Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F4C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 15:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbiDVPHq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Apr 2022 11:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiDVPHp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 11:07:45 -0400
Received: from gateway22.websitewelcome.com (gateway22.websitewelcome.com [192.185.46.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F85D1B4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 08:04:51 -0700 (PDT)
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id B4234138CA
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 10:04:50 -0500 (CDT)
Received: from gator3142.hostgator.com ([50.87.144.177])
        by cmsmtp with SMTP
        id huq2n3hicXvvJhuq2ng8TM; Fri, 22 Apr 2022 10:04:50 -0500
X-Authority-Reason: nr=8
Received: from mail-pf1-f170.google.com ([209.85.210.170]:39488)
        by gator3142.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <csosza@designsoftware.com>)
        id 1nhuq2-000PiJ-5d
        for git@vger.kernel.org; Fri, 22 Apr 2022 10:04:50 -0500
Received: by mail-pf1-f170.google.com with SMTP id z30so348387pfw.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 08:04:50 -0700 (PDT)
X-Gm-Message-State: AOAM530wRT70LdYCGaq4KhaTNnVVoohqNClUGzrkAQiY3f9matSz7ECV
        4gyIxTSiRGOd+zg2uNrfIXi0VJa4+gfSpEVbfgI=
X-Google-Smtp-Source: ABdhPJy8ihd1r6BGvmsmplbdRNst/ywLC8qvaiwvnCVOayVnQrqMJqX8W+1p1Ff3hClijJYzpBqFR3NiD+ke5RniBY0=
X-Received: by 2002:a63:fb56:0:b0:3aa:cec:6b6f with SMTP id
 w22-20020a63fb56000000b003aa0cec6b6fmr4317546pgj.409.1650639884331; Fri, 22
 Apr 2022 08:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net> <220422.868rrx5uju.gmgdl@evledraar.gmail.com>
In-Reply-To: <220422.868rrx5uju.gmgdl@evledraar.gmail.com>
From:   Attila Csosz <csosza@designsoftware.com>
Date:   Fri, 22 Apr 2022 17:04:32 +0200
X-Gmail-Original-Message-ID: <CAMYm8FqU8zHUPFqWdM3Mpw3kj4yHEqHsNYFXz+b+p0vZZaVjYw@mail.gmail.com>
Message-ID: <CAMYm8FqU8zHUPFqWdM3Mpw3kj4yHEqHsNYFXz+b+p0vZZaVjYw@mail.gmail.com>
Subject: Re: Git bug report - disk errors on Windows after push
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3142.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - designsoftware.com
X-BWhitelist: no
X-Source-IP: 209.85.210.170
X-Source-L: No
X-Exim-ID: 1nhuq2-000PiJ-5d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-pf1-f170.google.com [209.85.210.170]:39488
X-Source-Auth: csosza+designsoftware.com
X-Email-Count: 4
X-Source-Cap: ZHNnNHQwcjtkc2c0dDByO2dhdG9yMzE0Mi5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm using git on Windows for 6-7 years sometimes facing this problem
(different computers, different HDDs). Last time the problem occured
on my internal laptop HDD. So I have decided to report the problem.

If unstable to use local bare repos on Windows you should mention in
somewhere or completly disable it. Disk errors are unacceptable even
the git repo is corrupted.

Please check this link also
https://github.community/t/what-could-be-the-reason-my-git-repositories-keep-getting-corrupted-broken/184711

Attila


On Fri, Apr 22, 2022 at 11:27 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Apr 18 2022, brian m. carlson wrote:
>
> > [[PGP Signed Part:Undecided]]
> > Hey,
> >
> > On 2022-04-18 at 07:47:07, Attila Csosz wrote:
> >> Thank you for filling out a Git bug report!
> >> Please answer the following questions to help us understand your issue.
> >>
> >> What did you do before the bug happened? (Steps to reproduce your issue)
> >> Pushing to a directory directly.
> >>
> >> What did you expect to happen? (Expected behavior)
> >> Good behavior
> >>
> >> What happened instead? (Actual behavior)
> >> Disk errors. After pushing to a directory (my origin field is C:\Work for
> >> example) the git repository will be corrupted.
> >> Moreover causing disk errors not only in the target git bare repository.
> >> I've loosed some other files.
> >> Cannot be reproduced exactly. However I have decided to report this problem.
> >> I've experienced this problem for several years.
> >
> > There's nothing that Git should be able to do as a normal operating
> > system that causes disk errors.  If you're seeing those kinds of errors,
> > the likelihood is that your disk is bad and you need to replace it.
> >
> > Do note that if you're storing your data in a directory managed by a
> > cloud syncing service (e.g., Dropbox or OneDrive), then it is known that
> > those file systems corrupt Git repositories and you shouldn't use them
> > with Git.  That's due to the way they sync data.
> >
> > However, if this is a regular file system (e.g., NTFS), then Git
> > shouldn't be able to cause disk problems, and if it could, that would be
> > a serious defect in Windows, so it's almost certainly going to be a
> > hardware problem.
>
> I think you're most likely right that this is some local HW issue, but
> the report doesn't have enough information to say either way.
>
> But generally as we've been discussing at length in various threads
> related to git's fsync() behavior we can and will corrupt repositories
> due only to our own (mis)use of FS APIs, i.e. not doing fsyncing and the
> like correctly, it's been improved a bit recently.
>
> But we're still in a state of not doing it correctly, and/or relying on
> some implicit assumptions.
>
> For something like an external disk that may have its power cable yanked
> I'd give it about even odds that it's HW v.s. git's own FS syncing logic
> being at fault.
>
> We get away with a lot of shenanigans because we're usually on a
> journaled FS, which e.g. on a FAT32 external volume we won't benefit
> from.
>
> Attila: I have no idea if this even exists on Windows, but aside from
> other suggestions in this thread I'd suggest enabling whatever Window's
> equivalent of "sync" mounting is (if it even exists). I.e. to have every
> single FS operation by synced to the metal.
>
> It will make your repository *much much slower*, but it will be safe as
> far as any logic errors in git vis-a-vis syncing go.
