From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Fri, 13 May 2011 13:03:44 -0700
Message-ID: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 22:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKyab-0003uT-P1
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 22:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841Ab1EMUDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 16:03:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab1EMUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 16:03:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A833B5D87;
	Fri, 13 May 2011 16:05:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=5
	gC8PVKFCl6MATHPsggN1jGlgoI=; b=GlRSILxQwWmlirpwMH9rg9KXqMYaEXkOt
	zv+LEM9iaAdgWX60PEURc/iR2p2iKkxKPSi7UT0QgeGwnv/f3PJaklZxZO20GuEA
	QQMzI74mY5J5ol7RW5VM71svvxitEabqxQyb2EAZWF0QAZhmfR2NpqBqCciFT0B8
	939/pRnSAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VJK
	ttE5Dje5zM2gffnRa8QILSRg+5Axk/Yn21tXy72Js0qDQJSPZnXerfGisoQNJN5J
	DJU5ySGLqQZWxgzAedqKa0TakTmeKl9uMv+EeJs9/mO/uHh4hWuLULOKdsD3xqLL
	gBpZxZwhMbuX6a91E1hn21cpykY+hipyibIN+LV0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 952EA5D85;
	Fri, 13 May 2011 16:05:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4E8B95D83; Fri, 13 May 2011
 16:05:52 -0400 (EDT)
X-master-at: 2de58b398b5a1f81bf74a385e41cfc2fcd9cb427
X-next-at: fcbf71a2ac7af454bec14832c8dfba57e793dda7
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68A4C27A-7D9C-11E0-8C6E-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173567>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

I am somewhat frustrated that I see almost no reviews on gitweb
patches. Does this mean nobody is interested in viewing the projects
on gitweb? How can we improve this lack of review bandwidth situation?

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are about to finish the week #3 of this cycle.

--------------------------------------------------
[Graduated to "master"]

* bf/commit-template-no-cleanup (2011-05-11) 1 commit
  (merged to 'next' on 2011-05-11 at 01fde0d)
 + Do not strip empty lines / trailing spaces from a commit message template

* cn/log-parse-opt (2011-04-14) 1 commit
  (merged to 'next' on 2011-04-28 at 02f2eac)
 + log: convert to parse-options

* jc/fix-add-u-unmerged (2011-04-23) 1 commit
  (merged to 'next' on 2011-04-28 at f7ed821)
 + Fix "add -u" that sometimes fails to resolve unmerged paths
 (this branch is used by jc/add-delete-default.)

* jc/t1506-shell-param-expansion-gotcha (2011-05-09) 1 commit
  (merged to 'next' on 2011-05-11 at 6c8619e)
 + t1507: avoid "${parameter<op>'word'}" inside double-quotes

* jh/dirstat-lines (2011-04-29) 8 commits
  (merged to 'next' on 2011-04-29 at a302674)
 + Mark dirstat error messages for translation
 + Improve error handling when parsing dirstat parameters
 + New --dirstat=lines mode, doing dirstat analysis based on diffstat
 + Allow specifying --dirstat cut-off percentage as a floating point number
 + Add config variable for specifying default --dirstat behavior
 + Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
 + Make --dirstat=0 output directories that contribute < 0.1% of changes
 + Add several testcases for --dirstat and friends

* jn/setup-revisions-glob-and-friends-passthru (2011-04-21) 2 commits
  (merged to 'next' on 2011-04-28 at 6006cc4)
 + revisions: allow --glob and friends in parse_options-enabled commands
 + revisions: split out handle_revision_pseudo_opt function

* js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix (2011-05-05) 2 commits
 + send-pack: unbreak push over stateless rpc
 + send-pack: avoid deadlock when pack-object dies early
 (this branch is used by js/maint-send-pack-stateless-rpc-deadlock-fix.)

* js/maint-send-pack-stateless-rpc-deadlock-fix (2011-05-05) 2 commits
  (merged to 'next' on 2011-05-05 at 3f4ffb9)
 + Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
  (merged to 'next' on 2011-04-28 at db7e04a)
 + Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
 (this branch uses js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix.)

* rr/rerere-libify-clear-gc (2011-05-08) 1 commit
  (merged to 'next' on 2011-05-11 at b1d8c88)
 + rerere: libify rerere_clear() and rerere_gc()

This is pure code movement.  Changing them to suit the need of other
callers can be built on it as separate patches.

--------------------------------------------------
[New Topics]

* jc/maint-1.6.6-pathspec-stdin-and-cmdline (2011-05-11) 1 commit
 + setup_revisions(): take pathspec from command line and --stdin correctly
 (this branch is used by jc/magic-pathspec, jc/maint-1.7.4-pathspec-stdin-and-cmdline and jc/maint-pathspec-stdin-and-cmdline.)

* jc/maint-1.7.4-pathspec-stdin-and-cmdline (2011-05-11) 1 commit
 - Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'
 (this branch uses jc/maint-1.6.6-pathspec-stdin-and-cmdline; is tangled with jc/magic-pathspec and jc/maint-pathspec-stdin-and-cmdline.)

* jc/maint-pathspec-stdin-and-cmdline (2011-05-11) 2 commits
 - Merge branch 'jc/maint-1.7.4-pathspec-stdin-and-cmdline'
 - Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'
 (this branch uses jc/maint-1.6.6-pathspec-stdin-and-cmdline; is tangled with jc/magic-pathspec and jc/maint-1.7.4-pathspec-stdin-and-cmdline.)

These are to fix an ancient bug where feeding "git log --stdin path" with
an input that also has additional pathspec corrupted memory.

* jl/read-tree-m-dry-run (2011-05-11) 1 commit
 - Teach read-tree the -n|--dry-run option

Looked good. We _might_ want to make -n simply ignore -u, though.

* jc/streaming (2011-05-12) 5 commits
 - write_entry(): use streaming API for writing working tree files
 - stream: a streaming interface to read from the object store
 - sha1_object_info_extended(): expose a bit more information from object-info
 - write_entry(): separate two helper functions out
 - packed_object_info_detail(): do not return a string
 (this branch uses jc/convert.)

The counterpart to jc/bigfile to cover the write-out codepath. This does
not yet have "read directly from pack or loose object without slurping the
whole thing in memory" yet, which is still work in progress.

--------------------------------------------------
[Stalled]

* mg/diff-stat-count (2011-05-03) 2 commits
 - diff-options.txt: describe --stat-{width,name-width,count}
 - diff: introduce --stat-count to limit the stat lines

There was a miscounting spotted.  Need another round.

* jn/gitweb-js (2011-04-28) 13 commits
 - gitweb: Make JavaScript ability to adjust timezones configurable
 - gitweb.js: Add UI for selecting common timezone to display dates
 - gitweb: JavaScript ability to adjust time based on timezone
 - gitweb: Unify the way long timestamp is displayed
 - gitweb: Refactor generating of long dates into format_timestamp_html
 - gitweb.js: Provide getElementsByClassName method (if it not exists)
 - gitweb.js: Introduce code to handle cookies from JavaScript
 - gitweb.js: Extract and improve datetime handling
 - gitweb.js: Provide default values for padding in padLeftStr and padLeft
 - gitweb.js: Update and improve comments in JavaScript files
 - gitweb: Split JavaScript for maintability, combining on build
 - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
 - git-instaweb: Simplify build dependency on gitweb

Rerolled.  Waiting for comments.

* jn/ctags-more (2011-04-29) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Modularized git_get_project_description to be more generic
 - gitweb: Split git_project_list_body in two functions

Waiting for comments.

* jc/require-work-tree-exists (2011-05-08) 1 commit
 - require-work-tree wants more than what its name says

Make "git pull" run from a random place work as long as GIT_DIR and
GIT_WORK_TREE are set up correctly.  I am not absolutely sure if that
is a sane use case, though. May drop.

* jc/add-delete-default (2011-04-27) 1 commit
 - git add: notice removal of tracked paths by default

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-02-27) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

* jc/dotdot-is-parent-directory (2011-05-04) 1 commit
 - specifying ranges: we did not mean to make ".." an empty set

Updated documentation, but I do not feel a strong enough annoyance to push
this forward. May drop.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jc/advice-about-to-lose-commit (2011-05-06) 1 commit
 - checkout: honor advice.detachedHead when reattaching to a branch

Needs to tighten the advice to only govern the generic How-to part.

--------------------------------------------------
[Cooking]

* jc/bigfile (2011-05-12) 3 commits
 - Bigfile: teach "git add" to send a large file straight to a pack
 - index_fd(): split into two helper functions
 - index_fd(): turn write_object and format_check arguments into one flag

This covers the entry point for a big file to the system. Other parts that
need to know about them are the exit point (i.e. write_entry()), packing
and repacking (as long as bigfilethreshold is sane this should work),
diffs and status (avoid slurping large binary in core only to do nothing,
which we already should), and transport (receive-pack/fetch-pack call
either unpack-objects or index-pack, which still want to hold the full
object in-core and need to be fixed).

* jc/convert (2011-05-09) 4 commits
 - convert: make it harder to screw up adding a conversion attribute
 - convert: make it safer to add conversion attributes
 - convert: give saner names to crlf/eol variables, types and functions
 - convert: rename the "eol" global variable to "core_eol"
 (this branch is used by jc/streaming.)

Just a clean-up.
Will merge to "next" by the end of week #3.

* jk/blame-line-porcelain (2011-05-09) 3 commits
 - blame: add --line-porcelain output format
 - blame: refactor porcelain output
 - add tests for various blame formats

* ms/tagname-does-not-begin-with-dash (2011-05-10) 1 commit
 - tag: disallow '-' as tag name

Will merge to "next" by the end of week #3.

* fc/completion-zsh (2011-05-10) 1 commit
 + git-completion: fix regression in zsh support
 (this branch is used by sg/completion-updates.)

* nd/sparse-co-fix (2011-05-10) 2 commits
 - sparse checkout: do not eagerly decide the fate for whole directory
 - t1011: fix sparse-checkout initialization and add new file

* kk/maint-prefix-in-config-mak (2011-05-09) 3 commits
  (merged to 'next' on 2011-05-09 at 267a3aa)
 + Honor $(prefix) set in config.mak* when defining ETC_GIT*
 + Revert "Honor $(prefix) set in config.mak* when defining ETC_GIT* and sysconfdir"
  (merged to 'next' on 2011-05-02 at c747ba3)
 + Honor $(prefix) set in config.mak* when defining ETC_GIT* and sysconfdir

One revert and replace the whole thing from J6t. The end result looked
reasonable.

Will merge to "master" by the end of week #4.

* ci/commit--interactive-atomic (2011-05-10) 6 commits
  (merged to 'next' on 2011-05-11 at 7f36fd8)
 + Test atomic git-commit --interactive
 + Add commit to list of config.singlekey commands
 + Add support for -p/--patch to git-commit
 + Allow git commit --interactive with paths
 + t7501.8: feed a meaningful command
 + Use a temporary index for git commit --interactive

Will merge to "master" by the end of week #4.

* ab/i18n-scripts (2011-05-08) 48 commits
 - i18n: git-bisect bisect_next_check "You need to" message
 - i18n: git-bisect [Y/n] messages
 - i18n: git-bisect bisect_replay + $1 messages
 - i18n: git-bisect bisect_reset + $1 messages
 - i18n: git-bisect bisect_run + $@ messages
 - i18n: git-bisect die + eval_gettext messages
 - i18n: git-bisect die + gettext messages
 - i18n: git-bisect echo + eval_gettext message
 - i18n: git-bisect echo + gettext messages
 - i18n: git-bisect gettext + echo message
 - i18n: git-bisect add git-sh-i18n
 - i18n: git-stash drop_stash say/die messages
 - i18n: git-stash "unknown option" message
 - i18n: git-stash die + eval_gettext $1 messages
 - i18n: git-stash die + eval_gettext $* messages
 - i18n: git-stash die + eval_gettext messages
 - i18n: git-stash die + gettext messages
 - i18n: git-stash say + gettext messages
 - i18n: git-stash echo + gettext message
 - i18n: git-stash add git-sh-i18n
 - i18n: git-submodule "blob" and "submodule" messages
 - i18n: git-submodule "path not initialized" message
 - i18n: git-submodule "[...] path is ignored" message
 - i18n: git-submodule "Entering [...]" message
 - i18n: git-submodule $errmsg messages
 - i18n: git-submodule "Submodule change[...]" messages
 - i18n: git-submodule "cached cannot be used" message
 - i18n: git-submodule $update_module say + die messages
 - i18n: git-submodule die + eval_gettext messages
 - i18n: git-submodule say + eval_gettext messages
 - i18n: git-submodule echo + eval_gettext messages
 - i18n: git-submodule add git-sh-i18n
 - i18n: git-pull eval_gettext + warning message
 - i18n: git-pull eval_gettext + die message
 - i18n: git-pull die messages
 - i18n: git-pull add git-sh-i18n
 - i18n: git-am printf(1) message to eval_gettext
 - i18n: git-am core say messages
 - i18n: git-am "Falling back" say message
 - i18n: git-am "Apply?" message
 - i18n: git-am clean_abort messages
 - i18n: git-am cannot_fallback messages
 - i18n: git-am die messages
 - i18n: git-am echo + gettext message
 - i18n: git-am eval_gettext messages
 - i18n: git-am multi-line getttext $msg; echo
 - i18n: git-am one-line gettext $msg; echo
 - i18n: git-am add git-sh-i18n
 (this branch uses ab/i18n-scripts-basic.)

* ab/i18n-scripts-basic (2011-05-08) 4 commits
 - Makefile: add xgettext target for *.sh files
 - git-sh-i18n.sh: add GIT_GETTEXT_POISON support
 - git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers
 - git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
 (this branch is used by ab/i18n-scripts.)

Will be re-rolled to work around systems whose environment variable names
are case insensitive.

* mg/merge-ff-config (2011-05-06) 3 commits
  (merged to 'next' on 2011-05-08 at 977b432)
 + tests: check git does not barf on merge.ff values for future versions of git
 + merge: introduce merge.ff configuration variable
 + Merge branch 'jc/maint-branch-mergeoptions' into mg/merge-ff-config

Will merge to "master" by the end of week #4.

* mk/grep-pcre (2011-05-09) 10 commits
 - git-grep: do not die upon -F/-P when grep.extendedRegexp is set.
 - git-grep: Bail out when -P is used with -F or -E
 - grep: Add basic tests
 - configure: Check for libpcre
 - git-grep: Learn PCRE
 - grep: Extract compile_regexp_failed() from compile_regexp()
 - grep: Fix a typo in a comment
  (merged to 'next' on 2011-05-08 at 5d3bede)
 + grep: Put calls to fixmatch() and regmatch() into patmatch()
 + contrib/completion: --line-number to git grep
 + Documentation: Add --line-number to git-grep synopsis

Will merge to "next" by the end of week #3.

* sg/completion-updates (2011-05-10) 4 commits
  (merged to 'next' on 2011-05-10 at eaf5398)
 + Merge branch 'fc/completion-zsh' into sg/completion-updates
 + Revert "completion: don't declare 'local words' to make zsh happy"
  (merged to 'next' on 2011-05-08 at 761178c)
 + completion: move private shopt shim for zsh to __git_ namespace
  (merged to 'next' on 2011-05-02 at 0fd443a)
 + completion: don't declare 'local words' to make zsh happy
 (this branch uses fc/completion-zsh.)

This reverts the "local words only on bash" thingy and uses the
workaround blessed by zsh folks instead.

Will merge to "master" by the end of week #4.

* ld/p4-preserve-user-names (2011-05-10) 3 commits
 - git-p4: warn if git authorship won't be retained
  (merged to 'next' on 2011-05-11 at bc14314)
 + git-p4: small improvements to user-preservation
  (merged to 'next' on 2011-04-29 at 25116c8)
 + git-p4: add option to preserve user names

A re-roll of the tip one looked good but did not come in time for
morning cycle today.

Will merge to "next".

* jc/magic-pathspec (2011-05-12) 13 commits
  (merged to 'next' on 2011-05-12 at 656c8b5)
 + t3703: Skip tests using directory name ":" on Windows
  (merged to 'next' on 2011-05-11 at 86d1d6d)
 + revision.c: leave a note for "a lone :" enhancement
 + Merge branch 'jc/maint-1.6.6-pathspec-stdin-and-cmdline'
  (merged to 'next' on 2011-05-11 at aaad95e)
 + t3703, t4208: add test cases for magic pathspec
 + rev/path disambiguation: further restrict "misspelled index entry" diag
 + fix overslow :/no-such-string-ever-existed diagnostics
 + fix overstrict :<path> diagnosis
 + grep: use get_pathspec() correctly
 + pathspec: drop "lone : means no pathspec" from get_pathspec()
 + Revert "magic pathspec: add ":(icase)path" to match case insensitively"
  (merged to 'next' on 2011-04-25 at 788cd46)
 + magic pathspec: add ":(icase)path" to match case insensitively
 + magic pathspec: futureproof shorthand form
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support
 (this branch uses jc/maint-1.6.6-pathspec-stdin-and-cmdline; is tangled with jc/maint-1.7.4-pathspec-stdin-and-cmdline and jc/maint-pathspec-stdin-and-cmdline.)

This seems to need more time to mature than I expected.
