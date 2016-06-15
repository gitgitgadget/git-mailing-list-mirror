From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #01; Tue, 2)
Date: Tue, 02 Feb 2016 16:46:12 -0800
Message-ID: <xmqqa8nipqnf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 01:46:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQlaQ-0001im-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 01:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbcBCAqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 19:46:18 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751832AbcBCAqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 19:46:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 833884079E;
	Tue,  2 Feb 2016 19:46:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=6
	E/rpk/z/nS1O81rlfyGxT1q46s=; b=ekDGszW9tGYjrMFnLKZbJ9ci1yerfpoL9
	yNLZ1595yf1EUvSztiY3YG9jwB3dGJqyIv/WzrRLE1bS+ai9Kke5K6ToU4jHjhKL
	54BelXfHp3GOSsQnKG6ESdNujbCwEMHnLiReGxkUOlzjnKphWXkLNOp0b2iXn30x
	Uptdn0vYFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=U+c
	rDFZz71XqqMVjZeFO1QkXRgRBmHUJyia9fxYOunALEwUPgYro22ldY5kaIcZadDn
	QautoQyDtq4PUhv5+ATjT3XXoNK75vCT/ib/jMJsnsnKVxY6vLKKM8uj3i0Evu8s
	CnmQpHHbbi91GfvCnCu0PMr+QXvjIVj27GyAiEOA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 787B14079C;
	Tue,  2 Feb 2016 19:46:14 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2DF440797;
	Tue,  2 Feb 2016 19:46:13 -0500 (EST)
X-master-at: 07c314d22dc8b0a982e76e7498a3f4d384062491
X-next-at: 0765b0dbbbbf563f024948d74efb0d971872c22d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86ACE4AE-CA0F-11E5-A63B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285321>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

I thought we reduced the number of stalled topics due to lack of
reviews reasonably low, but it seems to be increasing again. Help is
greatly appreciated.

On the 'master' front, we have managed to merge enough important
fixes; expect the first maintenance release for 2.7.x series
soonish.  Thanks for all bug reporters, contributors and reviewers.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ew/svn-1.9.0-auth (2016-01-26) 1 commit
  (merged to 'next' on 2016-01-28 at 61a4a8f)
 + git-svn: fix auth parameter handling on SVN 1.9.0+


* jc/strbuf-getline (2016-01-15) 9 commits
  (merged to 'next' on 2016-01-22 at 8c4e051)
 + strbuf: give strbuf_getline() to the "most text friendly" variant
 + checkout-index: there are only two possible line terminations
 + update-index: there are only two possible line terminations
 + check-ignore: there are only two possible line terminations
 + check-attr: there are only two possible line terminations
 + mktree: there are only two possible line terminations
 + strbuf: introduce strbuf_getline_{lf,nul}()
 + strbuf: make strbuf_getline_crlf() global
 + strbuf: miniscule style fix
 (this branch is used by jc/peace-with-crlf.)

 The preliminary clean-up for jc/peace-with-crlf topic.


* jk/filter-branch-no-index (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-22 at 312aa2c)
 + filter-branch: resolve $commit^{tree} in no-index case

 A recent optimization to filter-branch in v2.7.0 introduced a
 regression when --prune-empty filter is used, which has been
 corrected.


* jk/list-tag-2.7-regression (2016-01-26) 2 commits
  (merged to 'next' on 2016-01-26 at fb9ccee)
 + tag: do not show ambiguous tag names as "tags/foo"
 + t6300: use test_atom for some un-modern tests
 (this branch is used by kn/ref-filter-atom-parsing.)

 "git tag" started listing a tag "foo" as "tags/foo" when a branch
 named "foo" exists in the same repository; remove this unnecessary
 disambiguation, which is a regression introduced in v2.7.0.


* jk/sanity (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-22 at 612cc5f)
 + test-lib: clarify and tighten SANITY

 The description for SANITY prerequisite the test suite uses has
 been clarified both in the comment and in the implementation.


* jk/shortlog (2016-01-19) 7 commits
  (merged to 'next' on 2016-01-22 at f1c688c)
 + shortlog: don't warn on empty author
 + shortlog: optimize out useless string list
 + shortlog: optimize out useless "<none>" normalization
 + shortlog: optimize "--summary" mode
 + shortlog: replace hand-parsing of author with pretty-printer
 + shortlog: use strbufs to read from stdin
 + shortlog: match both "Author:" and "author" on stdin

 "git shortlog" used to accumulate various pieces of information
 regardless of what was asked to be shown in the final output.  It
 has been optimized by noticing what need not to be collected
 (e.g. there is no need to collect the log messages when showing
 only the number of changes).


* js/msys2 (2016-01-15) 9 commits
  (merged to 'next' on 2016-01-22 at 8bab6ab)
 + mingw: uglify (a, 0) definitions to shut up warnings
 + mingw: squash another warning about a cast
 + mingw: avoid warnings when casting HANDLEs to int
 + mingw: avoid redefining S_* constants
 + compat/winansi: support compiling with MSys2
 + compat/mingw: support MSys2-based MinGW build
 + nedmalloc: allow compiling with MSys2's compiler
 + config.mak.uname: supporting 64-bit MSys2
 + config.mak.uname: support MSys2
 (this branch is used by js/mingw-tests.)

 Beginning of the upstreaming process of Git for Windows effort.


* tk/interpret-trailers-in-place (2016-01-14) 2 commits
  (merged to 'next' on 2016-01-22 at 5db0cf8)
 + interpret-trailers: add option for in-place editing
 + trailer: allow to write to files other than stdout

 "interpret-trailers" has been taught to optionally update a file in
 place, instead of always writing the result to the standard output.

--------------------------------------------------
[New Topics]

* aw/push-force-with-lease-reporting (2016-02-01) 1 commit
 - push: fix ref status reporting for --force-with-lease

 "git push --force-with-lease" has been taught to report if the push
 needed to force (or fast-forwarded).

 Will merge to 'next'.


* ew/connect-verbose (2016-01-28) 1 commit
 - pass transport verbosity down to git_connect

 There were a few "now I am doing this thing" progress messages in
 the TCP connection code that can be triggered by setting a verbose
 option internally in the code, but "git fetch -v" and friends never
 passed the verbose option down to that codepath.

 There was a brief discussion about the impact on the end-user
 experience by not limiting this to "fetch -v -v", but I think the
 conclusion is that this is OK to enable with a single "-v" as it is
 not too noisy.

 Will merge to 'next'.


* ls/clean-smudge-override-in-config (2016-01-29) 1 commit
 - convert: treat an empty string for clean/smudge filters as "cat"

 Allow clean and smudge filter commands defined in a configuration
 file to be disabled by redefining it to an empty string.

 Will merge to 'next'.


* ah/stripspace-optstring (2016-01-29) 1 commit
 - stripspace: call U+0020 a "space" instead of a "blank"

 Comments?


* dw/mergetool-vim-window-shuffle (2016-01-29) 1 commit
 - mergetool: reorder vim/gvim buffers in three-way diffs

 Comments from real vim/gvim users?


* jk/drop-rsync-transport (2016-02-01) 1 commit
 - transport: drop support for git-over-rsync

 It turns out "git clone" over rsync transport has been broken when
 the source repository has packed references for a long time, and
 nobody noticed nor complained about it.

 Will merge to 'next'.


* jk/options-cleanup (2016-02-01) 6 commits
 - apply, ls-files: simplify "-z" parsing
 - checkout-index: disallow "--no-stage" option
 - checkout-index: handle "--no-index" option
 - checkout-index: handle "--no-prefix" option
 - checkout-index: simplify "-z" option parsing
 - give "nbuf" strbuf a more meaningful name

 Various clean-ups to the command line option parsing.

 Will merge to 'next'.


* dv/http-try-negotiate-at-least-once (2016-02-02) 1 commit
 - remote-curl: don't fall back to Basic auth if we haven't tried Negotiate

 Needs review.


* js/test-lib-windows-emulated-yes (2016-02-02) 1 commit
 - test-lib: limit the output of the yes utility

 The emulated "yes" command used in our test scripts has been
 tweaked not to spend too much time generating unnecessary output
 that is not used, to help those who test on Windows where it would
 not stop until it fills the pipe buffer due to lack of SIGPIPE.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
 Will discard.


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* sb/submodule-parallel-update (2016-01-12) 8 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Needs review.


* dt/refs-backend-lmdb (2016-02-02) 21 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs backend
 - svn: learn ref-storage argument
 - refs: allow ref backend to be set for clone
 - refs: check submodules ref storage config
 - init: allow alternate backends to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: resolve symbolic refs first
 - refs: allow log-only updates
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add methods for the ref iterators
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 (this branch uses sb/submodule-parallel-update; is tangled with sb/submodule-init.)

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 This can now be reviewed and polished as it no longer depends on
 too many topics in flight ;-)

 Needs review.


* lv/add-doc-working-tree (2016-01-21) 1 commit
  (merged to 'next' on 2016-01-26 at c5b1ab1)
 + git-add doc: do not say working directory when you mean working tree

 Will merge to 'master'.


* mk/asciidoctor-bq-workaround (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at 19a742a)
 + Documentation: remove unnecessary backslashes

 Will merge to 'master'.


* nd/diff-with-path-params (2016-01-21) 2 commits
  (merged to 'next' on 2016-01-26 at b29a363)
 + diff: make -O and --output work in subdirectory
 + diff-no-index: do not take a redundant prefix argument

 A few options of "git diff" did not work well when the command was
 run from a subdirectory.

 Will merge to 'master'.


* tb/complete-word-diff-regex (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at a5beecc)
 + completion: complete "diff --word-diff-regex="

 Will merge to 'master'.


* tg/ls-remote-symref (2016-01-19) 5 commits
  (merged to 'next' on 2016-01-26 at e466ee2)
 + ls-remote: add support for showing symrefs
 + ls-remote: use parse-options api
 + ls-remote: fix synopsis
 + ls-remote: document --refs option
 + ls-remote: document --quiet option

 Teach "ls-remote" an option to show which branch the remote
 repository advertises as its primary by pointing its HEAD at.

 Will merge to 'master'.


* jk/ref-cache-non-repository-optim (2016-01-25) 2 commits
  (merged to 'next' on 2016-01-26 at 09057bc)
 + resolve_gitlink_ref: ignore non-repository paths
 + clean: make is_git_repository a public function

 Teach the underlying machinery used by "ls-files -o" and other
 commands not to create empty submodule ref cache for a directory
 that is not a submodule.  This removes a ton of wasted CPU cycles.

 Will merge to 'master'.


* jk/completion-rebase (2016-01-25) 1 commit
  (merged to 'next' on 2016-01-26 at def3e0b)
 + completion: add missing git-rebase options

 Will merge to 'master'.


* pw/completion-show-branch (2016-01-25) 1 commit
  (merged to 'next' on 2016-01-26 at d0d7735)
 + completion: complete show-branch "--date-order"

 Will merge to 'master'.


* js/mingw-tests (2016-01-28) 20 commits
 - mingw: do not bother to test funny file names
 - mingw: skip a test in t9130 that cannot pass on Windows
 - mingw: handle the missing POSIXPERM prereq in t9124
 - mingw: avoid illegal filename in t9118
 - mingw: mark t9100's test cases with appropriate prereqs
 - t0008: avoid absolute path
 - mingw: work around pwd issues in the tests
 - mingw: fix t9700's assumption about directory separators
 - mingw: skip test in t1508 that fails due to path conversion
 - tests: turn off git-daemon tests if FIFOs are not available
 - mingw: disable mkfifo-based tests
 - mingw: accomodate t0060-path-utils for MSYS2
 - mingw: fix t5601-clone.sh
 - mingw: let lstat() fail with errno == ENOTDIR when appropriate
 - mingw: try to delete target directory before renaming
 - mingw: prepare the TMPDIR environment variable for shell scripts
 - mingw: factor out Windows specific environment setup
 - Git.pm: stop assuming that absolute paths start with a slash
 - mingw: do not trust MSYS2's MinGW gettext.sh
 - mingw: let's use gettext with MSYS2

 Updates test scripts to remove assumptions that are not portable
 between Git for POSIX and Git for Windows, or to skip ones with
 expectations that are not satisfiable on Git for Windows.

 Will merge to 'next'.


* js/xmerge-marker-eol (2016-01-27) 2 commits
  (merged to 'next' on 2016-02-01 at 05d91a4)
 + merge-file: ensure that conflict sections match eol style
 + merge-file: let conflict markers match end-of-line style of the context

 The low-level merge machinery has been taught to use CRLF line
 termination when inserting conflict markers to merged contents that
 are themselves CRLF line-terminated.

 Will merge to 'master'.


* nd/clear-gitenv-upon-use-of-alias (2016-02-02) 4 commits
 - restore_env(): free the saved environment variable once we are done
 - git: simplify environment save/restore logic
 - git: protect against unbalanced calls to {save,restore}_env()
 - git: remove an early return from save_env_before_alias()

 The automatic typo correction applied to an alias was broken
 with a recent change already in 'master'.

 Needs review.


* pw/completion-stash (2016-01-26) 1 commit
  (merged to 'next' on 2016-01-26 at e41153c)
 + completion: update completion arguments for stash

 Will merge to 'master'.


* kf/http-proxy-auth-methods (2016-01-26) 2 commits
  (merged to 'next' on 2016-02-01 at b0956b2)
 + http: use credential API to handle proxy authentication
 + http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 Will merge to 'master'.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* jc/peace-with-crlf (2016-01-15) 12 commits
  (merged to 'next' on 2016-01-26 at 08724bc)
 + test-sha1-array: read command stream with strbuf_getline()
 + grep: read -f file with strbuf_getline()
 + send-pack: read list of refs with strbuf_getline()
 + column: read lines with strbuf_getline()
 + cat-file: read batch stream with strbuf_getline()
 + transport-helper: read helper response with strbuf_getline()
 + clone/sha1_file: read info/alternates with strbuf_getline()
 + remote.c: read $GIT_DIR/remotes/* with strbuf_getline()
 + ident.c: read /etc/mailname with strbuf_getline()
 + rev-parse: read parseopt spec with strbuf_getline()
 + revision: read --stdin with strbuf_getline()
 + hash-object: read --stdin-paths with strbuf_getline()

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Will merge to 'master'.


* dg/subtree-test (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-26 at 81f1356)
 + contrib/subtree: Make testing easier

 Will merge to 'master'.


* ls/travis-prove-order (2016-01-26) 2 commits
  (merged to 'next' on 2016-01-26 at d8e2a4a)
 + travis-ci: explicity use container-based infrastructure
 + travis-ci: run previously failed tests first, then slowest to fastest

 By persisting runtime statistics of previous "prove" run, execute
 tests that take longer before other ones, to reduce the total
 wallclock time when running with Travis CI.

 Will merge to 'master'.


* nd/do-not-move-worktree-manually (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at c539221)
 + worktree: stop supporting moving worktrees manually
 + worktree.c: fix indentation

 "git worktree" had a broken code that attempted to auto-fix
 possible inconsistency that results from end-users moving a
 worktree to different places without telling Git (the original
 repository needs to maintain backpointers to its worktrees, but
 "mv" run by end-users who are not familiar with that fact will
 obviously not adjust them), which actually made things worse
 when triggered.

 Will merge to 'master'.


* sb/submodule-init (2016-01-28) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with dt/refs-backend-lmdb.)

 Major part of "git submodule init" has been ported to C.

 Will have to wait for 'sb/submodule-parallel-update'.


* js/dirname-basename (2016-01-25) 6 commits
  (merged to 'next' on 2016-01-26 at b16b2b8)
 + mingw: avoid linking to the C library's isalpha()
  (merged to 'next' on 2016-01-20 at d198512)
 + t0060: loosen overly strict expectations
  (merged to 'next' on 2016-01-12 at c3c970a)
 + t0060: verify that basename() and dirname() work as expected
 + compat/basename.c: provide a dirname() compatibility function
 + compat/basename: make basename() conform to POSIX
 + Refactor skipping DOS drive prefixes

 dirname() emulation has been added, as Msys2 lacks it.

 Will merge to 'master'.


* wp/sha1-name-negative-match (2016-02-01) 2 commits
 - object name: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "<branch>^{/!-<pattern>}" notation to name a commit
 reachable from <branch> that does not match the given <pattern>.

 Will merge to 'next'.


* jk/notes-merge-from-anywhere (2016-01-17) 1 commit
  (merged to 'next' on 2016-01-26 at c60ac66)
 + notes: allow merging from arbitrary references

 "git notes merge" used to limit the source of the merged notes tree
 to somewhere under refs/notes/ hierarchy, which was too limiting
 when inventing a workflow to exchange notes with remote
 repositories using remote-tracking notes trees (located in e.g.
 refs/remote-notes/ or somesuch).

 Will merge to 'master'.


* dt/unpack-compare-entry-optim (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at 110e053)
 + unpack-trees: fix accidentally quadratic behavior
  (merged to 'next' on 2016-01-20 at 180dccf)
 + do_compare_entry: use already-computed path

 "git checkout $branch" (and other operations that share the same
 underlying machinery) has been optimized.

 Will merge to 'master'.


* cc/untracked (2016-01-27) 11 commits
  (merged to 'next' on 2016-02-01 at 8203631)
 + t7063: add tests for core.untrackedCache
 + test-dump-untracked-cache: don't modify the untracked cache
 + config: add core.untrackedCache
 + dir: simplify untracked cache "ident" field
 + dir: add remove_untracked_cache()
 + dir: add {new,add}_untracked_cache()
 + update-index: move 'uc' var declaration
 + update-index: add untracked cache notifications
 + update-index: add --test-untracked-cache
 + update-index: use enum for untracked cache options
 + dir: free untracked cache when removing it

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".

 Will merge to 'master'.


* dw/subtree-split-do-not-drop-merge (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at 3cfefef)
 + contrib/subtree: fix "subtree split" skipped-merge bug

 The "split" subcommand of "git subtree" (in contrib/) incorrectly
 skipped merges when it shouldn't, which was corrected.

 Will merge to 'master'.


* kn/ref-filter-atom-parsing (2016-02-02) 12 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: align: introduce long-form syntax
 - ref-filter: introduce align_atom_parser()
 - ref-filter: introduce parse_align_position()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: introduce parsing functions for each valid atom
 - ref-filter: introduce struct used_atom
 - ref-filter: bump 'used_atom' and related code to the top
 - ref-filter: use strbuf_split_str_omit_term()
 - strbuf: introduce strbuf_split_str_omit_term()

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.


* tb/ls-files-eol (2016-01-18) 1 commit
  (merged to 'next' on 2016-01-26 at bc9246f)
 + ls-files: add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 Will merge to 'master'.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, the change needs to be backed up by numbers.

 Needs review.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-01-21) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Needs further work on forget/gc.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)

--------------------------------------------------
[Discarded]

* bb/merge-marker-crlf (2015-11-24) 1 commit
 . merge-file: consider core.crlf when writing merge markers

 Resurrected as 'js/xmerge-maker-eol'.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 . sh-setup: make require_clean_work_tree() work on orphan branches
 . Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.
 ($gmane/284488)
