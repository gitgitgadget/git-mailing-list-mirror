From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2013, #01; Sun, 2)
Date: Sun, 02 Jun 2013 16:58:44 -0700
Message-ID: <7vfvx0kqtn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 03 01:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjIAo-0000pl-VD
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab3FBX6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 19:58:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202Ab3FBX6s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 19:58:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF3F2463C;
	Sun,  2 Jun 2013 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4kMtpfsTIJQHSzUqhNEx/X7DK
	Rs=; b=UffRKVGuc8FqsoygfCsssRz4dAjqEfr/tHbll409qJ/iDena6/l1CmK1v
	uuKKTdtzcjFDGEnhDSWN6yZUan7vpCYW1KOQhJUyViaTtRIgZsxLWuwJoaxYptw6
	SKhGUnbnjrOH19iJ7mdxrtzClg0DjjzmSoyNGdAdftBfkw3Jhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=JM1ttkQK4q4SH8xpb2q
	aMwrKxk2XUdzAknoHPrWjDOTnDJ2rztPSXp9YVpH9UP3JcWCKJNORa2QZnCkROFI
	3/KXnlT/rw4xtmXvlVpAkhoCR0w9vasZmJqeN5u2zkueyAEMZogGYvRAv9kNzpqK
	9Krg6hQ7Yapos6OVuqfCkb/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A131C2463B;
	Sun,  2 Jun 2013 23:58:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F76D24635;
	Sun,  2 Jun 2013 23:58:46 +0000 (UTC)
X-master-at: b2edae0ab6d8188d6cd912ba5c8d1f2086c2cb9a
X-next-at: 88ee588a4065fc39b2b849219c7dd2eb139932c5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5CCDEB36-CBE0-11E2-9FB2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226198>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Many topics that have been cooking in 'next' from the previous cycle
have now graduated to 'master', so the RelNotes have been updated
again.

Nothing really new in 'next' except for one, and it has not been
rewound yet, which will hopefully happen tomorrow, and after that
post 1.8.3 cycle really starts.  I haven't caught up all the series
posted during the past few days.

Also a rather serious regression on path-exclusion logic (most
notably seen in .gitignore) has been found and quickly patched (it
hasn't been merged to 'master' yet, though).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* an/diff-index-doc (2013-05-20) 1 commit
  (merged to 'next' on 2013-05-21 at 6e1459b)
 + Documentation/diff-index: mention two modes of operation


* da/darwin (2013-05-21) 4 commits
  (merged to 'next' on 2013-05-21 at 0497edb)
 + imap-send: eliminate HMAC deprecation warnings on Mac OS X
 + cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
 + Makefile: add support for Apple CommonCrypto facility
 + Makefile: fix default regex settings on Darwin

 Newer MacOS X encourages the programs to compile and link with
 their CommonCrypto, not with OpenSSL.


* fc/completion (2013-04-27) 9 commits
  (merged to 'next' on 2013-05-21 at aba6ef1)
 + completion: remove __git_index_file_list_filter()
 + completion: add space after completed filename
 + completion: add hack to enable file mode in bash < 4
 + completion: refactor __git_complete_index_file()
 + completion: refactor diff_index wrappers
 + completion: use __gitcompadd for __gitcomp_file
 + completion; remove unuseful comments
 + completion: document tilde expansion failure in tests
 + completion: add file completion tests


* fc/fast-export-persistent-marks (2013-05-07) 3 commits
  (merged to 'next' on 2013-05-21 at 10b8214)
 + fast-{import,export}: use get_sha1_hex() to read from marks file
 + fast-export: don't parse commits while reading marks file
 + fast-export: do not parse non-commit objects while reading marks fil=
e

 Optimization for fast-export by avoiding unnecessarily resolving
 arbitrary object name and parsing object when only presence and
 type information is necessary, etc.


* fc/macos-x-clipped-write (2013-05-17) 1 commit
  (merged to 'next' on 2013-05-21 at 510b0dd)
 + compate/clipped-write.c: large write(2) fails on Mac OS X/XNU

 Mac OS X does not like to write(2) more than INT_MAX number of
 bytes.


* fc/zsh-leftover-bits (2013-05-29) 3 commits
  (merged to 'next' on 2013-05-29 at b367b4e)
 + completion: zsh: improve bash script loading
  (merged to 'next' on 2013-05-21 at 1b84ec1)
 + completion: synchronize zsh wrapper
 + completion: cleanup zsh wrapper


* jc/strbuf-branchname-fix (2013-05-16) 1 commit
  (merged to 'next' on 2013-05-21 at 5db8872)
 + strbuf_branchname(): do not double-expand @{-1}~22

 "git merge @{-1}~22" was rewritten to "git merge frotz@{1}~22"
 incorrectly when your previous branch was "frotz" (it should be
 rewritten to "git merge frotz~22" instead).


* jc/t5551-posix-sed-bre (2013-05-12) 1 commit
  (merged to 'next' on 2013-05-21 at d597ca1)
 + t5551: do not use unportable sed '\+'

 POSIX fix for a test script.


* jk/fetch-always-update-tracking (2013-05-28) 5 commits
  (merged to 'next' on 2013-05-28 at c6abf3f)
 + fetch: don't try to update unfetched tracking refs
  (merged to 'next' on 2013-05-21 at f7e4b16)
 + fetch: opportunistically update tracking refs
 + refactor "ref->merge" flag
 + fetch/pull doc: untangle meaning of bare <ref>
 + t5510: start tracking-ref tests from a known state

 "git fetch origin master" unlike "git fetch origin" or "git fetch"
 does not update "refs/remotes/origin/master" and it was an early
 design decision to keep the update of remote tracking branches
 predictable, but in practice it turns out that people find it more
 convenient to opportunisticly update them whenever we have a
 chance, and we have been updating them when we run "git push" which
 already breaks the original "predictability" anyway.


* kb/ancestry-path-threedots (2013-05-16) 2 commits
  (merged to 'next' on 2013-05-21 at 5d75bd3)
 + revision.c: treat A...B merge bases as if manually specified
 + t6019: demonstrate --ancestry-path A...B breakage
 (this branch is used by kb/full-history-compute-treesame-carefully-2.)

 "git log --ancestry-path A...B" did not work as expected, as it did
 not pay attention to the fact that the merge base between A and B
 was the bottom of the range being specified.


* mc/describe-first-parent (2013-05-20) 1 commit
  (merged to 'next' on 2013-05-21 at 2e02ffc)
 + describe: Add --first-parent option


* mk/combine-diff-context-horizon-fix (2013-05-15) 1 commit
  (merged to 'next' on 2013-05-21 at f462c02)
 + combine-diff.c: Fix output when changes are exactly 3 lines apart

 "git diff -c -p" was not showing a deleted line from a hunk when
 another hunk immediately begins where the earlier one ends.


* nd/clone-local-with-colon (2013-05-07) 1 commit
  (merged to 'next' on 2013-05-21 at 3e293bd)
 + clone: allow cloning local paths with colons in them

 "git clone foo/bar:baz" cannot be a request to clone from a remote
 over git-over-ssh specified in the scp style.  Detect this case and
 clone from a local repository at "foo/bar:baz".


* rh/merge-options-doc-fix (2013-05-16) 1 commit
  (merged to 'next' on 2013-05-21 at f76baf3)
 + Documentation/merge-options.txt: restore `-e` option


* rs/empty-archive (2013-05-09) 2 commits
  (merged to 'next' on 2013-05-21 at 3e9e288)
 + t5004: resurrect original empty tar archive test
 + t5004: avoid using tar for checking emptiness of archive

 Fixes tests added in 1.8.2 era that are broken on BSDs.


* rs/tar-tests (2013-05-20) 6 commits
  (merged to 'next' on 2013-05-21 at aed12a7)
 + t5000: test long filenames
 + t5000: simplify tar-tree tests
 + t5000: use check_tar for prefix test
 + t5000: factor out check_tar
 + t5000, t5003: create directories for extracted files lazily
 + t5000: integrate export-subst tests into regular tests


* tr/coverage (2013-05-13) 4 commits
  (merged to 'next' on 2013-05-21 at 8480007)
 + coverage: build coverage-untested-functions by default
 + coverage: set DEFAULT_TEST_TARGET to avoid using prove
 + coverage: do not delete .gcno files before building
 + coverage: split build target into compile and test

 Update the test coverage support that was left to bitrot for some
 time.


* tr/line-log (2013-04-22) 13 commits
  (merged to 'next' on 2013-04-22 at 8f2c1de)
 + git-log(1): remove --full-line-diff description
  (merged to 'next' on 2013-04-21 at cd92620)
 + line-log: fix documentation formatting
  (merged to 'next' on 2013-04-15 at 504559e)
 + log -L: improve comments in process_all_files()
 + log -L: store the path instead of a diff_filespec
 + log -L: test merge of parallel modify/rename
 + t4211: pass -M to 'git log -M -L...' test
  (merged to 'next' on 2013-04-05 at 5afb00c)
 + log -L: fix overlapping input ranges
 + log -L: check range set invariants when we look it up
  (merged to 'next' on 2013-04-01 at 5be920c)
 + Speed up log -L... -M
 + log -L: :pattern:file syntax to find by funcname
 + Implement line-history search (git log -L)
 + Export rewrite_parents() for 'log -L'
 + Refactor parse_loc


* vv/help-unknown-ref (2013-05-08) 2 commits
  (merged to 'next' on 2013-05-21 at 77a2941)
 + merge: use help_unknown_ref()
 + help: add help_unknown_ref()

 Detect "git merge foo" that might have meant "git merge origin/foo"
 and give an error message that is more specific than "foo is not
 something we can merge".

--------------------------------------------------
[New Topics]

* ap/wildmatch-foldcase (2013-06-02) 1 commit
 - wildmatch: properly fold case everywhere


* fc/completion-less-ls-remote (2013-06-02) 1 commit
 - completion: avoid ls-remote in certain scenarios


* jk/test-exit-code-by-signal (2013-06-02) 1 commit
 - t0005: test git exit code from signal death


* nd/make-wildmatch-default (2013-06-02) 1 commit
 - Makefile: promote wildmatch to be the default fnmatch implementation


* rr/remove-contrib-some (2013-06-02) 1 commit
 - contrib: remove continuous/ and patches/


* rs/unpack-trees-plug-leak (2013-06-02) 7 commits
 - unpack-trees: free cache_entry array members for merges
 - diff-lib, read-tree, unpack-trees: mark cache_entry array paramters =
const
 - diff-lib, read-tree, unpack-trees: mark cache_entry pointers const
 - unpack-trees: create working copy of merge entry in merged_entry
 - unpack-trees: factor out dup_entry
 - read-cache: mark cache_entry pointers const
 - cache: mark cache_entry pointers const


* tr/test-commit-only-on-orphan (2013-06-02) 1 commit
 - Test 'commit --only' after 'checkout --orphan'

--------------------------------------------------
[Stalled]

* mg/more-textconv (2013-05-10) 7 commits
  (merged to 'next' on 2013-05-21 at 701cdb7)
 + grep: honor --textconv for the case rev:path
 + grep: allow to use textconv filters
 + t7008: demonstrate behavior of grep with textconv
 + cat-file: do not die on --textconv without textconv filters
 + show: honor --textconv for blobs
 + diff_opt: track whether flags have been set explicitly
 + t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list.


* mh/multimail (2013-04-21) 1 commit
 - git-multimail: a replacement for post-receive-email

 Waiting for the initial history to pull from.
 $gmane/223564


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Waiting for a reroll after a review.
 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


* jk/commit-info-slab (2013-04-19) 3 commits
 - commit-slab: introduce a macro to define a slab for new type
 - commit-slab: avoid large realloc
 - commit: allow associating auxiliary info on-demand
 (this branch is used by jc/show-branch.)

 Technology demonstration to show a way we could use unbound number
 of flag bits on commit objects.

--------------------------------------------------
[Cooking]

* ap/diff-ignore-blank-lines (2013-05-29) 1 commit
 - diff: add --ignore-blank-lines option

 "git diff" learned a mode that ignores hunks whose change consists
 only of additions and removals of blank lines, which is the same as
 "diff -B" (ignore blank lines) of GNU diff.


* fc/show-branch-in-rebase-am (2013-05-29) 1 commit
 - prompt: fix for simple rebase

 The bash prompt code (in contrib/) displayed the name of the branch
 being rebased when "rebase -i/-m/-p" modes are in use, but not the
 plain vanilla "rebase".

 Will merge to 'next'.


* kb/status-ignored-optim-2 (2013-06-02) 1 commit
  (merged to 'next' on 2013-06-02 at 88ee588)
 + dir.c: fix ignore processing within not-ignored directories

 Fix 1.8.3 regressions in the .gitignore path exclusion logic.

 Will merge to 'master'.


* ks/difftool-dir-diff-copy-fix (2013-05-29) 1 commit
 - difftool --dir-diff: allow changing any clean working tree file

 "difftool --dir-diff" did not copy back changes made by the
 end-user in the diff tool backend to the working tree in some
 cases.


* rr/push-head (2013-05-29) 3 commits
 - push: make push.default =3D current use resolved HEAD
 - push: fail early with detached HEAD and current
 - push: factor out the detached HEAD error message

 "git push $there HEAD:branch" did not resolve HEAD early enough, so
 it was easy to flip it around while push is still going on and push
 out a branch that the user did not originally intended when the
 command was started.

 Will merge to 'next'.


* sb/archive-zip-double-assignment-fix (2013-05-29) 1 commit
 - archive-zip:write_zip_entry: Remove second reset of size variable to=
 zero.

 Will merge to 'next'.


* rj/mingw-cygwin (2013-05-08) 2 commits
 - cygwin: Remove the CYGWIN_V15_WIN32API build variable
 - mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE

 Update build for Cygwin 1.[57].  Torsten B=C3=B6gershausen reports tha=
t
 this is fine with Cygwin 1.7 ($gmane/225824) so let's try moving it
 ahead.

 Will merge to 'next'.


* rr/rebase-autostash (2013-05-29) 7 commits
 - rebase: implement --[no-]autostash and rebase.autostash
 - rebase --merge: return control to caller, for housekeeping
 - rebase -i: return control to caller, for housekeeping
 - am: return control to caller, for housekeeping
 - rebase: prepare to do generic housekeeping
 - rebase -i: don't error out if $state_dir already exists
 - am: tighten a conditional that checks for $dotest

 Will merge to 'next'.


* nd/urls-doc-no-file-hyperlink-fix (2013-05-24) 1 commit
 - urls.txt: avoid auto converting to hyperlink

 Will merge to 'next'.


* cb/log-follow-with-combined (2013-05-28) 1 commit
 - fix segfault with git log -c --follow

 Will merge to 'next'.


* fc/cleanups (2013-05-28) 3 commits
 - test: rebase: fix --interactive test
 - test: trivial cleanups
 - remote: trivial style cleanup

 Will merge to 'next'.


* fc/makefile (2013-05-26) 5 commits
 - build: do not install git-remote-testpy
 - build: add NO_INSTALL variable
 - build: cleanup using $<
 - build: cleanup using $^
 - build: trivial simplification
 (this branch is used by fc/remote-helpers-use-specified-python.)

 Will merge to 'next'.


* fc/remote-helpers-use-specified-python (2013-05-28) 4 commits
 - remote-helpers: add exec-path links
 - remote-helpers: allow direct test execution
 - remote-helpers: rename tests
 - remote-helpers: generate scripts
 (this branch uses fc/makefile.)

 I do not particularly think the second from the bottom is a good
 change, but it takes the remainder of the series hostage.
 Will hopefully be rerolled without it.


* fc/send-email-chainreplyto-warning (2013-05-28) 1 commit
 - send-email: remove warning about unset chainreplyto

 An overdue removal od "behaviour changed at 1.7.0; if you were
 living in a cave, here is what you can adjust to it" message.

 Will merge to 'next'.


* ks/difftool-dirdiff-copy-all (2013-05-28) 1 commit
 - difftool --dir-diff: always use identical working tree file

 "difftool --dir-diff" populates a temporary directory with files,
 inviting the user to modify them in place, but in some cases we
 weren't expecting the user to modify them and did not take the
 change back to the working tree.

 Will merge to 'next'.


* nd/prune-packed-dryrun-verbose (2013-05-28) 1 commit
 - prune-packed: avoid implying "1" is DRY_RUN in prune_packed_objects(=
)

 Will merge to 'next'.


* rj/mingw-compat-st-mode-bits (2013-05-29) 1 commit
 - path: Fix a sparse warning

 Will merge to 'next'.


* rs/commit-m-no-edit (2013-05-28) 1 commit
 - commit: don't start editor if empty message is given with -m

 Will merge to 'next'.


* xq/credential-osxkeychain (2013-05-28) 1 commit
 - credential-osxkeychain: support more protocols

 Will merge to 'next'.


* jc/core-checkstat (2013-05-06) 1 commit
 - deprecate core.statinfo at Git 2.0 boundary
 (this branch is used by jc/core-checkstat-2.0.)

 Will merge to 'next'.


* mh/reflife (2013-06-02) 25 commits
 - refs: document the lifetime of the args passed to each_ref_fn
 - register_ref(): make a copy of the bad reference SHA-1
 - exclude_existing(): set existing_refs.strdup_strings
 - string_list_add_refs_by_glob(): add a comment about memory managemen=
t
 - string_list_add_one_ref(): rename first parameter to "refname"
 - show_head_ref(): rename first parameter to "refname"
 - show_head_ref(): do not shadow name of argument
 - add_existing(): do not retain a reference to sha1
 - do_fetch(): clean up existing_refs before exiting
 - do_fetch(): reduce scope of peer_item
 - object_array_entry: fix memory handling of the name field
 - find_first_merges(): remove unnecessary code
 - find_first_merges(): initialize merges variable using initializer
 - fsck: don't put a void*-shaped peg in a char*-shaped hole
 - object_array_remove_duplicates(): rewrite to reduce copying
 - revision: use object_array_filter() in implementation of gc_boundary=
()
 - object_array: add function object_array_filter()
 - revision: split some overly-long lines
 - cmd_diff(): make it obvious which cases are exclusive of each other
 - cmd_diff(): rename local variable "list" -> "entry"
 - cmd_diff(): use an object_array for holding trees
 - builtin_diff_tree(): make it obvious that function wants two entries
 - add_rev_cmdline(): make a copy of the name argument
 - fetch: make own copies of refnames
 - describe: make own copy of refname

 Define memory ownership and lifetime rules for what for-each-ref
 feeds to its callbacks (in short, "you do not own it, so make a
 copy if you want to keep it").

 Will merge to 'next'.


* th/bisect-skip-report-range-fix (2013-05-22) 1 commit
 - bisect: Fix log output for multi-parent skip ranges

 Fix for an additional bisect log comments.

 Will merge to 'next'.


* mm/mediawiki-https-fail-message (2013-05-29) 1 commit
 - git-remote-mediawiki: better error message when HTTP(S) access fails

 Hint users when https:// connection failed to check the
 certificate; it is a good hint if we assumie that it is common
 error for the end users to make.

 Will merge to 'next'.


* tg/maint-zsh-svn-remote-prompt (2013-05-22) 1 commit
 - prompt: fix show upstream with svn and zsh

 zsh prompt script that borrowed from bash prompt script did not
 work due to slight differences in array variable notation between
 these two shells.

 Will merge to 'next'.


* tr/push-no-verify-doc (2013-05-23) 1 commit
 - Document push --no-verify

 "git push --[no-]verify" was not documented.

 Will merge to 'next'.


* dm/unbash-subtree (2013-05-21) 1 commit
 - contrib/git-subtree: Use /bin/sh interpreter instead of /bin/bash

 It turns out that git-subtree script does not have to be run with
 bash.

 Will merge to 'next'.


* fc/transport-helper-no-refspec (2013-05-21) 2 commits
 - transport-helper: check if the dry-run is supported
 - transport-helper: barf when user tries old:new

 With "export" remote-helper protocol, (1) a push that tries to
 update a remote ref whose name is different from the pushing side
 does not work yet, and (2) the helper may not know how to do
 --dry-run, so detect such problematic cases and disable them for
 now.

 Will merge to 'next'.


* rr/die-on-missing-upstream (2013-06-02) 2 commits
 - sha1_name: fix error message for @{<N>}, @{<date>}
 - sha1_name: fix error message for @{u}

 When a reflog notation is used for implicit "current branch", we
 did not say which branch and worse said "branch ''".

 Will merge to 'next'.


* jc/show-branch (2013-05-21) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style
 (this branch uses jk/commit-info-slab.)

 Waiting for the final step to lift the hard-limit before sending it ou=
t.


* fc/remote-bzr (2013-05-28) 8 commits
 - remote-bzr: add fallback check for a partial clone
 - remote-bzr: reorganize the way 'wanted' works
 - remote-bzr: trivial cleanups
 - remote-bzr: change global repo
 - remote-bzr: delay cloning/pulling
 - remote-bzr: simplify get_remote_branch()
 - remote-bzr: fix for files with spaces
 - remote-bzr: recover from failed clones

 Will merge to 'next'.


* jx/clean-interactive (2013-05-22) 15 commits
 - test: add t7301 for git-clean--interactive
 - git-clean: add documentation for interactive git-clean
 - git-clean: add ask each interactive action
 - git-clean: add select by numbers interactive action
 - git-clean: add filter by pattern interactive action
 - git-clean: use a git-add-interactive compatible UI
 - git-clean: add colors to interactive git-clean
 - git-clean: show items of del_list in columns
 - git-clean: add support for -i/--interactive
 - git-clean: refactor git-clean into two phases
 - Refactor write_name_quoted_relative, remove unused params
 - Refactor quote_path_relative, remove unused params
 - quote.c: remove path_relative, use relative_path instead
 - path.c: refactor relative_path(), not only strip prefix
 - test: add test cases for relative_path

 Still under discussion, e.g. $gmane/225139.


* tr/test-v-and-v-subtest-only (2013-05-16) 6 commits
 - test-lib: support running tests under valgrind in parallel
 - test-lib: allow prefixing a custom string before "ok N" etc.
 - test-lib: valgrind for only tests matching a pattern
 - test-lib: verbose mode for only tests matching a pattern
 - test-lib: refactor $GIT_SKIP_TESTS matching
 - test-lib: enable MALLOC_* for the actual tests

 Allows N instances of tests run in parallel, each running 1/N parts
 of the test suite under Valgrind, to speed things up.

 The tip one may be useful in practice but is a tad ugly ;-)

 There seem to be some miscounting by toggling the verbose/valgrind
 mode at wrong places?  Cf. $gmane/225735


* rr/zsh-color-prompt (2013-05-17) 3 commits
 - prompt: colorize ZSH prompt
 - prompt: factor out gitstring coloring logic
 - prompt: introduce GIT_PS1_STATESEPARATOR

 Will merge to 'next'.


* fc/contrib-related (2013-05-20) 1 commit
 - Add new git-related helper to contrib

 Waiting the design review for this earliest part to settle.


* fc/remote-hg (2013-05-28) 50 commits
 - remote-hg: add support for --force
 - remote-hg: add support for --dry-run
 - remote-hg: check if a fetch is needed
 - remote-hg: trivial cleanup
 - remote-helpers: improve marks usage
 - remote-hg: add check_push() helper
 - remote-hg: add setup_big_push() helper
 - remote-hg: remove files before modifications
 - remote-hg: improve lightweight tag author
 - remote-hg: use remote 'default' not local one
 - remote-hg: improve branch listing
 - remote-hg: simplify branch_tip()
 - remote-hg: check diverged bookmarks
 - remote-hg: pass around revision refs
 - remote-hg: implement custom checkheads()
 - remote-hg: implement custom push()
 - remote-hg: only update necessary revisions
 - remote-hg: force remote bookmark push selectively
 - remote-hg: reorganize bookmark handling
 - remote-hg: add test for failed double push
 - remote-hg: add test for big push
 - remote-hg: add test for new bookmark special
 - remote-hg: add test for bookmark diverge
 - remote-hg: add test for diverged push
 - remote-hg: add test to push new bookmark
 - remote-hg: add remote tests
 - remote-hg: update bookmarks when using a remote
 - remote-hg: add check_bookmark() test helper
 - remote-bzr: simplify test checks
 - remote-hg: add tests for 'master' bookmark
 - remote-hg: always point HEAD to master
 - remote-hg: improve progress calculation
 - remote-hg: trivial cleanups
 - remote-hg: ensure remote rebasing works
 - remote-hg: upgrade version 1 marks
 - remote-hg: switch from revisions to SHA-1 noteids
 - remote-hg: add version checks to the marks
 - remote-hg: improve node traversing
 - remote-hg: shuffle some code
 - remote-hg: use a shared repository store
 - remote-hg: load all extensions
 - remote-hg: test: simplify previous branch checkout
 - remote-helpers: test: simplify remote URLs
 - remote-helpers: tests: general improvements
 - remote-helpers: test: cleanup style
 - remote-helpers: test: cleanup white-spaces
 - remote-hg: trivial reorganization
 - remote-hg: test: be a little more quiet
 - remote-hg: tests: fix hg merge
 - remote-helpers: tests: use python directly

 Will merge to 'next'.


* hv/config-from-blob (2013-05-12) 5 commits
 - do not die when error in config parsing of buf occurs
 - teach config --blob option to parse config from database
 - config: make parsing stack struct independent from actual data sourc=
e
 - config: drop cf validity check in get_next_char()
 - config: factor out config file stack management

 Will see a resubmit.
 $gmane/223964


* nd/clone-connectivity-shortcut (2013-05-28) 4 commits
 - clone: open a shortcut for connectivity check
 - index-pack: remove dead code (it should never happen)
 - fetch-pack: prepare updated shallow file before fetching the pack
 - clone: let the user know when check_everything_connected is run

 Will merge to 'next'.


* kb/full-history-compute-treesame-carefully-2 (2013-05-16) 15 commits
 - revision.c: make default history consider bottom commits
 - revision.c: don't show all merges for --parents
 - revision.c: discount side branches when computing TREESAME
 - revision.c: add BOTTOM flag for commits
 - simplify-merges: drop merge from irrelevant side branch
 - simplify-merges: never remove all TREESAME parents
 - t6012: update test for tweaked full-history traversal
 - revision.c: Make --full-history consider more merges
 - Documentation: avoid "uninteresting"
 - rev-list-options.txt: correct TREESAME for P
 - t6111: add parents to tests
 - t6111: allow checking the parents as well
 - t6111: new TREESAME test set
 - t6019: test file dropped in -s ours merge
 - decorate.c: compact table when growing

 Major update to a very core part of the system to improve culling
 of irrelevant parents while traversing a mergy history.

 Will not be a 1.8.3 material, but is an important topic.

 Will merge to 'next'.


* mm/color-auto-default (2013-05-15) 2 commits
 - make color.ui default to 'auto'
 - config: refactor management of color.ui's default value

 Flip the default for color.ui to 'auto', which is what many
 tutorials recommend new users to do.  The updated code claims the
 switch happened at Git 2.0 in the past tense, but we might want to
 expedite it, as this change is not all that important to deserve a
 major version bump.

 I'd vote for merging this without waiting for 2.0.  Comments?
 Waiting for a reroll.


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD t=
o origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin=
/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.


* nd/warn-ambiguous-object-name (2013-05-29) 1 commit
 - get_sha1: warn about full or short object names that look like refs

 "git cmd <name>", when <name> happens to be a 40-hex string,
 directly uses the 40-hex string as an object name, even if a ref
 "refs/<some hierarchy>/<name>" exists.  This disambiguation order
 is unlikely to change, but we should warn about the ambiguity just
 like we warn when more than one refs/ hierachies share the same
 name.


* jk/packed-refs-race (2013-05-06) 4 commits
 - for_each_ref: load all loose refs before packed refs
 - get_packed_refs: reload packed-refs file when it changes
 - add a stat_validity struct
 - resolve_ref: close race condition for packed refs

 What is the status of this thing?


* fc/at-head (2013-05-08) 13 commits
 - sha1_name: compare variable with constant, not constant with variabl=
e
 - Add new @ shortcut for HEAD
 - sha1_name: refactor reinterpret()
 - sha1_name: check @{-N} errors sooner
 - sha1_name: reorganize get_sha1_basic()
 - sha1_name: don't waste cycles in the @-parsing loop
 - sha1_name: remove unnecessary braces
 - sha1_name: remove no-op
 - tests: at-combinations: @{N} versus HEAD@{N}
 - tests: at-combinations: increase coverage
 - tests: at-combinations: improve nonsense()
 - tests: at-combinations: check ref names directly
 - tests: at-combinations: simplify setup

 Instead of typing four capital letters "HEAD", you can say "@"
 instead.

 Will merge to 'next'.


* jk/submodule-subdirectory-ok (2013-04-24) 3 commits
  (merged to 'next' on 2013-04-24 at 6306b29)
 + submodule: fix quoting in relative_path()
  (merged to 'next' on 2013-04-22 at f211e25)
 + submodule: drop the top-level requirement
 + rev-parse: add --prefix option

 Allow various subcommands of "git submodule" to be run not from the
 top of the working tree of the superproject.

 Will be commented by Jens.


* jl/submodule-mv (2013-04-23) 5 commits
  (merged to 'next' on 2013-04-23 at c04f574)
 + submodule.c: duplicate real_path's return value
  (merged to 'next' on 2013-04-19 at 45ae3c9)
 + rm: delete .gitmodules entry of submodules removed from the work tre=
e
 + Teach mv to update the path entry in .gitmodules for moved submodule=
s
 + Teach mv to move submodules using a gitfile
 + Teach mv to move submodules together with their work trees

 "git mv A B" when moving a submodule A does "the right thing",
 inclusing relocating its working tree and adjusting the paths in
 the .gitmodules file.

 Will be commented by Jens.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0
 (this branch uses jc/core-checkstat.)

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-04-03) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.
