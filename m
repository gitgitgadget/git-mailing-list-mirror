From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2016, #03; Wed, 13)
Date: Wed, 13 Jan 2016 14:23:38 -0800
Message-ID: <xmqqy4btktjp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 23:23:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJTpU-0002T8-WE
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 23:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbcAMWXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 17:23:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751923AbcAMWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 17:23:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48BDB3B6E1;
	Wed, 13 Jan 2016 17:23:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	+d1FSN1N0J+7OLJm1judmWz3fQ=; b=XlUEjtVucA46GSDRZEoeD84a9TIiUDSfN
	XbSJvkfO32cil9AZzts7ZVqjR/W4mTz+Mj5//H5zS+x9FcWhtWOYOkuZcrw8VNoR
	WTLm77XmVZO6lfk0vW2xC+c22fC3eAKOwgz8NcL5rJ8MJcTzPQWN2d99B/Wix3fy
	ojgFc/qbeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZLi
	7L5mWfYQJjPVeSebSSzq4MfgexUb3VZ/UToREc9TNO3X+SDRsZTjQZBKANBFzb52
	UKOP9KT0N8cetP9W8eVYpyZwvPr+LDbY9yn92DGKbhgCLyWERobyxDetJPKdnV2E
	xMqlXi0K8hD5o9dquQC5sgmbr08v0t9vKMsT4lks=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D8683B6E0;
	Wed, 13 Jan 2016 17:23:40 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4CFD23B6DF;
	Wed, 13 Jan 2016 17:23:39 -0500 (EST)
X-master-at: fc10eb5b87a75af2cb93a3932897572f2c544915
X-next-at: dc08a1951c8b3cd3e311ff0c2612db06ab28ae13
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B954FF8-BA44-11E5-BF62-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283992>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'next' has been rewound.  A handful of topics have
graduated to 'master'.  A few topics that are fixes to 2.7.0 started
cooking in 'next'.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ea/blame-progress (2015-12-16) 1 commit
  (merged to 'next' on 2015-12-22 at f8e8643)
 + blame: add support for --[no-]progress option

 Originally merged to 'next' on 2015-12-22

 "git blame" learned to produce the progress eye-candy when it takes
 too much time before emitting the first line of the result.


* ep/make-phoney (2015-12-16) 1 commit
  (merged to 'next' on 2015-12-22 at 27c7593)
 + Makefile: add missing phony target

 Originally merged to 'next' on 2015-12-22

 A slight update to the Makefile.


* nd/stop-setenv-work-tree (2015-12-22) 1 commit
  (merged to 'next' on 2015-12-22 at 6d7bb0c)
 + Revert "setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR"
 (this branch is used by nd/clear-gitenv-upon-use-of-alias.)

 Originally merged to 'next' on 2015-12-22

 An earlier change in 2.5.x-era broke users' hooks and aliases by
 exporting GIT_WORK_TREE to point at the root of the working tree,
 interfering when they tried to use a different working tree without
 setting GIT_WORK_TREE environment themselves.


* ps/push-delete-option (2015-12-16) 2 commits
  (merged to 'next' on 2015-12-22 at d83cc1d)
 + push: add '-d' as shorthand for '--delete'
 + push: add '--delete' flag to synopsis

 Originally merged to 'next' on 2015-12-22

 "branch --delete" has "branch -d" but "push --delete" does not.


* sb/submodule-parallel-fetch (2015-12-16) 7 commits
  (merged to 'next' on 2015-12-22 at 44e84ff)
 + submodules: allow parallel fetching, add tests and documentation
 + fetch_populated_submodules: use new parallel job processing
 + run-command: add an asynchronous parallel child processor
 + sigchain: add command to pop all common signals
 + strbuf: add strbuf_read_once to read without blocking
 + xread: poll on non blocking fds
 + submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is used by sb/submodule-parallel-update.)

 Originally merged to 'next' on 2015-12-22

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Rerolled and this seems to be a lot cleaner.  The merge of the
 earlier one to 'next' has been reverted.


* vl/grep-configurable-threads (2015-12-16) 3 commits
  (merged to 'next' on 2015-12-22 at 8954705)
 + grep: add --threads=<num> option and grep.threads configuration
 + grep: slight refactoring to the code that disables threading
 + grep: allow threading even on a single-core machine

 Originally merged to 'next' on 2015-12-22

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

--------------------------------------------------
[New Topics]

* ho/gitweb-squelch-undef-warning (2016-01-12) 1 commit
  (merged to 'next' on 2016-01-12 at ef4fc5f)
 + gitweb: squelch "uninitialized value" warning

 Asking gitweb for a nonexistent commit left a warning in the server
 log.

 Somebody may want to follow this up with a new test, perhaps?
 IIRC, we do test that no Perl warnings are given to the server log,
 so this should have been caught if our test coverage were good.

 Will merge to 'master'.


* tg/grep-no-index-fallback (2016-01-12) 2 commits
  (merged to 'next' on 2016-01-12 at 8960bdd)
 + builtin/grep: add grep.fallbackToNoIndex config
 + t7810: correct --no-index test

 "git grep" by default does not fall back to its --no-index
 behaviour outside a directory under Git's control (otherwise the
 user may by mistake end up running a huge recursive search); with a
 new configuration (set in $HOME/.gitconfig--by definition this
 cannot be set in the config file per project), this safety can be
 disabled.

 Will merge to 'master'.


* js/pull-rebase-i (2016-01-13) 3 commits
 - completion: add missing branch.*.rebase values
 - remote: handle the config setting branch.*.rebase=interactive
 - pull: allow interactive rebase with --rebase=interactive

 "git pull --rebase" has been extended to allow invoking
 "rebase -i".

 Will merge to 'next'.


* jk/ok-to-fail-gc-auto-in-rebase (2016-01-13) 1 commit
 - rebase: ignore failures from "gc --auto"

 "git rebase", unlike all other callers of "gc --auto", did not
 ignore the exit code from "gc --auto".

 Will merge to 'next'.


* js/close-packs-before-gc (2016-01-13) 4 commits
 - receive-pack: release pack files before garbage-collecting
 - merge: release pack files before garbage-collecting
 - am: release pack files before garbage-collecting
 - fetch: release pack files before garbage-collecting

 Many codepaths that run "gc --auto" before exiting kept packfiles
 mapped and left the file descriptors to them open, which was not
 friendly to systems that cannot remove files that are open.  They
 now close the packs before doing so.

 Will merge to 'next'.


* js/msys2 (2016-01-13) 5 commits
 - compat/winansi: support compiling with MSys2
 - compat/mingw: support MSys2-based MinGW build
 - nedmalloc: allow compiling with MSys2's compiler
 - config.mak.uname: supporting 64-bit MSys2
 - config.mak.uname: support MSys2

 Beginning of the upstreaming process of Git for Windows effort.

 Waiting for review.
 ($gmane/283975).


* rp/p4-filetype-change (2016-01-13) 1 commit
 - git-p4.py: add support for filetype change

 Will merge to 'next'.


* tk/interpret-trailers-in-place (2016-01-13) 2 commits
 - interpret-trailers: add option for in-place editing
 - trailer: use fprintf instead of printf

 "interpret-trailers" has been taught to optionally update a file in
 place, instead of always writing the result to the standard output.

 Test may need to be updated to ensure a failing rewrite does not
 clobber the original input.

 Waiting for review.
 ($gmane/283959).

--------------------------------------------------
[Stalled]

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
 pt/http-socks-proxy topic. That is now in master, so it can
 be re-rolled on top.

 Anybody wants to help rerolling this?  Otherwise will discard.


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

* dw/signoff-doc (2016-01-05) 1 commit
  (merged to 'next' on 2016-01-12 at 1b08b48)
 + Expand documentation describing --signoff

 The documentation has been updated to hint the connection between
 the '--signoff' option and DCO.

 Will merge to 'master'.


* ew/for-each-ref-doc (2016-01-05) 1 commit
  (merged to 'next' on 2016-01-12 at e5c4e75)
 + for-each-ref: document `creatordate` and `creator` fields

 Will merge to 'master'.


* sg/t6050-failing-editor-test-fix (2016-01-05) 1 commit
  (merged to 'next' on 2016-01-12 at dc08a19)
 + t6050-replace: make failing editor test more robust

 Will merge to 'master'.


* js/dirname-basename (2016-01-12) 4 commits
  (merged to 'next' on 2016-01-12 at c3c970a)
 + t0060: verify that basename() and dirname() work as expected
 + compat/basename.c: provide a dirname() compatibility function
 + compat/basename: make basename() conform to POSIX
 + Refactor skipping DOS drive prefixes

 dirname() emulation has been added, as Msys2 lacks it.

 The test needs to be loosened to allow implementation defined
 behaviour; currently it fails on Macs.

 Waiting for an update.
 ($gmane/283968).


* js/fopen-harder (2016-01-11) 2 commits
  (merged to 'next' on 2016-01-12 at c6ef194)
 + Handle more file writes correctly in shared repos
 + commit: allow editing the commit message even in shared repos

 Some codepaths used fopen(3) when opening a fixed path in $GIT_DIR
 (e.g. COMMIT_EDITMSG) that is meant to be left after the command is
 done.  This however did not work well if the repository is set to
 be shared with core.sharedRepository and the umask of the previous
 user is tighter.  Make them work better by calling unlink(2) and
 retrying after fopen(3) fails with EPERM.

 Will merge to 'master'.


* nd/exclusion-regression-fix (2016-01-08) 1 commit
  (merged to 'next' on 2016-01-12 at 0eb98a5)
 + Revert "dir.c: don't exclude whole dir prematurely if neg pattern may match"

 The ignore mechanism saw a few regressions around untracked file
 listing and sparse checkout selection areas in 2.7.0; the change
 that is responsible for the regression has been reverted.

 Will merge to 'master'.


* ss/clone-depth-single-doc (2016-01-08) 3 commits
  (merged to 'next' on 2016-01-12 at 16ded8c)
 + docs: clarify that --depth for git-fetch works with newly initialized repos
 + docs: say "commits" in the --depth option wording for git-clone
 + docs: clarify that passing --depth to git-clone implies --single-branch

 Updates documents to clarify "git fetch --depth".

 Will merge to 'master'.


* wp/sha1-name-negative-match (2016-01-13) 2 commits
 - object name: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "<branch>^{/!-<pattern>}" notation to name a commit
 reachable from <branch> that does not match the given <pattern>.

 A questionable corner case where commit has no message remains.

 Waiting for review.
 ($gmane/283971)


* ak/format-patch-odir-config (2016-01-13) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Allow "-o <dir>" option to be omitted on the command line of "git
 format-patch" if you always use the same directory in your
 workflow.

 Will merge to 'next'.


* jk/notes-merge-from-anywhere (2015-12-29) 1 commit
 - notes: allow merging from arbitrary references

 "git notes merge" used to limit the source of the merged notes tree
 to somewhere under refs/notes/ hierarchy, which was too limiting
 when inventing a workflow to exchange notes with remote
 repositories using remote-tracking notes trees (located in e.g.
 refs/remote-notes/ or somesuch).

 Needs review.


* dk/reflog-walk-with-non-commit (2016-01-05) 1 commit
  (merged to 'next' on 2016-01-12 at 5f7b10e)
 + reflog-walk: don't segfault on non-commit sha1's in the reflog

 "git reflog" incorrectly assumed that all objects that used to be
 at the tip of a ref must be commits, which caused it to segfault.

 Will merge to 'master'.


* ew/send-email-mutt-alias-fix (2016-01-04) 1 commit
  (merged to 'next' on 2016-01-12 at 84d1329)
 + git-send-email: do not double-escape quotes from mutt

 "git send-email" was confused by escaped quotes stored in the alias
 files saved by "mutt".

 Will merge to 'master'.


* jk/clang-pedantic (2016-01-04) 2 commits
  (merged to 'next' on 2016-01-12 at b5be271)
 + bswap: add NO_UNALIGNED_LOADS define
 + avoid shifting signed integers 31 bits

 A few unportable C construct have been spotted by clang compiler
 and have been fixed.

 Will merge to 'master'.


* dt/unpack-compare-entry-optim (2016-01-05) 1 commit
 - do_compare_entry: use already-computed path

 Will merge to 'next'.


* jk/pack-revindex (2015-12-21) 2 commits
  (merged to 'next' on 2016-01-12 at 2e39a16)
 + pack-revindex: store entries directly in packed_git
 + pack-revindex: drop hash table

 Will merge to 'master'.


* jk/symbolic-ref (2016-01-13) 6 commits
 - lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
 - lock_ref_sha1_basic: always fill old_oid while holding lock
 - checkout,clone: check return value of create_symref
 - create_symref: write reflog while holding lock
 - create_symref: use existing ref-lock code
 - create_symref: modernize variable names

 The low-level code that is used to create symbolic references has
 been updated to share more code with the code that deals with
 normal references.

 Will merge to 'next'.


* ep/shell-command-substitution-style (2016-01-12) 92 commits
 - t9901-git-web--browse.sh: use the $( ... ) construct for command substitution
 - t9501-gitweb-standalone-http-status.sh: use the $( ... ) construct for command substitution
 - t9350-fast-export.sh: use the $( ... ) construct for command substitution
 - t9300-fast-import.sh: use the $( ... ) construct for command substitution
 - t9150-svk-mergetickets.sh: use the $( ... ) construct for command substitution
 - t9145-git-svn-master-branch.sh: use the $( ... ) construct for command substitution
 - t9138-git-svn-authors-prog.sh: use the $( ... ) construct for command substitution
 - t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct for command substitution
 - t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for command substitution
 - t9130-git-svn-authors-file.sh: use the $( ... ) construct for command substitution
 - t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct for command substitution
 - t9119-git-svn-info.sh: use the $( ... ) construct for command substitution
 - t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct for command substitution
 - t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for command substitution
 - t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for command substitution
 - t9109-git-svn-multi-glob.sh: use the $( ... ) construct for command substitution
 - t9108-git-svn-glob.sh: use the $( ... ) construct for command substitution
 - t9107-git-svn-migrate.sh: use the $( ... ) construct for command substitution
 - t9105-git-svn-commit-diff.sh: use the $( ... ) construct for command substitution
 - t9104-git-svn-follow-parent.sh: use the $( ... ) construct for command substitution
 - t9101-git-svn-props.sh: use the $( ... ) construct for command substitution
 - t9100-git-svn-basic.sh: use the $( ... ) construct for command substitution
 - t/t9001-send-email.sh: use the $( ... ) construct for command substitution
 - t/t8003-blame-corner-cases.sh: use the $( ... ) construct for command substitution
 - t/t7700-repack.sh: use the $( ... ) construct for command substitution
 - t/t7602-merge-octopus-many.sh: use the $( ... ) construct for command substitution
 - t/t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for command substitution
 - t/t7504-commit-msg-hook.sh: use the $( ... ) construct for command substitution
 - t/t7408-submodule-reference.sh: use the $( ... ) construct for command substitution
 - t/t7406-submodule-update.sh: use the $( ... ) construct for command substitution
 - t/t7103-reset-bare.sh: use the $( ... ) construct for command substitution
 - t/t7006-pager.sh: use the $( ... ) construct for command substitution
 - t/t7004-tag.sh: use the $( ... ) construct for command substitution
 - t/t7003-filter-branch.sh: use the $( ... ) construct for command substitution
 - t/t7001-mv.sh: use the $( ... ) construct for command substitution
 - t/t6132-pathspec-exclude.sh: use the $( ... ) construct for command substitution
 - t/t6032-merge-large-rename.sh: use the $( ... ) construct for command substitution
 - t/t6015-rev-list-show-all-parents.sh: use the $( ... ) construct for command substitution
 - t/t6002-rev-list-bisect.sh: use the $( ... ) construct for command substitution
 - t/t6001-rev-list-graft.sh: use the $( ... ) construct for command substitution
 - t/t5900-repo-selection.sh: use the $( ... ) construct for command substitution
 - t/t5710-info-alternate.sh: use the $( ... ) construct for command substitution
 - t/t5700-clone-reference.sh: use the $( ... ) construct for command substitution
 - t/t5601-clone.sh: use the $( ... ) construct for command substitution
 - t/t5570-git-daemon.sh: use the $( ... ) construct for command substitution
 - t/t5550-http-fetch-dumb.sh: use the $( ... ) construct for command substitution
 - t/t5538-push-shallow.sh: use the $( ... ) construct for command substitution
 - t/t5537-fetch-shallow.sh: use the $( ... ) construct for command substitution
 - t/t5532-fetch-proxy.sh: use the $( ... ) construct for command substitution
 - t/t5530-upload-pack-error.sh: use the $( ... ) construct for command substitution
 - t/t5522-pull-symlink.sh: use the $( ... ) construct for command substitution
 - t/t5517-push-mirror.sh: use the $( ... ) construct for command substitution
 - t/t5516-fetch-push.sh: use the $( ... ) construct for command substitution
 - t/t5515-fetch-merge-logic.sh: use the $( ... ) construct for command substitution
 - t/t5510-fetch.sh: use the $( ... ) construct for command substitution
 - t/t5506-remote-groups.sh: use the $( ... ) construct for command substitution
 - t/t5505-remote.sh: use the $( ... ) construct for command substitution
 - t/t5500-fetch-pack.sh: use the $( ... ) construct for command substitution
 - t/t5305-include-tag.sh: use the $( ... ) construct for command substitution
 - t/t5304-prune.sh: use the $( ... ) construct for command substitution
 - t/t5303-pack-corruption-resilience.sh: use the $( ... ) construct for command substitution
 - t/t5100: no need to use 'echo' command substitutions for globbing
 - t/t5302-pack-index.sh: use the $( ... ) construct for command substitution
 - t/t5301-sliding-window.sh: use the $( ... ) construct for command substitution
 - t/t5300-pack-object.sh: use the $( ... ) construct for command substitution
 - t/t5100-mailinfo.sh: use the $( ... ) construct for command substitution
 - t/t3700-add.sh: use the $( ... ) construct for command substitution
 - t/t3600-rm.sh: use the $( ... ) construct for command substitution
 - t/t3511-cherry-pick-x.sh: use the $( ... ) construct for command substitution
 - t/t3403-rebase-skip.sh: use the $( ... ) construct for command substitution
 - t/t3210-pack-refs.sh: use the $( ... ) construct for command substitution
 - t/t3101-ls-tree-dirname.sh: use the $( ... ) construct for command substitution
 - t/t3100-ls-tree-restrict.sh: use the $( ... ) construct for command substitution
 - t/t3030-merge-recursive.sh: use the $( ... ) construct for command substitution
 - t/t2102-update-index-symlinks.sh: use the $( ... ) construct for command substitution
 - t/t2025-worktree-add.sh: use the $( ... ) construct for command substitution
 - t/t1700-split-index.sh: use the $( ... ) construct for command substitution
 - t/t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for command substitution
 - t/t1511-rev-parse-caret.sh: use the $( ... ) construct for command substitution
 - t/t1410-reflog.sh: use the $( ... ) construct for command substitution
 - t/t1401-symbolic-ref.sh: use the $( ... ) construct for command substitution
 - t/t1100-commit-tree-options.sh: use the $( ... ) construct for command substitution
 - unimplemented.sh: use the $( ... ) construct for command substitution
 - test-sha1.sh: use the $( ... ) construct for command substitution
 - t/lib-httpd.sh: use the $( ... ) construct for command substitution
 - git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for command substitution
 - contrib/thunderbird-patch-inline/appp.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-revert.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-repack.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-merge.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-fetch.sh: use the $( ... ) construct for command substitution
 - contrib/examples/git-commit.sh: use the $( ... ) construct for command substitution

 A shell script style update to change `command substitution` into
 $(command substitution).  Coverts contrib/ and much of the t/
 directory contents.

 Will merge to 'next'.


* nd/dir-exclude-cleanup (2015-12-28) 1 commit
  (merged to 'next' on 2016-01-12 at e6584c9)
 + dir.c: clean the entire struct in clear_exclude_list()

 The "exclude_list" structure has the usual "alloc, nr" pair of
 fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
 to reset 'alloc' to 0 when it cleared 'nr' and discarded the
 managed array.

 Will merge to 'master'.


* ss/user-manual (2015-12-30) 4 commits
  (merged to 'next' on 2016-01-12 at c7f0328)
 + user-manual: add addition gitweb information
 + user-manual: add section documenting shallow clones
 + glossary: define the term shallow clone
 + user-manual: remove temporary branch entry from todo list

 Drop a few old "todo" items by deciding that the change one of them
 suggests is not such a good idea, and doing the change the other
 one suggested to do.

 Will merge to 'master'.


* nd/ita-cleanup (2015-12-28) 3 commits
  (merged to 'next' on 2016-01-12 at 008a6e3)
 + grep: make it clear i-t-a entries are ignored
 + add and use a convenience macro ce_intent_to_add()
 + blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not
 quite yet in the index, but a few commands behaved as if they
 already are in a harmful way.

 Here are only the obviously correct bits; some other changes were
 in the posted series, but not quite ready to be queued here.

 Will merge to 'master'.


* cc/untracked (2015-12-29) 10 commits
 - t7063: add tests for core.untrackedCache
 - config: add core.untrackedCache
 - dir: simplify untracked cache "ident" field
 - dir: add remove_untracked_cache()
 - dir: add {new,add}_untracked_cache()
 - update-index: move 'uc' var declaration
 - update-index: add untracked cache notifications
 - update-index: add --test-untracked-cache
 - update-index: use enum for untracked cache options
 - dir: free untracked cache when removing it

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".

 Still being discussed and worked on.
 $gmane/283080


* dt/refs-backend-lmdb (2016-01-12) 22 commits
 . DONTMERGE: compilation fix
 . refs: tests for lmdb backend
 . refs: add LMDB refs backend
 . svn: learn ref-storage argument
 . refs: allow ref backend to be set for clone
 . clone: use child_process for recursive checkouts
 . refs: check submodules ref storage config
 . init: allow alternate backends to be set for new repos
 . refs: always handle non-normal refs in files backend
 . refs: resolve symbolic refs first
 . refs: allow log-only updates
 . refs: move duplicate check to common code
 . refs: make lock generic
 . refs: add method to rename refs
 . refs: add methods to init refs db
 . refs: add method for delete_refs
 . refs: add method for initial ref transaction commit
 . refs: add methods for reflog
 . refs: add do_for_each_per_worktree_ref
 . refs: add methods for the ref iterators
 . refs: add methods for misc ref operations
 . refs: add a backend method structure with transaction functions

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 Rerolled, but left out of 'pu' for now due to conflicts.


* dw/subtree-split-do-not-drop-merge (2015-12-10) 1 commit
 - contrib/subtree: fix "subtree split" skipped-merge bug

 The "split" subcommand of "git subtree" (in contrib/) incorrectly
 skipped merges when it shouldn't, which was corrected.

 Still being worked on.
 ($gmane/283874)


* nd/clear-gitenv-upon-use-of-alias (2015-12-29) 5 commits
  (merged to 'next' on 2016-01-12 at 696b1f5)
 + run-command: don't warn on SIGPIPE deaths
 + git.c: make sure we do not leak GIT_* to alias scripts
 + setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
 + git.c: make it clear save_env() is for alias handling only
 + Merge branch 'nd/stop-setenv-work-tree' into nd/clear-gitenv-upon-use-of-alias

 d95138e6 (setup: set env $GIT_WORK_TREE when work tree is set, like
 $GIT_DIR, 2015-06-26) attempted to work around a glitch in alias
 handling by overwriting GIT_WORK_TREE environment variable to
 affect subprocesses when set_git_work_tree() gets called, which
 resulted in a rather unpleasant regression to "clone" and "init".
 Try to address the same issue by always restoring the environment
 and respawning the real underlying command when handling alias.

 Will merge to 'master'.


* kn/ref-filter-atom-parsing (2016-01-05) 15 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: align: introduce long-form syntax
 - ref-filter: convert variable 'width' to an unsigned int
 - ref-filter: introduce parse_align_position()
 - ref-filter: introduce align_atom_parser()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: skip deref specifier in match_atom_name()
 - ref-fitler: bump match_atom() name to the top
 - ref-filter: introduce parsing functions for each valid atom
 - ref-filter: introduce struct used_atom
 - ref-filter: bump 'used_atom' and related code to the top
 - ref-filter: use strbuf_split_str_omit_term()
 - strbuf: introduce strbuf_split_str_omit_term()

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 This replaces (for now) kn/for-each-ref-remainder, which will be built
 on top.

 Still being discussed and worked on.


* bb/merge-marker-crlf (2015-11-24) 1 commit
 - merge-file: consider core.crlf when writing merge markers

 Write out merge markers using system end-of-line convention.

 Waiting for a re-roll to handle gitattributes.
 ($gmane/281701)


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for review.


* rm/subtree-unwrap-tags (2015-11-24) 1 commit
 - contrib/subtree: unwrap tag refs

 "git subtree" (in contrib/) records the tag object name in the
 commit log message when a subtree is added using a tag, without
 peeling it down to the underlying commit.  The tag needs to be
 peeled when "git subtree split" wants to work on the commit, but
 the command forgot to do so.

 Will merge to 'next'.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 - sh-setup: make require_clean_work_tree() work on orphan branches
 - Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.

 This series takes the conservative route of requiring scripts to opt
 into the looser behavior, at the expense of carrying around a new
 option-flag forever. I'm not sure if we need to do so.

 Needs review.


* tb/ls-files-eol (2016-01-07) 1 commit
 - ls-files: add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 Will merge to 'next'.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* sb/submodule-parallel-update (2016-01-12) 8 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Needs review.


* jc/strbuf-gets (2015-12-16) 17 commits
 - test-sha1-array: read command stream with strbuf_getline_crlf()
 - grep: read -f file with strbuf_getline_crlf()
 - send-pack: read list of refs with strbuf_getline_crlf()
 - column: read lines with strbuf_getline_crlf()
 - cat-file: read batch stream with strbuf_getline_crlf()
 - transport-helper: read helper response with strbuf_getline_crlf()
 - clone/sha1_file: read info/alternates with strbuf_getline_crlf()
 - remote.c: read $GIT_DIR/remotes/* with strbuf_getline_crlf()
 - ident.c: read /etc/mailname with strbuf_getline_crlf()
 - rev-parse: read parseopt spec with strbuf_getline_crlf()
 - revision: read --stdin with strbuf_getline_crlf()
 - hash-object: read --stdin-paths with strbuf_getline_crlf()
 - mktree: read textual tree representation with strbuf_getline_crlf()
 - update-index: read list of paths with strbuf_getline_crlf() under --stdin
 - update-index: read --index-info with strbuf_getline_crlf()
 - check-attr, check-ignore, checkout-index: read paths with strbuf_getline_crlf()
 - strbuf: make strbuf_getline_crlf() global

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Will be rerolled.


* mh/notes-allow-reading-treeish (2016-01-12) 1 commit
  (merged to 'next' on 2016-01-12 at 7aa311f)
 + notes: allow treeish expressions as notes ref

 Originally merged to 'next' on 2015-10-23

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 Will merge to 'master'.


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
 - am: make a direct call to merge_recursive
 - merge_recursive_options: introduce the "gently" flag

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

 Needs review.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.
 ($gmane/282594)
