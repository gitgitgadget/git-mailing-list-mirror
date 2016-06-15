From: Jeff King <peff@peff.net>
Subject: What's cooking in git.git (Nov 2015, #04; Tue, 24)
Date: Tue, 24 Nov 2015 20:07:23 -0500
Message-ID: <20151125010722.GA23632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:07:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1OYV-0004zr-L1
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbbKYBH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:07:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:33618 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753964AbbKYBH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:07:26 -0500
Received: (qmail 3095 invoked by uid 102); 25 Nov 2015 01:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 19:07:26 -0600
Received: (qmail 20950 invoked by uid 107); 25 Nov 2015 01:07:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 20:07:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 20:07:23 -0500
Content-Disposition: inline
X-master-at: 1bc8feaa7cc752fe3b902ccf83ae9332e40921db
X-next-at: ac6eb1c9efff97a4f02a0d094c9cc5fe314d4449
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281658>

What's cooking in git.git (Nov 2015, #04; Tue, 24)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Lots of little topics, most of which should go to maint/master fairly
quickly (actually, writing this I just realized that several of them
which I've annotated as "merge to master" can go to maint. I'm out of
time for today, so I'll fix that up in the next cycle).

There are a few topics which need review, especially from subsystem
folks. In some cases, they may simply need an Ack that the most recent
version of a series is OK.

You can find the normal integration branches at:

    https://github.com/git/git/

and all topic branches at:

    https://github.com/peff/git/

But note that I will _not_ be pushing to kernel.org.

--------------------------------------------------
[New Topics]

* bb/merge-marker-crlf (2015-11-24) 1 commit
 - merge-file: consider core.crlf when writing merge markers

 Write out merge markers using system end-of-line convention.

 Waiting for a re-roll to handle gitattributes.


* cb/ssl-config-pathnames (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at 658a9c9)
 + http: treat config options sslCAPath and sslCAInfo as paths

 Allow tilde-expansion in some http config variables.

 Will merge to 'master'.


* dk/gc-more-wo-pack (2015-11-24) 3 commits
 - gc: Clean garbage .bitmap files from pack dir
 - t5304: Add test for .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for review.


* dt/http-range (2015-11-11) 1 commit
  (merged to 'next' on 2015-11-24 at d342999)
 + http: fix some printf format warnings

 Portability fix for a topic already in 'master'.

 Will merge to 'master'.


* jk/send-email-ssl-errors (2015-11-24) 1 commit
 - send-email: enable SSL level 1 debug output

 Improve error reporting when SMTP TLS fails.

 Will merge to 'next'.


* mg/doc-word-diff-example (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at 5ba28db)
 + Documentation/diff: give --word-diff-regex=. example

 Will merge to 'master'.


* mr/ff-refs (2015-11-24) 5 commits
 - ff-refs: Add tests
 - ff-refs: Add documentation
 - ff-refs: add --dry-run and --skip-worktree options
 - ff-refs: update each updatable ref
 - ff-refs: builtin cmd to check and fast forward local refs to their upstream

 Specialized command to fast-forward refs to match their upstream.

 I remain skeptical that this is necessary or sufficient. Comments
 welcome.

 Will hold.


* ps/rebase-keep-empty (2015-11-24) 2 commits
 - rebase: fix preserving commits with --keep-empty
 - rebase: test broken behavior with --keep-empty

 Keep duplicate commits via rebase --keep-empty.

 I'm not sure if I agree with this interpretation of the "rebase
 --keep-empty" documentation, but I haven't thought too hard about it.
 Comments welcome.

 Waiting for review.


* rm/subtree-unwrap-tags (2015-11-24) 1 commit
 - contrib/subtree: unwrap tag refs

 Waiting for review from subtree folks.


* sg/bash-prompt-dirty-orphan (2015-11-24) 3 commits
  (merged to 'next' on 2015-11-24 at ac6eb1c)
 + bash prompt: indicate dirty index even on orphan branches
 + bash prompt: remove a redundant 'git diff' option
 + bash prompt: test dirty index and worktree while on an orphan branch

 Produce correct "dirty" marker for shell prompts, even when we
 are on an orphan branch.

 Will cook in 'next', then merge to 'master'.


* sg/filter-branch-dwim-ambiguity (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at fe596a6)
 + filter-branch: deal with object name vs. pathname ambiguity in tree-filter

 Fix for a corner case in filter-branch.

 Will merge to 'master'.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 - sh-setup: make require_clean_work_tree() work on orphan branches
 - Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.

 This series takes the conservative route of requiring scripts to opt
 into the looser behavior, at the expense of carrying around a new
 option-flag forever. I'm not sure if we need to do so. Comments
 welcome.

 Will merge to 'next' in a few days.


* tb/ls-files-eol (2015-11-24) 1 commit
 - ls-files: Add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 This latest round hasn't gotten any review yet.

 Waiting for review.

--------------------------------------------------
[Graduated to "master"]



* fp/subtree-todo-update (2015-11-06) 1 commit
  (merged to 'next' on 2015-11-20 at 3861698)
 + contrib/subtree: remove "push" command from the "todo" file

 Will merge to 'master'.


* rc/configure-use-libs-when-checking-a-lib (2015-11-06) 1 commit
  (merged to 'next' on 2015-11-20 at 37c26aa)
 + configure.ac: use $LIBS not $CFLAGS when testing -lpthread

 The "configure" script did not test for -lpthread correctly, which
 upset some linkers.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

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

* ar/doc-env-variable-format (2015-11-11) 1 commit
  (merged to 'next' on 2015-11-24 at 5ddf33e)
 + Documentation: make environment variable formatting more consistent

 Minor documentation fixup.

 Will merge to 'master'.


* ld/p4-detached-head (2015-11-24) 3 commits
  (merged to 'next' on 2015-11-24 at 36ab36a)
 + git-p4: work with a detached head
 + git-p4: add option to system() to return subshell status
 + git-p4: add failing test for submit from detached head

 Make git-p4 work on a detached head.

 Will merge to 'master'.


* cb/hook-sigpipe (2015-11-16) 1 commit
  (merged to 'next' on 2015-11-24 at 0bf4228)
 + allow hooks to ignore their standard input stream

 We now consistently allow all hooks to ignore their standard input,
 rather than having git complain of SIGPIPE.

 Will merge to 'master'.


* dg/subtree-test-cleanup (2015-11-13) 7 commits
  (merged to 'next' on 2015-11-24 at 1297941)
 + contrib/subtree: Handle '--prefix' argument with a slash appended
 + contrib/subtree: Make each test self-contained
 + contrib/subtree: Add split tests
 + contrib/subtree: Add merge tests
 + contrib/subtree: Add tests for subtree add
 + contrib/subtree: Add test for missing subtree
 + contrib/subtree: Clean and refactor test code

 Test cleanups for the subtree project.

 Will merge to 'master'.


* dk/check-ignore-docs (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at 0cce5c5)
 + check-ignore: correct documentation about output

 Documentation clarification for "check-ignore" without "--verbose".

 Will merge to 'master'.


* dk/rerere-train-quoting (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-24 at f9fa96e)
 + Escape Git's exec path in contrib/rerere-train.sh script

 Fix shell quoting in contrib script.

 Will merge to 'master'.


* dk/t5813-unc-paths (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-24 at 204e4a8)
 + t5813: avoid creating urls that break on cygwin

 Test portability fix for a topic in v2.6.1.

 Will merge to 'master'.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Needs review.


* fm/shell-path-whitespace (2015-11-13) 1 commit
  (merged to 'next' on 2015-11-24 at c2b8bdf)
 + rebase-i-exec: Allow space in SHELL_PATH

 Portability fix for Windows, which may rewrite $SHELL variable using
 non-POSIX paths.

 Will merge to 'master'.


* jk/filter-branch-no-index (2015-11-06) 1 commit
  (merged to 'next' on 2015-11-24 at e31946e)
 + filter-branch: skip index read/write when possible

 Speed up filter-branch for cases where we only care about rewriting
 commits, not tree data.

 Will merge to 'master' two cycles from now.


* jk/send-email-ca-path (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at 923b803)
 + send-email: die if CA path doesn't exist

 Use a safer behavior when we hit errors verifying remote certificates.

 Will merge to 'master'.


* jk/send-email-complete-aliases (2015-11-20) 2 commits
  (merged to 'next' on 2015-11-24 at a50094f)
 + completion: add support for completing email aliases
 + sendemail: teach git-send-email to dump alias names

 Teach send-email to dump mail aliases, so that we can do tab completion
 on the command line.

 Will merge to 'master' two cycles from now.


* jk/send-email-expand-paths (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-24 at d32fa4d)
 + send-email: expand path in sendemail.smtpsslcertpath config

 Expand paths in some send-email config variables.

 Will merge to 'master'.


* js/test-modernize-t9300 (2015-11-20) 7 commits
  (merged to 'next' on 2015-11-24 at d399494)
 + modernize t9300: move test preparations into test_expect_success
 + modernize t9300: mark here-doc words to ignore tab indentation
 + modernize t9300: use test_when_finished for clean-up
 + modernize t9300: wrap lines after &&
 + modernize t9300: use test_must_be_empty
 + modernize t9300: use test_must_fail
 + modernize t9300: single-quote placement and indentation

 Clean up style in an ancient test.

 Will merge to 'master'.


* ls/p4-test-timeouts (2015-11-20) 3 commits
  (merged to 'next' on 2015-11-24 at 905cff8)
 + git-p4: add trap to kill p4d on test exit
 + git-p4: add p4d timeout in tests
 + git-p4: retry kill/cleanup operations in tests with timeout

 Work around some test flakiness with p4d.

 Will merge to 'master'.


* ls/test-must-fail-sigpipe (2015-11-24) 3 commits
 - SQUASH???
 - add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
 - implement test_might_fail using a refactored test_must_fail

 Fix some racy client/server tests by treating SIGPIPE the same as a
 normal non-zero exit.

 Will hold pending logic cleanups.


* mc/push-recurse-submodules-config (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-24 at 3644d4b)
 + push: add recurseSubmodules config option

 Add new config to avoid typing "--recurse-submodules" on each push.

 Waiting for review from submodule folks.


* mk/blame-first-parent (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at a2ee2a4)
 + blame: fix object casting regression

 Regression fix for a topic already in master.

 Will merge to 'master'.


* np/credential-cache-sighup (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-24 at 410167f)
 + credential-cache: new option to ignore sighup

 Workaround for using credential-cache with emacs.

 Will merge to 'master' two cycles from now.


* rs/fsck-nul-header (2015-11-20) 2 commits
  (merged to 'next' on 2015-11-24 at 093b3d6)
 + fsck: treat a NUL in a tag header as an error
 + t1450: add tests for NUL in headers of commits and tags

 Fsck did not correctly detect a NUL-truncated header in a tag.

 Will merge to 'master'.


* rs/parseopt-short-help (2015-11-20) 5 commits
  (merged to 'next' on 2015-11-24 at f22b6e0)
 + show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP
 + grep: stop using PARSE_OPT_NO_INTERNAL_HELP
 + parse-options: allow -h as a short option
 + parse-options: inline parse_options_usage() at its only remaining caller
 + parse-options: deduplicate parse_options_usage() calls

 Make "-h" command line option work more consistently in all commands.

 Needs review.


* dt/refs-backend-pre-vtable (2015-11-20) 10 commits
  (merged to 'next' on 2015-11-24 at 8fd7293)
 + refs: break out ref conflict checks
 + files_log_ref_write: new function
 + initdb: make safe_create_dir public
 + refs: split filesystem-based refs code into a new file
 + refs/refs-internal.h: new header file
 + refname_is_safe(): improve docstring
 + pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
 + copy_msg(): rename to copy_reflog_msg()
 + verify_refname_available(): new function
 + verify_refname_available(): rename function

 Code preparation for pluggable ref backends.

 Will cook in 'next'.


* ad/sha1-update-chunked (2015-11-05) 2 commits
 - sha1: allow limiting the size of the data passed to SHA1_Update()
 - sha1: provide another level of indirection for the SHA-1 functions

 Apple's common crypto implementation of SHA1_Update() does not take
 more than 4GB at a time, and we now have a compile-time workaround
 for it.

 Will merge to 'next'.


* vl/grep-configurable-threads (2015-11-01) 1 commit
 - grep: add --threads=<num> option and grep.threads configuration

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 I haven't reviewed v6 yet. More eyes are welcome.

 Needs review.


* kf/http-proxy-auth-methods (2015-11-04) 3 commits
 . SQUASH???
 . http: use credential API to handle proxy authentication
 . http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 I ejected this from pu for the moment, as it conflicts with the
 pt/http-socks-proxy topic.

 Still being worked on.
 ($gmane/280925).


* sb/submodule-parallel-update (2015-11-20) 27 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.jobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 - run_processes_parallel: delimit intermixed task output
 - Merge branch 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update
 - Merge branch 'sb/submodule-parallel-fetch' into sb/submodule-parallel-update
  (merged to 'next' on 2015-11-20 at 89fc723)
 + strbuf: update documentation for strbuf_read_once()
 + run-command: remove set_nonblocking()
  (merged to 'next' on 2015-10-23 at 8f04bbd)
 + run-command: fix missing output from late callbacks
 + test-run-command: increase test coverage
 + test-run-command: test for gracefully aborting
 + run-command: initialize the shutdown flag
 + run-command: clear leftover state from child_process structure
 + run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is tangled with sb/submodule-parallel-fetch.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Waiting for sb/submodule-parallel-fetch to stabilize.

 It would be the cleanest to rebuild sb/submodule-parallel-fetch on
 top of 2.7.0 once it ships and then build this directly on top;
 that way, we do not have to have merges in this topic that
 distracting (besides, some part of the other topic can be updated
 in-place instead of this follow-up topic tweaking them as past
 mistakes and inflexibilities).

 I picked up v4 from the list, but it needs review.


* jc/strbuf-gets (2015-10-28) 17 commits
 - test-sha1-array: read command stream with strbuf_gets()
 - grep: read -f file with strbuf_gets()
 - send-pack: read list of refs with strbuf_gets()
 - column: read lines with strbuf_gets()
 - cat-file: read batch stream with strbuf_gets()
 - transport-helper: read helper response with strbuf_gets()
 - clone/sha1_file: read info/alternates with strbuf_gets()
 - remote.c: read $GIT_DIR/remotes/* with strbuf_gets()
 - ident.c: read /etc/mailname with strbuf_gets()
 - rev-parse: read parseopt spec with strbuf_gets()
 - revision: read --stdin with strbuf_gets()
 - hash-object: read --stdin-paths with strbuf_gets()
 - mktree: read textual tree representation with strbuf_gets()
 - update-index: read list of paths with strbuf_gets() under --stdin
 - update-index: read --index-info with strbuf_gets()
 - check-attr, check-ignore, checkout-index: read paths with strbuf_gets()
 - strbuf: add strbuf_gets()

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Waiting for reviews.


* eg/p4-submit-catch-failure (2015-11-24) 1 commit
  (merged to 'next' on 2015-11-24 at cf2dc76)
 + git-p4: clean up after p4 submit failure

 Just like the working tree is cleaned up when the user cancelled
 submission in P4Submit.applyCommit(), clean up the mess if "p4
 submit" fails.

 Will merge to 'master'.


* ep/ident-with-getaddrinfo (2015-10-30) 1 commit
 - (NEEDSWORK $gmane/280507) ident.c: add support for IPv6

 A build without NO_IPv6 used to use gethostbyname() when guessing
 user's hostname, instead of getaddrinfo() that is used in other
 codepaths in such a build.

 Waiting for a reroll.
 ($gmane/280507)


* pt/http-socks-proxy (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-20 at dc6ae48)
 + remote-http(s): support SOCKS proxies

 Add support for talking http/https over socks proxy.

 Will merge to 'master'.


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
  (merged to 'next' on 2015-10-23 at 8a697f0)
 + notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 As the patch was done on top of the 'drop old-syntax from merge',
 this has to wait until that other topic can graduate, unfortunately.
 It can be redone in a way that does not depend on that topic after
 this cycle, though.

 Will keep in 'next'.


* jc/mailinfo (2015-10-21) 1 commit
 - mailinfo: ignore in-body header that we do not care about

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 I have a feeling that that this is a step in a wrong direction.
 Comments?


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-23 at dc631e5)
 + am: make a direct call to merge_recursive
 + merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, we would want to see it backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will keep in 'next'.


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


* sb/submodule-parallel-fetch (2015-11-24) 17 commits
 . run-command: detect finished children by closed pipe rather than waitpid
  (merged to 'next' on 2015-11-20 at 89fc723)
 + strbuf: update documentation for strbuf_read_once()
 + run-command: remove set_nonblocking()
  (merged to 'next' on 2015-10-23 at 8f04bbd)
 + run-command: fix missing output from late callbacks
 + test-run-command: increase test coverage
 + test-run-command: test for gracefully aborting
 + run-command: initialize the shutdown flag
 + run-command: clear leftover state from child_process structure
 + run-command: fix early shutdown
  (merged to 'next' on 2015-10-15 at df63590)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread_nonblock: add functionality to read from fds without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is tangled with sb/submodule-parallel-update.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Is everybody happy with the topic commit?

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

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.

 Will keep in 'next'.
