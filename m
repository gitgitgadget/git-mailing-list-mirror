From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2015, #03; Wed, 14)
Date: Wed, 14 Jan 2015 15:45:15 -0800
Message-ID: <xmqqd26h7wqc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 00:45:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBXcv-0004T0-16
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 00:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbANXpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 18:45:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753479AbbANXpS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 18:45:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E6AD2DD48;
	Wed, 14 Jan 2015 18:45:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	7pqgd0kZPRtVXOzu+soAAnrZpI=; b=xPP+jNQdXqC6ZmG0HmdfK+U7iqIXNur6W
	83BtEVVpDtXNQeVXdVPlMfWPTqUjtJX9NvihJHcaCsnAJDm+/d524wua3S95mHc4
	QLB1TglYB0yAZkKM3MDmE9PnnNeLgeQr3WnIw0p57udzYAyugVme7vtLq0TY9APN
	Tn7FVVBkk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=dKN
	FWA1WR08GqfeEhluiLcgPGhVG2QBw4oDTgY7cG2pclP8NKCx8eAUNQmNRUZ0d4Sj
	re4OLwblwR9DdSrJUnmcTBoGMYNXpFWJyL3x4+TsS9ZAGUGZz+2GpxTNBZKvPDB9
	RXtFQ0+FGkvF6K6y2WJXVOWsvFM3EeSxvnzNTeWY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81C3E2DD46;
	Wed, 14 Jan 2015 18:45:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A339D2DD45;
	Wed, 14 Jan 2015 18:45:16 -0500 (EST)
X-master-at: 563d4e59bd167fe2eecc5480e3841d878b1c8c2b
X-next-at: cfa011ed84d39e514c6604f2af14259d9ad5483a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6444E08E-9C47-11E4-BE44-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262450>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Many small low-impact topics have been merged to 'master' in
preparation for 2.3-rc1 later in the week.  I see nothing pressing
that remain in 'next' other than a few bugfixes I am hoping that we
can merge and ship in the 2.3 final.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/doc-add-v-n-options (2015-01-09) 1 commit
  (merged to 'next' on 2015-01-12 at 0888edf)
 + Documentation: list long options for -v and -n


* ak/fewer-includes (2015-01-09) 2 commits
  (merged to 'next' on 2015-01-12 at d425e96)
 + cat-file: remove unused includes
 + git.c: remove unnecessary #includes


* ak/show-branch-usage-string (2015-01-08) 1 commit
  (merged to 'next' on 2015-01-12 at 3a0de03)
 + show-branch: line-wrap show-branch usage


* aw/doc-smtp-ssl-cert-path (2015-01-07) 1 commit
  (merged to 'next' on 2015-01-12 at 61d0b22)
 + correct smtp-ssl-cert-path description

 A long overdue documentation update to match an age-old code
 update.


* jk/prune-packed-server-info (2015-01-06) 2 commits
  (merged to 'next' on 2015-01-12 at 5e789e2)
 + update-server-info: create info/* with mode 0666
 + t1301: set umask in reflog sharedrepository=group test

 Fix recent breakage in Git 2.2 that started creating info/refs and
 objects/info/packs files with permission bits tighter than user's
 umask.


* js/remote-add-with-insteadof (2014-12-23) 2 commits
  (merged to 'next' on 2015-01-12 at ccff14f)
 + Add a regression test for 'git remote add <existing> <same-url>'
 + git remote: allow adding remotes agreeing with url.<...>.insteadOf

 "git remote add $name $URL" is now allowed when "url.$URL.insteadOf"
 is already defined.


* km/imap-send-libcurl-options (2015-01-06) 2 commits
  (merged to 'next' on 2015-01-12 at 5bb8802)
 + imap-send.c: set CURLOPT_USE_SSL to CURLUSESSL_TRY
 + imap-send.c: support GIT_CURL_VERBOSE

 Now imap-send learned to talk to the server using cURL library,
 allow the same GIT_CURL_VERBOSE environment variable to control the
 verbosity of the chattering.


* km/log-usage-string-i18n (2015-01-06) 1 commit
  (merged to 'next' on 2015-01-12 at 437bf8a)
 + log.c: fix translation markings


* mm/complete-rebase-autostash (2015-01-07) 1 commit
  (merged to 'next' on 2015-01-12 at edcdead)
 + git-completion: add --autostash for 'git rebase'


* po/doc-core-ignorestat (2015-01-12) 2 commits
  (merged to 'next' on 2015-01-12 at c660a71)
 + doc: core.ignoreStat update, and clarify the --assume-unchanged effect
  (merged to 'next' on 2014-12-23 at d2b3e84)
 + doc: core.ignoreStat clarify the --assume-unchanged effect


* rc/for-each-ref-tracking (2015-01-12) 1 commit
  (merged to 'next' on 2015-01-12 at 94eef27)
 + for-each-ref: always check stat_tracking_info()'s return value


* rh/autoconf-rhel3 (2015-01-09) 3 commits
  (merged to 'next' on 2015-01-12 at 57f125c)
 + configure.ac: check for HMAC_CTX_cleanup
 + configure.ac: check for clock_gettime and CLOCK_MONOTONIC
 + configure.ac: check 'tv_nsec' field in 'struct stat'

 Build update for older RHEL.


* rh/hide-prompt-in-ignored-directory (2015-01-07) 2 commits
  (merged to 'next' on 2015-01-12 at 9aed017)
 + git-prompt.sh: allow to hide prompt for ignored pwd
 + git-prompt.sh: if pc mode, immediately set PS1 to a plain prompt


* rh/test-color-avoid-terminfo-in-original-home (2015-01-07) 2 commits
  (merged to 'next' on 2015-01-12 at eac0b93)
 + test-lib.sh: do tests for color support after changing HOME
 + test-lib: use 'test ...' instead of '[ ... ]'

 We try to see if "tput" gives a useful result before switching TERM
 to dumb and moving HOME to point to our fake location for stability
 of the tests, and then use the command when coloring the output
 from the tests, but there is no guarantee "tput" works after
 switching HOME.


* sp/subtree-doc (2015-01-06) 1 commit
  (merged to 'next' on 2015-01-12 at 7c488d6)
 + subtree: fix AsciiDoc list item continuation

--------------------------------------------------
[New Topics]

* ah/usage-strings (2015-01-14) 1 commit
 - standardize usage info string format

 Will merge to and cook in 'next'.


* ak/cat-file-clean-up (2015-01-13) 1 commit
 - cat-file: use "type" and "size" from outer scope

 Will merge to 'next'.


* ak/stash-store-create-help (2015-01-13) 1 commit
 - stash: show "create" and "store" subcommands in usage-help

 Undecided.


* jk/blame-commit-label (2015-01-13) 5 commits
 - blame.c: fix garbled error message
 - use xstrdup_or_null to replace ternary conditionals
 - builtin/commit.c: use xstrdup_or_null instead of envdup
 - builtin/apply.c: use xstrdup_or_null instead of null_strdup
 - git-compat-util: add xstrdup_or_null helper

 Will merge to 'next'.


* jk/http-push-symref-fix (2015-01-14) 1 commit
 - http-push: trim trailing newline from remote symref

 Will merge to 'next'.


* js/t1050 (2015-01-14) 1 commit
 - t1050-large: generate large files without dd

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jn/doc-api-errors (2014-12-04) 1 commit
 - doc: document error handling functions and conventions

 For discussion.


* ye/http-accept-language (2014-12-22) 1 commit
 - http: Add Accept-Language header if possible

 Expecting a reroll ($gmane/261810).


* jk/strbuf-doc-to-header (2014-12-12) 4 commits
 - strbuf.h: reorganize api function grouping headers
 - strbuf.h: format asciidoc code blocks as 4-space indent
 - strbuf.h: drop asciidoc list formatting from API docs
 - strbuf: migrate api-strbuf.txt documentation to strbuf.h

 Resolve the "doc vs header" to favor the latter.

 Expecting to be rerolled.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* ms/submodule-update-config-doc (2014-11-03) 1 commit
 - submodule: clarify documentation for update subcommand

 Needs a reroll ($gmane/259037).


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack; will discard.


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


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


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

* lf/blame-commit-label (2015-01-12) 1 commit
 . blame.c: fix garbled error message

 Needs fixing.


* bc/http-fallback-to-password-after-krb-fails (2015-01-07) 1 commit
  (merged to 'next' on 2015-01-12 at 4c67038)
 + remote-curl: fall back to Basic auth if Negotiate fails

 After attempting and failing a password-less authentication
 (e.g. kerberos), libcURL refuses to fall back to password based
 Basic authentication without a bit of help/encouragement.

 Will cook in 'next'.


* bp/diff-relative-config (2015-01-07) 2 commits
 - diff: teach diff.relative to give default to --relative=<value>
 - diff: teach --no-relative to override earlier --relative


* dk/format-patch-ignore-diff-submodule (2015-01-07) 2 commits
  (merged to 'next' on 2015-01-12 at 6b4605b)
 + format-patch: ignore diff.submodule setting
 + t4255: test am submodule with diff.submodule

 Setting diff.submodule to 'log' made "git format-patch" produce
 broken patches.

 Will cook in 'next'.


* nd/attr-optim (2014-12-29) 3 commits
 - attr: avoid heavy work when we know the specified attr is not defined
 - attr: do not attempt to expand when we know it's not a macro
 - attr.c: rename arg name attr_nr to avoid shadowing the global one


* cj/log-invert-grep (2015-01-13) 1 commit
  (merged to 'next' on 2015-01-13 at c908e99)
 + log: teach --invert-grep option

 Will cook in 'next'.


* km/gettext-n (2015-01-12) 1 commit
  (merged to 'next' on 2015-01-12 at 0cbbf4a)
 + gettext.h: add parentheses around N_ expansion if supported

 Will cook in 'next'.


* jn/rerere-fail-on-auto-update-failure (2015-01-08) 1 commit
  (merged to 'next' on 2015-01-12 at 313c449)
 + rerere: error out on autoupdate failure

 "git rerere" (invoked internally from many mergy operations) did
 not correctly signal errors when told to update the working tree
 files and failed to do so for whatever reason.

 Will cook in 'next'.


* sb/atomic-push (2015-01-14) 11 commits
  (merged to 'next' on 2015-01-14 at 12c4e28)
 + Document receive.advertiseatomic
  (merged to 'next' on 2015-01-12 at 411c6a6)
 + t5543-atomic-push.sh: add basic tests for atomic pushes
 + push.c: add an --atomic argument
 + send-pack.c: add --atomic command line argument
 + send-pack: rename ref_update_to_be_sent to check_to_send_update
 + receive-pack.c: negotiate atomic push support
 + receive-pack.c: add execute_commands_atomic function
 + receive-pack.c: move transaction handling in a central place
 + receive-pack.c: move iterating over all commands outside execute_commands
 + receive-pack.c: die instead of error in case of possible future bug
 + receive-pack.c: shorten the execute_commands loop over all commands
 (this branch uses mh/reflog-expire.)

 "git push" has been taught a "--atomic" option that makes push to
 update more than one ref an "all-or-none" affair.

 Will cook in 'next'.


* mh/reflog-expire (2014-12-22) 24 commits
  (merged to 'next' on 2015-01-12 at 12a7dff)
 + refs.c: let fprintf handle the formatting
 + refs.c: don't expose the internal struct ref_lock in the header file
 + lock_any_ref_for_update(): inline function
 + refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
 + reflog_expire(): new function in the reference API
 + expire_reflog(): treat the policy callback data as opaque
 + Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
 + expire_reflog(): move rewrite to flags argument
 + expire_reflog(): move verbose to flags argument
 + expire_reflog(): pass flags through to expire_reflog_ent()
 + struct expire_reflog_cb: a new callback data type
 + Rename expire_reflog_cb to expire_reflog_policy_cb
 + expire_reflog(): move updateref to flags argument
 + expire_reflog(): move dry_run to flags argument
 + expire_reflog(): add a "flags" argument
 + expire_reflog(): extract two policy-related functions
 + Extract function should_expire_reflog_ent()
 + expire_reflog(): use a lock_file for rewriting the reflog file
 + expire_reflog(): return early if the reference has no reflog
 + expire_reflog(): rename "ref" parameter to "refname"
 + expire_reflog(): it's not an each_ref_fn anymore
 + refs.c: add a function to append a reflog entry to a fd
 + refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 + refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/atomic-push.)

 Restructure "reflog expire" to fit the reflogs better with the
 recently updated ref API.

 Looked reasonable (except that some shortlog entries stood out like
 a sore thumb).

 Will cook in 'next'.


* jc/push-to-checkout (2015-01-08) 2 commits
  (merged to 'next' on 2015-01-12 at e64df63)
 + receive-pack: support push-to-checkout hook
 + receive-pack: refactor updateInstead codepath

 Extending the js/push-to-deploy topic, the behaviour of "git push"
 when updating the working tree and the index with an update to the
 branch that is checked out can be tweaked by push-to-checkout hook.

 Will cook in 'next'.


* nd/list-files (2014-12-01) 19 commits
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

 Comments?


* nd/multiple-work-trees (2015-01-07) 37 commits
 - git-checkout.txt: a note about multiple checkout support for submodules
 - checkout: add --ignore-other-wortrees
 - checkout: pass whole struct to parse_branchname_arg instead of individual flags
 - git-common-dir: make "modules/" per-working-directory directory
 - checkout: do not fail if target is an empty directory
 - t2025: add a test to make sure grafts is working from a linked checkout
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/worktrees/...
 - gc: support prune --worktrees
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
 - checkout: clean up half-prepared directories in --to mode
 - checkout: reject if the branch is already checked out elsewhere
 - prune: strategies for linked checkouts
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.


* nd/untracked-cache (2015-01-06) 24 commits
 - fixup! untracked cache: load from UNTR index extension
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

 Comments?

--------------------------------------------------
[Discarded]

* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 . receive-pack: truncate hmac early and convert only necessary bytes
 . sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".


* mt/patch-id-stable (2014-06-10) 1 commit
 . patch-id: change default to stable

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.


* sb/copy-fd-errno (2014-11-17) 1 commit
 . copy.c: make copy_fd preserve meaningful errno


* cj/grep-none-match (2015-01-06) 1 commit
 . git-log: added --none-match option

 "git log --none-match --grep=WIP" will show only commits that are
 not marked as WIP.

 cj/log-invert-grep replaces this.
