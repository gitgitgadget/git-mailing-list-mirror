From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Wed, 02 Jun 2010 16:36:56 -0700
Message-ID: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 01:37:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxUq-0000jA-RA
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290Ab0FBXhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:37:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933263Ab0FBXhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:37:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B726B72F4;
	Wed,  2 Jun 2010 19:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=uFX1
	K+zzUGAStdMhyaHWwjg8Pbc=; b=O2QlacEuG06MB0UlbRDdpYDStAzwUT1/U5Ob
	RRdM7pCyYyJ2BtiDb2p04XkknpqbopPGQ8HKXf9FltdXVqcKeuabybkqV4yxygV8
	fAn8Zoy9l+XMVSC4YQy2RfROuDsIozWPJZdFe+y7HPzspfpmfQ8s879D/HEy9BwJ
	ZtH1UtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CqF
	ZcdS97oDeVIlyDGYZlub1PJGuySSJNHJ/18utSV8AayFyxkZIuIDAuAXM7r4jpEb
	PyjCPrCuBZ0i3p/bPwSptLJl561sjfAudQvsYQum5AJxiCkAZS4o9f36IljLeBjY
	0YSPzhJ5FdoHiVhK4HQP2pJwxZes/K3JdFQI6g00=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 850CCB72F3;
	Wed,  2 Jun 2010 19:37:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38033B72ED; Wed,  2 Jun
 2010 19:36:58 -0400 (EDT)
X-master-at: bdc4204119d2847ea8f1ae5e44614be859951822
X-next-at: c7bbdb20f017cfc4f70c5cad0067b0a3e6650153
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BDA77180-6E9F-11DF-B350-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148280>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Many topics that have been cooking since 1.7.1 pre-release freeze period
are now in master; maybe it is a good time to start freezing feature
branches for 1.7.2---I think I said I'll keep this cycle shorter, no?

--------------------------------------------------
[New Topics]

* bs/userdiff-php (2010-05-23) 1 commit
 - diff: Support visibility modifiers in the PHP hunk header regexp

Will merge to 'next'.

* cc/maint-diff-CC-binary (2010-06-02) 2 commits
 - fixup
 - diff: fix "git show -C -C" output when renaming a binary file

The fix-up should probably be squashed in, as the original "fix" was
barking up a wrong tree.

* jn/gitweb-plackup (2010-05-28) 3 commits
 - git-instaweb: Add support for running gitweb via 'plackup'
 - git-instaweb: Wait for server to start before running web browser
 - git-instaweb: Remove pidfile after stopping web server
 (this branch uses ps/gitweb-soc.)

Will merge to 'next'.

* mg/status-b (2010-05-25) 2 commits
 - Documentation+t5708: document and test status -s -b
 - Show branch information in short output of git status

There are a few style violations that snuck in, but otherwise looked
sensible.

* ps/gitweb-soc (2010-05-28) 4 commits
 - git-instaweb: Configure it to work with new gitweb structure
 - git-instaweb: Put httpd logs in a "$httpd_only" subdirectory
 - gitweb: Set default destination directory for installing gitweb in Makefile
 - gitweb: Move static files into seperate subdirectory
 (this branch is used by jn/gitweb-plackup.)

Will merge to 'next'.

* tc/commit-abbrev-fix (2010-05-27) 3 commits
 - commit::print_summary(): set rev_info.always_show_header to 1
 - t7502-commit: add summary output tests for empty and merge commits
 - t7502-commit: add tests for summary output

Will merge to 'next'.  I am not quite happy about the "impossible to
trigger" die message, though.  It is a good defensive programming to catch
breakages caused by future changes that may invalidate the assumption this
patch makes, but then the message should be worded as such to state that
assumption, I think.

* ab/maint-perl-use-instlibdir (2010-05-30) 1 commit
 - Makefile: remove redundant munging of @@INSTLIBDIR@@

Will merge to 'next'.

* by/diff-graph (2010-05-29) 6 commits
 - Make --color-words work well with --graph
 - graph.c: register a callback for graph output
 - Emit a whole line in one go
 - diff.c: Output the text graph padding before each diff line
 - Output the graph columns at the end of the commit message
 - Add a prefix output callback to diff output

Will merge to 'next'.

* cc/cherry-pick-series (2010-06-02) 8 commits
 - Documentation/revert: describe passing more than one commit
 - Documentation/cherry-pick: describe passing more than one commit
 - revert: add tests to check cherry-picking many commits
 - revert: allow cherry-picking more than one commit
 - revert: change help_msg() to take no argument
 - revert: refactor code into a do_pick_commit() function
 - revert: use run_command_v_opt() instead of execv_git_cmd()
 - revert: cleanup code for -x option

* gs/usage-to-stdout (2010-05-17) 1 commit
 - print the usage string on stdout instead of stderr

Will merge to 'next'.

* gv/portable (2010-05-14) 18 commits
 - Makefile: Tru64 portability fix
 - Makefile: HP-UX 10.20 portability fixes
 - Makefile: HPUX11 portability fixes
 - Makefile: SunOS 5.6 portability fix
 - inline declaration does not work on AIX
 - Allow disabling "inline"
 - Some platforms lack socklen_t type
 - Make NO_{INET_NTOP,INET_PTON} configured independently
 - Makefile: some platforms do not have hstrerror anywhere
 - git-compat-util.h: some platforms with mmap() lack MAP_FAILED definition
 - test_cmp: do not use "diff -u" on platforms that lack one
 - fixup: do not unconditionally disable "diff -u"
 - tests: use "test_cmp", not "diff", when verifying the result
 - Do not use "diff" found on PATH while building and installing
 - enums: omit trailing comma for portability
 - Makefile: -lpthread may still be necessary when libc has only pthread stubs
 - Rewrite dynamic structure initializations to runtime assignment
 - Makefile: pass CPPFLAGS through to fllow customization

Will merge to 'next'.

* jh/diff-index-line-abbrev (2010-05-30) 1 commit
 - diff.c: Ensure "index $from..$to" line contains unambiguous SHA1s

Will merge to 'next'.

* jk/am-skip-hint (2010-05-30) 1 commit
 - git-am: suggest what to do with superfluous patches

Will merge to 'next'.

* jn/checkout-doc (2010-05-30) 1 commit
 - Documentation/checkout: clarify description

Will merge to 'next'.

* jn/fsck-ident (2010-05-26) 1 commit
 - fsck: fix bogus commit header check

Will merge to 'next'.

* jn/maint-doc-ignore (2010-03-05) 1 commit
 - gitignore.5: Clarify matching rules

Will merge to 'next'.

* jn/rebase-cmdline-fix (2010-05-31) 1 commit
 - rebase: improve error message when upstream argument is missing

Will merge to 'next'.

* ps/gitweb--browse-chrome (2010-05-30) 1 commit
 - git-web--browse: Add support for google chrome and chromium

Will merge to 'next'.

* bc/portable (2010-06-01) 5 commits
 - t/aggregate-results: accomodate systems with small max argument list length
 - t/t7006: ignore return status of shell's unset builtin
 - t/t5150: remove space from sed script
 - git-request-pull.sh: remove -e switch to shell interpreter which breaks ksh
 - t/t5800: skip if python version is older than 2.5

* jn/show-num-walks (2010-06-01) 1 commit
 - DWIM 'git show -5' to 'git show --do-walk -5'

* rr/am-help (2010-06-02) 3 commits
 - git am: Remove stray error message from sed
 - git am: Display some help text when patch is empty
 - git am: Set cmdline globally

Will merge to 'next'.

* jc/t9129-any-utf8 (2010-06-02) 1 commit
 - t9129: fix UTF-8 locale detection

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

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

--------------------------------------------------
[Cooking]

* em/checkout-orphan (2010-05-21) 5 commits
 - bash completion: add --orphan to 'git checkout'
 - t3200: test -l with core.logAllRefUpdates options
 - checkout --orphan: respect -l option always
 - refs: split log_ref_write logic into log_ref_setup
 - Documentation: alter checkout --orphan description

In <4BFE2461.5080501@drmicha.warpmail.net>, Michael J Gruber raised a
valid request for a better explanation of superfluous files left behind
and then are cleaned.  Other than that I think this is a sane thing to
do.

* ec/diff-noprefix-config (2010-05-02) 1 commit
 - diff: add configuration option for disabling diff prefixes.

Will merge to 'next'.

* jk/diff-m-doc (2010-05-08) 1 commit
 - docs: clarify meaning of -M for git-log

Will merge to 'next'.

* mc/maint-zoneparse (2010-05-17) 1 commit
 - Add "Z" as an alias for the timezone "UTC"

Will merge to 'next'.

* mg/notes-dry-run (2010-05-14) 1 commit
 - notes: dry-run and verbose options for prune

Will merge to 'next'.

* mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
 - revlist: Introduce --lrbranches and --locals revision specifiers
 (this branch uses mg/rev-parse-option-sifter-deprecation.)

Hmmm...

* mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
 - t6018: make sure all tested symbolic names are different revs
 - t6018: add tests for rev-list's --branches and --tags
 - rev-parse: deprecate use as an option sifter
 (this branch is used by mg/rev-parse-lrbranches-locals.)

Some people might interpret "Deprecate" too strongly; the intent is that
we shouldn't keep piling parsing of new rev-list options to it and
discourage the use of "option sifter" in new programs.

* ab/cvsserver (2010-05-15) 6 commits
 - git-cvsserver: test for pserver authentication support
 - git-cvsserver: document making a password without htpasswd
 - git-cvsserver: Improved error handling for pserver
 - git-cvsserver: indent & clean up authdb code
 - git-cvsserver: use a password file cvsserver pserver
 - git-cvsserver: authentication support for pserver

Will merge to 'next'.

* eb/core-eol (2010-05-19) 4 commits
 - Add "core.eol" config variable
 - Rename the "crlf" attribute "text"
 - Add per-repository eol normalization
 - Add tests for per-repository eol normalization
 (this branch uses fg/autocrlf.)

Will merge to 'next'.

* jn/remote-set-branches (2010-05-19) 1 commit
 - Add git remote set-branches

Will merge to 'next'.

* js/maint-windows (2009-07-20) 2 commits
  (merged to 'next' on 2010-05-21 at 16abe03)
 + Recent MinGW has a C99 implementation of snprintf functions
 + mingw: use _commit to implement fsync

Will merge to 'next'.

* rs/grep-binary (2010-05-22) 8 commits
 - grep: support NUL chars in search strings for -F
 - grep: use REG_STARTEND for all matching if available
 - grep: continue case insensitive fixed string search after NUL chars
 - grep: use memmem() for fixed string search
 - grep: --name-only over binary
 - grep: --count over binary
 - grep: grep: refactor handling of binary mode options
 - grep: add test script for binary file handling

Will merge to 'next'.

* ab/submodule-foreach-toplevel (2010-05-21) 1 commit
 - git-submodule foreach: Add $toplevel variable

Will merge to 'next'.

* cb/ls-files-cdup (2010-05-26) 1 commit
 - ls-files: allow relative pathspec

Doesn't write_name() quote twice when prefix_offset is non-zero?

* jk/maint-pull-dry-run-noop (2010-05-25) 1 commit
 - pull: do nothing on --dry-run

Will merge to 'next'.

* jk/maint-sha1-file-name-fix (2010-05-22) 1 commit
 - remove over-eager caching in sha1_file_name

Will merge to 'next'.

* jk/url-decode (2010-05-23) 2 commits
 - decode file:// and ssh:// URLs
 - make url-related functions reusable

Will merge to 'next'.

* bw/diff-metainfo-color (2010-05-04) 1 commit
  (merged to 'next' on 2010-05-21 at 3aa552e)
 + diff: fix coloring of extended diff headers

* ph/clone-message-reword (2010-05-09) 1 commit
  (merged to 'next' on 2010-05-21 at 1785bd0)
 + clone: reword messages to match the end-user perception

* rc/ls-remote-default (2010-05-12) 1 commit
 - ls-remote: print URL when no repo is specified

Will merge to 'next'.

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

Will merge to 'next'.

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

Will merge to 'next'.

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

There might have been some valid objections to this but I cannot recall.
Will merge to 'next' unless I hear something within a few days.

--------------------------------------------------
[Discarded, perhaps can be rerolled]

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
