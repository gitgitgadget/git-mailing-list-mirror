Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988061F461
	for <e@80x24.org>; Fri, 19 Jul 2019 04:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfGSEt7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 00:49:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38758 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfGSEt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 00:49:59 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so23499705ioa.5
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 21:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmmIANP9COr2bcjCTpaiGSK53+J1/bdLf71QQdl5ZfQ=;
        b=Sj1BFr2mabR6/gFHm+tatuKMq6Lc8Dtl7P7Yg3mdYYv8bZ3YhQku07dOXKyFy7vanJ
         /tu1Lmtn566q8LCa2i27lrxc5c8p3/G3cp3ToJjptgWTU521hU9S8kBR516gfh1wK4Nd
         TGGZQsCbmBl+dLvNLCGxz1gSvWvFNQmei2G2G2nHiwdsUMrymP4Dn5C8NxxkFBKE2MKA
         N60mG6nh0rJeB2gyvwD0x5+R/RZeZyxibaYKnOxorU8tq0jHqHS6DZISo3AOBNCAAEpt
         SzaiAAZiFlpqQpXVCHATi+/nFffjyisEZgfQmffLurbgmujMFBuoH7yMCUNSSyg5RBKa
         qY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmmIANP9COr2bcjCTpaiGSK53+J1/bdLf71QQdl5ZfQ=;
        b=svIZX5brsv/KyMPMpogGTTiRLc1D2R3+qnulbK6cIuA4840IdQPo0W0CzKLVtDNI9b
         8AOBvrJZ/Fpk+7cLsTn+y3r1TrpPj8PcBx50GHaC1zSgZvLADvSAMP2fFk4a1h0tVeSb
         SQkEXA5RfSaUETr4C9EcoeJecihUdSMbPrvQG7Pvbvz0lb9BjYAuvjgqEqPl/YYdKCrs
         lHQyO+u+dsadGcEdTM6XudrSa9z+Y27RP/qvH/H89vy1CFUQX1FNEtohbQoI4051J4Y+
         jDcnq9h1fHk/cokfFtLV1Ub8FXdMBk8e7diCy+EWCrtj2dtaFPomMakwIDz8eEDavAuO
         Bz8w==
X-Gm-Message-State: APjAAAXRBFvE8z3+GizEGls1jyCGH2wdy+6jycbY2//hRzzbI7HY10T5
        fBbNGy3JM8GOIAefRdBoJLafxddsIJ86lxD9eUE=
X-Google-Smtp-Source: APXvYqwAvhoygMSMcIKnqHtEXjXt/3k7DM9Wc1tI1hwD67mSG4lAXAwasx+X3lJ/pCZMgVnubLeyCpvHd4SsVQzSXYk=
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr6588939iok.252.1563511798695;
 Thu, 18 Jul 2019 21:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com> <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com> <20190718152234.GI20404@szeder.dev>
 <20190719013128.GB251102@google.com>
In-Reply-To: <20190719013128.GB251102@google.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 18 Jul 2019 21:49:47 -0700
Message-ID: <CAPUEsphnCvK+RZ+h30ZarA1zo9yZ=ndEBrcAbKGf4W92j647vA@mail.gmail.com>
Subject: Re: [PATCH v2] transport-helper: enforce atomic in push_refs_with_push
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 6:31 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> This makes sense to me.  Not really for the 'for' loop declaration
> aspect: for that, I'd want some more specialized tool that allows
> turning on such a check specifically.  But more because Ubuntu trusty
> is still a platform that some people use (though hopefully not for
> long), so it's helpful as a representative old platform to see if we
> break the build on it.

FWIW this also breaks Centos 7 using gcc 4.8.5, as well as the one
originally reported (Centos 6), and anything else that uses gcc 4
(tested up to 4.9.4)

Carlo
