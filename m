Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADFC433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhK3Vzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhK3Vzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:55:45 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E9DC061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:52:25 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l7so43879915lja.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mf9+TmxXf5metaHp9HHxs6UOmAGs2kvkYKNeBr+D0wE=;
        b=HqmODgu9UrwkY0rI4fWEcvpS36pzqMVN8cSNs154lLrJYZbaRkEP6t6cuy6t3qoP3M
         jE5e3miWgNRDE3VXTxNEbKtYCj8DEROzsIh4bg2dLGMHRLZevcsBwZrGVkgKMGZEcYOX
         HXJcx1drWGR/exUs7Zjd2nQzkvu5P8uvs2NG1EB1RtfSCEPW7F407Sr9Jb249J+0oYp3
         4b+tiO52j+WZ9OSm8dlGcnbrY1zPOo7id8kQIeHFcU2BL05dhJpW6tJCHLOMGSvybBYB
         zyIMgPVZQotLE7i1O/XQ9ckpm1/8hIXJLosocGXPktDMpX+QI7nEQPEvg4g1+gqUiPpD
         hJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mf9+TmxXf5metaHp9HHxs6UOmAGs2kvkYKNeBr+D0wE=;
        b=SKimMWmOigSCfWER82iHiUQsiiK4yN0lCATUwH/nn61XGI+yKbRSXxx70FSKW8niVz
         WnG1vsO5Jigz5hSu9qtcWe6kRKMI0vUWo3eQN+vSr67Ic6uNehg6s3ReX7Bks+YCQNBE
         14NQ+MfWazl/vvqkEjXFcMkkSxq0rDc8xSymrErb1kYon/R6Neo2d1OSMnK4EhvLIEF0
         ZvPTDz0Sjt5/2Y0845ZjclAeLihdk4+vKP2KuNDQapsHLnVJ8w8wyhZS+1H/bM/IczqH
         P9VlLAj+CUN81ZxnqCZrj7M9mYVRIuNRIPXTmeYr98aG7m+Oa7+k763dbw34bCTCAo/p
         08Cg==
X-Gm-Message-State: AOAM532k0lvfyg8L+PObAgNXfNteIYzLNIuG4pwE6MHcGU6chprXSrfR
        r7tBFNqBqKdbYjNjhFF+0HLa6It+BoB3IMfyl2I=
X-Google-Smtp-Source: ABdhPJxQRlnbl+pUwsMKQrgzlFxywCZUMuXUYU7PzcW2cli1iJnrhZRxbPAwYWrl+M4jJsHE3vIvFAIqkq4gkbZUuWw=
X-Received: by 2002:a05:651c:2119:: with SMTP id a25mr1526315ljq.131.1638309143205;
 Tue, 30 Nov 2021 13:52:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <6b27afa60e05c6c0b7752f1bcf6629c446ede520.1637020263.git.gitgitgadget@gmail.com>
 <CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com>
In-Reply-To: <CABPp-BH6m4q_EoX77bqLcpCN1HRfJ_XayeCV2O0sRybX53rPrw@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 30 Nov 2021 13:52:12 -0800
Message-ID: <CANQDOdd7EHUqD_JBdO9ArpvOQYUnU9GSL6EVR7W7XXgNASZyhQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] tmp-objdir: new API for creating temporary
 writable databases
To:     Elijah Newren <newren@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 1:27 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Nov 15, 2021 at 3:51 PM Neeraj Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > The tmp_objdir API provides the ability to create temporary object
> > directories, but was designed with the goal of having subprocesses
> > access these object stores, followed by the main process migrating
> > objects from it to the main object store or just deleting it.  The
> > subprocesses would view it as their primary datastore and write to it.
> >
> > Here we add the tmp_objdir_replace_primary_odb function that replaces
> > the current process's writable "main" object directory with the
> > specified one. The previous main object directory is restored in either
> > tmp_objdir_migrate or tmp_objdir_destroy.
> >
> > For the --remerge-diff usecase, add a new `will_destroy` flag in `struct
> > object_database` to mark ephemeral object databases that do not require
> > fsync durability.
> >
> > Add 'git prune' support for removing temporary object databases, and
> > make sure that they have a name starting with tmp_ and containing an
> > operation-specific name.
> >
> > Based-on-patch-by: Elijah Newren <newren@gmail.com>
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  builtin/prune.c        | 23 +++++++++++++++---
> >  builtin/receive-pack.c |  2 +-
> >  environment.c          |  5 ++++
> >  object-file.c          | 44 +++++++++++++++++++++++++++++++--
> >  object-store.h         | 19 +++++++++++++++
> >  object.c               |  2 +-
> >  tmp-objdir.c           | 55 +++++++++++++++++++++++++++++++++++++++---
> >  tmp-objdir.h           | 29 +++++++++++++++++++---
> >  8 files changed, 165 insertions(+), 14 deletions(-)
> >
> > diff --git a/builtin/prune.c b/builtin/prune.c
> > index 485c9a3c56f..a76e6a5f0e8 100644
> > --- a/builtin/prune.c
> > +++ b/builtin/prune.c
> > @@ -18,6 +18,7 @@ static int show_only;
> >  static int verbose;
> >  static timestamp_t expire;
> >  static int show_progress = -1;
> > +static struct strbuf remove_dir_buf = STRBUF_INIT;
> >
> >  static int prune_tmp_file(const char *fullpath)
> >  {
> > @@ -26,10 +27,20 @@ static int prune_tmp_file(const char *fullpath)
> >                 return error("Could not stat '%s'", fullpath);
> >         if (st.st_mtime > expire)
> >                 return 0;
> > -       if (show_only || verbose)
> > -               printf("Removing stale temporary file %s\n", fullpath);
> > -       if (!show_only)
> > -               unlink_or_warn(fullpath);
> > +       if (S_ISDIR(st.st_mode)) {
> > +               if (show_only || verbose)
> > +                       printf("Removing stale temporary directory %s\n", fullpath);
> > +               if (!show_only) {
> > +                       strbuf_reset(&remove_dir_buf);
> > +                       strbuf_addstr(&remove_dir_buf, fullpath);
> > +                       remove_dir_recursively(&remove_dir_buf, 0);
>
> Why not just define remove_dir_buf here rather than as a global?  It'd
> not only make the code more readable by keeping everything localized,
> it would have prevented the forgotten strbuf_reset() bug from the
> earlier round of this patch.
>
> Sure, that'd be an extra memory allocation/free for each directory you
> hit, which should be negligible compared to the cost of
> remove_dir_recursively()...and I'm not sure this is performance
> critical anyway (I don't see why we'd expect more than O(1) cruft
> temporary directories).

I'll take this suggestion.

> > +               }
> > +       } else {
> > +               if (show_only || verbose)
> > +                       printf("Removing stale temporary file %s\n", fullpath);
> > +               if (!show_only)
> > +                       unlink_or_warn(fullpath);
> > +       }
> >         return 0;
> >  }
> >
> > @@ -97,6 +108,9 @@ static int prune_cruft(const char *basename, const char *path, void *data)
> >
> >  static int prune_subdir(unsigned int nr, const char *path, void *data)
> >  {
> > +       if (verbose)
>
> Shouldn't this be
>     if (show_only || verbose)
> ?

Doing that breaks one of the tests, since we print extra stuff that's
unexpected. I think I'm going to just revert this change, since it
appears that we call this callback and try to remove the directory
even if it's non-empty.

Do you have any comments or thoughts on how we want to allow the user
to configure fsync settings?

Thanks,
Neeraj
