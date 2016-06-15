From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Wed, 23 Jun 2010 15:09:32 -0700
Message-ID: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 00:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORY8h-0000ln-2t
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 00:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab0FWWJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 18:09:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0FWWJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 18:09:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C5B9BEBEE;
	Wed, 23 Jun 2010 18:09:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=TZDT
	7ltIg9xVXQDUgikOIpWAJZk=; b=A6atGOJTaug3XrHZk4gv0Rks+YSvPRWoePwl
	lXmBgLn8Zrp8N8W1LiZ/12/sJz3e8YhvVwczBzWTVvBtLpwWIxjqJZtrWXU9ZxAA
	sQn5+Ga2oZ01kz5VhDZgbfbuYzeFXJc+SfD0G9bvrcvSZoTb8+yNEx2F7c67tYMR
	9ZisVjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=jW1
	+puNNA9M+zKgYspDLTKdmRJPEHAvtcWtsy+lYNwEr9ypyXaMo2n9NI7wGhEcWTqz
	jqtmidpZAWH+kMlsiCDEdmwZezTlhxmC7dZxENTqZCz8U03GAsn+BwqagCyV8ZSs
	BSmodz/+T7xuZkyFESLE6Urjja7LsnbVJnmpKDv4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39C86BEBEC;
	Wed, 23 Jun 2010 18:09:36 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9791BEBE7; Wed, 23 Jun
 2010 18:09:33 -0400 (EDT)
X-master-at: ba4d01bd74edae1e4adb540a03ba17961f8dd4b2
X-next-at: eb6f21611e553cb1cc86c116fbd2ee4cb9dd3acb
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 027A07DA-7F14-11DF-A598-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149553>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I think I should start making noises about feature freeze for 1.7.2 by
now.  'next' is getting quite thin (and most of them look good ones),
while topics in 'pu' are mostly the kind nobody gets hurt if we waited for
a cycle or two.

--------------------------------------------------
[New Topics]

* ar/decorate-color (2010-06-23) 4 commits
 - Allow customizable commit decorations colors
 - log --decorate: Colorize commit decorations
 - log-tree.c: Use struct name_decoration's type for classifying decoration
 - commit.h: add 'type' to struct name_decoration

* tc/checkout-B (2010-06-22) 3 commits
 - builtin/checkout: learn -B
 - builtin/checkout: change -b from an OPTION_STRING to a OPTION_SET_INT
 - add tests for checkout -b

--------------------------------------------------
[Graduated to "master"]

* bc/portable (2010-06-09) 7 commits
  (merged to 'next' on 2010-06-13 at a423055)
 + Remove python 2.5'isms
 + Makefile: add PYTHON_PATH to GIT-BUILD-OPTIONS
  (merged to 'next' on 2010-06-07 at 27a57c9)
 + t/aggregate-results: accomodate systems with small max argument list length
 + t/t7006: ignore return status of shell's unset builtin
 + t/t5150: remove space from sed script
 + git-request-pull.sh: remove -e switch to shell interpreter which breaks ksh
 + t/t5800: skip if python version is older than 2.5

* bd/maint-unpack-trees-parawalk-fix (2010-06-10) 1 commit
  (merged to 'next' on 2010-06-18 at 183c13e)
 + unpack-trees: Make index lookahead less pessimal

* cc/cherry-pick-series (2010-06-02) 8 commits
  (merged to 'next' on 2010-06-18 at 26c504f)
 + Documentation/revert: describe passing more than one commit
 + Documentation/cherry-pick: describe passing more than one commit
 + revert: add tests to check cherry-picking many commits
 + revert: allow cherry-picking more than one commit
 + revert: change help_msg() to take no argument
 + revert: refactor code into a do_pick_commit() function
 + revert: use run_command_v_opt() instead of execv_git_cmd()
 + revert: cleanup code for -x option
 (this branch is used by cc/cherry-pick-stdin.)

* cc/maint-commit-reflog-msg (2010-06-12) 1 commit
  (merged to 'next' on 2010-06-17 at 863be4d)
 + commit: use value of GIT_REFLOG_ACTION env variable as reflog message

* eb/core-eol (2010-06-04) 4 commits
  (merged to 'next' on 2010-06-17 at 66b0c9f)
 + Add "core.eol" config variable
 + Rename the "crlf" attribute "text"
 + Add per-repository eol normalization
 + Add tests for per-repository eol normalization
 (this branch uses fg/autocrlf.)

* em/checkout-orphan (2010-06-10) 6 commits
  (merged to 'next' on 2010-06-12 at 2f531d5)
 + log_ref_setup: don't return stack-allocated array
  (merged to 'next' on 2010-06-07 at 23b4607)
 + bash completion: add --orphan to 'git checkout'
 + t3200: test -l with core.logAllRefUpdates options
 + checkout --orphan: respect -l option always
 + refs: split log_ref_write logic into log_ref_setup
 + Documentation: alter checkout --orphan description

* fg/autocrlf (2010-05-12) 1 commit
  (merged to 'next' on 2010-05-21 at 5f43b66)
 + autocrlf: Make it work also for un-normalized repositories
 (this branch is used by eb/core-eol.)

* gs/usage-to-stdout (2010-06-12) 2 commits
  (merged to 'next' on 2010-06-13 at e83c00f)
 + parseopt: wrap rev-parse --parseopt usage for eval consumption
  (merged to 'next' on 2010-06-03 at c81c783)
 + print the usage string on stdout instead of stderr

* gv/portable (2010-06-11) 20 commits
  (merged to 'next' on 2010-06-13 at 1add99c)
 + test-lib: use DIFF definition from GIT-BUILD-OPTIONS
  (merged to 'next' on 2010-06-07 at 1796035)
 + build: propagate $DIFF to scripts
  (merged to 'next' on 2010-06-03 at 41ae9cb)
 + Makefile: Tru64 portability fix
 + Makefile: HP-UX 10.20 portability fixes
 + Makefile: HPUX11 portability fixes
 + Makefile: SunOS 5.6 portability fix
 + inline declaration does not work on AIX
 + Allow disabling "inline"
 + Some platforms lack socklen_t type
 + Make NO_{INET_NTOP,INET_PTON} configured independently
 + Makefile: some platforms do not have hstrerror anywhere
 + git-compat-util.h: some platforms with mmap() lack MAP_FAILED definition
 + test_cmp: do not use "diff -u" on platforms that lack one
 + fixup: do not unconditionally disable "diff -u"
 + tests: use "test_cmp", not "diff", when verifying the result
 + Do not use "diff" found on PATH while building and installing
 + enums: omit trailing comma for portability
 + Makefile: -lpthread may still be necessary when libc has only pthread stubs
 + Rewrite dynamic structure initializations to runtime assignment
 + Makefile: pass CPPFLAGS through to fllow customization

* ic/maint-rebase-i-abort (2010-06-08) 1 commit
  (merged to 'next' on 2010-06-17 at 7f5f430)
 + rebase -i: Abort cleanly if new base cannot be checked out

* jc/maint-simpler-common-prefix (2010-06-16) 1 commit
  (merged to 'next' on 2010-06-18 at 24fa283)
 + common_prefix: simplify and fix scanning for prefixes

* jc/rev-list-ancestry-path (2010-06-04) 5 commits
  (merged to 'next' on 2010-06-17 at b35488a)
 + revision: Turn off history simplification in --ancestry-path mode
 + revision: Fix typo in --ancestry-path error message
 + Documentation/rev-list-options.txt: Explain --ancestry-path
 + Documentation/rev-list-options.txt: Fix missing line in example history graph
 + revision: --ancestry-path

* jk/maint-advice-empty-amend (2010-06-06) 1 commit
  (merged to 'next' on 2010-06-17 at 12ff4cd)
 + commit: give advice on empty amend

* jn/checkout-doc (2010-06-01) 2 commits
  (merged to 'next' on 2010-06-13 at d01c620)
 + Documentation/checkout: clarify description
  (merged to 'next' on 2010-06-07 at 93cc6a9)
 + Documentation/checkout: clarify description

* jn/document-rebase-i-p-limitation (2010-05-31) 1 commit
  (merged to 'next' on 2010-06-17 at a653a72)
 + rebase -i -p: document shortcomings

* jn/gitweb-fastcgi (2010-06-05) 3 commits
  (merged to 'next' on 2010-06-13 at 6d1fdd6)
 + gitweb: Run in FastCGI mode if gitweb script has .fcgi extension
  (merged to 'next' on 2010-05-21 at cb1724f)
 + gitweb: Add support for FastCGI, using CGI::Fast
 + gitweb: Put all per-connection code in run() subroutine

* jn/gitweb-return-or-exit-cleanup (2010-06-13) 1 commit
  (merged to 'next' on 2010-06-18 at 44299d4)
 + gitweb: Return or exit after done serving request

* js/async-thread (2010-06-11) 8 commits
  (merged to 'next' on 2010-06-13 at bf7457c)
 + fast-import: die_nicely() back to vsnprintf (reverts part of ebaa79f)
  (merged to 'next' on 2010-05-21 at 9d31940)
 + Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-05-04 at 2644e74)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

* js/maint-receive-pack-symref-alias (2010-06-16) 1 commit
  (merged to 'next' on 2010-06-17 at ecb7fa5)
 + Merge branch 'tr/receive-pack-aliased-update-fix' into js/maint-receive-pack-symref-alias
 (this branch uses tr/receive-pack-aliased-update-fix.)

* lt/extended-sha1-match-commit-with-regexp (2010-04-23) 1 commit
  (merged to 'next' on 2010-06-17 at 9ba2ec9)
 + Make :/ accept a regex rather than a fixed pattern

* mg/pretty-magic-space (2010-06-14) 1 commit
  (merged to 'next' on 2010-06-18 at dd5a896)
 + pretty: Introduce ' ' modifier to add space if non-empty

* rr/parse-date-refactor (2010-06-03) 1 commit
  (merged to 'next' on 2010-06-17 at c55f72b)
 + Refactor parse_date for approxidate functions

* sb/format-patch-signature (2010-06-15) 2 commits
  (merged to 'next' on 2010-06-18 at 4aee846)
 + completion: Add --signature and format.signature
 + format-patch: Add a signature option (--signature)

* sm/branch-broken-ref (2010-06-04) 2 commits
  (merged to 'next' on 2010-06-17 at cb81c35)
 + branch: don't fail listing branches if one of the commits wasn't found
 + branch: exit status now reflects if branch listing finds an error

* tc/commit-abbrev-fix (2010-06-12) 3 commits
  (merged to 'next' on 2010-06-16 at b2df7f8)
 + commit::print_summary(): don't use format_commit_message()
 + t7502-commit: add summary output tests for empty and merge commits
 + t7502-commit: add tests for summary output

* tc/maint-checkout-f-b (2010-06-21) 3 commits
 - builtin/checkout: Fix -f used with -b
 - t2018-checkout-branch.sh: "checkout -f -b" broken
 - add tests for checkout -b

* tr/receive-pack-aliased-update-fix (2010-06-10) 1 commit
  (merged to 'next' on 2010-06-14 at d3a3097)
 + check_aliased_update: strcpy() instead of strcat() to copy
 (this branch is used by js/maint-receive-pack-symref-alias.)

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* ab/i18n (2010-06-15) 3 commits
 . Add initial C, Shell and Perl gettext translations
 . fixup! Add infrastructure
 . Add infrastructure for translating Git with gettext

The parts that touch other topics in flight probably need to be split into
separate patches; otherwise it is unmanageable.

* ab/tap (2010-06-15) 5 commits
 . TAP: Make sure there's a newline before "ok" under harness
 . TAP: Say "pass" rather than "ok" on an empty line
 . We use TAP so the Perl test can run without scaffolding
 . Skip tests in a way that makes sense under TAP
 . Make test-lib.sh emit valid TAP format

Updated with a newer round but it seems to break "make -j8 test" when
merged to 'pu', hence ejected.  I was not sure why TAP is worth the
trouble, and I still am not sure.

--------------------------------------------------
[Cooking]

* as/maint-completion-set-u-fix (2010-06-17) 1 commit
 - bash-completion: Fix __git_ps1 to work with "set -u"

Will merge to 'next'; seemed sane.

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

Perhaps another round is coming?

* rr/svn-export (2010-06-10) 7 commits
 - Add LICENSE
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add library for string-specific memory pool
 - Add cpp macro implementation of treaps
 - Add memory pool library

I recall there was another round of re-roll planned for this one.

* tr/rev-list-count (2010-06-17) 2 commits
 - bash completion: Support "divergence from upstream" messages in __git_ps1
 - rev-list: introduce --count option

I'd like an Ack/Nack on the tip one from people involved in the completion
scripts.

* tr/send-email-8bit (2010-06-17) 1 commit
  (merged to 'next' on 2010-06-23 at be75199)
 + send-email: ask about and declare 8bit mails

* jl/maint-diff-ignore-submodules (2010-06-08) 2 commits
  (merged to 'next' on 2010-06-23 at 057acb7)
 + Add optional parameters to the diff option "--ignore-submodules"
 + git diff: rename test that had a conflicting name

* cp/textconv-cat-file (2010-06-09) 4 commits
 - [DONTMERGE] git gui: use textconv filter for diff and blame
  (merged to 'next' on 2010-06-23 at eb6f216)
 + t/t8007: test textconv support for cat-file
 + textconv: support for cat_file
 + sha1_name: add get_sha1_with_context()
 (this branch uses ab/blame-textconv.)

I'd need to prod Shawn to take a look at the tip one, as I shouldn't be
applying it to my tree myself.

* ab/blame-textconv (2010-06-07) 3 commits
  (merged to 'next' on 2010-06-23 at a7da5af)
 + t/t8006: test textconv support for blame
 + textconv: support for blame
 + textconv: make the API public
 (this branch is used by cp/textconv-cat-file.)

* jn/grep-open (2010-06-21) 7 commits
  (merged to 'next' on 2010-06-22 at 8edca58)
 + t/t7811-grep-open.sh: remove broken/redundant creation of fake "less" script
 + t/t7811-grep-open.sh: ensure fake "less" is made executable
 + t/lib-pager.sh: remove unnecessary '^' from 'expr' regular expression
  (merged to 'next' on 2010-06-18 at cf96ea8)
 + grep -O: allow optional argument specifying the pager (or editor)
 + grep: Add the option '--open-files-in-pager'
 + Unify code paths of threaded greps
 + grep: refactor grep_objects loop into its own function

* pb/maint-perl-errmsg-no-dir (2010-06-18) 1 commit
  (merged to 'next' on 2010-06-23 at 990ea67)
 + Git.pm: better error message

* eb/double-convert-before-merge (2010-06-16) 1 commit
 - ll-merge: Normalize files before merging

If running git-to-worktree and then worktree-to-git _fixes_ something, it
means that these are not roundtrip operations; there is something that is
fundamentally wrong.  The commit log message doesn't help explaining it,
either.

* js/maint-am-rebase-invalid-author (2010-06-16) 1 commit
  (merged to 'next' on 2010-06-23 at b345ad5)
 + am: use get_author_ident_from_commit instead of mailinfo when rebasing

* ps/gitweb-soc (2010-06-02) 2 commits
  (merged to 'next' on 2010-06-13 at 92245ae)
 + git-instaweb: Add option to reuse previous config file
 + Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'

If we are going to have a configuration variable to control this, I
strongly suspect that --reuse-config should be renamed so that the
variable can be named more sanely and in line with whatever option
that replaces it.

* cc/cherry-pick-stdin (2010-06-14) 3 commits
 - revert: do not rebuild argv on heap
 - revert: accept arbitrary rev-list options
 - t3508 (cherry-pick): futureproof against unmerged files

What's the doneness of this one?

* jn/show-num-walks (2010-06-01) 1 commit
  (merged to 'next' on 2010-06-23 at e61649c)
 + DWIM 'git show -5' to 'git show --do-walk -5'

* mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
 - revlist: Introduce --lrbranches and --locals revision specifiers
 (this branch uses mg/rev-parse-option-sifter-deprecation.)

I am reluctant to merge a patch that introduces an unpronounceable
option.

* mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
 - t6018: make sure all tested symbolic names are different revs
 - t6018: add tests for rev-list's --branches and --tags
 - rev-parse: deprecate use as an option sifter
 (this branch is used by mg/rev-parse-lrbranches-locals.)

I don't think these patches help anything.  Opinions?
