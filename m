Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57629201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdBTUjw (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:39:52 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35465 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdBTUjv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:39:51 -0500
Received: by mail-wm0-f43.google.com with SMTP id v186so90864390wmd.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gal-ro.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QZByiD4QlonbZdpQ3ZHSE5ElQRIk9zQm7CzGUJqvjGs=;
        b=XOOAObjmvF7N2h8GbvB7kToZT/trl+zMCCyyILc0uqk4HyLO0V1s8xMWWC3e6t6ixe
         INEhE1PXzelC+/dYDohEIiZyp5nWW9Sys8fAocykFmt9DMZkml5WVItlQbYod4W2CKRS
         CAnvRVWyLPpbzhMcsLdEBqkLWuhwogiT9Lo2PLDRrAdBYdpi4+UF9HaLKLZRPo3bRbP3
         acZBcXMhbBLf/RLdleLhO0ZANdLLn7XF+SIhgB9jOQvvur8GucbEK9JAhi5BmOSJ2MiM
         YY4Gx1w383kVC9ozDwWxhd7d540E2X1gSVU/W6W5986PDnqwjKLXEdVW3r3wzXf8wuLy
         qE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QZByiD4QlonbZdpQ3ZHSE5ElQRIk9zQm7CzGUJqvjGs=;
        b=nX3rFNOa87E5V7k7+5bxGDZ97eAvh7jboYBHb+clfs8yYWtEjfqwCdQbv2+9zrJAnD
         mDcNFvnF9leDU1MqnCAMOr99kOxz7yFgq9/TpiRiQvnnv0Q4onqhE3vt8Eb9AlNMRFbj
         SQWTFT+n127CrWCkpOrYyi3BTNQ4VZXQcksNkaulr8KSC/h6UBT5vBxgYJKH2z7NVIwn
         rhZri0ZFEHjE8CySIHzA9xP1zronznfgYa5KrnZPRpyojS10G3qO988zmm8L0yeHsWYx
         ly8+rr5kJQWVyebiPsYx8J4Rtz+h9cD9G5q6dnYtbvPtklntYCglIdDDb3Ijsco+EeFI
         qrqQ==
X-Gm-Message-State: AMke39ltluZqTid8q/qnrDmgfvCpGD61L2zEiBqbOhRJmDTtEmHHqdw4w8uVmAufbHxTc32PAhZNKPcoD/XHcw==
X-Received: by 10.28.125.22 with SMTP id y22mr12212136wmc.112.1487623190168;
 Mon, 20 Feb 2017 12:39:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.226.6 with HTTP; Mon, 20 Feb 2017 12:39:49 -0800 (PST)
X-Originating-IP: [77.178.206.182]
In-Reply-To: <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com>
 <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org>
 <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com>
 <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
 <CAP8UFD3ngMvVy2XLzYNn9OFbS+zQpWTW=pravpHhA-0PcDVhfg@mail.gmail.com>
 <CAMX8fZVeAEJ5tfCO_4Pebnq=rysaJ2xDMjH-9pjmPeF4FziLFw@mail.gmail.com>
 <d7bb866d-4a50-f75e-ff4c-bcdd54f75459@kdbg.org> <CAMX8fZWRgeK5XjSrFYzZea8YgT9Mqm0XJBxQGt1eqdWZU+DEnA@mail.gmail.com>
 <CA+P7+xrch9WDo6OgU3vUEpXqAETZ07mkf76dC9nJctm0LTFQHQ@mail.gmail.com>
 <CABEd3j8sgDd8DXW8+2Q7pjANPTr-Ws1Xs1ap875mkxFOfnenYw@mail.gmail.com>
 <58d25138-de2e-6995-444f-79c3ac0bbad2@gmail.com> <CABEd3j8m5D=bBbUD+uzvE9c8AwdBEM79Np7Pnin-RLL=Hjq06A@mail.gmail.com>
 <CAMX8fZUNHmouUsgEY3+0CmTaEp+y5b1-Cp8Nk3OttTc30v0R5A@mail.gmail.com> <ca1ef8f6-58cf-4994-d1bf-39e04b42dd4c@gmail.com>
From:   Alex Hoffman <spec@gal.ro>
Date:   Mon, 20 Feb 2017 21:39:49 +0100
X-Google-Sender-Auth: UWPV8KYmuAT3bF6sG1rqF1GEYZo
Message-ID: <CAMX8fZUbZQiKF6aXa9BifU5vAwJ1wWR3CTUg70jUbjxahrGdAQ@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Oleg Taranenko <olegtaranenko@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Christian Couder <christian.couder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If `git bisect` is/would be affected by `git log` history-related options
> then this is what `--strict-ancestor` option gives/would give.

Exactly my thoughts. All that needs to be changed in the 2nd problem
is the graph where to search.

But first we must agree about the usefulness of the 2nd problem. Any
thoughts/comments/votes for/against?
