From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2011, #02; Wed, 13)
Date: Wed, 13 Jul 2011 23:01:00 -0700
Message-ID: <7v7h7l4d0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathon Mah <me@JonathonMah.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 08:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhF7y-0008Dq-3n
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 08:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab1GNGKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 02:10:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab1GNGKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 02:10:19 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2011 02:10:19 EDT
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B06B24CF;
	Thu, 14 Jul 2011 02:01:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=V
	R3D8ylwuqSBBwcgHcLKWBX/PJg=; b=ZFcwMS1A/mlLYNBHN9ARcvodOFzEN8mrx
	7sga0dDcTrivU3DqZdSom8YgKE4wodrv3FYCD/5F0fmxmZtAPxW356or4aZJOYS1
	mFdEGHLE06cmO2hJ8P11DwEM2QZPELXQG6k4J6UDyRIAb3uZRVVdaj1JWs/D3N+G
	6GtMUk44As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=J5iTjOWp/nmFVjFgibfHl+jZmfyWwMMPHo85311wj85E70D0NrpEBDFp
	zZ8f9nd++zX9pWmoGdc5xvlitlN494A5P7SvJXRhHmjRkru8LVeZdk92PasjsPk2
	QRldkf46miyPLPpCjjXR/odVgQe4VlnW/pxJ/x1aTyfkjfbrTkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5908E24CE;
	Thu, 14 Jul 2011 02:01:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BC5A24CD; Thu, 14 Jul 2011
 02:01:02 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-master-at: 55272570dbe1c3f2a6f2f142c4bfe806665cd111
X-next-at: 867dc3783dfcad0e8c9bdd1c8d299d5a82f5babc
X-Pobox-Relay-ID: A7472D70-ADDE-11E0-A83F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177102>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[New Topics]

* bw/log-all-ref-updates-doc (2011-07-12) 1 commit
 - Documentation: clearly specify what refs are honored by core.logAllRefUpdates

* di/fast-import-doc (2011-07-13) 2 commits
 - doc/fast-import: document feature import-marks-if-exists
 - doc/fast-import: clarify notemodify command

* dz/connect-error-report (2011-07-13) 2 commits
 - connect.c: (fixup) report errors from failed socket(2) call as well
 - Do not log unless all connect() attempts fail

Needs squashing these into one.

* jc/pack-order-tweak (2011-07-08) 2 commits
 - pack-objects: optimize "recency order"
 - core: log offset pack data accesses happened

* jk/generation-numbers (2011-07-11) 6 commits
 - limit "contains" traversals based on commit generation
 - pretty: support %G to show the generation number of a commit
 - commit: add commit_generation function
 - add object-cache infrastructure
 - decorate: allow storing values instead of pointers
 + tag: speed up --contains calculation
 (this branch is tangled with jk/tag-contains-ab.)

Getting rerolled.

* js/maint-add-path-stat-pwd (2011-07-11) 1 commit
 - get_pwd_cwd(): Do not trust st_dev/st_ino blindly

Will merge to "next".

* ms/help-unknown (2011-07-08) 1 commit
 - help_unknown_cmd: do not propose an "unknown" cmd

Will merge to "next".

* mz/doc-rebase-abort (2011-07-11) 1 commit
 - git-rebase.txt: clarify that --abort checks out <branch>

Will merge to "next".

--------------------------------------------------
[Graduated to "master"]

* an/shallow-doc (2011-06-08) 2 commits
  (merged to 'next' on 2011-07-01 at 6ba80ef)
 + Document the underlying protocol used by shallow repositories and --depth commands.
 + Fix documentation of fetch-pack that implies that the client can disconnect after sending wants.

* aw/rebase-i-p (2011-06-19) 1 commit
  (merged to 'next' on 2011-07-01 at df3f3d8)
 + rebase -i -p: include non-first-parent commits in todo list

* bc/submodule-foreach-stdin-fix-1.7.4 (2011-06-29) 2 commits
  (merged to 'next' on 2011-07-01 at 4651925)
 + git-submodule.sh: preserve stdin for the command spawned by foreach
 + t/t7407: demonstrate that the command called by 'submodule foreach' loses stdin

* fg/submodule-keep-updating (2011-06-13) 3 commits
  (merged to 'next' on 2011-07-01 at 227827c)
 + git-submodule.sh: clarify the "should we die now" logic
 + submodule update: continue when a checkout fails
 + git-sh-setup: add die_with_status

* fk/relink-upon-ldflags-update (2011-06-22) 1 commit
  (merged to 'next' on 2011-07-01 at 69b57d0)
 + Makefile: Track changes to LDFLAGS and relink when necessary

* jc/legacy-loose-object (2011-06-08) 1 commit
  (merged to 'next' on 2011-07-01 at 5561971)
 + sha1_file.c: "legacy" is really the current format

* jc/maint-cygwin-trust-executable-bit-default (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-01 at d85aa04)
 + cygwin: trust executable bit by default

Fix for an ancient regression.

* jc/no-gitweb-test-without-cgi-etc (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 1db3fa4)
 + t/gitweb-lib.sh: skip gitweb tests when perl dependencies are not met

* jl/maint-fetch-recursive-fix (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-01 at 476eee4)
 + fetch: Also fetch submodules in subdirectories in on-demand mode

* jn/doc-dashdash (2011-06-29) 2 commits
  (merged to 'next' on 2011-07-01 at 5d51929)
 + Documentation/i18n: quote double-dash for AsciiDoc
 + Merge branch 'jn/maint-doc-dashdash' into jn/doc-dashdash
 (this branch uses jn/maint-doc-dashdash.)

* jn/maint-doc-dashdash (2011-06-29) 1 commit
  (merged to 'next' on 2011-07-01 at 55ab98d)
 + Documentation: quote double-dash for AsciiDoc
 (this branch is used by jn/doc-dashdash.)

Will merge to "maint" later.

* js/rebase-typo-branch-squelch-usage (2011-06-29) 1 commit
  (merged to 'next' on 2011-07-01 at b5b4c03)
 + rebase: do not print lots of usage hints after an obvious error message

* ln/gitweb-mime-types-split-at-blank (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 765aa1e)
 + gitweb: allow space as delimiter in mime.types

* md/interix-update (2011-06-15) 1 commit
  (merged to 'next' on 2011-07-01 at 0bc327d)
 + Update the Interix default build configuration.

* nk/ref-doc (2011-06-23) 7 commits
  (merged to 'next' on 2011-07-01 at 9ff278d)
 + glossary: clarify description of HEAD
 + glossary: update description of head and ref
 + glossary: update description of "tag"
 + git.txt: de-emphasize the implementation detail of a ref
 + check-ref-format doc: de-emphasize the implementation detail of a ref
 + git-remote.txt: avoid sounding as if loose refs are the only ones in the world
 + git-remote.txt: fix wrong remote refspec

* rj/config-cygwin (2011-06-16) 3 commits
  (merged to 'next' on 2011-07-01 at 6da4aa5)
 + config.c: Make git_config() work correctly when called recursively
 + t1301-*.sh: Fix the 'forced modes' test on cygwin
 + help.c: Fix detection of custom merge strategy on cygwin

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

* sr/transport-helper-fix (2011-06-19) 20 commits
 - transport-helper: implement marks location as capability
 - transport-helper: Use capname for gitdir capability too
 - transport-helper: export is no longer always the last command
 - transport-helper: change import semantics
 - transport-helper: update ref status after push with export
 - transport-helper: use the new done feature where possible
 - transport-helper: check status code of finish_command
 - transport-helper: factor out push_update_refs_status
 - fast-export: support done feature
 - fast-import: introduce 'done' command
 - git-remote-testgit: fix error handling
 - git-remote-testgit: only push for non-local repositories
 - remote-curl: accept empty line as terminator
 - git_remote_helpers: push all refs during a non-local export
 - transport-helper: don't feed bogus refs to export push
 - teach remote-testgit to import non-HEAD refs
 - t5800: document some non-functional parts of remote helpers
 - t5800: use skip_all instead of prereq
 - t5800: factor out some ref tests
 - transport-helper: fix minor leak in push_refs_with_export

At least Patch 10/20 (git-remote-testgit: fix error handling) and Patch
15/20 (transport-helper: use the new done feature where possible) need a
reroll.

* jm/mergetool-pathspec (2011-06-22) 2 commits
 - mergetool: Don't assume paths are unmerged
 - mergetool: Add tests for filename with whitespace

I think this is a good idea, but it probably needs a re-roll.
Cf. $gmane/176254, 176255, 166256

--------------------------------------------------
[Cooking]

* jc/maint-mergetool-read-fix (2011-07-01) 1 commit
 - mergetool: check return value from read

Will merge to "next".

* nk/branch-v-abbrev (2011-07-01) 1 commit
 - branch -v: honor core.abbrev

Perhaps needs an updated commit log message?

* jc/checkout-reflog-fix (2011-07-06) 3 commits
 - Merge commit 'v1.7.6' into jc/checkout-reflog-fix
 - Merge commit 'v1.7.0' into jc/checkout-reflog-fix
 - Merge commit 'v1.6.0' into jc/checkout-reflog-fix
 (this branch uses jc/maint-checkout-reflog-fix.)

Will merge to "next".

* jc/maint-checkout-reflog-fix (2011-07-06) 1 commit
 - checkout: do not write bogus reflog entry out
 (this branch is used by jc/checkout-reflog-fix.)

* js/ref-namespaces (2011-07-11) 4 commits
 - ref namespaces: documentation
 - ref namespaces: Support remote repositories via upload-pack and receive-pack
 - ref namespaces: infrastructure
 - Fix prefix handling in ref iteration functions

Would be nice to have some tests before merging to "next", no?

* mz/doc-synopsis-verse (2011-07-06) 1 commit
 - Documentation: use [verse] for SYNOPSIS sections

Will merge to "next".

* rc/histogram-diff (2011-07-12) 7 commits
 - xdiff/xprepare: use a smaller sample size for histogram diff
 - xdiff/xprepare: skip classification
 - teach --histogram to diff
 - t4033-diff-patience: factor out tests
 - xdiff/xpatience: factor out fall-back-diff function
 - xdiff/xprepare: refactor abort cleanups
 - xdiff/xprepare: use memset()

* rr/revert-cherry-pick-continue (2011-07-11) 17 commits
 - revert: Introduce --continue to continue the operation
 - revert: Introduce --reset to remove sequencer state
 - revert: Remove sequencer state when no commits are pending
 - reset: Make hard reset remove the sequencer state
 - revert: Introduce a layer of indirection over pick_commits
 - revert: Save command-line options for continuing operation
 - revert: Save data for continuing after conflict resolution
 - sequencer: Announce sequencer state location
 - revert: Don't create invalid replay_opts in parse_args
 - revert: Separate cmdline parsing from functional code
 - revert: Introduce struct to keep command-line options
 - revert: Eliminate global "commit" variable
 - revert: Propogate errors upwards from do_pick_commit
 - revert: Rename no_replay to record_origin
 - revert: Don't check lone argument in get_encoding
 - revert: Inline add_message_to_msg function
 - advice: Introduce error_resolve_conflict

* dc/stash-con-untracked (2011-06-26) 1 commit
  (merged to 'next' on 2011-07-13 at 9ed0d1d)
 + stash: Add --include-untracked option to stash and remove all untracked files

* jc/submodule-sync-no-auto-vivify (2011-06-26) 2 commits
  (merged to 'next' on 2011-07-05 at b207ba3)
 + submodule add: always initialize .git/config entry
 + submodule sync: do not auto-vivify uninteresting submodule

Will merge to "master".

* jn/gitweb-search (2011-06-22) 4 commits
  (merged to 'next' on 2011-07-13 at 455acdd)
 + gitweb: Make git_search_* subroutines render whole pages
 + gitweb: Clean up code in git_search_* subroutines
 + gitweb: Split body of git_search into subroutines
 + gitweb: Check permissions first in git_search

* ak/gcc46-profile-feedback (2011-06-20) 3 commits
  (merged to 'next' on 2011-07-01 at 81bc0a7)
 + Add explanation of the profile feedback build to the README
 + Add profile feedback build to git
 + Add option to disable NORETURN

Will merge to "master".

* jk/tag-list-multiple-patterns (2011-06-20) 1 commit
  (merged to 'next' on 2011-07-05 at 8db1bf0)
 + tag: accept multiple patterns for --list

Will merge to "master".

* jk/maint-config-param (2011-06-22) 6 commits
  (merged to 'next' on 2011-07-05 at 2dce181)
 + config: use strbuf_split_str instead of a temporary strbuf
 + strbuf: allow strbuf_split to work on non-strbufs
 + config: avoid segfault when parsing command-line config
 + config: die on error in command-line config
 + fix "git -c" parsing of values with equals signs
 + strbuf_split: add a max parameter
 (this branch is used by jk/clone-cmdline-config.)

Will merge to "master".

* jk/clone-cmdline-config (2011-06-22) 4 commits
  (merged to 'next' on 2011-07-05 at a022613)
 + clone: accept config options on the command line
 + config: make git_config_parse_parameter a public function
 + remote: use new OPT_STRING_LIST
 + parse-options: add OPT_STRING_LIST helper
 (this branch uses jk/maint-config-param.)

Will merge to "master".

* jn/gitweb-split-header-html (2011-06-22) 1 commit
  (merged to 'next' on 2011-07-05 at c60d9dc)
 + gitweb: Refactor git_header_html

Will merge to "master".

* en/merge-recursive (2011-06-13) 49 commits
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

Haven't looked at the whole series yet.

* jn/mime-type-with-params (2011-06-30) 2 commits
  (merged to 'next' on 2011-07-05 at 7caaf3b)
 + gitweb: Serve */*+xml 'blob_plain' as text/plain with $prevent_xss
 + gitweb: Serve text/* 'blob_plain' as text/plain with $prevent_xss

Will merge to "master".

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

Will merge to "master".

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

Killed "verify-pack" ;-) The next will be to update fsck, which would be a
bigger task.

Will merge to "master".

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

Will merge to "master".

* jk/tag-contains-ab (2011-06-30) 4 commits
 - git skew: a tool to find how big a clock skew exists in the history
  (merged to 'next' on 2011-07-05 at f9cf575)
 + default core.clockskew variable to one day
 + limit "contains" traversals based on commit timestamp
 + tag: speed up --contains calculation
 (this branch is tangled with jk/generation-numbers.)

Will revert the two commits from "next" once metadata-cache series gets
more stable.

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
