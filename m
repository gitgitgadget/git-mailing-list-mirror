From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2013, #03; Sun, 6)
Date: Sun, 06 Jan 2013 18:42:16 -0800
Message-ID: <7vip79lnnb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 03:42:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts2fm-0002zk-9W
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 03:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab3AGCmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 21:42:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463Ab3AGCmU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 21:42:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369E8B3BE;
	Sun,  6 Jan 2013 21:42:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	o58MJ1J8A2B3ZcBL/DLPW31Ws4=; b=CTBi7SQZ+1/APUm7HsNLn91vlNv7yGjbY
	qgQC5nC/C7SpJ62hJB0st4tte/B6Pk9qdTtbHEUrJHZ1hFBkc8GABWOcwgH34K6Q
	a4POEwc6RpV6+l5ITPw3uejAhrOFa86Lu9zvxZv9veq+BYzj8g3njDRn3mT95eee
	rgSc7RsuqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=PSk
	rWwmiNDzuoVm5BvrwxO75RqvA703CBMofXJFMBuSnhFECLd90xbO6E0Fy6H0Mm6d
	3uVSprk31Kyzdp8+izKDhpe+dKYcECf2pvKeqOQ2HiBEQC8uhLycXAFZX30aO4Po
	76UHm+N19sr0YDtULyKay2a/E+yJ4aX1gp/56pBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28242B3BD;
	Sun,  6 Jan 2013 21:42:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A08B1B3BC; Sun,  6 Jan 2013
 21:42:17 -0500 (EST)
X-master-at: 32238aeb730fda0f66ccc6ec2f1e342af8b9fd04
X-next-at: 6e0eed0d38e507b7cf6c43be8a89ad15eb9aab5e
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA0304D2-5873-11E2-BF1C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212869>

What's cooking in git.git (Jan 2013, #03; Sun, 6)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of 'next' will be rewound and rebuilt shortly, kicking a
couple of topics back to 'pu' and reordering the remainder as
needed.

As usual, this cycle is expected to last for 8 to 10 weeks.  To
ensure the quality of the end result, let's merge topics in flight
earlier than previous cycles to 'next' and fix issues in-tree.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

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

 Various updates to fast-export used in the context of the remote
 helper interface.


* ja/directory-attrs (2012-12-17) 1 commit
  (merged to 'next' on 2012-12-17 at ced8e73)
 + Add directory pattern matching to attributes

 The attribute mechanism didn't allow limiting attributes to be
 applied to only a single directory itself with "path/" like the
 exclude mechanism does.


* jc/fetch-ignore-symref (2012-12-11) 1 commit
  (merged to 'next' on 2012-12-17 at 370e2c8)
 + fetch: ignore wildcarded refspecs that update local symbolic refs

 Avoid false error from an attempt to update local symbolic ref via
 fetch.


* jc/format-color-auto (2012-12-17) 2 commits
  (merged to 'next' on 2012-12-18 at 5aaac94)
 + log --format: teach %C(auto,black) to respect color config
 + t6006: clean up whitespace

 Introduce "log --format=%C(auto,blue)Foo%C(auto,reset)" that does
 not color its output when writing to a non-terminal.


* jk/complete-commit-c (2012-12-15) 1 commit
  (merged to 'next' on 2012-12-18 at 75b5f21)
 + completion: complete refs for "git commit -c"

 Complete "git commmit -c foo<TAB>" into a refname that begins with
 "foo".


* jk/error-const-return (2012-12-15) 2 commits
  (merged to 'next' on 2012-12-22 at bf2b1cd)
 + silence some -Wuninitialized false positives
 + make error()'s constant return value more visible

 Help compilers' flow analysis by making it more explicit that
 error() always returns -1, to reduce false "variable used
 uninitialized" warnings.  Looks somewhat ugly but not too much.


* jk/fsck-dot-in-trees (2012-11-28) 2 commits
  (merged to 'next' on 2012-11-28 at 519dabc)
 + fsck: warn about ".git" in trees
 + fsck: warn about '.' and '..' in trees


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


* nd/pathspec-wildcard (2012-11-26) 4 commits
  (merged to 'next' on 2012-12-03 at eca0fcb)
 + tree_entry_interesting: do basedir compare on wildcard patterns when possible
 + pathspec: apply "*.c" optimization from exclude
 + pathspec: do exact comparison on the leading non-wildcard part
 + pathspec: save the non-wildcard length part

 Optimize matching paths with common forms of pathspecs that contain
 wildcard characters.


* wk/submodule-update-remote (2012-12-19) 3 commits
  (merged to 'next' on 2012-12-22 at 7ddf897)
 + submodule add: If --branch is given, record it in .gitmodules
 + submodule update: add --remote for submodule's upstream changes
 + submodule: add get_submodule_config helper funtion

 The beginning of 'integrate with the tip of the remote branch, not
 the commit recorded in the superproject gitlink' support.

--------------------------------------------------
[New Topics]

* jk/pathspec-literal (2013-01-06) 1 commit
 - t6130-pathspec-noglob: Windows does not allow a file named "f*"

 Will merge to 'next' and 'master' as a quick "oops" fix.


* as/dir-c-cleanup (2012-12-28) 10 commits
 - dir.c: rename free_excludes() to clear_exclude_list()
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name
 - Improve documentation and comments regarding directory traversal API
 - api-directory-listing.txt: update to match code
 (this branch is used by as/check-ignore.)

 Separated an earlier and more solidly done bits from the other
 topic.

 Will merge to 'next'.


* jk/config-uname (2013-01-03) 1 commit
 - Makefile: hoist uname autodetection to config.mak.uname

 Move the bits to set fallback default based on the platform from
 the main Makefile to a separate file, so that it can be included in
 Makefiles in subdirectories.

 Will merge to 'next'.


* jc/push-2.0-default-to-simple (2013-01-04) 10 commits
 - push: switch default from "matching" to "simple"
 - t9401: do not assume the "matching" push is the default
 - t9400: do not assume the "matching" push is the default
 - t7406: do not assume the "matching" push is the default
 - t5531: do not assume the "matching" push is the default
 - t5519: do not assume the "matching" push is the default
 - t5517: do not assume the "matching" push is the default
 - t5516: do not assume the "matching" push is the default
 - t5505: do not assume the "matching" push is the default
 - t5404: do not assume the "matching" push is the default

 Will merge to 'next' and cook there until Git 2.0.


* jk/maint-fast-import-doc-dedup-done (2013-01-05) 1 commit
 - git-fast-import(1): remove duplicate "--done" option

 Will merge to 'next' and 'master' as a quick "oops" fix.

 The "logical order" reorganization can come after that is done and
 can cook longer in 'next'.


* jk/unify-exit-code-by-receiving-signal (2013-01-06) 1 commit
 - run-command: encode signal death as a positive integer

 The internal logic had to deal with two representations of a death
 of a child process by a signal.

 Will merge to 'next'.


* jl/interrupt-clone-remove-separate-git-dir (2013-01-05) 1 commit
 - clone: support atomic operation with --separate-git-dir

 When "git clone --separate-git-dir" is interrupted, we failed to
 remove the real location we created the repository.

 Will merge to 'next'.


* rs/leave-base-name-in-name-field-of-tar (2013-01-05) 1 commit
 - archive-tar: split long paths more carefully

 Improve compatibility with implementations of "tar" that do not
 like empty name field in header (with the additional prefix field
 holding everything).

 Will merge to 'next'.


* as/api-allocation-doc (2013-01-06) 1 commit
 - api-allocation-growing.txt: encourage better variable naming

 Will merge to 'next'.


* jc/comment-cygwin-win32api-in-makefile (2013-01-06) 1 commit
 - Makefile: add comment on CYGWIN_V15_WIN32API

 Will merge to 'next'.


* jn/xml-depends-on-asciidoc-conf (2013-01-06) 1 commit
 - docs: manpage XML depends on asciidoc.conf

 Will merge to 'next'.


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


* rs/zip-tests (2013-01-06) 4 commits
 - t5003: check if unzip supports symlinks
 - t5000, t5003: move ZIP tests into their own script
 - t0024, t5000: use test_lazy_prereq for UNZIP
 - t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead

 Updates zip tests to skip some that cannot be handled on platform
 unzip.

 I've renamed the t5002 in the original to t5003 to avoid name
 clashes with another topic in flight.

 Will merge to 'next'.


* rs/zip-with-uncompressed-size-in-the-header (2013-01-06) 1 commit
 - archive-zip: write uncompressed size into header even with streaming

 Improve compatibility of our zip output to fill uncompressed size
 in the header, which we can do without seeking back (even though it
 should not be necessary).

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jl/submodule-deinit (2012-12-04) 1 commit
  (merged to 'next' on 2012-12-07 at ea772f0)
 + submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 But this does not yet do so (does not remove the checkout of the
 submodule).  The design discussion petered out.

 http://thread.gmane.org/gmane.comp.version-control.git/210867/focus=211456

 Will kick back to 'pu'.


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
  (merged to 'next' on 2012-10-29 at af52cef)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).

 Will kick back to 'pu'.


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

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* jn/less-reconfigure (2013-01-02) 1 commit
  (merged to 'next' on 2013-01-02 at e5cd6cf)
 + build: do not automatically reconfigure unless configure.ac changed

 When autoconf is used, any build on a different commit always ran
 "config.status --recheck" even when unnecessary.

 Will merge to 'master'.


* ap/merge-stop-at-prepare-commit-msg-failure (2013-01-03) 1 commit
  (merged to 'next' on 2013-01-04 at 251e88b)
 + merge: Honor prepare-commit-msg return code

 "git merge" started calling prepare-commit-msg hook like "git
 commit" does some time ago, but forgot to pay attention to the exit
 status of the hook.  t7505 may want a general clean-up but that is
 a different topic.

 Will merge to 'master'.


* tb/test-shell-lint (2013-01-02) 1 commit
  (merged to 'next' on 2013-01-04 at 0289566)
 + test: Add check-non-portable-shell.pl

 Check for common mistakes in the test scripts, based on simple
 pattern-matching.


* jk/enable-test-lint-by-default (2013-01-03) 1 commit
  (merged to 'next' on 2013-01-04 at 65b21ad)
 + tests: turn on test-lint by default

 We had two simple and quick tests to catch common mistakes when
 writing test scripts, but they weren't run by default when running
 tests.

 Will merge to 'master'.


* jc/doc-maintainer (2013-01-03) 2 commits
 - howto/maintain: mark titles for asciidoc
 - Documentation: update "howto maintain git"

 Describe tools for automation that were invented since this
 document was originally written.


* fc/remote-testgit-feature-done (2012-10-29) 1 commit
 - remote-testgit: properly check for errors

 In the longer term, tightening rules is a good thing to do, and
 because nobody who has worked in the remote helper area seems to be
 interested in reviewing this, I would assume they do not think
 such a retroactive tightening will affect their remote helpers.  So
 let's advance this topic to see what happens.


* fc/remote-bzr (2013-01-02) 9 commits
  (merged to 'next' on 2013-01-04 at 7791dcb)
 + remote-bzr: detect local repositories
 + remote-bzr: add support for older versions of bzr
 + remote-bzr: add support to push special modes
 + remote-bzr: add support for fecthing special modes
 + remote-bzr: add simple tests
 + remote-bzr: update working tree upon pushing
 + remote-bzr: add support for remote repositories
 + remote-bzr: add support for pushing
 + Add new remote-bzr transport helper

 New remote helper for bzr, with minimum fix squashed in.

 Will merge to 'master'.


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

 As nobody seems to be stepping up to review this, I am tempted to
 merge this to 'next and see who screams.

 Will merge to 'next'.


* jc/submittingpatches (2013-01-02) 4 commits
  (merged to 'next' on 2013-01-04 at 060ffb0)
 + SubmittingPatches: give list and maintainer addresses
 + SubmittingPatches: remove overlong checklist
 + SubmittingPatches: mention subsystems with dedicated repositories
 + SubmittingPatches: who am I and who cares?

 Streamline the document and update with a few e-mail addresses the
 patches should be sent to.

 Will merge to 'master'.


* kb/maint-bundle-doc (2013-01-01) 2 commits
  (merged to 'next' on 2013-01-04 at 73486d9)
 + Documentation: full-ness of a bundle is significant for cloning
 + Documentation: correct example restore from bundle

 Will merge to 'master'.


* nd/maint-branch-desc-doc (2013-01-03) 5 commits
  (merged to 'next' on 2013-01-04 at d05a47f)
 + format-patch: pick up branch description when no ref is specified
 + format-patch: pick up correct branch name from symbolic ref
 + t4014: a few more tests on cover letter using branch description
 + branch: delete branch description if it's empty
 + config.txt: a few lines about branch.<name>.description

 Teach various forms of "format-patch" command line to identify what
 branch the patches are taken from, so that the branch description
 is picked up in more cases.

 Will merge to 'master'.


* tb/test-t9020-no-which (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-04 at 0bcf646)
 + t9020: which is not portable

 Will merge to 'master'.


* tb/test-t9810-no-sed-i (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-04 at 0da03e6)
 + t9810: Do not use sed -i

 Will merge to 'master'.


* aw/rebase-am-failure-detection (2012-10-11) 1 commit
  (merged to 'next' on 2013-01-02 at b9db3a2)
 + rebase: Handle cases where format-patch fails

 Save output from format-patch command in a temporary file, just in
 case it aborts, to give a better failure-case behaviour.


* ap/status-ignored-in-ignored-directory (2013-01-06) 3 commits
 - status: always report ignored tracked directories
  (merged to 'next' on 2013-01-04 at 114fb2f)
 + git-status: Test --ignored behavior
 + dir.c: Make git-status --ignored more consistent

 Output from "git status --ignored" showed an unexpected interaction
 with "--untracked".


* ta/remove-stale-translated-tut (2012-12-27) 1 commit
  (merged to 'next' on 2013-01-02 at e70df8e)
 + Remove Documentation/pt_BR/gittutorial.txt

 Remove a translation of a document that was left stale.

 Will merge to 'master'.


* er/stop-recommending-parsecvs (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-02 at fd816dd)
 + Remove the suggestion to use parsecvs, which is currently broken.

 Stop recommending a defunct third-party software.

 Will merge to 'master'.


* as/test-name-alias-uniquely (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-02 at e297810)
 + Use longer alias names in subdirectory tests

 A few short-and-bland aliases used in the tests were interfering
 with git-custom command in user's $PATH.

 Will merge to 'master'.


* jc/maint-fmt-merge-msg-no-edit-lose-credit (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-02 at 8795e87)
 + merge --no-edit: do not credit people involved in the side branch

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

 Rerolled.


* jc/format-patch-reroll (2013-01-03) 9 commits
  (merged to 'next' on 2013-01-04 at 6840dbd)
 + format-patch: give --reroll-count a short synonym -v
 + format-patch: document and test --reroll-count
 + format-patch: add --reroll-count=$N option
 + get_patch_filename(): split into two functions
 + get_patch_filename(): drop "just-numbers" hack
 + get_patch_filename(): simplify function signature
 + builtin/log.c: stop using global patch_suffix
 + builtin/log.c: drop redundant "numbered_files" parameter from make_cover_letter()
 + builtin/log.c: drop unused "numbered" parameter from make_cover_letter()

 Teach "format-patch" to prefix v4- to its output files for the
 fourth iteration of a patch series, to make it easier for the
 submitter to keep separate copies for iterations.

 Will merge to 'master'.


* mz/pick-unborn (2012-12-23) 2 commits
  (merged to 'next' on 2013-01-02 at 22b9951)
 + learn to pick/revert into unborn branch
 + tests: move test_cmp_rev to test-lib-functions

 Allows "git cherry-pick $commit" when you do not have any history
 behind HEAD yet.


* nd/retire-fnmatch (2013-01-01) 7 commits
  (merged to 'next' on 2013-01-04 at 4dc3ff1)
 + Makefile: add USE_WILDMATCH to use wildmatch as fnmatch
 + wildmatch: advance faster in <asterisk> + <literal> patterns
 + wildmatch: make a special case for "*/" with FNM_PATHNAME
 + test-wildmatch: add "perf" command to compare wildmatch and fnmatch
 + wildmatch: support "no FNM_PATHNAME" mode
 + wildmatch: make dowild() take arbitrary flags
 + wildmatch: rename constants and update prototype
 (this branch uses nd/wildmatch.)

 Replace our use of fnmatch(3) with a more feature-rich wildmatch.
 A handful patches at the bottom have been moved to nd/wildmatch to
 graduate as part of that branch, before this series solidifies.


* os/gitweb-highlight-uncaptured (2013-01-01) 1 commit
  (merged to 'next' on 2013-01-04 at d565cdd)
 + gitweb: fix error in sanitize when highlight is enabled

 The code to sanitize control characters before passing it to
 "highlight" filter lost known-to-be-safe control characters by
 mistake.

 Will merge to 'master'.


* jc/merge-blobs (2012-12-26) 5 commits
 - merge-tree: fix d/f conflicts
 - merge-tree: add comments to clarify what these functions are doing
 - merge-tree: lose unused "resolve_directories"
 - merge-tree: lose unused "flags" from merge_list
 - Which merge_file() function do you mean?

 Update the disused merge-tree proof-of-concept code.

 Will merge to 'next'.


* er/python-version-requirements (2012-12-28) 1 commit
  (merged to 'next' on 2013-01-02 at 1023a3f)
 + Add checks to Python scripts for version dependencies.

 Some python scripts we ship cannot be run with old versions of the
 interpreter.

 Will merge to 'master'.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* mz/oneway-merge-wo-u-no-lstat (2012-12-20) 1 commit
  (merged to 'next' on 2012-12-22 at 87bd30e)
 + oneway_merge(): only lstat() when told to update worktree

 Optimize "read-tree -m <tree-ish>" without "-u".

 Will merge to 'master'.


* cc/no-gitk-build-dependency (2012-12-18) 3 commits
  (merged to 'next' on 2012-12-22 at da7b2cf)
 + Makefile: replace "echo 1>..." with "echo >..."
 + Makefile: detect when PYTHON_PATH changes
 + Makefile: remove tracking of TCLTK_PATH

 Remove leftover bits from an earlier change to move gitk in its own
 subdirectory.  Reimplementing the dependency tracking rules needs
 to be done in gitk history separately.

 Will merge to 'master'.


* zk/clean-report-failure (2013-01-06) 1 commit
 - git-clean: Display more accurate delete messages

 "git clean" states what it is going to remove and then goes on to
 remove it, but sometimes it only discovers things that cannot be
 removed after recursing into a directory, which makes the output
 confusing and even wrong.

 Rerolled.


* mp/complete-paths (2012-12-21) 1 commit
 - git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

 It has been reported (no surprise) that this does not work inside
 subdirectory. $gmane/212642

 Waiting for area-experts' review.


* ap/log-mailmap (2013-01-06) 10 commits
 - log: add log.mailmap configuration option
 - log: grep author/committer using mailmap
 - test: add test for --use-mailmap option
 - log: add --use-mailmap option
 - pretty: use mailmap to display username and email
 - mailmap: add mailmap structure to rev_info and pp
 - mailmap: simplify map_user() interface
 - mailmap: remove email copy and length limitation
 - Use split_ident_line to parse author and committer
 - list_lookup: create case and length search

 Clean up various codepaths around mailmap and teach the "log"
 machinery to use it.

 Rerolled.


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


* jn/warn-on-inaccessible-loosen (2012-10-14) 4 commits
  (merged to 'next' on 2012-11-28 at 43d51c2)
 + config: exit on error accessing any config file
 + doc: advertise GIT_CONFIG_NOSYSTEM
 + config: treat user and xdg config permission problems as errors
 + config, gitignore: failure to access with ENOTDIR is ok

 Deal with a situation where .config/git is a file and we notice
 .config/git/config is not readable due to ENOTDIR, not ENOENT.

 Will merge to 'master'.


* jc/apply-trailing-blank-removal (2012-10-12) 1 commit
  (merged to 'next' on 2012-11-26 at 3af69e7)
 + apply.c:update_pre_post_images(): the preimage can be truncated

 Fix to update_pre_post_images() that did not take into account the
 possibility that whitespace fix could shrink the preimage and
 change the number of lines in it.

 Will merge to 'master'.


* nd/wildmatch (2013-01-01) 18 commits
  (merged to 'next' on 2013-01-01 at 8c633a5)
 + wildmatch: replace variable 'special' with better named ones
 + compat/fnmatch: respect NO_FNMATCH* even on glibc
 + wildmatch: fix "**" special case
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
 (this branch is used by nd/retire-fnmatch.)

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hierarchies.

--------------------------------------------------
[Discarded]

* jc/doc-default-format (2013-01-03) 2 commits
 . Allow installing a non-default set of documentation
 . Allow generating a non-default set of documentation

 Instead of the default of generating html/man and installing man,
 you can control what "make doc" and "make install-doc" do via two
 make variables.
