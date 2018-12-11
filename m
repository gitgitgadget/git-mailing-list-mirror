Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D7520A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLKWSa (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:18:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39309 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbeLKWS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:18:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so15704811wra.6
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=81UmDTNJNl9a92cmkgKnEAEbkesig8HkxkxAabYMkCI=;
        b=bGe6yc5Up0LDR3SrybxBscxcSFL7/SSDpa6mYTRV7v26qKfrboc6UG01ZO91mNfY0E
         5+DUKRl/MRROLTv9drpz/T3CWBDe0xocv6xo6v3P9MZf6gP4urE6JEBdjwmefXkKe4nz
         cvcIgAHY2jLtow4mgnQkFuCmDjiZ8tNric9OEQDtmtduyzpbRiP7ApEjJ5GfZuFLfcaR
         NUgkFwtwUdoW3BOIch+iXP9Ok9XOUE90EVwylCogRZGWnAnkUpZ/tvoTr1AA2SQMFmWW
         fsu3l6leechOD/mxfuX7PS0l8BVCOw4y+01N5b4YhLQ8m2cIJiggRkitwb/i2R1czMUT
         1vbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=81UmDTNJNl9a92cmkgKnEAEbkesig8HkxkxAabYMkCI=;
        b=CXUp3sWGb0Vmq7Y2i4CMiDxYKU5RChlQ04uYBGWD4eG8DW4b7hn5RwDyMN0hRRpMLP
         cBiEe2AW2O8azAcUztjzNyNcK93zXhdXDvnYLWYvr5SNgWJkryhe4JKU3dk2Tk9FwYhw
         wV8aoaBy1WtBRnBFCzSBhmYHXtE2UKdD5o1OE78XDq7vJeCGAW/Ph6AkbTJDahLQiq4R
         PouufEUEitCbu5B4tpj2UMjT0p9E8TCdM2rzThqR35HdaKfiyH/3eeFGbaXn2qklSP2W
         c8SHqwhiUZ4Om1XRAaNS8zM6L0TOLpUxClyPcZvQu8LX4t5t9hQROf+f36B9+j1wcNY+
         7ivg==
X-Gm-Message-State: AA+aEWbGZylp3HEN1DyNilvkipjycfo6T6ciYF1AvM/HtwqzNGDBmkCU
        51amiIPgog1a/a8VU3XWGJfOUZc+
X-Google-Smtp-Source: AFSGD/W99MXupsIO7oyOXujzzd0zF/s+oz3E4OOQEjMXHRgV4TmubZvHa0wNf1zolXULVxXUvh5jlw==
X-Received: by 2002:adf:ec11:: with SMTP id x17mr15568200wrn.88.1544566706654;
        Tue, 11 Dec 2018 14:18:26 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id m4sm12748184wrw.67.2018.12.11.14.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:18:25 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:18:25 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: [PATCH 6/8] checkout: add --cached option
Message-ID: <20181211221825.GS4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-7-t.gummerer@gmail.com>
 <CABPp-BEyRNniNFBuMMFXjvuSz9RtP6R7TeBAWDJO+Y70oe7CBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEyRNniNFBuMMFXjvuSz9RtP6R7TeBAWDJO+Y70oe7CBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Elijah Newren wrote:
> On Sun, Dec 9, 2018 at 12:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > Add a new --cached option to git checkout, which works only on the
> > index, but not the working tree, similar to what 'git reset <tree-ish>
> > -- <pathspec>... does.  Indeed the tests are adapted from the 'git
> > reset' tests.
> >
> > In the longer term the idea is to potentially deprecate 'git reset
> > <tree-ish> -- <pathspec>...', so the 'git reset' command becomes only
> > about re-pointing the HEAD, and not also about copying entries from
> > <tree-ish> to the index.
> >
> > Note that 'git checkout' by default works in overlay mode, meaning
> > files that match the pathspec that don't exist in <tree-ish>, but
> > exist in the index would not be removed.  'git checkout --no-overlay
> > --cached' can be used to get the same behaviour as 'git reset
> > <tree-ish> -- <pathspec>'.
> 
> I think this argues _even more_ that --no-overlay should be the
> default.  Your series is valuable even if we don't push on that, I'm
> just being noisy about what I think would be an even better world.

I think just having that mode in 'git restore-files' Duy is working on
may have to be enough for now.

> Also, I don't think I've mentioned it yet, but I'm really excited
> about this series and what you're doing.  It's super cool.  (Which I
> expected when I saw the description of the desired behavior, but I'm
> also liking and contemplating re-using some code...)

Thanks :)

> > One thing this patch doesn't currently deal with is conflicts.
> > Currently 'git checkout --{ours,theirs} -- <file-with-conflicts>'
> > doesn't do anything with the index, so the --cached option just
> > mirrors that behaviour.  But given it doesn't even deal with
> > conflicts, the '--cached' option doesn't make much sense when no
> > <tree-ish> is given.  As it operates only on the index, it's always a
> > no-op if no tree-ish is given.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >
> > Maybe we can just disallow --cached without <tree-ish> given for now,
> > and possibly later allow it with some different behaviour for
> > conflicts, not sure what the best way forward here is.  We can also
> > just make it update the index as appropriate, and have it behave
> > different than 'git checkout' curerntly does when handling conflicts?
> 
> Huh?
>   "git checkout -- <path>"
> means update <path> from the index, meaning the index is left alone
> (it's the source) and only the working tree is touched.
> 
> When you add a flag named --cached to only update the index and not
> the working tree, then the index becomes the sole destination.
> 
> Now we combine: no tree is specified means the index is the source of
> the writing, and --cached being specified means the index is the sole
> destination of the writing.  Thus, you have a no-op.  If the user
> specifies --cached and no tree, you should immediately exit with a
> message along the lines of "Nothing to do; no tree given and --cached
> specified."  The presence of conflicts seems completely irrelevant to
> me here.

Ah yeah you're right, thanks for a sanity check.  The command I was
most worried about was 'git checkout --cached --{ours,theirs} -- <pathspec>', 
which I thought should update the index.  But as we don't give any
tree-ish, I'm not sure anymore it should.  Maybe just always exiting
with the message you mention above is the right thing to do.

> >  builtin/checkout.c         |  26 ++++++++--
> >  t/t2016-checkout-patch.sh  |   8 +++
> >  t/t2026-checkout-cached.sh | 103 +++++++++++++++++++++++++++++++++++++
> >  t/t9902-completion.sh      |   1 +
> >  4 files changed, 135 insertions(+), 3 deletions(-)
> >  create mode 100755 t/t2026-checkout-cached.sh
> >
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 0aef35bbc4..6ba85e9de5 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -45,6 +45,7 @@ struct checkout_opts {
> >         int ignore_other_worktrees;
> >         int show_progress;
> >         int overlay_mode;
> > +       int cached;
> >         /*
> >          * If new checkout options are added, skip_merge_working_tree
> >          * should be updated accordingly.
> > @@ -288,6 +289,10 @@ static int checkout_paths(const struct checkout_opts *opts,
> >                 die(_("Cannot update paths and switch to branch '%s' at the same time."),
> >                     opts->new_branch);
> >
> > +       if (opts->patch_mode && opts->cached)
> > +               return run_add_interactive(revision, "--patch=reset",
> > +                                          &opts->pathspec);
> > +
> >         if (opts->patch_mode)
> >                 return run_add_interactive(revision, "--patch=checkout",
> >                                            &opts->pathspec);
> > @@ -319,7 +324,9 @@ static int checkout_paths(const struct checkout_opts *opts,
> >                                  * the current index, which means that it should
> >                                  * be removed.
> >                                  */
> > -                               ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
> > +                               ce->ce_flags |= CE_MATCHED | CE_REMOVE;
> > +                               if (!opts->cached)
> > +                                       ce->ce_flags |= CE_WT_REMOVE;
> >                                 continue;
> >                         } else {
> >                                 /*
> > @@ -392,6 +399,9 @@ static int checkout_paths(const struct checkout_opts *opts,
> >         for (pos = 0; pos < active_nr; pos++) {
> >                 struct cache_entry *ce = active_cache[pos];
> >                 if (ce->ce_flags & CE_MATCHED) {
> > +                       if (opts->cached) {
> > +                               continue;
> > +                       }
> >                         if (!ce_stage(ce)) {
> >                                 errs |= checkout_entry(ce, &state, NULL);
> >                                 continue;
> > @@ -571,6 +581,11 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
> >          * not tested here
> >          */
> >
> > +       /*
> > +        * opts->cached cannot be used with switching branches so is
> > +        * not tested here
> > +        */
> > +
> >         /*
> >          * If we aren't creating a new branch any changes or updates will
> >          * happen in the existing branch.  Since that could only be updating
> > @@ -1207,9 +1222,13 @@ static int checkout_branch(struct checkout_opts *opts,
> >                 die(_("'%s' cannot be used with switching branches"),
> >                     "--patch");
> >
> > -       if (!opts->overlay_mode)
> > +       if (opts->overlay_mode != -1)
> > +               die(_("'%s' cannot be used with switching branches"),
> > +                   "--overlay/--no-overlay");
> > +
> > +       if (opts->cached)
> >                 die(_("'%s' cannot be used with switching branches"),
> > -                   "--no-overlay");
> > +                   "--cached");
> >
> >         if (opts->writeout_stage)
> >                 die(_("'%s' cannot be used with switching branches"),
> > @@ -1300,6 +1319,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
> >                             PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
> >                 OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
> >                 OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
> > +               OPT_BOOL(0, "cached", &opts.cached, N_("work on the index only")),
> >                 OPT_END(),
> >         };
> >
> > diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> > index 47aeb0b167..e8774046e0 100755
> > --- a/t/t2016-checkout-patch.sh
> > +++ b/t/t2016-checkout-patch.sh
> > @@ -108,6 +108,14 @@ test_expect_success PERL 'path limiting works: foo inside dir' '
> >         verify_state dir/foo head head
> >  '
> >
> > +test_expect_success PERL 'git checkout --cached -p' '
> > +       set_and_save_state dir/foo work work &&
> > +       test_write_lines n y | git checkout --cached -p >output &&
> > +       verify_state dir/foo work head &&
> > +       verify_saved_state bar &&
> > +       test_i18ngrep "Unstage" output
> > +'
> > +
> >  test_expect_success PERL 'none of this moved HEAD' '
> >         verify_saved_head
> >  '
> > diff --git a/t/t2026-checkout-cached.sh b/t/t2026-checkout-cached.sh
> > new file mode 100755
> > index 0000000000..1b66192727
> > --- /dev/null
> > +++ b/t/t2026-checkout-cached.sh
> > @@ -0,0 +1,103 @@
> > +#!/bin/sh
> > +
> > +test_description='checkout --cached <pathspec>'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'checkout --cached <pathspec>' '
> > +       echo 1 >file1 &&
> > +       echo 2 >file2 &&
> > +       git add file1 file2 &&
> > +       test_tick &&
> > +       git commit -m files &&
> > +       git rm file2 &&
> > +       echo 3 >file3 &&
> > +       echo 4 >file1 &&
> > +       git add file1 file3 &&
> > +       git checkout --cached HEAD -- file1 file2 &&
> > +       test_must_fail git diff --quiet &&
> > +
> > +       cat >expect <<-\EOF &&
> > +       diff --git a/file1 b/file1
> > +       index d00491f..b8626c4 100644
> > +       --- a/file1
> > +       +++ b/file1
> > +       @@ -1 +1 @@
> > +       -1
> > +       +4
> > +       diff --git a/file2 b/file2
> > +       deleted file mode 100644
> > +       index 0cfbf08..0000000
> > +       --- a/file2
> > +       +++ /dev/null
> > +       @@ -1 +0,0 @@
> > +       -2
> > +       EOF
> > +       git diff >actual &&
> > +       test_cmp expect actual &&
> > +
> > +       cat >expect <<-\EOF &&
> > +       diff --git a/file3 b/file3
> > +       new file mode 100644
> > +       index 0000000..00750ed
> > +       --- /dev/null
> > +       +++ b/file3
> > +       @@ -0,0 +1 @@
> > +       +3
> > +       EOF
> > +       git diff --cached >actual &&
> > +       test_cmp expect actual
> > +'
> > +
> > +test_expect_success 'checking out an unmodified path is a no-op' '
> > +       git reset --hard &&
> > +       git checkout --cached HEAD -- file1 &&
> > +       git diff-files --exit-code &&
> > +       git diff-index --cached --exit-code HEAD
> > +'
> > +
> > +test_expect_success 'checking out specific path that is unmerged' '
> > +       test_commit file3 file3 &&
> > +       git rm --cached file2 &&
> > +       echo 1234 >file2 &&
> > +       F1=$(git rev-parse HEAD:file1) &&
> > +       F2=$(git rev-parse HEAD:file2) &&
> > +       F3=$(git rev-parse HEAD:file3) &&
> > +       {
> > +               echo "100644 $F1 1      file2" &&
> > +               echo "100644 $F2 2      file2" &&
> > +               echo "100644 $F3 3      file2"
> > +       } | git update-index --index-info &&
> > +       git ls-files -u &&
> > +       git checkout --cached HEAD file2 &&
> > +       test_must_fail git diff --quiet &&
> > +       git diff-index --exit-code --cached HEAD
> > +'
> > +
> > +test_expect_success '--cached without --no-overlay does not remove entry from index' '
> > +       test_must_fail git checkout --cached HEAD^ file3 &&
> > +       git ls-files --error-unmatch -- file3
> > +'
> > +
> > +test_expect_success 'file is removed from the index with --no-overlay' '
> > +       git checkout --cached --no-overlay HEAD^ file3 &&
> > +       test_path_is_file file3 &&
> > +       test_must_fail git ls-files --error-unmatch -- file3
> > +'
> > +
> > +test_expect_success 'test checkout --cached --no-overlay at given paths' '
> > +       mkdir sub &&
> > +       >sub/file1 &&
> > +       >sub/file2 &&
> > +       git update-index --add sub/file1 sub/file2 &&
> > +       T=$(git write-tree) &&
> > +       git checkout --cached --no-overlay HEAD sub/file2 &&
> > +       test_must_fail git diff --quiet &&
> > +       U=$(git write-tree) &&
> 
> Do we need to worry at all about losing the exit status of write-tree
> in either invocation?  In particular, if the second one for U fails
> somehow, we'd end up with $U being a blank string and we'd still
> probably get "$T" != "$U" below.

Hmm this seems to be a fairly common pattern in our test suite:

$ git grep -F '$(git write-tree)' t/* | wc -l
112

But maybe it's just something we used to do, but should move away
from.  Just writing the output to a file shouldn't be much harder
either, I'll do that in the next iteration.

> You also had some rev-parse invocations hidden in a sub-shell in both
> this patch and patch 5, but subsequent commands relied on non-empty
> output out of those, so I figured those were fine.  This one might be
> too, but I thought I'd at least mention it.
> 
> > +       echo "$T" &&
> > +       echo "$U" &&
> > +       test_must_fail git diff-index --cached --exit-code "$T" &&
> > +       test "$T" != "$U"
> > +'
> > +
> > +test_done
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index a3fd9a9630..cbc304ace8 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -1437,6 +1437,7 @@ test_expect_success 'double dash "git checkout"' '
> >         --no-quiet Z
> >         --no-... Z
> >         --overlay Z
> > +       --cached Z
> >         EOF
> >  '
> >
> > --
> > 2.20.0.405.gbc1bbc6f85
