From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #04; Sun, 8)
Date: Sun, 08 May 2011 22:33:56 -0700
Message-ID: <7v8vugqvy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 07:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJJ6s-00039b-Dp
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 07:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab1EIFeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 01:34:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab1EIFeC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 01:34:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 28D625EED;
	Mon,  9 May 2011 01:36:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	DiXzbG6V+ESVV4QQBvv5CYyq9A=; b=C2pEN9QOlSf5pcrimMYCyfSQeKOR+noj1
	or3Q++lxK4alvqnp1s6VxPv8hObY5fCM0LaFQqpnDj2Ko2gF0+Yls73WGWXY9i+Q
	WENcn3yjpX0JiDL7QK2jwNGSTJlKWkrJzUOr6UUi3+8d0+ITtQH/F4Jq2sYRjfMQ
	MBtr86DjX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=xkl
	2yFM27PDpOJ4/VFnbVxVMRMqRCZ+Tz2yDkjqzMLguyqzW0ZvmMsvyYfI1sJQCpPl
	TNd97SEfyIoilkzD2bfaCc2eAX072AooKUcddEvT8a9XRsDllf/d9J3Uw/2nhjE1
	ox92NufDdRmqoUrNQFgDt161g76ty1+/A8Pnra3Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15E4B5EEA;
	Mon,  9 May 2011 01:36:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCC755EE9; Mon,  9 May 2011
 01:36:03 -0400 (EDT)
X-master-at: 4e3aa87d13b339fa678cd3cb7f23664d3a48fb21
X-next-at: 761178c48dcef128045e10696ae41e2d891a5987
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C351420-79FE-11E0-9CB2-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173195>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are about to begin week #3. Number of topics that have stalled seem
increasing, which is not a very good sign, considering that I plan to
start a feature freeze for 1.7.6 by the end of week #5.

--------------------------------------------------
[New Topics]

* bf/commit-template-no-cleanup (2011-05-08) 1 commit
 - Do not strip empty lines / trailing spaces from a commit message template

* ci/commit--interactive-atomic (2011-05-07) 4 commits
 - Add commit to list of config.singlekey commands
 - Add support for -p/--patch to git-commit
 - Allow git commit --interactive with paths
 - Use a temporary index for git commit --interactive
 (this branch uses vh/config-interactive-singlekey-doc.)

* jn/gitweb-dependency (2011-05-07) 2 commits
  (merged to 'next' on 2011-05-08 at 9101342)
 + Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
 + git-instaweb: Simplify build dependency on gitweb

* jn/maint-test-merge-verify-parents (2011-05-06) 2 commits
  (merged to 'next' on 2011-05-08 at 35a7c66)
 + tests: teach verify_parents to check for extra parents
 + tests: eliminate unnecessary setup test assertions

* rr/rerere-libify-clear-gc (2011-05-08) 1 commit
 - rerere: libify rerere_clear() and rerere_gc()

This is pure code movement.  Changing them to suit the need of other
callers can be built on it as separate patches.

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

* jc/t1506-shell-param-expansion-gotcha (2011-05-08) 1 commit
 - t1507: avoid "${parameter<op>'word'}" inside double-quotes

--------------------------------------------------
[Stalled]

* kk/maint-prefix-in-config-mak (2011-05-04) 3 commits
 - config.mak.in: allow "configure --sysconfdir=/else/where"
 - Makefile: allow sysconfdir to be used from configure
  (merged to 'next' on 2011-05-02 at c747ba3)
 + Honor $(prefix) set in config.mak* when defining ETC_GIT* and sysconfdir

J6t is unhappy that sysconfdir is ignored in relocatable case. Although I
personally do not think that is a problem, as it has never been an issue,
let's see what others think.

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
 (this branch uses jn/ctags.)

Waiting for comments.

* jc/dotdot-is-parent-directory (2011-05-02) 1 commit
 - specifying ranges: we did not mean to make ".." an empty set

Updated documentation.

* mg/diff-stat-count (2011-05-03) 2 commits
 - diff-options.txt: describe --stat-{width,name-width,count}
 - diff: introduce --stat-count to limit the stat lines

There was a miscounting spotted.  Need another round.

* jc/require-work-tree-exists (2011-05-04) 1 commit
 - require-work-tree wants more than what its name says

Make "git pull" run from a random place work as long as GIT_DIR and
GIT_WORK_TREE are set up correctly.  I am not absolutely sure if that
is a sane use case, though.

* jc/add-delete-default (2011-04-19) 1 commit
 - git add: notice removal of tracked paths by default
 (this branch uses jc/fix-add-u-unmerged.)

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

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

* sr/maint-fast-import-tighten-option-parsing (2011-05-05) 1 commit
  (merged to 'next' on 2011-05-08 at 367b148)
 + fast-import: fix option parser for no-arg options

Will merge to "master".

* mg/merge-ff-config (2011-05-06) 3 commits
  (merged to 'next' on 2011-05-08 at 977b432)
 + tests: check git does not barf on merge.ff values for future versions of git
 + merge: introduce merge.ff configuration variable
 + Merge branch 'jc/maint-branch-mergeoptions' into mg/merge-ff-config
 (this branch uses jc/maint-branch-mergeoptions.)

* mk/grep-pcre (2011-05-05) 3 commits
  (merged to 'next' on 2011-05-08 at 5d3bede)
 + grep: Put calls to fixmatch() and regmatch() into patmatch()
 + contrib/completion: --line-number to git grep
 + Documentation: Add --line-number to git-grep synopsis

This is without the real PCRE integration.  The above three looked
reasonable clean-ups regardless.

* vh/config-interactive-singlekey-doc (2011-05-05) 5 commits
  (merged to 'next' on 2011-05-06 at 46b522c)
 + git-reset.txt: better docs for '--patch'
 + git-checkout.txt: better docs for '--patch'
 + git-stash.txt: better docs for '--patch'
 + git-add.txt: document 'interactive.singlekey'
 + config.txt: 'interactive.singlekey; is used by...
 (this branch is used by ci/commit--interactive-atomic.)

* jc/maint-branch-mergeoptions (2011-05-04) 1 commit
  (merged to 'next' on 2011-05-08 at fa6b154)
 + merge: make branch.<name>.mergeoptions correctly override merge.<option>
 (this branch is used by mg/merge-ff-config.)

Fix branch.<name>.mergeoptions that does not override merge.<option>; this
is needed for the "merge.ff" configuration topic to correctly work.

* jn/ctags (2011-04-29) 3 commits
  (merged to 'next' on 2011-05-06 at 5c574ff)
 + gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
 + gitweb: Change the way "content tags" ('ctags') are handled
 + gitweb: Restructure projects list generation
 (this branch is used by jn/ctags-more.)

Will merge to "master".

* dm/http-cleanup (2011-05-05) 4 commits
  (merged to 'next' on 2011-05-06 at 711ff78)
 + t5541-http-push: add test for chunked
 + http-push: refactor curl_easy_setup madness
 + http-push: use const for strings in signatures
 + http: make curl callbacks match contracts from curl header

Will merge to "master".

* sg/completion-updates (2011-04-27) 2 commits
  (merged to 'next' on 2011-05-08 at 761178c)
 + completion: move private shopt shim for zsh to __git_ namespace
  (merged to 'next' on 2011-05-02 at 0fd443a)
 + completion: don't declare 'local words' to make zsh happy

With an update from Jonathan.
Will merge to "master".

* jc/maint-add-p-overlapping-hunks (2011-05-08) 5 commits
  (merged to 'next' on 2011-05-08 at bcf9228)
 + t3701: add-p-fix makes the last test to pass
  (merged to 'next' on 2011-05-02 at e57b66f)
 + "add -p": work-around an old laziness that does not coalesce hunks
 + add--interactive.perl: factor out repeated --recount option
 + t3701: Editing a split hunk in an "add -p" session
 + add -p: 'q' should really quit

Will merge to "master".

* ld/p4-preserve-user-names (2011-05-07) 2 commits
 - git-p4: small improvements to user-preservation
  (merged to 'next' on 2011-04-29 at 25116c8)
 + git-p4: add option to preserve user names

An incremental update waiting for a re-review.

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

Will merge to "master" by the end of week #3.

* jn/setup-revisions-glob-and-friends-passthru (2011-04-21) 2 commits
  (merged to 'next' on 2011-04-28 at 6006cc4)
 + revisions: allow --glob and friends in parse_options-enabled commands
 + revisions: split out handle_revision_pseudo_opt function

Will merge to "master" by the end of week #3.

* cn/log-parse-opt (2011-04-14) 1 commit
  (merged to 'next' on 2011-04-28 at 02f2eac)
 + log: convert to parse-options

Will merge to "master" by the end of week #3.

* jc/fix-add-u-unmerged (2011-04-20) 1 commit
  (merged to 'next' on 2011-04-28 at f7ed821)
 + Fix "add -u" that sometimes fails to resolve unmerged paths
 (this branch is used by jc/add-delete-default.)

Will merge to "master" by the end of week #3.

* js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix (2011-05-05) 2 commits
 + send-pack: unbreak push over stateless rpc
 + send-pack: avoid deadlock when pack-object dies early
 (this branch is used by js/maint-send-pack-stateless-rpc-deadlock-fix.)

Will merge to "master" by the end of week #3.

* js/maint-send-pack-stateless-rpc-deadlock-fix (2011-05-05) 2 commits
  (merged to 'next' on 2011-05-05 at 3f4ffb9)
 + Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
  (merged to 'next' on 2011-04-28 at db7e04a)
 + Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
 (this branch uses js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix.)

Will merge to "master" by the end of week #3.

* jc/magic-pathspec (2011-04-06) 3 commits
  (merged to 'next' on 2011-04-25 at 788cd46)
 + magic pathspec: add ":(icase)path" to match case insensitively
 + magic pathspec: futureproof shorthand form
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support

Thanks to Peff, Duy, and Michael for helping to whip the syntax and the
basic semantics into a not-so-horrible shape.  Duy wanted to add tests.

Taking out of "will-merge-soon" list before all the tests pass.

--------------------------------------------------
[Discarded]

* rr/rerere-clear-libify (2011-04-13) 1 commit
 . rerere: Expose an API corresponding to 'clear' functionality

Re-roll is happening...
