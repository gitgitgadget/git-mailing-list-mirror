Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A582022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdBWRDP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:03:15 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35868 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdBWRDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:03:09 -0500
Received: by mail-qt0-f182.google.com with SMTP id r45so14602146qte.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=xprzd+2D7RSCVK59RvAwBUGBLIeS91YsLahEJWK83Wo=;
        b=lq6uRsV/NslXwEwtoq4JkeIn2krw/k85Ow5BzOwWyBeJxO52yb43xXH9Ar68vbKy0x
         LDvHJ6TcYIjl+Xj0a1OmOEgn9C2rtxJJewikLdmbEXxKRXFMTSoARJixluF2yGT+65J2
         QVX9c3Kc2AgMce4DTqwW6NekkWFTtXitvLiR7zW8gawrudiffgesvmOKXfXX8pmtHZe1
         rwBNAmYAgu23H/QuOo3fHcVMJ2g0d6G0Hax0joHJGwZmWjHeyIGSWbCAFkYwFJ1v4dOW
         DX8ysWfoYoPg1C1fLw9Kuy1dgRUu1QVnQIIR/ks4cusuz38OvwdPmFti2KPn4B+IytJm
         7/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=xprzd+2D7RSCVK59RvAwBUGBLIeS91YsLahEJWK83Wo=;
        b=UVafeVjdNVJwmjN8ER57KI4fpNeFuDzZkxbsZgKkmlWw2FuW4Xr+Mu292BTmeWfExr
         QcUdaBYdB0Etx7p3I9HpkLmH1BdijZWk5Q+AgjP23A0zPVeXayVCTQC0XJCiviYQObcz
         2JEmRfFr/qd5RTW9EVsZjhXYhsujNJLxLtj05MPuoZGuck/7ivebhtnLz6Lo1qPxxuX6
         h025DBSHcXsV91Y2DOdEUHWlzpTuRuW4Lz6/iWBK+JMF7Ll9xZqCKuoyRFRhXqhRDxy2
         FEqUlvIOBA8PZm3j7Mclu+lxRmfRJRqLpUIjKpmn+ZleDcr5P4QCqpHksnSCuZ2Fwuvl
         L16w==
X-Gm-Message-State: AMke39mgpfu+ISP0OZtWGDVM3+ol9H02moB/fPtUDEatnFlPtLx2sh/dtiLB7/pLuvpH25zPmqyRiEg+jE5rxA==
X-Received: by 10.237.59.19 with SMTP id p19mr37382579qte.90.1487869379268;
 Thu, 23 Feb 2017 09:02:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Thu, 23 Feb 2017 09:02:38 -0800 (PST)
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Thu, 23 Feb 2017 09:02:38 -0800
X-Google-Sender-Auth: bhuicBXs1IKZ0s3JxRCLImI26DI
Message-ID: <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 8:43 AM, Joey Hess <id@joeyh.name> wrote:
>
> Since we now have collisions in valid PDF files, collisions in valid git
> commit and tree objects are probably able to be constructed.

That may be true, but
https://public-inbox.org/git/Pine.LNX.4.58.0504291221250.18901@ppc970.osdl.org/
