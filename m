From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #05; Wed, 17)
Date: Wed, 17 Feb 2016 14:34:08 -0800
Message-ID: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 23:34:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWAfq-0006Ek-3E
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423897AbcBQWeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 17:34:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423442AbcBQWeK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 17:34:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F92C43C9A;
	Wed, 17 Feb 2016 17:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=a
	3P1Kb1f3zuv3Rbxy9E3QLraOUo=; b=J6wJub8cRFgcNFxxn8TJHfJRmDqv+aqXN
	loqRtZM+vnxpB+MvRD2oUQQE6TbV/5VcR5H795nH7OCUNGNL4/f0oYHSY9Dv1DGt
	qmeXE0OKm3w/sPiGGwkKA+VPxxJsS7yUZVDgNAjq0nNuzFJxlX7gWlrASQtNh/Au
	Z/UXdbk1Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=QcI
	bCEUW8C2XJYxP60CAXwo3lqENceR4vzLYdFWSbXGWFanqkD31y3KbWoDjVmUfTQO
	bnL7AtcmoLm1Z46ti2qEzCJjWtVXVY4y09PrKsEozNmNk9XYJ7zj/t07C1He92H5
	r/+XgBhVM8gcJIZjvIvz8EXdbciLcPqaJHn9+/aU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0676343C99;
	Wed, 17 Feb 2016 17:34:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 491C843C97;
	Wed, 17 Feb 2016 17:34:09 -0500 (EST)
X-master-at: 0233b800c838ddda41db318ee396320b3c21a560
X-next-at: 45cd78e6c697b37c226f619775990486cf53e84f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F8A501C-D5C6-11E5-AD2E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286564>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

There are a few undecided topics among the ones that are queued.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/stripspace-optstring (2016-01-29) 1 commit
  (merged to 'next' on 2016-02-12 at cd021aa)
 + stripspace: call U+0020 a "space" instead of a "blank"


* da/user-useconfigonly (2016-02-08) 2 commits
  (merged to 'next' on 2016-02-09 at 8b303ce)
 + ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
 + fmt_ident: refactor strictness checks

 The "user.useConfigOnly" configuration variable can be used to
 force the user to always set user.email & user.name configuration
 variables, serving as a reminder for those who work on multiple
 projects and do not want to put these in their $HOME/.gitconfig.


* dw/mergetool-vim-window-shuffle (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-12 at 2a2e8bd)
 + mergetool: reorder vim/gvim buffers in three-way diffs

 The vimdiff backend for "git mergetool" has been tweaked to arrange
 and number buffers in the order that would match the expectation of
 majority of people who read left to right, then top down and assign
 buffers 1 2 3 4 "mentally" to local base remote merge windows based
 on that order.


* jk/drop-rsync-transport (2016-02-01) 1 commit
  (merged to 'next' on 2016-02-03 at 08be402)
 + transport: drop support for git-over-rsync

 It turns out "git clone" over rsync transport has been broken when
 the source repository has packed references for a long time, and
 nobody noticed nor complained about it.


* jk/rerere-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at ff9ade3)
 + rerere: replace strcpy with xsnprintf
 (this branch is used by jc/rerere-multi.)

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in "git rerere" that are already safe has been
 rewritten to avoid false wanings.


* jk/test-path-utils-xsnprintf (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-09 at 931f70b)
 + test-path-utils: use xsnprintf in favor of strcpy

 Some calls to strcpy(3) triggers a false warning from static
 analysers that are less intelligent than humans, and reducing the
 number of these false hits helps us notice real issues.  A few
 calls to strcpy(3) in test-path-utils that are already safe has
 been rewritten to avoid false wanings.


* js/mingw-tests (2016-02-08) 21 commits
  (merged to 'next' on 2016-02-08 at 417e555)
 + gitignore: ignore generated test-fake-ssh executable
  (merged to 'next' on 2016-02-03 at ace7624)
 + mingw: do not bother to test funny file names
 + mingw: skip a test in t9130 that cannot pass on Windows
 + mingw: handle the missing POSIXPERM prereq in t9124
 + mingw: avoid illegal filename in t9118
 + mingw: mark t9100's test cases with appropriate prereqs
 + t0008: avoid absolute path
 + mingw: work around pwd issues in the tests
 + mingw: fix t9700's assumption about directory separators
 + mingw: skip test in t1508 that fails due to path conversion
 + tests: turn off git-daemon tests if FIFOs are not available
 + mingw: disable mkfifo-based tests
 + mingw: accomodate t0060-path-utils for MSYS2
 + mingw: fix t5601-clone.sh
 + mingw: let lstat() fail with errno == ENOTDIR when appropriate
 + mingw: try to delete target directory before renaming
 + mingw: prepare the TMPDIR environment variable for shell scripts
 + mingw: factor out Windows specific environment setup
 + Git.pm: stop assuming that absolute paths start with a slash
 + mingw: do not trust MSYS2's MinGW gettext.sh
 + mingw: let's use gettext with MSYS2
 (this branch is used by mg/mingw-test-fix.)

 Test scripts have been updated to remove assumptions that are not
 portable between Git for POSIX and Git for Windows, or to skip ones
 with expectations that are not satisfiable on Git for Windows.


* mg/mingw-test-fix (2016-02-08) 1 commit
  (merged to 'next' on 2016-02-12 at df77956)
 + t9100: fix breakage when SHELL_PATH is not /bin/sh
 (this branch uses js/mingw-tests.)

 An earlier adjustment of test mistakenly used write_script
 to prepare a file whose exact content matters for the test;
 reverting that part fixes the breakage for those who use
 SHELL_PATH that is different from /bin/sh.


* mm/clean-doc-fix (2016-02-09) 1 commit
  (merged to 'next' on 2016-02-09 at ced8555)
 + Documentation/git-clean.txt: don't mention deletion of .git/modules/*

 The documentation for "git clean" has been corrected; it mentioned
 that .git/modules/* are removed by giving two "-f", which has never
 been the case.


* nd/clear-gitenv-upon-use-of-alias (2016-02-02) 4 commits
  (merged to 'next' on 2016-02-09 at 2c441b4)
 + restore_env(): free the saved environment variable once we are done
 + git: simplify environment save/restore logic
 + git: protect against unbalanced calls to {save,restore}_env()
 + git: remove an early return from save_env_before_alias()

 The automatic typo correction applied to an alias was broken
 with a recent change already in 'master'.

--------------------------------------------------
[New Topics]

* cn/deprecate-ssh-git-url (2016-02-15) 1 commit
 - Disown ssh+git and git+ssh

 Needs toning down by replacing the condescendence with an
 explanation and enlightenment.
 ($gmane/286222)


* jk/config-include (2016-02-13) 1 commit
 - git-config: better document default behavior for `--include`

 Will merge to 'next'.


* nd/git-common-dir-fix (2016-02-12) 1 commit
 - rev-parse: take prefix into account in --git-common-dir

 Will merge to 'next'.


* sp/remote-curl-ssl-strerror (2016-02-15) 1 commit
 - remote-curl: include curl_errorstr on SSL setup failures

 Help those who debug http(s) part of the system.

 Will merge to 'next'.


* bc/http-empty-auth (2016-02-15) 1 commit
 - http: add option to try authentication without username

 Some authentication methods do not need username or password, but
 libcurl needs some hint that it needs to perform authentication.
 Supplying an empty username and password string is a valid way to
 do so, but you can set the http.[<url>.]emptyAuth configuration
 variable to achieve the same, if you find it cleaner.

 Will merge to 'next'.


* ce/https-public-key-pinning (2016-02-15) 1 commit
 - http: implement public key pinning

 You can now set http.[<url>.]pinnedpubkey to specify the pinned
 public key when building with recent enough versions of libcURL.

 Will merge to 'next'.


* ew/connect-verbose (2016-02-15) 1 commit
 - t5570: add tests for "git {clone,fetch,pull} -v"

 Will merge to 'next'.


* fa/merge-recursive-no-rename (2016-02-17) 2 commits
 - merge-recursive: more consistent interface
 - merge-recursive: option to disable renames

 "git merge-recursive" learned "--no-renames" option to disable its
 rename detection logic.

 Will merge to 'next'.


* jc/am-i-v-fix (2016-02-17) 3 commits
 - am -i: fix "v"iew
 - pager: factor out a helper to prepare a child process to run the pager
 - pager: lose a separate argv[]

 The "v(iew)" subcommand of the interactive "git am -i" command was
 broken in 2.6.0 timeframe when the command was rewritten in C.

 Will merge to 'next'.


* jk/merge-tree-merge-blobs (2016-02-16) 1 commit
 - merge_blobs: use strbuf instead of manually-sized mmfile_t

 "git merge-tree" (a throw-away demonstration) did not work very
 well when merging "both sides added a new file at the same path"
 case.

 Undecided; we might be better off deleting it altogether.


* jk/tighten-alloc (2016-02-15) 18 commits
 - ewah: convert to REALLOC_ARRAY, etc
 - convert ewah/bitmap code to use xmalloc
 - diff_populate_gitlink: use a strbuf
 - transport_anonymize_url: use xstrfmt
 - git-compat-util: drop mempcpy compat code
 - sequencer: simplify memory allocation of get_message
 - test-path-utils: fix normalize_path_copy output buffer size
 - fetch-pack: simplify add_sought_entry
 - fast-import: simplify allocation in start_packfile
 - write_untracked_extension: use FLEX_ALLOC helper
 - use st_add and st_mult for allocation size computation
 - convert trivial cases to FLEX_ARRAY macros
 - use xmallocz to avoid size arithmetic
 - convert trivial cases to ALLOC_ARRAY
 - add helpers for allocating flex-array structs
 - harden REALLOC_ARRAY and xcalloc against size_t overflow
 - tree-diff: catch integer overflow in combine_diff_path allocation
 - add helpers for detecting size_t overflow

 Update various codepaths to avoid manually-counted malloc().

 Will merge to 'next'.


* js/git-remote-add-url-insteadof-test (2016-02-17) 1 commit
 - t5505: 'remote add x y' should work when url.y.insteadOf = x

 Will merge to 'next'.


* nd/dwim-wildcards-as-pathspecs (2016-02-10) 3 commits
 - get_sha1: don't die() on bogus search strings
 - check_filename: tighten dwim-wildcard ambiguity
 - checkout: reorder check_filename conditional

 "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
 rev, i.e. the object named by the the pathname with wildcard
 characters in a tree object.

 I lost track of this topic; did we decide that this is a good thing
 to do, or unnecessary noise to only cater to a crazy use case?


* nd/exclusion-regression-fix (2016-02-15) 4 commits
 - dir.c: don't exclude whole dir prematurely
 - dir.c: support marking some patterns already matched
 - dir.c: support tracing exclude
 - dir.c: fix match_pathname()

 Another try to add support to the ignore mechanism that lets you
 say "this is excluded" and then later say "oh, no, this part (that
 is a subset of the previous part) is not exlucded".

 Will merge to 'next'.


* nd/worktree-add-B (2016-02-15) 2 commits
 - worktree add -B: do the checkout test before update branch
 - worktree: fix "add -B"

 "git worktree add -B <branchname>" did not work.

 Will merge to 'next'.


* ps/config-error (2016-02-17) 16 commits
 - SQUASH
 - config: rename git_config_set_or_die to git_config_set
 - config: rename git_config_set to git_config_set_gently
 - compat: die when unable to set core.precomposeunicode
 - sequencer: die on config error when saving replay opts
 - init-db: die on config errors when initializing empty repo
 - clone: die on config error in cmd_clone
 - remote: die on config error when manipulating remotes
 - remote: die on config error when setting/adding branches
 - remote: die on config error when setting URL
 - submodule--helper: die on config error when cloning module
 - submodule: die on config error when linking modules
 - branch: die on config error when editing branch description
 - branch: die on config error when unsetting upstream
 - branch: report errors in tracking branch setup
 - config: introduce set_or_die wrappers

 Many codepaths forget to check return value from git_config_set();
 the function is made to die() to make sure we do not proceed when
 setting a configuration variable failed.

 Need to squash the tip two commits into one before moving forward.


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
 - wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).


* tg/git-remote (2016-02-16) 4 commits
 - remote: use remote_is_configured() for add and rename
 - remote: actually check if remote exits
 - remote: simplify remote_is_configured()
 - remote: use parse_config_key

 The internal API to interact with "remote.*" configuration
 variables has been streamlined.

 Will merge to 'next'.


* ls/config-origin (2016-02-17) 3 commits
 - config: add '--show-origin' option to print the origin of a config value
 - config: add 'type' to config_source struct that identifies config type
 - t: do not hide Git's exit code in tests using 'nul_to_q'

--------------------------------------------------
[Stalled]

* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


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

* ep/format-printf (2016-02-11) 22 commits
 - wt-status.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - utf8.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - transport-helper.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - trace.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - strbuf.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - remote.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - pkt-line.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - merge-recursive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - imap-send.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - http-backend.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - fsck.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - daemon.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - config.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - color.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - cache.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/upload-archive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/update-index.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/receive-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - builtin/index-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - argv-array.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - advice.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 - git-compat-util.h: add the FORMAT_PRINTF macro

 Undecided.


* ew/force-ipv4 (2016-02-12) 1 commit
 - connect & http: support -4 and -6 switches for remote operations

 "git fetch" and friends that make network connections can now be
 told to only use ipv4 (or ipv6).

 Will merge to 'next'.


* jk/lose-name-path (2016-02-12) 5 commits
 - list-objects: pass full pathname to callbacks
 - list-objects: drop name_path entirely
 - list-objects: convert name_path to a strbuf
 - show_object_with_name: simplify by using path_name()
 - http-push: stop using name_path

 The "name_path" API was an attempt to reduce the need to construct
 the full path out of a series of path components while walking a
 tree hierarchy, but over time made less efficient because the path
 needs to be flattened, e.g. to be compared with another path that
 is already flat.  Remove the API and rewrite its users to simplify
 overall code complexity.

 Will merge to 'next'.


* nd/icase (2016-02-15) 12 commits
 - grep.c: reuse "icase" variable
 - diffcore-pickaxe: support case insensitive match on non-ascii
 - diffcore-pickaxe: "share" regex error handling code
 - grep/pcre: support utf-8
 - gettext: add is_utf8_locale()
 - grep/pcre: prepare locale-dependent tables for icase matching
 - grep/icase: avoid kwsset when -F is specified
 - grep/icase: avoid kwsset on literal non-ascii strings
 - test-regex: expose full regcomp() to the command line
 - test-regex: isolate the bug test code
 - grep: break down an "if" stmt in preparation for next changes
 - grep: allow -F -i combination

 "git grep -i" has been taught to fold case in non-ascii locales.

 ($gmane/286137)


* tb/conversion (2016-02-10) 6 commits
  (merged to 'next' on 2016-02-12 at 6faf27b)
 + convert.c: simplify text_stat
 + convert.c: refactor crlf_action
 + convert.c: use text_eol_is_crlf()
 + convert.c: remove input_crlf_action()
 + convert.c: remove unused parameter 'path'
 + t0027: add tests for get_stream_filter()

 Will be rerolled.
 ($gmane/286219)


* sb/submodule-parallel-update (2016-02-13) 7 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - submodule update: direct error message to stderr
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch is used by dt/refs-backend-lmdb and sb/submodule-init.)

 A major part of "git submodule update" has been ported to C to take
 advantage of the recently added framework to run download tasks in
 parallel.

 Comments?


* dt/refs-backend-lmdb (2016-02-13) 22 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs storage backend
 - refs: add register_ref_storage_backends()
 - svn: learn ref-storage argument
 - clone: allow ref storage backend to be set for clone
 - refs: check submodules ref storage config
 - init: allow alternate ref strorage to be set for new repos
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

 Will be rerolled.
 ($gmane/285604)


* kn/ref-filter-atom-parsing (2016-02-17) 11 commits
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
 - ref-filter: use string_list_split over strbuf_split

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 Will merge to 'next'.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-02-08) 7 commits
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

* dv/http-try-negotiate-at-least-once (2016-02-02) 1 commit
 . remote-curl: don't fall back to Basic auth if we haven't tried Negotiate

 bc/http-empty-auth satisfies the original need that triggered this
 topic better.
