From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2010, #03; Fri, 10)
Date: Fri, 10 Dec 2010 23:49:50 -0800
Message-ID: <7voc8sagv5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 11 08:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRKDj-0003ku-26
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 08:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab0LKHuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 02:50:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60249 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0LKHt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 02:49:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38CD925B6;
	Sat, 11 Dec 2010 02:50:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Ys4T
	Ol5f7TBv1q83JgpIcL5b4gs=; b=kzwQRWk/msbC0x8UcQRtOMDfgAsNrSCpp4cZ
	UFDgCRQGkzHWacijj86zmLLQ6N6ogqbd22zJNFlX7c+VCPOjFjQkQSJCE3wprS0e
	b571QlCb4806TBnZ/jMwqpKJvpqCVIHAaP63hFABZt0wxqIK8GKyFMDD8BGOwAAL
	Pv61b+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YXm
	fxXMyMvxxrJddrrg2sMo+HWG/DrxlvM4vVt2R+BZPjNjB23Wl/rIhIvtIJ/a8G03
	gCb28NDQ7T2x/U5fhAv5NCwd1FpTFVEOVnBGv2j+dwo0mHv3W0NRAVAiIfAT3nkN
	Gapgv+UUCfuj2F0kZ2PEmrZrXCzobLtJNW3JAwLo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 248D125B5;
	Sat, 11 Dec 2010 02:50:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8E4C925B4; Sat, 11 Dec 2010
 02:50:16 -0500 (EST)
X-master-at: 4443091d961e91041e64c1675940f0585eeba456
X-next-at: 018bc80d140aff02f61e3a5100dd1367311d38ff
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CB14A1C-04FB-11E0-B173-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163459>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Some hawk-eyes among you might have noticed that I've been re-reading many
series and merging them to 'next' at a lot quicker pace than usual for the
last few days, and that would mean only one thing.  I don't think we have
quite enough time to deliver anything solid by the year end, but let's
wrap up the current round and prepare to tag 1.7.4 soonish.

--------------------------------------------------
[New Topics]

* jh/gitweb-caching-8 (2010-12-09) 18 commits
 . gitweb: Add better error handling for gitweb caching
 . gitweb: Prepare for cached error pages & better error page handling
 . gitweb: When changing output (STDOUT) change STDERR as well
 . gitweb: Add show_warning() to display an immediate warning, with refresh
 . gitweb: add print_transient_header() function for central header printing
 . gitweb: Add commented url & url hash to page footer
 . gitweb: Change file handles (in caching) to lexical variables as opposed to globs
 . gitweb: add isDumbClient() check
 . gitweb: Adding isBinaryAction() and isFeedAction() to determine the action type
 . gitweb: Revert reset_output() back to original code
 . gitweb: Change is_cacheable() to return true always
 . gitweb: Revert back to $cache_enable vs. $caching_enabled
 . gitweb: Add more explicit means of disabling 'Generating...' page
 . gitweb: Regression fix concerning binary output of files
 . gitweb: Minimal testing of gitweb caching
 . gitweb: File based caching layer (from git.kernel.org)
 . gitweb: add output buffering and associated functions
 . gitweb: Prepare for splitting gitweb

It appears that John and Jakub are finally working together to help
producing something that we can ship in-tree, finally.  I am looking
forward to seeing the conclusion of the discussion.

* rj/msvc-fix (2010-12-04) 4 commits
  (merged to 'next' on 2010-12-10 at 7a2c2c6)
 + msvc: Fix macro redefinition warnings
 + msvc: Fix build by adding missing INTMAX_MAX define
 + msvc: git-daemon.exe: Fix linker "unresolved externals" error
 + msvc: Fix compilation errors in compat/win32/sys/poll.c

--------------------------------------------------
[Stalled]

* nd/index-doc (2010-09-06) 1 commit
 - doc: technical details about the index file format

Half-written but it is a good start.  I may need to give some help in
describing more recent index extensions.

* cb/ignored-paths-are-precious (2010-08-21) 1 commit
 - checkout/merge: optionally fail operation when ignored files need to be overwritten

This needs tests; also we know of longstanding bugs in related area that
needs to be addressed---they do not have to be part of this series but
their reproduction recipe would belong to the test script for this topic.

It would hurt users to make the new feature on by default, especially the
ones with subdirectories that come and go.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* tr/config-doc (2010-10-24) 2 commits
 . Documentation: complete config list from other manpages
 . Documentation: Move variables from config.txt to separate file

This unfortunately heavily conflicts with patches in flight...

--------------------------------------------------
[Cooking]

* ak/describe-exact (2010-12-09) 4 commits
  (merged to 'next' on 2010-12-10 at 33497db)
 + describe: Delay looking up commits until searching for an inexact match
 + describe: Store commit_names in a hash table by commit SHA1
 + describe: Do not use a flex array in struct commit_name
 + describe: Use for_each_rawref

Rerolled and looked fine.

* jc/maint-svn-info-test-fix (2010-12-06) 1 commit
  (merged to 'next' on 2010-12-08 at f821694)
 + t9119: do not compare "Text Last Updated" line from "svn info"

* jn/submodule-b-current (2010-12-05) 2 commits
  (merged to 'next' on 2010-12-08 at 33423f3)
 + git submodule: Remove now obsolete tests before cloning a repo
 + git submodule -b ... of current HEAD fails

* jc/maint-no-openssl-build-fix (2010-12-08) 1 commit
  (merged to 'next' on 2010-12-08 at e348a87)
 + Do not link with -lcrypto under NO_OPENSSL

* aa/status-hilite-branch (2010-12-09) 2 commits
  (merged to 'next' on 2010-12-10 at d00551d)
 + default color.status.branch to "same as header"
  (merged to 'next' on 2010-12-08 at 0291858)
 + status: show branchname with a configurable color

Will merge to 'master'.

* ef/help-cmd-prefix (2010-11-26) 1 commit
  (merged to 'next' on 2010-12-08 at c92752e)
 + help: always suggest common-cmds if prefix of cmd

Will merge to 'master'.

* jn/fast-import-blob-access (2010-12-03) 5 commits
  (merged to 'next' on 2010-12-08 at a42f0b3)
 + t9300: remove unnecessary use of /dev/stdin
 + fast-import: Allow cat-blob requests at arbitrary points in stream
 + fast-import: let importers retrieve blobs
 + fast-import: clarify documentation of "feature" command
 + fast-import: stricter parsing of integer options

Will merge to 'master'.

* jn/gitweb-per-request-config (2010-11-28) 2 commits
  (merged to 'next' on 2010-12-08 at 44be9e5)
 + gitweb: document $per_request_config better
 + gitweb: selectable configurations that change with each request

Will merge to 'master'.

* kb/diff-C-M-synonym (2010-11-10) 2 commits
 - diff: use "find" instead of "detect" as prefix for long forms of -M and -C
 - diff: add --detect-copies-harder as a synonym for --find-copies-harder

* mg/cvsimport (2010-11-28) 3 commits
 - cvsimport.txt: document the mapping between config and options
 - cvsimport: fix the parsing of uppercase config options
 - cvsimport: partial whitespace cleanup

I was being lazy and said "Ok" to "cvsimport.capital-r" but luckily other
people injected sanity to the discussion.  Weatherbaloon patch sent, but
not queued here.

* mz/maint-rebase-stat-config (2010-11-09) 1 commit
  (merged to 'next' on 2010-12-08 at 97d4912)
 + rebase: only show stat if configured to true

Will merge to 'master'.

* mz/pull-rebase-rebased (2010-11-13) 1 commit
  (merged to 'next' on 2010-12-08 at 99c1762)
 + Use reflog in 'pull --rebase . foo'

Will merge to 'master'.

* nd/maint-hide-checkout-index-from-error (2010-11-28) 1 commit
  (merged to 'next' on 2010-12-08 at 1869996)
 + entry.c: remove "checkout-index" from error messages

Will merge to 'master'.

* tf/commit-list-prefix (2010-11-26) 1 commit
 - commit: Add commit_list prefix in two function names.

* gb/web--browse (2010-12-03) 4 commits
  (merged to 'next' on 2010-12-08 at cff4009)
 + web--browse: better support for chromium
 + web--browse: support opera, seamonkey and elinks
 + web--browse: split valid_tool list
 + web--browse: coding style

The remainder of the series, which is mostly Debian specific addition, can
wait (or just left for the distro).

Will merge to 'master'.

* ja/maint-pull-rebase-doc (2010-12-03) 1 commit
  (merged to 'next' on 2010-12-08 at 211bf89)
 + git-pull.txt: Mention branch.autosetuprebase

Will merge to 'master'.

* js/configurable-tab (2010-11-30) 2 commits
  (merged to 'next' on 2010-12-08 at 3257365)
 + Make the tab width used for whitespace checks configurable
 + Merge branch 'js/maint-apply-tab-in-indent-fix' into HEAD
 (this branch uses js/maint-apply-tab-in-indent-fix.)

Will merge to 'master'.

* js/maint-apply-tab-in-indent-fix (2010-11-30) 1 commit
  (merged to 'next' on 2010-12-08 at 02aedd5)
 + apply --whitespace=fix: fix tab-in-indent
 (this branch is used by js/configurable-tab.)

Will merge to 'master'.

* pd/bash-4-completion (2010-12-01) 2 commits
 - Use the new functions to get the current cword.
 - Introduce functions from bash-completion project.

There is a "here is a better way to do this" from Jonathan, but I lost
track.

* ef/win32-dirent (2010-11-23) 6 commits
  (merged to 'next' on 2010-12-08 at 1a7169d)
 + win32: use our own dirent.h
 + msvc: opendir: handle paths ending with a slash
 + win32: dirent: handle errors
 + msvc: opendir: do not start the search
 + msvc: opendir: allocate enough memory
 + msvc: opendir: fix malloc-failure

Will merge to 'master'.

* jk/asciidoc-update (2010-11-19) 1 commit
  (merged to 'next' on 2010-12-08 at 72ffafe)
 + docs: default to more modern toolset

Will merge to 'master'.

* jk/maint-reflog-bottom (2010-11-21) 1 commit
  (merged to 'next' on 2010-12-08 at f5ca80a)
 + reflogs: clear flags properly in corner case

Will merge to 'master'.

* jn/fast-import-ondemand-checkpoint (2010-11-22) 1 commit
  (merged to 'next' on 2010-12-08 at f538396)
 + fast-import: treat SIGUSR1 as a request to access objects early

Will merge to 'master'.

* jn/maint-fast-import-object-reuse (2010-11-23) 1 commit
  (merged to 'next' on 2010-12-08 at 5d29c08)
 + fast-import: insert new object entries at start of hash bucket

Will merge to 'master'.

* jn/maint-svn-fe (2010-12-08) 4 commits
  (merged to 'next' on 2010-12-09 at 98beb7c)
 + t9010 fails when no svn is available
  (merged to 'next' on 2010-12-08 at e25350b)
 + vcs-svn: fix intermittent repo_tree corruption
 + treap: make treap_insert return inserted node
 + t9010 (svn-fe): Eliminate dependency on svn perl bindings

Will merge to 'master'.

* jn/svn-fe (2010-12-06) 18 commits
 - vcs-svn: Allow change nodes for root of tree (/)
 - vcs-svn: Implement Prop-delta handling
 - vcs-svn: Sharpen parsing of property lines
 - vcs-svn: Split off function for handling of individual properties
 - vcs-svn: Make source easier to read on small screens
 - vcs-svn: More dump format sanity checks
 - vcs-svn: Reject path nodes without Node-action
 - vcs-svn: Delay read of per-path properties
 - vcs-svn: Combine repo_replace and repo_modify functions
 - vcs-svn: Replace = Delete + Add
 - vcs-svn: handle_node: Handle deletion case early
 - vcs-svn: Use mark to indicate nodes with included text
 - vcs-svn: Unclutter handle_node by introducing have_props var
 - vcs-svn: Eliminate node_ctx.mark global
 - vcs-svn: Eliminate node_ctx.srcRev global
 - vcs-svn: Check for errors from open()
 - vcs-svn: Allow simple v3 dumps (no deltas yet)
 - vcs-svn: Error out for v3 dumps

Some RFC patches, to give them early and wider exposure.

* mz/rebase-abort-reflog-fix (2010-11-21) 1 commit
  (merged to 'next' on 2010-12-08 at adce2e1)
 + rebase --abort: do not update branch ref

Will merge to 'master'.

* mz/rebase-i-verify (2010-11-22) 1 commit
  (merged to 'next' on 2010-12-08 at 18275df)
 + rebase: support --verify

Will merge to 'master'.

* nd/maint-relative (2010-11-20) 1 commit
  (merged to 'next' on 2010-12-10 at 018bc80)
 + get_cwd_relative(): do not misinterpret root path

* tc/format-patch-p (2010-11-23) 1 commit
  (merged to 'next' on 2010-12-08 at e8bff23)
 + format-patch: page output with --stdout

Will merge to 'master'.

* tc/http-urls-ends-with-slash (2010-11-25) 9 commits
  (merged to 'next' on 2010-12-08 at b9a878a)
 + http-fetch: rework url handling
 + http-push: add trailing slash at arg-parse time, instead of later on
 + http-push: check path length before using it
 + http-push: Normalise directory names when pushing to some WebDAV servers
 + http-backend: use end_url_with_slash()
 + url: add str wrapper for end_url_with_slash()
 + shift end_url_with_slash() from http.[ch] to url.[ch]
 + t5550-http-fetch: add test for http-fetch
 + t5550-http-fetch: add missing '&&'

Will merge to 'master'.

* nd/extended-sha1-relpath (2010-12-09) 3 commits
  (merged to 'next' on 2010-12-10 at 0018aa6)
 + get_sha1: teach ":$n:<path>" the same relative path logic
  (merged to 'next' on 2010-12-08 at 940e5e2)
 + get_sha1: support relative path ":path" syntax
 + Make prefix_path() return char* without const
 (this branch uses jn/parse-options-extra.)

* nd/maint-fix-add-typo-detection (2010-11-27) 5 commits
 - Revert "excluded_1(): support exclude files in index"
 - unpack-trees: fix sparse checkout's "unable to match directories"
 - unpack-trees: move all skip-worktree checks back to unpack_trees()
 - dir.c: add free_excludes()
 - cache.h: realign and use (1 << x) form for CE_* constants

Note that the commit that used to be at the bottom of this series
have been merged to 'master' (it was a no-op fix).

* jh/gitweb-caching (2010-12-03) 4 commits
 . gitweb: Minimal testing of gitweb caching
 . gitweb: File based caching layer (from git.kernel.org)
 . gitweb: add output buffering and associated functions
 . gitweb: Prepare for splitting gitweb

Previous iteration; dropped.

* jn/parse-options-extra (2010-12-01) 10 commits
  (merged to 'next' on 2010-12-08 at 3a3e3ac)
 + update-index: migrate to parse-options API
 + setup: save prefix (original cwd relative to toplevel) in startup_info
 + parse-options: make resuming easier after PARSE_OPT_STOP_AT_NON_OPTION
 + parse-options: allow git commands to invent new option types
 + parse-options: never suppress arghelp if LITERAL_ARGHELP is set
 + parse-options: do not infer PARSE_OPT_NOARG from option type
 + parse-options: sanity check PARSE_OPT_NOARG flag
 + parse-options: move NODASH sanity checks to parse_options_check
 + parse-options: clearer reporting of API misuse
 + parse-options: Don't call parse_options_check() so much
 (this branch is used by nd/extended-sha1-relpath.)

Will merge to 'master'.

* nd/setup (2010-11-26) 47 commits
 - git.txt: correct where --work-tree path is relative to
 - Revert "Documentation: always respect core.worktree if set"
 - t0001: test git init when run via an alias
 - Remove all logic from get_git_work_tree()
 - setup: rework setup_explicit_git_dir()
 - setup: clean up setup_discovered_git_dir()
 - t1020-subdirectory: test alias expansion in a subdirectory
 - setup: clean up setup_bare_git_dir()
 - setup: limit get_git_work_tree()'s to explicit setup case only
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - rev-parse: prints --git-dir relative to user's cwd
 - git-rev-parse.txt: clarify --git-dir
 - t1510: setup case #31
 - t1510: setup case #30
 - t1510: setup case #29
 - t1510: setup case #28
 - t1510: setup case #27
 - t1510: setup case #26
 - t1510: setup case #25
 - t1510: setup case #24
 - t1510: setup case #23
 - t1510: setup case #22
 - t1510: setup case #21
 - t1510: setup case #20
 - t1510: setup case #19
 - t1510: setup case #18
 - t1510: setup case #17
 - t1510: setup case #16
 - t1510: setup case #15
 - t1510: setup case #14
 - t1510: setup case #13
 - t1510: setup case #12
 - t1510: setup case #11
 - t1510: setup case #10
 - t1510: setup case #9
 - t1510: setup case #8
 - t1510: setup case #7
 - t1510: setup case #6
 - t1510: setup case #5
 - t1510: setup case #4
 - t1510: setup case #3
 - t1510: setup case #2
 - t1510: setup case #1
 - t1510: setup case #0
 - Add t1510 and basic rules that run repo setup
 - builtins: print setup info if repo is found

Will re-read these, hoping to merge them before the end of the year. 

* jn/git-cmd-h-bypass-setup (2010-10-22) 7 commits
  (merged to 'next' on 2010-12-08 at 0fc3158)
 + update-index -h: show usage even with corrupt index
 + merge -h: show usage even with corrupt index
 + ls-files -h: show usage even with corrupt index
 + gc -h: show usage even with broken configuration
 + commit/status -h: show usage even with broken configuration
 + checkout-index -h: show usage even in an invalid repository
 + branch -h: show usage even in an invalid repository

Will merge to 'master'.

* yd/dir-rename (2010-10-29) 5 commits
 - Allow hiding renames of individual files involved in a directory rename.
 - Unified diff output format for bulk moves.
 - Add testcases for the --detect-bulk-moves diffcore flag.
 - Raw diff output format for bulk moves.
 - Introduce bulk-move detection in diffcore.

Need to re-queue the reroll.

* nd/struct-pathspec (2010-09-20) 11 commits
 - ce_path_match: drop prefix matching in favor of match_pathspec
 - Convert ce_path_match() to use struct pathspec
 - tree_entry_interesting: turn to match_pathspec if wildcard is present
 - pathspec: add tree_recursive_diff parameter
 - pathspec: mark wildcard pathspecs from the beginning
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - pathspec: cache string length when initializing pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is tangled with en/object-list-with-pathspec.)

This is related to something I have long been wanting to see happen.
Wait Nguyen for another round (2010-11-11).

* en/object-list-with-pathspec (2010-09-20) 8 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - pathspec: cache string length when initializing pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is tangled with nd/struct-pathspec.)

* jl/fetch-submodule-recursive (2010-12-09) 4 commits
  (merged to 'next' on 2010-12-10 at edd0bf0)
 + fetch_populated_submodules(): document dynamic allocation
  (merged to 'next' on 2010-12-08 at 676c4f5)
 + Submodules: Add the "fetchRecurseSubmodules" config option
 + Add the 'fetch.recurseSubmodules' config setting
 + fetch/pull: Add the --recurse-submodules option

After giving another look, I think this is Ok, although I didn't quite get
where the magic number 5 in fetch_populated_submodules() came from.

Will merge to 'master'.

* tr/merge-unborn-clobber (2010-08-22) 1 commit
 - Exhibit merge bug that clobbers index&WT

* ab/i18n (2010-10-07) 161 commits
 - po/de.po: complete German translation
 - po/sv.po: add Swedish translation
 - gettextize: git-bisect bisect_next_check "You need to" message
 - gettextize: git-bisect [Y/n] messages
 - gettextize: git-bisect bisect_replay + $1 messages
 - gettextize: git-bisect bisect_reset + $1 messages
 - gettextize: git-bisect bisect_run + $@ messages
 - gettextize: git-bisect die + eval_gettext messages
 - gettextize: git-bisect die + gettext messages
 - gettextize: git-bisect echo + eval_gettext message
 - gettextize: git-bisect echo + gettext messages
 - gettextize: git-bisect gettext + echo message
 - gettextize: git-bisect add git-sh-i18n
 - gettextize: git-stash drop_stash say/die messages
 - gettextize: git-stash "unknown option" message
 - gettextize: git-stash die + eval_gettext $1 messages
 - gettextize: git-stash die + eval_gettext $* messages
 - gettextize: git-stash die + eval_gettext messages
 - gettextize: git-stash die + gettext messages
 - gettextize: git-stash say + gettext messages
 - gettextize: git-stash echo + gettext message
 - gettextize: git-stash add git-sh-i18n
 - gettextize: git-submodule "blob" and "submodule" messages
 - gettextize: git-submodule "path not initialized" message
 - gettextize: git-submodule "[...] path is ignored" message
 - gettextize: git-submodule "Entering [...]" message
 - gettextize: git-submodule $errmsg messages
 - gettextize: git-submodule "Submodule change[...]" messages
 - gettextize: git-submodule "cached cannot be used" message
 - gettextize: git-submodule $update_module say + die messages
 - gettextize: git-submodule die + eval_gettext messages
 - gettextize: git-submodule say + eval_gettext messages
 - gettextize: git-submodule echo + eval_gettext messages
 - gettextize: git-submodule add git-sh-i18n
 - gettextize: git-pull "rebase against" / "merge with" messages
 - gettextize: git-pull "[...] not currently on a branch" message
 - gettextize: git-pull "You asked to pull" message
 - gettextize: git-pull split up "no candidate" message
 - gettextize: git-pull eval_gettext + warning message
 - gettextize: git-pull eval_gettext + die message
 - gettextize: git-pull die messages
 - gettextize: git-pull add git-sh-i18n
 - gettext docs: add "Testing marked strings" section to po/README
 - gettext docs: the Git::I18N Perl interface
 - gettext docs: the git-sh-i18n.sh Shell interface
 - gettext docs: the gettext.h C interface
 - gettext docs: add "Marking strings for translation" section in po/README
 - gettext docs: add a "Testing your changes" section to po/README
 - po/pl.po: add Polish translation
 - po/hi.po: add Hindi Translation
 - po/en_GB.po: add British English translation
 - po/de.po: add German translation
 - Makefile: only add gettext tests on XGETTEXT_INCLUDE_TESTS=YesPlease
 - gettext docs: add po/README file documenting Git's gettext
 - gettextize: git-am printf(1) message to eval_gettext
 - gettextize: git-am core say messages
 - gettextize: git-am "Apply?" message
 - gettextize: git-am clean_abort messages
 - gettextize: git-am cannot_fallback messages
 - gettextize: git-am die messages
 - gettextize: git-am eval_gettext messages
 - gettextize: git-am multi-line getttext $msg; echo
 - gettextize: git-am one-line gettext $msg; echo
 - gettextize: git-am add git-sh-i18n
 - gettext tests: add GETTEXT_POISON tests for shell scripts
 - gettext tests: add GETTEXT_POISON support for shell scripts
 - Makefile: MSGFMT="msgfmt --check" under GNU_GETTEXT
 - Makefile: add GNU_GETTEXT, set when we expect GNU gettext
 - gettextize: git-shortlog basic messages
 - gettextize: git-revert split up "could not revert/apply" message
 - gettextize: git-revert literal "me" messages
 - gettextize: git-revert "Your local changes" message
 - gettextize: git-revert basic messages
 - gettextize: git-notes "Refusing to %s notes in %s" message
 - gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
 - gettextize: git-notes basic commands
 - gettextize: git-gc "Auto packing the repository" message
 - gettextize: git-gc basic messages
 - gettextize: git-describe basic messages
 - gettextize: git-clean clean.requireForce messages
 - gettextize: git-clean basic messages
 - gettextize: git-bundle basic messages
 - gettextize: git-archive basic messages
 - gettextize: git-status "renamed: " message
 - gettextize: git-status "Initial commit" message
 - gettextize: git-status "Changes to be committed" message
 - gettextize: git-status shortstatus messages
 - gettextize: git-status "nothing to commit" messages
 - gettextize: git-status basic messages
 - gettextize: git-push "prevent you from losing" message
 - gettextize: git-push basic messages
 - gettextize: git-tag tag_template message
 - gettextize: git-tag basic messages
 - gettextize: git-reset "Unstaged changes after reset" message
 - gettextize: git-reset reset_type_names messages
 - gettextize: git-reset basic messages
 - gettextize: git-rm basic messages
 - gettextize: git-mv "bad" messages
 - gettextize: git-mv basic messages
 - gettextize: git-merge "Wonderful" message
 - gettextize: git-merge "You have not concluded your merge" messages
 - gettextize: git-merge "Updating %s..%s" message
 - gettextize: git-merge basic messages
 - gettextize: git-log "--OPT does not make sense" messages
 - gettextize: git-log basic messages
 - gettextize: git-grep "--open-files-in-pager" message
 - gettextize: git-grep basic messages
 - gettextize: git-fetch split up "(non-fast-forward)" message
 - gettextize: git-fetch update_local_ref messages
 - gettextize: git-fetch formatting messages
 - gettextize: git-fetch basic messages
 - gettextize: git-diff basic messages
 - gettextize: git-commit advice messages
 - gettextize: git-commit "enter the commit message" message
 - gettextize: git-commit print_summary messages
 - gettextize: git-commit formatting messages
 - gettextize: git-commit "middle of a merge" message
 - gettextize: git-commit basic messages
 - gettextize: git-checkout "Switched to a .. branch" message
 - gettextize: git-checkout "HEAD is now at" message
 - gettextize: git-checkout describe_detached_head messages
 - gettextize: git-checkout: our/their version message
 - gettextize: git-checkout basic messages
 - gettextize: git-branch "(no branch)" message
 - gettextize: git-branch "git branch -v" messages
 - gettextize: git-branch "Deleted branch [...]" message
 - gettextize: git-branch "remote branch '%s' not found" message
 - gettextize: git-branch basic messages
 - gettextize: git-add refresh_index message
 - gettextize: git-add "remove '%s'" message
 - gettextize: git-add "pathspec [...] did not match" message
 - gettextize: git-add "Use -f if you really want" message
 - gettextize: git-add "no files added" message
 - gettextize: git-add basic messages
 - gettextize: git-clone "Cloning into" message
 - gettextize: git-clone basic messages
 - gettext tests: test message re-encoding under C
 - po/is.po: add Icelandic translation
 - gettext tests: mark a test message as not needing translation
 - gettext tests: test re-encoding with a UTF-8 msgid under Shell
 - gettext tests: test message re-encoding under Shell
 - gettext tests: add detection for is_IS.ISO-8859-1 locale
 - gettext tests: test if $VERSION exists before using it
 - gettextize: git-init "Initialized [...] repository" message
 - gettextize: git-init basic messages
 - gettext tests: skip lib-gettext.sh tests under GETTEXT_POISON
 - gettext tests: add GETTEXT_POISON=YesPlease Makefile parameter
 - gettext.c: use libcharset.h instead of langinfo.h when available
 - gettext.c: work around us not using setlocale(LC_CTYPE, "")
 - builtin.h: Include gettext.h
 - Makefile: use variables and shorter lines for xgettext
 - Makefile: tell xgettext(1) that our source is in UTF-8
 - Makefile: provide a --msgid-bugs-address to xgettext(1)
 - Makefile: A variable for options used by xgettext(1) calls
 - gettext tests: locate i18n lib&data correctly under --valgrind
 - gettext: setlocale(LC_CTYPE, "") breaks Git's C function assumptions
 - gettext tests: rename test to work around GNU gettext bug
 - gettext: add infrastructure for translating Git with gettext
 - builtin: use builtin.h for all builtin commands
 - tests: use test_cmp instead of piping to diff(1)
 - t7004-tag.sh: re-arrange git tag comment for clarity

It is getting ridiculously painful to keep re-resolving the conflicts with
other topics in flight, even with the help with rerere.

Needs a bit more minor work to get the basic code structure right.
