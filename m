From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Tue, 21 Dec 2010 17:59:54 -0800
Message-ID: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 03:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVDzs-0003SC-F3
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 03:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628Ab0LVCAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 21:00:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0LVB77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 20:59:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E2A213995;
	Tue, 21 Dec 2010 21:00:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=sEyH
	Foq1pV3yzJhaeiiVJOKqG9M=; b=goR6+uoUV3/RiFi59zVBIoT5OpFZDt7ggwS6
	w7DXp8gjLpWn8KbXsT48fGti6t7u+1jhRN7VZKpCfymc0xwas2GsPGAnKm4Aik3s
	Z9JejxZ9xTq9LUGWQBWkzO1gxHGW99QTiYykMtgOpOg/ffeNDupaFeAZcSloqX/V
	RPDPorc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=k9P
	VCMcfys8PqDq2Z8uU+820QdoGZCZS01q86/KYXoOHw2mnB9cAYaqj6lojAW+aCFi
	EAus74HRVrnkMY35YESvrTHIzI19bTxu6Xsa5bSto7l/o8kHoEA3VqnHby9sYdL+
	P9WgfssxARkAq6Dr80LxidxCvaivuu9V7CVW8L1g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C98B83993;
	Tue, 21 Dec 2010 21:00:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7A9363992; Tue, 21 Dec 2010
 21:00:25 -0500 (EST)
X-master-at: 853563d7344ee532aa56f8a9aabcfdfb5c4fe2c3
X-next-at: 8883a0cd5dc07da65afadda4c449e5c028ed63f7
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F6E61B0-0D6F-11E0-BC1C-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164070>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I'd like to merge nd/setup, nd/struct-pathspec, and everything in
tonight's 'next' soon and tag 1.7.4-rc1 but I might be being a bit too
ambitious.
--------------------------------------------------
[Graduated to "master"]

* jk/maint-decorate-01-bool (2010-12-18) 1 commit
  (merged to 'next' on 2010-12-20 at 72471ca)
 + handle arbitrary ints in git_config_maybe_bool

* jk/t2107-now-passes (2010-12-18) 1 commit
  (merged to 'next' on 2010-12-20 at c9156b5)
 + t2107: mark passing test as success

* jn/maint-gitweb-pathinfo-fix (2010-12-14) 1 commit
  (merged to 'next' on 2010-12-14 at 1af8cca)
 + gitweb: Fix handling of whitespace in generated links

* ks/blame-worktree-textconv-cached (2010-12-18) 2 commits
  (merged to 'next' on 2010-12-20 at 459c940)
 + fill_textconv(): Don't get/put cache if sha1 is not valid
 + t/t8006: Demonstrate blame is broken when cachetextconv is on

* nd/oneline-sha1-name-from-specific-ref (2010-12-15) 4 commits
  (merged to 'next' on 2010-12-20 at 553cf37)
 + get_sha1: handle special case $commit^{/}
 + get_sha1: support $commit^{/regex} syntax
 + get_sha1_oneline: make callers prepare the commit list to traverse
 + get_sha1_oneline: fix lifespan rule of temp_commit_buffer variable

* tc/completion-reflog (2010-12-16) 1 commit
  (merged to 'next' on 2010-12-20 at 2fa91e0)
 + bash completion: add basic support for git-reflog

--------------------------------------------------
[New Topics]

* jk/commit-die-on-bogus-ident (2010-12-20) 2 commits
  (merged to 'next' on 2010-12-21 at 7785c31)
 + commit: die before asking to edit the log message
 + ident: die on bogus date format

* jc/maint-am-abort-safely (2010-12-21) 1 commit
  (merged to 'next' on 2010-12-21 at 81602bc)
 + am --abort: keep unrelated commits since the last failure and warn

--------------------------------------------------
[Stalled]

* mg/cvsimport (2010-11-28) 3 commits
 - cvsimport.txt: document the mapping between config and options
 - cvsimport: fix the parsing of uppercase config options
 - cvsimport: partial whitespace cleanup

I was being lazy and said "Ok" to "cvsimport.capital-r" but luckily other
people injected sanity to the discussion.  Weatherbaloon patch sent, but
not queued here.

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

* rj/maint-difftool-cygwin-workaround (2010-12-14) 1 commit
  (merged to 'next' on 2010-12-21 at 74b9069)
 + difftool: Fix failure on Cygwin

* rj/maint-test-fixes (2010-12-14) 5 commits
  (merged to 'next' on 2010-12-21 at 8883a0c)
 + t9501-*.sh: Fix a test failure on Cygwin
 + lib-git-svn.sh: Add check for mis-configured web server variables
 + lib-git-svn.sh: Avoid setting web server variables unnecessarily
 + t9142: Move call to start_httpd into the setup test
 + t3600-rm.sh: Don't pass a non-existent prereq to test #15

* rj/test-fixes (2010-12-14) 4 commits
 - t4135-*.sh: Skip the "backslash" tests on cygwin
 - t3032-*.sh: Do not strip CR from line-endings while grepping on MinGW
 - t3032-*.sh: Pass the -b (--binary) option to sed on cygwin
 - t6038-*.sh: Pass the -b (--binary) option to sed on cygwin

* tr/maint-branch-no-track-head (2010-12-14) 1 commit
 - branch: do not attempt to track HEAD implicitly

Probably needs a re-roll to exclude either (1) any ref outside the
hierarchies for branches (i.e. refs/{heads,remotes}/), or (2) only refs
outside refs/ hierarchies (e.g. HEAD, ORIG_HEAD, ...).  The latter feels
safer and saner.

* by/log-l (2010-12-14) 8 commits
 . log -L: implement move/copy detection (-M/-C)
 . log -L: add --full-line-diff option
 . log -L: add --graph prefix before output
 . log -L: support parent rewriting
 . Implement line-history search (git log -L)
 . Export rewrite_parents() for 'log -L'
 . Export three functions from diff.c
 . Refactor parse_loc

Seems to have some bad interactions with nd/struct-pathspec.

* hv/mingw-fs-funnies (2010-12-14) 5 commits
 - mingw_rmdir: set errno=ENOTEMPTY when appropriate
 - mingw: add fallback for rmdir in case directory is in use
 - mingw: make failures to unlink or move raise a question
 - mingw: work around irregular failures of unlink on windows
 - mingw: move unlink wrapper to mingw.c

Can somebody remind me what the status of this series is?

* tf/commit-list-prefix (2010-11-26) 1 commit
  (merged to 'next' on 2010-12-21 at 16e1351)
 + commit: Add commit_list prefix in two function names.

This churn already introduced an unnecessary conflict.  It is not by
itself a biggie, but these things tend to add up.

* pd/bash-4-completion (2010-12-15) 3 commits
  (merged to 'next' on 2010-12-21 at dbf80ff)
 + Merge branch 'master' (early part) into pd/bash-4-completion
 + bash: simple reimplementation of _get_comp_words_by_ref
 + bash: get --pretty=m<tab> completion to work with bash v4

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

* nd/maint-fix-add-typo-detection (2010-11-27) 5 commits
  (merged to 'next' on 2010-12-21 at 87c702b)
 + Revert "excluded_1(): support exclude files in index"
 + unpack-trees: fix sparse checkout's "unable to match directories"
 + unpack-trees: move all skip-worktree checks back to unpack_trees()
 + dir.c: add free_excludes()
 + cache.h: realign and use (1 << x) form for CE_* constants

* jh/gitweb-caching (2010-12-03) 4 commits
 . gitweb: Minimal testing of gitweb caching
 . gitweb: File based caching layer (from git.kernel.org)
 . gitweb: add output buffering and associated functions
 . gitweb: Prepare for splitting gitweb

Previous iteration; dropped.

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

Need to re-read this series to move it forward.

* yd/dir-rename (2010-10-29) 5 commits
 - Allow hiding renames of individual files involved in a directory rename.
 - Unified diff output format for bulk moves.
 - Add testcases for the --detect-bulk-moves diffcore flag.
 - Raw diff output format for bulk moves.
 - Introduce bulk-move detection in diffcore.

Need to re-queue the reroll.

* nd/struct-pathspec (2010-12-15) 21 commits
 - t7810: overlapping pathspecs and depth limit
 - grep: drop pathspec_matches() in favor of tree_entry_interesting()
 - grep: use writable strbuf from caller for grep_tree()
 - grep: use match_pathspec_depth() for cache/worktree grepping
 - grep: convert to use struct pathspec
 - Convert ce_path_match() to use match_pathspec_depth()
 - Convert ce_path_match() to use struct pathspec
 - struct rev_info: convert prune_data to struct pathspec
 - pathspec: add match_pathspec_depth()
 - tree_entry_interesting(): optimize wildcard matching when base is matched
 - tree_entry_interesting(): support wildcard matching
 - tree_entry_interesting(): fix depth limit with overlapping pathspecs
 - tree_entry_interesting(): support depth limit
 - tree_entry_interesting(): refactor into separate smaller functions
 - diff-tree: convert base+baselen to writable strbuf
 - glossary: define pathspec
 - Move tree_entry_interesting() to tree-walk.c and export it
 - tree_entry_interesting(): remove dependency on struct diff_options
 - Convert struct diff_options to use struct pathspec
 - diff-no-index: use diff_tree_setup_paths()
 - Add struct pathspec
 (this branch is used by en/object-list-with-pathspec.)

Rerolled again.  Getting nicer by the round ;-)

* en/object-list-with-pathspec (2010-09-20) 2 commits
 - Add testcases showing how pathspecs are handled with rev-list --objects
 - Make rev-list --objects work together with pathspecs
 (this branch uses nd/struct-pathspec.)

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
