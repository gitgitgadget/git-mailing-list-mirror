Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80537C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 04:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjANEGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 23:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjANEGS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 23:06:18 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02DAD
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 20:06:17 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e13so24422005ljn.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rVKlqmuJqJ3wZz4JmJ5DOLAIQoFeOncydCYVAhhNxGs=;
        b=VdGDp+mKgWxKyUmTNrO36FDynNPCrbdmnxEEZa7kw6juE5poKT+h3hygJrG3aeeaLl
         78QfogQWBWfOwtpH9YIZkpRnz2o8nj4um2FHMAlsJm9wPKd3/ag4+/Zs9o62ZRF/E/Tx
         XmwlkDbqsl1CZ7loaC5QSMfnvc78wsu02F2Y+2PVM8xCghVAuSBPfd3PMiCI/QYtuC4Y
         komAQ6rMbcSdU8NgVMqfU0dBsGQv+TI6NQBr7T5477RuLdIIKpmKioimsncZFVeYlFPo
         vcNF+4ztm65HUlFObXOWWBoakBG9zjWt4dpzQOd/NQZQBJluTI6NkHhcuIbXz0HDD0Xb
         ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVKlqmuJqJ3wZz4JmJ5DOLAIQoFeOncydCYVAhhNxGs=;
        b=vK6i2nH/+D3y7WPoshP4ZkbChA7+diQS1GajWWtr+h4BLhviS6ednLYuZC4O6mzDAG
         jrEVkIRgzFLfvK69tIaknA+6hXRd9IMlxTlG8VWRu2Yqr8DdWbcuF1OZ2nILibWkGzVH
         BbBQcoU8UIi4J5p04/zGMIGmN4XvJYXIfV0/1b40RUvuqaaXhnzzzcHTFKqEcuLM/kqs
         968Vi8H3J2TtYUACeLxemMPTg3Cfs3jD5OlX7ywr5kW8rvgwWNPz348/Yqg8kW/fn7fb
         c04LWUgHnHNx9rA5Z2TajfWjE84VFIgibo+ZQ35uYXAw5rVyYeVQOWGpFzaewQj5O25q
         saNA==
X-Gm-Message-State: AFqh2krz/cDczIJvnZHoGgp6n7svrspet40ma3xA4SkQvBcD/LZzUsBl
        YTCPq642XSJm+XEkPWVcXb0Pu2MMiMmot1ux980=
X-Google-Smtp-Source: AMrXdXuQaxKcMnVKts59Mmat38l1qtUt8gnj2iVuz/m0j3QjrUQuSFplP8BBLvTlHSccTM/bX0PTZ+kjy1h1C+5CUxs=
X-Received: by 2002:a2e:9b41:0:b0:27f:e221:293c with SMTP id
 o1-20020a2e9b41000000b0027fe221293cmr4387553ljj.163.1673669175326; Fri, 13
 Jan 2023 20:06:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.1462.git.1673584084761.gitgitgadget@gmail.com> <f03094ce-e9e5-9530-7ed7-893a3f291ab0@gmail.com>
In-Reply-To: <f03094ce-e9e5-9530-7ed7-893a3f291ab0@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 13 Jan 2023 20:06:00 -0800
Message-ID: <CABPp-BE8O0beOS3=Y5Sh23KMRJGsOqmdHWD=ide4_=Zn5bWSPg@mail.gmail.com>
Subject: Re: [PATCH] t6426: fix TODO about making test more comprehensive
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2023 at 2:09 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> On 13/01/2023 05:28, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > t6426.7 (a rename/add testcase) long had a TODO/FIXME comment about
> > how the test could be improved (with some commented out sample code
> > that had a few small errors), but those improvements were blocked on
> > other changes still in progress.  The necessary changes were put in
> > place years ago but the comment was forgotten.  Remove and fix the
> > commented out code section and finally remove the big TODO/FIXME
> > comment.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
>
> Thank you for taking care of this FIXME.
>
> >      t6426: fix TODO about making test more comprehensive
> >
> >      See
> >      https://lore.kernel.org/git/CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com/
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1462%2Fnewren%2Ft6426-fix-todo-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1462/newren/t6426-fix-todo-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1462
> >
> >   t/t6426-merge-skip-unneeded-updates.sh | 56 ++++++++++----------------
> >   1 file changed, 22 insertions(+), 34 deletions(-)
> >
> > diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
> > index 2bb8e7f09bb..1fcf5d034ed 100755
> > --- a/t/t6426-merge-skip-unneeded-updates.sh
> > +++ b/t/t6426-merge-skip-unneeded-updates.sh
> > @@ -380,40 +380,28 @@ test_expect_success '2c: Modify b & add c VS rename b->c' '
> >
> >               # Make sure c WAS updated
> >               test-tool chmtime --get c >new-mtime &&
> > -             test $(cat old-mtime) -lt $(cat new-mtime)
> > -
> > -             # FIXME: rename/add conflicts are horribly broken right now;
> > -             # when I get back to my patch series fixing it and
> > -             # rename/rename(2to1) conflicts to bring them in line with
> > -             # how add/add conflicts behave, then checks like the below
> > -             # could be added.  But that patch series is waiting until
> > -             # the rename-directory-detection series lands, which this
> > -             # is part of.  And in the mean time, I do not want to further
> > -             # enforce broken behavior.  So for now, the main test is the
> > -             # one above that err is an empty file.
> > -
> > -             #git ls-files -s >index_files &&
> > -             #test_line_count = 2 index_files &&
> > -
> > -             #git rev-parse >actual :2:c :3:c &&
> > -             #git rev-parse >expect A:b  A:c  &&
> > -             #test_cmp expect actual &&
> > -
> > -             #git cat-file -p A:b >>merged &&
> > -             #git cat-file -p A:c >>merge-me &&
> > -             #>empty &&
> > -             #test_must_fail git merge-file \
> > -             #       -L "Temporary merge branch 1" \
> > -             #       -L "" \
> > -             #       -L "Temporary merge branch 2" \
> > -             #       merged empty merge-me &&
> > -             #sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
> > -
> > -             #git hash-object c               >actual &&
> > -             #git hash-object merged-internal >expect &&
> > -             #test_cmp expect actual &&
> > -
> > -             #test_path_is_missing b
> > +             test $(cat old-mtime) -lt $(cat new-mtime) &&
> > +
> > +             git ls-files -s >index_files &&
> > +             test_line_count = 2 index_files &&
> > +
> > +             git rev-parse >actual :2:c :3:c &&
> > +             git rev-parse >expect A:c  A:b  &&
> > +             test_cmp expect actual &&
> > +
> > +             git cat-file -p A:b >>merge-me &&
> > +             git cat-file -p A:c >>merged &&
> > +             >empty &&
> > +             test_must_fail git merge-file \
> > +                     -L "HEAD" \
> > +                     -L "" \
> > +                     -L "B^0" \
> > +                     merged empty merge-me &&
> > +             sed -e "s/^\([<=>]\)/\1\1\1/" merged >merged-internal &&
>
> It seems that this line can be dropped, because merged-internal is not
> inspected afterwards. None of the other tests in the file do similar
> calls to `sed`.  Such substitutions with sed are present in
> t6422-merge-rename-corner-cases.sh and t6406-merge-attr.sh though.

Ah, good catch.  There's no nested conflict, so this is totally unnecessary.

> > +
> > +             test_cmp merged c &&
> > +
> > +             test_path_is_missing b
>
> Function test_setup_2c() creates commits in order: commit O (create b),
> commit A (modify b, create c), and then commit B (rename b->c).
> I would have preferred if "test_path_is_missing b" check was done
> several lines higher, just before "test_line_count = 2 index_files".
> It feels more natural with this order of commits in setup to check what
> happened to file "b" first.  It would also mean that all checking of
> directory contents is done in one place, before merge conflict in file
> "c" is inspected.

I'm fine with switching it.  I need to remove the other superfluous line anyway.

> I see, however, that all tests in this file follow the pattern of
> checking missing files at the very end, and consistency might be
> preferable here.

After dealing with a number of really complicated conflicts (e.g. see
the mod6, rad, or rrdd testcases in t6422) where trying to go
file-by-file can just fail due to conflicts and files not being
one-to-one, I kind of got used to thinking in terms of "what's
committed", "what's in the index", "what's in the working tree".  But
there's no particular reason we have to stick to that structure in
this much simpler testcase.  I'm happy to move it.

> >       )
> >   '
> >
> >
> > base-commit: 2b4f5a4e4bb102ac8d967cea653ed753b608193c
>
> Aside from unnecessary call to sed and nitpicking about order of
> assertions, the patch looks good to me.

Thanks for taking a look!
