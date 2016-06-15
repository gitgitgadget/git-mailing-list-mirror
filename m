From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Tue, 02 Sep 2014 15:06:58 -0700
Message-ID: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 00:07:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOwEK-0005LE-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 03 Sep 2014 00:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbaIBWHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 18:07:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59245 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbaIBWHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 18:07:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8956836867;
	Tue,  2 Sep 2014 18:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	L0ieNKT0qU0sR5P/uSBVJJHuTg=; b=Vhen0TmqT6j5llqacSdRhLZa/hFHttLCm
	s0CVjjPRwtGEj9RgbHGznQWDC0PHG4b+HMRztqG57Decw2LxmHJ3yB0HuAXYNaNf
	EWhCckCjjHrdzFxDKwcVJCvp5eivxqJvp5IXFKzlnICi0rCukGpnxChcFUeOy+nj
	KV7KVj3CPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qq2
	bb6yVjAw4lvYCTT/fgHnCSemLawqjxr+DWqoLsRx/6nHH/vt1qp2ayWO8HaaEBgI
	z6knaZy6y3C8teqi2n5MZLwwr69wAO/myPlZblyTJOb/TV/J8Rd7DflHnDBx2vE5
	yL1mxqEVF2uXb4w2v2rKuk3v+MDH8HrbNO2yXurk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4261536866;
	Tue,  2 Sep 2014 18:07:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1598936863;
	Tue,  2 Sep 2014 18:07:00 -0400 (EDT)
X-master-at: 85f083786fe37f280ca30fc0b74498b22b322c6d
X-next-at: 7c4bc81ba6302d4dd40821b46578580afbcdf4b5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7647A08C-32ED-11E4-A849-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256371>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The first batch of topics have graduated to 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/archive-pax-header-mode (2014-08-04) 1 commit
  (merged to 'next' on 2014-08-26 at 51fca1a)
 + archive: honor tar.umask even for pax headers

 Originally merged to 'next' on 2014-08-13

 Implementations of "tar" that do not understand an extended pax
 header would extract the contents of it in a regular file; make
 sure the permission bits of this file follows the same tar.umask
 configuration setting.


* jc/reopen-lock-file (2014-07-14) 1 commit
  (merged to 'next' on 2014-08-26 at c5a5a12)
 + lockfile: allow reopening a closed but still locked file

 Originally merged to 'next' on 2014-07-21

 Needed in the "commit -p" code path to update the cache tree in the
 index (e.g. for dt/cache-tree-repair topic).


* jk/pretty-empty-format (2014-07-30) 3 commits
  (merged to 'next' on 2014-08-26 at 1eb7cc3)
 + pretty: make empty userformats truly empty
 + pretty: treat "--format=" as an empty userformat
 + revision: drop useless string offset when parsing "--pretty"

 Originally merged to 'next' on 2014-08-13

 "git log --pretty/format=" with an empty format string did not mean
 the more obvious "No output whatsoever" but "Use default format",
 which was counterintuitive.


* mm/config-edit-global (2014-07-25) 3 commits
  (merged to 'next' on 2014-08-26 at 3a47fc5)
 + commit: advertise config --global --edit on guessed identity
 + home_config_paths(): let the caller ignore xdg path
 + config --global --edit: create a template file if needed

 Originally merged to 'next' on 2014-07-31

 Start "git config --edit --global" from a skeletal per-user
 configuration file contents, instead of a total blank, when the
 user does not already have any.  This immediately reduces the need
 for a later "Have you forgotten setting core.user?" and we can add
 more to the template as we gain more experience.


* pr/remotes-in-hashmap (2014-07-30) 1 commit
  (merged to 'next' on 2014-08-26 at 2052a31)
 + use a hashmap to make remotes faster

 Originally merged to 'next' on 2014-08-13

 Optimize remotes configuration look-up in a repository with very
 many remotes defined.


* rs/init-no-duplicate-real-path (2014-07-28) 1 commit
  (merged to 'next' on 2014-08-26 at c66e1c4)
 + init: avoid superfluous real_path() calls

 Originally merged to 'next' on 2014-07-31


* rs/strbuf-getcwd (2014-08-26) 10 commits
  (merged to 'next' on 2014-08-26 at 11be0d6)
 + use strbuf_add_absolute_path() to add absolute paths
 + abspath: convert absolute_path() to strbuf
 + use xgetcwd() to set $GIT_DIR
 + use xgetcwd() to get the current directory or die
 + wrapper: add xgetcwd()
 + abspath: convert real_path_internal() to strbuf
 + abspath: use strbuf_getcwd() to remember original working directory
 + setup: convert setup_git_directory_gently_1 et al. to strbuf
 + unix-sockets: use strbuf_getcwd()
 + strbuf: add strbuf_getcwd()
 (this branch is tangled with nd/lock-paths-absolute.)

 Originally merged to 'next' on 2014-08-18

 Reduce the use of fixed sized buffer passed to getcwd() calls
 by introducing xgetcwd() helper.


* ta/config-set (2014-07-29) 2 commits
  (merged to 'next' on 2014-08-26 at 81395f9)
 + test-config: add tests for the config_set API
 + add `config_set` API for caching config-like files
 (this branch is used by ta/config-set-1 and ta/config-set-2.)

 Originally merged to 'next' on 2014-08-13

 Add in-core caching layer to let us avoid reading the same
 configuration files number of times.


* ta/pretty-parse-config (2014-08-04) 1 commit
  (merged to 'next' on 2014-08-26 at 901e8c2)
 + pretty.c: make git_pretty_formats_config return -1 on git_config_string failure

 Originally merged to 'next' on 2014-08-13

--------------------------------------------------
[New Topics]

* bb/date-iso-strict (2014-08-29) 1 commit
 - pretty: provide a strict ISO 8601 date format


* jk/commit-author-parsing (2014-08-29) 6 commits
 - determine_author_info(): copy getenv output
 - determine_author_info(): reuse parsing functions
 - date: use strbufs in date-formatting functions
 - record_author_date(): use find_commit_header()
 - record_author_date(): fix memory leak on malformed commit
 - commit: provide a function to find a header in a buffer


* jk/contrib-subtree-make-all (2014-08-18) 1 commit
 - subtree: make "all" default target of Makefile


* jk/fast-export-anonymize (2014-08-28) 2 commits
 - docs/fast-export: explain --anonymize more completely
 - teach fast-export an --anonymize option


* jk/index-pack-threading-races (2014-08-29) 1 commit
 - index-pack: fix race condition with duplicate bases


* jk/send-pack-many-refspecs (2014-08-26) 1 commit
 - send-pack: take refspecs over stdin


* jp/index-with-corrupt-stages (2014-08-29) 2 commits
 - read_index_unmerged(): remove unnecessary loop index adjustment
 - read_index_from(): catch out of order entries when reading an index file


* jt/timer-settime (2014-08-29) 9 commits
 - use timer_settime() for new platforms
 - autoconf: check for timer_settime()
 - autoconf: check for struct itimerspec
 - autoconf: check for struct sigevent
 - autoconf: check for struct timespec
 - autoconf: check for timer_t
 - autoconf: check for setitimer()
 - autoconf: check for struct itimerval
 - git-compat-util.h: add missing semicolon after struct itimerval

 Need a rerolled one.


* mb/build-contrib-svn-fe (2014-08-28) 1 commit
 - contrib/svn-fe: fix Makefile


* mb/fast-import-delete-root (2014-08-29) 2 commits
 - fast-import: fix segfault in store_tree()
 - t9300: test filedelete command


* mm/discourage-commit-a-to-finish-conflict-resolution (2014-08-28) 1 commit
 - merge, pull: stop advising 'commit -a' in case of conflict


* sp/pack-protocol-doc-on-shallow (2014-08-28) 1 commit
  (merged to 'next' on 2014-08-29 at b1ae451)
 + Document LF appearing in shallow command during send-pack/receive-pack

 Will merge to 'master'.


* ah/grammofix (2014-09-02) 1 commit
 - grammofix in user-facing messages


* da/styles (2014-09-02) 1 commit
 - stylefix: asterisks stick to the variable, not the type


* da/use-rev-parse-verify-quiet-in-stash (2014-09-02) 1 commit
 - stash: prefer --quiet over shell redirection


* mk/reachable-protect-detached-head (2014-09-02) 2 commits
 - SQUASH???
 - reachable.c: add HEAD to reachability starting commits


* rs/furhter-uses-of-skip-prefix (2014-09-02) 2 commits
 - pack-write: simplify index_pack_lockfile using skip_prefix() and xstrfmt()
 - connect: simplify check_ref() using skip_prefix() and starts_with()


* rs/merge-tree-simplify (2014-09-02) 1 commit
 - merge-tree: remove unused df_conflict arguments


* rs/simplify-config-include (2014-09-02) 1 commit
 - config: simplify git_config_include()


* rs/simplify-http-walker (2014-09-02) 1 commit
 - http-walker: simplify process_alternates_response() using strbuf


* tb/crlf-tests (2014-09-02) 3 commits
 - MinGW: update tests to handle a native eol of crlf
 - Makefile: propagate NATIVE_CRLF to C
 - t0027: Tests for core.eol=native, eol=lf, eol=crlf

--------------------------------------------------
[Stalled]

* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


* nd/multiple-work-trees (2014-07-29) 39 commits
 . checkout --to: do not touch existing target directory
 . checkout: prefix --to argument properly when cwd is moved
 . environment.c: fix incorrect git_graft_file initialization
 . checkout --to: fix dangling pointers in remove_junk()
 . checkout: no auto-detach if the ref is already checked out
 . prune --repos: fix uninitialized access
 . checkout: no need to call check_linked_checkouts if head_ref is NULL
 . gitrepository-layout.txt: s/ignored/ignored if/
 . checkout: don't require a work tree when checking out into a new one
 . git_path(): keep "info/sparse-checkout" per work-tree
 . count-objects: report unused files in $GIT_DIR/repos/...
 . gc: support prune --repos
 . gc: factor out gc.pruneexpire parsing code
 . gc: style change -- no SP before closing parenthesis
 . prune: strategies for linked checkouts
 . checkout: detach if the branch is already checked out elsewhere
 . checkout: clean up half-prepared directories in --to mode
 . checkout: support checking out into a new working directory
 . use new wrapper write_file() for simple file writing
 . wrapper.c: wrapper to open a file, fprintf then close
 . setup.c: support multi-checkout repo setup
 . setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 . setup.c: convert check_repository_format_gently to use strbuf
 . setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 . setup.c: convert is_git_directory() to use strbuf
 . git-stash: avoid hardcoding $GIT_DIR/logs/....
 . *.sh: avoid hardcoding $GIT_DIR/hooks/...
 . git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 . $GIT_COMMON_DIR: a new environment variable
 . commit: use SEQ_DIR instead of hardcoding "sequencer"
 . fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 . reflog: avoid constructing .lock path with git_path
 . *.sh: respect $GIT_INDEX_FILE
 . git_path(): be aware of file relocation in $GIT_DIR
 . path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 . path.c: rename vsnpath() to do_git_path()
 . git_snpath(): retire and replace with strbuf_git_path()
 . path.c: make get_pathname() call sites return const char *
 . path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Reroll posted, but haven't picked up yet.  How would this interact
 with rr/transaction series which is pretty much all about the refs?


* cb/mergetool-difftool (2014-07-21) 2 commits
 - difftool: don't assume that default sh is sane
 - mergetool: don't require a work tree for --tool-help

 Update the way the "difftool --help" shows the help message that is
 shared with the "mergetool" to reduce one shell dependency.

 Will be rerolled.


* rr/mergetool-temporary-filename-tweak (2014-08-21) 1 commit
 - Allow the user to change the temporary file name for mergetool

 Needs rerolling (new paragraph in doc seems to be in a wrong place)


* jk/tag-contains (2014-06-30) 8 commits
 . perf: add tests for tag --contains
 . tag: use commit_contains
 . commit: provide a fast multi-tip contains function
 . string-list: add pos to iterator callback
 . add functions for memory-efficient bitmaps
 . paint_down_to_common: use prio_queue
 . tag: factor out decision to stream tags
 . tag: allow --sort with -n

 Expecting a reroll.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* rh/prompt-tests (2014-06-05) 11 commits
 - t9904: new __git_ps1 tests for Zsh
 - test-lib: make it possible to override how test code is eval'd
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Expecting a reroll to limit the damage to test_eval_; also reported
 to be broken with older zsh that are still in the field ($gmane/251231).


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

 Reroll exists, but haven't had time to pick it up yet.


* mh/lockfile (2014-04-15) 25 commits
 . trim_last_path_elm(): replace last_path_elm()
 . resolve_symlink(): take a strbuf parameter
 . resolve_symlink(): use a strbuf for internal scratch space
 . change lock_file::filename into a strbuf
 . commit_lock_file(): use a strbuf to manage temporary space
 . try_merge_strategy(): use a statically-allocated lock_file object
 . try_merge_strategy(): remove redundant lock_file allocation
 . struct lock_file: declare some fields volatile
 . lockfile: avoid transitory invalid states
 . commit_lock_file(): die() if called for unlocked lockfile object
 . commit_lock_file(): inline temporary variable
 . remove_lock_file(): call rollback_lock_file()
 . lock_file(): exit early if lockfile cannot be opened
 . write_packed_entry_fn(): convert cb_data into a (const int *)
 . prepare_index(): declare return value to be (const char *)
 . delete_ref_loose(): don't muck around in the lock_file's filename
 . cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 . lockfile.c: document the various states of lock_file objects
 . lock_file(): always add lock_file object to lock_file_list
 . hold_lock_file_for_append(): release lock on errors
 . lockfile: unlock file if lockfile permissions cannot be adjusted
 . rollback_lock_file(): set fd to -1
 . rollback_lock_file(): do not clear filename redundantly
 . api-lockfile: expand the documentation
 . unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ta/config-add-to-empty-or-true-fix (2014-08-18) 1 commit
  (merged to 'next' on 2014-08-29 at d219212)
 + make config --add behave correctly for empty and NULL values

 We may want to undo the "a^" bit along the lines of $gmane/255445


* et/spell-poll-infinite-with-minus-one-only (2014-08-22) 1 commit
 - upload-pack: keep poll(2)'s timeout to -1

 We used to pass -1000 to poll(2), expecting it to also mean "no
 timeout", which should be spelled as -1.

 Will merge to 'next'.


* jk/make-simplify-dependencies (2014-08-26) 3 commits
 - Makefile: drop CHECK_HEADER_DEPENDENCIES code
 - Makefile: use `find` to determine static header dependencies
 - i18n: treat "make pot" as an explicitly-invoked target

 Admit that keeping LIB_H up-to-date, only for those that do not use
 the automatically generated dependencies, is a losing battle, and
 make it conservative by making everything depend on anything.

 Will merge to 'next'.


* jk/prompt-stash-could-be-packed (2014-08-25) 1 commit
  (merged to 'next' on 2014-08-29 at 526e3bd)
 + git-prompt: do not look for refs/stash in $GIT_DIR

 The prompt script checked $GIT_DIR/ref/stash file to see if there
 is a stash, which was a no-no.

 Will merge to 'master'.


* jk/prune-top-level-refs-after-packing (2014-08-25) 1 commit
 - pack-refs: prune top-level refs like "refs/foo"

 After "pack-refs --prune" packed refs at the top-level, it failed
 to prune them.

 Will merge to 'next'.


* jk/fast-import-fixes (2014-08-25) 2 commits
 - fast-import: fix buffer overflow in dump_tags
 - fast-import: clean up pack_data pointer in end_packfile

 With sufficiently long refnames, fast-import could have overflown
 an on-stack buffer.

 Will merge to 'next'.


* nd/fetch-pass-quiet-to-gc-child-process (2014-08-18) 2 commits
 - fetch: silence git-gc if --quiet is given
 - fetch: convert argv_gc_auto to struct argv_array

 Progress output from "git gc --auto" was visible in "git fetch -q".

 Will merge to 'next'.


* rs/list-optim (2014-08-25) 2 commits
 - walker: avoid quadratic list insertion in mark_complete
 - sha1_name: avoid quadratic list insertion in handle_one_ref

 Fix a couple of "accumulate into a sorted list" to "accumulate and
 then sort the list".

 Will merge to 'next'.


* sb/mailsplit-dead-code-removal (2014-08-13) 1 commit
  (merged to 'next' on 2014-08-29 at 4f9ca4f)
 + mailsplit.c: remove dead code

 Will merge to 'master'.


* tb/pretty-format-cd-date-format (2014-08-21) 1 commit
  (merged to 'next' on 2014-08-29 at ab8ccd4)
 + pretty: note that %cd respects the --date= option

 Documentation update.

 Will merge to 'master'.


* jk/name-decoration-alloc (2014-08-27) 3 commits
 - log-tree: use FLEX_ARRAY in name_decoration
 - log-tree: make name_decoration hash static
 - log-tree: make add_name_decoration a public function

 The API to allocate the structure to keep track of commit
 decoration was cumbersome to use, inviting lazy code to
 overallocate memory.

 Will merge to 'next'.


* br/http-init-fix (2014-08-21) 2 commits
 - http: style fixes for curl_multi_init error check
 - http.c: die if curl_*_init fails

 Will merge to 'next'.


* br/imap-send-simplify-tunnel-child-process (2014-09-02) 3 commits
 - imap-send: simplify v_issue_imap_cmd() and get_cmd_result() using starts_with()
 - imap-send.c: imap_folder -> imap_server_conf.folder
 - git-imap-send: simplify tunnel construction

 Will merge to 'next'.


* jc/config-mak-document-darwin-vs-macosx (2014-08-15) 1 commit
  (merged to 'next' on 2014-08-29 at 55e28af)
 + config.mak.uname: add hint on uname_R for MacOS X
 (this branch uses km/no-apple-common-crypto-on-darwin-8-and-below.)

 Will merge to 'master'.


* jn/unpack-trees-checkout-m-carry-deletion (2014-08-25) 3 commits
 - checkout -m: attempt merge when deletion of path was staged
 - unpack-trees: use 'cuddled' style for if-else cascade
 - unpack-trees: simplify 'all other failures' case

 Will merge to 'next'.


* km/no-apple-common-crypto-on-darwin-8-and-below (2014-08-15) 1 commit
  (merged to 'next' on 2014-08-29 at 8abb416)
 + config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems
 (this branch is used by jc/config-mak-document-darwin-vs-macosx.)

 Build automation for older versions of MacOS X.

 Will merge to 'master'.


* nd/large-blobs (2014-08-18) 5 commits
 - diff: shortcut for diff'ing two binary SHA-1 objects
 - diff --stat: mark any file larger than core.bigfilethreshold binary
 - diff.c: allow to pass more flags to diff_populate_filespec
 - sha1_file.c: do not die failing to malloc in unpack_compressed_entry
 - wrapper.c: introduce gentle xmallocz that does not die()

 Will merge to 'next'.


* nd/mv-code-cleaning (2014-08-11) 9 commits
 - SQUASH???
 - mv: no SP between function name and the first opening parenthese
 - mv: combine two if(s)
 - mv: unindent one level for directory move code
 - mv: move index search code out
 - mv: remove an "if" that's always true
 - mv: split submodule move preparation code out
 - mv: flatten error handling code block
 - mv: mark strings for translations

 SQUASH!!! Will merge to 'next'.


* nd/strbuf-utf8-replace (2014-08-11) 1 commit
  (merged to 'next' on 2014-08-29 at 5d1ddf4)
 + utf8.c: fix strbuf_utf8_replace() consuming data beyond input string

 Will merge to 'master'.


* rs/clean-menu-item-defn (2014-08-18) 1 commit
  (merged to 'next' on 2014-08-29 at 88c1a9d)
 + clean: use f(void) instead of f() to declare a pointer to a function without arguments

 Will merge to 'master'.


* rs/inline-compat-path-macros (2014-08-18) 1 commit
  (merged to 'next' on 2014-08-29 at 5705ad5)
 + turn path macros into inline function

 Will merge to 'master'.


* rs/refresh-beyond-symlink (2014-08-10) 1 commit
  (merged to 'next' on 2014-08-29 at 90a4a8b)
 + read-cache: check for leading symlinks when refreshing index

 "git add x" where x that used to be a directory has become a
 symbolic link to a directory misbehaved.

 Will merge to 'master'.


* sb/blame-msg-i18n (2014-08-12) 1 commit
  (merged to 'next' on 2014-08-29 at 5b33466)
 + builtin/blame.c: add translation to warning about failed revision walk

 Will merge to 'master'.


* sb/plug-leaks (2014-08-10) 2 commits
  (merged to 'next' on 2014-08-29 at e42f0b8)
 + clone.c: don't leak memory in cmd_clone
 + remote.c: don't leak the base branch name in format_tracking_info

 Will merge to 'master'.


* sb/prepare-revision-walk-error-check (2014-08-12) 1 commit
  (merged to 'next' on 2014-08-29 at fb82508)
 + prepare_revision_walk(): check for return value in all places

 Will merge to 'master'.


* so/rebase-doc (2014-08-12) 1 commit
  (merged to 'next' on 2014-08-29 at 77cfce1)
 + Documentation/git-rebase.txt: -f forces a rebase that would otherwise be a no-op

 May need description on what makes various modes of operation to
 decide that the request can become a "no-op".

 Will merge to 'master'.


* sp/stream-clean-filter (2014-08-28) 6 commits
 - convert: stream from fd to required clean filter to reduce used address space
 - copy_fd(): do not close the input file descriptor
 - mmap_limit: introduce GIT_MMAP_LIMIT to allow testing expected mmap size
 - memory_limit: use git_env_ulong() to parse GIT_ALLOC_LIMIT
 - config.c: add git_env_ulong() to parse environment variable
 - convert: drop arguments other than 'path' from would_convert_to_git()

 Rerolled.


* jc/push-cert (2014-08-25) 20 commits
 - signed push: fortify against replay attacks
 - signed-push: add "pushee" header to push certificate
 - signed push: remove duplicated protocol info
 - send-pack: send feature request on push-cert packet
 - receive-pack: GPG-validate push certificates
 - the beginning of the signed push
 - pack-protocol doc: typofix for PKT-LINE
 - gpg-interface: move parse_signature() to where it should be
 - gpg-interface: move parse_gpg_output() to where it should be
 - send-pack: clarify that cmds_sent is a boolean
 - send-pack: refactor inspecting and resetting status and sending commands
 - send-pack: rename "new_refs" to "need_pack_data"
 - send-pack: factor out capability string generation
 - send-pack: always send capabilities
 - send-pack: refactor decision to send update per ref
 - send-pack: move REF_STATUS_REJECT_NODELETE logic a bit higher
 - receive-pack: factor out queueing of command
 - receive-pack: do not reuse old_sha1[] for other things
 - receive-pack: parse feature request a bit earlier
 - receive-pack: do not overallocate command structure

 Allow "git push" request to be signed, so that it can be verified
 audited, using the GPG signature of the person who pushed, that the
 tips of branches at a public repository really point the commits
 the pusher wanted to, without having to "trust" the server.

 The tip two feels still a bit slushy, but otherwise should be
 reasonably solid to build upon.


* rs/child-process-init (2014-08-20) 4 commits
 - run-command: inline prepare_run_command_v_opt()
 - run-command: call run_command_v_opt_cd_env() instead of duplicating it
 - run-command: introduce child_process_init()
 - run-command: introduce CHILD_PROCESS_INIT

 Will merge to 'next'.


* tf/imap-send-create (2014-08-25) 2 commits
  (merged to 'next' on 2014-08-29 at 8390945)
 + imap-send: create target mailbox if it is missing
 + imap-send: clarify CRAM-MD5 vs LOGIN documentation

 Will merge to 'master'.


* bc/imap-send-doc (2014-08-05) 1 commit
  (merged to 'next' on 2014-08-29 at 2ea514b)
 + imap-send doc: omit confusing "to use imap-send" modifier

 Will merge to 'master'.


* jc/apply-ws-prefix (2014-08-07) 3 commits
  (merged to 'next' on 2014-08-29 at 67967d3)
 + apply: omit ws check for excluded paths
 + apply: hoist use_patch() helper for path exclusion up
 + apply: use the right attribute for paths in non-Git patches

 Applying a patch not generated by Git in a subdirectory used to
 check the whitespace breakage using the attributes for incorrect
 paths. Also whitespace checks were performed even for paths
 excluded via "git apply --exclude=<path>" mechanism.

 Will merge to 'master'.


* jk/command-line-config-empty-string (2014-08-05) 1 commit
  (merged to 'next' on 2014-08-29 at 74f04af)
 + config: teach "git -c" to recognize an empty string

 "git -c section.var command" and "git -c section.var= command"
 should pass the configuration differently (the former should be
 a boolean true, the latter should be an empty string).

 Will merge to 'master'.


* la/init-doc (2014-08-08) 7 commits
  (merged to 'next' on 2014-08-29 at 2cf846b)
 + Documentation: git-init: flesh out example
 + Documentation: git-init: template directory: reword and cross-reference
 + Documentation: git-init: reword parenthetical statements
 + Documentation: git-init: --separate-git-dir: clarify
 + Documentation: git-init: template directory: reword
 + Documentation: git-init: list items facelift
 + Documentation: git-init: typographical fixes

 Will merge to 'master'.


* lf/bundle-exclusion (2014-08-07) 1 commit
  (merged to 'next' on 2014-08-29 at d84b102)
 + bundle: fix exclusion of annotated tags

 Will merge to 'master'.


* mm/log-branch-desc-plug-leak (2014-08-07) 1 commit
  (merged to 'next' on 2014-08-29 at 3580add)
 + builtin/log.c: fix minor memory leak

 Will merge to 'master'.


* ta/config-set-1 (2014-08-07) 8 commits
 - add tests for `git_config_get_string_const()`
 - add a test for semantic errors in config files
 - rewrite git_config() to use the config-set API
 - config: add `git_die_config()` to the config-set API
 - change `git_config()` return value to void
 - add line number and file name info to `config_set`
 - config.c: fix accuracy of line number in errors
 - config.c: mark error and warnings strings for translation
 (this branch is used by ta/config-set-2.)

 Will merge to 'next'.


* ta/config-set-2 (2014-08-13) 15 commits
 - builtin/apply.c: replace `git_config()` with `git_config_get_string_const()`
 - merge-recursive.c: replace `git_config()` with `git_config_get_int()`
 - ll-merge.c: refactor `read_merge_config()` to use `git_config_string()`
 - fast-import.c: replace `git_config()` with `git_config_get_*()` family
 - branch.c: replace `git_config()` with `git_config_get_string()
 - alias.c: replace `git_config()` with `git_config_get_string()`
 - imap-send.c: replace `git_config()` with `git_config_get_*()` family
 - pager.c: replace `git_config()` with `git_config_get_value()`
 - builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
 - rerere.c: replace `git_config()` with `git_config_get_*()` family
 - fetchpack.c: replace `git_config()` with `git_config_get_*()` family
 - archive.c: replace `git_config()` with `git_config_get_bool()` family
 - read-cache.c: replace `git_config()` with `git_config_get_*()` family
 - http-backend.c: replace `git_config()` with `git_config_get_bool()` family
 - daemon.c: replace `git_config()` with `git_config_get_bool()` family
 (this branch uses ta/config-set-1.)

 Will merge to 'next'.


* jk/stash-list-p (2014-08-07) 1 commit
  (merged to 'next' on 2014-08-29 at db94527)
 + stash: default listing to working-tree diff

 Teach "git stash list -p" to show the difference between the base
 commit version and the working tree version, which is in line with
 what "git show" gives.

 Will merge to 'master'.


* rs/ref-transaction-multi (2014-08-27) 6 commits
 - ### rs/ref-transaction-multi
 - refs.c: make the *_packed_refs functions static
 - refs.c: make repack_without_refs static
 - remote.c: use a transaction for deleting refs
 - refs.c: write updates to packed refs when a transaction has more than one ref
 - refs.c: move reflog updates into its own function
 (this branch uses rs/ref-transaction, rs/ref-transaction-1, rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Follow-up on rs/ref-transaction series to use the packed-ref to
 achieve atomicity when multiple refs are involved.

 No more nitpicks and better design suggestions?


* rs/ref-transaction-rename (2014-08-27) 6 commits
 - ### rs/ref-transaction-rename
 - refs.c: rollback the lockfile before we die() in repack_without_refs
 - refs.c: update rename_ref to use a transaction
 - refs.c: use packed refs when deleting refs during a transaction
 - refs.c: return error instead of dying when locking fails during transaction
 - refs.c: allow passing raw git_committer_info as email to _update_reflog
 (this branch is used by rs/ref-transaction-multi; uses rs/ref-transaction, rs/ref-transaction-1 and rs/ref-transaction-reflog.)

 Follow-up on rs/ref-transaction series to make renaming a ref
 transactional (i.e. "delete old and create new" should not leave
 an in-between state behind when it fails).

 No more nitpicks and better design suggestions?


* rs/ref-transaction-reflog (2014-08-27) 16 commits
 - ### rs/ref-transaction-reflog
 - refs.c: allow deleting refs with a broken sha1
 - refs.c: remove lock_any_ref_for_update
 - refs.c: make unlock_ref/close_ref/commit_ref static
 - refs.c: rename log_ref_setup to create_reflog
 - reflog.c: use a reflog transaction when writing during expire
 - refs.c: allow multiple reflog updates during a single transaction
 - refs.c: only write reflog update if msg is non-NULL
 - refs.c: add a flag to allow reflog updates to truncate the log
 - refs.c: add a transaction function to append a reflog entry
 - lockfile.c: make hold_lock_file_for_append preserve meaningful errno
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: add a new update_type field to ref_update
 - refs.c: rename the transaction functions
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-multi and rs/ref-transaction-rename; uses rs/ref-transaction and rs/ref-transaction-1.)

 Cover updates to reflog with the same transaction mechanism as used
 for reflog manipulations.

 No more nitpicks and better design suggestions?


* jc/not-mingw-cygwin (2014-07-21) 2 commits
  (merged to 'next' on 2014-08-29 at 0d00bb7)
 + test prerequisites: enumerate with commas
 + test prerequisites: eradicate NOT_FOO

 We have been using NOT_{MINGW,CYGWIN} test prerequisites long
 before Peff invented support for negated prerequisites e.g. !MINGW
 and we still add more uses of the former.  Convert them to the
 latter to avoid confusion.

 Will merge to 'master'.


* rs/ref-transaction-1 (2014-08-27) 20 commits
 - refs.c: make delete_ref use a transaction
 - refs.c: make prune_ref use a transaction to delete the ref
 - refs.c: remove lock_ref_sha1
 - refs.c: remove the update_ref_write function
 - refs.c: remove the update_ref_lock function
 - refs.c: make lock_ref_sha1 static
 - walker.c: use ref transaction for ref updates
 - fast-import.c: use a ref transaction when dumping tags
 - receive-pack.c: use a reference transaction for updating the refs
 - refs.c: change update_ref to use a transaction
 - branch.c: use ref transaction for all ref updates
 - fast-import.c: change update_branch to use ref transactions
 - sequencer.c: use ref transactions for all ref updates
 - commit.c: use ref transactions for updates
 - replace.c: use the ref transaction functions for updates
 - tag.c: use ref transactions when doing updates
 - refs.c: add transaction.status and track OPEN/CLOSED
 - refs.c: make ref_transaction_begin take an err argument
 - refs.c: update ref_transaction_delete to check for error and return status
 - refs.c: change ref_transaction_create to do error checking and return status
 (this branch is used by rs/ref-transaction, rs/ref-transaction-multi, rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 The second batch of the transactional ref update series.
 A hopefully final reroll exists but haven't picked it up yet.


* dt/cache-tree-repair (2014-09-02) 5 commits
 - cache-tree: propagate invalidation up when punting
  (merged to 'next' on 2014-08-26 at 6faccdb)
 + cache-tree: Write updated cache-tree after commit
 + cache-tree: subdirectory tests
 + test-dump-cache-tree: invalid trees are not errors
 + cache-tree: create/update cache-tree on checkout

 Originally merged to 'next' on 2014-07-21

 Add a few more places in "commit" and "checkout" that make sure
 that the cache-tree is fully populated in the index.

 The tip one is a proposed fix for $gmane/256285, but it is not
 quite right yet.


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu'.


* rs/ref-transaction (2014-08-27) 14 commits
 - ### rs/ref-transaction
 - refs.c: fix handling of badly named refs
 - refs.c: make write_ref_sha1 static
 - fetch.c: change s_update_ref to use a ref transaction
 - refs.c: propagate any errno==ENOTDIR from _commit back to the callers
 - refs.c: pass a skip list to name_conflict_fn
 - refs.c: call lock_ref_sha1_basic directly from commit
 - refs.c: move the check for valid refname to lock_ref_sha1_basic
 - refs.c: pass NULL as *flags to read_ref_full
 - refs.c: pass the ref log message to _create/delete/update instead of _commit
 - refs.c: add an err argument to delete_ref_loose
 - wrapper.c: add a new function unlink_or_msg
 - wrapper.c: simplify warn_if_unremovable
 - ### rs/ref-transaction-1
 (this branch is used by rs/ref-transaction-multi, rs/ref-transaction-reflog and rs/ref-transaction-rename; uses rs/ref-transaction-1.)


* jc/test-lazy-prereq (2014-06-13) 1 commit
 - tests: drop GIT_*_TIMING_TESTS environment variable support

 Test-script clean-up.

 Will hold.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Will hold.
