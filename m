From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2015, #04; Tue, 20)
Date: Tue, 20 Oct 2015 15:10:14 -0700
Message-ID: <xmqq8u6x6vjt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zof82-0003GE-Hb
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbbJTWL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:11:29 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35749 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbbJTWKR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:10:17 -0400
Received: by pasz6 with SMTP id z6so33155135pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=QCnCdS78gkp3ks2KGm9IQgfvkoOld238jKzZvvSuEB8=;
        b=kSID9TR6agvy5GOsvGPevsq5DH+lt1KXf8VHWt/RcpKS9fOmxc5iJIiBy8lLnbrmS/
         kez9rBmYp6XaOdZ6w822YOKKDyhWDnQtGzgP+w1qR++Z5ozSRLd5fBZ5ESC9sRSuN3qt
         Y/w4VHOeBb3e6JF1v59p6cvDQmgAHwCUGKc7v++eXsgEM+TnaNSclk8VgjeEvEvhKXzg
         RPiP8DMrif9qBbW6RdLKY0xVO1vUwBTo9hRyCJkLlfqZVlKcJCxLurV/RYmBhRWbk+uk
         j/sR0j3DErsA54wzeCxSXIYc6VNn790elMraEvsA0fAsf3IGDnUptX4Ecmhiyso2wq62
         TAxQ==
X-Received: by 10.66.251.136 with SMTP id zk8mr6419432pac.143.1445379016317;
        Tue, 20 Oct 2015 15:10:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id dg2sm5542845pbb.9.2015.10.20.15.10.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 15:10:15 -0700 (PDT)
X-master-at: 614a2aced1ba739dfe5bf17a85f9d376efb235b1
X-next-at: 4688abffc19bfe433e802ce56f31d4a362291a2d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279946>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

With somewhat reduced review bandwidth, I'd expect that the upcoming
cycle would be slower than usual.  At tinyurl.com/gitCal, I
tentatively drew a 14-week schedule for this cycle (I plan to be
offline during weeks #7-#9 myself---hopefully we'll have capable
interim maintainers to take care of the list traffic in the meantime
as in past years).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* cc/quote-comments (2015-10-07) 2 commits
  (merged to 'next' on 2015-10-09 at fc8a359)
 + quote: move comment before sq_quote_buf()
 + quote: fix broken sq_quote_buf() related comment

 A no-op code-health maintenance.


* dt/log-follow-config (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 64a30d2)
 + log: Update log.follow doc and add to config.txt

 Description of the "log.follow" configuration variable in "git log"
 documentation is now also copied to "git config" documentation.


* es/worktree-add-cleanup (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 6ffd721)
 + t2026: rename worktree prune test

 A no-op code-health maintenance.


* gr/rebase-i-drop-warn (2015-10-05) 2 commits
  (merged to 'next' on 2015-10-09 at 0626b96)
 + rebase-i: loosen over-eager check_bad_cmd check
 + rebase-i: explicitly accept tab as separator in commands

 "git rebase -i" had a minor regression recently, which stopped
 considering a line that begins with an indented '#' in its insn
 sheet not a comment, which is now fixed.


* jc/doc-gc-prune-now (2015-10-14) 1 commit
  (merged to 'next' on 2015-10-15 at 5c07566)
 + Documentation/gc: warn against --prune=<now>

 "git gc" is safe to run anytime only because it has the built-in
 grace period to protect young objects.  In order to run with no
 grace period, the user must make sure that the repository is
 quiescent.


* jc/fsck-dropped-errors (2015-09-23) 1 commit
  (merged to 'next' on 2015-10-09 at 887fcac)
 + fsck: exit with non-zero when problems are found

 There were some classes of errors that "git fsck" diagnosed to its
 standard error that did not cause it to exit with non-zero status.


* jk/filter-branch-use-of-sed-on-incomplete-line (2015-10-12) 1 commit
  (merged to 'next' on 2015-10-15 at 9e7c032)
 + filter-branch: remove multi-line headers in msg filter

 A recent "filter-branch --msg-filter" broke skipping of the commit
 object header, which is fixed.


* js/clone-dissociate (2015-10-07) 4 commits
  (merged to 'next' on 2015-10-09 at ba30393)
 + clone --dissociate: avoid locking pack files
 + sha1_file.c: add a function to release all packs
 + sha1_file: consolidate code to close a pack's file descriptor
 + t5700: demonstrate a Windows file locking issue with `git clone --dissociate`

 "git clone --dissociate" runs a big "git repack" process at the
 end, and it helps to close file descriptors that are open on the
 packs and their idx files before doing so on filesystems that
 cannot remove a file that is still open.


* js/gc-with-stale-symref (2015-10-08) 2 commits
  (merged to 'next' on 2015-10-09 at 8b89576)
 + pack-objects: do not get distracted by broken symrefs
 + gc: demonstrate failure with stale remote HEAD

 "git gc" used to barf when a symbolic ref has gone dangling
 (e.g. the branch that used to be your upstream's default when you
 cloned from it is now gone, and you did "fetch --prune").


* js/icase-wt-detection (2015-09-28) 1 commit
  (merged to 'next' on 2015-10-09 at 78ff500)
 + setup: fix "inside work tree" detection on case-insensitive filesystems

 On a case insensitive filesystems, setting GIT_WORK_TREE variable
 using a random cases that does not agree with what the filesystem
 thinks confused Git that it wasn't inside the working tree.


* kn/for-each-branch (2015-09-25) 8 commits
  (merged to 'next' on 2015-10-09 at 45723ce)
 + branch: add '--points-at' option
 + branch.c: use 'ref-filter' APIs
 + branch.c: use 'ref-filter' data structures
 + branch: drop non-commit error reporting
 + branch: move 'current' check down to the presentation layer
 + branch: roll show_detached HEAD into regular ref_list
 + branch: bump get_head_description() to the top
 + branch: refactor width computation
 (this branch is used by kn/for-each-branch-remainder.)

 Update "git branch" that list existing branches, using the
 ref-filter API that is shared with "git tag" and "git
 for-each-ref".


* ls/p4-lfs (2015-10-03) 7 commits
  (merged to 'next' on 2015-10-14 at 4b8c365)
 + git-p4: add Git LFS backend for large file system
 + git-p4: add support for large file systems
 + git-p4: check free space during streaming
 + git-p4: add file streaming progress in verbose mode
 + git-p4: return an empty list if a list config has no values
 + git-p4: add gitConfigInt reader
 + git-p4: add optional type specifier to gitConfig reader

 Teach "git p4" to send large blobs outside the repository by
 talking to Git LFS.


* ls/p4-translation-failure (2015-09-22) 2 commits
  (merged to 'next' on 2015-10-09 at b462387)
 + git-p4: handle "Translation of file content failed"
 + git-p4: add test case for "Translation of file content failed" error

 Work around "git p4" failing when the P4 depot records the contents
 in UTF-16 without UTF-16 BOM.


* mk/submodule-gitdir-path (2015-09-14) 2 commits
  (merged to 'next' on 2015-10-09 at cf8768e)
 + path: implement common_dir handling in git_pathdup_submodule()
 + submodule refactor: use strbuf_git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".


* mm/detach-at-HEAD-reflog (2015-10-02) 2 commits
  (merged to 'next' on 2015-10-09 at 624bc87)
 + status: don't say 'HEAD detached at HEAD'
 + t3203: test 'detached at' after checkout --detach

 After "git checkout --detach", "git status" reported a fairly
 useless "HEAD detached at HEAD", instead of saying at which exact
 commit.


* nd/clone-linked-checkout (2015-09-28) 6 commits
  (merged to 'next' on 2015-10-09 at a93973f)
 + clone: better error when --reference is a linked checkout
 + clone: allow --local from a linked checkout
 + enter_repo: allow .git files in strict mode
 + enter_repo: avoid duplicating logic, use is_git_directory() instead
 + t0002: add test for enter_repo(), non-strict mode
 + path.c: delete an extra space

 It was not possible to use a repository-lookalike created by "git
 worktree add" as a local source of "git clone".


* nd/gc-auto-background-fix (2015-09-21) 1 commit
  (merged to 'next' on 2015-10-09 at 1f0fc60)
 + gc: save log from daemonized gc --auto and print it next time

 When "git gc --auto" is backgrounded, its diagnosis message is
 lost.  Save it to a file in $GIT_DIR and show it next time the "gc
 --auto" is run.


* pt/am-builtin (2015-09-30) 1 commit
  (merged to 'next' on 2015-10-09 at 396def8)
 + am: configure gpg at startup

 When "git am" was rewritten as a built-in, it stopped paying
 attention to user.signingkey, which was fixed.


* rd/test-path-utils (2015-10-08) 1 commit
  (merged to 'next' on 2015-10-15 at 827a271)
 + test-path-utils.c: remove incorrect assumption

 The normalize_ceiling_entry() function does not muck with the end
 of the path it accepts, and the real world callers do rely on that,
 but a test insisted that the function drops a trailing slash.


* sa/send-email-smtp-batch-data-limit (2015-09-30) 1 commit
  (merged to 'next' on 2015-10-09 at c021fdf)
 + git-send-email.perl: Fixed sending of many/huge changes/patches

 When "git send-email" wanted to talk over Net::SMTP::SSL,
 Net::Cmd::datasend() did not like to be fed too many bytes at the
 same time and failed to send messages.  Send the payload one line
 at a time to work around the problem.


* sb/http-flaky-test-fix (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-09 at 9dc37f3)
 + t5561: get rid of racy appending to logfile

 A test script for the HTTP service had a timing dependent bug,
 which was fixed.


* sb/perf-without-installed-git (2015-09-25) 1 commit
  (merged to 'next' on 2015-10-09 at 7a1ed05)
 + t/perf: make runner work even if Git is not installed

 Performance-measurement tests did not work without an installed Git.


* sb/submodule-config-parse (2015-10-12) 1 commit
  (merged to 'next' on 2015-10-15 at 6fea79d)
 + submodule-config: "goto" removal in parse_config()

 Code simplification.


* tk/doc-interpret-trailers-grammo (2015-10-07) 1 commit
  (merged to 'next' on 2015-10-09 at 37888a2)
 + Documentation/interpret-trailers: Grammar fix

--------------------------------------------------
[New Topics]

* dt/refs-backend-pre-vtable (2015-10-15) 27 commits
 - introduce "extensions" form of core.repositoryformatversion
 - refs: break out ref conflict checks
 - refs: make files_log_ref_write functions public
 - initdb: move safe_create_dir into common code
 - refs.c: move should_autocreate_reflog to common code
 - refs.c: move peel_object to the common code
 - refs.c: move copy_msg to the common code
 - refs.c: move refname_is_safe to the common code
 - refs: move transaction functions into common code
 - refs.c: move head_ref_namespaced to the common code
 - refs.c: move ref iterators to the common code
 - refs.c: move prettify_refname to the common code
 - refs.c: move is_branch to the common code
 - refs.c: move check_refname_format to the common code
 - refs.c: move resolve_refdup to common
 - refs.c: move read_ref, read_ref_full and ref_exists to the common code
 - refs.c: move warn_if_dangling_symref* to the common code
 - refs.c: move dwim and friend functions to the common refs code
 - refs.c: move the hidden refs functions to the common code
 - refs.c: move read_ref_at to the common refs file
 - refs.c: move delete_pseudoref and delete_ref to the common code
 - refs.c: move update_ref to refs.c
 - refs.c: add a new refs.c file to hold all common refs code
 - refs-be-files.c: rename refs to refs-be-files
 - refs: make repack_without_refs and is_branch public
 - refs.c: create a public version of verify_refname_available
 - Merge branch 'jk/war-on-sprintf' into HEAD
 (this branch uses jk/war-on-sprintf; is tangled with dt/refs-backend-lmdb.)

 The early part of the pluggable ref backend series, which sifts the
 ref API functions into two bins: the filesystem backend specific
 ones and the generic API functions.  The next step will start
 introducing the framework to dispatch generic calls to specific
 backend implementation(s) and then finally plug a new backend that
 is different from the file backend.

 Expecting a reroll after an review of the remainder.
 ($gmane/279897).


* jc/usage-stdin (2015-10-16) 1 commit
 - usage: do not insist that standard input must come from a file

 The synopsys text and the usage string of subcommands that read
 list of things from the standard input are often shown as if they
 only take input from a file on a filesystem, which was misleading.

 Will merge to 'next'.


* rt/placeholder-in-usage (2015-10-16) 1 commit
 - am, credential-cache: add angle brackets to usage string

 A couple of commands still showed "[options]" in their usage string
 to note where options should come on their command line, but we
 spell that "[<options>]" in most places these days.

 Will merge to 'next'.


* tk/stripspace (2015-10-16) 2 commits
 - stripspace: use parse-options for command-line parsing
 - strbuf: make stripspace() part of strbuf

 The internal stripspace() function has been moved to where it
 logically belongs to, i.e. strbuf API, and the command line parser
 of "git stripspace" has been updated to use the parse_options API.

 Will merge to 'next'.


* dk/p4-import-ctypes (2015-10-20) 1 commit
 - git-p4: import the ctypes module

 "git-p4" tried to use from ctypes module without first importing
 it.

 Will merge to 'next'.


* dt/t7063-fix-flaky-test (2015-10-19) 1 commit
 - t7063: fix flaky untracked-cache test

 Will merge to 'next'.


* es/worktree-add (2015-10-18) 1 commit
 - worktree: usage: denote <branch> as optional with 'add'

 Will merge to 'next'.


* kn/for-each-tag (2015-10-18) 1 commit
 - tag.c: use the correct algorithm for the '--contains' option

 Recent update to "git tag --contains" caused a performance
 regression.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* dk/gc-idx-wo-pack (2015-08-17) 3 commits
 - DONTMERGE: log message, grace-period and tests $gmane/276058
 - gc: remove stale .idx files without corresponding .pack file
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without correspoinding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 Waiting for a reroll.


* nd/ita-cleanup (2015-09-06) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.

 Waiting for a reroll.


* ld/p4-detached-head (2015-09-09) 2 commits
 - git-p4: work with a detached head
 - git-p4: add failing test for submit from detached head

 Will be rerolled.
 ($gmane/277574)


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Becoming tired of waiting for a reroll.
 ($gmane/272180).


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
 - notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).


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

--------------------------------------------------
[Cooking]

* mr/worktree-list (2015-10-08) 5 commits
 - worktree: add 'list' command
 - worktree: add details to the worktree struct
 - worktree: add a function to get worktree details
 - worktree: refactor find_linked_symref function
 - worktree: add top-level worktree.c

 Add the "list" subcommand to "git worktree".

 Will merge to 'next'.


* jc/mailinfo (2015-10-20) 1 commit
 - mailinfo: ignore in-body header that we do not care about
 (this branch uses jc/am-mailinfo-direct and jc/mailinfo-lib.)

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* jc/am-mailinfo-direct (2015-10-20) 2 commits
 - mailinfo: plug strbuf leak during continuation line handling
 - am: make direct call to mailinfo
 (this branch is used by jc/mailinfo; uses jc/mailinfo-lib.)

 "git am" used to spawn "git mailinfo" via run_command() API once
 per each patch, but learned to make a direct call to mailinfo()
 instead.

 Needs benchmark on platforms with slow run_command().


* jc/mailinfo-lib (2015-10-19) 33 commits
 - mailinfo: remove calls to exit() and die() deep in the callchain
 - mailinfo: handle charset conversion errors in the caller
 - mailinfo: libify
 - mailinfo: move definition of MAX_HDR_PARSED closer to its use
 - mailinfo: move cleanup_space() before its users
 - mailinfo: move check_header() after the helpers it uses
 - mailinfo: move read_one_header_line() closer to its callers
 - mailinfo: keep the parsed log message in a strbuf
 - mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
 - mailinfo: move content/content_top to struct mailinfo
 - mailinfo: move [ps]_hdr_data to struct mailinfo
 - mailinfo: move cmitmsg and patchfile to struct mailinfo
 - mailinfo: move charset to struct mailinfo
 - mailinfo: move transfer_encoding to struct mailinfo
 - mailinfo: move check for metainfo_charset to convert_to_utf8()
 - mailinfo: move metainfo_charset to struct mailinfo
 - mailinfo: move use_scissors and use_inbody_headers to struct mailinfo
 - mailinfo: move add_message_id and message_id to struct mailinfo
 - mailinfo: move patch_lines to struct mailinfo
 - mailinfo: move filter/header stage to struct mailinfo
 - mailinfo: move global "FILE *fin, *fout" to struct mailinfo
 - mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
 - mailinfo: introduce "struct mailinfo" to hold globals
 - mailinfo: move global "line" into mailinfo() function
 - mailinfo: do not let find_boundary() touch global "line" directly
 - mailinfo: do not let handle_boundary() touch global "line" directly
 - mailinfo: do not let handle_body() touch global "line" directly
 - mailinfo: get rid of function-local static states
 - mailinfo: move handle_boundary() lower
 - mailinfo: explicitly close file handle to the patch output
 - mailinfo: fix an off-by-one error in the boundary stack
 - mailinfo: fold decode_header_bq() into decode_header()
 - mailinfo: remove a no-op call convert_to_utf8(it, "")
 (this branch is used by jc/am-mailinfo-direct and jc/mailinfo.)

 The implementation of "git mailinfo" was refactored so that a
 mailinfo() function can be directly called from inside a process.


* jc/am-3-fallback-regression-fix (2015-10-09) 1 commit
  (merged to 'next' on 2015-10-15 at 7dde994)
 + am -3: do not let failed merge from completing the error codepath
 (this branch is used by js/am-3-merge-recursive-direct.)

 "git am -3" had a small regression where it is aborted in its error
 handling codepath when underlying merge-recursive failed in certain
 ways, as it assumed that the internal call to merge-recursive will
 never die, which is not the case (yet).


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag
 (this branch uses jc/am-3-fallback-regression-fix.)

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.


* km/cache-entry-refcnt (2015-10-14) 1 commit
 - merge: fix cache_entry use-after-free

 Sometimes we discarded a cache-entry that is still referenced from
 name-hash (used only to hold the pathname there), leading to use
 after free errors.  Reference-count cache entries to work it
 around.


* ls/p4-test-updates (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-15 at 3c94932)
 + git-p4: skip t9819 test case on case insensitive file systems
 + git-p4: avoid "stat" command in t9815 git-p4-submit-fail

 A few test scripts around "git p4" have been improved for
 portability.

 Will merge to 'master'.


* tb/t0027-crlf (2015-10-12) 1 commit
  (merged to 'next' on 2015-10-15 at 7ab4f31)
 + t0027: improve test for not-normalized files

 The test for various line-ending conversions has been enhanced.

 Will merge to 'master'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* kn/for-each-branch-remainder (2015-10-02) 9 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: adopt get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: add support for %(path) atom
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: implement %(if), %(then), and %(else) atoms

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Expecting a reroll.
 ($gmane/278926)


* jk/war-on-sprintf (2015-10-05) 70 commits
  (merged to 'next' on 2015-10-15 at 27a1ae5)
 + name-rev: use strip_suffix to avoid magic numbers
 + use strbuf_complete to conditionally append slash
 + fsck: use for_each_loose_file_in_objdir
 + Makefile: drop D_INO_IN_DIRENT build knob
 + fsck: drop inode-sorting code
 + convert strncpy to memcpy
 + notes: document length of fanout path with a constant
 + color: add color_set helper for copying raw colors
 + prefer memcpy to strcpy
 + help: clean up kfmclient munging
 + receive-pack: simplify keep_arg computation
 + avoid sprintf and strcpy with flex arrays
 + use alloc_ref rather than hand-allocating "struct ref"
 + color: add overflow checks for parsing colors
 + drop strcpy in favor of raw sha1_to_hex
 + use sha1_to_hex_r() instead of strcpy
 + daemon: use cld->env_array when re-spawning
 + stat_tracking_info: convert to argv_array
 + http-push: use an argv_array for setup_revisions
 + fetch-pack: use argv_array for index-pack / unpack-objects
 + diagnose_invalid_index_path: use strbuf to avoid strcpy/strcat
 + write_loose_object: convert to strbuf
 + remove_leading_path: use a strbuf for internal storage
 + enter_repo: convert fixed-size buffers to strbufs
 + merge-recursive: convert malloc / strcpy to strbuf
 + transport: use strbufs for status table "quickref" strings
 + apply: convert root string to strbuf
 + init: use strbufs to store paths
 + probe_utf8_pathname_composition: use internal strbuf
 + precompose_utf8: drop unused variable
 + sha1_get_pack_name: use a strbuf
 + http-walker: store url in a strbuf
 + http-push: use strbuf instead of fwrite_buffer
 + remote-ext: simplify git pkt-line generation
 + upload-archive: convert sprintf to strbuf
 + resolve_ref: use strbufs for internal buffers
 + read_remotes_file: simplify string handling
 + read_branches_file: simplify string handling
 + mailmap: replace strcpy with xstrdup
 + help: drop prepend function in favor of xstrfmt
 + ref-filter: drop sprintf and strcpy calls
 + use strip_suffix and xstrfmt to replace suffix
 + fetch: replace static buffer with xstrfmt
 + config: use xstrfmt in normalize_value
 + replace trivial malloc + sprintf / strcpy calls with xstrfmt
 + receive-pack: convert strncpy to xsnprintf
 + http-push: replace strcat with xsnprintf
 + add_packed_git: convert strcpy into xsnprintf
 + entry.c: convert strcpy to xsnprintf
 + grep: use xsnprintf to format failure message
 + compat/hstrerror: convert sprintf to snprintf
 + stop_progress_msg: convert sprintf to xsnprintf
 + find_short_object_filename: convert sprintf to xsnprintf
 + use xsnprintf for generating git object headers
 + archive-tar: use xsnprintf for trivial formatting
 + convert trivial sprintf / strcpy calls to xsnprintf
 + compat/inet_ntop: fix off-by-one in inet_ntop4
 + test-dump-cache-tree: avoid overflow of cache-tree name
 + progress: store throughput display in a strbuf
 + trace: use strbuf for quote_crnl output
 + mailsplit: make PATH_MAX buffers dynamic
 + fsck: use strbuf to generate alternate directories
 + add reentrant variants of sha1_to_hex and find_unique_abbrev
 + strbuf: make strbuf_complete_line more generic
 + add git_path_buf helper function
 + add xsnprintf helper function
 + fsck: don't fsck alternates for connectivity-only check
 + archive-tar: fix minor indentation violation
 + mailsplit: fix FILE* leak in split_maildir
 + show-branch: avoid segfault with --reflog of unborn branch
 (this branch is used by dt/refs-backend-lmdb and dt/refs-backend-pre-vtable.)

 Many allocations that is manually counted (correctly) that are
 followed by strcpy/sprintf have been replaced with a less error
 prone constructs such as xstrfmt.

 Macintosh-specific breakage was noticed and corrected in this
 reroll.

 Will merge to 'master'.


* rp/link-curl-before-ssl (2015-09-25) 3 commits
 - configure: make curl-config path configurable
 - configure.ac: detect ssl need with libcurl
 - Makefile: link libcurl before openssl and crypto

 Waiting for the (hopefully) final submission.


* jk/graph-format-padding (2015-09-14) 1 commit
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 Redefine the way '%>|(N)' padding and the "--graph" option
 interacts.  It has been that the available columns to display the
 log message was measured from the edge of the area the graph ended,
 but with this it becomes the beginning of the entire output.

 I have a suspicion that 50% of the users would appreciate this
 change, and the remainder see this break their expectation.  If
 that is the case, we might need to introduce a similar but
 different alignment operator so that this new behaviour is
 available to those who want to use it, without negatively affecting
 existing uses.

 Undecided.
 ($gmane/278326)


* sb/submodule-parallel-fetch (2015-10-20) 14 commits
 - run-command: fix missing output from late callbacks
 - test-run-command: increase test coverage
 - test-run-command: test for gracefully aborting
 - run-command: initialize the shutdown flag
 - run-command: call get_next_task with a clean child process.
 - run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Will cook in 'next'.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2015-09-14) 7 commits
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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-10-07 at 50fed71)
 + merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch is used by mh/notes-allow-reading-treeish.)

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.7 cycle.

--------------------------------------------------
[Discarded]

* dt/refs-backend-lmdb (2015-10-12) 45 commits
 . refs: tests for db backend
 . refs: add LMDB refs backend
 . introduce "extensions" form of core.repositoryformatversion
 . refs: add register_refs_backend
 . refs: allow ref backend to be set for clone
 . refs: always handle non-normal refs in files backend
 . refs: move duplicate check to common code
 . refs: break out a ref conflict check
 . refs: make files_log_ref_write functions public
 . refs: make lock generic
 . refs-be-files.c: add method to rename refs
 . refs.c: add method for initializing refs db
 . initdb: move safe_create_dir into common code
 . refs.c: add method for initial ref transaction commit
 . refs.c: add methods for reflog
 . refs.c: add ref backend init function
 . refs.c: move should_autocreate_reflog to common code
 . refs.c: move peel_object to the common code
 . refs.c: move copy_msg to the common code
 . refs.h: document make refname_is_safe and add it to header
 . refs.c: move refname_is_safe to the common code
 . refs-be-files.c: add do_for_each_per_worktree_ref
 . refs-be-files.c: add method for for_each_reftype_...
 . refs-be-files.c: add methods for the ref iterators
 . refs-be-files.c: add methods for misc ref operations
 . refs: add a backend method structure with transaction functions
 . refs: move transaction functions into common code
 . refs.c: move head_ref_namespaced to the common code
 . refs.c: move ref iterators to the common code
 . refs.c: move prettify_refname to the common code
 . refs.c: move is_branch to the common code
 . refs.c: move check_refname_format to the common code
 . refs.c: move resolve_refdup to common
 . refs.c: move read_ref, read_ref_full and ref_exists to the common code
 . refs.c: move warn_if_dangling_symref* to the common code
 . refs.c: move dwim and friend functions to the common refs code
 . refs.c: move the hidden refs functions to the common code
 . refs.c: move read_ref_at to the common refs file
 . refs.c: move delete_ref and delete_refs to the common code
 . refs.c: move update_ref to refs.c
 . refs.c: add a new refs.c file to hold all common refs code
 . refs-be-files.c: rename refs to refs-be-files
 . refs: make repack_without_refs and is_branch public
 . refs.c: create a public version of verify_refname_available
 - Merge branch 'jk/war-on-sprintf' into HEAD
 (this branch uses jk/war-on-sprintf; is tangled with dt/refs-backend-pre-vtable.)

 Being rerolled separately.
