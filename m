From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2010, #03; Sun, 9)
Date: Sun, 09 May 2010 00:32:38 -0700
Message-ID: <7vr5lla5t5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 09:32:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB10O-0004Dh-Rp
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 09:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0EIHcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 03:32:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33156 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0EIHcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 03:32:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE5ECB1947;
	Sun,  9 May 2010 03:32:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=NheP
	u9IhiJlDjOl1U9yqZA2dYm4=; b=p2zOw7RJAEVzzLk7n/qw5yFWqB7OpEwU0tra
	PN+rClV9A1vUTJeEm7iMcZQRFCO7arWl5cUKodbpPb60toP0qdZjH5vDDUxduaeT
	/ZeuunmJF7+DTlqbCoe4Z1ozXCnp72mD4+rqpvTxSgy53F3BAMJx5ljPIqSvOMLc
	g2D7nGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Arl
	YQbTilqh1oefP+by8FL+X+3eWLangpftZ2AAbzNnZp/1Fj3u+5QanuarBs/OtmS9
	AbrzOanfJQCyjTp4gIExhO1HBErk0ucGwF41X8bDoMcWOKLDa9GJsI+xgfuI6jVD
	ChLNu7pVHoYVVncgo21yJj9IEZpyZovJ+q0XvwJA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 98B45B1945;
	Sun,  9 May 2010 03:32:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 605FCB1942; Sun,  9 May
 2010 03:32:40 -0400 (EDT)
X-master-at: 212f0ba357cde43d1cf66692f73a2f662d13ac55
X-next-at: 07419c952633f427ce186bf4c2b9a49592c9d3d3
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DBB7ACA-5B3D-11DF-B86B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146708>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Tonight's 'master' merges many topics that have been cooking for a few
weeks in 'next' as the first batch of 1.7.2 cycle.  I will hopefully be
moving some topics in 'pu' to 'next' as the next step tomorrow.  I'm in
the middle of moving and I expect that I won't be back up to speed until
later this month.

By the way, in addition to more authoritative mirrors k.org and repo.or.cz
that have only the four primary integration branches, I am pushing all the
active topic branches broken out to git://github.com/gitster/git.git/ as
an experiment.

--------------------------------------------------
[New Topics]

* jn/gitweb-fastcgi (2010-05-07) 5 commits
 - gitweb: Add support for FastCGI, using CGI::Fast
 - gitweb: Put all per-connection code in run() subroutine
 - gitweb: Use nonlocal jump instead of 'exit' in die_error
 - gitweb: href(..., -path_info => 0|1)
 - Export more test-related variables when running external tests
 (this branch shares commits with jn/gitweb-caching-prep.)

* jn/make-header-dependency (2010-05-08) 2 commits
 - Makefile: let header dependency checker override COMPUTE_HEADER_DEPENDENCIES
 - Makefile: fix header dependency checker to allow NO_CURL builds

* js/try-to-free-stackable (2010-05-08) 2 commits
 - Do not call release_pack_memory in malloc wrappers when GIT_TRACE is used
 - Have set_try_to_free_routine return the previous routine
 (this branch uses np/malloc-threading.)

Should be Ok for 'next'.

--------------------------------------------------
[Graduated to "master"]

* ab/commit-empty-message (2010-04-06) 1 commit
  (merged to 'next' on 2010-05-04 at 54c2e47)
 + Add option to git-commit to allow empty log messages

(has been in 'next' since 2010-04-07)

* bg/apply-blank-trailing-context (2010-04-08) 1 commit
  (merged to 'next' on 2010-05-04 at 31f3482)
 + apply: Allow blank *trailing* context lines to match beyond EOF

(has been in 'next' since 2010-04-14)

* bg/send-email-smtpdomain (2010-04-10) 4 commits
  (merged to 'next' on 2010-05-04 at 2afbe2c)
 + send-email: Cleanup smtp-domain and add config
 + Document send-email --smtp-domain
 + send-email: Don't use FQDNs without a '.'
 + send-email: Cleanup { style

(has been in 'next' since 2010-04-14)

* cc/revert-strategy (2010-03-31) 5 commits
  (merged to 'next' on 2010-05-04 at 6d44a83)
 + revert: add "--strategy" option to choose merge strategy
 + merge: make function try_merge_command non static
 + merge: refactor code that calls "git merge-STRATEGY"
 + revert: refactor merge recursive code into its own function
 + revert: use strbuf to refactor the code that writes the merge message

(has been in 'next' since 2010-04-05)

* cw/ws-indent-with-tab (2010-04-03) 6 commits
  (merged to 'next' on 2010-05-04 at 1d7aca4)
 + whitespace: tests for git-apply --whitespace=fix with tab-in-indent
 + whitespace: add tab-in-indent support for --whitespace=fix
 + whitespace: replumb ws_fix_copy to take a strbuf *dst instead of char *dst
 + whitespace: tests for git-diff --check with tab-in-indent error class
 + whitespace: add tab-in-indent error class
 + whitespace: we cannot "catch all errors known to git" anymore

(has been in 'next' since 2010-04-05)

* eb/unpretty-b-format (2010-03-24) 1 commit
  (merged to 'next' on 2010-05-04 at a466ed8)
 + Add `%B' in format strings for raw commit body in `git log' and friends

(has been in 'next' since 2010-04-07)

* hg/maint-attr-fix (2010-04-06) 3 commits
  (merged to 'next' on 2010-05-04 at 8b98845)
 + attr: Expand macros immediately when encountered.
 + attr: Allow multiple changes to an attribute on the same line.
 + attr: Fixed debug output for macro expansion.

(has been in 'next' since 2010-04-14)

* jc/maint-reflog-expire-unreachable (2010-04-07) 1 commit
  (merged to 'next' on 2010-05-04 at 4efe837)
 + reflog --expire-unreachable: avoid merge-base computation
 (this branch is used by jc/maint-no-reflog-expire-unreach-for-head.)

(has been in 'next' since 2010-04-22)

* jc/test-sleepless (2010-04-06) 1 commit
  (merged to 'next' on 2010-05-04 at 9ff84b0)
 + war on "sleep" in tests

(has been in 'next' since 2010-04-07)

* jk/cached-textconv (2010-04-01) 5 commits
  (merged to 'next' on 2010-05-04 at e4b72a0)
 + diff: avoid useless filespec population
 + diff: cache textconv output
 + textconv: refactor calls to run_textconv
 + introduce notes-cache interface
 + make commit_tree a library function

(has been in 'next' since 2010-04-02)

* mh/status-optionally-refresh (2010-04-03) 3 commits
  (merged to 'next' on 2010-05-04 at be164f0)
 + t7508: add a test for "git status" in a read-only repository
 + git status: refresh the index if possible
 + t7508: add test for "git status" refreshing the index

(has been in 'next' since 2010-04-05)

* pc/remove-warn (2010-03-26) 4 commits
  (merged to 'next' on 2010-05-04 at c79c1e6)
 + Remove a redundant errno test in a usage of remove_path
 + Introduce remove_or_warn function
 + Implement the rmdir_or_warn function
 + Generalise the unlink_or_warn function

(has been in 'next' since 2010-04-02)

* rc/ls-remote-default (2010-04-09) 1 commit
  (merged to 'next' on 2010-05-04 at 2af33e1)
 + ls-remote: fall-back to default remotes when no remote specified

(has been in 'next' since 2010-04-14)

* rc/maint-curl-helper (2010-04-08) 3 commits
  (merged to 'next' on 2010-05-04 at c32988d)
 + remote-curl: ensure that URLs have a trailing slash
 + http: make end_url_with_slash() public
 + t5541-http-push: add test for URLs with trailing slash

(has been in 'next' since 2010-04-14)

* sc/http-late-auth (2010-04-01) 1 commit
  (merged to 'next' on 2010-05-04 at 23ae2e8)
 + Prompt for a username when an HTTP request 401s

(has been in 'next' since 2010-04-02)

* sd/log-decorate (2010-04-08) 6 commits
  (merged to 'next' on 2010-05-04 at 6e54ae9)
 + log.decorate: only ignore it under "log --pretty=raw"
 + script with rev-list instead of log
 + log --pretty/--oneline: ignore log.decorate
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

(has been in 'next' since 2010-04-08)

--------------------------------------------------
[Stalled]

* jc/rev-list-ancestry-path (2010-04-20) 1 commit
 - revision: --ancestry-path

Just an illustration patch.  merge simplification logic used when
pathspecs are in effect interacts with this rather badly.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* js/grep-open (2010-05-01) 3 commits
 - grep: do not ignore return value from chdir()
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'
 (this branch is used by jp/hold-string-list-sanity.)

Probably needs to support --no-index mode as well.

* jp/hold-string-list-sanity (2010-04-06) 9 commits
 . string_list: Fix argument order for string_list_append
 . Merge branch 'sr/remote-helper-export' into HEAD
 . Merge branch 'js/grep-open' into HEAD
 . Merge branch 'sb/fmt-merge-msg' into HEAD
 . string_list: Fix argument order for string_list_lookup
 . string_list: Fix argument order for string_list_insert_at_index
 . string_list: Fix argument order for string_list_insert
 . string_list: Fix argument order for for_each_string_list
 . string_list: Fix argument order for print_string_list
 (this branch uses js/grep-open and sr/remote-helper-export.)

Building this on top of slushy codebase is not a very promising endeavor.
Good thing to do, but it came at a bad time.

--------------------------------------------------
[Cooking]

* jn/gitweb-syntax-highlight (2010-04-27) 2 commits
 - gitweb: Refactor syntax highlighting support
 - gitweb: Syntax highlighting support

* jn/maint-amend-missing-name (2010-05-02) 1 commit
 - commit --amend: cope with missing display name

Should be Ok for 'next'.

* rs/diff-no-minimal (2010-05-02) 1 commit
 - git diff too slow for a file

Should be Ok for 'next'.

* ab/test-cleanup (2010-05-07) 2 commits
 - Turn setup code in t2007-checkout-symlink.sh into a test
 - Move t6000lib.sh to lib-*

Should be Ok for 'next'.

* by/blame-doc-m-c (2010-05-06) 1 commit
 - blame-options.txt: Add default value for `-M/-C` options.

* by/log-follow (2010-05-06) 3 commits
 - Make git log --follow find copies among unmodified files.
 - Make diffcore_std only can run once before a diff_flush
 - Add a macro DIFF_QUEUE_CLEAR.

Should be Ok for 'next'.

* eb/crlf (2010-05-08) 4 commits
 - Add per-repository eol normalization
 - Pass eol conv mode as an argument instead of using global auto_crlf
 - Add tests for per-repository eol normalization
 - Add "core.eolStyle" variable to control end-of-line conversion

* jn/notes-doc (2010-05-08) 8 commits
 - Documentation/notes: nitpicks
 - Documentation/notes: clean up description of rewriting configuration
 - Documentation/notes: simplify treatment of default display refs
 - Documentation/log: add a CONFIGURATION section
 - Documentation/notes: simplify treatment of default notes ref
 - Documentation/notes: add configuration section
 - Documentation/notes: describe content of notes blobs
 - Documentation/notes: document format of notes trees

* mg/advice-statushints (2010-04-22) 2 commits
 - wt-status: take advice.statusHints seriously
 - t7508: test advice.statusHints

Should be Ok for 'next'.

* cb/maint-stash-orphaned-file (2010-04-18) 2 commits
  (merged to 'next' on 2010-05-04 at 38488ba)
 + stash tests: stash can lose data in a file removed from the index
 + stash: Don't overwrite files that have gone from the index

(has been in 'next' since 2010-04-22)

* jn/maint-bundle (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at f2086f5)
 + fix "bundle --stdin" segfault
 + t5704 (bundle): add tests for bundle --stdin

(has been in 'next' since 2010-04-22)

* pb/patch-id-plus (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at 59881b8)
 + patch-id: Add support for mbox format
 + patch-id: extract parsing one diff out of generate_id_list

(has been in 'next' since 2010-04-22)

* rr/doc-submitting (2010-04-19) 1 commit
  (merged to 'next' on 2010-05-04 at 5f040bd)
 + SubmittingPatches: Add new section about what to base work on

(has been in 'next' since 2010-04-22)

* st/remote-tags-no-tags (2010-04-20) 2 commits
 - remote add: add a --[no-]tags option
 - Honor "tagopt = --tags" configuration option

Should be Ok for 'next'.

* cb/assume-unchanged-fix (2010-05-01) 2 commits
 - Documentation: git-add does not update files marked "assume unchanged"
 - do not overwrite files marked "assume unchanged"

* jn/fsck-ident (2010-04-24) 1 commit
 - fsck: check ident lines in commit objects

There also was a companion patch to fast-import to deal with foreign SCM
interface that may not have human-readable author identifier.

Should be Ok for 'next'.

* jn/gitweb-caching-prep (2010-04-24) 5 commits
 - gitweb: Move generating page title to separate subroutine
 - gitweb: Add custom error handler using die_error
 - gitweb: Use nonlocal jump instead of 'exit' in die_error
 - gitweb: href(..., -path_info => 0|1)
 - Export more test-related variables when running external tests
 (this branch shares commits with jn/gitweb-fastcgi.)

Should be Ok for 'next'.

* jn/gitweb-install (2010-05-01) 2 commits
 - gitweb: Create install target for gitweb in Makefile
 - gitweb: Improve installation instructions in gitweb/INSTALL

Should be Ok for 'next'.

* jn/gitweb-our-squelch (2010-04-30) 1 commit
 - gitweb: Silence 'Variable VAR may be unavailable' warnings

Should be Ok for 'next'.

* jn/maint-request-pull (2010-05-07) 3 commits
 - t5150: protect backslash with backslash in shell
 - request-pull: protect against OPTIONS_KEEPDASHDASH from environment
 - tests for request-pull
 (this branch is used by jn/request-pull.)

* jn/request-pull (2010-04-24) 2 commits
 - adapt request-pull tests for new pull request format
 - Merge branch 'jn/maint-request-pull' into jn/request-pull
 (this branch uses jn/maint-request-pull.)

Should be Ok for 'next'.

* jn/shortlog (2010-05-03) 5 commits
 - pretty: Respect --abbrev option
 - shortlog: Document and test --format option
 - t4201 (shortlog): Test output format with multiple authors
 - t4201 (shortlog): guard setup with test_expect_success
 - Documentation/shortlog: scripted users should not rely on implicit HEAD

Should be Ok for 'next'.

* wp/pretty-enhancement (2010-05-08) 4 commits
 - pretty: initialize new cmt_fmt_map to 0
 - pretty: add aliases for pretty formats
 - pretty: add infrastructure for commit format aliases
 - pretty: make it easier to add new formats

Should be Ok for 'next'.

* jn/t7006-fixup (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at 490ab5d)
 + t7006: guard cleanup with test_expect_success

(has been in 'next' since 2010-04-22)

* js/maint-receive-pack-symref-alias (2010-04-19) 3 commits
  (merged to 'next' on 2010-05-04 at 259f4f1)
 + t5516-fetch-push.sh: style cleanup
 + receive-pack: detect aliased updates which can occur with symrefs
 + receive-pack: switch global variable 'commands' to a parameter

(has been in 'next' since 2010-04-22)

* sp/maint-dumb-http-pack-reidx (2010-04-19) 12 commits
  (merged to 'next' on 2010-05-04 at 166443a)
 + http.c::new_http_pack_request: do away with the temp variable filename
 + http-fetch: Use temporary files for pack-*.idx until verified
 + http-fetch: Use index-pack rather than verify-pack to check packs
 + Allow parse_pack_index on temporary files
 + Extract verify_pack_index for reuse from verify_pack
 + Introduce close_pack_index to permit replacement
 + http.c: Remove unnecessary strdup of sha1_to_hex result
 + http.c: Don't store destination name in request structures
 + http.c: Drop useless != NULL test in finish_http_pack_request
 + http.c: Tiny refactoring of finish_http_pack_request
 + t5550-http-fetch: Use subshell for repository operations
 + http.c: Remove bad free of static block

(has been in 'next' since 2010-04-22)

* hg/id-munging (2010-04-06) 2 commits
 - convert: Keep foreign $Id$ on checkout.
 - convert: Safer handling of $Id$ contraction.

* jn/submodule-basic-test (2010-04-10) 3 commits
  (merged to 'next' on 2010-05-04 at 0bec27a)
 + t7400: clarify submodule update tests
 + t7400: clarify 'submodule add' tests
 + t7400: split setup into multiple tests

(has been in 'next' since 2010-04-22)

* np/index-pack-memsave (2010-04-12) 3 commits
  (merged to 'next' on 2010-05-04 at 366b014)
 + index-pack: smarter memory usage when appending objects
 + index-pack: rationalize unpack_entry_data()
 + index-pack: smarter memory usage when resolving deltas

(has been in 'next' since 2010-04-22)

* jc/am-3-show-corrupted-patch (2010-04-09) 1 commit
  (merged to 'next' on 2010-05-04 at 951f0e6)
 + am -3: recover the diagnostic messages for corrupt patches

(has been in 'next' since 2010-04-22)

* jc/maint-no-reflog-expire-unreach-for-head (2010-04-09) 3 commits
  (merged to 'next' on 2010-05-04 at d23a180)
 + reflog --expire-unreachable: special case entries in "HEAD" reflog
 + more war on "sleep" in tests
 + Document gc.<pattern>.reflogexpire variables

(has been in 'next' since 2010-04-22)

* cw/maint-exec-defpath (2010-04-15) 2 commits
  (merged to 'next' on 2010-05-04 at 8d1591f)
 + autoconf: Check if <paths.h> exists and set HAVE_PATHS_H
 + exec_cmd.c: replace hard-coded path list with one from <paths.h>

(has been in 'next' since 2010-04-22)

* tr/word-diff (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at d191b25)
 + diff: add --word-diff option that generalizes --color-words

(has been in 'next' since 2010-04-22)
There are gitk patches that go with this series.

* sp/maint-describe-tiebreak-with-tagger-date (2010-04-12) 5 commits
  (merged to 'next' on 2010-05-04 at af2d605)
 + describe: Break annotated tag ties by tagger date
 + tag.c: Parse tagger date (if present)
 + tag.c: Refactor parse_tag_buffer to be saner to program
 + tag.h: Remove unused signature field
 + tag.c: Correct indentation

(has been in 'next' since 2010-04-22)

* jc/status-show-ignored (2010-05-01) 6 commits
  (merged to 'next' on 2010-05-04 at 8b32120)
 + wt-status: fix 'fprintf' compilation warning
 + status: --ignored option shows ignored files
 + wt-status: rename and restructure status-print-untracked
 + wt-status: collect ignored files
 + wt-status: plug memory leak while collecting untracked files
 + wt-status: remove unused workdir_untracked member

(has been in 'next' since 2010-05-01)

I am negative about conflating the JSON output to the mix at this point.
Let's stabilize "status" with the existing --porcelain/-z option first.

* np/malloc-threading (2010-04-08) 2 commits
  (merged to 'next' on 2010-05-04 at 1b0567f)
 + Thread-safe xmalloc and xrealloc needs a recursive mutex
 + Make xmalloc and xrealloc thread-safe
 (this branch is used by js/try-to-free-stackable.)

(has been in 'next' since 2010-04-10)

The fix should eventually go to 'maint' and 'master'.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-05-04 at 2644e74)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

(all except for the tip has been in 'next' since 2010-03-20).

* sr/remote-helper-export (2010-04-12) 9 commits
  (merged to 'next' on 2010-05-04 at 519ab16)
 + t5800: testgit helper requires Python support
 + Makefile: Simplify handling of python scripts
 + remote-helpers: add tests for testgit helper
 + remote-helpers: add testgit helper
 + remote-helpers: add support for an export command
 + remote-helpers: allow requesing the path to the .git directory
 + fast-import: always create marks_file directories
 + clone: also configure url for bare clones
 + clone: pass the remote name to remote_get
 (this branch is used by jp/hold-string-list-sanity.)

(has been in 'next' since 2010-04-12)

* ld/discovery-limit-to-fs (2010-04-04) 6 commits
 - write-index: check and warn when worktree crosses a filesystem boundary
  (merged to 'next' on 2010-05-04 at b7118ad)
 + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
 + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
 + Add support for GIT_ONE_FILESYSTEM
 + truncate cwd string before printing error message
 + config.c: remove static keyword from git_env_bool()

(all except for the tip has been in 'next' since 2010-04-07)

The tip one is a bit iffy.

* em/checkout-orphan (2010-03-21) 1 commit
  (merged to 'next' on 2010-05-04 at ddb45fc)
 + git checkout: create unparented branch by --orphan

(has been in 'next' since 2010-03-28)

Perhaps needs a bit of documentation updates, describing the "going open
source" scenario.

* ar/config-from-command-line (2010-03-26) 2 commits
  (merged to 'next' on 2010-05-04 at 2962717)
 + Use strbufs instead of open-coded string manipulation
 + Allow passing of configuration parameters in the command line

(has been in 'next' since 2010-04-07)
