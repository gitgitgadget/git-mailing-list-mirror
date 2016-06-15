From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2013, #08; Wed, 30)
Date: Wed, 30 Oct 2013 15:18:46 -0700
Message-ID: <xmqqob669zcp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 23:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbe6K-0006YH-Vb
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 23:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab3J3WSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 18:18:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482Ab3J3WSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 18:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C32354EB01;
	Wed, 30 Oct 2013 18:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	OLxi3FUerRtTUxq525Jwp1Ul9U=; b=tay1HsfZ9PJtWEfiiva3iwKg5YmC3MHMt
	DptpNwK+Qya7EIgRFl7pF21FUGebQKpGBS+3dbqgdSJlVDDmvEgoGc6yFhRo192W
	MzVHUMn5fV3+GVsRkRufM+zfDKdWDfJrsPEMvaYJkYp+em/FSMrDzqLmcB+JfcPU
	qfG/2fIUq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=kHB
	SngN1CfSSYprRxokeuYw2jAvPDYoH1tWkBAiPvwrns8oTMB3Dxf2qIujrk4b9pwx
	uByfZ70bGvBllOy+QEcM4mvc1UV3f6yIqcRlYkVcdYFvhFjeo21CDpiWGGgSSGxz
	6gQuGrrZT5m1QIQI3T8i8Zqc3267CQkZaAikCuIc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAD9B4EAFF;
	Wed, 30 Oct 2013 18:18:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB0AE4EAFE;
	Wed, 30 Oct 2013 18:18:48 -0400 (EDT)
X-master-at: 42817b96b1b80b56fd5a4d5e0d6239524b1832a3
X-next-at: a9bf06aa4c8db76465f9b7c11b2704229b2adb5a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3FE7886E-41B1-11E3-B5E3-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237074>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

An early preview 1.8.5-rc0 has been tagged. There still are handful
of fixes and enhancements left in 'next' that I'd like to see in the
final, which will hopefully be in when the first release candidate
is tagged.

As promised/requested, the final steps for 2.0 are in 'next'; they,
together with a handful topics that have been merged to 'next'
fairly recently, will _not_ be part of the upcoming 1.8.5 release,
but will be carried over in 'next' to the next cycle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* fc/styles (2013-10-16) 7 commits
  (merged to 'next' on 2013-10-28 at cf592ed)
 + block-sha1/sha1.c: have SP around arithmetic operators
 + base85.c: have SP around arithmetic operators
 + archive.c: have SP around arithmetic operators
 + alloc.c: have SP around arithmetic operators
 + abspath.c: have SP around arithmetic operators
 + alias: have SP around arithmetic operators
 + C: have space around && and || operators

 C coding style fixes.


* hn/log-graph-color-octopus (2013-10-18) 1 commit
  (merged to 'next' on 2013-10-28 at e103175)
 + graph: fix coloring around octopus merges


* jc/upload-pack-send-symref (2013-10-22) 10 commits
  (merged to 'next' on 2013-10-23 at 8ef5660)
 + t5570: Update for clone-progress-to-stderr branch
 + Merge branch 'jk/clone-progress-to-stderr' into jc/upload-pack-send-symref
 + t5570: Update for symref capability
  (merged to 'next' on 2013-10-16 at eb1ae25)
 + clone: test the new HEAD detection logic
 + connect: annotate refs with their symref information in get_remote_head()
 + connect.c: make parse_feature_value() static
 + upload-pack: send non-HEAD symbolic refs
 + upload-pack: send symbolic ref information as capability
 + upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 + t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.


* jk/date-c-double-semicolon (2013-10-24) 1 commit
  (merged to 'next' on 2013-10-28 at 00ce440)
 + drop redundant semicolon in empty while


* jk/http-auth-redirects (2013-10-24) 10 commits
  (merged to 'next' on 2013-10-24 at 4bebb66)
 + http.c: Spell the null pointer as NULL
 + remote-curl: rewrite base url from info/refs redirects
 + remote-curl: store url as a strbuf
 + remote-curl: make refs_url a strbuf
 + http: update base URLs when we see redirects
 + http: provide effective url to callers
 + http: hoist credential request out of handle_curl_result
  (merged to 'next' on 2013-10-14 at a0642be)
 + http: refactor options to http_get_*
 + http_request: factor out curlinfo_strbuf
 + http_get_file: style fixes

 Handle the case where http transport gets redirected during the
 authorization request better.


* jk/refs-c-squelch-gcc (2013-10-24) 1 commit
  (merged to 'next' on 2013-10-28 at d15f7c2)
 + silence gcc array-bounds warning


* jl/pack-transfer-avoid-double-close (2013-10-23) 1 commit
  (merged to 'next' on 2013-10-28 at 4a55bba)
 + Clear fd after closing to avoid double-close error

 The codepath that send_pack() calls pack_objects() mistakenly
 closed the same file descriptor twice, leading to potentially
 closing a wrong file descriptor that was opened in the meantime.


* mm/checkout-auto-track-fix (2013-10-18) 2 commits
  (merged to 'next' on 2013-10-28 at f4594ba)
 + checkout: proper error message on 'git checkout foo bar --'
 + checkout: allow dwim for branch creation for "git checkout $branch --"

 "git checkout topic", when there is not yet a local "topic" branch
 but there is a unique remote-tracking branch for a remote "topic"
 branch, pretended as if "git checkout -t -b topic remote/$r/topic"
 (for that unique remote $r) was run. This hack however was not
 implemented for "git checkout topic --".


* nd/gc-lock-against-each-other (2013-10-18) 1 commit
  (merged to 'next' on 2013-10-28 at 14bd458)
 + gc: remove gc.pid file at end of execution


* nd/lift-path-max (2013-10-24) 2 commits
  (merged to 'next' on 2013-10-28 at 07698af)
 + checkout_entry(): clarify the use of topath[] parameter
 + entry.c: convert checkout_entry to use strbuf


* nd/magic-pathspec (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at 50eda68)
 + Fix calling parse_pathspec with no paths nor PATHSPEC_PREFER_* flags

 All callers to parse_pathspec() must choose between getting no
 pathspec or one path that is limited to the current directory
 when there is no paths given on the command line, but there were
 two callers that violated this rule, triggering a BUG().


* sb/git-svn-docs-indent-with-ht (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at 8a952d1)
 + git-svn docs: Use tabs consistently within the ascii doc


* sg/t3600-nul-sha1-fix (2013-10-16) 1 commit
  (merged to 'next' on 2013-10-28 at ac4b703)
 + t3600: fix broken "choking git rm" test


* tr/gitk-doc-update (2013-10-22) 1 commit
  (merged to 'next' on 2013-10-28 at f4158b8)
 + Documentation: revamp gitk(1)


* tr/valgrind-test-fix (2013-10-22) 2 commits
  (merged to 'next' on 2013-10-28 at 4d3f31a)
 + Revert "test-lib: allow prefixing a custom string before "ok N" etc."
 + Revert "test-lib: support running tests under valgrind in parallel"

--------------------------------------------------
[New Topics]

* jn/test-prereq-perl-doc (2013-10-28) 1 commit
 - t/README: tests can use perl even with NO_PERL

 Will merge to 'next'.


* ak/cvsserver-stabilize-use-of-hash-keys (2013-10-30) 1 commit
 - cvsserver: Determinize output to combat Perl 5.18 hash randomization

 Will merge to 'next'.


* jk/replace-perl-in-built-scripts (2013-10-29) 1 commit
 - use @@PERL@@ in built scripts

 Will merge to 'next'.


* jk/subtree-install-fix (2013-10-30) 1 commit
 - subtree: add makefile target for html docs

 Will merge to 'next'.


* jk/wrap-perl-used-in-tests (2013-10-29) 2 commits
 - t: use perl instead of "$PERL_PATH" where applicable
 - t: provide a perl() function which uses $PERL_PATH

 Will merge to 'next'.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

--------------------------------------------------
[Stalled]

* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.


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


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


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

* sc/doc-howto-dumb-http (2013-10-28) 1 commit
 - doc/howto: warn about (dumb)http server document being too old

 Will merge to 'next'.


* bw/solaris-sed-tr-test-portability (2013-10-30) 2 commits
 - Avoid difference in tr semantics between System V and BSD
 - Change sed i\ usage to something Solaris' sed can handle

 The bottom one may want to lose the "\<nl>" that seems to be a
 no-op.


* fc/transport-helper-fixes (2013-10-28) 13 commits
 - test: remote-helper: add test for force pushes
 - git-remote-testgit: support the new 'force' option
 - fixup! transport-helper: add 'force' to 'export' helpers
 - transport-helper: don't update refs in dry-run
 - transport-helper: add support to delete branches
 - fast-export: add support to delete refs
 - fast-import: add support to delete refs
 - transport-helper: add support for old:new refspec
 - fast-export: add new --refspec option
 - fast-export: improve argument parsing
 - transport-helper: check for 'forced update' message
 - transport-helper: fix extra lines
 - transport-helper: add 'force' to 'export' helpers

 This may need to be rerolled, taking review comments and
 discussions into account.


* jh/loose-object-dirs-creation-race (2013-10-28) 1 commit
 - sha1_file.c:create_tmpfile(): Fix race when creating loose object dirs

 Will merge to 'next'.


* js/test-help-format-windows-port-fix (2013-10-30) 1 commit
  (merged to 'next' on 2013-10-30 at b98e991)
 + t3200: do not open a HTML manual page when DEFAULT_MAN_FORMAT is html

 Will merge to 'master'.


* js/tests-windows-port-fix (2013-10-28) 3 commits
  (merged to 'next' on 2013-10-30 at 61f8e24)
 + tests: undo special treatment of CRLF for Windows
 + Windows: a test_cmp that is agnostic to random LF <> CRLF conversions
 + t5300-pack-object: do not compare binary data using test_cmp

 Will merge to 'master'.


* nd/liteal-pathspecs (2013-10-28) 1 commit
 - pathspec: stop --*-pathspecs impact on internal parse_pathspec() uses

 Will merge to 'next'.


* rs/web-browse-xdg-open (2013-10-30) 1 commit
  (merged to 'next' on 2013-10-30 at 37d6eb4)
 + web--browse: Add support for xdg-open

 Will merge to 'master'.


* sb/refs-code-cleanup (2013-10-28) 2 commits
  (merged to 'next' on 2013-10-30 at a9bf06a)
 + cache: remove unused function 'have_git_dir'
 + refs: remove unused function invalidate_ref_cache

 Will merge to 'master'.


* th/reflog-annotated-tag (2013-10-28) 1 commit
 - reflog: handle lightweight and annotated tags equally

 Will merge to 'next'.


* tr/merge-recursive-index-only (2013-10-28) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()


* bc/http-100-continue (2013-10-29) 1 commit
 - remote-curl: fix large pushes with GSSAPI

 Conditionally allow "100 Continue" responses to help use of
 GSS-Negotiate authentication scheme over HTTP transport.

 Still being updated, but it seems like we are getting there.


* jc/merge-base-reflog (2013-10-29) 2 commits
 - merge-base: teach "--fork-point" mode
 - merge-base: use OPT_CMDMODE and clarify the command line parsing

 Code the logic in "pull --rebase" that figures out a fork point
 from reflog entries in C.

 Will merge to 'next'.


* jk/for-each-ref-skip-parsing (2013-10-30) 1 commit
  (merged to 'next' on 2013-10-30 at 56ea310)
 + for-each-ref: avoid loading objects to print %(objectname)

 Will merge to 'master'.


* jk/pack-bitmap (2013-10-30) 20 commits
 - count-objects: recognize .bitmap in garbage-checking
 - pack-bitmap: implement optional name_hash cache
 - t: add basic bitmap functionality tests
 - repack: consider bitmaps when performing repacks
 - repack: handle optional files created by pack-objects
 - repack: turn exts array into array-of-struct
 - repack: stop using magic number for ARRAY_SIZE(exts)
 - pack-objects: implement bitmap writing
 - rev-list: add bitmap mode to speed up object lists
 - pack-objects: use bitmaps when packing objects
 - pack-bitmap: add support for bitmap indexes
 - documentation: add documentation for the bitmap format
 - ewah: compressed bitmap implementation
 - compat: add endianness helpers
 - sha1_file: export `git_open_noatime`
 - revision: allow setting custom limiter function
 - pack-objects: factor out name_hash
 - pack-objects: refactor the packing list
 - revindex: export new APIs
 - sha1write: make buffer const-correct

 Borrows the bitmap index into packfiles from JGit to speed up
 enumeration of objects involved in a commit range without having to
 fully traverse the history.

 Still under discussion.


* jk/robustify-parse-commit (2013-10-24) 6 commits
 - checkout: do not die when leaving broken detached HEAD
 - use parse_commit_or_die instead of custom message
 - use parse_commit_or_die instead of segfaulting
 - assume parse_commit checks for NULL commit
 - assume parse_commit checks commit->object.parsed
 - log_tree_diff: die when we fail to parse a commit

 Will merge to 'next' after taking another look.


* mh/fetch-tags-in-addition-to-normal-refs (2013-10-30) 23 commits
 - fetch: improve the error messages emitted for conflicting refspecs
 - handle_duplicate(): mark error message for translation
 - ref_remote_duplicates(): extract a function handle_duplicate()
 - ref_remove_duplicates(): simplify loop logic
 - t5536: new test of refspec conflicts when fetching
 - ref_remove_duplicates(): avoid redundant bisection
 - git-fetch.txt: improve description of tag auto-following
 - fetch-options.txt: simplify ifdef/ifndef/endif usage
 - fetch, remote: properly convey --no-prune options to subprocesses
 - builtin/remote.c:update(): use struct argv_array
 - builtin/remote.c: reorder function definitions
 - query_refspecs(): move some constants out of the loop
 - fetch --prune: prune only based on explicit refspecs
 - fetch --tags: fetch tags *in addition to* other stuff
 - fetch: only opportunistically update references based on command line
 - get_expanded_map(): avoid memory leak
 - get_expanded_map(): add docstring
 - builtin/fetch.c: reorder function definitions
 - get_ref_map(): rename local variables
 - api-remote.txt: correct section "struct refspec"
 - t5510: check that "git fetch --prune --tags" does not prune branches
 - t5510: prepare test refs more straightforwardly
 - t5510: use the correct tag name in test

 Will merge to 'next' after taking another look.


* jk/pack-corruption-post-mortem (2013-10-25) 1 commit
  (merged to 'next' on 2013-10-30 at 2248df6)
 + howto: add article on recovering a corrupted object

 Will merge to 'master'.


* jk/reset-p-current-head-fix (2013-10-25) 2 commits
  (merged to 'next' on 2013-10-30 at 37ae6e0)
 + reset: pass real rev name to add--interactive
 + add-interactive: handle unborn branch in patch mode

 "git reset -p HEAD" has codepath to special case it from resetting
 to contents of other commits, but recent change broke it.

 Will merge to 'master'.


* nv/parseopt-opt-arg (2013-10-25) 1 commit
 - rev-parse --parseopt: add the --sticked-long mode

 Enhance "rev-parse --parseopt" mode to help parsing options with
 an optional parameter.

 Option name bikeshedding aside ("Is it sticked or stuck?"), the
 change seems to be competently done.


* ap/remote-hg-unquote-cquote (2013-10-23) 1 commit
  (merged to 'next' on 2013-10-28 at 6b99fd5)
 + remote-hg: unquote C-style paths when exporting

 A fast-import stream expresses a pathname with funny characters by
 quoting them in C style; remote-hg remote helper forgot to unquote
 such a path.

 Will merge to 'master'.


* ak/submodule-foreach-quoting (2013-09-27) 1 commit
  (merged to 'next' on 2013-10-14 at d77c5f1)
 + submodule foreach: skip eval for more than one argument

 A behavior change, but a worthwhile one: "git submodule foreach"
 was treating its arguments as part of a single command to be
 concatenated and passed to a shell, making writing buggy
 scripts too easy.

 This patch preserves the old "just pass it to the shell" behavior
 when a single argument is passed to 'git submodule foreach' and
 moves to a new "skip the shell and use the arguments passed
 unmolested" behavior when more than one argument is passed.

 The old behavior (always concatenating and passing to the shell)
 was similar to the 'ssh' command, while the new behavior (switching
 on the number of arguments) is what 'xterm -e' does.

 May need more thought to make sure this change is advertised well
 so that scripts that used multiple arguments but added their own
 extra layer of quoting are not broken.

 Will cook in 'next' for the rest of this cycle.


* jl/submodule-mv (2013-10-13) 1 commit
  (merged to 'next' on 2013-10-28 at 8dc9b31)
 + mv: Fix spurious warning when moving a file in presence of submodules

 Moving a regular file in a repository with a .gitmodules file was
 producing a warning 'Could not find section in .gitmodules where
 path=<filename>'.

 Will merge to 'master'.


* kb/fast-hashmap (2013-10-22) 12 commits
 - remove old hash.[ch] implementation
 - read-cache.c: fix memory leaks caused by removed cache entries
 - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
 - name-hash.c: use new hash map implementation for cache entries
 - name-hash.c: remove unreferenced directory entries
 - name-hash.c: use new hash map implementation for directories
 - diffcore-rename.c: use new hash map implementation
 - diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: move code around to prepare for the next patch
 - buitin/describe.c: use new hash map implementation
 - add a hashtable implementation that supports O(1) removal
 - submodule: don't access the .gitmodules cache entry after removing it

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.

 The preparatory clean-up to submodule from Jens is at the bottom. I
 also squashed in a fix-up by Karsten found at $gmane/236468 (please
 double-check the result).

 More valgrind breakage reported ($gmane/236869).


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
  (merged to 'next' on 2013-10-28 at d8cdf30)
 + git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
  (merged to 'next' on 2013-10-28 at f1bec96)
 + core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
  (merged to 'next' on 2013-10-28 at 3153a9e)
 + push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
  (merged to 'next' on 2013-10-28 at 5fd76ec)
 + git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will merge to and cook in 'next' until a distant future.
