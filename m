Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580831F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfKLVI0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 16:08:26 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35922 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfKLVIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 16:08:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id f7so16206235edq.3
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 13:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l5egq6W6H05DCUQ/jh1gz2hE3RhftsM94HTzeZnluIc=;
        b=LRrIvMVPIZpQPiqO2D6kQNUSLXy3yqQBT/hcnc2GDrYETyCxQAu8r83tN0loVgBYFa
         vpKg6S+LY0gypu7hh8p6puJ7kLufBenlUu9nHJYikQIvnaFg/b78hLkzoHdcbEG5faJm
         JB0lnDsjtEpIgZJBA+INY38CNKySV1YPpPMLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l5egq6W6H05DCUQ/jh1gz2hE3RhftsM94HTzeZnluIc=;
        b=pmkGavwc09BLSoVU17tAcTf2gNPBBs2aW1T+KfB2oQrdK250Jlv3IBVsn7133A60X9
         yOlTlj7lDt2oQTM/DlS6J1LUKmqoNM9VkaNvdQVPGVPIDBbVUG5gvx0m+tfNfs5dYPaa
         rjM9/T4waapAm9DaVAM3DTxI+GqpkyrQ/+gEG2xhV0hWuWZnMPaNTDtk6BTkl+mzlDYb
         BQxWl5u+uPI4BAGX6WQgq43G61b5uFPB9EY1jWlr+Uso9UllAikKXYQe4YoQP9KBwoqq
         TPSxyAYJzq2NqIhT3HELxnNBMvAgC/urELmm2KYoEsaHPh/kZUJTn6p30/GDw0Nw+qtQ
         CyJQ==
X-Gm-Message-State: APjAAAU36wKwvLlDyCwDczpb/T/ldfP3Fv2MAmHnyHfy95dkwsDglGTM
        kJZwEimPsrcFENESOo1aPC1SBp4PmQnRViowHDjpig==
X-Google-Smtp-Source: APXvYqxbR58P26p4VhjBrGCDIYFanIl+lCK3tjRlOxiEM7MsEIqx9Fp3qdbbquVWBca23Mz2xh+tdpTLtGWwt6jtYrQ=
X-Received: by 2002:a17:906:3393:: with SMTP id v19mr5305370eja.117.1573592903251;
 Tue, 12 Nov 2019 13:08:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
 <8d69ba362261690e58b3879c33ac01c8888dc473.1573196960.git.gitgitgadget@gmail.com>
 <20191112111809.GN4348@szeder.dev>
In-Reply-To: <20191112111809.GN4348@szeder.dev>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Tue, 12 Nov 2019 13:08:12 -0800
Message-ID: <CAPYzU3PKrL=tz13_VV2uCkX04UyaC4GvD9GPvtnHUeu7UKU4cg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fsmonitor: skip sanity check if the index is split
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 3:18 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Fri, Nov 08, 2019 at 07:09:20AM +0000, Utsav Shah via GitGitGadget wro=
te:
> > The checks added in 3444ec2eb2 ("fsmonitor: don't fill bitmap with
> > entries to be removed", 2019-10-11), to ensure that the
> > fsmonitor_dirty bitmap does not have more bits than the index
> > do not play well with the split index.
> >
> > git update-index --fsmonitor --split-index calls write_locked_index
> > which calls write_shared_index as well as write_split_index.
> > The first call fills up the fsmonitor_dirty bitmap,
> > and the second modifies the index such that istate->cache_nr is zero an=
d
> > this assert is hit.
>
> Just to make sure that we are on the same page, is this the one?
>
>   BUG: fsmonitor.c:88: fsmonitor_dirty has more entries than the index (1=
02 > 1)
>

Yes, that's the one.

> > The test written does reproduce the error, but only flakily. There is
> > limited difference with GIT_TEST_FSMONITOR=3Dfsmonitor-all or
> > GIT_TEST_FSMONITOR=3Dfsmonitor-watchman, so the flakiness might come fr=
om
> > somewhere else, which I haven't tracked down.
> >
> > The test also requires checkout of a new branch, and checking out back
> > to master.
>
> It doesn't; see below.
>
> > It's clear that the index gets into some poor state through
> > these operations, and there is a deeper bug somewhere.
> >
> > At the very least, this patch mitigates an over-eager check for split
> > index users while maintaining good invariants for the standard case.
> > Also, I haven't been able to reproduce this with "standard" user
> > commands, like status/checkout/stash, so the blast radius seems limited=
.
> >
> > Helped-by: Kevin Willford <kewillf@microsoft.com>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Utsav Shah <utsav@dropbox.com>
> > ---
>
> > diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> > index d8df990972..b5029eff3e 100755
> > --- a/t/t7519-status-fsmonitor.sh
> > +++ b/t/t7519-status-fsmonitor.sh
> > @@ -371,4 +371,27 @@ test_expect_success 'status succeeds after staging=
/unstaging ' '
> >       )
> >  '
> >
> > +# Git will only split indices if we have a bunch of files created,
> > +# so that prep work of creating a few hundred files is required.
>
> 'git update-index --split-index' splits the index no matter what; it
> even splits an empty index.
>
> > +# Note that this test doesn't fail determinstically without
> > +# its corresponding bugfix.
> > +test_expect_success 'update-index succeeds after staging with split in=
dex' '
> > +     test_create_repo fsmonitor-stage-split &&
> > +     (
> > +             cd fsmonitor-stage-split &&
> > +             test_commit initial &&
> > +             files=3D$(test_seq 1 100) &&
> > +             echo "hello world" > file &&
> > +             touch $files &&
> > +             git add -A &&
> > +             git commit -m "next" &&
> > +             git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonito=
r-watchman" &&
> > +             echo "hello world" > file &&
> > +             git checkout -b new-branch &&
> > +             git checkout master &&
> > +             echo hello >> file &&
> > +             git update-index --split-index --untracked-cache --fsmoni=
tor
> > +     )
> > +'
>
> I could reproduce the failure with '-r 30 --stress' relatively easily
> [1], but with those options I could shave off a lot from this test:
>
>         test_create_repo fsmonitor-stage-split &&
>         (
>                 cd fsmonitor-stage-split &&
>                 >tracked &&
>                 git add tracked &&
>                 git config core.fsmonitor
>                 "$TEST_DIRECTORY/t7519/fsmonitor-watchman" &&
>                 >untracked &&
>                 git update-index --split-index --untracked-cache --fsmoni=
tor
>         )
>
> and could still trigger the failure:
>
>   + git update-index --split-index --untracked-cache --fsmonitor
>   open2: exec of watchman -j failed at /home/szeder/src/git/t/t7519/fsmon=
itor-watchman line 47.
>   BUG: fsmonitor.c:88: fsmonitor_dirty has more entries than the index (1=
 > 0)
>
>
> [1] There is a quite expensive lazy prereq evaluation outside of
>     'test_expect_*' that I disabled it with the following for
>     speedier stress testing:
>
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index 997d5fb349..103520415d 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -50,8 +50,7 @@ write_integration_script () {
>  }
>
>  test_lazy_prereq UNTRACKED_CACHE '
> -       { git update-index --test-untracked-cache; ret=3D$?; } &&
> -       test $ret -ne 1
> +       true
>  '
>
>  test_expect_success 'setup' '
