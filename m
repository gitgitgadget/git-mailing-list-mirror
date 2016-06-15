From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2011, #03; Fri, 17)
Date: Tue, 21 Jun 2011 13:07:01 -0700
Message-ID: <7viprz6ja2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 22:07:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ7E7-000530-GI
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153Ab1FUUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 16:07:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab1FUUHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 16:07:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0203E4D9C;
	Tue, 21 Jun 2011 16:09:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=B
	SIzcvi/wwFOHXDmXfmo6mmEqDY=; b=C80vvN3l91w9tbcHEGZpxAt1uXcMizcjN
	i6d46meVmtm2fjqFoBTafSQtDgdGNkSsgnDQjji+3rJwMmsmEqJqcMG7WRal5HSu
	g0e2iBbSk1/m79k+RyFD9Ffwsd3sovIkPG6InKwkoCF9/Uuf3U2TBCVZFSZNOsTz
	bKad8roSjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WCP
	IPLwZn3us5KtIJ4U3oerlfXcCbfYM41FI5cmFmlQux3h3FiFC2btC49uSKWxzCXW
	CcVb2GIbyNMzS5rtUXmCNxEsENV1qEcw0LVD9nkp+KJm/eJxSs5eN1KvKMr2z3Lj
	yts6IYATI3GKyR5EO0oO9Bjn2kFp+NGGkDcms72M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF87E4D9B;
	Tue, 21 Jun 2011 16:09:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0E504D98; Tue, 21 Jun 2011
 16:09:14 -0400 (EDT)
X-master-at: 36bfb0e5f6004e4c4ac9334107dc185c316839a7
X-next-at: a2eb42042a14044c35525779dcf76ee92f3305a7
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56225198-9C42-11E0-9CA0-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176194>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

We have passed v1.7.6-rc2 and it seems things are really in releaseable
form, so I am tempted to skip -rc3 and tag the final sometime next week.

--------------------------------------------------
[New Topics]

* aw/rebase-i-p (2011-06-13) 1 commit
 - rebase -i -p: doesn't pick certain merge commits that are children of "upstream"

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

* fg/submodule-keep-updating (2011-06-13) 3 commits
 - git-submodule.sh: clarify the "should we die now" logic
 - submodule update: continue when a checkout fails
 - git-sh-setup: add die_with_status

* jc/no-gitweb-test-without-cgi-etc (2011-06-15) 1 commit
 - t/gitweb-lib.sh: skip gitweb tests when perl dependencies are not met

* jn/mime-type-with-params (2011-06-13) 1 commit
 - gitweb: Make $prevent_xss protection for 'blob_plain' more usable

* ln/gitweb-mime-types-split-at-blank (2011-06-15) 1 commit
 - gitweb: allow space as delimiter in mime.types

* md/interix-update (2011-06-15) 1 commit
 - Update the Interix default build configuration.

* rj/config-cygwin (2011-06-16) 3 commits
 - config.c: Make git_config() work correctly when called recursively
 - t1301-*.sh: Fix the 'forced modes' test on cygwin
 - help.c: Fix detection of custom merge strategy on cygwin

* di/no-no-existant (2011-06-16) 1 commit
 - Fix typo: existant->existent

* jk/archive-tar-filter (2011-06-15) 7 commits
 - archive: provide builtin .tar.gz filter
 - archive: match extensions from user-configured formats
 - archive: refactor format-guessing from filename
 - archive: advertise user tar-filters in --list
 - archive: support user tar-filters via --format
 - archive: add user-configurable tar-filter infrastructure
 - archive: reorder option parsing and config reading

--------------------------------------------------
[Stalled]

* js/ref-namespaces (2011-06-07) 4 commits
 . ref namespaces: documentation
 . ref namespaces: support remote repositories via upload-pack and receive-pack
 . ref namespaces: infrastructure
 . Fix prefix handling in ref iteration functions

Fairly involved feature enhancement, and breaks tests when merged to 'pu'.
Not urgent. Will not merge before 1.7.6.

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
Not urgent. Will not merge before 1.7.6.

--------------------------------------------------
[Cooking]

* jc/index-pack (2011-06-05) 9 commits
 - verify-pack: use index-pack --verify
 - index-pack: show histogram when emulating "verify-pack -v"
 - index-pack: start learning to emulate "verify-pack -v"
 - index-pack: a miniscule refactor
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Killed "verify-pack" ;-) The next will be to update fsck, which would be a
bigger task.

Not urgent. Will not merge before 1.7.6.

* js/i18n-windows (2011-06-06) 3 commits
  (merged to 'next' on 2011-06-06 at d8c4ba3)
 + Windows: teach getenv to do a case-sensitive search
 + mingw.c: move definition of mingw_getenv down
 + sh-i18n--envsubst: do not crash when no arguments are given

Looked sane but will wait for msysgit folks to take a look.
Not urgent. Will not merge before 1.7.6.

* an/shallow-doc (2011-06-08) 2 commits
 - Document the underlying protocol used by shallow repositories and --depth commands.
 - Fix documentation of fetch-pack that implies that the client can disconnect after sending wants.

Waiting for a review, but looked sensible.

* jc/legacy-loose-object (2011-06-08) 1 commit
 - sha1_file.c: "legacy" is really the current format

* jc/zlib-wrap (2011-06-10) 7 commits
 - zlib: allow feeding more than 4GB in one go
 - zlib: zlib can only process 4GB at a time
 - zlib: wrap deflateBound() too
 - zlib: wrap deflate side of the API
 - zlib: wrap inflateInit2 used to accept only for gzip format
 - zlib: wrap remaining calls to direct inflate/inflateEnd
 - zlib wrapper: refactor error message formatter

This replaces the earlier attempt to deal with the mismatch between our
expectation and what zlib API actually offers piecemeal.

* jk/clone-cmdline-config (2011-06-11) 10 commits
 - clone: accept config options on the command line
 - config: make git_config_parse_parameter a public function
 - remote: use new OPT_STRING_LIST
 - parse-options: add OPT_STRING_LIST helper
 - config: use strbuf_split_str instead of a temporary strbuf
 - strbuf: allow strbuf_split to work on non-strbufs
 - config: avoid segfault when parsing command-line config
 - config: die on error in command-line config
 - fix "git -c" parsing of values with equals signs
 - strbuf_split: add a max parameter

* jk/tag-contains-ab (2011-06-11) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

* jk/transport-helper-fix (2011-06-07) 8 commits
 - git_remote_helpers: push all refs during a non-local export
 - transport-helper: don't feed bogus refs to export push
 - teach remote-testgit to import multiple refs
 - teach remote-testgit to import non-HEAD refs
 - t5800: document some non-functional parts of remote helpers
 - t5800: factor out some ref tests
 - git-remote-testgit: exit gracefully after push
 - transport-helper: fix minor leak in push_refs_with_export

* db/http-cookies (2011-06-03) 1 commit
  (merged to 'next' on 2011-06-06 at 90d736a)
 + http: pass http.cookiefile using CURLOPT_COOKIEFILE

Fairly trivial enhancement.
Not urgent. Will not merge before 1.7.6.

* jc/maint-1.7.3-checkout-describe (2011-06-05) 1 commit
  (merged to 'next' on 2011-06-06 at 6a59bb7)
 + checkout -b <name>: correctly detect existing branch

Fairly trivial bugfix.
Not urgent. Will not merge before 1.7.6.

* jk/clone-detached (2011-06-07) 5 commits
 . remote-testgit: short-term fix to allow t5800 pass
 - clone: always fetch remote HEAD
 - make copy_ref globally available
 - consider only branches in guess_remote_head
 - t: add tests for cloning remotes with detached HEAD

Somewhat involved bugfix.
Not urgent. Will not merge before 1.7.6.

* jk/maint-1.7.2-status-ignored (2011-06-02) 2 commits
  (merged to 'next' on 2011-06-02 at 8626cc6)
 + git status --ignored: tests and docs
 + status: fix bug with missing --ignore files

Fairly trivial bugfix.
Not urgent. Will not merge before 1.7.6.

* jl/submodule-add-relurl-wo-upstream (2011-06-06) 3 commits
 - submodule add: clean up duplicated code
 - submodule add: allow relative repository path even when no url is set
 - submodule add: test failure when url is not configured in superproject

Not urgent. Will not merge before 1.7.6.

* rs/grep-color (2011-06-05) 3 commits
  (merged to 'next' on 2011-06-06 at fd6bae1)
 + grep: add --heading
 + grep: add --break
 + grep: fix coloring of hunk marks between files

Fairly straightforward feature enhancement.
Not urgent. Will not merge before 1.7.6.

* jc/diff-index-quick-exit-early (2011-05-31) 2 commits
  (merged to 'next' on 2011-06-01 at 79d868a)
 + diff-index --quiet: learn the "stop feeding the backend early" logic
 + Merge remote-tracking branch 'ko/maint' into jc/diff-index-quick-exit-early

Not urgent. Will not merge before 1.7.6.

* ef/maint-win-verify-path (2011-06-08) 5 commits
 - verify_dotfile(): do not assume '/' is the path seperator
  (merged to 'next' on 2011-06-07 at b418e05)
 + verify_path(): simplify check at the directory boundary
  (merged to 'next' on 2011-06-01 at f316f68)
 + verify_path: consider dos drive prefix
 + real_path: do not assume '/' is the path seperator
 + A Windows path starting with a backslash is absolute

Not urgent, but is sane. Will not merge before 1.7.6.

* jn/gitweb-js-blame (2011-05-27) 3 commits
  (merged to 'next' on 2011-06-01 at a984a1b)
 + gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
 + gitweb.js: No need for loop in blame_incremental's handleResponse()
 + gitweb.js: No need for inProgress in blame_incremental.js

Will cook a bit longer.

* mg/diff-stat-count (2011-05-27) 4 commits
  (merged to 'next' on 2011-06-01 at 5cdb776)
 + diff --stat-count: finishing touches
 + diff-options.txt: describe --stat-{width,name-width,count}
 + diff: introduce --stat-lines to limit the stat lines
 + diff.c: omit hidden entries from namelen calculation with --stat

Not urgent. Will not merge before 1.7.6.

* da/git-prefix-everywhere (2011-06-02) 4 commits
  (merged to 'next' on 2011-06-02 at 2ab66e7)
 + t/t7503-pre-commit-hook.sh: Add GIT_PREFIX tests
  (merged to 'next' on 2011-05-30 at 9480900)
 + git-mergetool--lib: Make vimdiff retain the current directory
 + git: Remove handling for GIT_PREFIX
 + setup: Provide GIT_PREFIX to built-ins

Not urgent. Will not merge before 1.7.6.

* jc/streaming-filter (2011-05-26) 8 commits
  (merged to 'next' on 2011-06-06 at 8ed6b3d)
 + t0021: test application of both crlf and ident
 + t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test
 + streaming: filter cascading
 + streaming filter: ident filter
 + Add LF-to-CRLF streaming conversion
 + stream filter: add "no more input" to the filters
 + Add streaming filter API
 + convert.h: move declarations for conversion from cache.h
 (this branch uses jc/streaming.)

Trivial lf-to-crlf and ident conversions can be performed without reading
everything in-core first.
Not urgent. Will not merge before 1.7.6.

* jk/combine-diff-binary-etc (2011-05-24) 5 commits
  (merged to 'next' on 2011-05-24 at 07cf180)
 + combine-diff: respect textconv attributes
 + refactor get_textconv to not require diff_filespec
 + combine-diff: handle binary files as binary
 + combine-diff: calculate mode_differs earlier
 + combine-diff: split header printing into its own function

Not urgent. Will not merge before 1.7.6.

* jc/advice-about-to-lose-commit (2011-05-24) 1 commit
  (merged to 'next' on 2011-05-30 at 42385cc)
 + checkout: make advice when reattaching the HEAD less loud

Not urgent. Will not merge before 1.7.6.

* jc/streaming (2011-05-26) 14 commits
  (merged to 'next' on 2011-05-26 at 7fdda8d)
 + sha1_file: use the correct type (ssize_t, not size_t) for read-style function
  (merged to 'next' on 2011-05-23 at 7fd0b52)
 + streaming: read loose objects incrementally
 + sha1_file.c: expose helpers to read loose objects
 + streaming: read non-delta incrementally from a pack
 + streaming_write_entry(): support files with holes
 + convert: CRLF_INPUT is a no-op in the output codepath
 + streaming_write_entry(): use streaming API in write_entry()
 + streaming: a new API to read from the object store
 + write_entry(): separate two helper functions out
 + unpack_object_header(): make it public
 + sha1_object_info_extended(): hint about objects in delta-base cache
 + sha1_object_info_extended(): expose a bit more info
 + packed_object_info_detail(): do not return a string
 + Merge branches 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming
 (this branch is used by jc/streaming-filter.)

Not urgent. Will not merge before 1.7.6.

* ab/i18n-scripts (2011-05-21) 48 commits
  (merged to 'next' on 2011-05-23 at 69164a3)
 + i18n: git-bisect bisect_next_check "You need to" message
 + i18n: git-bisect [Y/n] messages
 + i18n: git-bisect bisect_replay + $1 messages
 + i18n: git-bisect bisect_reset + $1 messages
 + i18n: git-bisect bisect_run + $@ messages
 + i18n: git-bisect die + eval_gettext messages
 + i18n: git-bisect die + gettext messages
 + i18n: git-bisect echo + eval_gettext message
 + i18n: git-bisect echo + gettext messages
 + i18n: git-bisect gettext + echo message
 + i18n: git-bisect add git-sh-i18n
 + i18n: git-stash drop_stash say/die messages
 + i18n: git-stash "unknown option" message
 + i18n: git-stash die + eval_gettext $1 messages
 + i18n: git-stash die + eval_gettext $* messages
 + i18n: git-stash die + eval_gettext messages
 + i18n: git-stash die + gettext messages
 + i18n: git-stash say + gettext messages
 + i18n: git-stash echo + gettext message
 + i18n: git-stash add git-sh-i18n
 + i18n: git-submodule "blob" and "submodule" messages
 + i18n: git-submodule "path not initialized" message
 + i18n: git-submodule "[...] path is ignored" message
 + i18n: git-submodule "Entering [...]" message
 + i18n: git-submodule $errmsg messages
 + i18n: git-submodule "Submodule change[...]" messages
 + i18n: git-submodule "cached cannot be used" message
 + i18n: git-submodule $update_module say + die messages
 + i18n: git-submodule die + eval_gettext messages
 + i18n: git-submodule say + eval_gettext messages
 + i18n: git-submodule echo + eval_gettext messages
 + i18n: git-submodule add git-sh-i18n
 + i18n: git-pull eval_gettext + warning message
 + i18n: git-pull eval_gettext + die message
 + i18n: git-pull die messages
 + i18n: git-pull add git-sh-i18n
 + i18n: git-am printf(1) message to eval_gettext
 + i18n: git-am core say messages
 + i18n: git-am "Falling back" say message
 + i18n: git-am "Apply?" message
 + i18n: git-am clean_abort messages
 + i18n: git-am cannot_fallback messages
 + i18n: git-am die messages
 + i18n: git-am gettext + gettext to stderr message
 + i18n: git-am eval_gettext messages
 + i18n: git-am multi-line getttext $msg; echo
 + i18n: git-am one-line gettext $msg; echo
 + i18n: git-am add git-sh-i18n

Rerolled.
Will cook a bit longer.
