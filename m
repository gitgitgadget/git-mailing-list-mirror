From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2013, #01; Mon, 1)
Date: Mon, 01 Jul 2013 15:21:50 -0700
Message-ID: <7v38rxapkx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 00:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmTv-0004xJ-9E
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab3GAWVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:21:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755748Ab3GAWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:21:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D75112D859;
	Mon,  1 Jul 2013 22:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	vDjKNOXU+Y3Fvpa+HApiePFiZQ=; b=vvnfHdA9HXZlE8Adcet3vypWaoeRf9/xV
	swZPZkjoRMk3kZ/3bnMdIqH/b+DLVWAEvVl+O1G6Z2Cfy33UstMmnP+AKf1b6qIv
	JqeoOVGvs6ib81Qhnde6sdWnX2qvUVf/kVS5H8WeYnCwBKSXHOZcpHr4NOTz99wF
	BmWZly5+qM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vRz
	irR+w7QjTXxgLEgF8VWs8+XwO+BeRCDcD8PXEFZronwOSy8EfkymZYK6cDM9CAbS
	13PcZFQTlN0zOLu8PquDNFDAZl6fC0TKjP55ARmrr9ZdopnBhBpnEqLxEt/+Sd5u
	Xeuqw/jAB91Q2qxH5Fj+KP/bOO4w4lMcdzrDSHQE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE10C2D858;
	Mon,  1 Jul 2013 22:21:52 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B5A52D855;
	Mon,  1 Jul 2013 22:21:51 +0000 (UTC)
X-master-at: 8c4e4ec3ff053331c845331645a437b01b1f0de6
X-next-at: 27cfd277767dfcdf40973f837d71a02664df5d01
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0D77720-E29C-11E2-B4DB-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229343>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

We are in the middle of 5th week now in the 11-week releace cycle
for 1.8.4, and quite a few topics have graduated to 'master'.
Please help ensure the quality of the upcoming release by testing
the tip of 'master' (and if you are so inclined, 'next') early.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/diff-ignore-blank-lines (2013-06-19) 1 commit
  (merged to 'next' on 2013-06-23 at 9cf8e03)
 + diff: add --ignore-blank-lines option

 "git diff" learned a mode that ignores hunks whose change consists
 only of additions and removals of blank lines, which is the same as
 "diff -B" (ignore blank lines) of GNU diff.


* ap/rebase-multiple-fixups (2013-06-27) 1 commit
  (merged to 'next' on 2013-06-28 at c3d1b1e)
 + rebase -i: handle fixup! fixup! in --autosquash

 Having multiple "fixup!" on a line in the rebase instruction sheet
 did not work very well with "git rebase -i --autosquash".


* ed/color-prompt (2013-06-26) 5 commits
  (merged to 'next' on 2013-06-28 at 334892c)
 + git-prompt.sh: add missing information in comments
 + git-prompt.sh: do not print duplicate clean color code
 + t9903: remove redundant tests
 + git-prompt.sh: refactor colored prompt code
 + t9903: add tests for git-prompt pcmode

 Code clean-up for in-prompt status script (in contrib/).


* ft/doc-git-transport (2013-06-26) 1 commit
  (merged to 'next' on 2013-06-27 at 4a7d248)
 + documentation: add git:// transport security notice


* jc/topo-author-date-sort (2013-06-21) 9 commits
  (merged to 'next' on 2013-06-26 at 9283719)
 + t6003: add --author-date-order test
 + topology tests: teach a helper to set author dates as well
 + t6003: add --date-order test
 + topology tests: teach a helper to take abbreviated timestamps
 + t/lib-t6000: style fixes
  (merged to 'next' on 2013-06-15 at ad4fb48)
 + log: --author-date-order
 + sort-in-topological-order: use prio-queue
 + prio-queue: priority queue of pointers to structs
 + toposort: rename "lifo" field
 (this branch uses jk/commit-info-slab; is tangled with jc/show-branch.)

 "git log" learned the "--author-date-order" option, with which the
 output is topologically sorted and commits in parallel histories
 are shown intermixed together based on the author timestamp.


* jk/commit-info-slab (2013-06-07) 3 commits
  (merged to 'next' on 2013-06-15 at 908ab93)
 + commit-slab: introduce a macro to define a slab for new type
 + commit-slab: avoid large realloc
 + commit: allow associating auxiliary info on-demand
 (this branch is used by jc/show-branch and jc/topo-author-date-sort.)

 Allow adding custom information to commit objects in order to
 represent unbound number of flag bits etc.


* jk/submodule-subdirectory-ok (2013-06-17) 6 commits
  (merged to 'next' on 2013-06-23 at f17fb37)
 + submodule: drop the top-level requirement
 + rev-parse: add --prefix option
 + submodule: show full path in error message
 + t7403: add missing && chaining
 + t7403: modernize style
 + t7401: make indentation consistent

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.


* kb/am-deprecate-resolved (2013-06-27) 1 commit
  (merged to 'next' on 2013-06-28 at 177f491)
 + am: replace uses of --resolved with --continue

 Promote "git am --continue" over "git am --resolved" for UI
 consistency.


* mh/loose-refs-race-with-pack-ref (2013-06-19) 3 commits
  (merged to 'next' on 2013-06-23 at 2099d0b)
 + resolve_ref_unsafe(): close race condition reading loose refs
 + resolve_ref_unsafe(): handle the case of an SHA-1 within loop
 + resolve_ref_unsafe(): extract function handle_missing_loose_ref()

 We read loose and packed rerferences in two steps, but after
 deciding to read a loose ref but before actually opening it to read
 it, another process racing with us can unlink it, which would cause
 us to barf. Update the codepath to retry when such a race is
 detected.


* mh/ref-races (2013-06-20) 11 commits
  (merged to 'next' on 2013-06-23 at 71f1a18)
 + for_each_ref: load all loose refs before packed refs
 + get_packed_ref_cache: reload packed-refs file when it changes
 + add a stat_validity struct
 + Extract a struct stat_data from cache_entry
 + packed_ref_cache: increment refcount when locked
 + do_for_each_entry(): increment the packed refs cache refcount
 + refs: manage lifetime of packed refs cache via reference counting
 + refs: implement simple transactions for the packed-refs file
 + refs: wrap the packed refs cache in a level of indirection
 + pack_refs(): split creation of packed refs and entry writing
 + repack_without_ref(): split list curation and entry writing
 (this branch is used by mh/ref-races-optim-invalidate-cached.)

 "git pack-refs" that races with new ref creation or deletion have
 been susceptible to lossage of refs under right conditions, which
 has been tightened up.


* nk/name-rev-abbreviated-refs (2013-06-18) 1 commit
  (merged to 'next' on 2013-06-23 at 2ec9e05)
 + name-rev: allow to specify a subpath for --refs option

 "git name-rev --refs=tags/v*" were forbidden, which was a bit
 inconvenient (you had to give a pattern to match refs fully, like
 --refs=refs/tags/v*).


* rr/column-doc (2013-06-26) 1 commit
  (merged to 'next' on 2013-06-27 at 99497e1)
 + column doc: rewrite documentation for column.ui


* rr/remote-branch-config-refresh (2013-06-23) 9 commits
  (merged to 'next' on 2013-06-26 at 48746e1)
 + t/t5505-remote: test multiple push/pull in remotes-file
 + ls-remote doc: don't encourage use of branches-file
 + ls-remote doc: rewrite <repository> paragraph
 + ls-remote doc: fix example invocation on git.git
 + t/t5505-remote: test url-with-# in branches-file
 + remote: remove dead code in read_branches_file()
 + t/t5505-remote: use test_path_is_missing
 + t/t5505-remote: test push-refspec in branches-file
 + t/t5505-remote: modernize style

 The original way to specify remote repository using .git/branches/
 used to have a nifty feature.  The code to support the feature was
 still in a function but the caller was changed not to call it 5
 years ago, breaking that feature and leaving the supporting code
 unreachable.


* sb/mailmap-merijn-brand (2013-06-25) 1 commit
  (merged to 'next' on 2013-06-27 at 2dd247a)
 + .mailmap: Map "H.Merijn Brand" to "H. Merijn Brand"


* sg/bash-prompt (2013-06-24) 16 commits
  (merged to 'next' on 2013-06-27 at 09fda6a)
 + bash prompt: mention that PROMPT_COMMAND mode is faster
 + bash prompt: avoid command substitution when finalizing gitstring
 + bash prompt: avoid command substitution when checking for untracked files
 + bash prompt: use bash builtins to check stash state
 + bash prompt: use bash builtins to check for unborn branch for dirty state
 + bash prompt: combine 'git rev-parse' for detached head
 + bash prompt: combine 'git rev-parse' executions in the main code path
 + bash prompt: use bash builtins to find out current branch
 + bash prompt: use bash builtins to find out rebase state
 + bash prompt: run 'git rev-parse --git-dir' directly instead of __gitdir()
 + bash prompt: return early from __git_ps1() when not in a git repository
 + bash prompt: print unique detached HEAD abbreviated object name
 + bash prompt: add a test for symbolic link symbolic refs
 + completion, bash prompt: move __gitdir() tests to completion test suite
 + bash prompt: use 'write_script' helper in interactive rebase test
 + bash prompt: fix redirection coding style in tests


* wk/doc-in-linux-3.x-era (2013-06-22) 4 commits
  (merged to 'next' on 2013-06-26 at a24e9e6)
 + Documentation: Update 'linux-2.6.git' -> 'linux.git'
 + Documentation: Update the NFS remote examples to use the staging repo
 + doc/clone: Pick more compelling paths for the --reference example
 + doc/clone: Remove the '--bare -l -s' example

 Update documentation to match more recent realities.

--------------------------------------------------
[New Topics]

* pb/stash-refuse-to-kill (2013-07-01) 2 commits
 - git stash: avoid data loss when "git stash save" kills a directory
 - treat_directory(): do not declare submodules to be untracked

 "git stash save" is not just about "saving" the local changes, but
 also is to restore the working tree state to that of HEAD. If you
 changed a non-directory into a directory in the local change, you
 may have untracked files in that directory, which have to be killed
 while doing so, unless you run it with --include-untracked.  Teach
 the command to detect and error out before spreading the damage.

 This needed a small fix to "ls-files --killed".

 Will merge to 'next' after waiting for a few days.


* es/contacts (2013-06-30) 4 commits
 - contrib: contacts: interpret committish akin to format-patch
 - contrib: contacts: add ability to parse from committish
 - contrib: contacts: add support for multiple patches
 - contrib: add git-contacts helper

 Waiting for more discussion.


* jk/bash-completion (2013-06-30) 2 commits
  (merged to 'next' on 2013-07-01 at 6daca44)
 + completion: learn about --man-path
 + completion: handle unstuck form of base git options

 Will merge to 'master'.


* cp/submodule-custom-update (2013-07-01) 1 commit
 - submodule update: allow custom command to update submodule working tree

 In addition to the choice from "rebase, merge, or checkout-detach",
 allow a custom command to be used in "submodule update" to update
 the working tree of submodules.

 Needs to be reviewed.


* mv/merge-ff-tristate (2013-07-01) 1 commit
 - merge: handle --ff/--no-ff/--ff-only as a tri-state option

 The configuration variable "merge.ff" was cleary a tri-state to
 choose one from "favor fast-forward when possible", "always create
 a merge even when the history could fast-forward" and "do not
 create any merge, only update when the history fast-forwards", but
 the command line parser did not implement the usual convention of
 "last one wins, and command line overrides the configuration"
 correctly.

 Needs to be reviewed.


* rr/rebase-reflog-message-reword (2013-06-23) 2 commits
 - rebase -i: use a better reflog message
 - rebase: use a better reflog message
 (this branch uses rr/rebase-checkout-reflog.)

 Split from the other topic.

--------------------------------------------------
[Stalled]

* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data source
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Waiting for a reroll.
 $gmane/223964


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* jl/submodule-mv (2013-04-23) 5 commits
 - submodule.c: duplicate real_path's return value
 - rm: delete .gitmodules entry of submodules removed from the work tree
 - Teach mv to update the path entry in .gitmodules for moved submodules
 - Teach mv to move submodules using a gitfile
 - Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Waiting for a reroll.
 $gmane/226294


* jk/list-objects-sans-blobs (2013-06-06) 4 commits
 . archive: ignore blob objects when checking reachability
 . list-objects: optimize "revs->blob_objects = 0" case
 . upload-archive: restrict remote objects with reachability check
 . clear parsed flag when we free tree buffers

 Attempt to allow "archive --remote=$there $arbitrary_sha1" while
 keeping the reachability safety.

 Seems to break some tests in a trivial and obvious way.


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* bp/mediawiki-preview (2013-06-26) 5 commits
 - git-remote-mediawiki: Add preview subcommand into git mw.
 - git-remote-mediawiki: Adding git-mw command
 - git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
 - git-remote-mediawiki: new git bin-wrapper for developement
 - git-remote-mediawiki: Introduction of Git::Mediawiki.pm

 Still under discussion?


* fg/submodule-clone-depth (2013-06-28) 1 commit
 - Add --depth to submodule update/add

 Allow shallow-cloning of submodules with "git submodule update".

 Waiting for a reroll.
 $gmane/229248


* jc/pull-training-wheel (2013-06-27) 1 commit
 - pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" refuse with "it does not fast forward; choose between
 'pull --merge' and 'pull --rebase'".

 John Keeping seems to want to restrict this to "git pull" without
 any other argument. I personally do not have a strong opinion
 either way, but I'm inclined to take such a patch to loosen the new
 logic with other people's support.  Hint, hint...


* as/log-output-encoding-in-user-format (2013-07-01) 6 commits
  (merged to 'next' on 2013-07-01 at 3318aa8)
 + t4205: replace .\+ with ..* in sed commands
  (merged to 'next' on 2013-06-28 at 4063330)
 + pretty: --format output should honor logOutputEncoding
 + pretty: Add failing tests: --format output should honor logOutputEncoding
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs
 + t7102 (reset): don't hardcode SHA-1 in expected outputs
 + t6006 (rev-list-format): don't hardcode SHA-1 in expected outputs

 "log --format=" did not honor i18n.logoutputencoding configuration
 and this is a beginning of the series that attempts to fix it.

 Will merge to 'master'.


* jc/maint-diff-core-safecrlf (2013-06-25) 1 commit
 - diff: demote core.safecrlf=true to core.safecrlf=warn

 "git diff" refused to even show difference when core.safecrlf is
 set to true (i.e. error out) and there are offending lines in the
 working tree files.

 Will merge to 'next'.


* jk/fast-import-empty-ls (2013-06-23) 4 commits
 - fast-import: allow moving the root tree
 - fast-import: allow ls or filecopy of the root tree
 - fast-import: set valid mode on root tree in "ls"
 - t9300: document fast-import empty path issues

 Waiting for reviews.
 $gmane/228741


* af/rebase-i-merge-options (2013-06-25) 2 commits
 - SQUASH???
 - Do not ignore merge options in interactive rebase

 "git rebase -i" now honors --strategy and -X options.

 Waiting for response to review comments.
 $gmane/228988


* rj/cygwin-remove-cheating-lstat (2013-06-25) 1 commit
 - cygwin: Remove the Win32 l/stat() implementation

 Seems that this gives different performance results to different
 people.

 A replacement WIP has been posted.
 $gmane/229280


* jc/triangle-push-fixup (2013-06-24) 5 commits
  (merged to 'next' on 2013-06-26 at 73cbb69)
 + t/t5528-push-default: test pushdefault workflows
 + t/t5528-push-default: generalize test_push_*
 + push: change `simple` to accommodate triangular workflows
 + config doc: rewrite push.default section
 + t/t5528-push-default: remove redundant test_config lines
 (this branch is tangled with rr/triangle-push-fix.)

 Earlier remote.pushdefault (and per-branch branch.*.pushremote)
 were introduced as an additional mechanism to choose what
 repository to push into when "git push" did not say it from the
 command line, to help people who push to a repository that is
 different from where they fetch from.  This attempts to finish that
 topic by teaching the default mechanism to choose branch in the
 remote repository to be updated by such a push.

 The 'current', 'matching' and 'nothing' modes (specified by the
 push.default configuration variable) extend to such a "triangular"
 workflow naturally, but 'upstream' and 'simple' have to be updated.

 . 'upstream' is about pushing back to update the branch in the
 remote repository that the current branch fetches from and
 integrates with, it errors out in a triangular workflow.

 . 'simple' is meant to help new people by avoiding mistakes, and
 will be the safe default in Git 2.0.  In a non-triangular
 workflow, it will continue to act as a cross between 'upstream'
 and 'current' in that it pushes to the current branch's
 @{upstream} only when it is set to the same name as the current
 branch (e.g. your 'master' forks from the 'master' from the
 central repository).  In a triangular workflow, this series
 tentatively defines it as the same as 'current', but we may have
 to tighten it to avoid surprises in some way.


* jg/status-config (2013-06-24) 4 commits
 - status/commit: make sure --porcelain is not affected by user-facing config
 - commit: make it work with status.short
 - status: introduce status.branch to enable --branch by default
 - status: introduce status.short to enable --short by default

 "git status" learned status.branch and status.short configuration
 variables to use --branch and --short options by default (override
 with --no-branch and --no-short options from the command line).

 The bottom two has been graduated to 'master' but then reverted.
 The tip two are quick attempts to fix the fallout.  The one for
 status.short looks correct; the other one, while it is correct,
 is unfortunately overly complex in order not to introduce an
 unnecessary regression.

 Will merge to 'next'.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* mh/ref-races-optim-invalidate-cached (2013-06-20) 1 commit
 - refs: do not invalidate the packed-refs cache unnecessarily

 This requires the platform lstat() to be correct to avoid false
 negatives.


* rr/rebase-checkout-reflog (2013-06-17) 5 commits
  (merged to 'next' on 2013-07-01 at 27cfd27)
 + checkout: respect GIT_REFLOG_ACTION
  (merged to 'next' on 2013-06-27 at 4d99efa)
 + status: do not depend on rebase reflog messages
 + t/t2021-checkout-last: "checkout -" should work after a rebase finishes
 + wt-status: remove unused field in grab_1st_switch_cbdata
 + t7512: test "detached from" as well
 (this branch is used by rr/rebase-reflog-message-reword.)

 Invocations of "git checkout" used internally by "git rebase" were
 counted as "checkout", and affected later "git checkout -" to the
 the user to an unexpected place.

 The "bugfix" bits of the series is here.  The follow-up part to
 reword reflog messages for steps in "rebase" are split to another
 topic.

 Will merge to 'master'.


* jx/clean-interactive (2013-06-26) 16 commits
 - test: run testcases with POSIX absolute paths on Windows
 - test: add t7301 for git-clean--interactive
 - git-clean: add documentation for interactive git-clean
 - git-clean: add ask each interactive action
 - git-clean: add select by numbers interactive action
 - git-clean: add filter by pattern interactive action
 - git-clean: use a git-add-interactive compatible UI
 - git-clean: add colors to interactive git-clean
 - git-clean: show items of del_list in columns
 - git-clean: add support for -i/--interactive
  (merged to 'next' on 2013-06-26 at f7be2d8)
 + git-clean: refactor git-clean into two phases
 + write_name{_quoted_relative,}(): remove redundant parameters
 + quote_path_relative(): remove redundant parameter
 + quote.c: substitute path_relative with relative_path
 + path.c: refactor relative_path(), not only strip prefix
 + test: add test cases for relative_path

 Add "interactive" mode to "git clean".

 The early part to refactor relative path related helper functions
 looked sensible. The actual "clean interactive" may want to be
 discussed further by interested parties before the topic is fully
 merged to 'next'.


* tr/test-v-and-v-subtest-only (2013-06-29) 9 commits
  (merged to 'next' on 2013-06-30 at 1c5fac1)
 + perf-lib: fix start/stop of perf tests
  (merged to 'next' on 2013-06-26 at 8ff4d84)
 + test-lib: support running tests under valgrind in parallel
 + test-lib: allow prefixing a custom string before "ok N" etc.
 + test-lib: valgrind for only tests matching a pattern
 + test-lib: verbose mode for only tests matching a pattern
 + test-lib: self-test that --verbose works
 + test-lib: rearrange start/end of test_expect_* and test_skip
 + test-lib: refactor $GIT_SKIP_TESTS matching
 + test-lib: enable MALLOC_* for the actual tests

 Allows N instances of tests run in parallel, each running 1/N parts
 of the test suite under Valgrind, to speed things up.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.

--------------------------------------------------
[Discarded]

* rr/complete-difftool (2013-06-09) 3 commits
  (merged to 'next' on 2013-06-09 at 2ee40cb)
 + Revert 77c1305 and 3c3b46b
  (merged to 'next' on 2013-06-07 at 90e5f58)
 + completion: add deprecated __git_complete_file ()
  (merged to 'next' on 2013-06-04 at 01c7611)
 + completion: clarify ls-tree, archive, show completion

 Update command line completion (in contrib/) to use a better named
 completion helper function for commands that take revisions and
 paths.

 Reverted, to be replaced with rr/complete-difftool-fixup.


* fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
 - remote-helpers: add exec-path links
 - remote-helpers: allow direct test execution
 - remote-helpers: rename tests
 - remote-helpers: generate scripts

 Retracted.


* jk/packed-refs-race (2013-05-06) 4 commits
 . for_each_ref: load all loose refs before packed refs
 . get_packed_refs: reload packed-refs file when it changes
 . add a stat_validity struct
 . resolve_ref: close race condition for packed refs

 Superseded by mh/ref-races topic, I think.


* rr/triangle-push-fix (2013-06-20) 9 commits
 . push: honor branch.*.push
 . SQUASH??? fix git-config push.default description
 . SQUASH??? minimum "simple" safety fix-up
 . t/t5528-push-default: test pushdefault workflows
 . t/t5528-push-default: generalize test_push_*
 . push: remove dead code in setup_push_upstream()
 . push: change `simple` to accommodate triangular workflows
 . config doc: rewrite push.default section
 + t/t5528-push-default: remove redundant test_config lines
 (this branch is tangled with jc/triangle-push-fixup.)

 Superseded by jc/triangle-push-fixup.
