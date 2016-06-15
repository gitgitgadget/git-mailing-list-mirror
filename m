From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2011, #03; Tue, 22)
Date: Tue, 22 Mar 2011 22:50:46 -0700
Message-ID: <7vfwqegzbd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 06:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2GyD-0007Vd-8I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 06:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab1CWFuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 01:50:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33634 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab1CWFux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 01:50:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F26D123D9;
	Wed, 23 Mar 2011 01:52:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	QGDOmAGdlQr1RVlS4LIIV47Ivo=; b=T2gZX88mlHeoJ2oTxN8aPrXDIMRddF3M5
	ik7ruKjQiZDf94vgeFdn86JuQvEk9InJ5Lbm+ggpWwuTCwMYWlHCl/tp0CZfd6dD
	eMPn10TI1lYsjbppBESU6q0CTXJLWctHsd14SKJtYUQNXsQrgRhQeDOKRA6tfMz2
	ndyZokW9PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Erk
	ooZBFgxbos/onVUX7fhZQeAWoXPsF2YOrMfyFKFqPHQOCm4zNz27ReRKTNCvBbmV
	GHnWoeE24NelFvozMhf20KMow1zvmpXtpE8SKuXPa8JgHI5CWeYeqrmNeobeRx7z
	Zi1of0tplK8jmPfcEcaFnUQ8wiFRcka7NbSiIU7U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD8A723D8;
	Wed, 23 Mar 2011 01:52:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F5EB23C7; Wed, 23 Mar 2011
 01:52:28 -0400 (EDT)
X-master-at: 5e839c8f6d5edfaf0d2250f3c9628a238e24c6be
X-next-at: 18336960f038eb2d7d5eb883b2967c8e38bedc3e
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDCA8158-5511-11E0-A5A9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169801>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I notice that there are too many stalled topics, for which only the
"finishing touches" are the missing pieces. These new "features" and
"usability" that were discussed, tried, and then abandoned are things that
we survived without so far, so in that sense I do not see very strong need
for me to step in and clean them up alone, shaving my beauty sleep time.

But it is a shame to see all the discussions and efforts go to waste when
we are this (shows the thumb and the index finger almost touching)
close. Discussing new features may be more fun, but please, people, let's
start wrapping things up for this cycle.

--------------------------------------------------
[Graduated to "master"]

* jc/maint-fetch-alt (2011-03-11) 2 commits
  (merged to 'next' on 2011-03-17 at c61ec4f)
 + fetch-pack: objects in our alternates are available to us
 + refs_from_alternate: helper to use refs from alternates

* jc/maint-rev-list-culled-boundary (2011-03-14) 1 commit
  (merged to 'next' on 2011-03-17 at 001b546)
 + list-objects.c: don't add an unparsed NULL as a pending tree

* jn/test-sanitize-git-env (2011-03-15) 5 commits
  (merged to 'next' on 2011-03-17 at 80a3678)
 + tests: scrub environment of GIT_* variables
 + config: drop support for GIT_CONFIG_NOGLOBAL
 + gitattributes: drop support for GIT_ATTR_NOGLOBAL
 + tests: suppress system gitattributes
 + tests: stop worrying about obsolete environment variables

* js/maint-stash-index-copy (2011-03-16) 2 commits
  (merged to 'next' on 2011-03-17 at 9f74cc8)
 + stash: copy the index using --index-output instead of cp -p
 + stash: fix incorrect quoting in cleanup of temporary files

* mg/doc-bisect-tweak-worktree (2011-03-15) 2 commits
  (merged to 'next' on 2011-03-17 at e0acf52)
 + git-bisect.txt: example for bisecting with hot-fix
 + git-bisect.txt: streamline run presentation

* mg/rev-list-one-side-only (2011-03-10) 10 commits
  (merged to 'next' on 2011-03-10 at 2a69869)
 + git-log: put space after commit mark
 + t6007: test rev-list --cherry
 + log --cherry: a synonym
 + rev-list: documentation and test for --cherry-mark
 + revision.c: introduce --cherry-mark
 + rev-list/log: factor out revision mark generation
 + rev-list: --left/right-only are mutually exclusive
 + rev-list: documentation and test for --left/right-only
 + t6007: Make sure we test --cherry-pick
 + revlist.c: introduce --left/right-only for unsymmetric picking
 (this branch is used by mg/rev-list-n-parents.)

* sg/complete-symmetric-diff (2011-03-10) 2 commits
  (merged to 'next' on 2011-03-17 at adb0618)
 + bash: complete 'git diff ...branc<TAB>'
 + bash: fix misindented esac statement in __git_complete_file()

* sp/maint-fetch-pack-stop-early (2011-03-14) 2 commits
  (merged to 'next' on 2011-03-17 at 2580068)
 + fetch-pack: Implement no-done capability
 + fetch-pack: Finish negotation if remote replies "ACK %s ready"
 (this branch is used by jc/fetch-progressive-stride.)

* sp/maint-upload-pack-stop-early (2011-03-14) 2 commits
  (merged to 'next' on 2011-03-17 at e717a84)
 + upload-pack: Implement no-done capability
 + upload-pack: More aggressively send 'ACK %s ready'

* tl/p4 (2011-03-15) 3 commits
  (merged to 'next' on 2011-03-17 at 3d7f69f)
 + git-p4: Fix error message crash in P4Sync.commit.
 + Teach git-p4 to ignore case in perforce filenames if configured.
 + git-p4: Teach gitConfig method about arguments.

--------------------------------------------------
[New Topics]

* jc/add-u-migration (2011-03-22) 3 commits
 - add: make "add -u/-A" update full tree without pathspec (step 3)
 - add: make "add -u/-A" update full tree without pathspec (step 2)
 - add: make "add -u/-A" update full tree without pathspec

The earlier one was a flawed migration path. We would probably need
per-user preference after all.

* jk/checkout-orphan-warning (2011-03-20) 3 commits
 - checkout: tweak detached-orphan warning format
 - checkout: clear commit marks after detached-orphan check
 - checkout: add basic tests for detached-orphan warning

Will merge to 'next'.

* mg/rev-list-n-parents (2011-03-21) 3 commits
 - rev-list --min-parents,--max-parents: doc, test and completion
 - revision.c: introduce --min-parents and --max-parents options
 - t6009: use test_commit() from test-lib.sh

Perhaps will wait until the "infinity" syntax settles.

* jc/index-update-if-able (2011-03-21) 2 commits
 - update $GIT_INDEX_FILE when there are racily clean entries
 - diff/status: refactor opportunistic index update

* jp/completion-help-alias (2011-03-21) 1 commit
 - git-completion: Add git help completion for aliases

* js/remove-unused-variables (2011-03-22) 1 commit
 - Remove unused variables

* sb/sparse-more (2011-03-21) 1 commit
 - Makefile: Cover more files with make check

--------------------------------------------------
[Stalled]

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

* jc/maint-rerere-in-workdir (2011-03-10) 1 commit
 - rerere: make sure it works even in a workdir attached to a young repository

Do not merge; needs more thought around relative symlinks.

--------------------------------------------------
[Cooking]

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

Will merge to 'master'.

* cn/system-path-tweak (2011-03-17) 1 commit
 - system_path: use a static buffer

* jc/fetch-progressive-stride (2011-03-20) 3 commits
  (merged to 'next' on 2011-03-20 at 2917b19)
 + fetch-pack: use smaller handshake window for initial request
 + fetch-pack: progressively use larger handshake windows
 + fetch-pack: factor out hardcoded handshake window size

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

* pw/p4 (2011-03-16) 2 commits
  (merged to 'next' on 2011-03-20 at fdad818)
 + git-p4: test sync new branch
 + git-p4: fix sync new branch regression

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

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Will merge to 'next'.

* ab/i18n-st (2011-02-22) 69 commits
 - i18n: git-shortlog basic messages
 - i18n: git-revert split up "could not revert/apply" message
 - i18n: git-revert literal "me" messages
 - i18n: git-revert "Your local changes" message
 - i18n: git-revert basic messages
 - i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 - i18n: git-notes basic commands
 - i18n: git-gc "Auto packing the repository" message
 - i18n: git-gc basic messages
 - i18n: git-describe basic messages
 - i18n: git-clean clean.requireForce messages
 - i18n: git-clean basic messages
 - i18n: git-bundle basic messages
 - i18n: git-archive basic messages
 - i18n: git-status "renamed: " message
 - i18n: git-status "Initial commit" message
 - i18n: git-status "Changes to be committed" message
 - i18n: git-status shortstatus messages
 - i18n: git-status "nothing to commit" messages
 - i18n: git-status basic messages
 - i18n: git-push "prevent you from losing" message
 - i18n: git-push basic messages
 - i18n: git-tag tag_template message
 - i18n: git-tag basic messages
 - i18n: git-reset "Unstaged changes after reset" message
 - i18n: git-reset reset_type_names messages
 - i18n: git-reset basic messages
 - i18n: git-rm basic messages
 - i18n: git-mv "bad" messages
 - i18n: git-mv basic messages
 - i18n: git-merge "Wonderful" message
 - i18n: git-merge "You have not concluded your merge" messages
 - i18n: git-merge "Updating %s..%s" message
 - i18n: git-merge basic messages
 - i18n: git-log "--OPT does not make sense" messages
 - i18n: git-log basic messages
 - i18n: git-grep "--open-files-in-pager" message
 - i18n: git-grep basic messages
 - i18n: git-fetch split up "(non-fast-forward)" message
 - i18n: git-fetch update_local_ref messages
 - i18n: git-fetch formatting messages
 - i18n: git-fetch basic messages
 - i18n: git-diff basic messages
 - i18n: git-commit advice messages
 - i18n: git-commit "enter the commit message" message
 - i18n: git-commit print_summary messages
 - i18n: git-commit formatting messages
 - i18n: git-commit "middle of a merge" message
 - i18n: git-commit basic messages
 - i18n: git-checkout "Switched to a .. branch" message
 - i18n: git-checkout "HEAD is now at" message
 - i18n: git-checkout describe_detached_head messages
 - i18n: git-checkout: our/their version message
 - i18n: git-checkout basic messages
 - i18n: git-branch "(no branch)" message
 - i18n: git-branch "git branch -v" messages
 - i18n: git-branch "Deleted branch [...]" message
 - i18n: git-branch "remote branch '%s' not found" message
 - i18n: git-branch basic messages
 - i18n: git-add "Unstaged changes" message
 - i18n: git-add "remove '%s'" message
 - i18n: git-add "did not match any files" message
 - i18n: git-add "The following paths are ignored" message
 - i18n: git-add basic messages
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone basic messages
 - i18n: git-init "Initialized [...] repository" message
 - i18n: git-init basic messages

--------------------------------------------------
[Discarded]

* nd/rfc-add-u-full-tree (2011-02-07) 1 commit
 - add: make "add -u" update full tree without pathspec

See jc/add-u-migration.
