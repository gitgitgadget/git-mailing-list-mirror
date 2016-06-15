From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2014, #05; Fri, 19)
Date: Fri, 19 Sep 2014 16:03:54 -0700
Message-ID: <xmqq7g0zmcv9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 01:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XV7Di-0001sB-SZ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Sep 2014 01:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbaISXEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 19:04:02 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63155 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020AbaISXD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 19:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 955583C43F;
	Fri, 19 Sep 2014 19:03:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	iST9VTzI0q1wICGBaVvoy16RZM=; b=Y5MIN0Rx23pKEdOTLUIgA1MvDfzPpsbDD
	DLxSrxWcp1Rf5hItkPK/VGcoqA4CDUf2KXEEhLVY5XFahmAuojYJ9riKEi1DFtED
	X/OFLg2LHzm7Zg083nwbZx6cAWMuReA8pI0iVesPEgjSZA+R1DPleqJDsCmTN2pz
	Q74ukiVH90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=RgL
	Rn/XYyZcwatssrEv7hf3UiQZxhy1/VZiS/C6YfWHI3gs1wejk84O8B58DKMedXx+
	N5mSBOVP761cBV6piUS62k+2f+B9jd+zON75//Dc/TJAb0vJUL1sXkl5B8cP12+Y
	n049wDkF/4+kr10j8G9OT7QclxjMHLR4PafuS38A=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BE613C43E;
	Fri, 19 Sep 2014 19:03:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B72473C43D;
	Fri, 19 Sep 2014 19:03:55 -0400 (EDT)
X-master-at: 97b8860c071898d9e162678ea1035a8ced2f8b1f
X-next-at: 7a54a76ab8dddf4a52b3453b206ed4b8f4200891
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B3178EE-4051-11E4-A915-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257309>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Many topics that have been cooking in 'next' are now in 'master'.

For some unknown reason, we ended up seeing that multiple people
simultaneously cooking topics that are all on the larger side
(i.e. dozen patches or more).  Inevitably larger topics tend to need
more rerolls, and they haven't really hit my tree quite yet, even
though many have been receiving and responding to reviews quite
actively.  Hopefully some may be able to hit 'next' by the end of
6th week of this cycle (i.e. early to mid October), or they would
have to wait until the next cycle.

On the 'maint' front, the first maintenance release for v2.1.x
series is out, downmerging the fixes that are already on 'master'
accumulated since v2.1.0.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ah/grammofix (2014-09-02) 1 commit
  (merged to 'next' on 2014-09-12 at 58fbb44)
 + grammofix in user-facing messages


* as/calloc-takes-nmemb-then-size (2014-09-03) 1 commit
  (merged to 'next' on 2014-09-12 at a287484)
 + calloc() and xcalloc() takes nmemb and then size

 Code clean-up.


* bb/date-iso-strict (2014-08-29) 1 commit
  (merged to 'next' on 2014-09-12 at c9d415d)
 + pretty: provide a strict ISO 8601 date format

 "log --date=iso" uses a slight variant of ISO 8601 format that is
 made more human readable.  A new "--date=iso-strict" option gives
 datetime output that is more strictly conformant.


* da/styles (2014-09-02) 1 commit
  (merged to 'next' on 2014-09-12 at a22322e)
 + stylefix: asterisks stick to the variable, not the type


* ir/makefile-typofix (2014-09-15) 1 commit
  (merged to 'next' on 2014-09-18 at bc1c273)
 + Makefile: fix some typos in the preamble


* jc/parseopt-verify-short-name (2014-09-04) 1 commit
  (merged to 'next' on 2014-09-12 at 43dba24)
 + parse-options: detect attempt to add a duplicate short option name

 Add checks for a common programming mistake to assign the same
 short option name to two separate options to help developers.


* jk/commit-author-parsing (2014-08-29) 6 commits
  (merged to 'next' on 2014-09-12 at cfbb6b6)
 + determine_author_info(): copy getenv output
 + determine_author_info(): reuse parsing functions
 + date: use strbufs in date-formatting functions
 + record_author_date(): use find_commit_header()
 + record_author_date(): fix memory leak on malformed commit
 + commit: provide a function to find a header in a buffer

 Code clean-up.


* jk/fast-export-anonymize (2014-08-28) 2 commits
  (merged to 'next' on 2014-09-12 at 0af10fa)
 + docs/fast-export: explain --anonymize more completely
 + teach fast-export an --anonymize option

 Sometimes users want to report a bug they experience on their
 repository, but they are not at liberty to share the contents of
 the repository.  "fast-export" was taught an "--anonymize" option
 to replace blob contents, names of people and paths and log
 messages with bland and simple strings to help them.


* jk/fsck-exit-code-fix (2014-09-12) 2 commits
  (merged to 'next' on 2014-09-18 at 34c696f)
 + fsck: return non-zero status on missing ref tips
 + fsck: exit with non-zero status upon error from fsck_obj()

 "git fsck" failed to report that it found corrupt objects via its
 exit status in some cases.


* jk/index-pack-threading-races (2014-08-29) 1 commit
  (merged to 'next' on 2014-09-12 at 9241312)
 + index-pack: fix race condition with duplicate bases

 When receiving an invalid pack stream that records the same object
 twice, multiple threads got confused due to a race.  We should
 reject or correct such a stream upon receiving, but that will be a
 larger change.


* jk/send-pack-many-refspecs (2014-08-26) 1 commit
  (merged to 'next' on 2014-09-12 at 7f4ae4e)
 + send-pack: take refspecs over stdin

 The number of refs that can be pushed at once over smart HTTP was
 limited by the command line length.  The limitation has been lifted
 by passing these refs from the standard input of send-pack.


* jp/index-with-corrupt-stages (2014-08-29) 2 commits
  (merged to 'next' on 2014-09-12 at 54016d5)
 + read_index_unmerged(): remove unnecessary loop index adjustment
 + read_index_from(): catch out of order entries when reading an index file

 A broken reimplementation of Git could write an invalid index that
 records both stage #0 and higher stage entries for the same path.
 Notice and reject such an index, as there is no sensible fallback
 (we do not know if the broken tool wanted to resolve and forgot to
 remove higher stage entries, or if it wanted to unresolve and
 forgot to remove the stage#0 entry).


* js/no-test-cmp-for-binaries (2014-09-12) 1 commit
  (merged to 'next' on 2014-09-15 at c5609e9)
 + t9300: use test_cmp_bin instead of test_cmp to compare binary files


* kb/perf-trace (2014-09-08) 1 commit
  (merged to 'next' on 2014-09-12 at 371df71)
 + trace: correct trace_strbuf() parameter type for !HAVE_VARIADIC_MACROS

 Compilation fix for some compilers.


* mb/build-contrib-svn-fe (2014-08-28) 1 commit
  (merged to 'next' on 2014-09-12 at acb252b)
 + contrib/svn-fe: fix Makefile


* mb/fast-import-delete-root (2014-08-29) 2 commits
  (merged to 'next' on 2014-09-12 at d0fda49)
 + fast-import: fix segfault in store_tree()
 + t9300: test filedelete command

 An attempt to remove the entire tree in the "git fast-import" input
 stream caused it to misbehave.


* mk/reachable-protect-detached-head (2014-09-03) 1 commit
  (merged to 'next' on 2014-09-12 at de2b50b)
 + reachable.c: add HEAD to reachability starting commits


* mr/mark-i18n-log-rerere (2014-09-15) 2 commits
  (merged to 'next' on 2014-09-15 at ba35eb3)
 + builtin/log.c: mark strings for translation
 + rerere.h: mark string for translation


* rs/export-strbuf-addchars (2014-09-08) 2 commits
  (merged to 'next' on 2014-09-12 at 8b25fe0)
 + strbuf: use strbuf_addchars() for adding a char multiple times
 + strbuf: export strbuf_addchars()

 Code clean-up.


* rs/merge-tree-simplify (2014-09-02) 1 commit
  (merged to 'next' on 2014-09-12 at 5b4c349)
 + merge-tree: remove unused df_conflict arguments

 Code clean-up.


* rs/more-uses-of-skip-prefix (2014-09-02) 2 commits
  (merged to 'next' on 2014-09-12 at 156a436)
 + pack-write: simplify index_pack_lockfile using skip_prefix() and xstrfmt()
 + connect: simplify check_ref() using skip_prefix() and starts_with()

 Code clean-up.


* rs/simplify-config-include (2014-09-02) 1 commit
  (merged to 'next' on 2014-09-12 at e4ffd6d)
 + config: simplify git_config_include()

 Code clean-up.


* rs/simplify-http-walker (2014-09-02) 1 commit
  (merged to 'next' on 2014-09-12 at b5178d2)
 + http-walker: simplify process_alternates_response() using strbuf

 Code clean-up.


* so/rebase-doc (2014-09-16) 1 commit
  (merged to 'next' on 2014-09-18 at cce521d)
 + Documentation/git-rebase.txt: <upstream> must be given to specify <branch>


* sp/doc-update-index-cacheinfo (2014-09-11) 1 commit
  (merged to 'next' on 2014-09-15 at 11ec716)
 + Documentation: use single-parameter --cacheinfo in example


* ss/compat-default-source-for-newer-gnu (2014-09-15) 1 commit
  (merged to 'next' on 2014-09-15 at 0e87594)
 + compat-util: add _DEFAULT_SOURCE define


* ta/config-add-to-empty-or-true-fix (2014-09-11) 2 commits
  (merged to 'next' on 2014-09-15 at af779a7)
 + config: avoid a funny sentinel value "a^"
  (merged to 'next' on 2014-08-29 at d219212)
 + make config --add behave correctly for empty and NULL values

 "git config --add section.var val" used to lose existing
 section.var whose value was an empty string.


* tb/complete-diff-ignore-blank-lines (2014-09-03) 1 commit
  (merged to 'next' on 2014-09-12 at 1b7d259)
 + completion: Add --ignore-blank-lines for diff


* tb/crlf-tests (2014-09-02) 3 commits
  (merged to 'next' on 2014-09-12 at 2c950af)
 + MinGW: update tests to handle a native eol of crlf
 + Makefile: propagate NATIVE_CRLF to C
 + t0027: Tests for core.eol=native, eol=lf, eol=crlf


* wk/pre-push-sample-hook (2014-09-11) 1 commit
  (merged to 'next' on 2014-09-18 at 6f8c9d7)
 + pre-push.sample: Write error message to stderr

--------------------------------------------------
[Stalled]

* rs/ref-transaction (2014-09-12) 20 commits
 . remote rm/prune: print a message when writing packed-refs fails
 . ref_transaction_commit: bail out on failure to remove a ref
 . lockfile: remove unable_to_lock_error
 . refs.c: do not permit err == NULL
 . for-each-ref.c: improve message before aborting on broken ref
 . refs.c: fix handling of badly named refs
 . branch -d: avoid repeated symref resolution
 . refs.c: change resolve_ref_unsafe reading argument to be a flags field
 . refs.c: make write_ref_sha1 static
 . fetch.c: change s_update_ref to use a ref transaction
 . refs.c: ref_transaction_commit: distinguish name conflicts from other errors
 . refs.c: pass a skip list to name_conflict_fn
 . refs.c: call lock_ref_sha1_basic directly from commit
 . refs.c: move the check for valid refname to lock_ref_sha1_basic
 . rename_ref: don't ask read_ref_full where the ref came from
 . refs.c: pass the ref log message to _create/delete/update instead of _commit
 . refs.c: add an err argument to delete_ref_loose
 . wrapper.c: add a new function unlink_or_msg
 . wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
 . mv test: recreate mod/ directory instead of relying on stale copy

 Rerolled and was asked to wait.  Seems to break HEAD reflog
 upon "checkout HEAD^0".

 Expecting another reroll.


* tr/remerge-diff (2014-09-08) 8 commits
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Review comments sent.


* hv/submodule-config (2014-06-30) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


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

 Reviewed, discussed and wanting for a reroll.


* jk/pack-bitmap (2014-08-04) 1 commit
 - pack-bitmap: do not use gcc packed attribute

 Hold, waiting for Karsten's replacement.


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


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


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

 Waiting for a reroll (thread ending at $gmane/254746)


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

* jk/faster-name-conflicts (2014-09-12) 1 commit
  (merged to 'next' on 2014-09-19 at 34d2840)
 + refs: speed up is_refname_available

 Optimize the check to see if a ref $F can be created by making sure
 no existing ref has $F/ as its prefix, which especially matters in
 a repository with a large number of existing refs.

 Will merge to 'master'.


* jk/write-packed-refs-via-stdio (2014-09-10) 1 commit
  (merged to 'next' on 2014-09-19 at f1e94fb)
 + refs: write packed_refs file using stdio

 Optimize the code path to write out the packed-refs file, which
 especially matters in a repository with a large number of refs.

 Will merge to 'master'.


* da/include-compat-util-first-in-c (2014-09-15) 4 commits
 - SQUASH???
 - check-headers: add header usage checks for .c files
 - Makefile: add check-headers target
 - cleanups: ensure that git-compat-util.h is included first


* da/rev-parse-verify-quiet (2014-09-19) 4 commits
 - stash: prefer --quiet over shell redirection of the standard error stream
 - refs: make rev-parse --quiet actually quiet
 - t1503: use test_must_be_empty
 - Documentation: a note about stdout for git rev-parse --verify --quiet

 "rev-parse --verify --quiet $name" is meant to quietly exit with a
 non-zero status when $name is not a valid object name, but still
 gave error messages in some cases.

 Will merge to 'next'.


* hj/pretty-naked-decoration (2014-09-18) 1 commit
 - pretty: add %D format specifier

 Will merge to 'next'.


* jc/ignore-sigpipe-while-running-hooks (2014-09-16) 1 commit
  (merged to 'next' on 2014-09-19 at 7abf293)
 + receive-pack: allow hooks to ignore its standard input stream

 pre- and post-receive hooks are no longer required to read all
 their inputs.

 Will merge to 'master'.


* jk/close-stderr-of-credential-cache-deamon (2014-09-16) 1 commit
  (merged to 'next' on 2014-09-19 at 51ba3be)
 + credential-cache: close stderr in daemon process

 Plug fd leaks.

 Will merge to 'master'.


* jk/mbox-from-line (2014-09-16) 1 commit
  (merged to 'next' on 2014-09-19 at 314af77)
 + mailinfo: make ">From" in-body header check more robust

 Some MUAs mangled a line in a message that begins with "From " to
 ">From " when writing to a mailbox file and feeding such an input
 to "git am" used to lose such a line.

 Will merge to 'master'.


* jk/prune-packed-server-info (2014-09-15) 4 commits
  (merged to 'next' on 2014-09-19 at 5e6c398)
 + repack: call prune_packed_objects() and update_server_info() directly
 + server-info: clean up after writing info/packs
 + make update-server-info more robust
 + prune-packed: fix minor memory leak

 Code cleanup.

 Will merge to 'master'.


* pr/use-default-sigpipe-setting (2014-09-18) 1 commit
 - unblock and unignore SIGPIPE

 We used to get confused when a process called us with SIGPIPE
 ignored; we do want to die with SIGPIPE when the output is not
 read by default, and do ignore the signal when appropriate.

 Will merge to 'next'.


* rs/realloc-array (2014-09-18) 2 commits
 - use REALLOC_ARRAY for changing the allocation size of arrays
 - add macro REALLOC_ARRAY

 Code cleanup.

 Will merge to 'next'.


* jk/branch-verbose-merged (2014-09-18) 1 commit
 - branch: clean up commit flags after merge-filter walk

 The "--verbose" option no longer breaks "git branch --merged $it".

 Will merge to 'next'.


* sb/help-unknown-command-sort-fix (2014-09-18) 1 commit
 - help: fix the size passed to qsort

 Code cleanup.

 Will merge to 'next'.


* jc/hash-object (2014-09-11) 3 commits
  (merged to 'next' on 2014-09-19 at ea6ac62)
 + hash-object: add --literally option
 + hash-object: pass 'write_object' as a flag
 + hash-object: reduce file-scope statics
 (this branch is used by jc/hash-object-fsck-tag.)

 "hash-object" learned a new "--literally" option to hash any random
 garbage into a loose object, to allow us to create a test data for
 mechanisms to catch corrupt objects.

 Will merge to 'next'.


* jc/hash-object-fsck-tag (2014-09-12) 2 commits
  (merged to 'next' on 2014-09-19 at f14a7fe)
 + t1450: make sure fsck detects a malformed tagger line
 + Merge branch 'js/fsck-tag-validation' into HEAD
 (this branch uses jc/hash-object and js/fsck-tag-validation.)

 Using "hash-object --literally", test one of the new breakages
 js/fsck-tag-validation topic teaches "fsck" to catch is caught.

 Will merge to 'next'.


* js/fsck-tag-validation (2014-09-12) 6 commits
  (merged to 'next' on 2014-09-19 at 4a62182)
 + Make sure that index-pack --strict checks tag objects
 + Add regression tests for stricter tag fsck'ing
 + fsck: check tag objects' headers
 + Make sure fsck_commit_buffer() does not run out of the buffer
 + fsck_object(): allow passing object data separately from the object itself
 + Refactor type_from_string() to allow continuing after detecting an error
 (this branch is used by jc/hash-object-fsck-tag.)

 Teach "git fsck" to inspect the contents of annotated tag objects.

 Will merge to 'next'.


* mh/lockfile (2014-09-16) 35 commits
 - get_locked_file_path(): new function
 - lockfile.c: rename static functions
 - lockfile: rename LOCK_NODEREF to LOCK_NO_DEREF
 - commit_locked_index(): extract a function commit_lock_file_to()
 - trim_last_path_component(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - struct lock_file: change the filename member into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
 - dump_marks(): remove a redundant call to rollback_lock_file()
 - api-lockfile: document edge cases
 - commit_lock_file(): rollback lock file on failure to rename
 - commit_lock_file(): if close fails, roll back
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): exit early if lock is not active
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Rerolled, reviews in progress; it seems that we will see another reroll?


* nd/multiple-work-trees (2014-09-16) 32 commits
 - t2025: add a test to make sure grafts is working from a linked checkout
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/worktrees/...
 - gc: support prune --worktrees
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
 - checkout: clean up half-prepared directories in --to mode
 - checkout: reject if the branch is already checked out elsewhere
 - prune: strategies for linked checkouts
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Rerolled, reviews in progress; it seems that we will see another reroll?


* cc/interpret-trailers (2014-09-15) 11 commits
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

 Rerolled, with some review comments but not much; it seems that we
 will see another reroll?


* sp/stream-clean-filter (2014-08-28) 6 commits
 - convert: stream from fd to required clean filter to reduce used address space
 - copy_fd(): do not close the input file descriptor
 - mmap_limit: introduce GIT_MMAP_LIMIT to allow testing expected mmap size
 - memory_limit: use git_env_ulong() to parse GIT_ALLOC_LIMIT
 - config.c: add git_env_ulong() to parse environment variable
 - convert: drop arguments other than 'path' from would_convert_to_git()

 Rerolled.  Comments & reviews?


* jc/push-cert (2014-09-17) 23 commits
 - signed push: allow stale nonce in stateless mode
 - signed push: teach smart-HTTP to pass "git push --signed" around
 - signed push: fortify against replay attacks
 - signed push: add "pushee" header to push certificate
 - signed push: remove duplicated protocol info
 - send-pack: send feature request on push-cert packet
 - receive-pack: GPG-validate push certificates
 - push: the beginning of "git push --signed"
 - pack-protocol doc: typofix for PKT-LINE
 - gpg-interface: move parse_signature() to where it should be
 - gpg-interface: move parse_gpg_output() to where it should be
 - send-pack: clarify that cmds_sent is a boolean
 - send-pack: refactor inspecting and resetting status and sending commands
 - send-pack: rename "new_refs" to "need_pack_data"
 - receive-pack: factor out capability string generation
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

 Will merge to 'next'.


* jc/test-lazy-prereq (2014-06-13) 1 commit
 - tests: drop GIT_*_TIMING_TESTS environment variable support

 Test-script clean-up.

 Will merge to 'next'.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.
