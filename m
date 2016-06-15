From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Nov 2015, #02; Fri, 6)
Date: Fri, 06 Nov 2015 15:41:24 -0800
Message-ID: <xmqq4mgy3dcr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 00:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuqdU-0005xr-Aw
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 00:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbbKFXlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 18:41:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757848AbbKFXl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 18:41:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BF8029D1E;
	Fri,  6 Nov 2015 18:41:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	gZk5c+0fzKPLxLFkT7ZgpZ7KD0=; b=pekA46Kly0Hh9jKywNIRYhGf9ztJZN2lX
	knUYdmxazKRezDBIib6PF5/HOAJyyWKsUzCUrqmy73rdsJ5fjR3bx/35PAyWbYPX
	wKaShLOPwh2N0/+zdFJ1W4wibBBM/8wA01FjhwLPx1Y/MDXrYikFYe7d+6JVNKqU
	d37LWfZyRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=d31
	uS+dITIdrfWnNb3fENBQUhWUsvLcBrp3ylgtgRdWc2k3uATVm8u4V6U/K8YiJKqb
	PPAoeXoc9QABRKRAmB5FyJCUECwlks3zScHiP2NhWg/t1rLmCLpfhk6UVrMICk2M
	znIKJriS+Ulmg73WrDQH1VhXFv17u/AAbWj5ksFA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 233D329D1D;
	Fri,  6 Nov 2015 18:41:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A6CE29D1B;
	Fri,  6 Nov 2015 18:41:25 -0500 (EST)
X-master-at: f34be46e47773d03e9d09641209121591a6b37c8
X-next-at: c10b11f912265621bc9c1988f048b8c065303d87
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4B7E096-84DF-11E5-9445-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281007>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

I'll be offline for a few weeks, and Jeff King graciously agreed to
help shepherd the project forward in the meantime as an interim
maintainer.  Please be gentle.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* dt/refs-backend-pre-vtable (2015-11-03) 26 commits
 - refs: break out ref conflict checks
 - refs: create a shared version of verify_refname_available
 - files_log_ref_write: new function
 - initdb: make safe_create_dir public
 - refs: move should_autocreate_reflog to common code
 - refs: move peel_object to the common code
 - refs: move copy_msg to the common code
 - refs: move refname_is_safe to the common code
 - refs: move transaction functions to the common code
 - refs: move head_ref_namespaced to the common code
 - refs: move ref iterators to the common code
 - refs: move prettify_refname to the common code
 - refs: move is_branch to the common code
 - refs: move check_refname_format to the common code
 - refs: move resolve_refdup to common
 - refs: move read_ref, read_ref_full and ref_exists to the common code
 - refs: move warn_if_dangling_symref* to the common code
 - refs: move dwim and friend functions to the common refs code
 - refs: move the hidden refs functions to the common code
 - refs: move read_ref_at to the common refs file
 - refs: move delete_pseudoref and delete_ref to the common code
 - refs: move update_ref to refs/refs.c
 - refs: add a new file, refs/refs.c, to hold common refs code
 - refs/files-backend.c: new file, renamed from refs.c
 - refs: make is_branch public
 - Merge branch 'jk/war-on-sprintf' into HEAD

 This is a verbatim copy of refs-backend-pre-vtable branch taken
 from https://github.com/mhagger/git; not even signed-off by me, and
 "thanks for noticing; Junio can you amend?" obviously has not been
 done.  We would want to rebase the series (after discarding the
 bottom "Merge into HEAD") on top of 228905f in order to do the
 amending and then re-merge, but I ran out of time (and patience).


* rc/configure-use-libs-when-checking-a-lib (2015-11-06) 1 commit
 - configure.ac: use $LIBS not $CFLAGS when testing -lpthread

 The "configure" script did not test for -lpthread correctly, which
 upset some linkers.

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* dt/http-range (2015-11-02) 2 commits
  (merged to 'next' on 2015-11-03 at 7c3cc60)
 + http: use off_t to store partial file size
 + http.c: use CURLOPT_RANGE for range requests

 A Range: request can be responded with a full response and when
 asked properly libcurl knows how to strip the result down to the
 requested range.  However, we were hand-crafting a range request
 and it did not kick in.


* ea/checkout-progress (2015-11-01) 1 commit
  (merged to 'next' on 2015-11-03 at 08a8d1f)
 + checkout: add --progress option

 "git checkout" did not follow the usual "--[no-]progress"
 convention and implemented only "--quiet" that is essentially
 a superset of "--no-progress".  Extend the command to support the
 usual "--[no-]progress".

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

* ad/sha1-update-chunked (2015-11-05) 2 commits
 - sha1: allow limiting the size of the data passed to SHA1_Update()
 - sha1: provide another level of indirection for the SHA-1 functions

 Apple's common crypto implementation of SHA1_Update() does not take
 more than 4GB at a time, and we now have a compile-time workaround
 for it.

 I think this is more or less ready.  I am skeptical about the file
 location reorg ([PATCH 3/3] $gmane/280912) and did not queue it.


* vl/grep-configurable-threads (2015-11-01) 1 commit
 - grep: add --threads=<num> option and grep.threads configuration

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Expecting a reroll.
 ($gmane/280854)


* kf/http-proxy-auth-methods (2015-11-04) 3 commits
 - SQUASH???
 - http: use credential API to handle proxy authentication
 - http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 Still being worked on.
 ($gmane/280925).


* lf/ref-is-hidden-namespace (2015-11-05) 4 commits
  (merged to 'next' on 2015-11-05 at b245404)
 + t5509: add basic tests for hideRefs
 + hideRefs: add support for matching full refs
 + upload-pack: strip refs before calling ref_is_hidden()
 + config.txt: document the semantics of hideRefs with namespaces

 Extend transfer.hideRefs to work better with use of namespaces.

 Will merge to 'master'.


* dg/git-svn-empty-dirs (2015-11-05) 1 commit
 - git-svn: improve rebase/mkdirs performance


* fp/subtree-todo-update (2015-11-06) 1 commit
 - contrib/subtree: remove "push" command from the "todo" file

 Will merge to 'next' and then 'master'.


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

 Will merge to 'master'.


* sb/submodule-parallel-update (2015-11-05) 10 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.jobs` config option
 - submodule config: update parse_config()
 - submodule config: remove name_and_item_from_var
 - submodule config: keep update strategy around
 - run_processes_parallel: add output to tracing messages
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
 - test: accept death by SIGPIPE as a valid failure mode

 In some tests we expect a git command that transfers objects to
 result in failure, but it is normal for the failure to come from
 SIGPIPE when the other end of the connection detects an (expected)
 error and hangs up.  However, test_expect_failure helper function
 was not prepared to see a death by sigpipe as a normal failure
 exit.

 Replacement was floated as a part of Travis CI patch series, so it
 is likely that this will be replaced while I (Junio) am away.


* pt/http-socks-proxy (2015-10-26) 1 commit
 - remote-http(s): support SOCKS proxies

 Add support for talking http/https over socks proxy.
 Needs a sign-off from the original author.


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
 - strbuf: update documentation for strbuf_read_once()
 - run-command: remove set_nonblocking()
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

 Still being worked on, but it seems that we are seeing light at the
 end of the tunnel.
 ($gmane/280937)


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
