Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED93202F3
	for <e@80x24.org>; Wed, 20 Jul 2016 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbcGTOor (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 10:44:47 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35991 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbcGTOoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 10:44:38 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so116862130ith.1
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 07:44:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CUBLtQi8DZiSlKjRETuwwJ4C0+EFpbhKudjE4pLEOMw=;
        b=khcgZOFT+IBbXVbdJEMYod1XIrhgJYiWNNX141StTNceMCFoqI0PUHoRCMvtMbkhFC
         1ByJhQdgCvv6k0wJd+CPqPvvQPkAqHV0EPBlgcNR6wHX9qLS2nI2+u0a6Ui4CX/szVx1
         74LKnHbBvbpMmO3JoDqx9iUSttvXQjESrCB59DffPQMEUbRh1I7zY0qJwNgRdEtfiC0P
         YYQUpsEHSDOWJ1gaQMpSziaZiwyZ+oblGOuc6z1KXZ3flklC3gfnXEOLYmV34ss0kPRY
         UdsuuQlaVHLvLmFoca0t0f1mHCFnSLpjoJxgaawq1f0eeJWm23kytjbQlL+xprKTFZzJ
         37OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CUBLtQi8DZiSlKjRETuwwJ4C0+EFpbhKudjE4pLEOMw=;
        b=IeLsLyaY3/+EboUNx6/SA9rKGpMXEmRkMSfsFOKYAnLJD4EAnRyai6slNNrD1cFNbh
         shnq+/tCmHmFl8eA29BUgAtp3agJYUJIEmDu9RLEhWZuMOc5QdiDdEVThinJUDPObd4N
         DXlPH1Y+pXKbgYyQL2M4eFwYZ5CJ/QsWDjpRhKm9KX4WuX66Ang+3jtRXz9NBej3oPs2
         YLcKjgmtbe7ZFUwaAQxttZToT/B1MEBJMZUxmA8nPItT+dBeqchPybQeRWRbVj9lOgNk
         mrvPtGKpMTY3K0ucrwKPSAkdQpd4EOCpiOr/HLKgTwW1PKXTJkwa5bo22DcDA+rfcFUF
         OEug==
X-Gm-Message-State: ALyK8tLL2FUPelhOYmUPy0AEEC50rNxX9/wvezV5K8OJhS8/ECPlgFXYB6XWM+7stJ+HQ1rOPMbYr6OceKd0rg==
X-Received: by 10.36.91.134 with SMTP id g128mr10281453itb.42.1469025877303;
 Wed, 20 Jul 2016 07:44:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 20 Jul 2016 07:44:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607201428030.14111@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
 <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
 <alpine.DEB.2.20.1607201428030.14111@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 20 Jul 2016 16:44:07 +0200
Message-ID: <CACsJy8A3ZTfRRNuYXYD-nzXm6KXHu8cHU6fzfysJxfW0EggKNA@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Lang <david@lang.hm>, Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 2:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> But that strategy *still* ignores the distributed nature of Git. Just
> because *you* make that merge at a certain point does not necessarily mean
> that I make it at that point, too.
>
> Any approach that tries to have one single point of conversion will most
> likely fall short of a solution.

OK I see the difference in our views now. To me an sha256 repo would
see an sha1 repo as a _foreign_ DVCS, pretty much like git sees
mercurial now. So a transition from sha1 to sha256 is not that
different from cvs -> svn -> a dvcs bubble -> git.

> To be honest, I am less concerned about the GPG-signed commits (after all,
> after switching to a more secure hash algorithm, a maintainer could
> cross-sign all signed commits, or only the branch tips or tags, as new
> tags, to reinstitute trust).
>
> I am much more concerned about references to commits, both inside and
> outside the repository. That is, if I read anywhere on the internet about
> Git having added support for `git add --chmod=+x <file>` in 4e55ed3 (add:
> add --chmod=+x / --chmod=-x options, 2016-05-31), I want to find that
> commit by that reference.
>
> And I am of course concerned what should happen if a user wants to fetch
> from, or push to, a SHA-1-hashed remote repository into, or from, a
> SHA-256-hashed local one.

to follow the above, in my view, interaction with sha1 repos go
through some conversion bridges like what we have with hg and svn. I
don't know if we are going this route. It's certainly simpler and
people already have experiences (from previous migration) to prepare
for it.
-- 
Duy
