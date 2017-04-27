Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2D2207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423304AbdD0WIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:08:01 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:35960 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162486AbdD0WH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:07:59 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 3rZsd1rA2cpsk3rZsdbDDC; Thu, 27 Apr 2017 23:07:57 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=FOMDAfpskrF99ATBFH0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <DAB03BFCBBCA4C4F95D21A86E3B1DF2F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Stefan Beller" <sbeller@google.com>, "Jeff King" <peff@peff.net>,
        "Orgad Shaneh" <orgads@gmail.com>,
        "Dakota Hawkins" <dakotahawkins@gmail.com>,
        "git" <git@vger.kernel.org>,
        "Christoph Michelbach" <michelbach94@gmail.com>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com>        <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>        <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>        <CAGZ79kZDzuSHw4siSkiekw73bBq9R8gg_R+a7NyNUG6bYxc2Og@mail.gmail.com>        <C3A8A88B8DDD468095B7FD256330EEF7@PhilipOakley> <xmqqa873ubiw.fsf@gitster.mtv.corp.google.com>
Subject: Re: Submodule/contents conflict
Date:   Thu, 27 Apr 2017 23:07:57 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfE7PblHoMfq63oQWmYBmIceAuP4YIjxl0zrDSiZDmfteoQZSoqnH60UG4nRneaNg+hhrZ9kakvxrRvKvyfKpj/S/hYwjfpqQD/fbCI3BsKocEzrxvOCD
 AiVCKOV6cdqCeJZC+I9rziY6koLEwZv+WkoQpP8sE2b85fnMoCEv+RxBSZSxSs2iaG8HCTKCNDrVx856oUQTsUnkIWnRonoDyhujxSXG0ZPvF9cFLiRKSPb6
 F/4EER/G+bXM7JNR+ouwdBH0+qT8LZjTel/WcD6cgnkYPn9tpkNjS4jSARbRm2yAWXZPyc4JCicQ1of3bGR2jMvpysKD/0fcWcH64g3sMB0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com> Sent: Wednesday, April 26, 2017 
3:51 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> As I recall Christoph was using checkout to copy a file (e.g. a
>> template file) from an older commit/revision into his worktree, and
>> was suprised that this (git checkout <tree> <path>) also _staged_ the
>> file, rather than simply letting it be in a modified/untracked state.
>
> This probably is taking it even further than the original topic, but
> I raise this weather-balloon to see if anybody is interested.
>
> In the modern day, it might be useful if the "--working-tree-only"
> mode added a new file as an intent-to-add entry to the index, but
> that is not what "git apply (no other options)" (which is the gold

did you mean `git add` ? Or am I missing something.

> standard for command that operates on the working tree and/or on the
> index) does, so it is not done in this patch.  IOW, if you grab a
> path that does not exist in your index out of <tree-ish>, you will
> write out an untracked file to the working tree.

It sound like a good idea, as I wasn't aware of another easy way of doing 
it.

>
> -- >8 --
> Subject: [PATCH] checkout: add --working-tree-only option
>
> "git checkout <tree-ish> <pathspec>" has always copied the blob from
> the tree-ish to the index before checking them out to the working tree.
>
> Some users may want to grab a blob out of a tree-ish directly to the
> working tree, without updating the index, so that "git diff" can be
> used to assess the damage and adjust the file contents taken from a
> different branch to be more appropriate for the current branch.
>
> The new option "--working-tree-only" allows exactly that.
>
> In the hindsight, when a command works on the working tree and/or
> the index, the usual convention is:
>
> - with no other option, the command works only on the working tree;
>
> - with "--cached" option, the command works only on the index; and
>
> - with "--index" option, the command works on both the working tree
>   and the index.
>
> So we probably should have triggered the default behaviour under the
> "--index" option, and triggered this "--working-tree-only" mode of
> behaviour when "--index" option is not given.  From the same point
> of view, "git checkout --cached <tree-ish> <pathspec>" would have
> done the same as "git reset <tree-ish> <pathspec>" would do.  And
> that may have made the command set a bit more consistent.
>
> But that is merely a hindsight being 20/20, oh well.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Documentation/git-checkout.txt | 22 +++++++++++++++-------
> builtin/checkout.c             | 10 +++++++++-
> t/t2022-checkout-paths.sh      | 21 +++++++++++++++++++++
> 3 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt 
> b/Documentation/git-checkout.txt
> index 8e2c0662dd..201677752e 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -14,6 +14,7 @@ SYNOPSIS
> 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] 
> [<start_point>]
> 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] 
> [--] <paths>...
> 'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
> +'git checkout' --working-tree-only <tree-ish> [--] [<paths>...]
>
> DESCRIPTION
> -----------
> @@ -81,13 +82,14 @@ Omitting <branch> detaches HEAD at the tip of the 
> current branch.
> 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
>
>  When <paths> or `--patch` are given, 'git checkout' does *not*
> - switch branches.  It updates the named paths in the working tree
> - from the index file or from a named <tree-ish> (most often a
> - commit).  In this case, the `-b` and `--track` options are
> - meaningless and giving either of them results in an error.  The
> - <tree-ish> argument can be used to specify a specific tree-ish
> - (i.e.  commit, tag or tree) to update the index for the given
> - paths before updating the working tree.
> + switch branches.  In this case, the `-b` and `--track` options
> + are meaningless and giving either of them results in an error.
> ++
> +The command checks out blobs for paths that match the given
> +<pathspec> from the index to the working tree.  When an optional
> +<tree-ish> is given, the blobs for paths that match the given
> +<pathspec> are copied from the <tree-ish> to the index before
> +they are checked out of the index.
> +
> 'git checkout' with <paths> or `--patch` is used to restore modified or
> deleted paths to their original contents from the index or replace paths
> @@ -101,6 +103,12 @@ specific side of the merge can be checked out of the 
> index by
> using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
> file can be discarded to re-create the original conflicted merge result.
>
> +'git checkout' --working-tree-only <tree-ish> [--] <pathspec>...::
> + Similar to `git checkout <tree-ish> [--] <pathspec>`, but
> + the index file is left in the same state as it was before
> + running this command.

I feel that the docs should also contain a little of the commit message 
highlighting that `This complements the usual convention of "--cached" and 
"--index" options for other commands.`, and would pick up on Stefan's "I 
didn't know that" response - A little education of the reader goes a long 
way, maybe ;-)

> +
> +
> OPTIONS
> -------
> -q::
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 9b2a5b31d4..d214e99521 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -37,6 +37,7 @@ struct checkout_opts {
>  int overwrite_ignore;
>  int ignore_skipworktree;
>  int ignore_other_worktrees;
> + int no_index;
>  int show_progress;
>
>  const char *new_branch;
> @@ -268,6 +269,9 @@ static int checkout_paths(const struct checkout_opts 
> *opts,
>  die(_("Cannot update paths and switch to branch '%s' at the same time."),
>      opts->new_branch);
>
> + if (opts->no_index && !opts->source_tree)
> + die(_("'--working-tree-only' cannot be used without tree-ish"));
> +
>  if (opts->patch_mode)
>  return run_add_interactive(revision, "--patch=checkout",
>     &opts->pathspec);
> @@ -370,7 +374,9 @@ static int checkout_paths(const struct checkout_opts 
> *opts,
>  }
>  }
>
> - if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
> + if (opts->no_index)
> + ; /* discard the in-core index */
> + else if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
>  die(_("unable to write new index file"));
>
>  read_ref_full("HEAD", 0, rev.hash, NULL);
> @@ -1161,6 +1167,8 @@ int cmd_checkout(int argc, const char **argv, const 
> char *prefix)
>  OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
>  N_("do not check if another worktree is holding the given ref")),
>  OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress 
> reporting")),
> + OPT_BOOL(0, "working-tree-only", &opts.no_index, N_("checkout to working 
> tree only without touching the index")),
> +
>  OPT_END(),
>  };
>
> diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
> index f46d0499bc..8ea2e34c90 100755
> --- a/t/t2022-checkout-paths.sh
> +++ b/t/t2022-checkout-paths.sh
> @@ -78,4 +78,25 @@ test_expect_success 'do not touch files that are 
> already up-to-date' '
>  test_cmp expect actual
> '
>
> +test_expect_success 'working-tree-only option leaves checked out files 
> unadded' '
> + git reset --hard &&
> + git checkout -b pu next &&
> + echo another >>file1 &&
> + echo exists >file3 &&
> + git add file3 &&
> + git commit -a -m another &&
> + git checkout next &&
> +
> + ! grep another file1 &&
> + git checkout --working-tree-only pu file1 file3 &&
> + grep another file1 &&
> + test_must_fail git grep --cached another file1 &&
> +
> + grep exists file3 &&
> + git ls-files file3 >actual &&
> + >expect &&
> + test_cmp expect actual
> +
> +'
> +
> test_done
> -- 
> 2.13.0-rc0-309-gb63395ed9e
>
--
Thanks
Philip 

