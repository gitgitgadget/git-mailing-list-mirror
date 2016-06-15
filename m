From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2013, #07; Thu, 17)
Date: Thu, 17 Jan 2013 16:14:29 -0800
Message-ID: <7vsj5zs5y2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 01:14:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvzbj-0003xA-3J
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 01:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3ARAOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 19:14:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab3ARAOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 19:14:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE3B4B54F;
	Thu, 17 Jan 2013 19:14:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	m4DgzEQ51CNAnKSi7ObIt4rxqg=; b=ygl209khSUE48wxOF8O9Vr60q7VZGEKRX
	vJZBOHiiVn1wbUMhvoMr2rC3lECdCmlE/1LqUwn0so+DDDelFUwH0Y/zR8uoWDZW
	wPjtej+r/xVJaNSLkoguXqB+DiJ9Qyk1pdTmQpMcgSb/Y/jtiTLRMu3w8Tz1EsR8
	g77MMUDOwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=miK
	2TTNm9pUAHfTTJGNdMlyDSciGt5QYV5DQjMM/sqTET6yhbpUBSBDkodmZyxzc+74
	prpyjd1Y+jUy8emrLEQZ4Wc5YqmTMVRIG8STh2ZvumFPFo80oB3nRK2OGAyKTpzI
	X70W3GenLx0PgWDoPn651yJuAgk0kalLwjunsQT4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE95BB54D;
	Thu, 17 Jan 2013 19:14:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C0DBB549; Thu, 17 Jan 2013
 19:14:30 -0500 (EST)
X-master-at: eacf0117752780bf418d352a6ad2f033aeda1cce
X-next-at: 99bfae2c22d58cfa0db9262c774d3f61a8d0dc1a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0752E040-6104-11E2-B0E8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213894>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

As usual, this cycle is expected to last for 8 to 10 weeks, with a
preview -rc0 sometime in the middle of next month.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* fc/remote-hg-fixup-url (2013-01-15) 1 commit
  (merged to 'next' on 2013-01-15 at d2acb2d)
 + remote-hg: store converted URL

 Update to the Hg remote helper (in contrib/).

 Will merge to 'master'.


* mh/remote-hg-mode-bits-fix (2013-01-15) 1 commit
  (merged to 'next' on 2013-01-15 at ad57d9f)
 + remote-hg: fix handling of file perms when pushing

 Update to the Hg remote helper (in contrib/).

 Will merge to 'master'.


* jc/valgrind-memcmp-bsearch (2013-01-14) 1 commit
 - ignore memcmp() overreading in bsearch() callback

 Squelch false positive in valgrind tests

 Will discard.


* mh/imap-send-shrinkage (2013-01-15) 14 commits
 - imap-send.c: simplify logic in lf_to_crlf()
 - imap-send.c: fold struct store into struct imap_store
 - imap-send.c: remove unused field imap_store::uidvalidity
 - imap-send.c: use struct imap_store instead of struct store
 - imap-send.c: remove unused field imap_store::trashnc
 - imap-send.c: remove namespace fields from struct imap
 - imap-send.c: remove struct imap argument to parse_imap_list_l()
 - imap-send.c: inline parse_imap_list() in parse_list()
 - imap-send.c: remove some unused fields from struct store
 - imap-send.c: remove struct message
 - imap-send.c: remove struct store_conf
 - iamp-send.c: remove unused struct imap_store_conf
 - imap-send.c: remove struct msg_data
 - imap-send.c: remove msg_data::flags, which was always zero

 Remove a lot of unused code from "git imap-send".

 With a further comment fixup in patch #6, this seems ready for
 'next'.
 Expecting a reroll.


* nd/attr-debug-fix (2013-01-15) 1 commit
  (merged to 'next' on 2013-01-15 at 8460acf)
 + attr: make it build with DEBUG_ATTR again

 Fix debugging support that was broken in earlier change.

 Will merge to 'master'.


* nd/fix-directory-attrs-off-by-one (2013-01-16) 2 commits
  (merged to 'next' on 2013-01-16 at bd63e61)
 + attr: avoid calling find_basename() twice per path
  (merged to 'next' on 2013-01-15 at e0a0129)
 + attr: fix off-by-one directory component length calculation

 Fix performance regression introduced by an earlier change to let
 attributes apply to directories.

 Will merge to 'master'.


* nd/fix-perf-parameters-in-tests (2013-01-15) 1 commit
  (merged to 'next' on 2013-01-15 at fedbdb9)
 + test-lib.sh: unfilter GIT_PERF_*

 Allow GIT_PERF_* environment variables to be passed through the
 test framework.

 Will merge to 'master'.


* pw/p4-branch-fixes (2013-01-15) 14 commits
  (merged to 'next' on 2013-01-15 at 1ee379e)
 + git p4: fix submit when no master branch
 + git p4 test: keep P4CLIENT changes inside subshells
 + git p4: fix sync --branch when no master branch
 + git p4: fail gracefully on sync with no master branch
 + git p4: rearrange self.initialParent use
 + git p4: allow short ref names to --branch
 + git p4 doc: fix branch detection example
 + git p4: clone --branch should checkout master
 + git p4: verify expected refs in clone --bare test
 + git p4: create p4/HEAD on initial clone
 + git p4: inline listExistingP4GitBranches
 + git p4: add comments to p4BranchesInGit
 + git p4: rearrange and simplify hasOrigin handling
 + git p4: test sync/clone --branch behavior

 Fix "git p4" around branch handling.

 Will merge to 'master'.


* ss/help-htmlpath-config-doc (2013-01-15) 1 commit
  (merged to 'next' on 2013-01-17 at 99bfae2)
 + config.txt: Document help.htmlpath config parameter

 Add missing doc.

 Will merge to 'master'.


* cr/push-force-tag-update (2013-01-16) 1 commit
 - push: fix "refs/tags/ hierarchy cannot be updated without --force"

 Regression fix.

 Will merge to 'next' and then to 'master' soonish.


* jk/suppress-clang-warning (2013-01-16) 1 commit
 - fix clang -Wunused-value warnings for error functions

 Will merge to 'next'.


* rs/clarify-entry-cmp-sslice (2013-01-16) 1 commit
 - refs: use strncmp() instead of strlen() and memcmp()

 Will merge to 'next'.


* ch/add-auto-submitted-in-sample-post-receive-email (2013-01-17) 1 commit
 - Add Auto-Submitted header to post-receive-email

 Will merge to 'next'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
 - simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 As this touches a fairly core part of the revision traversal
 infrastructure, it is appreciated to have an extra set of eyes for
 sanity check.

 Waiting for comments.


* jk/remote-helpers-in-python-3 (2013-01-17) 8 commits
 - git-remote-testpy: call print as a function
 - git-remote-testpy: don't do unbuffered text I/O
 - git-remote-testpy: hash bytes explicitly
 - svn-fe: allow svnrdump_sim.py to run with Python 3
 - git_remote_helpers: use 2to3 if building with Python 3
 - git_remote_helpers: force rebuild if python version changes
 - git_remote_helpers: fix input when running under Python 3
 - git_remote_helpers: allow building with Python 3

 Except for one instance of <user-generated-string>.encode('utf-8'),
 nothing looked wrong.  People who have worked on git_remote_helpers
 should review and Ack, though.  Perhaps Sverre?

 Waiting for further comments.

--------------------------------------------------
[Stalled]

* mp/complete-paths (2013-01-11) 1 commit
 - git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

 Waiting for area-experts' help and review.


* jl/submodule-deinit (2012-12-04) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Expecting a reroll.
 $gmane/212884


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

 "git name-rev" names the given revision based on a ref that can be
 reached in the smallest number of steps from the rev, but that is
 not useful when the caller wants to know which tag is the oldest one
 that contains the rev.  This teaches a new mode to the command that
 uses the oldest ref among those which contain the rev.

 I am not sure if this is worth it; for one thing, even with the help
 from notes-cache, it seems to make the "describe --contains" even
 slower. Also the command will be unusably slow for a user who does
 not have a write access (hence unable to create or update the
 notes-cache).

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Stalled mostly due to lack of responses.


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* jc/cvsimport-upgrade (2013-01-14) 8 commits
 - t9600: adjust for new cvsimport
 - t9600: further prepare for sharing
 - cvsimport-3: add a sample test
 - cvsimport: make tests reusable for cvsimport-3
 - cvsimport: start adding cvsps 3.x support
 - cvsimport: introduce a version-switch wrapper
 - cvsimport: allow setting a custom cvsps (2.x) program name
 - Makefile: add description on PERL/PYTHON_PATH

 The most important part of this series is the addition of the new
 cvsimport by Eric Raymond that works with cvsps 3.x.  Given some
 distros have inertia to be conservative, Git with cvsimport that
 does not work with both 3.x will block adoption of cvsps 3.x by
 them, and shipping Git with cvsimport that does not work with cvsps
 2.x will block such a version of Git, so we'll do the proven "both
 old and new are available, but we aim to deprecate and remove the
 old one in due time" strategy that we used successfully in the
 past.

 Both folks on the Git side and Chris Rorvick (contributor to cvsps
 3.0 and new cvsimport) seem happy with the new layout, so let's
 wait for a few days to see how it evolves and merge it to 'next'.

 Waiting for Eric to say something, but otherwise will merge to 'next'.


* as/pre-push-hook (2013-01-14) 4 commits
 - Add sample pre-push hook script
 - [SQUASH???] t5571 sample hooks should consume their input
 - push: Add support for pre-push hooks
 - hooks: Add function to check if a hook exists

 Add an extra hook so that "git push" that is run without making
 sure what is being pushed is sane can be checked and rejected (as
 opposed to the user deciding not pushing).

 Will merge to 'next' after squashing the fix in.


* dl/am-hg-locale (2013-01-14) 1 commit
 - am: invoke perl's strftime in C locale

 Datestamp recorded in "Hg" format patch was reformatted incorrectly
 to an e-mail looking date using locale dependant strftime, causing
 patch application to fail.

 This is an original "everything in C locale" version; the later one
 that uses LC_TIME may technically be more correct, so I may replace
 this with it later ($gmane/213660).


* jk/config-parsing-cleanup (2013-01-14) 7 commits
 - [DONTMERGE] reroll coming
 - submodule: simplify memory handling in config parsing
 - submodule: use match_config_key when parsing config
 - userdiff: drop parse_driver function
 - convert some config callbacks to match_config_key
 - archive-tar: use match_config_key when parsing config
 - config: add helper function for parsing key names

 Expecting a reroll.


* mp/diff-algo-config (2013-01-16) 3 commits
 - diff: Introduce --diff-algorithm command line option
 - config: Introduce diff.algorithm variable
 - git-completion.bash: Autocomplete --minimal and --histogram for git-diff

 Add diff.algorithm configuration so that the user does not type
 "diff --histogram".

 Looking better; may want tests to protect it from future breakages,
 but otherwise it looks ready for 'next'.


* ph/rebase-preserve-all-merges (2013-01-14) 1 commit
  (merged to 'next' on 2013-01-15 at 3a67878)
 + rebase --preserve-merges: keep all merge commits including empty ones

 An earlier change to add --keep-empty option broke "git rebase
 --preserve-merges" and lost merge commits that end up being the
 same as its parent.

 Will merge to 'master'.


* rs/archive-tar-config-parsing-fix (2013-01-14) 1 commit
 - archive-tar: fix sanity check in config parsing

 Configuration parsing for tar.* configuration variables were
 broken; Peff's config parsing clean-up topic will address the same
 breakage, so this may be superseded by that other topic.


* rs/pretty-use-prefixcmp (2013-01-14) 1 commit
  (merged to 'next' on 2013-01-15 at d76452d)
 + pretty: use prefixcmp instead of memcmp on NUL-terminated strings

 Will merge to 'master'.


* rt/commit-cleanup-config (2013-01-10) 1 commit
  (merged to 'next' on 2013-01-15 at c4742ae)
 + commit: make default of "cleanup" option configurable

 Add a configuration variable to set default clean-up mode other
 than "strip".

 Will merge to 'master'.


* jc/custom-comment-char (2013-01-16) 1 commit
 - Allow custom "comment char"

 An illustration to show codepaths that need to be touched to change
 the hint lines in the edited text to begin with something other
 than '#'.

 This is half my work and half by Ralf Thielow.  There may still be
 leftover '#' lurking around, though.  My "git grep" says C code
 should be already fine, but git-rebase--interactive.sh could be
 converted (it should not matter, as the file is not really a
 free-form text).

 I don't know how useful this will be in real life, though.

 Waiting for bug reports and user feedback.


* jn/maint-trim-vim-contrib (2013-01-10) 1 commit
  (merged to 'next' on 2013-01-15 at ad80a9d)
 + contrib/vim: simplify instructions for old vim support

 Will merge to 'master'.


* mz/reset-misc (2013-01-16) 20 commits
  (merged to 'next' on 2013-01-16 at 937bc20)
 + reset: update documentation to require only tree-ish with paths
  (merged to 'next' on 2013-01-15 at a93b394)
 + reset [--mixed]: use diff-based reset whether or not pathspec was given
 + reset: allow reset on unborn branch
 + reset $sha1 $pathspec: require $sha1 only to be treeish
 + reset.c: inline update_index_refresh()
 + reset.c: finish entire cmd_reset() whether or not pathspec is given
 + reset [--mixed]: only write index file once
 + reset.c: move lock, write and commit out of update_index_refresh()
 + reset.c: move update_index_refresh() call out of read_from_tree()
 + reset.c: replace switch by if-else
 + reset: avoid redundant error message
 + reset --keep: only write index file once
 + reset.c: share call to die_if_unmerged_cache()
 + reset.c: extract function for updating {ORIG_,}HEAD
 + reset.c: remove unnecessary variable 'i'
 + reset.c: extract function for parsing arguments
 + reset: don't allow "git reset -- $pathspec" in bare repo
 + reset.c: pass pathspec around instead of (prefix, argv) pair
 + reset $pathspec: exit with code 0 if successful
 + reset $pathspec: no need to discard index

 Various 'reset' optimizations and clean-ups, followed by a change
 to allow "git reset" to work even on an unborn branch.

 Will merge to 'master'.


* pe/doc-email-env-is-trumped-by-config (2013-01-10) 1 commit
  (merged to 'next' on 2013-01-14 at 6b4d555)
 + git-commit-tree(1): correct description of defaults

 In the precedence order, the environment variable $EMAIL comes
 between the built-in default (i.e. taking value by asking the
 system's gethostname() etc.) and the user.email configuration
 variable; the documentation implied that it is stronger than the
 configuration like $GIT_COMMITTER_EMAIL is, which is wrong.

 Will merge to 'master'.


* ds/completion-silence-in-tree-path-probe (2013-01-11) 1 commit
  (merged to 'next' on 2013-01-15 at 7542d21)
 + git-completion.bash: silence "not a valid object" errors

 An internal ls-tree call made by completion code only to probe if
 a path exists in the tree recorded in a commit object leaked error
 messages when the path is not there.  It is not an error at all and
 should not be shown to the end user.

 Will merge to 'master'.


* nd/fetch-depth-is-broken (2013-01-11) 3 commits
  (merged to 'next' on 2013-01-15 at 70a5ca7)
 + fetch: elaborate --depth action
 + upload-pack: fix off-by-one depth calculation in shallow clone
 + fetch: add --unshallow for turning shallow repo into complete one

 "git fetch --depth" was broken in at least three ways.  The
 resulting history was deeper than specified by one commit, it was
 unclear how to wipe the shallowness of the repository with the
 command, and documentation was misleading.

 Will cook in 'next'.


* jc/no-git-config-in-clone (2013-01-11) 1 commit
  (merged to 'next' on 2013-01-15 at feeffe1)
 + clone: do not export and unexport GIT_CONFIG

 We stopped paying attention to $GIT_CONFIG environment that points
 at a single configuration file from any command other than "git config"
 quite a while ago, but "git clone" internally set, exported, and
 then unexported the variable during its operation unnecessarily.

 Will cook in 'next'.


* mk/complete-tcsh (2013-01-07) 1 commit
  (merged to 'next' on 2013-01-11 at b8b30b1)
 + Prevent space after directories in tcsh completion

 Update tcsh command line completion so that an unwanted space is
 not added to a single directory name.

 Will merge to 'master'.


* dg/subtree-fixes (2013-01-08) 7 commits
 - contrib/subtree: mkdir the manual directory if needed
 - contrib/subtree: honor $(DESTDIR)
 - contrib/subtree: fix synopsis and command help
 - contrib/subtree: better error handling for "add"
 - contrib/subtree: add --unannotate option
 - contrib/subtree: use %B for split Subject/Body
 - t7900: remove test number comments

 contrib/subtree updates; there are a few more from T. Zheng that
 were posted separately, with an overlap.

 Expecting a reroll.


* ap/log-mailmap (2013-01-10) 11 commits
  (merged to 'next' on 2013-01-10 at 8544084)
 + log --use-mailmap: optimize for cases without --author/--committer search
 + log: add log.mailmap configuration option
 + log: grep author/committer using mailmap
 + test: add test for --use-mailmap option
 + log: add --use-mailmap option
 + pretty: use mailmap to display username and email
 + mailmap: add mailmap structure to rev_info and pp
 + mailmap: simplify map_user() interface
 + mailmap: remove email copy and length limitation
 + Use split_ident_line to parse author and committer
 + string-list: allow case-insensitive string list

 Teach commands in the "log" family to optionally pay attention to
 the mailmap.

 Will merge to 'master'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0 ;-).


* nd/clone-no-separate-git-dir-with-bare (2013-01-10) 1 commit
  (merged to 'next' on 2013-01-15 at 64f441a)
 + clone: forbid --bare --separate-git-dir <dir>

 Forbid a useless combination of options to "git clone".

 Will merge to 'master'.


* nd/parse-pathspec (2013-01-11) 20 commits
 . Convert more init_pathspec() to parse_pathspec()
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . add: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Export parse_pathspec() and convert some get_pathspec() calls
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: save the non-wildcard length part

 Uses the parsed pathspec structure in more places where we used to
 use the raw "array of strings" pathspec.

 Ejected from 'pu' for now; will take a look at the rerolled one
 later ($gmane/213340).


* jc/doc-maintainer (2013-01-03) 2 commits
  (merged to 'next' on 2013-01-11 at f35d582)
 + howto/maintain: mark titles for asciidoc
 + Documentation: update "howto maintain git"

 Describe tools for automation that were invented since this
 document was originally written.


* mo/cvs-server-updates (2012-12-09) 18 commits
  (merged to 'next' on 2013-01-08 at 75e2d11)
 + t9402: Use TABs for indentation
 + t9402: Rename check.cvsCount and check.list
 + t9402: Simplify git ls-tree
 + t9402: Add missing &&; Code style
 + t9402: No space after IO-redirection
 + t9402: Dont use test_must_fail cvs
 + t9402: improve check_end_tree() and check_end_full_tree()
 + t9402: sed -i is not portable
 + cvsserver Documentation: new cvs ... -r support
 + cvsserver: add t9402 to test branch and tag refs
 + cvsserver: support -r and sticky tags for most operations
 + cvsserver: Add version awareness to argsfromdir
 + cvsserver: generalize getmeta() to recognize commit refs
 + cvsserver: implement req_Sticky and related utilities
 + cvsserver: add misc commit lookup, file meta data, and file listing functions
 + cvsserver: define a tag name character escape mechanism
 + cvsserver: cleanup extra slashes in filename arguments
 + cvsserver: factor out git-log parsing logic

 Various git-cvsserver updates.

 Will cook in 'next' for a while to see if anybody screams.


* as/check-ignore (2013-01-16) 13 commits
 - clean.c, ls-files.c: respect encapsulation of exclude_list_groups
  (merged to 'next' on 2013-01-14 at 9df2afc)
 + t0008: avoid brace expansion
 + add git-check-ignore sub-command
 + setup.c: document get_pathspec()
 + add.c: extract new die_if_path_beyond_symlink() for reuse
 + add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
 + pathspec.c: rename newly public functions for clarity
 + add.c: move pathspec matchers into new pathspec.c for reuse
 + add.c: remove unused argument from validate_pathspec()
 + dir.c: improve docs for match_pathspec() and match_pathspec_depth()
 + dir.c: provide clear_directory() for reclaiming dir_struct memory
 + dir.c: keep track of where patterns came from
 + dir.c: use a single struct exclude_list per source of excludes

 Add a new command "git check-ignore" for debugging .gitignore
 files.

 The variable names may want to get cleaned up but that can be done
 in-tree.

 Will merge to 'next'.


* nd/retire-fnmatch (2013-01-01) 7 commits
  (merged to 'next' on 2013-01-07 at ab31f9b)
 + Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
 + wildmatch: advance faster in <asterisk> + <literal> patterns
 + wildmatch: make a special case for "*/" with FNM_PATHNAME
 + test-wildmatch: add "perf" command to compare wildmatch and fnmatch
 + wildmatch: support "no FNM_PATHNAME" mode
 + wildmatch: make dowild() take arbitrary flags
 + wildmatch: rename constants and update prototype

 Originally merged to 'next' on 2013-01-04

 Replace our use of fnmatch(3) with a more feature-rich wildmatch.
 A handful patches at the bottom have been moved to nd/wildmatch to
 graduate as part of that branch, before this series solidifies.

 Will cook in 'next' a bit longer than other topics.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* zk/clean-report-failure (2013-01-14) 1 commit
  (merged to 'next' on 2013-01-15 at 5b31614)
 + git-clean: Display more accurate delete messages

 "git clean" states what it is going to remove and then goes on to
 remove it, but sometimes it only discovers things that cannot be
 removed after recursing into a directory, which makes the output
 confusing and even wrong.

 Will merge to 'master'.


* bc/append-signed-off-by (2013-01-01) 12 commits
 - t4014: do not use echo -n
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - format-patch: stricter S-o-b detection
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - sequencer.c: remove broken support for rfc2822 continuation in footer

 Expecting a reroll.
 $gmane/212507

--------------------------------------------------
[Discarded]

* er/replace-cvsimport (2013-01-12) 7 commits
 . t/lib-cvs: cvsimport no longer works without Python >= 2.7
 . t9605: test for cvsps commit ordering bug
 . t9604: fixup for new cvsimport
 . t9600: fixup for new cvsimport
 . t/lib-cvs.sh: allow cvsps version 3.x.
 . t/t960[123]: remove leftover scripts
 . cvsimport: rewrite to use cvsps 3.x to fix major bugs

 Rerolled as jc/cvsimport-upgrade.
