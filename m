From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2013, #05; Wed, 18)
Date: Wed, 18 Sep 2013 15:03:47 -0700
Message-ID: <xmqqwqmdu6rg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 19 00:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMPqm-0003j5-T3
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 00:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370Ab3IRWDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 18:03:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34940 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226Ab3IRWDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 18:03:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 124894339E;
	Wed, 18 Sep 2013 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	BeQt5AEBFsmVCEwH4HhIdEe+HM=; b=mI3Eqb3mSftUjXRVwiuNyZSI/M3dNGAUN
	V+xPSlIVSIXbxL6kyqwPmffmATV6tMwFwZ4oZYE3rAGzif3v29qQ0Mpi/nbt6RX4
	2z12ubS57d/qZQeE9e7BUMjPMaLXNUDlZcbLkKlluOmOJQfPLMk2qocvhfhZxrBB
	j05VxJB0YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ffW
	2XftlI2J2l3lbJpcIlZSlGjWThM2QoPBy0GqaFTh9pz3HVddTr+KTpY2BasR58no
	pcy7zMQxguRab1jLvC7d8I6ORvtPfaq5jB18fhB4eGO+KU8bPQDPi580YowdMkQA
	9WHfBHakNGZjeczb11NN5tisKl8/mMKNfg7a2yMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 047594339C;
	Wed, 18 Sep 2013 22:03:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04F9F43394;
	Wed, 18 Sep 2013 22:03:48 +0000 (UTC)
X-master-at: eeaee045c85719821e685a22603a645a0ea85bad
X-next-at: d97bfe6d8d1499241374e46954d566a3af3b8087
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3239F932-20AE-11E3-84F4-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234997>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The fourth batch of topics are in 'master'.

By the way, I'm scheduled to be offline starting next week for a few
weeks; for the past two autumns, Peff played the role of the interim
maintainer and took good care of the project during my absense. This
time around, to improve the "bus factor", I asked Jonathan Nieder to
fill in for me (with Peff as a back-up help).

A big "Thanks!" to both of them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ab/gitweb-author-initials (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at ecb924d)
 + gitweb: Fix the author initials in blame for non-ASCII names


* ap/commit-author-mailmap (2013-08-24) 1 commit
  (merged to 'next' on 2013-09-09 at 79d5a20)
 + commit: search author pattern against mailmap

 "git commit --author=$name", when $name is not in the canonical
 "A. U. Thor <au.thor@example.xz>" format, looks for a matching name
 from existing history, but did not consult mailmap to grab the
 preferred author name.


* bc/send-email-ssl-die-message-fix (2013-09-10) 1 commit
  (merged to 'next' on 2013-09-13 at c6fcdf4)
 + send-email: don't call methods on undefined values

 When send-email comes up with an error message to die with upon
 failure to start an SSL session, it tried to read the error string
 from a wrong place.


* dw/diff-no-index-doc (2013-08-28) 2 commits
  (merged to 'next' on 2013-09-10 at 423c8f6)
 + diff --no-index: describe in a separate paragraph
 + diff --no-index: clarify operation when not inside a repository

 When the user types "git diff" outside a working tree, thinking he
 is inside one, the current error message that is a single-liner
 "usage: git diff --no-index <path> <path>" may not be sufficient to
 make him realize the mistake. Add "Not a git repository" to the
 error message when we fell into the "--no-index" mode without an
 explicit command line option to instruct us to do so.


* fc/contrib-bzr-hg-fixes (2013-09-03) 10 commits
  (merged to 'next' on 2013-09-12 at f5e8684)
 + contrib/remote-helpers: quote variable references in redirection targets
 + contrib/remote-helpers: style updates for test scripts
 + remote-hg: use notes to keep track of Hg revisions
 + remote-helpers: cleanup more global variables
 + remote-helpers: trivial style fixes
 + remote-hg: improve basic test
 + remote-hg: add missing &&s in the test
 + remote-hg: fix test
 + remote-bzr: make bzr branches configurable per-repo
 + remote-bzr: fix export of utf-8 authors


* fc/fast-export (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-09 at 8d5d396)
 + fast-export: refactor get_tags_and_duplicates()
 + fast-export: make extra_refs global

 Code simpification.


* fc/rev-parse-test-updates (2013-09-03) 4 commits
  (merged to 'next' on 2013-09-09 at 92c51ef)
 + rev-parse test: use standard test functions for setup
 + rev-parse test: use test_cmp instead of "test" builtin
 + rev-parse test: use test_must_fail, not "if <command>; then false; fi"
 + rev-parse test: modernize quoting and whitespace

 Modernize tests.


* fc/t3200-fixes (2013-09-03) 3 commits
  (merged to 'next' on 2013-09-09 at 3626363)
 + t: branch: fix broken && chains
 + t: branch: fix typo
 + t: branch: trivial style fix


* fc/trivial (2013-09-08) 5 commits
  (merged to 'next' on 2013-09-09 at a8ad2e1)
 + pull: use $curr_branch_short more
 + add: trivial style cleanup
 + reset: trivial style cleanup
 + branch: trivial style fix
 + reset: trivial refactoring


* jc/cvsserver-perm-bit-fix (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-13 at 56db105)
 + cvsserver: pick up the right mode bits

 "git cvsserver" computed the permission mode bits incorrectly for
 executable files.


* jc/url-match (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-13 at 7b94f8e)
 + urlmatch.c: recompute pointer after append_normalized_escapes

 While normalizing a URL, we forgot that the buffer that holds it
 could be relocated when it grows, which was a brown-paper-bag bug
 that can lead to a crash introduced on 'master' post 1.8.4 release.


* jk/duplicate-objects-in-packs (2013-09-04) 5 commits
  (merged to 'next' on 2013-09-09 at 72f2c3d)
 + t5308: check that index-pack --strict detects duplicate objects
 + test index-pack on packs with recoverable delta cycles
 + add tests for indexing packs with delta cycles
 + sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
 + test-sha1: add a binary output mode

 A packfile that stores the same object more than once is broken and
 will be rejected.


* jk/free-tree-buffer (2013-06-06) 1 commit
  (merged to 'next' on 2013-09-09 at 3576189)
 + clear parsed flag when we free tree buffers


* jk/has-sha1-file-retry-packed (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at fc42e9b)
 + has_sha1_file: re-check pack directory before giving up

 When an object is not found after checking the packfiles and then
 loose object directory, read_sha1_file() re-checks the packfiles to
 prevent racing with a concurrent repacker; teach the same logic to
 has_sha1_file().


* jk/pager-bypass-cat-for-default-pager (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at c9cfbaa)
 + pager: turn on "cat" optimization for DEFAULT_PAGER

 If a build-time fallback is set to "cat" instead of "less", we
 should apply the same "no subprocess or pipe" optimization as we
 apply to user-supplied GIT_PAGER=cat.


* jk/remove-remote-helpers-in-python (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-10 at 49c7a74)
 + git_remote_helpers: remove little used Python library

 Remove now disused remote-helpers framework for helpers written in
 Python.


* jk/write-broken-index-with-nul-sha1 (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 6953f27)
 + write_index: optionally allow broken null sha1s

 Earlier we started rejecting an attempt to add 0{40} object name to
 the index and to tree objects, but it sometimes is necessary to
 allow so to be able to use tools like filter-branch to correct such
 broken tree objects.


* js/add-i-mingw (2013-09-04) 1 commit
  (merged to 'next' on 2013-09-10 at 50ab841)
 + add--interactive: fix external command invocation on Windows

 The implementation of "add -i" has a crippling code to work around
 ActiveState Perl limitation but it by mistake also triggered on Git
 for Windows where MSYS perl is used.


* jx/clean-interactive (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 477fec6)
 + documentation: clarify notes for clean.requireForce
 (this branch is used by jx/relative-path-regression-fix.)

 Finishing touches to update the document to adjust to a new option
 "git clean" learned recently.


* kk/tests-with-no-perl (2013-08-24) 4 commits
  (merged to 'next' on 2013-09-09 at 67510b1)
 + reset test: modernize style
 + t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
 + add -i test: use skip_all instead of repeated PERL prerequisite
 + Make test "using invalid commit with -C" more strict

 Some tests were not skipped under NO_PERL build.


* ks/p4-view-spec (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-10 at 8ceb2ec)
 + git p4: implement view spec wildcards with "p4 where"
 + git p4 test: sanitize P4CHARSET

 Replaced with a reroll that was whitespace damaged.


* nd/git-dir-pointing-at-gitfile (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at 5b0a4bf)
 + Make setup_git_env() resolve .git file when $GIT_DIR is not specified

 We made sure that we notice the user-supplied GIT_DIR is actually a
 gitfile, but failed to do so when the default ".git" is a gitfile.


* rh/ishes-doc (2013-09-04) 7 commits
  (merged to 'next' on 2013-09-10 at 3611e8a)
 + glossary: fix and clarify the definition of 'ref'
 + revisions.txt: fix and clarify <rev>^{<type>}
 + glossary: more precise definition of tree-ish (a.k.a. treeish)
 + use 'commit-ish' instead of 'committish'
 + use 'tree-ish' instead of 'treeish'
 + glossary: define commit-ish (a.k.a. committish)
 + glossary: mention 'treeish' as an alternative to 'tree-ish'

 We liberally use "committish" and "commit-ish" (and "treeish" and
 "tree-ish"); as these are non-words, let's unify these terms to
 their dashed form.  More importantly, clarify the documentation on
 object peeling using these terms.


* ss/doclinks (2013-09-06) 1 commit
  (merged to 'next' on 2013-09-10 at 2d029a9)
 + Documentation: make AsciiDoc links always point to HTML files

 When we converted many documents that were traditionally text-only
 to be formatted to AsciiDoc, we did not update links that point at
 them to refer to the formatted HTML files.


* ta/user-manual (2013-08-27) 11 commits
  (merged to 'next' on 2013-09-10 at 1361be1)
 + "git prune" is safe
 + Remove irrelevant reference from "Tying it all together"
 + Remove unnecessary historical note from "Object storage format"
 + Improve section "Merging multiple trees"
 + Improve section "Manipulating branches"
 + Simplify "How to make a commit"
 + Fix some typos and improve wording
 + Use "git merge" instead of "git pull ."
 + Use current output for "git repack"
 + Use current "detached HEAD" message
 + Call it "Git User Manual" and remove reference to very old Git version

 Update the user's manual to more recent versions of Git.


* tb/precompose-autodetect-fix (2013-08-27) 1 commit
  (merged to 'next' on 2013-09-09 at 9bfdac1)
 + Set core.precomposeunicode to true on e.g. HFS+

 On MacOS X, we detected if the filesystem needs the "pre-composed
 unicode strings" workaround, but did not automatically enable it.
 Now we do.


* uh/git-svn-serf-fix (2013-09-06) 1 commit
  (merged to 'next' on 2013-09-13 at d65a9a1)
 + git-svn: fix termination issues for remote svn connections

 "git-svn" used with SVN 1.8.0 when talking over https:// connection
 dumped core due to a bug in the serf library that SVN uses.  Work
 it around on our side, even though the SVN side is being fixed.

--------------------------------------------------
[New Topics]

* es/name-hash-no-trailing-slash-in-dirs (2013-09-17) 4 commits
 - dir: revert work-around for retired dangerous behavior
 - name-hash: stop storing trailing '/' on paths in index_state.dir_hash
 - employ new explicit "exists in index?" API
 - name-hash: refactor polymorphic index_name_exists()

 Clean up the internal of the name-hash mechanism used to work
 around case insensitivity on some filesystems to cleanly fix a
 long-standing API glitch where the caller of cache_name_exists()
 that ask about a directory with a counted string was required to
 have '/' at one location past the end of the string.

 Will merge to 'next'.


* po/dot-url (2013-09-13) 2 commits
 - config doc: update dot-repository notes
 - doc: command line interface (cli) dot-repository dwimmery

 Explain how '.' can be used to refer to the "current repository"
 in the documentation.

 Will merge to 'next'.


* es/contacts-in-subdir (2013-09-17) 1 commit
 - contacts: fix to work in subdirectories

 Allow the contacts (in contrib/) script to run from inside a
 subdirectory.

 Will merge to 'next'.


* jc/upload-pack-send-symref (2013-09-17) 7 commits
 - clone: test the new HEAD detection logic
 - connect: annotate refs with their symref information in get_remote_head()
 - connect.c: make parse_feature_value() static
 - upload-pack: send non-HEAD symbolic refs
 - upload-pack: send symbolic ref information as capability
 - upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 - t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.

 Will merge to 'next'.


* jk/clone-progress-to-stderr (2013-09-18) 3 commits
 - clone: always set transport options
 - clone: treat "checking connectivity" like other progress
 - clone: send diagnostic messages to stderr

 Some progress and diagnostic messages from "git clone" were
 incorrectly sent to the standard output stream, not to the standard
 error stream.

 Will merge to 'next'.


* nd/fetch-pack-error-reporting-fix (2013-09-18) 1 commit
 - fetch-pack.c: show correct command name that fails

 When "fetch-pack" detected an error from spawned "index-pack" or
 "unpack-objects", it did not report the failed program name
 correctly when a shallow repository is involved.

 Will merge to 'next'.


* sg/complete-untracked-filter (2013-09-18) 1 commit
 - completion: improve untracked directory filtering for filename completion

 Will merge to 'next'.


* jc/strcasecmp-pure-inline (2013-09-12) 1 commit
 - mailmap: work around implementations with pure inline strcasecmp

 Work around MinGW <string.h> header that does not declare strcasecmp
 whose address cannot be taken.

 Will merge to 'next'.


* jk/shortlog-tolerate-broken-commit (2013-09-18) 1 commit
 - shortlog: ignore commits with missing authors

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/ref-excludes (2013-09-03) 2 commits
 - document --exclude option
 - revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Needs a matching change to rev-parse.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jx/relative-path-regression-fix (2013-09-13) 3 commits
 - Use simpler relative_path when set_git_dir
 - relative_path should honor dos_drive_prefix
 - test: use unambigous leading path (/foo) for mingw

 Waiting for the review to settle.


* nd/unpack-entry-optim-in-pack-objects (2013-09-13) 1 commit
  (merged to 'next' on 2013-09-17 at 00f7335)
 + pack-objects: no crc check when the cached version is used

 The codepath to use data from packfiles that is only exercised in
 pack-objects unnecessarily checked crc checksum of the pack data,
 even when it ends up using in-core copy that it got by reading from
 the pack (at which point the checksum was validated).

 Will merge to 'master' in the sixth batch.


* jc/checkout-detach-doc (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-17 at 438cf13)
 + checkout: update synopsys and documentation on detaching HEAD

 "git checkout [--detach] <commit>" was listed poorly in the
 synopsis section of its documentation.

 Will merge to 'master' in the sixth batch.


* jk/trailing-slash-in-pathspec (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-17 at 18fe277)
 + reset: handle submodule with trailing slash
 + rm: re-use parse_pathspec's trailing-slash removal

 Code refactoring.

 Will merge to 'master' in the sixth batch.


* kb/msvc-compile (2013-09-11) 5 commits
  (merged to 'next' on 2013-09-17 at a9bcbb5)
 + Windows: do not redefine _WIN32_WINNT
 + MinGW: Fix stat definitions to work with MinGW runtime version 4.0
 + MSVC: fix stat definition hell
 + MSVC: fix compile errors due to macro redefinitions
 + MSVC: fix compile errors due to missing libintl.h

 Build updates for Windows port.

 Will merge to 'master' in the sixth batch.


* lc/filter-branch-too-many-refs (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-17 at 31cd01a)
 + Allow git-filter-branch to process large repositories with lots of branches.

 "git filter-branch" in a repository with many refs blew limit of
 command line length.

 Will merge to 'master' in the sixth batch.


* mm/commit-template-squelch-advice-messages (2013-09-12) 3 commits
  (merged to 'next' on 2013-09-13 at 410d207)
 + commit: disable status hints when writing to COMMIT_EDITMSG
 + wt-status: turn advice_status_hints into a field of wt_status
 + commit: factor status configuration is a helper function

 From the commit log template, remove irrelevant "advice" messages
 that are shared with "git status" output.

 Will merge to 'master' in the fifth batch.


* np/lookup-object-hashing (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-12 at d835ef6)
 + lookup_object: remove hashtable_index() and optimize hash_obj()

 Micro optimize hash function used in the object hash table.

 Will merge to 'master' in the fifth batch.


* bc/http-backend-allow-405 (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-12 at bc1719f)
 + http-backend: provide Allow header for 405

 When the webserver responds with "405 Method Not Allowed", it
 should tell the client what methods are allowed with the "Allow"
 header.

 Will merge to 'master' in the fifth batch.


* dw/check-ignore-sans-index (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-13 at 8daec3c)
 + check-ignore: Add option to ignore index contents

 "git check-ignore" follows the same rule as "git add" and "git
 status" in that the ignore/exclude mechanism does not take effect
 on paths that are already tracked.  With "--no-index" option, it
 can be used to diagnose which paths that should have been ignored
 have been mistakenly added to the index.

 Will merge to 'master' in the fifth batch.


* hu/cherry-pick-previous-branch (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-12 at 36e4d9b)
 + cherry-pick: allow "-" as abbreviation of '@{-1}'

 Just like "git checkout -" knows to check out and "git merge -"
 knows to merge the branch you were previously on, teach "git
 cherry-pick" to understand "-" as the previous branch.

 Will merge to 'master' in the fifth batch.


* jh/checkout-auto-tracking (2013-09-17) 6 commits
  (merged to 'next' on 2013-09-17 at 6748f49)
 + t3200: fix failure on case-insensitive filesystems
  (merged to 'next' on 2013-09-13 at 2aa1553)
 + branch.c: Relax unnecessary requirement on upstream's remote ref name
 + t3200: Add test demonstrating minor regression in 41c21f2
 + Refer to branch.<name>.remote/merge when documenting --track
 + t3200: Minor fix when preparing for tracking failure
 + t2024: Fix &&-chaining and a couple of typos

 Fix a minor regression in v1.8.3.2 and later that made it
 impossible to base your local work on anything but a local branch
 of the upstream repository you are tracking from.

 Will merge to 'master' in the fifth batch.


* jk/upload-pack-keepalive (2013-09-09) 2 commits
  (merged to 'next' on 2013-09-17 at d3141ac)
 + upload-pack: bump keepalive default to 5 seconds
 + upload-pack: send keepalive packets during pack computation

 When running "fetch -q", a long silence while the sender side
 computes the set of objects to send can be mistaken by proxies as
 dropped connection.

 Will merge to 'master' in the fifth batch.


* mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-13 at 82e8b91)
 + rebase: fix run_specific_rebase's use of "return" on FreeBSD

 Work around a bug in FreeBSD shell that caused a regression to "git
 rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
 success report to make sure we didn't miss any other use of a bare
 "return" from dot-sourced script.

 Will merge to 'master' in the fifth batch.


* np/pack-v4 (2013-09-18) 90 commits
 - packv4-parse.c: add tree offset caching
 - t1050: replace one instance of show-index with verify-pack
 - index-pack, pack-objects: allow creating .idx v2 with .pack v4
 - unpack-objects: decode v4 trees
 - unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.


* bk/refs-multi-update (2013-09-11) 8 commits
  (merged to 'next' on 2013-09-13 at e6d21af)
 + update-ref: add test cases covering --stdin signature
 + update-ref: support multiple simultaneous updates
 + refs: add update_refs for multiple simultaneous updates
 + refs: add function to repack without multiple refs
 + refs: factor delete_ref loose ref step into a helper
 + refs: factor update_ref steps into helpers
 + refs: report ref type from lock_any_ref_for_update
 + reset: rename update_refs to reset_refs

 Give "update-refs" a "--stdin" option to read multiple update
 requests and perform them in an all-or-none fashion.

 Will merge to 'master' in the fifth batch.


* fc/at-head (2013-09-12) 2 commits
  (merged to 'next' on 2013-09-13 at d3800c2)
 + Add new @ shortcut for HEAD
 + sha1-name: pass len argument to interpret_branch_name()

 Attempt to resurrect "Type @ for HEAD"; the bottom one seems to be
 a genuine code improvement, but identifying cases where "@" means
 HEAD were harder than it should have been.  I think the result of
 squashing the tip one in covers all the necessary cases.

 Will merge to 'master' in the fifth batch.


* nr/git-cd-to-a-directory (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-13 at 2b07af9)
 + git: run in a directory given with -C option

 Just like "make -C <directory>", make "git -C <directory> ..." to
 go there before doing anything else.

 Will merge to 'master' in the fifth batch.


* rh/peeling-tag-to-tag (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-12 at 3a1d906)
 + peel_onion: do not assume length of x_type globals
 + peel_onion(): add support for <rev>^{tag}

 Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
 "foo" is not a tag.

 Will merge to 'master' in the fifth batch.


* cc/replace-with-the-same-type (2013-09-09) 8 commits
  (merged to 'next' on 2013-09-17 at 34b5bb7)
 + Doc: 'replace' merge and non-merge commits
 + t6050-replace: use some long option names
 + replace: allow long option names
 + Documentation/replace: add Creating Replacement Objects section
 + t6050-replace: add test to clean up all the replace refs
 + t6050-replace: test that objects are of the same type
 + Documentation/replace: state that objects must be of the same type
 + replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.

 Will merge to 'master' in the sixth batch.


* mm/status-without-comment-char (2013-09-17) 7 commits
  (merged to 'next' on 2013-09-17 at d93e7c1)
 + t7508: avoid non-portable sed expression
  (merged to 'next' on 2013-09-12 at 89161b8)
 + status: add missing blank line after list of "other" files
 + tests: don't set status.displayCommentPrefix file-wide
 + status: disable display of '#' comment prefix by default
 + submodule summary: ignore --for-status option
 + wt-status: use argv_array API
 + builtin/stripspace.c: fix broken indentation

 Allow "git status" to omit the prefix to make its output a comment
 in a commit log editor, which is not necessary for human
 consumption.

 We may want to tighten the output to omit unnecessary trailing
 blank lines, but that does not have to be in the scope of this
 series.

 Will merge to 'master' in the fifth batch.


* bc/submodule-status-ignored (2013-09-11) 3 commits
  (merged to 'next' on 2013-09-11 at 9f66712)
 + Improve documentation concerning the status.submodulesummary setting
  (merged to 'next' on 2013-09-10 at a417960)
 + submodule: don't print status output with ignore=all
 + submodule: fix confusing variable name

 Will cook in 'next' a bit.


* sb/repack-in-c (2013-09-17) 3 commits
 - repack: improve warnings about failure of renaming and removing files
 - repack: retain the return value of pack-objects
 - repack: rewrite the shell script in C

 Rerolled, and I think it is in a reasonably good shape.

 Will merge to 'next'.


* jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
  (merged to 'next' on 2013-09-12 at b5c37f4)
 + status: always show tracking branch even no change
 + branch: report invalid tracking branch as gone

 "git branch -v -v" (and "git status") did not distinguish among a
 branch that does not build on any other branch, a branch that is in
 sync with the branch it builds on, and a branch that is configured
 to build on some other branch that no longer exists.

 Will merge to 'master' in the fifth batch.


* nd/fetch-into-shallow (2013-08-28) 7 commits
  (merged to 'next' on 2013-09-09 at 87a3b99)
 + Add testcase for needless objects during a shallow fetch
 + list-objects: mark more commits as edges in mark_edges_uninteresting
 + list-objects: reduce one argument in mark_edges_uninteresting
 + upload-pack: delegate rev walking in shallow fetch to pack-objects
 + shallow: add setup_temporary_shallow()
 + shallow: only add shallow graft points to new shallow file
 + move setup_alternate_shallow and write_shallow_commits to shallow.c

 When there is no sufficient overlap between old and new history
 during a fetch into a shallow repository, we unnecessarily sent
 objects the sending side knows the receiving end has.

 Will merge to 'master' in the fifth batch.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-08-28 at c39bd15)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 This topic has been reverted from 'next'.  Will wait for the
 conclusion of the discussion to seek a more user-friendly
 alternative; it is likely that it will be based on the simpler
 approach Felipe posted earlier.
