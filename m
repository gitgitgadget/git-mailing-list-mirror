Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CB71F405
	for <e@80x24.org>; Thu,  9 Aug 2018 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeHIVRt (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:17:49 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35108 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbeHIVRs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:17:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id s68-v6so5924853ywg.2
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8k7aaeq+H588HOvTaGrfwTqHIRrlPQ8EPBiA9Z2S/Y=;
        b=bTPMxW+IewVewwXSMkwO9OKzWoDHrso4L46slAzDMV6L0XQ+C2RK44a3XdWkn2jYl3
         0wE3LY/6q1oEoP0fMIO2koxkI6Ob91fc2bb25TZpJbpPe/FTdIKvW4kRawtZ0IYMAT30
         3YwLlHY0QPUxud0qtf4Hd5Hw7v8OzpNeCQu/yB5uD8k6WG72gZCsCnAkZOtKN9V6ZJzj
         /lGS98qfFlvE8cAJ3aVKrpP0fTCH/9VOwdAazr3Xz0FStS1RuxFic8uleEA3AuEqdkDk
         d/MoBOMASyp0GSfkEYpc2Fc8xcrlvSf+cVEAJd/BN6cAtjPMwtS39N9ncqv7ZLWxWbGM
         M0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8k7aaeq+H588HOvTaGrfwTqHIRrlPQ8EPBiA9Z2S/Y=;
        b=HmaZOebkiJK3Jgrs/EuR4HqwrjFuEznrWKAquyJl2OEfVLyu7L2+LwXpcMsnPrcanc
         H4fSxNHWOt7rEPm+POaIlZKENU2MppoDI3flpgRHtjEEbVU3JxVov9T9Fod6ZHLSvAJv
         QoICAqDak39SL6HRaBcvq0XxecboPlVoqByBJkyA+NoYbzmal1yw96w8s+h4LL3u78eH
         nILK98/kR/KGsOYvFGPYCDwWSYhR1mMq2sU+AoiRtzJlLRDnOnj6LguNkTm0f5StGqLT
         3sFWtANLYTjKu/k7dtGn7hDNoC+pyjFybgKdaMSDdnlwPi+FElmLWJlZkHArKaEiS4xk
         dyBA==
X-Gm-Message-State: AOUpUlHIhZRfwVutNPCQYLr6TZHi1+UIkJok1S71xu538fVrfXVGmKS8
        BBr4Y5+3MHQ32qjhHrHhmOAlX4B0ZbPpf+sR6Lo=
X-Google-Smtp-Source: AA+uWPzYZ0W3UTuJQ0phanI3QgnRUVUUqBUolPlQ3515SepMxl59CAPtl4J9E6oTPoo6PZ0f4TF4+yvqgl0brdOJz5s=
X-Received: by 2002:a1f:f284:: with SMTP id q126-v6mr2159336vkh.38.1533840696412;
 Thu, 09 Aug 2018 11:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BHxJyWsAQ3FkfdC-5Vqe3d7wWZm-hVYd0-afNY9dEgMeQ@mail.gmail.com>
 <20180806224745.8681-1-newren@gmail.com> <xmqq600jctr1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq600jctr1.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Aug 2018 11:51:24 -0700
Message-ID: <CABPp-BE23fzBPuR94Ukrn4Va_Aw2wsZ0DjjxRxbSYJLmCrvP6w@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 0/3] Modifications to handling of non-textual file
 merge conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 9, 2018 at 10:52 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> > 1) Representative example: A modify/delete conflict; the path in question
> > in the working tree would have conflict information at the top of the file
> > followed by the normal file contents; thus it could be of the form:
> >
> >     <<<<<<<< HEAD
> >     Conflict hint: This block of text was not part of the original
> >     branch; it serves instead to hint about non-textual conflicts:
> >       MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
> >     ========
> >     Conflict hint: This block of text was not part of the original
> >     branch; it serves instead to hint about non-textual conflicts:
> >       MODIFY/DELETE: path foo modified in HEAD and deleted in BRANCH
> >     >>>>>>>> BRANCH
> >     Lorem ipsum dolor sit amet, consectetuer sadipscing elitr,
> >     sed diam nonumy eirmod tempor invidunt ut labore et dolore
> >     magna aliquyam erat, sed diam voluptua. At vero eos et
> >     accusam et justo duo dolores et ea rebum. Stet clita kasd
> >     gubergren, no sea takimata sanctus est Lorem ipsum dolor
> >     sit amet.
> >
> > Alternative ideas for handling the explanatory text here are welcome.
>
> In a modify/delete conflict, we currently do not leave any in-file
> clue, so smudging the modified side like this might be a change that
> helps those who "grep e '<<<<<<<'" to find the set of paths that
> need to be examined.

Yes, that's one of the things I'm hoping for with this change.

>  I personally do not feel it would be all that
> useful, as "ls-files -u" is how I'd learn about these paths.

"ls-files -u" is really nice; I love it and try to show it to others,
but keep getting surprised by how many people are surprised to learn
of its existence.

Further, "ls-files -u" may be insufficient even for those who know
about it, for two reasons (and admittedly, I care a lot more about the
second than the first):

* There are more conflict types than the number of permutations of
stages.  For example, how do you know if a file was from a
rename/delete or a modify/delete conflict?  And if from a
rename/delete, how do you determine the original filename?  The index
doesn't store this information.  Granted those two conflict types are
at least similar, but other stage combinations might be more
confusing.  For example, if all three stages are present, is the
conflict in question an edit/edit, a rename/add/delete, or a D/F
conflict where the file came from a rename?

* Future feature: Thomas Rast' proposed remerge-diff[1] (which I want
to resurrect and remove the edge/corner cases from).  This worked by
creating what I call an auto-merged tree, where you just accept all
conflicts and commit.  Then you diff the merge commit to what the
auto-merge tree was to see how the user edited conflicts to create the
merge commit.  Problem is, for the auto-merge tree we won't have an
index anymore so how do we represent conflicts that aren't edit/edit
of normal text files?  My proposal here is an answer for that; I'm
open to others, but it's the best I came up with.

[1] https://public-inbox.org/git/cover.1409860234.git.tr@thomasrast.ch/

(I'll also note here that others have requested the ability to create
an as-merged-as-possibly tree including conflicts for other purposes;
see "API suggestion" of
https://public-inbox.org/git/CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com/
and my response noting the various difficulties with non-textual
conflicts.  So it may not be just the remerge-diff ability here.)

> What I would want to see when faced to a modify/delete conflict is
> how the modification side changed the contents, as the change, or
> its moral equivalent, would need to be ported to other locations in
> the context of the deleting side.  But I am not sure if it makes
> sense to attempt to somehow include "diff HEAD...MERGE_HEAD" (or the
> other way around) in the file to show the contents change on the
> modification side.

That's a good point; I'm not sure how to include that either.
Something to think about.

> > 2) Representative example: A binary edit/edit conflict.  In this case,
> > it would be inappropriate to put the conflict markers inside the
> > binary file.  Instead, we create another file (e.g. path~CONFLICTS)
> > and put conflict markers in it:
> >
> >     <<<<<<<< HEAD
> >     Conflict hint: This block of text was not part of the original
> >     branch; it serves instead to hint about non-textual conflicts:
> >       BINARY conflict: path foo modified in both branches
> >     ========
> >     Conflict hint: This block of text was not part of the original
> >     branch; it serves instead to hint about non-textual conflicts:
> >       BINARY conflict: path foo modified in both branches
> >     >>>>>>>> BRANCH
> >
> > This file would also be added to the index at stage 1 (so that 'git merge
> > --abort' would clean this file out instead of leaving it around untracked,
> > and also because 'git status' would report "deleted in both" which seems
> > reasonable).
> >
> > This type of example could apply for each of the following types of
> > conflicts:
> >   * binary edit/edit
> >   * any of the conflicts from type 1 when binary files are involved
> >   * symlink edit/edit (or add/add)
> >   * symlink/submodule
> >   * symlink/directory
> >   * directory/submodule
> >   * submodule/submodule
> >
> > It could also apply to the following new corner case conflict types from
> > directory rename detection:
> >   * N-way colliding paths (N>=2) due to directory renames
> >   * directory rename split; half renamed to one directory and half to another
>
> Hmph, I am starting to wonder if it may be easier to access if
> instead you did not touch any working tree file to do any of the
> above, and instead write a single file in $GIT_DIR/ to explain what
> kind of conflicts these paths are involved in.  That would probably
> give a better and easier-to-read summary than "ls-files -u" output.

That's interesting, and would be an alternate way to help some users.
I think it's less discoverable than sticking the info in files in the
working tree for the user to see (particularly for the users who are
allergic to git commands and just stay in their IDE as much as
possible), but there might be something interesting here.

However, I don't see how this would cover the remerge-diff usecase (or
more general create-as-merged-as-possible-tree-with-conflicts-in-it
usecases) at all, which was my biggest motivation for these changes.
Is there a good solution there?

> Or do we have _enough_ information in the "ls-files -u" already to
> infer "Ah, we are in symlink edit/edit conflict.", etc.?  If so,
> perhaps "git status" can be extended to show what kind of conflict
> these paths are in by reading the higher-stage index entries (and
> lack of stages thereof, when dealing with a conflict with deletion
> involved)?

We have enough information in _some_ cases to determine which type of
conflict it is from the index (e.g. because we don't detect renames
for symlinks or submodules and thus have fewer conflict types possible
involving those).  However, we again run into problems (at least for
binaries) about there being more conflict types than permutations of
stage entries, and for all conflicts, we run into the same problem of
not having an index at all for the remerge-diff capability.
