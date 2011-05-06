From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #03; Fri, 6)
Date: Fri, 06 May 2011 16:22:30 -0700
Message-ID: <7v7ha3xvm1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:22:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIUM8-0004in-Ik
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 01:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab1EFXWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 19:22:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1EFXWh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 19:22:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E1AA44702;
	Fri,  6 May 2011 19:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	I4qycNjmttiQs72dLigMRWAeu0=; b=ibaSEBkjg6OdTNMx+us/MH3u16JiFJZMB
	nKcL5/Gva2PT0XeF1fKCs+nD4RfoTrODRLGopE0xZMKDbDSKS9IhfSk1st+cDd52
	SGllnfSOuIdUbXwOy813HHQPNh6K5V31s+T29CLcwk601M+PygCudAJpX0rx+z0H
	CNlzPSAmTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=rfF
	6uOQ7D/iQC7/wc5618+fhle/awdTqH3hqq7UzFU5EnI5iE+RHM+GWKH8A5n/+BLZ
	Ld7iYNE4hZiSYjO+oR3CAAsATaL7Jxt8co25C27IhM/I7QHlSLdZF5YXw2neVbbc
	SN5BZezPYSxlBCAOUgTUhklWBHv7e9dHSKce5KTg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CE27B46FE;
	Fri,  6 May 2011 19:24:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 936E046FC; Fri,  6 May 2011
 19:24:35 -0400 (EDT)
X-master-at: 4e3aa87d13b339fa678cd3cb7f23664d3a48fb21
X-next-at: 711ff7850102428a21459848c6ae899101e93bc6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 028C5E44-7838-11E0-8260-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173028>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are late in the week #2 of this cycle.

--------------------------------------------------
[Graduated to "master"]

* aw/maint-rebase-i-p-no-ff (2011-04-28) 1 commit
  (merged to 'next' on 2011-05-02 at 9a159a5)
 + git-rebase--interactive.sh: preserve-merges fails on merges created with no-ff

* cj/p4merge (2011-05-01) 1 commit
  (merged to 'next' on 2011-05-02 at 7197ef3)
 + Pass empty file to p4merge where no base is suitable.

* gr/cvsimport-alternative-cvspass-location (2011-05-01) 1 commit
  (merged to 'next' on 2011-05-02 at 5a89e3e)
 + Look for password in both CVS and CVSNT password files.

* im/hashcmp-optim (2011-04-28) 1 commit
  (merged to 'next' on 2011-05-02 at f131195)
 + hashcmp(): inline memcmp() by hand to optimize

* jc/fix-diff-files-unmerged (2011-04-22) 4 commits
  (merged to 'next' on 2011-04-28 at f1f837c)
 + diff-files: show unmerged entries correctly
 + diff: remove often unused parameters from diff_unmerge()
 + diff.c: return filepair from diff_unmerge()
 + test: use $_z40 from test-lib
 (this branch is used by jc/add-delete-default and jc/fix-add-u-unmerged.)

* jk/format-patch-quote-special-in-from (2011-04-08) 1 commit
  (merged to 'next' on 2011-04-28 at 587f2d4)
 + pretty: quote rfc822 specials in email addresses

* jk/merge-one-file-working-tree (2011-04-29) 2 commits
  (merged to 'next' on 2011-05-02 at 308fe21)
 + merge-one-file: fix broken merges with alternate work trees
 + add tests for merge-index / merge-one-file

* jn/run-command-error-failure (2011-04-20) 2 commits
  (merged to 'next' on 2011-04-26 at a1f171e)
 + run-command: handle short writes and EINTR in die_child
 + tests: check error message from run_command

* js/blame-parsename (2011-05-05) 2 commits
  (merged to 'next' on 2011-05-05 at 1d5e505)
 + t/annotate-tests: Use echo & cat instead of sed
  (merged to 'next' on 2011-04-29 at 5fde945)
 + blame: tolerate bogus e-mail addresses a bit better

* js/info-man-path (2011-05-02) 2 commits
  (merged to 'next' on 2011-05-02 at 20a15dd)
 + Documentation: clarify meaning of --html-path, --man-path, and --info-path
 + git: add --info-path and --man-path options

* mg/alias-expose-prefix (2011-04-27) 2 commits
  (merged to 'next' on 2011-05-02 at 1c01d3a)
 + handle_alias: provide GIT_PREFIX to !alias
 + t1020: test !alias in subdirectory

* mg/diff-uiconfig-doc (2011-04-27) 1 commit
  (merged to 'next' on 2011-05-02 at 579a515)
 + config.txt,diff-options.txt: porcelain vs. plumbing for color.diff

* nd/struct-pathspec (2011-04-05) 5 commits
  (merged to 'next' on 2011-04-25 at 65dbe80)
 + pathspec: rename per-item field has_wildcard to use_wildcard
 + Improve tree_entry_interesting() handling code
 + Convert read_tree{,_recursive} to support struct pathspec
 + Reimplement read_tree_recursive() using tree_entry_interesting()
 + Merge branch 'en/object-list-with-pathspec' into 'nd/struct-pathspec'

* sg/completion-cleanup (2011-04-28) 2 commits
 + completion: remove unnecessary _get_comp_words_by_ref() invocations
 + completion: don't modify the $cur variable in completion functions
 (this branch is used by sg/completion-updates.)

--------------------------------------------------
[New Topics]

* sr/maint-fast-import-tighten-option-parsing (2011-05-05) 1 commit
 - fast-import: fix option parser for no-arg options

Will merge to "next".

* jc/advice-about-to-lose-commit (2011-05-06) 1 commit
 - checkout: honor advice.detachedHead when reattaching to a branch

A weather-balloon.

* mg/merge-ff-config (2011-05-06) 2 commits
 - merge: introduce merge.ff configuration variable
 - Merge branch 'jc/maint-branch-mergeoptions' into mg/merge-ff-config
 (this branch uses jc/maint-branch-mergeoptions.)

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

* rr/rerere-clear-libify (2011-04-13) 1 commit
 - rerere: Expose an API corresponding to 'clear' functionality

Jonathan had good comments on moving the garbage collection interface as
well. Perhaps needs a re-roll.

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

--------------------------------------------------
[Cooking]

* mk/grep-pcre (2011-05-05) 3 commits
 - grep: Put calls to fixmatch() and regmatch() into patmatch()
 - contrib/completion: --line-number to git grep
 - Documentation: Add --line-number to git-grep synopsis

This is without the real PCRE integration.  The above three looked
reasonable clean-ups regardless.

Will merge to "next".

* vh/config-interactive-singlekey-doc (2011-05-05) 5 commits
  (merged to 'next' on 2011-05-06 at 46b522c)
 + git-reset.txt: better docs for '--patch'
 + git-checkout.txt: better docs for '--patch'
 + git-stash.txt: better docs for '--patch'
 + git-add.txt: document 'interactive.singlekey'
 + config.txt: 'interactive.singlekey; is used by...

* jc/maint-branch-mergeoptions (2011-05-04) 1 commit
 - merge: fix branch.<name>.mergeoptions
 (this branch is used by mg/merge-ff-config.)

Fix branch.<name>.mergeoptions that does not override merge.<option>; this
is needed for the "merge.ff" configuration topic to correctly work.

* jn/ctags (2011-04-29) 3 commits
  (merged to 'next' on 2011-05-06 at 5c574ff)
 + gitweb: Mark matched 'ctag' / contents tag (?by_tag=foo)
 + gitweb: Change the way "content tags" ('ctags') are handled
 + gitweb: Restructure projects list generation
 (this branch is used by jn/ctags-more.)

* dm/http-cleanup (2011-05-05) 4 commits
  (merged to 'next' on 2011-05-06 at 711ff78)
 + t5541-http-push: add test for chunked
 + http-push: refactor curl_easy_setup madness
 + http-push: use const for strings in signatures
 + http: make curl callbacks match contracts from curl header

* sg/completion-updates (2011-04-28) 1 commit
  (merged to 'next' on 2011-05-02 at 0fd443a)
 + completion: don't declare 'local words' to make zsh happy

* jc/maint-add-p-overlapping-hunks (2011-04-06) 4 commits
  (merged to 'next' on 2011-05-02 at e57b66f)
 + "add -p": work-around an old laziness that does not coalesce hunks
 + add--interactive.perl: factor out repeated --recount option
 + t3701: Editing a split hunk in an "add -p" session
 + add -p: 'q' should really quit

Probably needs tests.

* ld/p4-preserve-user-names (2011-04-21) 1 commit
  (merged to 'next' on 2011-04-29 at 25116c8)
 + git-p4: add option to preserve user names

Luke wants to update this, so will not be merging to "master" until the
update settles down.

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

Will merge to "master" by the end of week #3.
