From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2013, #04; Wed, 9)
Date: Wed, 09 Jan 2013 13:04:48 -0800
Message-ID: <7vmwwi3w5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 22:05:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt2py-00089G-9y
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 22:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933814Ab3AIVE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 16:04:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933800Ab3AIVEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 16:04:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44BECB118;
	Wed,  9 Jan 2013 16:04:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	dXw3bHUm3LrIxSKeeFyG82m4kg=; b=CrjPvfCFwKMQ2sdzYRzk2HR8KdhRgvsAJ
	kQDaWIEq9NNdDWYwpVXtAPALRi9KnUH0rRyTcaL+d+OFwhKx7ywMHlxfs5rIN99n
	OU/27s5F2fOCwAnLOuLB3M28ua8MjdoZEiG1FgEbrOzOD3OiwCD8kFY0RaS/3cDs
	6F0CHb0UKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VPO
	PfcjHell0oCcVnsf9lJ7Z579O77nZ+WJgqb0EEK3VsXxGEUOKWUdhPges+tB0rwT
	gxVJnxrouTOqMeFUnCMdIxYnXd83ljTMoXGRBMbmyl+/3BnWA9QG6w7h+N7dZefs
	TTpE+oJaa82Fr1eoJ9pIllFAh5P0m3EEsOoK/054=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38211B117;
	Wed,  9 Jan 2013 16:04:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87004B115; Wed,  9 Jan 2013
 16:04:49 -0500 (EST)
X-master-at: 44fe83502edf5391bb3a5997cab01794b4568062
X-next-at: ffbe6f75280588398438a571a8a937328d87c3a3
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3470B634-5AA0-11E2-8607-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213104>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

So far, about 60 topics, most of which have been cooking since the
previous cycle, have been graduated to the 'master' branch in
preparation for the next release, which tentatively is called 1.8.2.
Many of these early topics are bugfixes and expected to later land
in the 'maint' branch for 1.8.1.1 release as well.

As usual, this cycle is expected to last for 8 to 10 weeks, with a
preview -rc0 sometime in the middle of next month.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* nz/send-email-headers-are-case-insensitive (2013-01-06) 1 commit
 - git-send-email: treat field names as case-insensitively

 When user spells "cc:" in lowercase in the fake "header" in the
 trailer part, send-email failed to pick up the addresses from
 there. As e-mail headers field names are case insensitive, this
 script should follow suit and treat "cc:" and "Cc:" the same way.

 Will merge to 'next'.


* mk/complete-tcsh (2013-01-07) 1 commit
 - Prevent space after directories in tcsh completion

 Update tcsh command line completion so that an unwanted space is
 not added to a single directory name.

 Will merge to 'next'.


* dg/subtree-fixes (2013-01-08) 7 commits
 - contrib/subtree: mkdir the manual directory if needed
 - contrib/subtree: honor $(DESTDIR)
 - contrib/subtree: fix synopsis and command help
 - contrib/subtree: better error handling for "add"
 - contrib/subtree: add --unannotate option
 - contrib/subtree: use %B for split Subject/Body
 - t7900: remove test number comments

 contrib/subtree updates.

 Will merge to 'next'.


* ap/log-mailmap (2013-01-08) 11 commits
 - log --use-mailmap: optimize for cases without --author/--committer search
 - log: add log.mailmap configuration option
 - log: grep author/committer using mailmap
 - test: add test for --use-mailmap option
 - log: add --use-mailmap option
 - pretty: use mailmap to display username and email
 - mailmap: add mailmap structure to rev_info and pp
 - mailmap: simplify map_user() interface
 - mailmap: remove email copy and length limitation
 - Use split_ident_line to parse author and committer
 - string-list: allow case-insensitive string list

 Teach commands in the "log" family to optionally pay attention to
 the mailmap.

 Will merge to 'next'.


* nd/upload-pack-shallow-must-be-commit (2013-01-08) 1 commit
 - upload-pack: only accept commits from "shallow" line

 A minor consistency check patch that does not have much relevance
 to the real world.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* ap/merge-stop-at-prepare-commit-msg-failure (2013-01-03) 1 commit
  (merged to 'next' on 2013-01-07 at 6790566)
 + merge: Honor prepare-commit-msg return code

 Originally merged to 'next' on 2013-01-04

 "git merge" started calling prepare-commit-msg hook like "git
 commit" does some time ago, but forgot to pay attention to the exit
 status of the hook.  t7505 may want a general clean-up but that is
 a different topic.


* as/test-name-alias-uniquely (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-07 at 3b11c25)
 + Use longer alias names in subdirectory tests

 Originally merged to 'next' on 2013-01-02

 A few short-and-bland aliases used in the tests were interfering
 with git-custom command in user's $PATH.


* cc/no-gitk-build-dependency (2012-12-18) 3 commits
 + Makefile: replace "echo 1>..." with "echo >..."
 + Makefile: detect when PYTHON_PATH changes
 + Makefile: remove tracking of TCLTK_PATH

 Remove leftover bits from an earlier change to move gitk in its own
 subdirectory.  Reimplementing the dependency tracking rules needs
 to be done in gitk history separately.


* er/python-version-requirements (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-07 at 4954e27)
 + Add checks to Python scripts for version dependencies.

 Originally merged to 'next' on 2013-01-02

 Some python scripts we ship cannot be run with old versions of the
 interpreter.


* er/stop-recommending-parsecvs (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-07 at 689f28f)
 + Remove the suggestion to use parsecvs, which is currently broken.

 Originally merged to 'next' on 2013-01-02

 Stop recommending a defunct third-party software.


* fc/remote-bzr (2013-01-02) 9 commits
  (merged to 'next' on 2013-01-07 at f8c0b76)
 + remote-bzr: detect local repositories
 + remote-bzr: add support for older versions of bzr
 + remote-bzr: add support to push special modes
 + remote-bzr: add support for fecthing special modes
 + remote-bzr: add simple tests
 + remote-bzr: update working tree upon pushing
 + remote-bzr: add support for remote repositories
 + remote-bzr: add support for pushing
 + Add new remote-bzr transport helper

 Originally merged to 'next' on 2013-01-04

 New remote helper for bzr, with minimum fix squashed in.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
 + apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.


* jc/submittingpatches (2013-01-02) 4 commits
  (merged to 'next' on 2013-01-07 at 1cc3b8e)
 + SubmittingPatches: give list and maintainer addresses
 + SubmittingPatches: remove overlong checklist
 + SubmittingPatches: mention subsystems with dedicated repositories
 + SubmittingPatches: who am I and who cares?

 Originally merged to 'next' on 2013-01-04

 Streamline the document and update with a few e-mail addresses the
 patches should be sent to.


* jk/enable-test-lint-by-default (2013-01-03) 1 commit
  (merged to 'next' on 2013-01-07 at 2a77155)
 + tests: turn on test-lint by default

 Originally merged to 'next' on 2013-01-04

 We had two simple and quick tests to catch common mistakes when
 writing test scripts, but they weren't run by default when running
 tests.


* jk/maint-fast-import-doc-dedup-done (2013-01-07) 1 commit
  (merged to 'next' on 2013-01-07 at af6a054)
 + git-fast-import(1): remove duplicate '--done' option

 The "logical order" reorganization can come after that is done and
 can cook longer in 'next'.


* jk/pathspec-literal (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-07 at f0725cc)
 + t6130-pathspec-noglob: Windows does not allow a file named "f*"

 Finishing touches to unbreak a test on Windows.


* jn/less-reconfigure (2013-01-02) 1 commit
  (merged to 'next' on 2013-01-07 at 04c11cb)
 + build: do not automatically reconfigure unless configure.ac changed

 Originally merged to 'next' on 2013-01-02

 When autoconf is used, any build on a different commit always ran
 "config.status --recheck" even when unnecessary.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
 + config: exit on error accessing any config file
 + doc: advertise GIT_CONFIG_NOSYSTEM
 + config: treat user and xdg config permission problems as errors
 + config, gitignore: failure to access with ENOTDIR is ok

 Deal with a situation where .config/git is a file and we notice
 .config/git/config is not readable due to ENOTDIR, not ENOENT.


* kb/maint-bundle-doc (2013-01-01) 2 commits
  (merged to 'next' on 2013-01-07 at 3d2b1ea)
 + Documentation: full-ness of a bundle is significant for cloning
 + Documentation: correct example restore from bundle

 Originally merged to 'next' on 2013-01-04

 Update an example in the "git bundle" documentation.


* mz/oneway-merge-wo-u-no-lstat (2012-12-20) 1 commit
 + oneway_merge(): only lstat() when told to update worktree

 Optimize "read-tree -m <tree-ish>" without "-u".


* nd/maint-branch-desc-doc (2013-01-03) 5 commits
  (merged to 'next' on 2013-01-07 at 5117679)
 + format-patch: pick up branch description when no ref is specified
 + format-patch: pick up correct branch name from symbolic ref
 + t4014: a few more tests on cover letter using branch description
 + branch: delete branch description if it's empty
 + config.txt: a few lines about branch.<name>.description

 Originally merged to 'next' on 2013-01-04

 Teach various forms of "format-patch" command line to identify what
 branch the patches are taken from, so that the branch description
 is picked up in more cases.


* os/gitweb-highlight-uncaptured (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-07 at 5db0558)
 + gitweb: fix error in sanitize when highlight is enabled

 Originally merged to 'next' on 2013-01-04

 The code to sanitize control characters before passing it to
 "highlight" filter lost known-to-be-safe control characters by
 mistake.


* ta/remove-stale-translated-tut (2012-12-27) 1 commit
  (merged to 'next' on 2013-01-07 at 47b1056)
 + Remove Documentation/pt_BR/gittutorial.txt

 Originally merged to 'next' on 2013-01-02

 Remove a translation of a document that was left stale.


* tb/test-t9020-no-which (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-07 at 9661948)
 + t9020: which is not portable

 Originally merged to 'next' on 2013-01-04

 Test portability update.


* tb/test-t9810-no-sed-i (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-07 at cd82266)
 + t9810: Do not use sed -i

 Originally merged to 'next' on 2013-01-04

 Test portability update.

--------------------------------------------------
[Stalled]

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

* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Will merge to 'next'.


* as/dir-c-cleanup (2012-12-28) 10 commits
  (merged to 'next' on 2013-01-08 at 5aee090)
 + dir.c: rename free_excludes() to clear_exclude_list()
 + dir.c: refactor is_path_excluded()
 + dir.c: refactor is_excluded()
 + dir.c: refactor is_excluded_from_list()
 + dir.c: rename excluded() to is_excluded()
 + dir.c: rename excluded_from_list() to is_excluded_from_list()
 + dir.c: rename path_excluded() to is_path_excluded()
 + dir.c: rename cryptic 'which' variable to more consistent name
 + Improve documentation and comments regarding directory traversal API
 + api-directory-listing.txt: update to match code
 (this branch is used by as/check-ignore.)

 Refactor and generally clean up the directory traversal API
 implementation.

 Will merge to 'master'.


* jk/config-uname (2013-01-03) 1 commit
  (merged to 'next' on 2013-01-08 at f986500)
 + Makefile: hoist uname autodetection to config.mak.uname

 Move the bits to set fallback default based on the platform from
 the main Makefile to a separate file, so that it can be included in
 Makefiles in subdirectories.

 Will merge to 'master'.


* jc/push-2.0-default-to-simple (2013-01-08) 11 commits
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


* jk/unify-exit-code-by-receiving-signal (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-08 at 5ebf940)
 + run-command: encode signal death as a positive integer

 The internal logic had to deal with two representations of a death
 of a child process by a signal.

 Will merge to 'master'.


* jl/interrupt-clone-remove-separate-git-dir (2013-01-05) 1 commit
  (merged to 'next' on 2013-01-08 at 568f874)
 + clone: support atomic operation with --separate-git-dir

 When "git clone --separate-git-dir" is interrupted, we failed to
 remove the real location we created the repository.

 Will merge to 'master'.


* rs/leave-base-name-in-name-field-of-tar (2013-01-05) 1 commit
  (merged to 'next' on 2013-01-08 at 98f325e)
 + archive-tar: split long paths more carefully

 Improve compatibility with implementations of "tar" that do not
 like empty name field in header (with the additional prefix field
 holding everything).

 Will merge to 'master'.


* as/api-allocation-doc (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-08 at c80b544)
 + api-allocation-growing.txt: encourage better variable naming

 Will merge to 'master'.


* jc/comment-cygwin-win32api-in-makefile (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-08 at dea04e8)
 + Makefile: add comment on CYGWIN_V15_WIN32API

 Will merge to 'master'.


* jn/xml-depends-on-asciidoc-conf (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-08 at 4faf8d4)
 + docs: manpage XML depends on asciidoc.conf

 Will merge to 'master'.


* nd/clone-no-separate-git-dir-with-bare (2013-01-06) 1 commit
 - clone: forbid --bare --separate-git-dir <dir>

 Expecting a reroll.
 $gmane/212863


* nd/parse-pathspec (2013-01-06) 21 commits
 - Convert more init_pathspec() to parse_pathspec()
 - Convert add_files_to_cache to take struct pathspec
 - Convert {read,fill}_directory to take struct pathspec
 - Convert refresh_index to take struct pathspec
 - Convert report_path_error to take struct pathspec
 - checkout: convert read_tree_some to take struct pathspec
 - Convert unmerge_cache to take struct pathspec
 - Convert read_cache_preload() to take struct pathspec
 - add: convert to use parse_pathspec
 - archive: convert to use parse_pathspec
 - ls-files: convert to use parse_pathspec
 - rm: convert to use parse_pathspec
 - checkout: convert to use parse_pathspec
 - rerere: convert to use parse_pathspec
 - status: convert to use parse_pathspec
 - commit: convert to use parse_pathspec
 - clean: convert to use parse_pathspec
 - Export parse_pathspec() and convert some get_pathspec() calls
 - pathspec: make sure the prefix part is wildcard-clean
 - Add parse_pathspec() that converts cmdline args to struct pathspec
 - pathspec: save the non-wildcard length part

 Uses the parsed pathspec structure in more places where we used to
 use the raw "array of strings" pathspec.

 Unfortunately, this conflicts a couple of topics in flight. I tried
 to be careful while resolving conflicts, though.

 Expecting a reroll after the dust settles.


* rs/zip-tests (2013-01-07) 4 commits
  (merged to 'next' on 2013-01-08 at 8e37423)
 + t5003: check if unzip supports symlinks
 + t5000, t5003: move ZIP tests into their own script
 + t0024, t5000: use test_lazy_prereq for UNZIP
 + t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead

 Updates zip tests to skip some that cannot be handled on platform
 unzip.

 I've renamed the t5002 in the original to t5003 to avoid name
 clashes with another topic in flight.

 Will merge to 'master'.


* rs/zip-with-uncompressed-size-in-the-header (2013-01-06) 1 commit
  (merged to 'next' on 2013-01-08 at d9ec30e)
 + archive-zip: write uncompressed size into header even with streaming

 Improve compatibility of our zip output to fill uncompressed size
 in the header, which we can do without seeking back (even though it
 should not be necessary).

 Will merge to 'master'.


* tb/test-shell-lint (2013-01-02) 1 commit
  (merged to 'next' on 2013-01-07 at 0bca54a)
 + test: Add check-non-portable-shell.pl

 Originally merged to 'next' on 2013-01-04

 Check for common mistakes in the test scripts, based on simple
 pattern-matching.

 Will merge to 'master'.


* jc/doc-maintainer (2013-01-03) 2 commits
 - howto/maintain: mark titles for asciidoc
 - Documentation: update "howto maintain git"

 Describe tools for automation that were invented since this
 document was originally written.

 Will merge to 'next'.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 In the longer term, tightening rules is a good thing to do, and
 because nobody who has worked in the remote helper area seems to be
 interested in reviewing this, I would assume they do not think
 such a retroactive tightening will affect their remote helpers.  So
 let's advance this topic to see what happens.

 Will merge to 'next'.


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


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
  (merged to 'next' on 2013-01-07 at 9e2ee43)
 + rebase: Handle cases where format-patch fails

 Originally merged to 'next' on 2013-01-02

 Save output from format-patch command in a temporary file, just in
 case it aborts, to give a better failure-case behaviour.

 Will merge to 'master'.


* ap/status-ignored-in-ignored-directory (2013-01-07) 3 commits
 - status: always report ignored tracked directories
  (merged to 'next' on 2013-01-07 at 2a20b19)
 + git-status: Test --ignored behavior
 + dir.c: Make git-status --ignored more consistent

 Originally merged to 'next' on 2013-01-04

 Output from "git status --ignored" showed an unexpected interaction
 with "--untracked".

 Will merge to 'next'.


* jc/maint-fmt-merge-msg-no-edit-lose-credit (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-07 at 497bf10)
 + merge --no-edit: do not credit people involved in the side branch

 Originally merged to 'next' on 2013-01-02

 Stop spending cycles to compute information to be placed on
 commented lines in "merge --no-edit".

 Will merge to 'master'.


* as/check-ignore (2013-01-06) 11 commits
 - add git-check-ignore sub-command
 - setup.c: document get_pathspec()
 - add.c: extract new die_if_path_beyond_symlink() for reuse
 - add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
 - pathspec.c: rename newly public functions for clarity
 - add.c: move pathspec matchers into new pathspec.c for reuse
 - add.c: remove unused argument from validate_pathspec()
 - dir.c: improve docs for match_pathspec() and match_pathspec_depth()
 - dir.c: provide clear_directory() for reclaiming dir_struct memory
 - dir.c: keep track of where patterns came from
 - dir.c: use a single struct exclude_list per source of excludes
 (this branch uses as/dir-c-cleanup.)

 The test it adds seems to break under dash.
 Expecting a reroll or fixup.


* jc/format-patch-reroll (2013-01-03) 9 commits
  (merged to 'next' on 2013-01-07 at 0e007e6)
 + format-patch: give --reroll-count a short synonym -v
 + format-patch: document and test --reroll-count
 + format-patch: add --reroll-count=$N option
 + get_patch_filename(): split into two functions
 + get_patch_filename(): drop "just-numbers" hack
 + get_patch_filename(): simplify function signature
 + builtin/log.c: stop using global patch_suffix
 + builtin/log.c: drop redundant "numbered_files" parameter from make_cover_letter()
 + builtin/log.c: drop unused "numbered" parameter from make_cover_letter()

 Originally merged to 'next' on 2013-01-04

 Teach "format-patch" to prefix v4- to its output files for the
 fourth iteration of a patch series, to make it easier for the
 submitter to keep separate copies for iterations.

 Will merge to 'master'.


* mz/pick-unborn (2012-12-23) 2 commits
  (merged to 'next' on 2013-01-07 at c6c062b)
 + learn to pick/revert into unborn branch
 + tests: move test_cmp_rev to test-lib-functions

 Originally merged to 'next' on 2013-01-02

 Allows "git cherry-pick $commit" when you do not have any history
 behind HEAD yet.

 Will merge to 'master'.


* nd/retire-fnmatch (2013-01-01) 7 commits
  (merged to 'next' on 2013-01-07 at ab31f9b)
 + Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
 + wildmatch: advance faster in <asterisk> + <literal> patterns
 + wildmatch: make a special case for "*/" with FNM_PATHNAME
 + test-wildmatch: add "perf" command to compare wildmatch and fnmatch
 + wildmatch: support "no FNM_PATHNAME" mode
 + wildmatch: make dowild() take arbitrary flags
 + wildmatch: rename constants and update prototype
 (this branch uses nd/wildmatch.)

 Originally merged to 'next' on 2013-01-04

 Replace our use of fnmatch(3) with a more feature-rich wildmatch.
 A handful patches at the bottom have been moved to nd/wildmatch to
 graduate as part of that branch, before this series solidifies.

 Will cook in 'next' a bit longer than other topics.


* jc/merge-blobs (2012-12-26) 5 commits
  (merged to 'next' on 2013-01-08 at 582ca38)
 + merge-tree: fix d/f conflicts
 + merge-tree: add comments to clarify what these functions are doing
 + merge-tree: lose unused "resolve_directories"
 + merge-tree: lose unused "flags" from merge_list
 + Which merge_file() function do you mean?

 Update the disused merge-tree proof-of-concept code.

 Will merge to 'master'.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* zk/clean-report-failure (2013-01-06) 1 commit
 - git-clean: Display more accurate delete messages

 "git clean" states what it is going to remove and then goes on to
 remove it, but sometimes it only discovers things that cannot be
 removed after recursing into a directory, which makes the output
 confusing and even wrong.

 Expecting a response to $gmane/212860.


* mp/complete-paths (2012-12-21) 1 commit
 - git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

 It has been reported (no surprise) that this does not work inside
 subdirectory, and fixing it seems to be non-trivial. $gmane/212642

 Waiting for area-experts' help.


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


* nd/wildmatch (2013-01-01) 18 commits
  (merged to 'next' on 2013-01-07 at 2a39f7d)
 + wildmatch: replace variable 'special' with better named ones
 + compat/fnmatch: respect NO_FNMATCH* even on glibc
 + wildmatch: fix "**" special case
 + t3070: Disable some failing fnmatch tests
 + test-wildmatch: avoid Windows path mangling
 + Support "**" wildcard in .gitignore and .gitattributes
 + wildmatch: make /**/ match zero or more directories
 + wildmatch: adjust "**" behavior
 + wildmatch: fix case-insensitive matching
 + wildmatch: remove static variable force_lower_case
 + wildmatch: make wildmatch's return value compatible with fnmatch
 + t3070: disable unreliable fnmatch tests
 + Integrate wildmatch to git
 + wildmatch: follow Git's coding convention
 + wildmatch: remove unnecessary functions
 + Import wildmatch from rsync
 + ctype: support iscntrl, ispunct, isxdigit and isprint
 + ctype: make sane_ctype[] const array
 (this branch is used by nd/retire-fnmatch.)

 Originally merged to 'next' on 2013-01-01

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 Will merge to 'master'.
