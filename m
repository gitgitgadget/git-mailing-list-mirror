From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Tue, 18 Dec 2012 12:31:43 -0800
Message-ID: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 21:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl3pn-0005WD-No
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 21:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab2LRUbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 15:31:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891Ab2LRUbw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 15:31:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435BBABF4;
	Tue, 18 Dec 2012 15:31:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	I/+MVhNanJZT0+LHUIEjjkxj4E=; b=myv4UcvLsHdAXs61o6Gn2B+wvlXW6FnMK
	EB28VUQSnnXrpGYOoLPS7RHIJn/Jp0Zp6PRBP5mcb0LG5koZrqUNYqFtx4Lz/rl0
	XArZmHdgULP7BuPGZez7KStdM6TPM6Bdxp10lI8fSN/SkBKuEHVecMCQXNT7cNSY
	ABSEB5dD9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=r4X
	6Umt+FarSgdfrIcjFqYh564R13mgAuHJkPR5c4lcv9dGSWGm7QgSEbXxUIbO/ej2
	qrC7NBNrc1AipBZGdsuPWVTs4tDc8BViMn4OLNGp2f2yDU69tu/beWeSpKnC7vK0
	+22o67+gH26ahHNzoghtpST7kwEPwgAP2OXp1XTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FB68ABF2;
	Tue, 18 Dec 2012 15:31:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3FB8ABEB; Tue, 18 Dec 2012
 15:31:48 -0500 (EST)
X-master-at: b7cd0c9b692af7728a1d876a3e4fe760956e00c3
X-next-at: c92fcd913d6db915141f6e28e838c7976a746786
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2CF9ACE-4951-11E2-8ED8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211784>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the 'master' branch is a bit past 1.8.1-rc2; hopefully we
can go final around the end of the week.

Many topics are getting into good shape in 'next', hopefully ready
to be merged soon after the 1.8.1 final.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* cc/no-gitk-build-dependency (2012-12-18) 3 commits
 - Makefile: replace "echo 1>..." with "echo >..."
 - Makefile: detect when PYTHON_PATH changes
 - Makefile: remove tracking of TCLTK_PATH

 Remove leftover bits from an earlier change to move gitk in its own
 subdirectory.  Reimplementing the dependency tracking rules needs
 to be done in gitk history separately.


* cr/doc-checkout-branch (2012-12-18) 2 commits
 - Documentation/git-checkout.txt: document 70c9ac2 behavior
 - Documentation/git-checkout.txt: clarify usage

 Document the magic "git checkout <no-such-branch>" hack to create
 local branch out of a remote tracking branch that hasn't been
 documented so far.

 Will merge to 'next'.


* jc/format-color-auto (2012-12-17) 2 commits
 - log --format: teach %C(auto,black) to respect color config
 - t6006: clean up whitespace

 Introduce "log --format=%C(auto,blue)Foo%C(auto,reset)" that does
 not color its output when writing to a non-terminal.

 Will merge to 'next'.


* ss/svn-prompt (2012-12-17) 3 commits
 - git-svn, perl/Git.pm: extend and use Git->prompt method for querying users
 - perl/Git.pm: Honor SSH_ASKPASS as fallback if GIT_ASKPASS is not set
 - git-svn, perl/Git.pm: add central method for prompting passwords

 Waiting for an Ack from the area export.


* zk/clean-report-failure (2012-12-17) 1 commit
 - git-clean: Display more accurate delete messages

 "git clean" states what it is going to remove and then goes on to
 remove it, but sometimes it only discovers things that cannot be
 removed after recursing into a directory, which makes the output
 confusing and even wrong.

 Waiting for responses to review comments.


* jc/doc-diff-blobs (2012-12-18) 1 commit
 - Documentation: Describe "git diff <blob> <blob>" separately

 "git diff <blob> <blob>" was not documented and was only hinted as
 an extension to "git diff <commit> <commit> -- <pathspec>", but
 comparison between two blobs are more special than that.  It does
 not take any pathspec to begin with.


* mp/complete-paths (2012-12-18) 1 commit
 - git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

--------------------------------------------------
[Stalled]

* jc/merge-blobs (2012-12-13) 5 commits
 . [broken] wip to fix d/f conflicts
 - merge-tree: add comments to clarify what these functions are doing
 - merge-tree: lose unused "resolve_directories"
 - merge-tree: lose unused "flags" from merge_list
 - Which merge_file() function do you mean?

 A beginning of a new merge strategy based on the disused merge-tree
 proof-of-concept code.


* jc/doc-maintainer (2012-11-27) 1 commit
 - update "howto maintain git"

 An early draft that is still incomplete.


* fc/remote-bzr (2012-12-13) 10 commits
 - (fixup) test-bzr.sh: fix multi-line string assignment
 - remote-bzr: detect local repositories
 - remote-bzr: add support for older versions of bzr
 - remote-bzr: add support to push special modes
 - remote-bzr: add support for fecthing special modes
 - remote-bzr: add simple tests
 - remote-bzr: update working tree upon pushing
 - remote-bzr: add support for remote repositories
 - remote-bzr: add support for pushing
 - Add new remote-bzr transport helper

 New remote helper for bzr (v3).  With minor fixes, this may be ready
 for 'next'.


* mo/cvs-server-updates (2012-12-09) 18 commits
 - t9402: Use TABs for indentation
 - t9402: Rename check.cvsCount and check.list
 - t9402: Simplify git ls-tree
 - t9402: Add missing &&; Code style
 - t9402: No space after IO-redirection
 - t9402: Dont use test_must_fail cvs
 - t9402: improve check_end_tree() and check_end_full_tree()
 - t9402: sed -i is not portable
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

* ja/directory-attrs (2012-12-17) 1 commit
  (merged to 'next' on 2012-12-17 at ced8e73)
 + Add directory pattern matching to attributes

 The attribute mechanism didn't allow limiting attributes to be
 applied to only a single directory itself with "path/" like the
 exclude mechanism does.

 Will cook in 'next'.


* jk/mailmap-cleanup (2012-12-12) 5 commits
  (merged to 'next' on 2012-12-17 at 07c1a11)
 + contrib: update stats/mailmap script
 + .mailmap: normalize emails for Linus Torvalds
 + .mailmap: normalize emails for Jeff King
 + .mailmap: fix broken entry for Martin Langhoff
 + .mailmap: match up some obvious names/emails

 Update various entries in our .mailmap file.


* jk/mailmap-from-blob (2012-12-13) 5 commits
  (merged to 'next' on 2012-12-17 at 14b7cdc)
 + mailmap: default mailmap.blob in bare repositories
 + mailmap: fix some documentation loose-ends for mailmap.blob
 + mailmap: clean up read_mailmap error handling
 + mailmap: support reading mailmap from blobs
 + mailmap: refactor mailmap parsing for non-file sources

 Allow us to read, and default to read, mailmap files from the tip
 of the history in bare repositories.  This will help running tools
 like shortlog in server settings.


* nd/index-format-doc (2012-12-13) 1 commit
  (merged to 'next' on 2012-12-17 at 7984924)
 + index-format.txt: clarify what is "invalid"


* as/doc-for-devs (2012-12-16) 2 commits
 - Documentation: move support for old compilers to CodingGuidelines
 - SubmittingPatches: add convention of prefixing commit messages

 It might be a better idea to move the text the bottom one adds to
 the extended description from the quick checklist part.

 Will merge to 'next'.


* dm/port (2012-12-18) 4 commits
 - git-compat-util.h: do not #include <sys/param.h> by default
 - Generalize the inclusion of strings.h
 - Detect when the passwd struct is missing pw_gecos
 - Support builds when sys/param.h is missing

 Will merge to 'next'.


* jc/fetch-tags-doc (2012-12-13) 1 commit
  (merged to 'next' on 2012-12-17 at 857413a)
 + fetch --tags: clarify documentation

 The explanation for "fetch --tags" was actually talking more about
 "fetch --no-tags".  Clariify what "--tags" really means.


* jk/avoid-mailto-invalid-in-doc (2012-12-16) 1 commit
 - Documentation: don't link to example mail addresses

 Avoids invalid sample e-mail addresses from becoming mailto links
 in the formatted output, which by itself is "Meh" for me (who
 cares?) but it highlights some issues with ``pretty quotes''.

 Will merge to 'next'.


* jk/complete-commit-c (2012-12-15) 1 commit
 - completion: complete refs for "git commit -c"

 Complete "git commmit -c foo<TAB>" into a refname that begins with
 "foo".

 Will merge to 'next'.


* jk/error-const-return (2012-12-15) 2 commits
 - silence some -Wuninitialized false positives
 - make error()'s constant return value more visible

 Help compilers' flow analysis by making it more explicit that
 error() always returns -1, to reduce false "variable used
 uninitialized" warnings.

 This is still an RFC.


* mk/qnx (2012-12-15) 2 commits
 - Port to QNX
 - Make lock local to fetch_pack

 Port to QNX; we may want to rebase this on top of dm/port topic as
 it also wants to use the HAVE_STRINGS_H mechanism it introduces.


* rj/maint-cygwin-say-color (2012-12-15) 1 commit
 - tests: Allow customization of how say_color() prints

 Even though I do not think of a cleaner way to do this, I am not
 happy with the way how $GIT_TEST_PRINT and $GIT_TEST_PRINT_LN are
 interpolated into the command line with token splitting at $IFS.


* sl/readme-gplv2 (2012-12-15) 2 commits
 - README: it does not matter who the current maintainer is
 - README: Git is released under the GPLv2, not just "the GPL"

 Clarify that the project as a whole is GPLv2 only, with some parts
 borrowed under different licenses that are compatible with GPLv2.

 Will merge to 'next'.


* ta/api-index-doc (2012-12-16) 1 commit
 - Remove misleading date from api-index-skel.txt

 Will merge to 'next'.


* as/test-tweaks (2012-12-17) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: change info messages from yellow/brown to bold cyan
 - tests: paint skipped tests in bold blue
 - tests: paint known breakages in bold yellow
 - tests: test number comes first in 'not ok $count - $message'

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Will merge to 'next'.


* sp/shortlog-missing-lf (2012-12-11) 2 commits
  (merged to 'next' on 2012-12-11 at 64b8429)
 + strbuf_add_wrapped*(): Remove unused return value
 + shortlog: fix wrapping lines of wraplen

 When a line to be wrapped has a solid run of non space characters
 whose length exactly is the wrap width, "git shortlog -w" failed to
 add a newline after such a line.

 Will cook in 'next'.


* ap/log-mailmap (2012-12-15) 7 commits
 - test: Add test for --use-mailmap option
 - log: Add --use-mailmap option
 - pretty: Use mailmap to display username and email
 - mailmap: Add mailmap structure to rev_info and pp
 - mailmap: Simplify map_user() interface
 - mailmap: Remove buffer length limit in map_user
 - Use split_ident_line to parse author and committer

 Clean up various codepaths around mailmap and teach the "log"
 machinery to use it.

 Will merge to 'next' after reading it over once again.


* jc/fetch-ignore-symref (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-17 at 370e2c8)
 + fetch: ignore wildcarded refspecs that update local symbolic refs

 Avoid false error from an attempt to update local symbolic ref via
 fetch.

 Will cook in 'next'.


* md/gitweb-sort-by-age (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-13 at 9f39410)
 + gitweb: Sort projects with undefined ages last

 Gitweb showed repositories without any commit at the top in its
 age-sorted view, in which the users are interested in looking at
 active projects; sorting them at the bottom makes it more useful.

 Will cook in 'next'.


* ss/nedmalloc-compilation (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-13 at c1f0d7f)
 + nedmalloc: Fix a compile warning (exposed as error) with GCC 4.7.2

 Will cook in 'next'.


* wk/submodule-update-remote (2012-12-12) 3 commits
 - submodule add: If --branch is given, record it in .gitmodules
 - submodule update: add --remote for submodule's upstream changes
 - submodule: add get_submodule_config helper funtion

 Expecting a re-roll.


* jc/maint-fbsd-sh-ifs-workaround (2012-12-10) 1 commit
  (merged to 'next' on 2012-12-11 at 6659fdc)
 + sh-setup: work around "unset IFS" bug in some shells

 Will cook in 'next'.


* jc/same-encoding (2012-12-10) 1 commit
  (merged to 'next' on 2012-12-17 at 86b41c7)
 + format_commit_message(): simplify calls to logmsg_reencode()

 Finishing touches to the series to unify "Do we need to reencode
 between these two encodings?" logic.


* nd/invalidate-i-t-a-cache-tree (2012-12-15) 4 commits
 - cache-tree: invalidate i-t-a paths after generating trees
 - cache-tree: fix writing cache-tree when CE_REMOVE is present
 - cache-tree: replace "for" loops in update_one with "while" loops
 - cache-tree: remove dead i-t-a code in verify_cache()

 Writing out a tree object when you still have intent-to-add entries
 in the index left an incorrect cache-tree data there.

 Will merge to 'next'.


* jl/submodule-deinit (2012-12-04) 1 commit
  (merged to 'next' on 2012-12-07 at ea772f0)
 + submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will cook in 'next'.


* sl/git-svn-docs (2012-12-05) 4 commits
  (merged to 'next' on 2012-12-07 at 5bfbb73)
 + git-svn: Note about tags.
 + git-svn: Expand documentation for --follow-parent
 + git-svn: Recommend use of structure options.
 + git-svn: Document branches with at-sign(@).

 Will cook in 'next'.


* pf/editor-ignore-sigint (2012-12-02) 5 commits
  (merged to 'next' on 2012-12-07 at 6b04419)
 + launch_editor: propagate signals from editor to git
 + run-command: do not warn about child death from terminal
 + launch_editor: ignore terminal signals while editor has control
 + launch_editor: refactor to use start/finish_command
 + run-command: drop silent_exec_failure arg from wait_or_whine

 Avoid confusing cases where the user hits Ctrl-C while in the editor
 session, not realizing git will receive the signal. Since most editors
 will take over the terminal and will block SIGINT, this is not likely
 to confuse anyone.

 Will cook in 'next'.


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

 Will cook in 'next'.


* jk/fsck-dot-in-trees (2012-11-28) 2 commits
  (merged to 'next' on 2012-11-28 at 519dabc)
 + fsck: warn about ".git" in trees
 + fsck: warn about '.' and '..' in trees

 Will cook in 'next'.


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


* nd/wildmatch (2012-12-15) 15 commits
  (merged to 'next' on 2012-12-15 at c734714)
 + t3070: Disable some failing fnmatch tests
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

 Will cook in 'next'.
