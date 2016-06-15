From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2010, #05; Tue, 25)
Date: Tue, 25 May 2010 22:03:32 -0700
Message-ID: <7vpr0js197.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 07:03:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8mT-00047V-GX
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab0EZFDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:03:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab0EZFDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:03:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A458B6749;
	Wed, 26 May 2010 01:03:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=k3MZ
	BTdJE36Otz7qoKFKWmp2OT8=; b=eW2nR8uBr0TuYILYTtNypCg6szunVPTyrPVV
	wnXrEnhlXM1Pg0taISc3VAo6yGHV3LX4Op04nxWORzCjzXfnI+M+5orvSfPaLJpx
	jBhaOfXU6bm86W1IFIIZJRV9KlHeVISvo9DpR8464VX6FsMK4s3uBbdJ1hqY9601
	CxtlHaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Lga
	kgost7/9I3EI9BC9nw+sKOYz9CgbtjS9ZVgmjPWd/xGm0/LsXGahb/fMrNsrpJiC
	hyxDddBqiCigz8Vbfz0xP7cZ4+RUYjHY5MJ22UrNhwGOCzfWKE5dNbusNlU6xMB1
	bkjrv0Gi95GOlGddUKMEIWJKkdofIMMQ6MqZWkFA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 85002B6748;
	Wed, 26 May 2010 01:03:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 484DCB6747; Wed, 26 May
 2010 01:03:34 -0400 (EDT)
X-master-at: d0b16c8f878bef5c1268e033a3d1f427498c7008
X-next-at: b26ba11a604b521da594b71d7e3fbc51f26e24fa
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A7A2B14-6884-11DF-B453-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147733>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Many topics that have been cooking since 1.7.1 pre-release freeze period
are now in master; maybe it is a good time to start freezing feature
branches for 1.7.2---I think I said I'll keep this cycle shorter, no?

Btw, fwiw, I recently took a position with Google.  The primary
development machine has been unpacked but I still haven't managed to get
back to speed yet.

--------------------------------------------------
[Graduated to "master"]

* ar/config-from-command-line (2010-03-26) 2 commits
  (merged to 'next' on 2010-05-04 at 2962717)
 + Use strbufs instead of open-coded string manipulation
 + Allow passing of configuration parameters in the command line

* by/blame-doc-m-c (2010-05-06) 1 commit
  (merged to 'next' on 2010-05-09 at c975ad5)
 + blame-options.txt: Add default value for `-M/-C` options.

* by/log-follow (2010-05-10) 4 commits
  (merged to 'next' on 2010-05-10 at f4ce9f8)
 + tests: rename duplicate t4205
  (merged to 'next' on 2010-05-09 at d97e924)
 + Make git log --follow find copies among unmodified files.
 + Make diffcore_std only can run once before a diff_flush
 + Add a macro DIFF_QUEUE_CLEAR.

* cb/maint-stash-orphaned-file (2010-04-18) 2 commits
  (merged to 'next' on 2010-05-04 at 38488ba)
 + stash tests: stash can lose data in a file removed from the index
 + stash: Don't overwrite files that have gone from the index

* cw/maint-exec-defpath (2010-04-15) 2 commits
  (merged to 'next' on 2010-05-04 at 8d1591f)
 + autoconf: Check if <paths.h> exists and set HAVE_PATHS_H
 + exec_cmd.c: replace hard-coded path list with one from <paths.h>

* jc/am-3-show-corrupted-patch (2010-04-09) 1 commit
  (merged to 'next' on 2010-05-04 at 951f0e6)
 + am -3: recover the diagnostic messages for corrupt patches

* jc/maint-no-reflog-expire-unreach-for-head (2010-04-09) 3 commits
  (merged to 'next' on 2010-05-04 at d23a180)
 + reflog --expire-unreachable: special case entries in "HEAD" reflog
 + more war on "sleep" in tests
 + Document gc.<pattern>.reflogexpire variables

* jc/status-show-ignored (2010-05-01) 6 commits
  (merged to 'next' on 2010-05-04 at 8b32120)
 + wt-status: fix 'fprintf' compilation warning
 + status: --ignored option shows ignored files
 + wt-status: rename and restructure status-print-untracked
 + wt-status: collect ignored files
 + wt-status: plug memory leak while collecting untracked files
 + wt-status: remove unused workdir_untracked member

I am negative about conflating the JSON output to the mix at this point.
Let's stabilize "status" with the existing --porcelain/-z option first.

* jn/fsck-ident (2010-04-24) 1 commit
  (merged to 'next' on 2010-05-09 at 0d36355)
 + fsck: check ident lines in commit objects

There also was a companion patch to fast-import to deal with foreign SCM
interface that may not have human-readable author identifier.

* jn/gitweb-caching-prep (2010-04-24) 5 commits
  (merged to 'next' on 2010-05-09 at ceb4dad)
 + gitweb: Move generating page title to separate subroutine
 + gitweb: Add custom error handler using die_error
 + gitweb: Use nonlocal jump instead of 'exit' in die_error
 + gitweb: href(..., -path_info => 0|1)
 + Export more test-related variables when running external tests
 (this branch shares commits with jn/gitweb-fastcgi.)

* jn/gitweb-install (2010-05-01) 2 commits
  (merged to 'next' on 2010-05-09 at 9ea6cad)
 + gitweb: Create install target for gitweb in Makefile
 + gitweb: Improve installation instructions in gitweb/INSTALL

* jn/gitweb-our-squelch (2010-04-30) 1 commit
  (merged to 'next' on 2010-05-09 at 060726a)
 + gitweb: Silence 'Variable VAR may be unavailable' warnings

* jn/maint-bundle (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at f2086f5)
 + fix "bundle --stdin" segfault
 + t5704 (bundle): add tests for bundle --stdin

* jn/maint-request-pull (2010-05-07) 3 commits
 + t5150: protect backslash with backslash in shell
 + request-pull: protect against OPTIONS_KEEPDASHDASH from environment
 + tests for request-pull
 (this branch is used by jn/request-pull.)

* jn/request-pull (2010-05-10) 3 commits
  (merged to 'next' on 2010-05-10 at fcae760)
 + tests: chmod +x t5150
  (merged to 'next' on 2010-05-09 at 05aadd6)
 + adapt request-pull tests for new pull request format
 + Merge branch 'jn/maint-request-pull' into jn/request-pull
 (this branch uses jn/maint-request-pull.)

* jn/shortlog (2010-05-03) 5 commits
  (merged to 'next' on 2010-05-09 at efd1311)
 + pretty: Respect --abbrev option
 + shortlog: Document and test --format option
 + t4201 (shortlog): Test output format with multiple authors
 + t4201 (shortlog): guard setup with test_expect_success
 + Documentation/shortlog: scripted users should not rely on implicit HEAD

* jn/submodule-basic-test (2010-04-10) 3 commits
  (merged to 'next' on 2010-05-04 at 0bec27a)
 + t7400: clarify submodule update tests
 + t7400: clarify 'submodule add' tests
 + t7400: split setup into multiple tests

* jn/t7006-fixup (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at 490ab5d)
 + t7006: guard cleanup with test_expect_success

* js/maint-receive-pack-symref-alias (2010-04-19) 3 commits
  (merged to 'next' on 2010-05-04 at 259f4f1)
 + t5516-fetch-push.sh: style cleanup
 + receive-pack: detect aliased updates which can occur with symrefs
 + receive-pack: switch global variable 'commands' to a parameter

* mg/advice-statushints (2010-04-22) 2 commits
  (merged to 'next' on 2010-05-09 at 4642509)
 + wt-status: take advice.statusHints seriously
 + t7508: test advice.statusHints

* np/index-pack-memsave (2010-04-12) 3 commits
  (merged to 'next' on 2010-05-04 at 366b014)
 + index-pack: smarter memory usage when appending objects
 + index-pack: rationalize unpack_entry_data()
 + index-pack: smarter memory usage when resolving deltas

* np/malloc-threading (2010-04-08) 2 commits
  (merged to 'next' on 2010-05-04 at 1b0567f)
 + Thread-safe xmalloc and xrealloc needs a recursive mutex
 + Make xmalloc and xrealloc thread-safe
 (this branch is used by js/try-to-free-stackable.)

This fix should eventually go to 'maint' and 'master'.

* pb/patch-id-plus (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at 59881b8)
 + patch-id: Add support for mbox format
 + patch-id: extract parsing one diff out of generate_id_list

* rr/doc-submitting (2010-04-19) 1 commit
  (merged to 'next' on 2010-05-04 at 5f040bd)
 + SubmittingPatches: Add new section about what to base work on

* sp/maint-describe-tiebreak-with-tagger-date (2010-04-12) 5 commits
  (merged to 'next' on 2010-05-04 at af2d605)
 + describe: Break annotated tag ties by tagger date
 + tag.c: Parse tagger date (if present)
 + tag.c: Refactor parse_tag_buffer to be saner to program
 + tag.h: Remove unused signature field
 + tag.c: Correct indentation

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

* st/remote-tags-no-tags (2010-04-20) 2 commits
  (merged to 'next' on 2010-05-09 at fa9e04e)
 + remote add: add a --[no-]tags option
 + Honor "tagopt = --tags" configuration option

* tr/word-diff (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at d191b25)
 + diff: add --word-diff option that generalizes --color-words

There are gitk patches that go with this series.

--------------------------------------------------
[New Topics]

* em/checkout-orphan (2010-05-21) 5 commits
 - [sign-off?] bash completion: add --orphan to 'git checkout'
 - [sign-off?] t3200: test -l with core.logAllRefUpdates options
 - [sign-off?] checkout --orphan: respect -l option always
 - [sign-off?] refs: split log_ref_write logic into log_ref_setup
 - [sign-off?] Documentation: alter checkout --orphan description

* ec/diff-noprefix-config (2010-05-02) 1 commit
 - diff: add configuration option for disabling diff prefixes.

* jk/diff-m-doc (2010-05-08) 1 commit
 - docs: clarify meaning of -M for git-log

* mc/maint-zoneparse (2010-05-17) 1 commit
 - Add "Z" as an alias for the timezone "UTC"

* mg/notes-dry-run (2010-05-14) 1 commit
 - notes: dry-run and verbose options for prune

* mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
 - revlist: Introduce --lrbranches and --locals revision specifiers
 (this branch uses mg/rev-parse-option-sifter-deprecation.)

* mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
 - t6018: make sure all tested symbolic names are different revs
 - t6018: add tests for rev-list's --branches and --tags
 - rev-parse: deprecate use as an option sifter
 (this branch is used by mg/rev-parse-lrbranches-locals.)

* ab/cvsserver (2010-05-15) 6 commits
 - git-cvsserver: test for pserver authentication support
 - git-cvsserver: document making a password without htpasswd
 - git-cvsserver: Improved error handling for pserver
 - git-cvsserver: indent & clean up authdb code
 - git-cvsserver: use a password file cvsserver pserver
 - git-cvsserver: authentication support for pserver

* eb/core-eol (2010-05-19) 4 commits
 - Add "core.eol" config variable
 - Rename the "crlf" attribute "text"
 - Add per-repository eol normalization
 - Add tests for per-repository eol normalization
 (this branch uses fg/autocrlf.)

* jn/remote-set-branches (2010-05-19) 1 commit
 - Add git remote set-branches

* js/maint-windows (2009-07-20) 2 commits
  (merged to 'next' on 2010-05-21 at 16abe03)
 + Recent MinGW has a C99 implementation of snprintf functions
 + mingw: use _commit to implement fsync

* rs/grep-binary (2010-05-22) 8 commits
 - grep: support NUL chars in search strings for -F
 - grep: use REG_STARTEND for all matching if available
 - grep: continue case insensitive fixed string search after NUL chars
 - grep: use memmem() for fixed string search
 - grep: --name-only over binary
 - grep: --count over binary
 - grep: grep: refactor handling of binary mode options
 - grep: add test script for binary file handling

* ab/submodule-foreach-toplevel (2010-05-21) 1 commit
 - git-submodule foreach: Add $toplevel variable

* cb/ls-files-cdup (2010-05-22) 1 commit
 - ls-files: allow relative pathspec

* jk/maint-pull-dry-run-noop (2010-05-25) 1 commit
 - pull: do nothing on --dry-run

* jk/maint-sha1-file-name-fix (2010-05-22) 1 commit
 - remove over-eager caching in sha1_file_name

* jk/url-decode (2010-05-23) 2 commits
 - decode file:// and ssh:// URLs
 - make url-related functions reusable

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
 (this branch uses js/grep-open.)

Building this on top of slushy codebase is not a very promising endeavor.
Good thing to do, but it came at a bad time.

--------------------------------------------------
[Cooking]

* bw/diff-metainfo-color (2010-05-04) 1 commit
  (merged to 'next' on 2010-05-21 at 3aa552e)
 + diff: fix coloring of extended diff headers

* ph/clone-message-reword (2010-05-09) 1 commit
  (merged to 'next' on 2010-05-21 at 1785bd0)
 + clone: reword messages to match the end-user perception

* rc/ls-remote-default (2010-05-12) 1 commit
 - ls-remote: print URL when no repo is specified

* fg/autocrlf (2010-05-12) 1 commit
  (merged to 'next' on 2010-05-21 at 5f43b66)
 + autocrlf: Make it work also for un-normalized repositories
 (this branch is used by eb/core-eol.)

* tc/merge-m-log (2010-05-11) 8 commits
  (merged to 'next' on 2010-05-21 at e889876)
 + merge: --log appends shortlog to message if specified
 + fmt-merge-msg: add function to append shortlog only
 + fmt-merge-msg: refactor merge title formatting
 + fmt-merge-msg: minor refactor of fmt_merge_msg()
 + merge: rename variable
 + merge: update comment
 + t7604-merge-custom-message: show that --log doesn't append to -m
 + t7604-merge-custom-message: shift expected output creation

* jn/gitweb-fastcgi (2010-05-07) 2 commits
  (merged to 'next' on 2010-05-21 at cb1724f)
 + gitweb: Add support for FastCGI, using CGI::Fast
 + gitweb: Put all per-connection code in run() subroutine

* jn/make-header-dependency (2010-05-08) 2 commits
  (merged to 'next' on 2010-05-21 at d4ed230)
 + Makefile: let header dependency checker override COMPUTE_HEADER_DEPENDENCIES
 + Makefile: fix header dependency checker to allow NO_CURL builds

* js/try-to-free-stackable (2010-05-08) 2 commits
  (merged to 'next' on 2010-05-21 at 4c1afcb)
 + Do not call release_pack_memory in malloc wrappers when GIT_TRACE is used
 + Have set_try_to_free_routine return the previous routine

* jn/gitweb-syntax-highlight (2010-04-27) 2 commits
 - gitweb: Refactor syntax highlighting support
 - gitweb: Syntax highlighting support

* jn/maint-amend-missing-name (2010-05-02) 1 commit
  (merged to 'next' on 2010-05-09 at 9023332)
 + commit --amend: cope with missing display name

* rs/diff-no-minimal (2010-05-02) 1 commit
  (merged to 'next' on 2010-05-09 at 6c74aa0)
 + git diff too slow for a file

* ab/test-cleanup (2010-05-07) 2 commits
  (merged to 'next' on 2010-05-21 at a3cbd67)
 + Turn setup code in t2007-checkout-symlink.sh into a test
 + Move t6000lib.sh to lib-*

* jn/notes-doc (2010-05-08) 8 commits
  (merged to 'next' on 2010-05-21 at 1c28059)
 + Documentation/notes: nitpicks
 + Documentation/notes: clean up description of rewriting configuration
 + Documentation/notes: simplify treatment of default display refs
 + Documentation/log: add a CONFIGURATION section
 + Documentation/notes: simplify treatment of default notes ref
 + Documentation/notes: add configuration section
 + Documentation/notes: describe content of notes blobs
 + Documentation/notes: document format of notes trees

* cb/assume-unchanged-fix (2010-05-01) 2 commits
  (merged to 'next' on 2010-05-21 at bab2342)
 + Documentation: git-add does not update files marked "assume unchanged"
 + do not overwrite files marked "assume unchanged"

* wp/pretty-enhancement (2010-05-08) 4 commits
  (merged to 'next' on 2010-05-09 at eeaa4dc)
 + pretty: initialize new cmt_fmt_map to 0
 + pretty: add aliases for pretty formats
 + pretty: add infrastructure for commit format aliases
 + pretty: make it easier to add new formats

* hg/id-munging (2010-04-06) 2 commits
 - convert: Keep foreign $Id$ on checkout.
 - convert: Safer handling of $Id$ contraction.

* js/async-thread (2010-03-09) 7 commits
  (merged to 'next' on 2010-05-21 at 9d31940)
 + Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-05-04 at 2644e74)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

(all except for the tip has been in 'next' since 2010-03-20).

* ld/discovery-limit-to-fs (2010-04-04) 1 commit
 - write-index: check and warn when worktree crosses a filesystem boundary

This one is a bit iffy.
