From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2012, #01; Thu, 6)
Date: Thu, 06 Dec 2012 14:01:17 -0800
Message-ID: <7vtxryj0wi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 23:01:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgjVl-0004Mu-AP
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 23:01:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab2LFWBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 17:01:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752509Ab2LFWBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 17:01:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA42A12A;
	Thu,  6 Dec 2012 17:01:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	i3t8jvHYct063OwZglNupuYeWc=; b=FU5xVL0ZhvWFU26dC/pSm+6JppzGRpV/J
	+kyRdqMrVGuZL+b9oML1BdgNDmrIhOO1HJl2BULZBSiJoFCyr6JqoFOj3IYI9MwN
	4WvrCOiN0ZEfpWExR/2+Kvpj+0yUYM65Cy/BW5HOv11u6SEkKpTdsmklrdm5DSlG
	gz9Ai3vNV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=FS/
	1q0PFUXIMM5v7w+YuHD7Un1DLA2S+UKK2EtRD+tl91WSTlnJFvbL2jrK4AMf1GvX
	lylkZEPiUiE59CqqizNm0jNc2GxXzhOm2TnS1++ljEhThBUvecJKl5MGk9w2siXx
	5S8yQ3iQGy0RnhFAKu011YOW3lehxx49VHjsoTAM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C3D5A129;
	Thu,  6 Dec 2012 17:01:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F4E6A125; Thu,  6 Dec 2012
 17:01:19 -0500 (EST)
X-master-at: fb4c62235fee8008d99ef55c4adcb1f7ea9508a3
X-next-at: af2e3a9095a73e8f4f0dea403998204b8ff7dee1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76E57916-3FF0-11E2-A25F-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211171>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

All the topics still in 'next' are high-impact enough to deserve
getting cooked a bit longer, rather than risking potential
regression to the upcoming release.  v1.8.1-rc1 will be tagged
sometime this weekend (cf. http://tinyurl.com/gitCal).

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ef/mingw-tty-getpass (2012-12-04) 6 commits
 - mingw: get rid of getpass implementation
 - mingw: reuse tty-version of git_terminal_prompt
 - compat/terminal: separate input and output handles
 - compat/terminal: factor out echo-disabling
 - mingw: make fgetc raise SIGINT if apropriate
 - mingw: correct exit-code for SIGALRM's SIG_DFL

 Update getpass() emulation for MinGW.
 Will merge to 'next'.


* jl/submodule-deinit (2012-12-04) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will merge to 'next'.


* sl/git-svn-docs (2012-12-05) 4 commits
 - git-svn: Note about tags.
 - git-svn: Expand documentation for --follow-parent
 - git-svn: Recommend use of structure options.
 - git-svn: Document branches with at-sign(@).

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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

* pf/editor-ignore-sigint (2012-12-02) 5 commits
 - launch_editor: propagate signals from editor to git
 - run-command: do not warn about child death from terminal
 - launch_editor: ignore terminal signals while editor has control
 - launch_editor: refactor to use start/finish_command
 - run-command: drop silent_exec_failure arg from wait_or_whine

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Will merge to 'next'.


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


* mh/unify-xml-in-imap-send-and-http-push (2012-12-02) 8 commits
  (merged to 'next' on 2012-12-03 at d677090)
 + wrap_in_html(): process message in bulk rather than line-by-line
 + wrap_in_html(): use strbuf_addstr_xml_quoted()
 + imap-send: change msg_data from storing (ptr, len) to storing strbuf
 + imap-send: correctly report errors reading from stdin
 + imap-send: store all_msgs as a strbuf
 + lf_to_crlf(): NUL-terminate msg_data::data
 + xml_entities(): use function strbuf_addstr_xml_quoted()
 + Add new function strbuf_add_xml_quoted()

 Update imap-send to reuse xml quoting code from http-push codepath,
 clean up some code, and fix a small bug.


* rr/t4041-cleanup (2012-12-02) 4 commits
  (merged to 'next' on 2012-12-04 at ecee35d)
 + t4041 (diff-submodule-option): modernize style
 + t4041 (diff-submodule-option): rewrite add_file() routine
 + t4041 (diff-submodule-option): parse digests sensibly
 + t4041 (diff-submodule-option): don't hardcode SHA-1 in expected outputs

 Test clean-up.


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


* fc/fast-export-fixes (2012-12-03) 15 commits
  (merged to 'next' on 2012-12-03 at f9df523)
 + fast-export: make sure updated refs get updated
 + fast-export: don't handle uninteresting refs
 + fast-export: fix comparison in tests
 + fast-export: trivial cleanup
 + remote-testgit: implement the "done" feature manually
 + remote-testgit: report success after an import
 + remote-testgit: exercise more features
 + remote-testgit: cleanup tests
 + remote-testgit: remove irrelevant test
 + remote-testgit: remove non-local functionality
 + Add new simplified git-remote-testgit
 + Rename git-remote-testgit to git-remote-testpy
 + remote-helpers: fix failure message
 + remote-testgit: fix direction of marks
 + fast-export: avoid importing blob marks

 Will cook in 'next'.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
  (merged to 'next' on 2012-11-26 at 3af69e7)
 + apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Will cook in 'next'.


* nd/pathspec-wildcard (2012-11-26) 4 commits
  (merged to 'next' on 2012-12-03 at eca0fcb)
 + tree_entry_interesting: do basedir compare on wildcard patterns when possible
 + pathspec: apply "*.c" optimization from exclude
 + pathspec: do exact comparison on the leading non-wildcard part
 + pathspec: save the non-wildcard length part

 Will cook in 'next'.


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


* cr/push-force-tag-update (2012-12-03) 10 commits
  (merged to 'next' on 2012-12-04 at af2e3a9)
 + push: allow already-exists advice to be disabled
 + push: rename config variable for more general use
 + push: cleanup push rules comment
 + push: clarify rejection of update to non-commit-ish
 + push: require force for annotated tags
 + push: require force for refs under refs/tags/
 + push: flag updates that require force
 + push: keep track of "update" state separately
 + push: add advice for rejected tag reference
 + push: return reject reasons as a bitset

 Require "-f" for push to update a tag, even if it is a fast-forward.
