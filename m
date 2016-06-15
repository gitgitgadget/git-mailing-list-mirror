From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2016, #06; Mon, 22)
Date: Mon, 22 Feb 2016 14:18:51 -0800
Message-ID: <xmqq60xg5qyc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:19:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyon-0001uG-5V
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbcBVWS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:18:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755877AbcBVWSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:18:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AAE4747AC6;
	Mon, 22 Feb 2016 17:18:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=b
	whkdAAEBtO/SmjuZlAhvTS/MAw=; b=AozGw084IJZSKYXqR4wLvw3ao11E5JMcY
	f13vlCVd/9n6udC8LkWmTqpmm44TAA6+7s5SmHPEu19FBBd8OdGnzExhMPFRrg3/
	Yz8AxBJF3jW/F9bk9xDUxVY7Tx0l6SKNS2etg38U2XCZmKrnP4u9y8/soXZVfCw9
	/uq0K4QseY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=mYc
	U+S4BJyxmoucni0gXK90cDwd9WdirP1EDBK7Crg8ZMIMXwkbNzDxn4NOMIN6fmeU
	G1GiIfrQBy3UCsxhVmtngqvNZ8RgEdMcmFTy/3BUbTTmlCebqXdlqX+lpRWa23gS
	SLWH/BPuo/QzHlrujevHs2kohrOVuyMzq+RTAcA4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A2A9C47AC5;
	Mon, 22 Feb 2016 17:18:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3AA847AC1;
	Mon, 22 Feb 2016 17:18:52 -0500 (EST)
X-master-at: 70bd996071bf724a7b151c81a165e8837179d6d7
X-next-at: 5fe9e24d37736b932d9f6fc17afbc616cde818a3
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4168939A-D9B2-11E5-878E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286962>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

I originally penciled in -rc0 for today, but let's give a handful of
topics that are cooking in 'next' a few more time and merge them to
'master' before doing so.  On the 'maint' front, there is 2.7.2 out,
that merges the fixes accumulated on 'master' so far.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ew/connect-verbose (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at 5555b13)
 + t5570: add tests for "git {clone,fetch,pull} -v"

 A missing test for a recent feature has been added.


* jk/config-include (2016-02-13) 1 commit
  (merged to 'next' on 2016-02-18 at 8491d55)
 + git-config: better document default behavior for `--include`

 A belated documentation update clarifies the interaction between
 "--file", "--include" and "[include] path = $over_there".


* js/git-remote-add-url-insteadof-test (2016-02-17) 1 commit
  (merged to 'next' on 2016-02-18 at ef1d82e)
 + t5505: 'remote add x y' should work when url.y.insteadOf = x

 A missing test for a rather old change has been added.

--------------------------------------------------
[New Topics]

* sb/submodule-init (2016-02-19) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update; is tangled with dt/refs-backend-lmdb.)


* ak/extract-argv0-last-dir-sep (2016-02-19) 1 commit
 - exec_cmd.c: use find_last_dir_sep() for code simplification

 Code simplification.

 Will merge to 'next'.


* az/p4-bare-no-rebase (2016-02-19) 1 commit
 - git-p4.py: Don't try to rebase on submit from bare repository

 "git p4 submit" attempts to do a rebase, which would fail if done
 in a bare repository.  Not doing this rebase would paper over the
 failure, which is what this patch does, but it is unclear what the
 side effect of not rebasing is.

 Needs a better explanation.


* ak/git-strip-extension-from-dashed-command (2016-02-21) 1 commit
 - git.c: simplify stripping extension of a file in handle_builtin()

 Code simplification.

 Will merge to 'next'.


* jk/grep-binary-workaround-in-test (2016-02-21) 2 commits
 - t9200: avoid grep on non-ASCII data
 - t8005: avoid grep on non-ASCII data

 Will see a reroll.


* mg/work-tree-tests (2016-02-20) 1 commit
 - tests: rename work-tree tests to *work-tree*

 Traditionally, the tests that try commands that work on the
 contents in the working tree were named with "worktree" in their
 filenames, but with the recent addition of "git worktree"
 subcommand, whose tests are also named similarly, it has become
 harder to tell them apart.  The traditional tests have been renamed
 to use "work-tree" instead in an attempt to differentiate them.


* jk/more-comments-on-textconv (2016-02-22) 1 commit
 - diff: clarify textconv interface

 The memory ownership rule of fill_textconv() API, which was a bit
 tricky, has been documented a bit better.

 Will merge to 'next'.

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

* cn/deprecate-ssh-git-url (2016-02-15) 1 commit
 - Disown ssh+git and git+ssh

 Needs toning down by replacing the condescendence with an
 explanation and enlightenment.
 ($gmane/286222)


* nd/git-common-dir-fix (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-18 at 957afc5)
 + rev-parse: take prefix into account in --git-common-dir

 "git rev-parse --git-common-dir" used in the worktree feature
 misbehaved when run from a subdirectory.

 Will merge to 'master'.


* sp/remote-curl-ssl-strerror (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at 1339fe4)
 + remote-curl: include curl_errorstr on SSL setup failures

 Help those who debug http(s) part of the system.

 Will merge to 'master'.


* bc/http-empty-auth (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at 6d2fc88)
 + http: add option to try authentication without username

 Some authentication methods do not need username or password, but
 libcurl needs some hint that it needs to perform authentication.
 Supplying an empty username and password string is a valid way to
 do so, but you can set the http.[<url>.]emptyAuth configuration
 variable to achieve the same, if you find it cleaner.

 Will merge to 'master'.


* ce/https-public-key-pinning (2016-02-15) 1 commit
  (merged to 'next' on 2016-02-18 at f382cf0)
 + http: implement public key pinning

 You can now set http.[<url>.]pinnedpubkey to specify the pinned
 public key when building with recent enough versions of libcURL.

 Will merge to 'master'.


* fa/merge-recursive-no-rename (2016-02-22) 4 commits
 - merge-recursive: find-renames resets threshold
 - merge-strategies.txt: fix typo
  (merged to 'next' on 2016-02-18 at dd6125b)
 + merge-recursive: more consistent interface
 + merge-recursive: option to disable renames

 "git merge-recursive" learned "--no-renames" option to disable its
 rename detection logic.


* jc/am-i-v-fix (2016-02-17) 3 commits
  (merged to 'next' on 2016-02-18 at 331e518)
 + am -i: fix "v"iew
 + pager: factor out a helper to prepare a child process to run the pager
 + pager: lose a separate argv[]

 The "v(iew)" subcommand of the interactive "git am -i" command was
 broken in 2.6.0 timeframe when the command was rewritten in C.

 Will merge to 'master'.


* jk/merge-tree-merge-blobs (2016-02-16) 1 commit
 - merge_blobs: use strbuf instead of manually-sized mmfile_t

 "git merge-tree" (a throw-away demonstration) did not work very
 well when merging "both sides added a new file at the same path"
 case.

 Undecided; we might be better off deleting it altogether.


* jk/tighten-alloc (2016-02-19) 21 commits
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
 - prepare_{git,shell}_cmd: use argv_array
 - use st_add and st_mult for allocation size computation
 - convert trivial cases to FLEX_ARRAY macros
 - use xmallocz to avoid size arithmetic
 - convert trivial cases to ALLOC_ARRAY
 - convert manual allocations to argv_array
 - add helpers for allocating flex-array structs
 - harden REALLOC_ARRAY and xcalloc against size_t overflow
 - tree-diff: catch integer overflow in combine_diff_path allocation
 - add helpers for detecting size_t overflow
 - reflog_expire_cfg: NUL-terminate pattern field

 Update various codepaths to avoid manually-counted malloc().


* nd/dwim-wildcards-as-pathspecs (2016-02-10) 3 commits
  (merged to 'next' on 2016-02-18 at fc7caf4)
 + get_sha1: don't die() on bogus search strings
 + check_filename: tighten dwim-wildcard ambiguity
 + checkout: reorder check_filename conditional

 "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
 rev, i.e. the object named by the the pathname with wildcard
 characters in a tree object.

 Will merge to 'master'.


* nd/exclusion-regression-fix (2016-02-15) 4 commits
  (merged to 'next' on 2016-02-18 at 85412ab)
 + dir.c: don't exclude whole dir prematurely
 + dir.c: support marking some patterns already matched
 + dir.c: support tracing exclude
 + dir.c: fix match_pathname()

 Another try to add support to the ignore mechanism that lets you
 say "this is excluded" and then later say "oh, no, this part (that
 is a subset of the previous part) is not excluded".

 Will merge to 'master'.


* nd/worktree-add-B (2016-02-15) 2 commits
  (merged to 'next' on 2016-02-18 at bf77016)
 + worktree add -B: do the checkout test before update branch
 + worktree: fix "add -B"

 "git worktree add -B <branchname>" did not work.

 Will merge to 'master'.


* ps/config-error (2016-02-22) 15 commits
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

 Will merge to 'next'.


* ss/commit-dry-run-resolve-merge-to-no-op (2016-02-17) 1 commit
 - wt-status.c: set commitable bit if there is a meaningful merge.

 "git commit --dry-run" reported "No, no, you cannot commit." in one
 case where "git commit" would have allowed you to commit, and this
 improves it a little bit ("git commit --dry-run --short" still does
 not give you the correct answer, for example).


* tg/git-remote (2016-02-16) 4 commits
  (merged to 'next' on 2016-02-18 at 091d43e)
 + remote: use remote_is_configured() for add and rename
 + remote: actually check if remote exits
 + remote: simplify remote_is_configured()
 + remote: use parse_config_key

 The internal API to interact with "remote.*" configuration
 variables has been streamlined.

 Will merge to 'master'.


* ls/config-origin (2016-02-22) 4 commits
 - config: add '--show-origin' option to print the origin of a config value
 - config: add 'origin_type' to config_source struct
 - rename git_config_from_buf to git_config_from_mem
 - t: do not hide Git's exit code in tests using 'nul_to_q'

 The configuration system has been taught to phrase where it found a
 bad configuration variable in a better way in its error messages.
 "git config" learnt a new "--show-origin" option to indicate where
 the values come from.

 Will merge to 'next'.


* ew/force-ipv4 (2016-02-12) 1 commit
  (merged to 'next' on 2016-02-18 at d0211b0)
 + connect & http: support -4 and -6 switches for remote operations

 "git fetch" and friends that make network connections can now be
 told to only use ipv4 (or ipv6).

 Will merge to 'master'.


* jk/lose-name-path (2016-02-12) 5 commits
  (merged to 'next' on 2016-02-18 at 85831a6)
 + list-objects: pass full pathname to callbacks
 + list-objects: drop name_path entirely
 + list-objects: convert name_path to a strbuf
 + show_object_with_name: simplify by using path_name()
 + http-push: stop using name_path

 The "name_path" API was an attempt to reduce the need to construct
 the full path out of a series of path components while walking a
 tree hierarchy, but over time made less efficient because the path
 needs to be flattened, e.g. to be compared with another path that
 is already flat.  The API has been removed and its users have been
 rewritten to simplify the overall code complexity.

 Will merge to 'master'.


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

 Comments?
 ($gmane/286137)


* tb/conversion (2016-02-21) 7 commits
 - convert.c: correct attr_action()
  (merged to 'next' on 2016-02-12 at 6faf27b)
 + convert.c: simplify text_stat
 + convert.c: refactor crlf_action
 + convert.c: use text_eol_is_crlf()
 + convert.c: remove input_crlf_action()
 + convert.c: remove unused parameter 'path'
 + t0027: add tests for get_stream_filter()


* sb/submodule-parallel-update (2016-02-19) 7 commits
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


* dt/refs-backend-lmdb (2016-02-19) 28 commits
 - tests: add ref-storage argument
 - refs: tests for lmdb backend
 - refs: add LMDB refs storage backend
 - refs: add register_ref_storage_backends()
 - svn: learn ref-storage argument
 - clone: allow ref storage backend to be set for clone
 - refs: check submodules' ref storage config
 - init: allow alternate ref strorage to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: resolve symbolic refs first
 - refs: on symref reflog expire, lock symref not referrent
 - refs: don't dereference on rename
 - refs: allow log-only updates
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: forbid cross-backend ref renames
 - refs: add method to rename refs
 - refs: add methods to init refs db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add method for do_for_each_ref
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions
 - refs: move for_each_*ref* functions into common code
 - refs: move head_ref{,_submodule} to the common code
 - Merge branch 'sb/submodule-parallel-update' into dt/refs-backend-lmdb
 (this branch uses sb/submodule-parallel-update; is tangled with sb/submodule-init.)

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 ($gmane/286572)


* kn/ref-filter-atom-parsing (2016-02-17) 11 commits
  (merged to 'next' on 2016-02-18 at 9606218)
 + ref-filter: introduce objectname_atom_parser()
 + ref-filter: introduce contents_atom_parser()
 + ref-filter: introduce remote_ref_atom_parser()
 + ref-filter: align: introduce long-form syntax
 + ref-filter: introduce align_atom_parser()
 + ref-filter: introduce parse_align_position()
 + ref-filter: introduce color_atom_parser()
 + ref-filter: introduce parsing functions for each valid atom
 + ref-filter: introduce struct used_atom
 + ref-filter: bump 'used_atom' and related code to the top
 + ref-filter: use string_list_split over strbuf_split

 The ref-filter's format-parsing code has been refactored, in
 preparation for "branch --format" and friends.

 Will merge to 'master'.


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


* ep/format-printf (2016-02-11) 22 commits
 . wt-status.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . utf8.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . transport-helper.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . trace.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . strbuf.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . remote.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . pkt-line.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . merge-recursive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . imap-send.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . http-backend.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . fsck.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . daemon.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . config.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . color.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . cache.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/upload-archive.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/update-index.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/receive-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . builtin/index-pack.c: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . argv-array.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . advice.h: use the FORMAT_PRINTF macro to declare the gcc function attribute 'format printf'
 . git-compat-util.h: add the FORMAT_PRINTF macro

 Replace __attribute__((format(printf, a, b))) with
 FORMAT_PRINTF(a,b) everywhere in the code.

 It would be a different story if another compiler had the same
 feature implemented using a different syntax, in which case we
 could use conditionally #define what FORMAT_PRINTF(a,b) expands to,
 but because we do not have such a compiler supported, this change
 is a net negative, churning the code without buying us anything
 (yet).
