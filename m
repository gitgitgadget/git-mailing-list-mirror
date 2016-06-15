From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Wed, 23 Mar 2011 16:38:36 -0700
Message-ID: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 00:38:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Xdh-0001UI-4J
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 00:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346Ab1CWXiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 19:38:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab1CWXin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 19:38:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B13CF4705;
	Wed, 23 Mar 2011 19:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	OdmGYcyortqzpSwlcziZuhleB0=; b=xSz42ZoxuSXiQzoF+DDpudvbVlRXqAFKX
	i2TR5HLPFXR7uBNridgQyEITQDPjVYwSotplx7YqXp2EaAwu62jFK76WsRPCQn9N
	EpcMWFm9277HUIQGOm9vdKnD7foE4GxuTxZRopbLcntCu4CBaMgA0U3MH+CVZk1s
	MVTUuSElyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=O5Q
	wfIkDMxu7ScIU+yGWXmu9XrRRnlQWY6JlbN8KUPLSe5QPGRusvd7Hp9huLmyBGDP
	drjU+uc1X4QMeuqAbJSmA4uRYn45AQei0Ro8AY7VrUzV0YBSiWlELmaTy5/kMGzJ
	fcF8Yp9B1c036ZsTciIAQbOertv9HsqAwTjpRyj8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9E48C4703;
	Wed, 23 Mar 2011 19:40:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5B3CF4701; Wed, 23 Mar 2011
 19:40:18 -0400 (EDT)
X-master-at: cd3065f9e3c27594a91540e971d147f1acba89de
X-next-at: 46300131fe1c0c8ebcb394416c551a5f8fa38342
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA529C34-55A6-11E0-B928-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169879>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I notice that there are too many stalled topics, for which only the
"finishing touches" are the missing pieces. These new "features" and
"usability" that were discussed, tried, and then abandoned are things that
we survived without so far, so in that sense I do not see very strong need
for me to step in and clean them up alone, losing my beauty sleep time.

But it is a shame to see all the discussions and efforts go to waste when
we are this (shows the thumb and the index finger almost touching)
close. Discussing new features may be more fun, but please, people, let's
start wrapping things up for this cycle.

--------------------------------------------------
[New Topics]

* jc/diff-dotdot (2011-03-23) 2 commits
 - warn use of "git diff A..B"
 - diff: remove dead code that flips arguments order

This is 1/4 tongue-in-cheek but mostly serious.

* jk/progress-with-pager (2011-03-23) 3 commits
 - show: turn on rename progress
 - progress: use pager's original_stderr if available
 - pager: save the original stderr when redirecting to pager

The bottom two feel like a right thing to do, but "show" may not be a
right example.

--------------------------------------------------
[Graduated to "master"]

* jc/maint-diff-q-filter (2011-03-16) 1 commit
  (merged to 'next' on 2011-03-20 at d3d85dc)
 + diff --quiet: disable optimization when --diff-filter=X is used

* jn/fortify-source-workaround (2011-03-16) 1 commit
  (merged to 'next' on 2011-03-20 at 69c4ceb)
 + run-command: prettify -D_FORTIFY_SOURCE workaround

* jn/maint-c99-format (2011-03-16) 2 commits
  (merged to 'next' on 2011-03-20 at 65cbc8c)
 + unbreak and eliminate NO_C99_FORMAT
 + mktag: avoid %td in format string

* kc/gitweb-pathinfo-w-anchor (2011-03-18) 1 commit
  (merged to 'next' on 2011-03-20 at 2d65786)
 + gitweb: fix #patchNN anchors when path_info is enabled

* lt/default-abbrev (2011-03-20) 2 commits
  (merged to 'next' on 2011-03-20 at 17ed457)
 + Rename core.abbrevlength back to core.abbrev
  (merged to 'next' on 2011-03-17 at 1d7e406)
 + Make the default abbrev length configurable

The configuration roughly corresponds to --abbrev command line option, so
I should rename it back to core.abbrev as Linus originally named it.
Will merge to 'master'.

* pk/stash-apply-status-relative (2011-03-14) 2 commits
  (merged to 'next' on 2011-03-20 at 232b096)
 + Add test: git stash shows status relative to current dir
 + git stash: show status relative to current directory

* pw/p4 (2011-03-16) 2 commits
  (merged to 'next' on 2011-03-20 at fdad818)
 + git-p4: test sync new branch
 + git-p4: fix sync new branch regression

--------------------------------------------------
[Stalled]

* jc/add-u-migration (2011-03-22) 3 commits
 - add: make "add -u/-A" update full tree without pathspec (step 3)
 - add: make "add -u/-A" update full tree without pathspec (step 2)
 - add: make "add -u/-A" update full tree without pathspec

The message in the bottom one really needs proofreading to move this topic
forward. Of course, perhaps nobody cares enough (even though many people
seem to have complained about the current behaviour) and we may end up
discarding this topic. We'll see.

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way? I've been wanting to move this forward for quite some time but
also hoping somebody else would send in a final version.

* mz/rebase (2011-02-28) 34 commits
 - rebase: define options in OPTIONS_SPEC
  (merged to 'next' on 2011-02-25 at 52caa7a)
 + Makefile: do not install sourced rebase scripts
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

I think the tip one is a response to J6t's regression concerns; it looked
Ok to me.

* jc/diff-irreversible-delete (2011-02-28) 1 commit
 - git diff -D: omit the preimage of deletes

"diff -B -D" should omit the deleting half of a broken pair from the
output.  Need documentation and tests.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

It seems that we need separate parsers for these two formats in order not
to regress the users of the original cvs.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP, and will not be ready for 1.7.5. Need to put histogram output
into index-pack --verify to really kill verify-pack.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jk/edit-notes-in-commit-log (2011-03-07) 2 commits
 - [wip] commit: allow editing notes in commit message editor
 - notes: make expand_notes_ref globally accessible

* mg/grep-full-tree (2011-03-01) 2 commits
 - grep: make --full-tree work with pathspecs
 - grep: --full-tree

Do not merge; it would be preferable to use ":/" or whatever magic
pathspec that is relative to the root of the working tree.

--------------------------------------------------
[Cooking]

* jc/maint-rerere-in-workdir (2011-03-10) 1 commit
  (merged to 'next' on 2011-03-23 at e5ef1a2)
 + rerere: make sure it works even in a workdir attached to a young repository

Resurrected, as this was originally written with the explicit goal of
helping contrib/workdir/git-new-workdir users, and it is good enough to
only support absolute symbolic links for that purpose.

* jk/checkout-orphan-warning (2011-03-20) 3 commits
  (merged to 'next' on 2011-03-23 at 26adae6)
 + checkout: tweak detached-orphan warning format
 + checkout: clear commit marks after detached-orphan check
 + checkout: add basic tests for detached-orphan warning

* mg/rev-list-n-parents (2011-03-23) 3 commits
  (merged to 'next' on 2011-03-23 at 8baa059)
 + rev-list --min-parents,--max-parents: doc, test and completion
 + revision.c: introduce --min-parents and --max-parents options
 + t6009: use test_commit() from test-lib.sh

Rerolled with --no-max-parents and the like.

* jc/index-update-if-able (2011-03-21) 2 commits
  (merged to 'next' on 2011-03-23 at e7e071a)
 + update $GIT_INDEX_FILE when there are racily clean entries
 + diff/status: refactor opportunistic index update

* jp/completion-help-alias (2011-03-21) 1 commit
  (merged to 'next' on 2011-03-23 at e21fa7b)
 + git-completion: Add git help completion for aliases

* js/remove-unused-variables (2011-03-22) 1 commit
  (merged to 'next' on 2011-03-23 at 4630013)
 + Remove unused variables

* sb/sparse-more (2011-03-21) 1 commit
  (merged to 'next' on 2011-03-23 at 4bec1d1)
 + Makefile: Cover more files with make check

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
 - diffcore-rename: fall back to -C when -C -C busts the rename limit
 - diffcore-rename: record filepair for rename src
 - diffcore-rename: refactor "too many candidates" logic
 - builtin/diff.c: remove duplicated call to diff_result_code()

Took another look and even wrote tests, but it turns out that it needed
rebasing on bf0ab10 (merge: improve inexact rename limit warning,
2011-02-19), as that commit didn't anticipate that we may want this
warning outside merge-recursive codepath.  The top one ended up
larger than it should have been as a result.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

* jc/fetch-progressive-stride (2011-03-20) 3 commits
  (merged to 'next' on 2011-03-20 at 2917b19)
 + fetch-pack: use smaller handshake window for initial request
 + fetch-pack: progressively use larger handshake windows
 + fetch-pack: factor out hardcoded handshake window size

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-03-18 at a32016b)
 + merge-recursive: tweak magic band-aid
  (merged to 'next' on 2011-03-09 at 3762932)
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

I am not happy with these magic band aids.

* nd/init-gitdir (2011-03-19) 2 commits
 - init, clone: support --separate-git-dir for .git file
 - git-init.txt: move description section up

* jl/submodule-fetch-on-demand (2011-03-06) 7 commits
  (merged to 'next' on 2011-03-20 at a5e452d)
 + fetch/pull: Describe --recurse-submodule restrictions in the BUGS section
 + submodule update: Don't fetch when the submodule commit is already present
 + fetch/pull: Don't recurse into a submodule when commits are already present
 + Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' option
 + config: teach the fetch.recurseSubmodules option the 'on-demand' value
 + fetch/pull: Add the 'on-demand' value to the --recurse-submodules option
 + fetch/pull: recurse into submodules when necessary

* ss/git-gui-mergetool (2011-02-26) 2 commits
  (merged to 'next' on 2011-03-17 at a8fac18)
 + mergetool--lib: Add Beyond Compare 3 as a tool
 + mergetool--lib: Sort tools alphabetically for easier lookup

The CLI side (ss/mergetool--lib topic) will be in the next release, so
I've pinged Pat to take this into gut-gui tree.

* nd/index-doc (2011-03-01) 2 commits
  (merged to 'next' on 2011-03-23 at 316cafc)
 + doc: technical details about the index file format
 + doc: technical details about the index file format

* ab/i18n-st (2011-02-22) 69 commits
  (merged to 'next' on 2011-03-23 at e2732e2)
 + i18n: git-shortlog basic messages
 + i18n: git-revert split up "could not revert/apply" message
 + i18n: git-revert literal "me" messages
 + i18n: git-revert "Your local changes" message
 + i18n: git-revert basic messages
 + i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 + i18n: git-notes basic commands
 + i18n: git-gc "Auto packing the repository" message
 + i18n: git-gc basic messages
 + i18n: git-describe basic messages
 + i18n: git-clean clean.requireForce messages
 + i18n: git-clean basic messages
 + i18n: git-bundle basic messages
 + i18n: git-archive basic messages
 + i18n: git-status "renamed: " message
 + i18n: git-status "Initial commit" message
 + i18n: git-status "Changes to be committed" message
 + i18n: git-status shortstatus messages
 + i18n: git-status "nothing to commit" messages
 + i18n: git-status basic messages
 + i18n: git-push "prevent you from losing" message
 + i18n: git-push basic messages
 + i18n: git-tag tag_template message
 + i18n: git-tag basic messages
 + i18n: git-reset "Unstaged changes after reset" message
 + i18n: git-reset reset_type_names messages
 + i18n: git-reset basic messages
 + i18n: git-rm basic messages
 + i18n: git-mv "bad" messages
 + i18n: git-mv basic messages
 + i18n: git-merge "Wonderful" message
 + i18n: git-merge "You have not concluded your merge" messages
 + i18n: git-merge "Updating %s..%s" message
 + i18n: git-merge basic messages
 + i18n: git-log "--OPT does not make sense" messages
 + i18n: git-log basic messages
 + i18n: git-grep "--open-files-in-pager" message
 + i18n: git-grep basic messages
 + i18n: git-fetch split up "(non-fast-forward)" message
 + i18n: git-fetch update_local_ref messages
 + i18n: git-fetch formatting messages
 + i18n: git-fetch basic messages
 + i18n: git-diff basic messages
 + i18n: git-commit advice messages
 + i18n: git-commit "enter the commit message" message
 + i18n: git-commit print_summary messages
 + i18n: git-commit formatting messages
 + i18n: git-commit "middle of a merge" message
 + i18n: git-commit basic messages
 + i18n: git-checkout "Switched to a .. branch" message
 + i18n: git-checkout "HEAD is now at" message
 + i18n: git-checkout describe_detached_head messages
 + i18n: git-checkout: our/their version message
 + i18n: git-checkout basic messages
 + i18n: git-branch "(no branch)" message
 + i18n: git-branch "git branch -v" messages
 + i18n: git-branch "Deleted branch [...]" message
 + i18n: git-branch "remote branch '%s' not found" message
 + i18n: git-branch basic messages
 + i18n: git-add "Unstaged changes" message
 + i18n: git-add "remove '%s'" message
 + i18n: git-add "did not match any files" message
 + i18n: git-add "The following paths are ignored" message
 + i18n: git-add basic messages
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone "Cloning into" message
 + i18n: git-clone basic messages
 + i18n: git-init "Initialized [...] repository" message
 + i18n: git-init basic messages

Now in 'next'.
