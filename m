From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2015, #01; Thu, 2)
Date: Thu, 02 Apr 2015 15:09:43 -0700
Message-ID: <xmqqbnj6gp20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 00:09:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdnJD-0005pJ-IV
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 00:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbbDBWJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 18:09:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752922AbbDBWJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 18:09:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B922744301;
	Thu,  2 Apr 2015 18:09:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=7
	IM11F58qTvEh2nZHp2Ux7gb5BI=; b=T7mJU54Nw8JKjRKe2EIDD3R6o9l1IW9Mk
	av/c7ltxyNE6KKF7jUIECsTIkOYSZkE9jafRnC7MWVQXhDF6BTTM29w3ei43cNER
	MZZKlViuYVETsV+TttTdjOp7gjmTNTXbYxs1dsDwctoltxCzvO8RG74A8+xsk4Fd
	+1NaapWAO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WTT
	kTTyKxWxYn688cX6VCLvLOtVIoEPTq/RekR+S3WOZPUz0Sbj22EuMZ4EHDVnlZ0A
	x0mWyCJy7Ui/h5D0QK8eS4yG+doIf8lr0hcbGp+1C9mTCIpapB6wLpCp/dUva0Gz
	Vb8OdVyhJ+U05Z6AgnvKlAVxWDq2trgn7TexrG0U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AFD8C44300;
	Thu,  2 Apr 2015 18:09:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3446442FF;
	Thu,  2 Apr 2015 18:09:44 -0400 (EDT)
X-master-at: 6ae0d972664134b82a6dd164a01e8adbebeaffe3
X-next-at: 85735d76ca4ac11dd4059dfd973b4df8b42f8776
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F807BA7E-D984-11E4-BF7B-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266687>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The first release candidate 2.4-rc1 has been tagged.  I'll still
take small and trivial fixes and documentation updates but let's
really shift our focus to find and fix (or revert) regressions
that may have happened during this cycle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* va/fix-git-p4-tests (2015-03-28) 2 commits
 - git-p4: fix copy detection test
 - t9814: fix broken shell syntax in git-p4 rename test

 Test fixes for git-p4

 Will merge to 'next'.


* va/p4-client-path (2015-03-28) 2 commits
 - git-p4: improve client path detection when branches are used
 - t9801: check git-p4's branch detection and client view together

 Attempt to better handle branches in perforce by git p4
 Reviews by git-p4 experts are very much appreciated.


* iu/fix-parse-options-h-comment (2015-03-29) 1 commit
  (merged to 'next' on 2015-04-02 at 7fd3cef)
 + parse-options.h: OPTION_{BIT,SET_INT} do not store pointer to defval

 Will merge to 'master'.


* jk/at-push-sha1 (2015-03-31) 6 commits
 - sha1_name: implement @{push} shorthand
 - sha1_name: refactor upstream_mark
 - remote.c: provide per-branch pushremote name
 - remote.c: hoist branch.*.remote lookup out of remote_get_1
 - remote.c: drop "remote" pointer from "struct branch"
 - remote.c: drop default_remote_name variable


* jk/cherry-pick-docfix (2015-03-30) 1 commit
  (merged to 'next' on 2015-04-02 at 40da1d7)
 + cherry-pick: fix docs describing handling of empty commits

 Will merge to 'master'.


* jk/sha1-file-reduce-useless-warnings (2015-03-30) 1 commit
 - sha1_file: squelch "packfile cannot be accessed" warnings


* jz/gitweb-conf-doc-fix (2015-03-31) 1 commit
  (merged to 'next' on 2015-04-02 at 237d1bc)
 + gitweb.conf.txt: say "build-time", not "built-time"

 Will merge to 'master'.


* mh/show-branch-topic (2015-03-31) 1 commit
 - show-branch: show all local heads when only giving one rev along --topics

 "git show-branch --topics HEAD" (with no other arguments) did not
 do anything interesting.  Instead, contrast the given revision
 against all the local branches by default.

 Will merge to 'next'.


* pt/enter-repo-comment-fix (2015-03-31) 1 commit
  (merged to 'next' on 2015-04-02 at 276ad7e)
 + enter_repo(): fix docs to match code

 Will merge to 'master'.


* sb/line-log-plug-pairdiff-leak (2015-03-30) 1 commit
 - line-log.c: fix a memleak

 Will merge to 'next'.


* sb/plug-wt-shortstatus-tracking-leak (2015-03-30) 1 commit
 - wt-status.c: fix a memleak

 Will merge to 'next'.


* jc/push-cert (2015-04-02) 1 commit
 - push --signed: tighten what the receiving end can ask to sign

 The "git push --signed" protocol extension did not limit what the
 "nonce" that is a server-chosen string can contain or how long it
 can be, which was unnecessarily lax.  Limit both the length and the
 alphabet to a reasonably small space that can still have enough
 entropy.

 Will merge to 'next'.


* jc/update-instead-into-void (2015-04-01) 1 commit
 - push-to-deploy: allow pushing into an unborn branch and updating it

 A push into an unborn branch, with "receive.denyCurrentBranch" set
 to "updateInstead", did not check out the working tree as expected.

 Will merge to 'next'.


* jk/init-core-worktree-at-root (2015-04-02) 1 commit
 - init: don't set core.worktree when initializing /.git

 We avoid setting core.worktree when the repository location is the
 ".git" directory directly at the top level of the working tree, but
 the code misdetected the case in which the working tree is at the
 root level of the filesystem (which arguably is a silly thing to
 do, but still valid).

 Will merge to 'next'.


* jk/pack-corruption-post-mortem (2015-04-01) 1 commit
 - howto: document more tools for recovery corruption

 Documentation update.

 Will merge to 'next'.


* jn/doc-fast-import-no-16-octopus-limit (2015-03-31) 1 commit
 - fast-import doc: remove suggested 16-parent limit

 Documentation update.

 Will merge to 'next'.


* sb/plug-streaming-leak (2015-03-31) 1 commit
 - streaming.c: fix a memleak

 Will merge to 'next'.


* ts/checkout-advice-plural (2015-04-01) 1 commit
 - checkout: call a single commit $B!H(Bit$B!I(B instead of $B!H(Bth

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* ph/push-doc-cas (2015-03-26) 1 commit
  (merged to 'next' on 2015-03-27 at 0737697)
 + git-push.txt: clean up force-with-lease wording

 Documentation update.


* sb/leaks (2015-03-24) 10 commits
  (merged to 'next' on 2015-03-24 at bdbc0c7)
 + http: release the memory of a http pack request as well
  (merged to 'next' on 2015-03-23 at 5397daf)
 + read-cache: fix memleak
 + add_to_index(): free unused cache-entry
 + commit.c: fix a memory leak
 + http-push: remove unneeded cleanup
 + merge-recursive: fix memleaks
 + merge-blobs.c: fix a memleak
 + builtin/apply.c: fix a memleak
 + update-index: fix a memleak
 + read-cache: free cache entry in add_to_index in case of early return

 Plug minor memory leaks everywhere.


* ss/pull-rebase-preserve (2015-03-30) 2 commits
 + docs: clarify what git-rebase's "-p" / "--preserve-merges" does
 + docs: clarify "preserve" option wording for git-pull

 Documentation update.

--------------------------------------------------
[Stalled]

* as/userdiff-sh (2015-03-13) 1 commit
 - userdiff: funcname and word patterns for sh

 Add a built-in "userdiff" patterns to word-split and identify
 notable lines in shell scripts to help presentation of diff and
 grep output.

 Will discard.


* mh/fdopen-with-retry (2015-03-06) 6 commits
 - buffer_fdinit(): use fdopen_with_retry()
 - update_info_file(): use fdopen_with_retry()
 - copy_to_log(): use fdopen_with_retry()
 - fdopen_lock_file(): use fdopen_with_retry()
 - SQUASH??? $gmane/264889
 - xfdopen(): if first attempt fails, free memory and try again

 Various parts of the code where they call fdopen() can fail when
 they run out of memory; attempt to proceed by retrying the
 operation after freeing some resource.

 Waiting for further comments.


* nd/untracked-cache (2015-03-12) 24 commits
 - git-status.txt: advertisement for untracked cache
 - untracked cache: guard and disable on system changes
 - mingw32: add uname()
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - ewah: add convenient wrapper ewah_serialize_strbuf()
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file

 Need extra sets of eyes to review this.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* pt/credential-xdg (2015-03-25) 4 commits
  (merged to 'next' on 2015-03-25 at 765128e)
 + t0302: "unreadable" test needs POSIXPERM
  (merged to 'next' on 2015-03-24 at 9a3706e)
 + t0302: test credential-store support for XDG_CONFIG_HOME
 + git-credential-store: support XDG_CONFIG_HOME
 + git-credential-store: support multiple credential files

 Tweak the sample "store" backend of the credential helper to honor
 XDG configuration file locations when specified.

 As this may see further updates, and also this is not an urgent
 issue anyway, I'll give it a bit more time for it to simmer.

 Will cook in 'next'.


* jc/merge-deprecate-old-syntax (2015-03-26) 1 commit
 - merge: deprecate 'git merge <message> HEAD <commit>' syntax
 (this branch is used by jc/merge-drop-old-syntax.)

 The first step to really start the process of removing the ancient
 syntax to invoke a two-way merge, which has been deprecated since
 October 2007.


* jc/merge-drop-old-syntax (2015-03-26) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch uses jc/merge-deprecate-old-syntax.)

 Stop supporting "git merge <messsage> HEAD <commit>" syntax that
 has been deprecated since October 2007.


* jc/diff-no-index-d-f (2015-03-26) 2 commits
  (merged to 'next' on 2015-03-27 at 1f270f9)
 + diff-no-index: align D/F handling with that of normal Git
 + diff-no-index: DWIM "diff D F" into "diff D/F F"

 The usual "git diff" when seeing a file turning into a directory
 showed a patchset to remove the file and create all files in the
 directory, but "git diff --no-index" simply refused to work.  Also,
 when asked to compare a file and a directory, imitate POSIX "diff"
 and compare the file with the file with the same name in the
 directory, instead of refusing to run.

 Will cook in 'next'.


* nd/diff-i-t-a (2015-03-23) 1 commit
  (merged to 'next' on 2015-03-24 at a6be89f)
 + diff-lib.c: adjust position of i-t-a entries in diff

 After "git add -N", the path appeared in output of "git diff HEAD"
 and "git diff --cached HEAD", leading "git status" to classify it
 as "Changes to be committed".  Such a path, however, is not yet to
 be scheduled to be committed.  "git diff" showed the change to the
 path as modification, not as a "new file", in the header of its
 output.

 Treat such paths as "yet to be added to the index but Git already
 know about them"; "git diff HEAD" and "git diff --cached HEAD"
 should not talk about them, and "git diff" should show them as new
 files yet to be added to the index.

 Will cook in 'next', as this brings in a new world order.


* mh/numparse (2015-03-19) 14 commits
 - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 - diff_opt_parse(): use convert_i() when handling "-l<num>"
 - opt_arg(): simplify pointer handling
 - opt_arg(): report errors parsing option values
 - opt_arg(): use convert_i() in implementation
 - opt_arg(): val is always non-NULL
 - builtin_diff(): detect errors when parsing --unified argument
 - handle_revision_opt(): use convert_ui() when handling "--abbrev="
 - strtoul_ui(), strtol_i(): remove functions
 - handle_revision_opt(): use convert_i() when handling "-<digit>"
 - handle_revision_opt(): use skip_prefix() in many places
 - write_subdirectory(): use convert_ui() for parsing mode
 - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 - numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 Waiting for a reroll ($gmane/266209).


* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 Any comments from those who use or have their own code in Gitweb?


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


* bc/object-id (2015-03-13) 10 commits
  (merged to 'next' on 2015-03-24 at 3ec4f83)
 + apply: convert threeway_stage to object_id
 + patch-id: convert to use struct object_id
 + commit: convert parts to struct object_id
 + diff: convert struct combine_diff_path to object_id
 + bulk-checkin.c: convert to use struct object_id
 + zip: use GIT_SHA1_HEXSZ for trailers
 + archive.c: convert to use struct object_id
 + bisect.c: convert leaf functions to use struct object_id
 + define utility functions for object IDs
 + define a structure for object IDs

 Identify parts of the code that knows that we use SHA-1 hash to
 name our objects too much, and use (1) symbolic constants instead
 of hardcoded 20 as byte count and/or (2) use struct object_id
 instead of unsigned char [20] for object names.

 Will cook in 'next'.
 Also waiting for reviews on the follow-up series ($gmane/265939)
 that seems to have seen no interest X-<.


* nd/slim-index-pack-memory-usage (2015-02-27) 2 commits
 - index-pack: kill union delta_base to save memory
 - index-pack: reduce object_entry size to save memory

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.

 Waiting for further comments and a final reroll ($gmane/264544).


* nd/list-files (2015-02-09) 21 commits
 - t3080: tests for git-list-files
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
 - list-files: make alias 'ls' default to 'list-files'
 - list-files: a user friendly version of ls-files and more
 - ls-files: support --max-depth
 - ls-files: add --column
 - ls-files: add --color to highlight file names
 - ls-files: buffer full item in strbuf before printing
 - ls_colors.c: highlight submodules like directories
 - ls_colors.c: add a function to color a file name
 - ls_colors.c: parse color.ls.* from config file
 - ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 Waiting for a further polished reroll ($gmane/265534).


* js/fsck-opt (2015-01-21) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --quick`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.* options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.*
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 "fsck.warnings = <list of error tokens>" I suggested turned out to
 be an unpopular choice (sorry Dscho).

 Expecting a reroll.


* nd/multiple-work-trees (2015-03-31) 41 commits
  (merged to 'next' on 2015-04-02 at 7ea51b4)
 + prune --worktrees: fix expire vs worktree existence condition
  (merged to 'next' on 2015-03-24 at 58b5a60)
 + t1501: fix test with split index
  (merged to 'next' on 2015-03-20 at cc98ed0)
 + t2026: fix broken &&-chain
  (merged to 'next' on 2015-02-18 at b51f696)
 + t2026 needs procondition SANITY
 + git-checkout.txt: a note about multiple checkout support for submodules
 + checkout: add --ignore-other-wortrees
 + checkout: pass whole struct to parse_branchname_arg instead of individual flags
 + git-common-dir: make "modules/" per-working-directory directory
 + checkout: do not fail if target is an empty directory
 + t2025: add a test to make sure grafts is working from a linked checkout
 + checkout: don't require a work tree when checking out into a new one
 + git_path(): keep "info/sparse-checkout" per work-tree
 + count-objects: report unused files in $GIT_DIR/worktrees/...
 + gc: support prune --worktrees
 + gc: factor out gc.pruneexpire parsing code
 + gc: style change -- no SP before closing parenthesis
 + checkout: clean up half-prepared directories in --to mode
 + checkout: reject if the branch is already checked out elsewhere
 + prune: strategies for linked checkouts
 + checkout: support checking out into a new working directory
 + use new wrapper write_file() for simple file writing
 + wrapper.c: wrapper to open a file, fprintf then close
 + setup.c: support multi-checkout repo setup
 + setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 + setup.c: convert check_repository_format_gently to use strbuf
 + setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 + setup.c: convert is_git_directory() to use strbuf
 + git-stash: avoid hardcoding $GIT_DIR/logs/....
 + *.sh: avoid hardcoding $GIT_DIR/hooks/...
 + git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 + $GIT_COMMON_DIR: a new environment variable
 + commit: use SEQ_DIR instead of hardcoding "sequencer"
 + fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 + reflog: avoid constructing .lock path with git_path
 + *.sh: respect $GIT_INDEX_FILE
 + git_path(): be aware of file relocation in $GIT_DIR
 + path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 + path.c: rename vsnpath() to do_git_path()
 + git_snpath(): retire and replace with strbuf_git_path()
 + path.c: make get_pathname() call sites return const char *
 + path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will cook in 'next'.

--------------------------------------------------
[Discarded]

* ak/stash-store-create-help (2015-01-13) 1 commit
 . stash: show "create" and "store" subcommands in usage-help


* bp/diff-relative-config (2015-01-07) 2 commits
 . diff: teach diff.relative to give default to --relative=<value>
 . diff: teach --no-relative to override earlier --relative


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 . git-quiltimport: flip the default not to allow fuzz
 . git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 . SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 . git-add--interactive: Preserve diff heading when splitting hunks


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 . userdiff: support Java try keyword
 . userdiff: support C# async methods and correct C# keywords


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 . git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 . merge: drop unused arg from abort_commit method signature
 . merge: make prepare_to_commit responsible for write_merge_state
 . t7505: ensure cleanup after hook blocks merge
 . t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 . WIP: document what we want at the end
 . graph: remove unused code a bit
 . graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* ts/man-pdf (2015-03-20) 1 commit
 . Documentation: make 'make pdf' format manpages to PDF as well

 For offline consumption of manual pages, a target to produce one
 pdf document per manual page was added to Documentation/Makefile.

 Its usefulness is unknown, given that this does not produce a
 single document with all the manual pages in it, which would be not
 much better than keeping a bunch of HTML manual pages we already
 produce and use them instead for offline consumption.

 Discarded, while leaving a single-document target as an open
 possibility.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 . gitweb: Harden UTF-8 handling in generated links
