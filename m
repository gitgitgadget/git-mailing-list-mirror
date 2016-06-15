From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2011, #01; Fri, 2)
Date: Fri, 02 Dec 2011 12:30:04 -0800
Message-ID: <7vzkfan2cz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 21:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWZkP-0007Es-GQ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 21:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab1LBUaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 15:30:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab1LBUaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 15:30:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35A2A6EB4;
	Fri,  2 Dec 2011 15:30:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	lRJRCYf9V3U/+z0VeNm5eWnW3U=; b=fANMsCeYTZPpRSimqidlMy7IN4Hvd4Nuz
	yIQ6pOWKBm5OdaReFF1vg1zRo80LpNI0Ie/6kPnkd7pjdldCU970FakuclQk2XOq
	3G+3SSSzcX5M7t3LiTrh1LNbMPsOZJxs8NKD8tbJLdurctFLznI70ulIHbniY/sq
	ebbHXSKsHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=XCU
	XCEuYudVjPGlphV908ba9ONhzKci+b0V9ODGopYKGOpHjD541QzYcG+ds3hhM6oD
	LPfP3Vm7b7OGbc7P8MvqBJl9P6vptLsMcg2YhF9qK6L87lCNgeHfPCWPcquqG0Ub
	avPBQHKChI+noP3dHtXxRiF+OIepNo37YE45fEx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 293C46EB3;
	Fri,  2 Dec 2011 15:30:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1057C6EB2; Fri,  2 Dec 2011
 15:30:05 -0500 (EST)
X-master-at: 406da7803217998ff6bf5dc69c55b1613556c2f4
X-next-at: 56e79320f3d9b044c380dfebf136584aaa17ac5b
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BB363B8-1D24-11E1-89CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186240>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Now that 1.7.8 is tagged, I'll start planning to rewind 'next' by kicking
topics back to 'pu' and/or dropping them, but let's give the new release a
couple of days of calm.

Here are the repositories that have my integration branches:

With maint, master, next, pu, todo:

        git://git.kernel.org/pub/scm/git/git.git
        git://repo.or.cz/alt-git.git
        https://code.google.com/p/git-core/
        https://github.com/git/git

With only maint and master:

        git://git.sourceforge.jp/gitroot/git-core/git.git
        git://git-core.git.sourceforge.net/gitroot/git-core/git-core

With all the topics and integration branches:

        https://github.com/gitster/git

The preformatted documentation in HTML and man format are found in:

        git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
        git://repo.or.cz/git-{htmldocs,manpages}.git/
        https://code.google.com/p/git-{htmldocs,manpages}.git/
        https://github.com/gitster/git-{htmldocs,manpages}.git/

--------------------------------------------------
[New Topics]

* aw/rebase-i-stop-on-failure-to-amend (2011-11-30) 1 commit
 - rebase -i: interrupt rebase when "commit --amend" failed during "reword"

* jc/split-blob (2011-12-01) 6 commits
 . WIP (streaming chunked)
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding
 (this branch uses jc/stream-to-pack.)

* jh/fast-import-notes (2011-11-28) 3 commits
 - fast-import: Fix incorrect fanout level when modifying existing notes refs
 - t9301: Add 2nd testcase exposing bugs in fast-import's notes fanout handling
 - t9301: Fix testcase covering up a bug in fast-import's notes fanout handling

* ld/p4-labels-branches (2011-11-30) 4 commits
 - git-p4: importing labels should cope with missing owner
 - git-p4: add test for p4 labels
 - git-p4: cope with labels with empty descriptions
 - git-p4: handle p4 branches and labels containing shell chars

Retracted?

* tj/maint-imap-send-remove-unused (2011-11-23) 2 commits
 - Merge branch 'maint' into tj/imap-send-remove-unused
 - imap-send: Remove unused 'use_namespace' variable

--------------------------------------------------
[Stalled]

* hv/submodule-merge-search (2011-10-13) 4 commits
 - submodule.c: make two functions static
 - allow multiple calls to submodule merge search for the same path
 - push: Don't push a repository with unpushed submodules
 - push: teach --recurse-submodules the on-demand option

What the topic aims to achieve may make sense, but the implementation
looked somewhat suboptimal.

* sg/complete-refs (2011-10-21) 9 commits
  (merged to 'next' on 2011-10-26 at d65e2b4)
 + completion: remove broken dead code from __git_heads() and __git_tags()
 + completion: fast initial completion for config 'remote.*.fetch' value
 + completion: improve ls-remote output filtering in __git_refs_remotes()
 + completion: query only refs/heads/ in __git_refs_remotes()
 + completion: support full refs from remote repositories
 + completion: improve ls-remote output filtering in __git_refs()
 + completion: make refs completion consistent for local and remote repos
 + completion: optimize refs completion
 + completion: document __gitcomp()

Needs an Ack or two from completion folks before going forward.

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content

See comments on sr/fix-fast-export-tips topic.

* sr/fix-fast-export-tips (2011-11-05) 3 commits
 - fast-export: output reset command for commandline revs
 - fast-export: do not refer to non-existing marks
 - t9350: point out that refs are not updated correctly

The bottom commit from the stalled sr/transport-helper-fix-rfc topic is
fixed with this. It may make sense to drop the other topic and include
that commit in this series.

The command line parser is still too lax and accepts malformed input, but
this is a step in the right direction and tightening the command line now
should be doable without a low level surgery that touches codepaths that
are unrelated to the command line processing like the previous attempt
used to do.

* jc/lookup-object-hash (2011-08-11) 6 commits
 - object hash: replace linear probing with 4-way cuckoo hashing
 - object hash: we know the table size is a power of two
 - object hash: next_size() helper for readability
 - pack-objects --count-only
 - object.c: remove duplicated code for object hashing
 - object.c: code movement for readability

I do not think there is anything fundamentally wrong with this series, but
the risk of breakage far outweighs observed performance gain in one
particular workload.

* jc/verbose-checkout (2011-10-16) 2 commits
 - checkout -v: give full status output after switching branches
 - checkout: move the local changes report to the end

This is just to leave a record that the reason why we do not do this not
because we are incapable of coding this, but because it is not a good idea
to do this. I suspect people who are new to git that might think they need
it would soon realize the don't.

Will drop.

* eh/grep-scale-to-cpunum (2011-11-05) 1 commit
 - grep: detect number of CPUs for thread spawning

Kills I/O parallelism and needs to be improved or discarded.

* jc/commit-tree-extra (2011-11-12) 2 commits
 - commit-tree: teach -C <extra-commit>
 - commit-tree: teach -x <extra>
 (this branch uses jc/pull-signed-tag; is tangled with jc/signed-commit.)

Not absolutely needed; parked in 'pu' but may drop.

* cb/daemon-permission-errors (2011-10-17) 2 commits
 - daemon: report permission denied error to clients
 - daemon: add tests

The tip commit might be loosening things a bit too much.

--------------------------------------------------
[Cooking]

* cn/maint-lf-to-crlf-filter (2011-11-28) 1 commit
 - convert: track state in LF-to-CRLF filter

Candidate for early next cycle.

* nd/maint-ignore-exclude (2011-11-28) 1 commit
 - checkout,merge: loosen overwriting untracked file check based on info/exclude
 (this branch is used by nd/ignore-might-be-precious.)

Candidate for early next cycle.

* vr/git-merge-doc (2011-11-21) 1 commit
 - Show error for 'git merge' with unset merge.defaultToUpstream

Candidate for early next cycle.

* jn/branch-move-to-self (2011-11-28) 2 commits
 - Allow checkout -B <current-branch> to update the current branch
 - branch: allow a no-op "branch -M <current-branch> HEAD"

Candidate for early next cycle.

* jk/credentials (2011-11-28) 20 commits
 - fixup! 034c066e
 - compat/getpass: add a /dev/tty implementation
 - credential: use git_prompt instead of git_getpass
 - prompt: add PROMPT_ECHO flag
 - stub out getpass_echo function
 - refactor git_getpass into generic prompt function
 - move git_getpass to its own source file
 - t: add test harness for external credential helpers
 - credentials: add "store" helper
 - strbuf: add strbuf_add*_urlencode
 - credentials: add "cache" helper
 - docs: end-user documentation for the credential subsystem
 - credential: make relevance of http path configurable
 - credential: add credential.*.username
 - credential: apply helper config
 - http: use credential API to get passwords
 - credential: add function for parsing url components
 - introduce credentials API
 - t5550: fix typo
 - test-lib: add test_config_global variant

* nd/ignore-might-be-precious (2011-11-28) 2 commits
 - checkout,merge: disallow overwriting ignored files with --no-overwrite-ignore
 - Merge branch 'nd/maint-ignore-exclude' into nd/ignore-might-be-precious
 (this branch uses nd/maint-ignore-exclude.)

* jk/upload-archive-use-start-command (2011-11-21) 1 commit
 - upload-archive: use start_command instead of fork

* jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
 - archive: don't let remote clients get unreachable commits
 (this branch is used by jk/maint-upload-archive.)

* jk/maint-upload-archive (2011-11-21) 1 commit
 - Merge branch 'jk/maint-1.6.2-upload-archive' into jk/maint-upload-archive
 (this branch uses jk/maint-1.6.2-upload-archive.)

* jk/refresh-porcelain-output (2011-11-18) 3 commits
  (merged to 'next' on 2011-11-18 at 872f25e)
 + refresh_index: make porcelain output more specific
 + refresh_index: rename format variables
 + read-cache: let refresh_cache_ent pass up changed flags

* ab/enable-i18n (2011-11-18) 1 commit
 - i18n: add infrastructure for translating Git with gettext

* gh/userdiff-matlab (2011-11-15) 1 commit
  (merged to 'next' on 2011-11-18 at 10cd275)
 + Add built-in diff patterns for MATLAB code

* jc/maint-pack-object-cycle (2011-11-16) 1 commit
  (merged to 'next' on 2011-11-18 at 3715a81)
 + pack-object: tolerate broken packs that have duplicated objects

Make the client side more robust against bogus pack stream; the problem
was discovered by accident while repacking a clone obtained from somewhat
buggy test server.

* jc/index-pack-reject-dups (2011-11-16) 1 commit
  (merged to 'next' on 2011-11-18 at 2090221)
 + receive-pack, fetch-pack: reject bogus pack that records objects twice

And this is the prevention to reject such pack stream in the first place.

* nd/resolve-ref (2011-11-13) 2 commits
  (merged to 'next' on 2011-11-18 at 8e17b34)
 + Copy resolve_ref() return value for longer use
 + Convert many resolve_ref() calls to read_ref*() and ref_exists()

A fix for an error-reporting codepath that is not a regression, that
turned into a patch that touches many callsite.

* vr/msvc (2011-10-31) 3 commits
  (merged to 'next' on 2011-11-14 at f46d021)
 + MSVC: Remove unneeded header stubs
 + Compile fix for MSVC: Include <io.h>
 + Compile fix for MSVC: Do not include sys/resources.h

* na/strtoimax (2011-11-05) 3 commits
  (merged to 'next' on 2011-11-14 at b64e1cb)
 + Support sizes >=2G in various config options accepting 'g' sizes.
 + Compatibility: declare strtoimax() under NO_STRTOUMAX
 + Add strtoimax() compatibility function.

* jc/signed-commit (2011-11-29) 5 commits
 - gpg-interface: allow use of a custom GPG binary
 - pretty: %G[?GS] placeholders
 - test "commit -S" and "log --show-signature"
 - log: --show-signature
 - commit: teach --gpg-sign option
 (this branch uses jc/pull-signed-tag; is tangled with jc/commit-tree-extra.)

Rebased on top of jc/pull-signed-tag topic, after reverting the old one
out of 'next'.

* jc/pull-signed-tag (2011-11-12) 15 commits
  (merged to 'next' on 2011-11-14 at 25e8838)
 + commit-tree: teach -m/-F options to read logs from elsewhere
 + commit-tree: update the command line parsing
 + commit: teach --amend to carry forward extra headers
 + merge: force edit and no-ff mode when merging a tag object
 + commit: copy merged signed tags to headers of merge commit
 + merge: record tag objects without peeling in MERGE_HEAD
 + merge: make usage of commit->util more extensible
 + fmt-merge-msg: Add contents of merged tag in the merge message
 + fmt-merge-msg: package options into a structure
 + fmt-merge-msg: avoid early returns
 + refs DWIMmery: use the same rule for both "git fetch" and others
 + fetch: allow "git fetch $there v1.0" to fetch a tag
 + merge: notice local merging of tags and keep it unwrapped
 + fetch: do not store peeled tag object names in FETCH_HEAD
 + Split GPG interface into its own helper library
 (this branch is used by jc/commit-tree-extra and jc/signed-commit.)

Further updated to allow "commit --amend" to retain the mergetag
headers. I think this is ready for the cycle after upcoming 1.7.8.

* jc/request-pull-show-head-4 (2011-11-09) 12 commits
  (merged to 'next' on 2011-11-13 at e473fd2)
 + request-pull: use the annotated tag contents
  (merged to 'next' on 2011-10-15 at 7e340ff)
 + fmt-merge-msg.c: Fix an "dubious one-bit signed bitfield" sparse error
  (merged to 'next' on 2011-10-10 at 092175e)
 + environment.c: Fix an sparse "symbol not declared" warning
 + builtin/log.c: Fix an "Using plain integer as NULL pointer" warning
  (merged to 'next' on 2011-10-07 at fcaeca0)
 + fmt-merge-msg: use branch.$name.description
  (merged to 'next' on 2011-10-06 at fa5e0fe)
 + request-pull: use the branch description
 + request-pull: state what commit to expect
 + request-pull: modernize style
 + branch: teach --edit-description option
 + format-patch: use branch description in cover letter
 + branch: add read_branch_desc() helper function
 + Merge branch 'bk/ancestry-path' into jc/branch-desc

Allow setting "description" for branches and use it to help communications
between humans in various workflow elements. It also allows requesting for
a signed tag to be pulled and shows the tag message in the generated message.

* ab/clang-lints (2011-11-06) 2 commits
  (merged to 'next' on 2011-11-13 at a573aec)
 + cast variable in call to free() in builtin/diff.c and submodule.c
 + apply: get rid of useless x < 0 comparison on a size_t type

* ab/pull-rebase-config (2011-11-07) 1 commit
  (merged to 'next' on 2011-11-13 at 72bb2d5)
 + pull: introduce a pull.rebase option to enable --rebase

* nd/fsck-progress (2011-11-06) 4 commits
  (merged to 'next' on 2011-11-13 at 8831811)
 + fsck: print progress
 + fsck: avoid reading every object twice
 + verify_packfile(): check as many object as possible in a pack
 + fsck: return error code when verify_pack() goes wrong

* nd/prune-progress (2011-11-07) 3 commits
  (merged to 'next' on 2011-11-13 at c5722ac)
 + reachable: per-object progress
 + prune: handle --progress/no-progress
 + prune: show progress while marking reachable objects

* jc/stream-to-pack (2011-12-01) 5 commits
 - bulk-checkin: replace fast-import based implementation
 - csum-file: introduce sha1file_checkpoint
 - finish_tmp_packfile(): a helper function
 - create_tmp_packfile(): a helper function
 - write_pack_header(): a helper function
 (this branch is used by jc/split-blob.)

Teaches "git add" to send large-ish blob data straight to a packfile.
This is a continuation to the "large file support" topic. The codepath to
move data from worktree to repository is made aware of streaming, just
like the checkout codepath that goes the other way, which was done in the
previous "large file support" topic in the 1.7.7 cycle.

* jn/gitweb-side-by-side-diff (2011-10-31) 8 commits
 - gitweb: Add navigation to select side-by-side diff
 - gitweb: Use href(-replay=>1,...) for formats links in "commitdiff"
 - t9500: Add basic sanity tests for side-by-side diff in gitweb
 - t9500: Add test for handling incomplete lines in diff by gitweb
 - gitweb: Give side-by-side diff extra CSS styling
 - gitweb: Add a feature to show side-by-side diff
 - gitweb: Extract formatting of diff chunk header
 - gitweb: Refactor diff body line classification

Replaces a series from Kato Kazuyoshi on the same topic.

* mf/curl-select-fdset (2011-11-04) 4 commits
  (merged to 'next' on 2011-11-06 at a49516f)
 + http: drop "local" member from request struct
 + http.c: Rely on select instead of tracking whether data was received
 + http.c: Use timeout suggested by curl instead of fixed 50ms timeout
 + http.c: Use curl_multi_fdset to select on curl fds instead of just sleeping

Reduces unnecessary waits.

* nd/misc-cleanups (2011-10-27) 6 commits
  (merged to 'next' on 2011-10-28 at 2527a49)
 + unpack_object_header_buffer(): clear the size field upon error
 + tree_entry_interesting: make use of local pointer "item"
 + tree_entry_interesting(): give meaningful names to return values
 + read_directory_recursive: reduce one indentation level
 + get_tree_entry(): do not call find_tree_entry() on an empty tree
 + tree-walk.c: do not leak internal structure in tree_entry_len()

These are unquestionably good parts taken out of a larger series, so that
we can focus more on the other changes in later rounds of review.

* rs/allocate-cache-entry-individually (2011-10-26) 2 commits
  (merged to 'next' on 2011-10-27 at 2e4acd6)
 + cache.h: put single NUL at end of struct cache_entry
 + read-cache.c: allocate index entries individually

* mh/ref-api-3 (2011-11-16) 26 commits
  (merged to 'next' on 2011-11-16 at cc76151)
 + refs: loosen over-strict "format" check
  (merged to 'next' on 2011-10-23 at 92e2d35)
 + is_refname_available(): reimplement using do_for_each_ref_in_array()
 + names_conflict(): simplify implementation
 + names_conflict(): new function, extracted from is_refname_available()
 + repack_without_ref(): reimplement using do_for_each_ref_in_array()
 + do_for_each_ref_in_array(): new function
 + do_for_each_ref(): correctly terminate while processesing extra_refs
 + add_ref(): take a (struct ref_entry *) parameter
 + create_ref_entry(): extract function from add_ref()
 + parse_ref_line(): add a check that the refname is properly formatted
 + repack_without_ref(): remove temporary
 + Rename another local variable name -> refname
  (merged to 'next' on 2011-10-19 at cc89f0e)
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 + cache.h: add comments for git_path() and git_path_submodule()
 (this branch is tangled with mh/ref-api-2.)

* rr/revert-cherry-pick (2011-10-23) 5 commits
  (merged to 'next' on 2011-10-26 at 27b7496)
 + revert: simplify communicating command-line arguments
 + revert: allow mixed pick and revert instructions
 + revert: make commit subjects in insn sheet optional
 + revert: simplify getting commit subject in format_todo()
 + revert: free msg in format_todo()

The internals of "git revert/cherry-pick" has been further refactored to
serve as the basis for the sequencer.

* mh/ref-api-2 (2011-11-16) 15 commits
  (merged to 'next' on 2011-11-16 at 511457f)
 + refs: loosen over-strict "format" check
  (merged to 'next' on 2011-10-19 at cc89f0e)
 + resolve_gitlink_ref_recursive(): change to work with struct ref_cache
 + Pass a (ref_cache *) to the resolve_gitlink_*() helper functions
 + resolve_gitlink_ref(): improve docstring
 + get_ref_dir(): change signature
 + refs: change signatures of get_packed_refs() and get_loose_refs()
 + is_dup_ref(): extract function from sort_ref_array()
 + add_ref(): add docstring
 + parse_ref_line(): add docstring
 + is_refname_available(): remove the "quiet" argument
 + clear_ref_array(): rename from free_ref_array()
 + refs: rename parameters result -> sha1
 + refs: rename "refname" variables
 + struct ref_entry: document name member
 + cache.h: add comments for git_path() and git_path_submodule()
 (this branch is tangled with mh/ref-api-3.)
