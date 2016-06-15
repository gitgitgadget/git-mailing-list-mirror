From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2011, #03; Wed, 20)
Date: Wed, 20 Jul 2011 16:06:46 -0700
Message-ID: <7vei1k4kmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 01:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjfqz-0005YN-0f
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 01:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1GTXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 19:06:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab1GTXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 19:06:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39F85FB6;
	Wed, 20 Jul 2011 19:06:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=H
	hQmso/aFYdu4O7639S9kfPwgM0=; b=Ctc7zudqSnCBfrvXiwgEkiAICUDvYqhw1
	AKIsaQu0BG2fe+nOkat0i6g0O5pAZozOhxMUPx+HL9JeAf48wGPFpGPs2QinGfGR
	DUelg8i1IXwYY+j2R1xyRAJrnrSjfEpbhwvYhuMMf5CunufPUojPRuQqoWfzYmRc
	XbNf6y9mKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=npq
	sKtadSVJP0PjKZG5W/lN/KYRuBOcgbw/SFIHbvYnGhrZ0px7GRT+sU6HqWKuaGjl
	Zxg8Gy0GLeAsiidQMhIrVo2TgvQaRS/7Plll1dExxsBJ/Wqu6Xhq8czyi7j19HmK
	V0fBlsmK0EHXlHchEk0/2ypqhZjSJwq072C5JTjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB0755FB5;
	Wed, 20 Jul 2011 19:06:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 771755FB0; Wed, 20 Jul 2011
 19:06:48 -0400 (EDT)
X-master-at: d79bcd68056250d7c03bf9b12728ee2fd85a0ab3
X-next-at: e1ef4147bce8b10d938f988e64e2adfef7cb94eb
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F236BE36-B324-11E0-A814-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177560>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[Graduated to "master"]

* ak/gcc46-profile-feedback (2011-06-20) 3 commits
  (merged to 'next' on 2011-07-01 at 81bc0a7)
 + Add explanation of the profile feedback build to the README
 + Add profile feedback build to git
 + Add option to disable NORETURN

* jc/index-pack (2011-06-05) 9 commits
  (merged to 'next' on 2011-07-05 at 5062ba9)
 + verify-pack: use index-pack --verify
 + index-pack: show histogram when emulating "verify-pack -v"
 + index-pack: start learning to emulate "verify-pack -v"
 + index-pack: a miniscule refactor
 + index-pack --verify: read anomalous offsets from v2 idx file
 + write_idx_file: need_large_offset() helper function
 + index-pack: --verify
 + write_idx_file: introduce a struct to hold idx customization options
 + index-pack: group the delta-base array entries also by type

* jc/submodule-sync-no-auto-vivify (2011-06-26) 2 commits
  (merged to 'next' on 2011-07-05 at b207ba3)
 + submodule add: always initialize .git/config entry
 + submodule sync: do not auto-vivify uninteresting submodule

* jc/zlib-wrap (2011-06-10) 7 commits
  (merged to 'next' on 2011-07-05 at 77bcbdc)
 + zlib: allow feeding more than 4GB in one go
 + zlib: zlib can only process 4GB at a time
 + zlib: wrap deflateBound() too
 + zlib: wrap deflate side of the API
 + zlib: wrap inflateInit2 used to accept only for gzip format
 + zlib: wrap remaining calls to direct inflate/inflateEnd
 + zlib wrapper: refactor error message formatter

We used to use zlib incorrectly and botched inflating/deflating data
that is more than 4GB long on platforms with 64-bit ulong.

* jk/archive-tar-filter (2011-06-22) 9 commits
  (merged to 'next' on 2011-07-05 at add3e7f)
 + upload-archive: allow user to turn off filters
 + archive: provide builtin .tar.gz filter
 + archive: implement configurable tar filters
 + archive: refactor file extension format-guessing
 + archive: move file extension format-guessing lower
 + archive: pass archiver struct to write_archive callback
 + archive: refactor list of archive formats
 + archive-tar: don't reload default config options
 + archive: reorder option parsing and config reading

* jk/clone-cmdline-config (2011-06-22) 4 commits
  (merged to 'next' on 2011-07-05 at a022613)
 + clone: accept config options on the command line
 + config: make git_config_parse_parameter a public function
 + remote: use new OPT_STRING_LIST
 + parse-options: add OPT_STRING_LIST helper
 (this branch uses jk/maint-config-param.)

* jk/maint-config-param (2011-06-22) 6 commits
  (merged to 'next' on 2011-07-05 at 2dce181)
 + config: use strbuf_split_str instead of a temporary strbuf
 + strbuf: allow strbuf_split to work on non-strbufs
 + config: avoid segfault when parsing command-line config
 + config: die on error in command-line config
 + fix "git -c" parsing of values with equals signs
 + strbuf_split: add a max parameter
 (this branch is used by jk/clone-cmdline-config.)

* jk/tag-list-multiple-patterns (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-05 at 8db1bf0)
 + tag: accept multiple patterns for --list

* jn/gitweb-split-header-html (2011-06-22) 1 commit
  (merged to 'next' on 2011-07-05 at c60d9dc)
 + gitweb: Refactor git_header_html

* jn/mime-type-with-params (2011-06-30) 2 commits
  (merged to 'next' on 2011-07-05 at 7caaf3b)
 + gitweb: Serve */*+xml 'blob_plain' as text/plain with $prevent_xss
 + gitweb: Serve text/* 'blob_plain' as text/plain with $prevent_xss

--------------------------------------------------
[New Topics]

* jc/maint-reset-unmerged-path (2011-07-13) 1 commit
  (merged to 'next' on 2011-07-19 at bbc2d54)
 + reset [<commit>] paths...: do not mishandle unmerged paths
 (this branch is used by jc/diff-index-refactor.)

* jc/diff-index-refactor (2011-07-13) 2 commits
 - diff-lib: refactor run_diff_index() and do_diff_cache()
 - diff-lib: simplify do_diff_cache()
 (this branch uses jc/maint-reset-unmerged-path.)

* sr/transport-helper-fix-rfc (2011-07-19) 2 commits
 - t5800: point out that deleting branches does not work
 - t5800: document inability to push new branch with old content
 (this branch uses sr/transport-helper-fix.)

* vi/make-test-vector-less-specific (2011-07-19) 1 commit
 - tests: cleanup binary test vector files

* jk/http-auth-keyring (2011-07-20) 13 commits
 - credentials: add "getpass" helper
 - credentials: add "store" helper
 - credentials: add "cache" helper
 - docs: end-user documentation for the credential subsystem
 - http: use hostname in credential description
 - allow the user to configure credential helpers
 - look for credentials in config before prompting
 - http: use credential API to get passwords
 - introduce credentials API
 - http: retry authentication failures for all http requests
 - remote-curl: don't retry auth failures with dumb protocol
 - improve httpd auth tests
 - url: decode buffers that are not NUL-terminated

* tc/minix (2011-07-20) 1 commit
 - Makefile: add Minix configuration options.

--------------------------------------------------
[Stalled]

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.
Cf. $gmane/176254, 176255, 166256

--------------------------------------------------
[Cooking]

* sr/transport-helper-fix (2011-07-19) 21 commits
  (merged to 'next' on 2011-07-19 at e1ef414)
 + transport-helper: die early on encountering deleted refs
 + transport-helper: implement marks location as capability
 + transport-helper: Use capname for refspec capability too
 + transport-helper: change import semantics
 + transport-helper: update ref status after push with export
 + transport-helper: use the new done feature where possible
 + transport-helper: check status code of finish_command
 + transport-helper: factor out push_update_refs_status
 + fast-export: support done feature
 + fast-import: introduce 'done' command
 + git-remote-testgit: fix error handling
 + git-remote-testgit: only push for non-local repositories
 + remote-curl: accept empty line as terminator
 + remote-helpers: export GIT_DIR variable to helpers
 + git_remote_helpers: push all refs during a non-local export
 + transport-helper: don't feed bogus refs to export push
 + git-remote-testgit: import non-HEAD refs
 + t5800: document some non-functional parts of remote helpers
 + t5800: use skip_all instead of prereq
 + t5800: factor out some ref tests
 + transport-helper: fix minor leak in push_refs_with_export
 (this branch is used by sr/transport-helper-fix-rfc.)

* bw/log-all-ref-updates-doc (2011-07-12) 1 commit
  (merged to 'next' on 2011-07-14 at 31b80a8)
 + Documentation: clearly specify what refs are honored by core.logAllRefUpdates

* di/fast-import-doc (2011-07-13) 2 commits
 - doc/fast-import: document feature import-marks-if-exists
 - doc/fast-import: clarify notemodify command

Comments from fast-import folks?

* dz/connect-error-report (2011-07-14) 1 commit
  (merged to 'next' on 2011-07-14 at bf1c775)
 + Do not log unless all connect() attempts fail

* jc/pack-order-tweak (2011-07-08) 2 commits
 - pack-objects: optimize "recency order"
 - core: log offset pack data accesses happened

* jk/generation-numbers (2011-07-14) 8 commits
 - limit "contains" traversals based on commit generation
 - check commit generation cache validity against grafts
 - pretty: support %G to show the generation number of a commit
 - commit: add commit_generation function
 - add metadata-cache infrastructure
 - decorate: allow storing values instead of pointers
 - Merge branch 'jk/tag-contains-ab' (early part) into HEAD
 + tag: speed up --contains calculation
 (this branch is tangled with jk/tag-contains-ab.)

* js/maint-add-path-stat-pwd (2011-07-11) 1 commit
  (merged to 'next' on 2011-07-14 at c6fef9d)
 + get_pwd_cwd(): Do not trust st_dev/st_ino blindly

* ms/help-unknown (2011-07-08) 1 commit
  (merged to 'next' on 2011-07-14 at d7976b4)
 + help_unknown_cmd: do not propose an "unknown" cmd

* mz/doc-rebase-abort (2011-07-13) 1 commit
  (merged to 'next' on 2011-07-14 at a1a612c)
 + rebase: clarify "restore the original branch"

* jc/maint-mergetool-read-fix (2011-07-01) 1 commit
  (merged to 'next' on 2011-07-14 at 2056a67)
 + mergetool: check return value from read

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

* jc/checkout-reflog-fix (2011-07-06) 3 commits
  (merged to 'next' on 2011-07-14 at 5982cdd)
 + Merge commit 'v1.7.6' into jc/checkout-reflog-fix
 + Merge commit 'v1.7.0' into jc/checkout-reflog-fix
 + Merge commit 'v1.6.0' into jc/checkout-reflog-fix
 (this branch uses jc/maint-checkout-reflog-fix.)

* jc/maint-checkout-reflog-fix (2011-07-06) 1 commit
 + checkout: do not write bogus reflog entry out
 (this branch is used by jc/checkout-reflog-fix.)

* js/ref-namespaces (2011-07-14) 6 commits
 - t5509: (fixup) partial readability fix
 - ref namespaces: tests
 - ref namespaces: documentation
 - ref namespaces: Support remote repositories via upload-pack and receive-pack
 - ref namespaces: infrastructure
 - Fix prefix handling in ref iteration functions

* mz/doc-synopsis-verse (2011-07-06) 1 commit
  (merged to 'next' on 2011-07-14 at 34d45e2)
 + Documentation: use [verse] for SYNOPSIS sections

* rc/histogram-diff (2011-07-12) 7 commits
 - xdiff/xprepare: use a smaller sample size for histogram diff
 - xdiff/xprepare: skip classification
 - teach --histogram to diff
 - t4033-diff-patience: factor out tests
 - xdiff/xpatience: factor out fall-back-diff function
 - xdiff/xprepare: refactor abort cleanups
 - xdiff/xprepare: use memset()

* rr/revert-cherry-pick-continue (2011-07-19) 18 commits
 - revert: Introduce --continue to continue the operation
 - revert: Don't implictly stomp pending sequencer operation
 - revert: Remove sequencer state when no commits are pending
 - reset: Make reset remove the sequencer state
 - revert: Introduce --reset to remove sequencer state
 - revert: Make pick_commits functionally act on a commit list
 - revert: Save command-line options for continuing operation
 - revert: Save data for continuing after conflict resolution
 - revert: Don't create invalid replay_opts in parse_args
 - revert: Separate cmdline parsing from functional code
 - revert: Introduce struct to keep command-line options
 - revert: Eliminate global "commit" variable
 - revert: Propogate errors upwards from do_pick_commit
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Simplify and inline add_message_to_msg
 - config: Introduce functions to write non-standard file
 - advice: Introduce error_resolve_conflict

Getting very close, I would think...

* dc/stash-con-untracked (2011-06-26) 1 commit
  (merged to 'next' on 2011-07-13 at 9ed0d1d)
 + stash: Add --include-untracked option to stash and remove all untracked files

* jn/gitweb-search (2011-06-22) 4 commits
  (merged to 'next' on 2011-07-13 at 455acdd)
 + gitweb: Make git_search_* subroutines render whole pages
 + gitweb: Clean up code in git_search_* subroutines
 + gitweb: Split body of git_search into subroutines
 + gitweb: Check permissions first in git_search

* en/merge-recursive (2011-07-14) 50 commits
 - fixup! Do not assume that qsort is stable
 - t3030: fix accidental success in symlink rename
 - merge-recursive: Fix working copy handling for rename/rename/add/add
 - merge-recursive: add handling for rename/rename/add-dest/add-dest
 - merge-recursive: Have conflict_rename_delete reuse modify/delete code
 - merge-recursive: Make modify/delete handling code reusable
 - merge-recursive: Consider modifications in rename/rename(2to1) conflicts
 - merge-recursive: Create function for merging with branchname:file markers
 - merge-recursive: Record more data needed for merging with dual renames
 - merge-recursive: Defer rename/rename(2to1) handling until process_entry
 - merge-recursive: Small cleanups for conflict_rename_rename_1to2
 - merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
 - merge-recursive: Introduce a merge_file convenience function
 - merge-recursive: Fix modify/delete resolution in the recursive case
 - merge-recursive: Provide more info in conflict markers with file renames
 - merge-recursive: Cleanup and consolidation of rename_conflict_info
 - merge-recursive: Consolidate process_entry() and process_df_entry()
 - merge-recursive: Improve handling of rename target vs. directory addition
 - merge-recursive: Add comments about handling rename/add-source cases
 - merge-recursive: Make dead code for rename/rename(2to1) conflicts undead
 - merge-recursive: Fix deletion of untracked file in rename/delete conflicts
 - merge-recursive: When we detect we can skip an update, actually skip it
 - merge-recursive: Split update_stages_and_entry; only update stages at end
 - merge-recursive: Consolidate different update_stages functions
 - merge-recursive: Allow make_room_for_path() to remove D/F entries
 - merge-recursive: Split was_tracked() out of would_lose_untracked()
 - merge-recursive: Save D/F conflict filenames instead of unlinking them
 - merge-recursive: Fix code checking for D/F conflicts still being present
 - merge-recursive: Fix sorting order and directory change assumptions
 - merge-recursive: Fix recursive case with D/F conflict via add/add conflict
 - merge-recursive: Avoid working directory changes during recursive case
 - merge-recursive: Remember to free generated unique path names
 - merge-recursive: Mark some diff_filespec struct arguments const
 - merge-recursive: Correct a comment
 - merge-recursive: Make BUG message more legible by adding a newline
 - t6022: Add testcase for merging a renamed file with a simple change
 - t6022: New tests checking for unnecessary updates of files
 - t6022: Remove unnecessary untracked files to make test cleaner
 - t6036: criss-cross + rename/rename(1to2)/add-source + modify/modify
 - t6036: criss-cross w/ rename/rename(1to2)/modify+rename/rename(2to1)/modify
 - t6036: tests for criss-cross merges with various directory/file conflicts
 - t6036: criss-cross with weird content can fool git into clean merge
 - t6036: Add differently resolved modify/delete conflict in criss-cross test
 - t6042: Ensure rename/rename conflicts leave index and workdir in sane state
 - t6042: Add failing testcases for rename/rename/add-{source,dest} conflicts
 - t6042: Add tests for content issues with modify/rename/directory conflicts
 - t6042: Add a testcase where undetected rename causes silent file deletion
 - t6042: Add a pair of cases where undetected renames cause issues
 - t6042: Add failing testcase for rename/modify/add-source conflict
 - t6042: Add a testcase where git deletes an untracked file

Looked at up to 29/48; looks basically sound.

* jk/tag-contains-ab (2011-07-14) 5 commits
  (merged to 'next' on 2011-07-14 at 002a9d7)
 + Revert clock-skew based attempt to optimize tag --contains traversal
 + git skew: a tool to find how big a clock skew exists in the history
  (merged to 'next' on 2011-07-05 at f9cf575)
 + default core.clockskew variable to one day
 + limit "contains" traversals based on commit timestamp
 + tag: speed up --contains calculation
 (this branch is tangled with jk/generation-numbers.)

Reverted the commits near the tip.

* jk/clone-detached (2011-06-07) 4 commits
 - clone: always fetch remote HEAD
 - make copy_ref globally available
 - consider only branches in guess_remote_head
 - t: add tests for cloning remotes with detached HEAD

Somewhat involved bugfix. Seems to expose breakage in t5800 without the
stalled "transport-helper-fix" series.

* jl/submodule-add-relurl-wo-upstream (2011-06-06) 3 commits
  (merged to 'next' on 2011-07-13 at f989abb)
 + submodule add: clean up duplicated code
 + submodule add: allow relative repository path even when no url is set
 + submodule add: test failure when url is not configured in superproject
