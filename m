Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14451F453
	for <e@80x24.org>; Mon, 15 Oct 2018 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeJPBSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 21:18:55 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42421 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeJPBSz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 21:18:55 -0400
Received: by mail-ed1-f54.google.com with SMTP id b7-v6so18617350edd.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7B9IINkz/E7lAGlGBvg3p9IONVCOCprXYcJ100+EF0=;
        b=BcEI2fPQFc+3ioDapxlACW+hcL1zgs9/r/zlC7Uhwtxc+J/L+4IqCdf/r2CDH2nUlx
         yWDwgOJbhTWLviYmX8PRqf8rNWZy8hXzi52lYgT+Yhag2tzGM5UQImJdcsWHOO3Yg75Y
         YA5ta3FJ7oh9gy7wDySIeJZlqGjlhAkmh3Lmjt86g/5tH/tQ0vNLOqsbL5ixvTGaV3ie
         oYoaZbb5G3KkFpgtF/k+KI9Z8m1HdtKplKPhrwnG7uUXMnlCzLklYUmrPaaHQgbobQih
         2jG5P7nfuz4wuNLTKO92HegMamNMmJSoWyl13/WhrcrpGjrZIn1KVMBPmk1rLaP3/pzb
         +54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7B9IINkz/E7lAGlGBvg3p9IONVCOCprXYcJ100+EF0=;
        b=QpU5m3Fb8p+xAiYCmP+xC//eY2qpZm8E4ZpBS4mjHsxwKpSj155rM0IjJkLqI7huLg
         wa7rx5GiH2a0aLGuSrIegYcbMYqT/OT0ksb8HBXePYZsRG0qHBeJWBVi0kyPxcypyHWD
         JabrcEA/4Rn8BMUS01NVIpRu8NBSi64JJ4EyGrssmFg2lijd7TuCKEnFTdprxbsj/NxU
         CcQDxDm87fLKirCTzdHt9TlYurFJ0gS68sEFTavDSnd48aApP7VF3fbwnb6VTqi9b5LI
         PjIKYQ9zPUuqLEbU81X/gl/Xg0fjDfLRms4lWn6Jn8KdDvZoI+fYjy3YykXWhAcI2edF
         t99w==
X-Gm-Message-State: ABuFfoiH/Uxpm43GHH07ZtAy3A8BRmAfixCJ+Xrdkuj1Y3SRWAyg6j2u
        3yp4DEZhmgY83w91tOO4fUlU3LK7WKeHObb7Xabwfw==
X-Google-Smtp-Source: ACcGV60xcW2i1LS2ynyrLMsGMJhLAgJSaJzmhDV4wYEm7GyzYyC6ocK9wS8ipocl2Hq5JzZ1PZdowDEcZPfWEBglqk4=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr25379453eds.25.1539624761827;
 Mon, 15 Oct 2018 10:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh8hr9pxb.fsf@gitster-ct.c.googlers.com> <CAGZ79kZGEMWpr7aqeqXbC4bkmsCCiW+1pxbEV4T0vfsYG+_3iA@mail.gmail.com>
 <xmqqd0seac9y.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0seac9y.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 15 Oct 2018 10:32:30 -0700
Message-ID: <CAGZ79kYQfSHkk-cxxL5zz3sj6gYigPFw4zccA46poOYY-fBeSA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #02; Sat, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 6:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >> * sb/submodule-recursive-fetch-gets-the-tip (2018-10-11) 9 commits
> >>  . builtin/fetch: check for submodule updates for non branch fetches
> >>  . fetch: retry fetching submodules if needed objects were not fetched
> >>  . submodule: fetch in submodules git directory instead of in worktree
> >>  . repository: repo_submodule_init to take a submodule struct
> >>  . submodule.c: do not copy around submodule list
> >>  . submodule.c: move global changed_submodule_names into fetch submodu=
le struct
> >>  . submodule.c: sort changed_submodule_names before searching it
> >>  . submodule.c: fix indentation
> >>  . sha1-array: provide oid_array_filter
> >>
> >>  "git fetch --recurse-submodules" may not fetch the necessary commit
> >>  that is bound to the superproject, which is getting corrected.
> >>
> >>  Ejected for now, as it has fallouts in places like t/helper/.
> >
> > This is the first time I hear about that, I'll look into that.
> > The tipmost commit there is also shoddy, I'll redo that.
>
> This is the first time I saw the breakage with this series, but I
> would not be suprised, as this was rerolled recently.  Who knows
> what got changed in this series and in other topics---any new
> interaction can arise and that is a normal part of distributed
> development.

I performed the same merge last week, and the range-diff indicates,
that your version of next was further ahead than mine.

The breakage itself comes from

t/helper/test-submodule-nested-repo-config.c: In function
=E2=80=98cmd__submodule_nested_repo_config=E2=80=99:
t/helper/test-submodule-nested-repo-config.c:20:54: warning: passing
argument 3 of =E2=80=98repo_submodule_init=E2=80=99 from incompatible point=
er type
[-Wincompatible-pointer-types]
  if (repo_submodule_init(&submodule, the_repository, argv[1])) {
                                                      ^~~~
In file included from ./cache.h:17:0,
                 from ./submodule-config.h:4,
                 from t/helper/test-submodule-nested-repo-config.c:2:
./repository.h:126:5: note: expected =E2=80=98const struct submodule *=E2=
=80=99 but
argument is of type =E2=80=98const char *=E2=80=99
 int repo_submodule_init(struct repository *subrepo,
     ^~~~~~~~~~~~~~~~~~~

which is introduced by
commit c369da44610acc5e56213b8784d4250ae619fdb9
  (origin/ao/submodule-wo-gitmodules-checked-out)
Author: Antonio Ospite <ao2@ao2.it>
Date:   2018-10-05 15:06

    t/helper: add test-submodule-nested-repo-config

    Add a test tool to exercise config_from_gitmodules(), in particular for
    the case of nested submodules.

    Add also a test to document that reading the submoudles config of neste=
d
    submodules does not work yet when the .gitmodules file is not in the
    working tree but it still in the index.

    This is because the git API does not always make it possible access the
    object store  of an arbitrary repository (see get_oid() usage in
    config_from_gitmodules()).

    When this git limitation gets fixed the aforementioned use case will be
    supported too.

    Signed-off-by: Antonio Ospite <ao2@ao2.it>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

My resend will take that into account, building on Antonios series.

Thanks,
Stefan
