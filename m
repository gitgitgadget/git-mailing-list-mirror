Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836FC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 05:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiI1Fic (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 01:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiI1Fia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 01:38:30 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69241118DD6
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:38:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a10so13225382ljq.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 22:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=eTYnd3dVGUULP4pnc7wd18biyDpIn5ZNcUhQ69dGbCw=;
        b=Xzbv5QqkDc0rH9TRWXtx/7l+bkvLZU1pvzPWyGXFg7PrZ+oOtJnh0b23SdzmTHiCgi
         3zSDK6Lx4huNznEyhX8k7mTVMXWuqGyRlVO2CRWYal1d9KoxDevVZyfHUdWyJnjhPqkY
         Y4fjX6A2+az6EJQm+RpA5UBB+G9kEOnnao/se3qrZgSqU0CtEMHLlHX6hJbU36v/eIwp
         9YGBE0NX5Hecltj2ipNeb2W+j0BTUsvtVVfnppHybg42SPPzeqYOcoWtKBxcGCmZGxZ3
         0W/GDhQXPpOvb9vJG0/VsexVioFkKGcdMN4DyelD8xxNoC4iAssK5A5dnvAhNB5dM5tl
         a5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=eTYnd3dVGUULP4pnc7wd18biyDpIn5ZNcUhQ69dGbCw=;
        b=7FbJl0NxZGWa9L9t0wcECUvwGjF7oqCxs5TTaQbmN9vnCR9iFkcHq/p0VH5slPHC7O
         0RCKB+DDCrXi2EF9Q4EA3meCVuZmPV0mc5eFVpYk6MrYzpaH0TuWgP55z+z0a8TC+DoF
         bF4piZ72D83M4awGK+3VXF+T7QugA6oGRsIwUHIvPj6KKdGtPKA8gYeFJhepjMRty55P
         3xDf32XzcZv7PGvQ3eYIv/luk3deuvZV7TYJ7xZQrTSBoOOnu3VZgysFj+OlL+H3KeGo
         5amcY1U/AU0BrVkzGpJJI+y4DjguCSg7M2w6G9lBisoVwnw1UpO2uENJsi0m71sC1tBs
         KYlw==
X-Gm-Message-State: ACrzQf3iHqeXPJarPjjvqCIH0YTcSvQfmGJfh4FZVlxk8hKwrcYyBIWJ
        63OrshqzuykDcnhUkloBsMH4XcQTUDCzI1PB3wU=
X-Google-Smtp-Source: AMsMyM54gGS7cXtCw51lCLQmgCb8l97C1yVCbSkglYgBxKmCxvrP90RykF6rnVRMQZ1PqUNtvfoYNAXIXIjKoLEIs8c=
X-Received: by 2002:a2e:921a:0:b0:26c:1166:6666 with SMTP id
 k26-20020a2e921a000000b0026c11666666mr11262152ljg.128.1664343506239; Tue, 27
 Sep 2022 22:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com> <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
In-Reply-To: <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 27 Sep 2022 22:38:14 -0700
Message-ID: <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 9:36 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 9/24/2022 8:09 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> > +  (Behavior A) Users are _only_ interested in the sparse portion of the repo
> > +
> > +These folks might know there are other things in the repository, but
> > +don't care.  They are uninterested in other parts of the repository, and
> > +only want to know about changes within their area of interest.  Showing
> > +them other results from history (e.g. from diff/log/grep/etc.) is a
> > +usability annoyance, potentially a huge one since other changes in
> > +history may dwarf the changes they are interested in.
>
> This idea of restricting the commit history to the sparse-checkout
> definition (by default, with an escape hatch) seems like the most
> radical of the things we've considered. I think it's interesting to
> consider, but it might be better to think about things like diffstats,
> grepping, and otherwise preventing out-of-cone adjustments by default.
>
> That said, the idea of restricting history is also the simplest to
> describe as a user-visible change.

By "restricting commit history", are you thinking in terms of "git log
-- PATHS" or more like some kind of special --filter to git-clone?

I get the feeling you might be thinking about the latter, whereas I
was assuming users had all commits (and all trees), but log/diff would
restrict output based on relevant paths.

> > +Some of these users also arrive at this usecase from wanting to use
> > +partial clones together with sparse checkouts and do disconnected
> > +development.  Not only do these users generally not care about other
> > +parts of the repository, but consider it a blocker for Git commands to
> > +try to operate on those.  If commands attempt to access paths in history
> > +outside the sparsity specification, then the partial clone will attempt
> > +to download additional blobs on demand, fail, and then fail the user's
> > +command.  (This may be unavoidable in some cases, e.g. when `git merge`
> > +has non-trivial changes to reconcile outside the sparsity path, but we
> > +should limit how often users are forced to connect to the network.)
>
> This idea pairs well with a feature I've been meaning to build:
> 'git sparse-checkout backfill' would download all historical blobs
> within the sparse-checkout definition. This is possible with rev-list,
> but I want to investigate grouping blobs by path and making requests in
> batches, hopefully allowing better deltification and ability to recover
> from network disconnections. That makes this idea of "staying within
> your sparse-checkout means no missing object downloads" even more likely.

This sounds awesome.

> > +  (Behavior B) Users want a sparse working tree, but are working in a larger whole
> > +
> > +Stolee described this usecase this way[11]:
> > +
> > +"I'm also focused on users that know that they are a part of a larger
> > +whole. They know they are operating on a large repository but focus on
> > +what they need to contribute their part. I expect multiple "roles" to
> > +use very different, almost disjoint parts of the codebase. Some other
> > +"architect" users operate across the entire tree or hop between different
> > +sections of the codebase as necessary. In this situation, I'm wary of
> > +scoping too many features to the sparse-checkout definition, especially
> > +"git log," as it can be too confusing to have their view of the codebase
> > +depend on your "point of view."
>
> Thanks for including this.

I was actually worried this usecase was decreasing in priority for
you.  More on that later...

> > +People might also end up wanting behavior B due to complex inter-project
> > +dependencies.  The initial attempts to use sparse-checkouts usually
> > +involve the directories you are directly interested in plus what those
> > +directories depend upon within your repository.  But there's a monkey
> > +wrench here: if you have integration tests, they invert the hierarchy:
> > +to run integration tests, you need not only what you are interested in
> > +and its dependencies, you also need everything that depends upon what
> > +you are interested in or that depends upon one of your
> > +dependencies...AND you need all the dependencies of that expanded group.
> > +That can easily change your sparse-checkout into a nearly dense one.
>
> In my experience, the downstream dependencies are checked via builds in
> the cloud, though that doesn't help if they are source dependencies and
> you make a breaking change to an API interface. This kind of problem is
> absolutely one of system architecture and I don't know what Git can do
> other than to acknowledge it and recommend good patterns.

I was talking about (source) dependencies between
modules/projects/whatever-you-want-to-call-the-subcomponents of your
repository.  We have hundreds of modules, with various cross-module
dependencies that evolve over time.

I get the feeling from your description that your intra-repository
dependencies between modules/projects/whatever are much more static
for you than what we deal with.  (Which is a good thing; it'd be nice
if ours were more static.)

> In a properly-organized project, 95% of engineers in the project can have
> a small sparse-checkout, then 5% work on the common core that has these
> downstream dependencies and require a large sparse-checkout definition.

"In a properly-organized project"?  I'm unsure if this is an
indictment of some of the repositories I deal with in reality (and to
be fair, it might be a totally fair indictment), or if your statement
is starting to cross into "No true scotsman" territory.  ;-)

I would probably lean towards the former (we know it's more messy than
it should be), but I'm a bit puzzled that you'd just brush aside my
mention of integration tests.  We have people who want to run
integration tests locally, even when only modifying a small area of
the codebase.  These users are not doing cross-tree work, rather they
are doing cross-tree testing in conjunction with their work.  Running
such tests requires a build of the modules across the repository,
which naively would push folks into a dense checkout...and really long
local builds.  We want fast local builds, and sparse-checkouts help us
achieve that...but it does mean we have to be clever about how we
build in order to let these users run integration tests.  (And we have
to make it easy for users to discover the relevant integration tests,
and sometimes associated code components that depend on what they are
changing, which is where behavior B comes in).

> There's nothing Git can do to help those engineers that do cross-tree
> work.

I'm going to partially disagree with this, in part because of our
experience with many inter-module dependencies that evolve over time.
Folks can start on a certain module and begin refactoring.  Being
aware that their changes will affect other areas of the code, the can
do a search (e.g. "git grep --cached ..." to find cases outside their
current sparse checkout), and then selectively unsparsify to get the
relevant few dozen (or maybe even few hundred) modules added.  They
aren't switching to a dense checkout, just a less sparse one.  When
they are done, they may narrow their sparse specification again.  We
have a number of users doing cross-tree work who are using
sparse-checkouts, and who find it productive and say it still speeds
up their local build/test cycles.

So, I'd say that ensuring Git supports behavior B well in
sparse-checkouts, is something Git can do to help out both some of the
engineers doing cross-tree work, and some of the engineers that are
doing cross-tree testing.

(For full disclosure, we also have users doing cross-tree work using
regular dense checkouts and I agree there's not a lot we can do to
help them.)

> (nit: this is a good place to break up this paragraph.)

Yeah, it was kind of nice to have one paragraph per explanation of why
people might like behavior B.  But this is indeed a long paragraph.

[...]
> > +      * blame
> > +     * and annotate
>
> blame and annotate operate on a single path, so they already
> restrict within the sparse-checkout definition (unless the user
> specifies a path outside of the sparse-checkout). The only difference
> between A and B would be reporting an error if the path is outside the
> definition, right? We don't need to do anything special to simplify
> the history.

You're forgetting the possibility of one or more -C flags.  I'll note
it specifically on the line.

> > +      * show (when given commit arguments)
> > +      * log
> > +     * and variants: shortlog, gitk, show-branch, whatchanged
>
> And here is where we'd need to do that big changes for simplifying
> the history graph. Does 'rev-list' not fit here? I tend to think of
> 'log' as a formatting layer on top of 'rev-list', but maybe that is
> misguided.

Right, rev-list should probably be included here too.

> > +* Comands I don't know how to classify
>
> nit: s/Comands/Commands/

Thanks.

[...]
> > +=== Subcommand-dependent defaults ===
> > +
> > +Note that we have different defaults (for the desired behavior, not just
> > +the current implementation) depending on the command:
> > +
> > +  * Commands defaulting to --restrict:
>
> This appears to be the first mention of --restrict. Perhaps it would be
> worth declaring what --restrict, --restrict-unless-conflicts, and
> --no-restrict mean before creating this categorization?

Probably, yes.  Doing that might have even avoided some of the
confusion below...

[...]
> > +  * Commands defaulting to --restrict-unless-conflicts
> > +    * merge
> > +    * rebase
> > +    * cherry-pick
> > +    * revert
>
> In my mind, --restrict-unless-conflicts doesn't provide any value unless
> you want the --restrict mode to create an _error_ when trying to do
> something outside of the sparse-checkout cone.

Are you assuming here I was suggesting command line flags?  If so, I
apologize for my poor wording/descriptions.  At some point, I was just
noting that I was referring to behavior by the names of `--restrict`
and `--no-restrict`.  While pointing out that a strict interpretation
of the behaviors suggested by each name didn't match all commands, I
came up with names for alternate behaviors.  These names weren't meant
to become flags we'd use on the command line, despite the name that
perhaps suggests such.  Probably a really poor way to name these
behaviors; sorry about that.

Anyway, we do not want the behavior of `--restrict` for these
commands.  That would imply not providing conflicts to users for them
to resolve unless they are contained within the sparse specification,
which would clearly be broken.  We instead chose to write out files
with conflicts regardless of whether they are outside the sparse
specification.  This modified behavior I gave the name of
`--restrict-unless-conflict`, but we don't need or want an actual
command line flag for that.  I think the behavior should just remain
hardcoded into these commands.

(Note: these commands are among those that make me think
--[no-]restrict or --[un]focus or whatever might not make sense as a
git global option: `--restrict-unless-conflict` behavior is the
default for these and in fact that only sensible option, I think.  If
there's only one sensible option, no actual flag names are needed.)

> The only thing I can think about is that the diffstat might want to show
> the stats for the conflicted files, in which case that's an important
> perspective on the distinction from --restrict.

We only show the diffstat on a successful merge, so there's no
diffstat to show if there are any conflicted files.

> > +    In the case of am and apply, those commands only operate on the
> > +    working tree, so they are kind of in the same boat as stash.
> > +    Perhaps `git am` could run `git sparse-checkout reapply`
> > +    automatically afterward and move into a category more similar to
> > +    merge/rebase/cherry-pick, but it'd still be weird because it'd
> > +    vivify files besides just conflicted ones when there are conflicts.
>
> 'git am' should be able to construct the resulting commit from the patch
> without adding files outside of the sparse-checkout definition. If there

That's yet another interesting take on `git am` -- different than what
I originally had in mind, and different from what Junio suggested.  I
think both of your takes are better than what I was initially
thinking, I just wish your two approaches weren't pulling in opposite
directions.  :-)

> is a conflict, it fails in the application, anyway. I suppose you are
> writing this here because 'git am' does not play nice with sparse-checkout
> right now.

Well, as a result of this thread, we now have at least 2-3 potential
solutions we could pursue...

[...]
> > +    * add
> > +    * rm
> > +    * mv
> > +
> > +    The defaults here perhaps make sense since they are nearly --restrict, but
> > +    actually using --restrict could cause user confusion if users specify a
> > +    specific filename, so they warn by default.  That logic may sound like
> > +    --no-restrict should be the default, but that's prone to even bigger confusion:
> > +      * `git add <somefile>` if honored and outside the sparse cone, can result in
> > +     the file randomly disappearing later when some subsequent command is run
> > +     (since various commands automatically clean up unmodified files outside
> > +     the sparsity specification).
> > +      * `git rm '*.jpg'` could very negatively surprise users if it deletes files
> > +     outside the range of the user's interest.  Much better to operate on the
> > +     sparsity specification and give the user warnings if other files could have
> > +     matched.
>
> The cost of checking for other files that might match is sometimes too large
> (needing to expand the sparse index or walk trees to find those path names) that
> I would not recommend warning that we _didn't_ do something. Perhaps an advice
> that says "we did not look outside the sparse-checkout definition for matching
> paths" when the pathspec is not an exact path or a prefix match.

Ah, good point, and a good idea to keep in mind.

However, I think advise_on_updating_sparse_paths() currently does what
you're warning against.  Do you think there's a good chance this is
the cause of the performance bug reported over at
https://lore.kernel.org/git/CABPp-BEkJQoKZsQGCYioyga_uoDQ6iBeW+FKr8JhyuuTMK1RDw@mail.gmail.com
?

> > +  * Commands whose default for --restrict vs. --no-restrict should vary depending
> > +    on Behavior A or Behavior B
> > +    * diff (with --cached or REVISION arguments)
> > +    * grep (with --cached or REVISION arguments)
> > +    * show (when given commit arguments)
> > +    * bisect
> > +    * blame
> > +      * and annotate
> > +    * log
> > +      * and variants: shortlog, gitk, show-branch, whatchanged
> > +
> > +    For now, we default to behavior B for these, which want a default of
> > +    --no-restrict.
>
> I do feel pretty strongly that we'll want a --no-restrict default here
> because otherwise we will present confusion. I'm not even sure if we would
> want to make this available via a config setting, but likely a config
> setting makes sense in the long term.

You've got me slightly confused.  You did say the same thing a long time ago:

    "But I also want to avoid doing this as a default or even behind a
config setting."[A]

BUT, when Shaoxuan proposed making --restrict/--focus the default for
one of these commands, you seemed to be on board[B].

Personally, I thought that if anyone would object to some of these
commands changing, that grep would be considered as among the riskier.
For diff and log, printing a "Warning: restricting output to the
sparse-checkout specification" would be pretty innocuous, but for grep
that wouldn't be.

I was a little unsure about making `--restrict/--focus` the default
for these commands, both based on your previous concerns and because
of thinking about some of my behavior B users.  But then, it seemed
like everyone else was pushing for not only having this behavior but
making it the default[C,D,E,F].  I was beginning to wonder if even you
had decided behavior B didn't matter anymore between your support of
Shaoxuan's change at [B] and your diffstat comments at [G].  But now
it sounds like you're not only against behavior A by default but even
implementing it at all...even though I don't see how that squares with
your previous comments on grep and diffstat.

Is it just a matter of presentation?  Is it specific subcommands you
don't want changed?  Or am I either missing or misunderstanding
something?


Anyway...I will note that without a configurable option to give these
commands a behavior of `--restrict`, I think you make working in
disconnected partial clones practically impossible.  I want to be able
to do "git log -p", "git diff REV1 REV2", and "git grep TERM REV" in
disconnected partial clones, and I've wanted that kind of capability
for well over a decade[H].  So, don't be surprised if I keep bringing
up a config option of some sort for these commands.  :-)

[A] https://lore.kernel.org/git/1a1e33f6-3514-9afc-0a28-5a6b85bd8014@gmail.com/
[B] https://lore.kernel.org/git/e719d1e1-1849-07bc-ea08-2729985e5048@github.com/,
and the others in the thread
[C] https://lore.kernel.org/git/2fc889c9c264fc10d878f31bd89cc44e79982516.1599758167.git.matheus.bernardino@usp.br/
[D] paragraphs with "transitioning" in them from
https://lore.kernel.org/git/a89413b5-464b-2d54-5b8c-4502392afde8@github.com/
[E] https://lore.kernel.org/git/xmqqh719pcoo.fsf@gitster.g/
[F] https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/
[G] https://lore.kernel.org/git/a86af661-cf58-a4e5-0214-a67d3a794d7e@github.com/
[H] https://lore.kernel.org/git/1283645647-1891-1-git-send-email-newren@gmail.com/


> > +=== Implementation Questions ===
> > +
> > +  * Does the name --[no-]restrict sound good to others?  Are there better options?
> > +    * Names in use, or appearing in patches, or previously suggested:
> > +      * --sparse/--dense
> > +      * --ignore-skip-worktree-bits
> > +      * --ignore-skip-worktree-entries
> > +      * --ignore-sparsity
> > +      * --[no-]restrict-to-sparse-paths
> > +      * --full-tree/--sparse-tree
> > +      * --[no-]restrict
>
> I like the simplicity of --[no-]restrict, and my only worry is that it
> doesn't immediately link to what it is restricting.

Yeah, Junio and Victoria brought up other flavors of this same
concern, and it's also the one thing I find suboptimal about this
name.

The problem is just that we need to add the flag in more places,
"sparse" is already taken in some of them with a different meaning,
and I'm not sure there is any other flag that does automatically link
to sparse-checkouts and/or self-describe without being excessively
wordy.

> Perhaps something like "scope" would describe the set of things we care
> about, but use a text mode:
>
>         --scope=sparse  (--restrict)
>         --scope=all     (--no-restrict)
>
> But I'm notoriously bad at naming things.

Yeah, me too.  Naming things is one of the two hard problems in
computer science, right?  (The others being cache invalidation, and
off-by-one errors.)

However, in this case, your suggestion sounds pretty decent to me.
I'll add it to the list for us to consider.

> > +  * Should --[no-]restrict be a git global option, or added as options to each
> > +    relevant command?  (Does that make sense given the multitude of different
> > +    default behaviors we have for different options?)
>
> If we can make it a global option, that would be great, then update
> the commands to behave under that mode as we go.
>
> If that doesn't work, then adding the consistent option across commands
> would be helpful. It might be good to make a OPT_RESTRICT macro (much
> like OPT__VERBOSE, OPT__QUIET, and similar macros.

Ooh, I didn't know about OPT__VERBOSE and OPT__QUIET.  Thanks for the flag.

[...]
> > +  * clone: should we provide some mechanism for tying partial clones and
> > +    sparse checkouts together better.  Maybe an option
> > +     --sparse=dir1,dir2,...,dirN
> > +    which:
> > +       * Does initial fetch with `--filter=blob:none`
> > +       * Does the `sparse-checkout set --cone dir1 dir2 ... dirN` thing
> > +       * Runs a `git rev-list --objects --all -- dir1 dir2 ... dirN` to
> > +      fault in the missing blobs within the sparse
> > +      specification...except that rev-list needs some kind of options
> > +      to also get files from leading directories too.
> > +       * Sets --restrict mode to allow focusing on the cone of interest
> > +      (and to permit disconnected development)
>
> As mentioned, I think we should have the option to backfill the blobs in
> the sparse-checkout definition, but 'git clone' should not do this by
> default. It's something that can be launched in the background, maybe, but
> not a blocking operation on being able to use the repository.
>
> 'scalar clone' is an excellent testing bed for these kinds of things,
> like setting the --restrict mode by default.

Earlier in this same email you were against even making an option to
request --restrict mode, but now you're suggesting to not only
implement it but make it the default in scalar?

> Hopefully my responses aren't too far off-base. I'll go read the rest of
> the discussion now that I've contributed my thoughts on the doc.

Thanks for the detailed response!

I figured we'd have one or two places where all of us had some
disagreements on the big picture, but more and more I'm finding we
aren't even always thinking about the problems the same (e.g. the 3+
different solutions to the `am` issues).  All the more reason that a
document like this is important for us to discuss these details and
work out a plan.
