From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2012, #10; Thu, 29)
Date: Thu, 29 Nov 2012 15:22:34 -0800
Message-ID: <7vr4ncnged.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 00:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeDRa-0001Sz-7m
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 00:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab2K2XWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 18:22:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41457 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752776Ab2K2XWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 18:22:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D249AAA7;
	Thu, 29 Nov 2012 18:22:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	7fCl/e7VN0ln7JYilRA6tUFKEo=; b=aATQqJRlBnMfSpaTu5Tpn1GWHAiMdQgs+
	yystkfmLUlqCI38yLIRr0qFXcas/c9ZveWYUmr63G7UnRPa+y3rMJ2iTPcW9oPyp
	MJKD+MZLgm/xL9JmvNZlSzeCqMR68OORS+YfpYx/pDsal6krMDVTZ44lbmhN4U6b
	Hfi9PTC8V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=kAH
	00hcm2hfdnlX8gKrT6gPD4QRX8thMScz4Pf+IXQ56+oOoZxmYHtETnP+ypf2RJXq
	158Ru3hZ8CbKvQznmKzSKiqE/SQn7iDzn6wzYqKkI2rmnPd7KG0AYsW4xfhd4yij
	IbrKZ1/trZYiE5ok65yKZySgc8A8bEE3hnP7Q2wU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A489AAA6;
	Thu, 29 Nov 2012 18:22:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5EC1AAA5; Thu, 29 Nov 2012
 18:22:35 -0500 (EST)
X-master-at: f94c3251e1400c3cf349f7f84fea4db66b540113
X-next-at: 19e1b0a2032ea70977d8d774ed994913f067038b
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A889D414-3A7B-11E2-AAA3-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210882>

What's cooking in git.git (Nov 2012, #10; Thu, 29)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Hopefully 1.8.1-rc0 preview will be tagged this weekend.  Many
topics are marked to be cooked in 'next' during the feature freeze,
but some topics in flight should be in 'master' before -rc1 happens.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* wk/submodule-update-remote (2012-11-28) 2 commits
 - submodule add: If --branch is given, record it in .gitmodules
 - submodule update: add --remote for submodule's upstream changes

 Still under active discussion.

--------------------------------------------------
[Graduated to "master"]

* er/doc-add-new-commands (2012-11-26) 1 commit
  (merged to 'next' on 2012-11-28 at 2daf755)
 + Documentation: how to add a new command


* fc/completion-test-simplification (2012-11-16) 6 commits
  (merged to 'next' on 2012-11-28 at b7b2f67)
 + completion: simplify __gitcomp() test helper
 + completion: refactor __gitcomp related tests
 + completion: consolidate test_completion*() tests
 + completion: simplify tests using test_completion_long()
 + completion: standardize final space marker in tests
 + completion: add comment for test_completion()

 Clean up completion tests.  Use of conslidated helper may make
 instrumenting one particular test during debugging of the test
 itself, but I think that issue should be addressed in some other
 way (e.g. making sure individual tests in 9902 can be skipped).


* fc/remote-hg (2012-11-27) 22 commits
  (merged to 'next' on 2012-11-28 at f805784)
 + remote-hg: fix for older versions of python
 + remote-hg: fix for files with spaces
  (merged to 'next' on 2012-11-18 at 4a4f2e4)
 + remote-hg: avoid bad refs
 + remote-hg: try the 'tip' if no checkout present
 + remote-hg: fix compatibility with older versions of hg
 + remote-hg: add missing config for basic tests
 + remote-hg: the author email can be null
 + remote-hg: add option to not track branches
 + remote-hg: add extra author test
 + remote-hg: add tests to compare with hg-git
 + remote-hg: add bidirectional tests
 + test-lib: avoid full path to store test results
 + remote-hg: add basic tests
 + remote-hg: fake bookmark when there's none
 + remote-hg: add compat for hg-git author fixes
 + remote-hg: add support for hg-git compat mode
 + remote-hg: match hg merge behavior
 + remote-hg: make sure the encoding is correct
 + remote-hg: add support to push URLs
 + remote-hg: add support for remote pushing
 + remote-hg: add support for pushing
 + Add new remote-hg transport helper

 New remote helper for hg.


* fc/send-email-no-sender-prompt (2012-11-26) 1 commit
  (merged to 'next' on 2012-11-28 at 690d525)
 + send-email: avoid questions when user has an ident
 (this branch is used by jk/send-email-sender-prompt.)

 In cases the sender ident is sufficiently specified, there is no
 need to prompt the user before sending the series out.


* fc/zsh-completion (2012-11-19) 2 commits
  (merged to 'next' on 2012-11-26 at 48ebdc9)
 + completion: start moving to the new zsh completion
 + completion: add new zsh completion

 Completion script revamped for zsh users.


* jc/doc-push-satellite (2012-11-27) 1 commit
  (merged to 'next' on 2012-11-28 at 7114637)
 + Documentation/git-push.txt: clarify the "push from satellite" workflow

 Clarify what the example that pushes branches into remote-tracking
 branches of another repository is trying to achieve (i.e. emulating
 a fetch in reverse).


* jk/pickaxe-textconv (2012-10-28) 2 commits
  (merged to 'next' on 2012-11-26 at 2c5b5c9)
 + pickaxe: use textconv for -S counting
 + pickaxe: hoist empty needle check

 Use textconv filters when searching with "log -S".


* jk/send-email-sender-prompt (2012-11-28) 7 commits
  (merged to 'next' on 2012-11-28 at a808921)
 + t9001: check send-email behavior with implicit sender
 + Merge branch 'fc/send-email-no-sender-prompt' into jk/send-email-sender-prompt
 + t: add tests for "git var"
 + ident: keep separate "explicit" flags for author and committer
 + ident: make user_ident_explicitly_given static
 + t7502: factor out autoident prerequisite
 + test-lib: allow negation of prerequisites
 (this branch uses fc/send-email-no-sender-prompt.)

 General clean-ups in various areas, originally written to support a
 patch that later turned out to be unneeded.


* jl/submodule-rm (2012-11-23) 1 commit
  (merged to 'next' on 2012-11-28 at 0e4115f)
 + Teach rm to remove submodules when given with a trailing '/'

 Finishing touches to "git rm $submodule" that removes the working
 tree of a submodule.


* km/send-email-remove-cruft-in-address (2012-11-26) 5 commits
  (merged to 'next' on 2012-11-28 at 2688772)
 + git-send-email: allow edit invalid email address
 + git-send-email: ask what to do with an invalid email address
 + git-send-email: remove invalid addresses earlier
 + git-send-email: fix fallback code in extract_valid_address()
 + git-send-email: remove garbage after email address

 Garbage after e-mail address on Cc: in the patch breaks the
 transmission of it over send-email.


* lt/diff-stat-show-0-lines (2012-11-27) 6 commits
  (merged to 'next' on 2012-11-28 at de89eed)
 + diff --shortstat: do not count "unmerged" entries
 + diff --stat: do not count "unmerged" entries
 + diff --stat: move the "total count" logic to the last loop
 + diff --stat: use "file" temporary variable to refer to data->files[i]
 + diff --stat: status of unmodified pair in diff-q is not zero
 + test: add failing tests for "diff --stat" to t4049

 "git diff --stat" miscounted the total number of changed lines when
 binary files were involved and hidden beyond --stat-count.  It also
 miscounted the total number of changed files when there were
 unmerged paths.


* mk/complete-tcsh (2012-11-27) 1 commit
  (merged to 'next' on 2012-11-28 at 5528439)
 + Support for git aliasing for tcsh completion

 Completion script revamped for tcsh users.


* mm/status-push-pull-advise (2012-11-16) 1 commit
  (merged to 'next' on 2012-11-26 at ed40d5e)
 + status: add advice on how to push/pull to tracking branch

 When "git checkout" checks out a branch, it tells the user how far
 behind (or ahead) the new branch is relative to the remote tracking
 branch it builds upon.  The message now also advises how to sync
 them up by pushing or pulling.


* pp/gitweb-config-underscore (2012-11-21) 1 commit
  (merged to 'next' on 2012-11-28 at fc9bf5f)
 + gitweb: make remote_heads config setting work

 The key "gitweb.remote_heads" is not legal git config; this maps it to
 "gitweb.remoteheads".


* pw/p4-various-fixes (2012-11-26) 6 commits
  (merged to 'next' on 2012-11-28 at 1a6f9a9)
 + git p4: remove unneeded cmd initialization
 + git p4: fix labelDetails typo in exception
 + git p4 test: display unresolvable host error
 + git p4: catch p4 errors when streaming file contents
 + git p4: handle servers without move support
 + git p4: catch p4 describe errors

--------------------------------------------------
[Stalled]

* pf/editor-ignore-sigint (2012-11-11) 5 commits
 - launch_editor: propagate SIGINT from editor to git
 - run-command: do not warn about child death by SIGINT
 - run-command: drop silent_exec_failure arg from wait_or_whine
 - launch_editor: ignore SIGINT while the editor has control
 - launch_editor: refactor to use start/finish_command

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Some people raised issues with emacsclient, which are addressed by this
 re-roll. It should probably also handle SIGQUIT, and there were a
 handful of other review comments.

 Expecting a re-roll.


* mo/cvs-server-updates (2012-10-16) 10 commits
 - cvsserver Documentation: new cvs ... -r support
 - cvsserver: add t9402 to test branch and tag refs
 - cvsserver: support -r and sticky tags for most operations
 - cvsserver: Add version awareness to argsfromdir
 - cvsserver: generalize getmeta() to recognize commit refs
 - cvsserver: implement req_Sticky and related utilities
 - cvsserver: add misc commit lookup, file meta data, and file listing functions
 - cvsserver: define a tag name character escape mechanism
 - cvsserver: cleanup extra slashes in filename arguments
 - cvsserver: factor out git-log parsing logic

 Needs review by folks interested in cvsserver.


* as/check-ignore (2012-11-08) 14 commits
 - t0007: fix tests on Windows
 - Documentation/check-ignore: we show the deciding match, not the first
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name

 Duy helped to reroll this.

 Expecting a re-roll.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
 - rebase: Handle cases where format-patch fails

 I am unhappy a bit about the possible performance implications of
 having to store the output in a temporary file only for a rare case
 of format-patch aborting.


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


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 Needs review and Ack (or Nack) from people involved in the remote
 helper interface for this to move forward.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


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


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* jc/doc-default-format (2012-11-26) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Need to address the installation half if this is to be any useful.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


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

 Expecting a re-roll.

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* bc/append-signed-off-by (2012-11-26) 11 commits
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

 Expecting a re-roll after a review.


* mh/unify-xml-in-imap-send-and-http-push (2012-11-29) 8 commits
 - wrap_in_html(): process message in bulk rather than line-by-line
 - wrap_in_html(): use strbuf_addstr_xml_quoted()
 - imap-send: change msg_data from storing (ptr, len) to storing strbuf
 - imap-send: correctly report errors reading from stdin
 - imap-send: store all_msgs as a strbuf
 - lf_to_crlf(): NUL-terminate msg_data::data
 - xml_entities(): use function strbuf_addstr_xml_quoted()
 - Add new function strbuf_add_xml_quoted()

 Will merge to 'next'.


* rr/t4041-cleanup (2012-11-27) 4 commits
 - t4041 (diff-submodule-option): modernize style
 - t4041 (diff-submodule-option): rewrite add_file() routine
 - t4041 (diff-submodule-option): parse digests sensibly
 - t4041 (diff-submodule-option): don't hardcode SHA-1 in expected outputs

 As a clean-up, it still misses some.
 Expecting a re-roll.


* jc/doc-maintainer (2012-11-27) 1 commit
 - update "howto maintain git"

 An early draft that is still incomplete.


* jk/fsck-dot-in-trees (2012-11-28) 2 commits
  (merged to 'next' on 2012-11-28 at 519dabc)
 + fsck: warn about ".git" in trees
 + fsck: warn about '.' and '..' in trees

 Will cook in 'next'.


* mh/doc-remote-helpers (2012-11-27) 6 commits
 - git-remote-helpers.txt: clarify options & ref list attributes
 - git-remote-helpers.txt: clarify command <-> capability correspondences
 - git-remote-helpers.txt: rearrange description of capabilities
 - git-remote-helpers.txt: minor grammar fix
 - git-remote-helpers.txt: document missing capabilities
 - git-remote-helpers.txt: document invocation before input format

 Need comment and Ack from people who have worked on remote-helpers
 before this goes forward.


* mh/pthreads-autoconf (2012-11-27) 1 commit
  (merged to 'next' on 2012-11-28 at 780600e)
 + configure.ac: fix pthreads detection on Mac OS X

 Will cook in 'next'.


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
  (merged to 'next' on 2012-11-28 at 43d51c2)
 + config: exit on error accessing any config file
 + doc: advertise GIT_CONFIG_NOSYSTEM
 + config: treat user and xdg config permission problems as errors
 + config, gitignore: failure to access with ENOTDIR is ok

 An RFC to deal with a situation where .config/git is a file and we
 notice .config/git/config is not readable due to ENOTDIR, not
 ENOENT.

 Will cook in 'next'.


* mh/ceiling (2012-10-29) 8 commits
  (merged to 'next' on 2012-11-26 at d1ce76a)
 + string_list_longest_prefix(): remove function
 + setup_git_directory_gently_1(): resolve symlinks in ceiling paths
 + longest_ancestor_length(): require prefix list entries to be normalized
 + longest_ancestor_length(): take a string_list argument for prefixes
 + longest_ancestor_length(): use string_list_split()
 + Introduce new function real_path_if_valid()
 + real_path_internal(): add comment explaining use of cwd
 + Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

 Resurrected from Stalled; the earlier performance fear was
 unwarranted.

 Will cook in 'next'.


* fc/fast-export-fixes (2012-11-29) 15 commits
 - fast-export: make sure updated refs get updated
 - fast-export: don't handle uninteresting refs
 - fast-export: fix comparison in tests
 - fast-export: trivial cleanup
 - remote-testgit: implement the "done" feature manually
 - remote-testgit: report success after an import
 - remote-testgit: exercise more features
 - remote-testgit: cleanup tests
 - remote-testgit: remove irrelevant test
 - remote-testgit: remove non-local functionality
 - Add new simplified git-remote-testgit
 - Rename git-remote-testgit to git-remote-testpy
 - remote-helpers: fix failure message
 - remote-testgit: fix direction of marks
 - fast-export: avoid importing blob marks

 Will merge to (and cook in) 'next'.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
  (merged to 'next' on 2012-11-26 at 3af69e7)
 + apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Will cook in 'next'.


* nd/pathspec-wildcard (2012-11-26) 4 commits
 - tree_entry_interesting: do basedir compare on wildcard patterns when possible
 - pathspec: apply "*.c" optimization from exclude
 - pathspec: do exact comparison on the leading non-wildcard part
 - pathspec: save the non-wildcard length part

 Will merge to 'next'.


* nd/wildmatch (2012-11-20) 14 commits
  (merged to 'next' on 2012-11-21 at 151288f)
 + test-wildmatch: avoid Windows path mangling
  (merged to 'next' on 2012-10-25 at 510e8df)
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

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

 I suspect that this needs to be plugged to pathspec matching code;
 otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
 commits that touch Documentation/git.txt, which would be confusing
 to the users.

 Will cook in 'next'.


* fc/remote-bzr (2012-11-28) 10 commits
 - (fixup) test-bzr.sh: fix multi-line string assignment
 - remote-bzr: detect local repositories
 - remote-bzr: add support for older versions of bzr
 - remote-bzr: add support to push special modes
 - remote-bzr: add support for fecthing special modes
 - remote-bzr: add simple tests
 - remote-bzr: update working tree
 - remote-bzr: add support for remote repositories
 - remote-bzr: add support for pushing
 - Add new remote-bzr transport helper

 New remote helper for bzr (v3).  With minor fixes, this may be ready
 for 'next'.


* cr/push-force-tag-update (2012-11-26) 7 commits
 - push: clarify rejection of update to non-commit-ish
 - push: require force for annotated tags
 - push: require force for refs under refs/tags/
 - push: flag updates that require force
 - push: keep track of "update" state separately
 - push: add advice for rejected tag reference
 - push: return reject reasons via a mask

 Require "-f" for push to update a tag, even if it is a fast-forward.

 With a minor tweak, I think this is getting ready for 'next'.
 Expecting a re-roll.

--------------------------------------------------
[Discarded]

* nd/unify-appending-of-s-o-b (2012-11-15) 1 commit
 . Unify appending signoff in format-patch, commit and sequencer

 I am not sure if the logic to refrain from adding a sign-off based
 on the existing run of sign-offs is done correctly in this change.

 Brandon's series attempts the same thing and seemed to be more
 cleanly done.


* nd/pretty-placeholder-with-color-option (2012-09-30) 9 commits
 . pretty: support %>> that steal trailing spaces
 . pretty: support truncating in %>, %< and %><
 . pretty: support padding placeholders, %< %> and %><
 . pretty: two phase conversion for non utf-8 commits
 . utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 . utf8.c: move display_mode_esc_sequence_len() for use by other functions
 . pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
 . pretty: split parsing %C into a separate function
 . pretty: share code between format_decoration and show_decorations

 This causes warnings with -Wuninitialized, so I've ejected it from pu
 for the time being.
