From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2015, #01; Mon, 2)
Date: Mon, 02 Mar 2015 15:19:50 -0800
Message-ID: <xmqqwq2z7zs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 00:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSZdF-0008EW-Lf
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 00:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbbCBXUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 18:20:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753948AbbCBXUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 18:20:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E54153D74B;
	Mon,  2 Mar 2015 18:20:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	hgXsf9nnPpc8iCdjX+aVmTU7Og=; b=S7QeEre0KS5LkMHEPFlgKJTgfBXzReqP6
	GvtROZNxBp3sVW3ukcuaAWwL4fX9ftpkYqFYhslmq37zzmQPzsiYB/0kl9237NnG
	TffEpaFYZQyWCvRpT1euqG/1/sprQIrWJL6GzR9AbAAangj74/3zUWfshUFZKb1b
	kpHIQaCN2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bM+
	m/Jy6scWaAPWY8CETydEyQRgl7Crn+l308UDSze8k3OYSftce0mbrFFrxJADWl2c
	WxpOOVOmnGmC+BtBPVDqnKa7oB8bQUheUYXje4PeRttwVTiDDQiSdKRjgwbUZh2Z
	lMemDza9ZjY5VrbegxfGZEVZTbfLCdZa+kZzyCjo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7058D3D746;
	Mon,  2 Mar 2015 18:20:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2043C3D741;
	Mon,  2 Mar 2015 18:19:52 -0500 (EST)
X-master-at: 7f4ba4b6e3ba7075ca6b379ba23fd3088cbe69a8
X-next-at: 993ae8bdc3df206f62a424eb695a49f1ba8fa118
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0FD7E22-C132-11E4-91F5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264633>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Fifth batch of topics have been merged to 'master', including both
fixes and enhancements. First maintenance release for v2.3 was cut
with many fixes that have already been merged to 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ew/svn-fixes (2015-02-26) 2 commits
 - Merge branch 'svn-maint-fixes' into svn-fixes
 - git-svn: lazy load some modules
 (this branch uses ew/svn-maint-fixes.)

 Will merge to 'next'.


* ew/svn-maint-fixes (2015-02-26) 2 commits
 - Git::SVN::*: avoid premature FileHandle closure
 - git-svn: fix localtime=true on non-glibc environments
 (this branch is used by ew/svn-fixes.)

 Will merge to 'next' and soon to 'master'.


* mr/doc-clean-f-f (2015-02-26) 1 commit
 - Documentation/git-clean.txt: document that -f may need to be given twice

 Will merge to 'next'.


* ye/http-accept-language (2015-02-26) 1 commit
 - gettext.c: move get_preferred_languages() from http.c

 Compilation fix for a recent topic in 'master'.

 Will merge to 'next'.


* jk/diffcore-rename-duplicate (2015-02-27) 2 commits
 - diffcore-rename: avoid processing duplicate destinations
 - diffcore-rename: split locate_rename_dst into two functions

 A corrupt input to "git diff -M" can cause us to segfault.

 Will merge to 'next'.


* nd/grep-exclude-standard-help-fix (2015-02-27) 1 commit
 - grep: correct help string for --exclude-standard

 Will merge to 'next'.


* nd/versioncmp-prereleases (2015-02-27) 1 commit
 - versionsort: support reorder prerelease suffixes

 The versionsort.prerelease configuration variable can be used to
 specify that v1.0-pre1 comes before v1.0.

 Will merge to 'next'.


* ja/clean-confirm-i18n (2015-03-02) 1 commit
 - Add hint interactive cleaning

 The prompt string "remove?" used when "git clean -i" asks the user
 if a path should be removed was localizable, but the code always
 expects a substring of "yes" to tell it to go ahead.  Always show
 [y/N] as part of this prompt to hint that the answer is not (yet)
 localized.

 Will merge to 'next'.


* mk/diff-shortstat-dirstat-fix (2015-03-02) 1 commit
 - diff --shortstat --dirstat: remove duplicate output

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jk/push-config (2015-02-17) 4 commits
 - [NEEDSACK] push: allow --follow-tags to be set by config push.followTags
 - cmd_push: pass "flags" pointer to config callback
 - cmd_push: set "atomic" bit directly
 - git_push_config: drop cargo-culted wt_status pointer

 Waiting for Ack and/or update for the tip one from Dave Olszewski
 ($gmane/263880, $gmane/263991).


* nd/untracked-cache (2015-02-09) 24 commits
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


* ak/stash-store-create-help (2015-01-13) 1 commit
 - stash: show "create" and "store" subcommands in usage-help

 Will discard.


* bp/diff-relative-config (2015-01-07) 2 commits
 - diff: teach diff.relative to give default to --relative=<value>
 - diff: teach --no-relative to override earlier --relative

 No comments?  No interests?


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging
 (this branch uses jc/diff-test-updates.)

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack
 Will discard.


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

* nd/slim-index-pack-memory-usage (2015-02-27) 2 commits
 - index-pack: kill union delta_base to save memory
 - index-pack: reduce object_entry size to save memory

 Memory usage of "git index-pack" has been trimmed by tens of
 per-cent.


* mg/detached-head-report (2015-02-23) 1 commit
 - branch: name detached HEAD analogous to status

 "git branch" on a detached HEAD always said "(detached from xyz)",
 even when "git status" would report "detached at xyz".  The HEAD is
 actually at xyz and haven't been moved since it was detached in
 such a case, but the user cannot read what the current value of
 HEAD is when "detached from" is used.

 The goal is sound.  May want to share code between branch and
 status in a reroll?  Are there other commands that give the same
 information that share the code, too?


* mg/sequencer-commit-messages-always-verbatim (2015-02-23) 1 commit
 - sequencer: preserve commit messages

 Always replay the original commit message verbatim, regardless of
 the commit.cleanup configuration settings by the user.

 Is this a good idea?


* rj/no-xopen-source-for-cygwin (2015-02-22) 1 commit
  (merged to 'next' on 2015-02-23 at 323ac75)
 + git-compat-util.h: remove redundant code

 Will merge to 'master'.


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


* mm/am-c-doc (2015-02-20) 2 commits
  (merged to 'next' on 2015-02-23 at 1cd9b0f)
 + Documentation/git-am.txt: mention mailinfo.scissors config variable
 + Documentation/config.txt: document mailinfo.scissors

 The configuration variable 'mailinfo.scissors' was hard to
 discover in the documentation.

 Will merge to 'master'.


* rs/simple-cleanups (2015-02-22) 4 commits
  (merged to 'next' on 2015-02-23 at a89f034)
 + sha1_name: use strlcpy() to copy strings
 + pretty: use starts_with() to check for a prefix
 + for-each-ref: use skip_prefix() to avoid duplicate string comparison
 + connect: use strcmp() for string comparison

 Will merge to 'master'.


* tb/connect-ipv6-parse-fix (2015-02-22) 3 commits
  (merged to 'next' on 2015-02-24 at 6658564)
 + t5500: show user name and host in diag-url
 + t5601: add more test cases for IPV6
 + connect.c: allow ssh://user@[2001:db8::1]/repo.git

 We did not parse username followed by literal IPv6 address in SSH
 transport URLs, e.g. ssh://user@[2001:db8::1]:22/repo.git
 correctly.

 Will merge to 'master'.


* jc/decorate-leaky-separator-color (2015-02-20) 2 commits
 - config.txt: spell out how certain typed values are written
 - log --decorate: do not leak "commit" color into the next item

 "git log --decorate" did not reset colors correctly around the
 branch names.

 Waiting for discussion on the tip one.


* ms/submodule-update-config-doc (2015-03-02) 1 commit
 - submodule: improve documentation of update subcommand

 The interaction between "git submodule update" and the
 submodule.*.update configuration was not clearly documented.

 Will merge to 'next'.


* jc/diff-test-updates (2015-02-23) 7 commits
  (merged to 'next' on 2015-02-23 at 9e863a7)
 + test_ln_s_add: refresh stat info of fake symbolic links
  (merged to 'next' on 2015-02-18 at f152c9f)
 + t4008: modernise style
 + t/diff-lib: check exact object names in compare_diff_raw
 + tests: do not borrow from COPYING and README from the real source
 + t4010: correct expected object names
 + t9300: correct expected object names
 + t4008: correct stale comments
 (this branch is used by jc/diff-b-m.)

 Test clean-up.

 Will merge to 'master'.


* km/send-email-getopt-long-workarounds (2015-02-16) 1 commit
  (merged to 'next' on 2015-02-18 at 84c1597)
 + git-send-email.perl: support no- prefix with older GetOptions

 Even though we officially haven't dropped Perl 5.8 support, the
 Getopt::Long package that came with it does not support "--no-"
 prefix to negate a boolean option; manually add support to help
 people with older Getopt::Long package.

 Will merge to 'master'.


* jk/daemon-interpolate (2015-02-17) 3 commits
  (merged to 'next' on 2015-02-20 at 21118a7)
 + daemon: sanitize incoming virtual hostname
 + t5570: test git-daemon's --interpolated-path option
 + git_connect: let user override virtual-host we send to daemon

 The "interpolated-path" option of "git daemon" inserted any string
 client declared on the "host=" capability request without checking.
 Sanitize and limit %H and %CH to a saner and a valid DNS name.

 Will merge to 'master'.


* rs/daemon-interpolate (2015-02-17) 2 commits
  (merged to 'next' on 2015-02-18 at c0f5750)
 + daemon: use callback to build interpolated path
 + daemon: look up client-supplied hostname lazily

 "git daemon" looked up the hostname even when "%CH" and "%IP"
 interpolations are not requested, which was unnecessary.

 Will merge to 'master'.


* mh/expire-updateref-fixes (2015-03-02) 9 commits
 - reflog_expire(): never update a reference to null_sha1
 - reflog_expire(): ignore --updateref for symbolic references
 - reflog: improve and update documentation
 - struct ref_lock: delete the force_write member
 - lock_ref_sha1_basic(): do not set force_write for missing references
 - write_ref_sha1(): move write elision test to callers
 - write_ref_sha1(): remove check for lock == NULL
 - Merge branch 'sb/atomic-push' into mh/ref-trans-value-check
 - Merge branch 'mh/reflog-expire' into mh/ref-trans-value-check

 Will wait for a short while before merging to 'next'.
 ($gmane/264586).


* mh/refs-have-new (2015-02-17) 13 commits
  (merged to 'next' on 2015-02-23 at b8929db)
 + refs.h: remove duplication in function docstrings
 + update_ref(): improve documentation
 + ref_transaction_verify(): new function to check a reference's value
 + ref_transaction_delete(): check that old_sha1 is not null_sha1
 + ref_transaction_create(): check that new_sha1 is valid
 + commit: avoid race when creating orphan commits
 + commit: add tests of commit races
 + ref_transaction_delete(): remove "have_old" parameter
 + ref_transaction_update(): remove "have_old" parameter
 + struct ref_update: move "have_old" into "flags"
 + refs.c: change some "flags" to "unsigned int"
 + refs: remove the gap in the REF_* constant values
 + refs: move REF_DELETING to refs.c

 Simplify the ref transaction API around how "the ref should be
 pointing at this object" is specified.

 Will merge to 'master'.


* jc/apply-beyond-symlink (2015-02-10) 4 commits
  (merged to 'next' on 2015-02-18 at 4109de1)
 + apply: do not touch a file beyond a symbolic link
 + apply: do not read from beyond a symbolic link
 + apply: do not read from the filesystem under --index
 + apply: reject input that touches outside the working area

 "git apply" was not very careful about reading from, removing,
 updating and creating paths outside the working tree (under
 --index/--cached) or the current directory (when used as a
 replacement for GNU patch).

 Will merge to 'master'.


* jc/apply-ws-fix-expands-report (2015-01-22) 1 commit
  (merged to 'next' on 2015-02-18 at b571668)
 + apply: detect and mark whitespace errors in context lines when fixing

 "git apply --whitespace=fix" fixed whitespace errors in the common
 context lines but did so without reporting.

 Will merge to 'master'.


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


* nd/multiple-work-trees (2015-01-27) 38 commits
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
