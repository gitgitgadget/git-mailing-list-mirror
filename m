Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C6C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiI0QgU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiI0QgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:36:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744761D88FD
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:36:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d14so5376559ilf.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+UI1KgTab0CTvoGtNBRd0ino0cadpQt8LmvQFF75V4o=;
        b=DsO8h5KHOfC/5da4Mk61cw2Yx/RVfq7f41UajQ27BlmFPFsgpZOXCaOun4NEkJHvWT
         MUQH3rRy+UsdRyBsC3CTpp6VlCNatil+baDNTSJrc/N3Hbo9oap7wQV1TEGNMYbSkjcT
         sasI+aBwF/fkWzcybYn4kvnny8z+bEU8Hx0IN/hxUgKxl7RsAp6qxCDTnscPrHWJ32ci
         K5lrrhI7K3w93yFRSxAtpOo7kmD1zfoYM1clQJ4M+kCCUkJJOlcc9CKiHeisMrGlB9rK
         MRYmIjbAmqZJzt/if8uOoQTcRgD+kQH3QWqsYiJAkxf6/ICWHeWSnAjgfYmM4KMxbnew
         mLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+UI1KgTab0CTvoGtNBRd0ino0cadpQt8LmvQFF75V4o=;
        b=c+W58rLunsud7uQvQ0vxRbyB1CeWB3oWFyjI8xeShuyksOzRmOyBPBEHwPazWsgx4j
         frS87c7bB1vxs/3/2Dj9lFHzs7ywRfBOoPmiA7bxvtMOhIMYrF8Q3vQzchEQc5jFwc2+
         HWQQzyCumYeVxvT/tutgHGqZDMiU+vhksqmnWWNi/rsQmxYUtwvaiBc/UUUM43Dr5Yzt
         +VQntutDzrpVwJk9r6n1scDb4ryG+Gw2nbMRsQMnZbRty0y0rxtc8juw+fUDJiuNpw60
         5S6tJL/DNZIe+VzEy2Szq3M2qgq4y2jT1tc/OvZiWCkJGoilEAYTQ+X3UUXekJr1pTos
         QAJA==
X-Gm-Message-State: ACrzQf2+wz03q1dC/xrAe498Fm9gapaxC40AZcvRxwabk6PmC2Kj/6gN
        Dn33VsOfgmTdwSMrMcdeUIuw
X-Google-Smtp-Source: AMsMyM65DUNSq1z2BVI2sY7A9lLpKiIy2++F2XgUQVOd1uQwiFkNHD2RPOs2ijAEr2AYoMLblMZbTg==
X-Received: by 2002:a05:6e02:152c:b0:2f6:58ae:ff0a with SMTP id i12-20020a056e02152c00b002f658aeff0amr12916177ilu.167.1664296563500;
        Tue, 27 Sep 2022 09:36:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id g15-20020a056602150f00b006a2e2834531sm933239iow.44.2022.09.27.09.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:36:03 -0700 (PDT)
Message-ID: <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
Date:   Tue, 27 Sep 2022 12:36:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/24/2022 8:09 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>

> +  (Behavior A) Users are _only_ interested in the sparse portion of the repo
> +
> +These folks might know there are other things in the repository, but
> +don't care.  They are uninterested in other parts of the repository, and
> +only want to know about changes within their area of interest.  Showing
> +them other results from history (e.g. from diff/log/grep/etc.) is a
> +usability annoyance, potentially a huge one since other changes in
> +history may dwarf the changes they are interested in.

This idea of restricting the commit history to the sparse-checkout
definition (by default, with an escape hatch) seems like the most
radical of the things we've considered. I think it's interesting to
consider, but it might be better to think about things like diffstats,
grepping, and otherwise preventing out-of-cone adjustments by default.

That said, the idea of restricting history is also the simplest to
describe as a user-visible change.

> +Some of these users also arrive at this usecase from wanting to use
> +partial clones together with sparse checkouts and do disconnected
> +development.  Not only do these users generally not care about other
> +parts of the repository, but consider it a blocker for Git commands to
> +try to operate on those.  If commands attempt to access paths in history
> +outside the sparsity specification, then the partial clone will attempt
> +to download additional blobs on demand, fail, and then fail the user's
> +command.  (This may be unavoidable in some cases, e.g. when `git merge`
> +has non-trivial changes to reconcile outside the sparsity path, but we
> +should limit how often users are forced to connect to the network.)

This idea pairs well with a feature I've been meaning to build:
'git sparse-checkout backfill' would download all historical blobs
within the sparse-checkout definition. This is possible with rev-list,
but I want to investigate grouping blobs by path and making requests in
batches, hopefully allowing better deltification and ability to recover
from network disconnections. That makes this idea of "staying within
your sparse-checkout means no missing object downloads" even more likely.

> +  (Behavior B) Users want a sparse working tree, but are working in a larger whole
> +
> +Stolee described this usecase this way[11]:
> +
> +"I'm also focused on users that know that they are a part of a larger
> +whole. They know they are operating on a large repository but focus on
> +what they need to contribute their part. I expect multiple "roles" to
> +use very different, almost disjoint parts of the codebase. Some other
> +"architect" users operate across the entire tree or hop between different
> +sections of the codebase as necessary. In this situation, I'm wary of
> +scoping too many features to the sparse-checkout definition, especially
> +"git log," as it can be too confusing to have their view of the codebase
> +depend on your "point of view."

Thanks for including this.

> +People might also end up wanting behavior B due to complex inter-project
> +dependencies.  The initial attempts to use sparse-checkouts usually
> +involve the directories you are directly interested in plus what those
> +directories depend upon within your repository.  But there's a monkey
> +wrench here: if you have integration tests, they invert the hierarchy:
> +to run integration tests, you need not only what you are interested in
> +and its dependencies, you also need everything that depends upon what
> +you are interested in or that depends upon one of your
> +dependencies...AND you need all the dependencies of that expanded group.
> +That can easily change your sparse-checkout into a nearly dense one.

In my experience, the downstream dependencies are checked via builds in
the cloud, though that doesn't help if they are source dependencies and
you make a breaking change to an API interface. This kind of problem is
absolutely one of system architecture and I don't know what Git can do
other than to acknowledge it and recommend good patterns.

In a properly-organized project, 95% of engineers in the project can have
a small sparse-checkout, then 5% work on the common core that has these
downstream dependencies and require a large sparse-checkout definition.
There's nothing Git can do to help those engineers that do cross-tree
work.

(nit: this is a good place to break up this paragraph.)

> +Naturally, that tends to kill the benefits of sparse-checkouts.  There
> +are a couple solutions to this conundrum: either avoid grabbing
> +dependencies (maybe have built versions of your dependencies pulled from
> +a CI cache somewhere), or say that users shouldn't run integration tests
> +directly and instead do it on the CI server when they submit a code
> +review.  Or do both.  Regardless of whether you stub out your
> +dependencies or stub out the things that depend upon you, there is
> +certainly a reason to want to query and be aware of those other
> +stubbed-out parts of the repository, particularly when the dependencies
> +are complex or change relatively frequently.  Thus, for such uses,
> +sparse-checkouts can be used to limit what you directly build and
> +modify, but these users do not necessarily want their sparse checkout
> +paths to limit their queries of history.

...

> +* Commands behaving the same regardless of high-level use-case

Thank you for this audit of command usage.

> +* Commands that differ for behavior A vs. behavior B:
> +
> +  * commands that make modifications:
> +      * add
> +      * rm
> +      * mv

I think these, along with diff and grep, are great candidates to have
the default behavior fit category A with a flag to act with behavior B.

> +  * commands that query history
> +      * bisect

Interesting that 'bisect' could be considered differently, but I
suppose that if we are presenting the commit history graph in a
simplified form that we'd want to bisect on that simplified graph
instead of the full one.

> +      * blame
> +	* and annotate

blame and annotate operate on a single path, so they already
restrict within the sparse-checkout definition (unless the user
specifies a path outside of the sparse-checkout). The only difference
between A and B would be reporting an error if the path is outside the
definition, right? We don't need to do anything special to simplify
the history.

> +      * show (when given commit arguments)
> +      * log
> +	* and variants: shortlog, gitk, show-branch, whatchanged

And here is where we'd need to do that big changes for simplifying
the history graph. Does 'rev-list' not fit here? I tend to think of
'log' as a formatting layer on top of 'rev-list', but maybe that is
misguided.

> +* Comands I don't know how to classify

nit: s/Comands/Commands/

> +
> +  * ls-files> +  * checkout-index
> +  * update-index
> +  * plumbing -- diff-files, diff-index, diff-tree, ls-tree, rev-list

Plumbing commands might be a good candidate for "by default you
can do anything, but we can add ability to put guard rails on the
sparse-checkout set".

> +  * range-diff
> +
> +    Is this like `log` or `format-patch`?

I think this is more like format-patch. However, we need to be careful
if users use "git log" output to determine the range they provide to
the range-diff command, since that range could indicate a larger set of
commits.

> +=== Subcommand-dependent defaults ===
> +
> +Note that we have different defaults (for the desired behavior, not just
> +the current implementation) depending on the command:
> +
> +  * Commands defaulting to --restrict:

This appears to be the first mention of --restrict. Perhaps it would be
worth declaring what --restrict, --restrict-unless-conflicts, and
--no-restrict mean before creating this categorization?

> +    * status
> +    * diff (without --cached or REVISION arguments)
> +    * grep (without --cached or REVISION arguments)
> +    * switch
> +    * checkout (the switch-like half)
> +    * read-tree
> +    * reset (--hard)
> +    * restore/checkout
> +    * checkout-index
> +
> +    This behavior makes sense; these interact with the working tree.
> +
> +  * Commands defaulting to --restrict-unless-conflicts
> +    * merge
> +    * rebase
> +    * cherry-pick
> +    * revert

In my mind, --restrict-unless-conflicts doesn't provide any value unless
you want the --restrict mode to create an _error_ when trying to do
something outside of the sparse-checkout cone.

The only thing I can think about is that the diffstat might want to show
the stats for the conflicted files, in which case that's an important
perspective on the distinction from --restrict.

> +    In the case of am and apply, those commands only operate on the
> +    working tree, so they are kind of in the same boat as stash.
> +    Perhaps `git am` could run `git sparse-checkout reapply`
> +    automatically afterward and move into a category more similar to
> +    merge/rebase/cherry-pick, but it'd still be weird because it'd
> +    vivify files besides just conflicted ones when there are conflicts.

'git am' should be able to construct the resulting commit from the patch
without adding files outside of the sparse-checkout definition. If there
is a conflict, it fails in the application, anyway. I suppose you are
writing this here because 'git am' does not play nice with sparse-checkout
right now.

> +    In the case of ls-files, `git ls-files -t` is often used to see what
> +    is sparse and not, in which case restricting would not make sense.
> +    Also, ls-files has traditionally been used to get a list of "all
> +    tracked files", which would suggest not restricting.  But it's
> +    slightly funny, because sparse-checkouts essentially split tracked
> +    files into two categories -- those in the sparse specification and
> +    those outside -- and how does the user specify which of those two
> +    types of tracked files they want?

> +  * Commands defaulting to --restrict-but-warn (although Behavior A vs. Behavior B> +    may affect how verbose the warnings are):

More modes! OK.

> +    * add
> +    * rm
> +    * mv
> +
> +    The defaults here perhaps make sense since they are nearly --restrict, but
> +    actually using --restrict could cause user confusion if users specify a
> +    specific filename, so they warn by default.  That logic may sound like
> +    --no-restrict should be the default, but that's prone to even bigger confusion:
> +      * `git add <somefile>` if honored and outside the sparse cone, can result in
> +	the file randomly disappearing later when some subsequent command is run
> +	(since various commands automatically clean up unmodified files outside
> +	the sparsity specification).
> +      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
> +	outside the range of the user's interest.  Much better to operate on the
> +	sparsity specification and give the user warnings if other files could have
> +	matched.

The cost of checking for other files that might match is sometimes too large
(needing to expand the sparse index or walk trees to find those path names) that
I would not recommend warning that we _didn't_ do something. Perhaps an advice
that says "we did not look outside the sparse-checkout definition for matching
paths" when the pathspec is not an exact path or a prefix match.

> +      * `git mv` has similar surprises when moving into or out of the cone, so
> +	best to restrict and throw warnings if restriction might affect the result.
> +
> +    There may be a difference in here between behavior A and behavior B.
> +    For behavior A, we probably only want to warn if there were no
> +    suitable matches for files in the sparsity specification, whereas
> +    for behavior B, we may want to warn even if there are valid files to
> +    operate on if the result would have been different under
> +    `--no-restrict`.

I think in behavior B, users who actually want to modify things tree-wide will
actually increase their sparse-checkout definition to include those files so
they can validate what they are doing.

> +  * Commands whose default for --restrict vs. --no-restrict should vary depending
> +    on Behavior A or Behavior B
> +    * diff (with --cached or REVISION arguments)
> +    * grep (with --cached or REVISION arguments)
> +    * show (when given commit arguments)
> +    * bisect
> +    * blame
> +      * and annotate
> +    * log
> +      * and variants: shortlog, gitk, show-branch, whatchanged
> +
> +    For now, we default to behavior B for these, which want a default of
> +    --no-restrict.

I do feel pretty strongly that we'll want a --no-restrict default here
because otherwise we will present confusion. I'm not even sure if we would
want to make this available via a config setting, but likely a config
setting makes sense in the long term.

> +=== Implementation Questions ===
> +
> +  * Does the name --[no-]restrict sound good to others?  Are there better options?
> +    * Names in use, or appearing in patches, or previously suggested:
> +      * --sparse/--dense
> +      * --ignore-skip-worktree-bits
> +      * --ignore-skip-worktree-entries
> +      * --ignore-sparsity
> +      * --[no-]restrict-to-sparse-paths
> +      * --full-tree/--sparse-tree
> +      * --[no-]restrict

I like the simplicity of --[no-]restrict, and my only worry is that it
doesn't immediately link to what it is restricting.

Perhaps something like "scope" would describe the set of things we care
about, but use a text mode:

	--scope=sparse	(--restrict)
	--scope=all	(--no-restrict)

But I'm notoriously bad at naming things.

> +  * Should --[no-]restrict be a git global option, or added as options to each
> +    relevant command?  (Does that make sense given the multitude of different
> +    default behaviors we have for different options?)

If we can make it a global option, that would be great, then update
the commands to behave under that mode as we go.

If that doesn't work, then adding the consistent option across commands
would be helpful. It might be good to make a OPT_RESTRICT macro (much
like OPT__VERBOSE, OPT__QUIET, and similar macros.

> +  * Should --sparse in ls-files be made an alias for --restrict?
> +    `--restrict` is certainly a near synonym in cone-mode, but even then
> +    it's not quite the same.  In non-cone mode, ls-files' `--sparse`
> +    option has no effect, and in cone-mode it still shows the sparse
> +    directory entries which are technically outside the sparsity
> +    specification.

We should definitely replace the --sparse option(s) with whatever we
choose here. For ls-files, we have the issue that we are reporting
what is in the index, and in non-cone-mode the index cannot be sparse.

Now, maybe we change what the ls-files mode does under --restrict and
only have it report the paths within the sparse-checkout and not even
show the results for sparse directory entries. The --no-restrict would
then expand a sparse-index to show only paths again.

> +  * Should --ignore-skip-worktree-bits in checkout-index, checkout, and
> +    restore be made deprecated aliases for --no-restrict?  (They have the
> +    same meaning.)

Yes.

> +  * Should --ignore-skip-worktree-entries in update-index be made a
> +    deprecated alias for --no-restrict?  (Or, better yet, should the
> +    option just be nuked from orbit after flipping the default, since
> +    the reverse option is never wanted and the sole purpose of this
> +    option was to turn off a bug?)

Yes and yes.

> +  * sparse-checkout: once behavior A is fully implemented, should we
> +    take an interim measure to easy people into switching the default?

nit: s/easy/ease/

> +    Namely, if folks are not already in a sparse checkout, then require
> +    `sparse-checkout init/set` to take a `--[no-]restrict` flag (which
> +    would set core.restrictToSparse according to the setting given), and
> +    throw an error if the flag is not provided?  That error would be a
> +    great place to warn folks that the default may change in the future,
> +    and get them used to specifying what they want so that the eventual
> +    default switch is seamless for them.

I don't like using the same option name (--[no-]restrict) for something
that sets a config option to keep that behavior permanently. Different
names that make it clearer could be:

	--enable-restrict-mode
	--set-scope=(sparse|all)

> +  * clone: should we provide some mechanism for tying partial clones and
> +    sparse checkouts together better.  Maybe an option
> +	--sparse=dir1,dir2,...,dirN
> +    which:
> +       * Does initial fetch with `--filter=blob:none`
> +       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
> +       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
> +	 fault in the missing blobs within the sparse
> +	 specification...except that rev-list needs some kind of options
> +	 to also get files from leading directories too.
> +       * Sets --restrict mode to allow focusing on the cone of interest
> +	 (and to permit disconnected development)

As mentioned, I think we should have the option to backfill the blobs in
the sparse-checkout definition, but 'git clone' should not do this by
default. It's something that can be launched in the background, maybe, but
not a blocking operation on being able to use the repository.

'scalar clone' is an excellent testing bed for these kinds of things,
like setting the --restrict mode by default.

Hopefully my responses aren't too far off-base. I'll go read the rest of
the discussion now that I've contributed my thoughts on the doc.

Thanks,
-Stolee
