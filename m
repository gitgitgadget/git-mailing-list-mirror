From: Jeff King <peff@peff.net>
Subject: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Fri, 20 Nov 2015 09:09:37 -0500
Message-ID: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 15:09:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzmNp-0003PQ-R2
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 15:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934913AbbKTOJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 09:09:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:60153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934869AbbKTOJk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 09:09:40 -0500
Received: (qmail 32021 invoked by uid 102); 20 Nov 2015 14:09:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 08:09:40 -0600
Received: (qmail 27758 invoked by uid 107); 20 Nov 2015 14:10:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 09:10:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 09:09:37 -0500
Content-Disposition: inline
X-master-at: 0c83680e9c047170614fb08ef222ea4f460e514d
X-next-at: dc6ae483b6062dec4979462c5b072d883a323fee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281521>

What's cooking in git.git (Nov 2015, #03; Fri, 20)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Sorry for the extreme delay in pushing out my tree. I ended up busier
than I expected during the first week of Junio's absence, and then it
took me a while to dig myself out of the ever-filling hole of incoming
topics. :)

Expect quite a few new topics in this edition.  A number of them have
seen review already, and I'm planning to merge them to "next" fairly
quickly (I may do another integration cycle late tonight or tomorrow
with those changes).

I still have a few threads to comb through on the list. If you don't see
the latest version of your topic here, please feel free to ping me, or
to repost.

You can find the normal integration branches at:

    https://github.com/git/git/

and all topic branches at:

    https://github.com/peff/git/

But note that I will _not_ be pushing to kernel.org.


--------------------------------------------------
[New Topics]

* ap/doc-env-variable-format (2015-11-11) 1 commit
 - Documentation: make environment variable formatting more consistent

 Minor documentation fixup.

 Will merge to 'next'.


* cb/hook-sigpipe (2015-11-16) 1 commit
 - allow hooks to ignore their standard input stream

 We now consistently allow all hooks to ignore their standard input,
 rather than having git complain of SIGPIPE.

 Will merge to 'next'.


* dg/subtree-test-cleanup (2015-11-13) 7 commits
 - contrib/subtree: Handle '--prefix' argument with a slash appended
 - contrib/subtree: Make each test self-contained
 - contrib/subtree: Add split tests
 - contrib/subtree: Add merge tests
 - contrib/subtree: Add tests for subtree add
 - contrib/subtree: Add test for missing subtree
 - contrib/subtree: Clean and refactor test code

 Test cleanups for the subtree project.

 Will merge to 'next'.


* dk/check-ignore-docs (2015-11-20) 1 commit
 - check-ignore: correct documentation about output

 Documentation clarification for "check-ignore" without "--verbose".

 This may be losing information, and we would want to enhance the
 "--verbose" documentation.

 Will hold for comments.


* dk/rerere-train-quoting (2015-11-20) 1 commit
 - Escape Git's exec path in contrib/rerere-train.sh script

 Fix shell quoting in contrib script.

 Will merge to 'next'.


* dk/t5813-unc-paths (2015-11-20) 1 commit
 - t5813: avoid creating urls that break on cygwin

 Test portability fix for a topic in v2.6.1.

 Will merge to 'next'.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Needs review.


* fm/shell-path-whitespace (2015-11-13) 1 commit
 - rebase-i-exec: Allow space in SHELL_PATH

 Portability fix for Windows, which may rewrite $SHELL variable using
 non-POSIX paths.

 Will merge to 'next'.


* jk/filter-branch-no-index (2015-11-06) 1 commit
 - filter-branch: skip index read/write when possible

 Speed up filter-branch for cases where we only care about rewriting
 commits, not tree data.

 Needs review.


* jk/send-email-ca-path (2015-11-20) 1 commit
 - send-email: die if CA path doesn't exist

 Use a safer behavior when we hit errors verifying remote certificates.

 We may want to update this to guide users toward workarounds.


* jk/send-email-complete-aliases (2015-11-20) 2 commits
 - completion: add support for completing email aliases
 - sendemail: teach git-send-email to dump alias names

 Teach send-email to dump mail aliases, so that we can do tab completion
 on the command line.

 This is v4. Is everybody happy with this one?


* jk/send-email-expand-paths (2015-11-20) 2 commits
 - send-email: expand paths in sendemail.{to,cc}cmd config
 - send-email: expand path in sendemail.smtpsslcertpath config

 Expand paths in some send-email config variables.

 Needs review.


* js/test-modernize-t9300 (2015-11-20) 7 commits
 - modernize t9300: move test preparations into test_expect_success
 - modernize t9300: mark here-doc words to ignore tab indentation
 - modernize t9300: use test_when_finished for clean-up
 - modernize t9300: wrap lines after &&
 - modernize t9300: use test_must_be_empty
 - modernize t9300: use test_must_fail
 - modernize t9300: single-quote placement and indentation

 Clean up style in an ancient test.

 Will merge to 'next'.


* ls/p4-test-timeouts (2015-11-20) 3 commits
 - git-p4: add trap to kill p4d on test exit
 - git-p4: add p4d timeout in tests
 - git-p4: retry kill/cleanup operations in tests with timeout

 Work around some test flakiness with p4d.

 Will merge to 'next'.


* ls/test-must-fail-sigpipe (2015-11-20) 2 commits
 - add "ok=sigpipe" to test_must_fail and use it to fix flaky tests
 - implement test_might_fail using a refactored test_must_fail

 Fix some racy client/server tests by treating SIGPIPE the same as a
 normal non-zero exit.

 Will merge to 'next'.


* mc/push-recurse-submodules-config (2015-11-20) 1 commit
 - push: add recurseSubmodules config option

 Add new config to avoid typing "--recurse-submodules" on each push.

 People seemed to like v1, but v2 didn't see a lot of review. Is
 everybody happy?


* mk/blame-first-parent (2015-11-20) 1 commit
 - blame: fix object casting regression

 Regression fix for a topic already in master.

 Will merge to 'next'.


* np/credential-cache-sighup (2015-11-20) 1 commit
 - credential-cache: new option to ignore sighup

 Workaround for using credential-cache with emacs.

 Will merge to 'next'.


* rs/fsck-nul-header (2015-11-20) 2 commits
 - fsck: treat a NUL in a tag header as an error
 - t1450: add tests for NUL in headers of commits and tags

 Fsck did not correctly detect a NUL-truncated header in a tag.

 Will merge to 'next'.


* rs/parseopt-short-help (2015-11-20) 5 commits
 - show-ref: stop using PARSE_OPT_NO_INTERNAL_HELP
 - grep: stop using PARSE_OPT_NO_INTERNAL_HELP
 - parse-options: allow -h as a short option
 - parse-options: inline parse_options_usage() at its only remaining caller
 - parse-options: deduplicate parse_options_usage() calls

 Make "-h" command line option work more consistently in all commands.

 Needs review.


--------------------------------------------------
[Graduated to "master"]

* dg/git-svn-empty-dirs (2015-11-05) 1 commit
 - git-svn: improve rebase/mkdirs performance

 This came via a pull from Eric's git-svn tree, and I dropped the
 topic branch that Junio had created.


* dk/gc-idx-wo-pack (2015-11-04) 3 commits
  (merged to 'next' on 2015-11-05 at af058fa)
 + gc: remove garbage .idx files from pack dir
 + t5304: test cleaning pack garbage
 + prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without corresponding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 We may want to do the same for .bitmap (and notice but not prune
 .keep) without corresponding .pack, but that can be a separate
 topic.


* lf/ref-is-hidden-namespace (2015-11-05) 4 commits
  (merged to 'next' on 2015-11-05 at b245404)
 + t5509: add basic tests for hideRefs
 + hideRefs: add support for matching full refs
 + upload-pack: strip refs before calling ref_is_hidden()
 + config.txt: document the semantics of hideRefs with namespaces

 Extend transfer.hideRefs to work better with use of namespaces.


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

* dt/refs-backend-pre-vtable (2015-11-20) 10 commits
 - refs: break out ref conflict checks
 - files_log_ref_write: new function
 - initdb: make safe_create_dir public
 - refs: split filesystem-based refs code into a new file
 - refs/refs-internal.h: new header file
 - refname_is_safe(): improve docstring
 - pack_if_possible_fn(): use ref_type() instead of is_per_worktree_ref()
 - copy_msg(): rename to copy_reflog_msg()
 - verify_refname_available(): new function
 - verify_refname_available(): rename function

 Code preparation for pluggable ref backends.

 This is the slimmed-down version from Michael, v8. It applies a lot
 more pleasantly than the old one.

 Will merge to 'next'.


* rc/configure-use-libs-when-checking-a-lib (2015-11-06) 1 commit
  (merged to 'next' on 2015-11-20 at 37c26aa)
 + configure.ac: use $LIBS not $CFLAGS when testing -lpthread

 The "configure" script did not test for -lpthread correctly, which
 upset some linkers.

 Will merge to 'master'.


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


* fp/subtree-todo-update (2015-11-06) 1 commit
  (merged to 'next' on 2015-11-20 at 3861698)
 + contrib/subtree: remove "push" command from the "todo" file

 Will merge to 'master'.


* sb/submodule-parallel-update (2015-11-20) 11 commits
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
 (this branch uses sb/submodule-parallel-fetch.)

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


* eg/p4-submit-catch-failure (2015-10-30) 1 commit
 - git-p4: clean up after p4 submit failure

 Just like the working tree is cleaned up when the user cancelled
 submission in P4Submit.applyCommit(), clean up the mess if "p4
 submit" fails.

 Needs an update to test.
 ($gmane/280539)


* ep/ident-with-getaddrinfo (2015-10-30) 1 commit
 - (NEEDSWORK $gmane/280507) ident.c: add support for IPv6

 A build without NO_IPv6 used to use gethostbyname() when guessing
 user's hostname, instead of getaddrinfo() that is used in other
 codepaths in such a build.

 Waiting for a reroll.
 ($gmane/280507)


* jc/test-must-fail-with-sigpipe (2015-10-30) 1 commit
 . test: accept death by SIGPIPE as a valid failure mode

 Discarded in favor of ls/test-must-fail-sigpipe.

* pt/http-socks-proxy (2015-11-20) 1 commit
  (merged to 'next' on 2015-11-20 at dc6ae48)
 + remote-http(s): support SOCKS proxies

 Add support for talking http/https over socks proxy.

 Will cook in 'next'.


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


* sb/submodule-parallel-fetch (2015-11-05) 16 commits
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
 (this branch is used by sb/submodule-parallel-update.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 I merged the removal of the non-blocking descriptors to 'next'.

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
