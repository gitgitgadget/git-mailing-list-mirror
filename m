From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2016, #05; Tue, 26)
Date: Tue, 26 Jan 2016 16:27:35 -0800
Message-ID: <xmqqr3h3amtk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 01:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aODxa-0003U8-Fn
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 01:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbcA0A1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 19:27:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbcA0A1i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 19:27:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AFBA40276;
	Tue, 26 Jan 2016 19:27:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	Nhet36QiTbwTibGLwNxpWE0O4c=; b=DKpYR8xC4eJ1+FJ87XZRZ8SmvTnOZCU2Y
	Ll3210EzlmcHFLw5pa7Uz4Nx+h33UdFYlScQelABm31+3ar788uoRYDMncGZN9Qh
	myVQHvQOfGXeCBO9VpIpFWvLE4a6AzgOhPuU0Zmf56Rs0JmlGSp3MZR7jVCI015n
	5ML6ZCa0mQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hN6
	4Gudhg8CBmm7fI8z0ghvUPp1vu5KfaWQRbU3Y8gLwlKKXunqadCTH+gzbN59OK2A
	b5NvI1HjMl+jp98GNBK4acjF5iFxjSRWFArD/y7cOLTc+b1e9vDTTah2Zt96SESe
	2jGbEQHAtEaFoebFjo/0flBNWKBTiVh3IhbgmwO4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7101040275;
	Tue, 26 Jan 2016 19:27:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A36C340274;
	Tue, 26 Jan 2016 19:27:36 -0500 (EST)
X-master-at: d10e2cb9d0299a26f43d57dd5bdcf2b3f86a30b3
X-next-at: 2d793f61b3b211a574b86fbf9750d86a2ebf6ae1
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3F64A22-C48C-11E5-AEB7-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284866>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The tip of 'master' now has a few batches of topics merged, some of
which should later be merged to 'maint'.  There are a few topics
that are v2.7.0 regression fixes still cooking outside 'master',
which also need to be merged to 'maint' for the maintenance release.

Quite a many topics have been merged to 'next', all of them feel
quite solid.  Hopefully more to follow in the rest of the week.

A big thank-you to Elia Pinto for resurrecting a long-stalled http
proxy-auth topic.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/format-patch-odir-config (2016-01-13) 1 commit
  (merged to 'next' on 2016-01-20 at 97c699b)
 + format-patch: introduce format.outputDirectory configuration

 "git format-patch" learned to notice format.outputDirectory
 configuration variable.  This allows "-o <dir>" option to be
 omitted on the command line if you always use the same directory in
 your workflow.


* ep/shell-command-substitution-style (2016-01-12) 92 commits
  (merged to 'next' on 2016-01-20 at ae1b1d8)
 + t9901-git-web--browse.sh: use the $( ... ) construct for command substitution
 + t9501-gitweb-standalone-http-status.sh: use the $( ... ) construct for command substitution
 + t9350-fast-export.sh: use the $( ... ) construct for command substitution
 + t9300-fast-import.sh: use the $( ... ) construct for command substitution
 + t9150-svk-mergetickets.sh: use the $( ... ) construct for command substitution
 + t9145-git-svn-master-branch.sh: use the $( ... ) construct for command substitution
 + t9138-git-svn-authors-prog.sh: use the $( ... ) construct for command substitution
 + t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) construct for command substitution
 + t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for command substitution
 + t9130-git-svn-authors-file.sh: use the $( ... ) construct for command substitution
 + t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct for command substitution
 + t9119-git-svn-info.sh: use the $( ... ) construct for command substitution
 + t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct for command substitution
 + t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for command substitution
 + t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for command substitution
 + t9109-git-svn-multi-glob.sh: use the $( ... ) construct for command substitution
 + t9108-git-svn-glob.sh: use the $( ... ) construct for command substitution
 + t9107-git-svn-migrate.sh: use the $( ... ) construct for command substitution
 + t9105-git-svn-commit-diff.sh: use the $( ... ) construct for command substitution
 + t9104-git-svn-follow-parent.sh: use the $( ... ) construct for command substitution
 + t9101-git-svn-props.sh: use the $( ... ) construct for command substitution
 + t9100-git-svn-basic.sh: use the $( ... ) construct for command substitution
 + t/t9001-send-email.sh: use the $( ... ) construct for command substitution
 + t/t8003-blame-corner-cases.sh: use the $( ... ) construct for command substitution
 + t/t7700-repack.sh: use the $( ... ) construct for command substitution
 + t/t7602-merge-octopus-many.sh: use the $( ... ) construct for command substitution
 + t/t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for command substitution
 + t/t7504-commit-msg-hook.sh: use the $( ... ) construct for command substitution
 + t/t7408-submodule-reference.sh: use the $( ... ) construct for command substitution
 + t/t7406-submodule-update.sh: use the $( ... ) construct for command substitution
 + t/t7103-reset-bare.sh: use the $( ... ) construct for command substitution
 + t/t7006-pager.sh: use the $( ... ) construct for command substitution
 + t/t7004-tag.sh: use the $( ... ) construct for command substitution
 + t/t7003-filter-branch.sh: use the $( ... ) construct for command substitution
 + t/t7001-mv.sh: use the $( ... ) construct for command substitution
 + t/t6132-pathspec-exclude.sh: use the $( ... ) construct for command substitution
 + t/t6032-merge-large-rename.sh: use the $( ... ) construct for command substitution
 + t/t6015-rev-list-show-all-parents.sh: use the $( ... ) construct for command substitution
 + t/t6002-rev-list-bisect.sh: use the $( ... ) construct for command substitution
 + t/t6001-rev-list-graft.sh: use the $( ... ) construct for command substitution
 + t/t5900-repo-selection.sh: use the $( ... ) construct for command substitution
 + t/t5710-info-alternate.sh: use the $( ... ) construct for command substitution
 + t/t5700-clone-reference.sh: use the $( ... ) construct for command substitution
 + t/t5601-clone.sh: use the $( ... ) construct for command substitution
 + t/t5570-git-daemon.sh: use the $( ... ) construct for command substitution
 + t/t5550-http-fetch-dumb.sh: use the $( ... ) construct for command substitution
 + t/t5538-push-shallow.sh: use the $( ... ) construct for command substitution
 + t/t5537-fetch-shallow.sh: use the $( ... ) construct for command substitution
 + t/t5532-fetch-proxy.sh: use the $( ... ) construct for command substitution
 + t/t5530-upload-pack-error.sh: use the $( ... ) construct for command substitution
 + t/t5522-pull-symlink.sh: use the $( ... ) construct for command substitution
 + t/t5517-push-mirror.sh: use the $( ... ) construct for command substitution
 + t/t5516-fetch-push.sh: use the $( ... ) construct for command substitution
 + t/t5515-fetch-merge-logic.sh: use the $( ... ) construct for command substitution
 + t/t5510-fetch.sh: use the $( ... ) construct for command substitution
 + t/t5506-remote-groups.sh: use the $( ... ) construct for command substitution
 + t/t5505-remote.sh: use the $( ... ) construct for command substitution
 + t/t5500-fetch-pack.sh: use the $( ... ) construct for command substitution
 + t/t5305-include-tag.sh: use the $( ... ) construct for command substitution
 + t/t5304-prune.sh: use the $( ... ) construct for command substitution
 + t/t5303-pack-corruption-resilience.sh: use the $( ... ) construct for command substitution
 + t/t5100: no need to use 'echo' command substitutions for globbing
 + t/t5302-pack-index.sh: use the $( ... ) construct for command substitution
 + t/t5301-sliding-window.sh: use the $( ... ) construct for command substitution
 + t/t5300-pack-object.sh: use the $( ... ) construct for command substitution
 + t/t5100-mailinfo.sh: use the $( ... ) construct for command substitution
 + t/t3700-add.sh: use the $( ... ) construct for command substitution
 + t/t3600-rm.sh: use the $( ... ) construct for command substitution
 + t/t3511-cherry-pick-x.sh: use the $( ... ) construct for command substitution
 + t/t3403-rebase-skip.sh: use the $( ... ) construct for command substitution
 + t/t3210-pack-refs.sh: use the $( ... ) construct for command substitution
 + t/t3101-ls-tree-dirname.sh: use the $( ... ) construct for command substitution
 + t/t3100-ls-tree-restrict.sh: use the $( ... ) construct for command substitution
 + t/t3030-merge-recursive.sh: use the $( ... ) construct for command substitution
 + t/t2102-update-index-symlinks.sh: use the $( ... ) construct for command substitution
 + t/t2025-worktree-add.sh: use the $( ... ) construct for command substitution
 + t/t1700-split-index.sh: use the $( ... ) construct for command substitution
 + t/t1512-rev-parse-disambiguation.sh: use the $( ... ) construct for command substitution
 + t/t1511-rev-parse-caret.sh: use the $( ... ) construct for command substitution
 + t/t1410-reflog.sh: use the $( ... ) construct for command substitution
 + t/t1401-symbolic-ref.sh: use the $( ... ) construct for command substitution
 + t/t1100-commit-tree-options.sh: use the $( ... ) construct for command substitution
 + unimplemented.sh: use the $( ... ) construct for command substitution
 + test-sha1.sh: use the $( ... ) construct for command substitution
 + t/lib-httpd.sh: use the $( ... ) construct for command substitution
 + git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for command substitution
 + contrib/thunderbird-patch-inline/appp.sh: use the $( ... ) construct for command substitution
 + contrib/examples/git-revert.sh: use the $( ... ) construct for command substitution
 + contrib/examples/git-repack.sh: use the $( ... ) construct for command substitution
 + contrib/examples/git-merge.sh: use the $( ... ) construct for command substitution
 + contrib/examples/git-fetch.sh: use the $( ... ) construct for command substitution
 + contrib/examples/git-commit.sh: use the $( ... ) construct for command substitution

 A shell script style update to change `command substitution` into
 $(command substitution).  Coverts contrib/ and much of the t/
 directory contents.


* jk/ok-to-fail-gc-auto-in-rebase (2016-01-13) 1 commit
  (merged to 'next' on 2016-01-20 at c9a8e82)
 + rebase: ignore failures from "gc --auto"

 "git rebase", unlike all other callers of "gc --auto", did not
 ignore the exit code from "gc --auto".


* jk/symbolic-ref (2016-01-13) 6 commits
  (merged to 'next' on 2016-01-20 at 30b5408)
 + lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
 + lock_ref_sha1_basic: always fill old_oid while holding lock
 + checkout,clone: check return value of create_symref
 + create_symref: write reflog while holding lock
 + create_symref: use existing ref-lock code
 + create_symref: modernize variable names

 The low-level code that is used to create symbolic references has
 been updated to share more code with the code that deals with
 normal references.


* js/close-packs-before-gc (2016-01-13) 4 commits
  (merged to 'next' on 2016-01-20 at 16cf87b)
 + receive-pack: release pack files before garbage-collecting
 + merge: release pack files before garbage-collecting
 + am: release pack files before garbage-collecting
 + fetch: release pack files before garbage-collecting

 Many codepaths that run "gc --auto" before exiting kept packfiles
 mapped and left the file descriptors to them open, which was not
 friendly to systems that cannot remove files that are open.  They
 now close the packs before doing so.


* js/pull-rebase-i (2016-01-13) 3 commits
  (merged to 'next' on 2016-01-20 at a0c5440)
 + completion: add missing branch.*.rebase values
 + remote: handle the config setting branch.*.rebase=interactive
 + pull: allow interactive rebase with --rebase=interactive

 "git pull --rebase" has been extended to allow invoking
 "rebase -i".


* rm/subtree-unwrap-tags (2015-11-24) 1 commit
  (merged to 'next' on 2016-01-20 at 6373d95)
 + contrib/subtree: unwrap tag refs

 "git subtree" (in contrib/) records the tag object name in the
 commit log message when a subtree is added using a tag, without
 peeling it down to the underlying commit.  The tag needs to be
 peeled when "git subtree split" wants to work on the commit, but
 the command forgot to do so.


* rp/p4-filetype-change (2016-01-13) 1 commit
  (merged to 'next' on 2016-01-20 at 7b5954b)
 + git-p4.py: add support for filetype change

 "git p4" learned to cope with the type of a file getting changed.

--------------------------------------------------
[New Topics]

* lv/add-doc-working-tree (2016-01-21) 1 commit
  (merged to 'next' on 2016-01-26 at c5b1ab1)
 + git-add doc: do not say working directory when you mean working tree

 Will merge to 'master'.


* mk/asciidoctor-bq-workaround (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at 19a742a)
 + Documentation: remove unnecessary backslashes

 Will merge to 'master'.


* nd/diff-with-path-params (2016-01-21) 2 commits
  (merged to 'next' on 2016-01-26 at b29a363)
 + diff: make -O and --output work in subdirectory
 + diff-no-index: do not take a redundant prefix argument

 A few options of "git diff" did not work well when the command was
 run from a subdirectory.

 Will merge to 'master'.


* tb/complete-word-diff-regex (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at a5beecc)
 + completion: complete "diff --word-diff-regex="

 Will merge to 'master'.


* tg/ls-remote-symref (2016-01-19) 5 commits
  (merged to 'next' on 2016-01-26 at e466ee2)
 + ls-remote: add support for showing symrefs
 + ls-remote: use parse-options api
 + ls-remote: fix synopsis
 + ls-remote: document --refs option
 + ls-remote: document --quiet option

 Teach "ls-remote" an option to show which branch the remote
 repository advertises as its primary by pointing its HEAD at.

 Will merge to 'master'.


* jk/ref-cache-non-repository-optim (2016-01-25) 2 commits
  (merged to 'next' on 2016-01-26 at 09057bc)
 + resolve_gitlink_ref: ignore non-repository paths
 + clean: make is_git_repository a public function

 Teach the underlying machinery used by "ls-files -o" and other
 commands not to create empty submodule ref cache for a directory
 that is not a submodule.  This removes a ton of wasted CPU cycles.

 Will merge to 'master'.


* jk/completion-rebase (2016-01-25) 1 commit
  (merged to 'next' on 2016-01-26 at def3e0b)
 + completion: add missing git-rebase options

 Will merge to 'master'.


* jk/list-tag-2.7-regression (2016-01-26) 2 commits
  (merged to 'next' on 2016-01-26 at fb9ccee)
 + tag: do not show ambiguous tag names as "tags/foo"
 + t6300: use test_atom for some un-modern tests

 "git tag" started listing a tag "foo" as "tags/foo" when a branch
 named "foo" exists in the same repository; remove this unnecessary
 disambiguation, which is a regression introduced in v2.7.0.

 Will merge to 'master'.


* pw/completion-show-branch (2016-01-25) 1 commit
  (merged to 'next' on 2016-01-26 at d0d7735)
 + completion: complete show-branch "--date-order"

 Will merge to 'master'.


* js/mingw-tests (2016-01-26) 20 commits
 - mingw: skip a test in t9130 that cannot pass on Windows
 - mingw: do not bother to test funny file names
 - mingw: handle the missing POSIXPERM prereq in t9124
 - mingw: avoid illegal filename in t9118
 - mingw: mark t9100's test cases with appropriate prereqs
 - Avoid absolute path in t0008
 - mingw: work around pwd issues in the tests
 - mingw: fix t9700's assumption about directory separators
 - mingw: skip test in t1508 that fails due to path conversion
 - tests: turn off git-daemon tests if FIFOs are not available
 - mingw: disable mkfifo-based tests
 - mingw: accomodate t0060-path-utils for MSYS2
 - mingw: fix t5601-clone.sh
 - mingw: let lstat() fail with errno == ENOTDIR when appropriate
 - mingw: try to delete target directory before renaming
 - mingw: prepare the TMPDIR environment variable for shell scripts
 - mingw: factor out Windows specific environment setup
 - Git.pm: stop assuming that absolute paths start with a slash
 - mingw: do not trust MSYS2's MinGW gettext.sh
 - mingw: let's use gettext with MSYS2
 (this branch uses js/msys2.)

 Updates test scripts to remove assumptions that are not portable
 between Git for POSIX and Git for Windows, or to skip ones with
 expectations that are not satisfiable on Git for Windows.

 Looks mostly done, but I had to tweak a few things, so
 Waiting for re-test.


* js/xmerge-maker-eol (2016-01-26) 2 commits
 - merge-file: ensure that conflict sections match eol style
 - merge-file: let conflict markers match end-of-line style of the context

 The low-level merge machinery has been taught to use CRLF line
 termination when inserting conflict markers to merged contents that
 are themselves CRLF line-terminated.

 Will merge to 'next'.


* nd/clear-gitenv-upon-use-of-alias (2016-01-26) 3 commits
 - git: simplify environment save/restore logic
 - git: protect against unbalanced calls to {save,restore}_env()
 - git: remove an early return from save_env_before_alias()

 The automatic typo correction applied to an alias was broken
 with a recent change already in 'master'.

 Waiting for a response.
 This is my attempt to clarify an original from Duy by splitting it
 into a minimal fix and clean-up.


* pw/completion-stash (2016-01-26) 1 commit
  (merged to 'next' on 2016-01-26 at e41153c)
 + completion: update completion arguments for stash

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

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

* kf/http-proxy-auth-methods (2016-01-26) 2 commits
 - http: use credential API to handle proxy authentication
 - http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 Will merge to 'next'.


* dg/subtree-rebase-test (2016-01-19) 1 commit
 - contrib/subtree: Add a test for subtree rebase that loses commits

 Reviewed up to v5.
 Will be rerolled.
 ($gmane/284426)


* jk/shortlog (2016-01-19) 7 commits
  (merged to 'next' on 2016-01-22 at f1c688c)
 + shortlog: don't warn on empty author
 + shortlog: optimize out useless string list
 + shortlog: optimize out useless "<none>" normalization
 + shortlog: optimize "--summary" mode
 + shortlog: replace hand-parsing of author with pretty-printer
 + shortlog: use strbufs to read from stdin
 + shortlog: match both "Author:" and "author" on stdin

 "git shortlog" used to accumulate various pieces of information
 regardless of what was asked to be shown in the final output.  It
 has been optimized by noticing what need not to be collected
 (e.g. there is no need to collect the log messages when showing
 only the number of changes).

 Will merge to 'master'.


* jc/peace-with-crlf (2016-01-15) 12 commits
  (merged to 'next' on 2016-01-26 at 08724bc)
 + test-sha1-array: read command stream with strbuf_getline()
 + grep: read -f file with strbuf_getline()
 + send-pack: read list of refs with strbuf_getline()
 + column: read lines with strbuf_getline()
 + cat-file: read batch stream with strbuf_getline()
 + transport-helper: read helper response with strbuf_getline()
 + clone/sha1_file: read info/alternates with strbuf_getline()
 + remote.c: read $GIT_DIR/remotes/* with strbuf_getline()
 + ident.c: read /etc/mailname with strbuf_getline()
 + rev-parse: read parseopt spec with strbuf_getline()
 + revision: read --stdin with strbuf_getline()
 + hash-object: read --stdin-paths with strbuf_getline()
 (this branch uses jc/strbuf-getline.)

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Will merge to 'master'.


* dg/subtree-test (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-26 at 81f1356)
 + contrib/subtree: Make testing easier

 Will merge to 'master'.


* jk/filter-branch-no-index (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-22 at 312aa2c)
 + filter-branch: resolve $commit^{tree} in no-index case

 A recent optimization to filter-branch in v2.7.0 introduced a
 regression when --prune-empty filter is used, which has been
 corrected.

 Will merge to 'master'.


* jk/sanity (2016-01-19) 1 commit
  (merged to 'next' on 2016-01-22 at 612cc5f)
 + test-lib: clarify and tighten SANITY

 The description for SANITY prerequisite the test suite uses has
 been clarified both in the comment and in the implementation.

 Will merge to 'master'.


* ls/travis-prove-order (2016-01-26) 2 commits
  (merged to 'next' on 2016-01-26 at d8e2a4a)
 + travis-ci: explicity use container-based infrastructure
 + travis-ci: run previously failed tests first, then slowest to fastest

 By persisting runtime statistics of previous "prove" run, execute
 tests that take longer before other ones, to reduce the total
 wallclock time when running with Travis CI.

 Will merge to 'master'.


* nd/do-not-move-worktree-manually (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at c539221)
 + worktree: stop supporting moving worktrees manually
 + worktree.c: fix indentation

 "git worktree" had a broken code that attempted to auto-fix
 possible inconsistency that results from end-users moving a
 worktree to different places without telling Git (the original
 repository needs to maintain backpointers to its worktrees, but
 "mv" run by end-users who are not familiar with that fact will
 obviously not adjust them), which actually made things worse
 when triggered.

 Will merge to 'master'.


* sb/submodule-init (2016-01-25) 2 commits
 - submodule: port init from shell to C
 - submodule: port resolve_relative_url from shell to C
 (this branch uses sb/submodule-parallel-update.)

 Major part of "git submodule init" has been ported to C.

 Will have to wait for 'sb/submodule-parallel-update'.


* js/msys2 (2016-01-15) 9 commits
  (merged to 'next' on 2016-01-22 at 8bab6ab)
 + mingw: uglify (a, 0) definitions to shut up warnings
 + mingw: squash another warning about a cast
 + mingw: avoid warnings when casting HANDLEs to int
 + mingw: avoid redefining S_* constants
 + compat/winansi: support compiling with MSys2
 + compat/mingw: support MSys2-based MinGW build
 + nedmalloc: allow compiling with MSys2's compiler
 + config.mak.uname: supporting 64-bit MSys2
 + config.mak.uname: support MSys2
 (this branch is used by js/mingw-tests.)

 Beginning of the upstreaming process of Git for Windows effort.

 Will merge to 'master'.


* tk/interpret-trailers-in-place (2016-01-14) 2 commits
  (merged to 'next' on 2016-01-22 at 5db0cf8)
 + interpret-trailers: add option for in-place editing
 + trailer: allow to write to files other than stdout

 "interpret-trailers" has been taught to optionally update a file in
 place, instead of always writing the result to the standard output.

 Will merge to 'master'.


* js/dirname-basename (2016-01-25) 6 commits
  (merged to 'next' on 2016-01-26 at b16b2b8)
 + mingw: avoid linking to the C library's isalpha()
  (merged to 'next' on 2016-01-20 at d198512)
 + t0060: loosen overly strict expectations
  (merged to 'next' on 2016-01-12 at c3c970a)
 + t0060: verify that basename() and dirname() work as expected
 + compat/basename.c: provide a dirname() compatibility function
 + compat/basename: make basename() conform to POSIX
 + Refactor skipping DOS drive prefixes

 dirname() emulation has been added, as Msys2 lacks it.

 Will merge to 'master'.


* wp/sha1-name-negative-match (2016-01-13) 2 commits
 - object name: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "<branch>^{/!-<pattern>}" notation to name a commit
 reachable from <branch> that does not match the given <pattern>.

 A questionable corner case where commit has no message remains.

 Waiting for review.
 ($gmane/283971)


* jk/notes-merge-from-anywhere (2016-01-17) 1 commit
  (merged to 'next' on 2016-01-26 at c60ac66)
 + notes: allow merging from arbitrary references

 "git notes merge" used to limit the source of the merged notes tree
 to somewhere under refs/notes/ hierarchy, which was too limiting
 when inventing a workflow to exchange notes with remote
 repositories using remote-tracking notes trees (located in e.g.
 refs/remote-notes/ or somesuch).

 Will merge to 'master'.


* dt/unpack-compare-entry-optim (2016-01-22) 2 commits
  (merged to 'next' on 2016-01-26 at 110e053)
 + unpack-trees: fix accidentally quadratic behavior
  (merged to 'next' on 2016-01-20 at 180dccf)
 + do_compare_entry: use already-computed path

 "git checkout $branch" (and other operations that share the same
 underlying machinery) has been optimized.

 Will merge to 'master'.


* cc/untracked (2016-01-25) 11 commits
 - t7063: add tests for core.untrackedCache
 - test-dump-untracked-cache: don't modify the untracked cache
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

 Will merge to 'next'.


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


* dw/subtree-split-do-not-drop-merge (2016-01-20) 1 commit
  (merged to 'next' on 2016-01-26 at 3cfefef)
 + contrib/subtree: fix "subtree split" skipped-merge bug

 The "split" subcommand of "git subtree" (in contrib/) incorrectly
 skipped merges when it shouldn't, which was corrected.

 Will merge to 'master'.


* kn/ref-filter-atom-parsing (2016-01-05) 15 commits
 . ref-filter: introduce objectname_atom_parser()
 . ref-filter: introduce contents_atom_parser()
 . ref-filter: introduce remote_ref_atom_parser()
 . ref-filter: align: introduce long-form syntax
 . ref-filter: convert variable 'width' to an unsigned int
 . ref-filter: introduce parse_align_position()
 . ref-filter: introduce align_atom_parser()
 . ref-filter: introduce color_atom_parser()
 . ref-filter: skip deref specifier in match_atom_name()
 . ref-fitler: bump match_atom() name to the top
 . ref-filter: introduce parsing functions for each valid atom
 . ref-filter: introduce struct used_atom
 . ref-filter: bump 'used_atom' and related code to the top
 . ref-filter: use strbuf_split_str_omit_term()
 . strbuf: introduce strbuf_split_str_omit_term()

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 Ejected as this will need to be rerolled on top of regression fix
 for "git tag" that started sharing the internal machinery with
 ref-filter that happened in v2.7.0.

 Needs reroll.
 ($gmane/284776).


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for a reroll.
 ($gmane/284368).


* tb/ls-files-eol (2016-01-18) 1 commit
  (merged to 'next' on 2016-01-26 at bc9246f)
 + ls-files: add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 Will merge to 'master'.


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
 (this branch is used by sb/submodule-init.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Needs review.


* jc/strbuf-getline (2016-01-15) 9 commits
  (merged to 'next' on 2016-01-22 at 8c4e051)
 + strbuf: give strbuf_getline() to the "most text friendly" variant
 + checkout-index: there are only two possible line terminations
 + update-index: there are only two possible line terminations
 + check-ignore: there are only two possible line terminations
 + check-attr: there are only two possible line terminations
 + mktree: there are only two possible line terminations
 + strbuf: introduce strbuf_getline_{lf,nul}()
 + strbuf: make strbuf_getline_crlf() global
 + strbuf: miniscule style fix
 (this branch is used by jc/peace-with-crlf.)

 The preliminary clean-up for jc/peace-with-crlf topic.

 Will merge to 'master'.


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


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2016-01-21) 7 commits
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

* bb/merge-marker-crlf (2015-11-24) 1 commit
 . merge-file: consider core.crlf when writing merge markers

 Resurrected as 'js/xmerge-maker-eol'.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 . sh-setup: make require_clean_work_tree() work on orphan branches
 . Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.
 ($gmane/284488)
