Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F919A
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399912; cv=none; b=Mi9Q+Gf2AQMVI2zLEbdJqeg1+MlgmQjdVHQAqPsiH+Y6iGXPDU3TZNxoYBghn1suzwOmGm6oBfeR9574QXWhzeO2oS7nMfPSQY4mJZOI7uhzjtdDKq9ovMX+oq2o4xEU0Ua2GYjszadBPfVR202yVRME54KNJB4VFnBcETOpGKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399912; c=relaxed/simple;
	bh=Mp8uTz6gn/iTeVHFqJIIbWSvcPhdklzd/aF+JhO+OsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lXOs7btRZXVIosjww4aTokKDrMDprFerQ1sCPyHNeQ+lJI3CTS04eIABOAO/V9qR44cmZ4XHA/aOAKhTqWCdhlDNn6GGY2KQnuALcfSJBl8Ce8fuOYvP4R3YzC7LDDLEylIPsiXQL/5rLqJ/9lNqtnEjo3WZZF5HdPadiwCGzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D6DhX4am; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D6DhX4am"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 25A052442D;
	Wed, 17 Apr 2024 20:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=M
	p8uTz6gn/iTeVHFqJIIbWSvcPhdklzd/aF+JhO+OsY=; b=D6DhX4amx2ZtovnJX
	4U2i8v6z5YEckMfUKVmJD/1CHuYruUj2ThKKB+kXGiq2/zWUP7YmjxK1O/SLSchf
	4Wy36KwHP81f+Zb00izKXk00zIB2FBzfgzOOx/yJx6L75+dVwKO43oxLjHqRfCjS
	agZpcUvKVFaTDIBRwZ14QzD3Mc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DF792442C;
	Wed, 17 Apr 2024 20:25:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75D2B24428;
	Wed, 17 Apr 2024 20:25:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2024, #06; Wed, 17)
X-master-at: 21306a098c3f174ad4c2a5cddb9069ee27a548b0
X-next-at: 701ccded8beffcdb6ef223edea31263683e5129b
Date: Wed, 17 Apr 2024 17:25:03 -0700
Message-ID: <xmqqa5lr4iw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1AC28F22-FD1A-11EE-8CEF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a
future release).  Commits prefixed with '-' are only in 'seen', and
aren't considered "accepted" at all and may be annotated with an URL
to a message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity (of course they can be resubmit when new interests
arise).

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-scm/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* ba/osxkeychain-updates (2024-04-01) 4 commits
  (merged to 'next' on 2024-04-10 at 1e7d925a43)
 + osxkeychain: store new attributes
 + osxkeychain: erase matching passwords only
 + osxkeychain: erase all matching credentials
 + osxkeychain: replace deprecated SecKeychain API

 Update osxkeychain backend with features required for the recent
 credential subsystem.
 source: <pull.1667.git.1708212896.gitgitgadget@gmail.com>


* ds/fetch-config-parse-microfix (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-09 at 585dcadd63)
 + fetch: return when parsing submodule.recurse

 A config parser callback function fell through instead of returning
 after recognising and processing a variable, wasting cycles, which
 has been corrected.
 source: <pull.1709.git.1712285542303.gitgitgadget@gmail.com>


* gt/add-u-commit-i-pathspec-check (2024-04-03) 3 commits
  (merged to 'next' on 2024-04-09 at 1a0c757907)
 + builtin/add: error out when passing untracked path with -u
 + builtin/commit: error out when passing untracked path with -i
 + revision: optionally record matches with pathspec elements

 "git add -u <pathspec>" and "git commit [-i] <pathspec>" did not
 diagnose a pathspec element that did not match any files in certain
 situations, unlike "git add <pathspec>" did.
 source: <20240402213640.139682-2-shyamthakkar001@gmail.com>


* jc/local-extern-shell-rules (2024-04-05) 8 commits
  (merged to 'next' on 2024-04-10 at d3a13273e7)
 + t1016: local VAR="VAL" fix
 + t0610: local VAR="VAL" fix
 + t: teach lint that RHS of 'local VAR=VAL' needs to be quoted
 + t: local VAR="VAL" (quote ${magic-reference})
 + t: local VAR="VAL" (quote command substitution)
 + t: local VAR="VAL" (quote positional parameters)
 + CodingGuidelines: quote assigned value in 'local var=$val'
 + CodingGuidelines: describe "export VAR=VAL" rule

 Document and apply workaround for a buggy version of dash that
 mishandles "local var=val" construct.
 source: <20240406000902.3082301-1-gitster@pobox.com>


* jc/t2104-style-fixes (2024-04-09) 1 commit
  (merged to 'next' on 2024-04-11 at 7678ec509b)
 + t2104: style fixes

 Test style fixes.
 source: <xmqqmsqb4ngg.fsf@gitster.g>


* jc/unleak-core-excludesfile (2024-04-08) 1 commit
  (merged to 'next' on 2024-04-10 at ffb0c01871)
 + config: do not leak excludes_file

 The variable that holds the value read from the core.excludefile
 configuration variable used to leak, which has been corrected.
 source: <xmqqttkeicov.fsf@gitster.g>


* jk/libcurl-8.7-regression-workaround (2024-04-05) 3 commits
  (merged to 'next' on 2024-04-10 at 3b76577bfc)
 + remote-curl: add Transfer-Encoding header only for older curl
 + INSTALL: bump libcurl version to 7.21.3
 + http: reset POSTFIELDSIZE when clearing curl handle

 Fix was added to work around a regression in libcURL 8.7.0 (which has
 already been fixed in their tip of the tree).
 source: <20240402200254.GA874754@coredump.intra.peff.net>


* jt/reftable-geometric-compaction (2024-04-08) 4 commits
  (merged to 'next' on 2024-04-10 at 7e868a831c)
 + reftable/stack: use geometric table compaction
 + reftable/stack: add env to disable autocompaction
 + reftable/stack: expose option to disable auto-compaction
 + Merge branch 'ps/pack-refs-auto' into jt/reftable-geometric-compaction

 The strategy to compact multiple tables of reftables after many
 operations accumulate many entries has been improved to avoid
 accumulating too many tables uncollected.
 source: <pull.1683.v6.git.1712593016.gitgitgadget@gmail.com>


* ma/win32-unix-domain-socket (2024-04-03) 1 commit
  (merged to 'next' on 2024-04-09 at b98021a65c)
 + Win32: detect unix socket support at runtime

 Windows binary used to decide the use of unix-domain socket at
 build time, but it learned to make the decision at runtime instead.
 source: <pull.1708.git.1712158923106.gitgitgadget@gmail.com>


* ps/t0610-umask-fix (2024-04-09) 2 commits
  (merged to 'next' on 2024-04-10 at 659a29b138)
 + t0610: execute git-pack-refs(1) with specified umask
 + t0610: make `--shared=` tests reusable

 The "shared repository" test in the t0610 reftable test failed
 under restrictive umask setting (e.g. 007), which has been
 corrected.
 source: <cover.1712656576.git.ps@pks.im>


* pw/t3428-cleanup (2024-04-09) 3 commits
  (merged to 'next' on 2024-04-11 at 3c40516874)
 + t3428: restore coverage for "apply" backend
 + t3428: use test_commit_message
 + t3428: modernize test setup

 Test cleanup.
 source: <pull.1713.git.1712676444.gitgitgadget@gmail.com>


* rs/apply-lift-path-length-limit (2024-04-05) 2 commits
  (merged to 'next' on 2024-04-09 at 3270d194fd)
 + path: remove mksnpath()
 + apply: avoid fixed-size buffer in create_one_file()

 "git apply" has been updated to lift the hardcoded pathname length
 limit, which in turn allowed a mksnpath() function that is no
 longer used.
 source: <df774306-f29b-4a75-a282-59db89812b9a@web.de>


* rs/apply-reject-fd-leakfix (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-09 at 11efa0543c)
 + apply: don't leak fd on fdopen() error

 A file descriptor leak in an error codepath, used when "git apply
 --reject" fails to create the *.rej file, has been corrected.
 source: <5ba55ee4-94c7-4094-a744-584fc623b391@web.de>


* rs/date-mode-pass-by-value (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-10 at cc3c17d31c)
 + date: make DATE_MODE thread-safe

 The codepaths that reach date_mode_from_type() have been updated to
 pass "struct date_mode" by value to make them thread safe.
 source: <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>


* rs/usage-fallback-to-show-message-format (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-10 at 9a34aed4d5)
 + usage: report vsnprintf(3) failure

 vreportf(), which is usede by error() and friends, has been taught
 to give the error message printf-format string when its vsnprintf()
 call fails, instead of showing nothing useful to identify the
 nature of the error.
 source: <3da13298-b6a6-4391-b8e8-5dae9a28b860@web.de>


* sj/userdiff-c-sharp (2024-04-05) 1 commit
  (merged to 'next' on 2024-04-10 at 56aaf254a7)
 + userdiff: better method/property matching for C#

 The userdiff patterns for C# has been updated.

 Acked-by: Johannes Sixt <j6t@kdbg.org>
 cf. <c2154457-3f2f-496e-9b8b-c8ea7257027b@kdbg.org>
 source: <pull.1682.v5.git.git.1712180564927.gitgitgadget@gmail.com>


* tb/make-indent-conditional-with-non-spaces (2024-04-08) 2 commits
  (merged to 'next' on 2024-04-10 at 98aa239dc3)
 + Makefile(s): do not enforce "all indents must be done with tab"
 + Makefile(s): avoid recipe prefix in conditional statements

 Adjust to an upcoming changes to GNU make that breaks our Makefiles.
 source: <9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>


* tb/t7700-fixup (2024-04-03) 1 commit
  (merged to 'next' on 2024-04-10 at ff1f877ef7)
 + t/t7700-repack.sh: fix test breakages with `GIT_TEST_MULTI_PACK_INDEX=1 `

 Test fix.
 source: <7e8d435d58eea19d2aae0be366720f5956d29a5d.1712075189.git.me@ttaylorr.com>

--------------------------------------------------
[New Topics]

* mr/rerere-crash-fix (2024-04-16) 1 commit
  (merged to 'next' on 2024-04-17 at 60be8e2d74)
 + rerere: fix crashes due to unmatched opening conflict markers

 When .git/rr-cache/ rerere database gets corrupted or rerere is fed to
 work on a file with conflicted hunks resolved incompletely, the rerere
 machinery got confused and segfaulted, which has been corrected.

 Will merge to 'master'.
 source: <20240416105320.1113401-1-marcel@roethke.info>


* pk/bisect-use-show (2024-04-15) 1 commit
 - bisect: report the found commit with "show"

 When "git bisect" reports the commit it determined to be the
 culprit, we used to show it in a format that does not honor common
 UI tweaks, like log.date and log.decorate.  The code has been
 taught to use "git show" to follow more customizations.

 Will merge to 'next'.
 source: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se>


* ps/missing-btmp-fix (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-16 at c70779ba4b)
 + pack-bitmap: gracefully handle missing BTMP chunks

 GIt 2.44 introduced a regression that makes the updated code to
 barf in repositories with multi-pack index written by older
 versions of Git, which has been corrected.

 Will merge to 'master'.
 source: <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>


* rj/launch-editor-error-message (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-16 at 3d0dd46fc2)
 + launch_editor: waiting message on error

 Git writes a "waiting for your editor" message on an incomplete
 line after launching an editor, and then append another error
 message on the same line if the editor errors out.  It now clears
 the "waiting for..." line before giving the error message.

 Will merge to 'master'.
 source: <e208da74-8f16-44ae-912e-ae968da82057@gmail.com>


* rs/imap-send-simplify-cmd-issuing-codepath (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-17 at 0255e49f8b)
 + imap-send: increase command size limit

 Code simplification.

 Will merge to 'master'.
 source: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>


* rs/no-openssl-compilation-fix-on-macos (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-15 at 48cab93d0a)
 + git-compat-util: fix NO_OPENSSL on current macOS

 Build fix.

 Will merge to 'master'.
 source: <3188f4e2-9744-40b1-8f05-0896b8679d25@web.de>


* yb/replay-doc-linkfix (2024-04-15) 1 commit
  (merged to 'next' on 2024-04-15 at e8cf9cd9a8)
 + Documentation: fix linkgit reference

 Docfix.

 Will merge to 'master'.
 source: <pull.1706.git.git.1713132482976.gitgitgadget@gmail.com>


* rs/apply-reject-long-name (2024-04-16) 1 commit
  (merged to 'next' on 2024-04-17 at 701ccded8b)
 + apply: avoid using fixed-size buffer in write_out_one_reject()

 The filename used for rejected hunks "git apply --reject" creates
 was limited to PATH_MAX, which has been lifted.

 Will merge to 'master'.
 source: <a93cd243-cb17-4ad5-8d23-30768dc5213b@web.de>


* js/for-each-repo-keep-going (2024-04-17) 2 commits
 - maintenance: running maintenance should not stop on errors
 - for-each-repo: optionally keep going on an error

 A scheduled "git maintenance" job is expected to work on all
 repositories it knows about, but it stopped at the first one that
 errored out.  Now it keeps going.

 Expecting a (hopefully minor and final) reroll.
 cf. <CAPig+cSjoGe7Eeynz=jGSaNYWXQ-VkvWv7mv1NDeCXPFEtdqOA@mail.gmail.com>
 source: <pull.1719.git.1713342535.gitgitgadget@gmail.com>


* ps/run-auto-maintenance-in-receive-pack (2024-04-17) 2 commits
 - builtin/receive-pack: convert to use git-maintenance(1)
 - run-command: introduce function to prepare auto-maintenance process

 The "receive-pack" program (which responds to "git push") was not
 converted to run "git maintenance --auto" when other codepaths that
 used to run "git gc --auto" were updated, which has been corrected.

 Will merge to 'next'.
 source: <cover.1713334241.git.ps@pks.im>


* la/mailmap-entry (2024-04-16) 1 commit
  (merged to 'next' on 2024-04-17 at 440b18b8be)
 + mailmap: change primary address for Linus Arver

 source: <pull.1720.git.1713309711217.gitgitgadget@gmail.com>


* xx/disable-replace-when-building-midx (2024-04-17) 1 commit
 - midx: disable replace objects

 source: <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* dd/t9604-use-posix-timezones (2024-04-10) 1 commit
  (merged to 'next' on 2024-04-16 at 46ab81737f)
 + t9604: Fix test for musl libc and new Debian

 The cvsimport tests required that the platform understands
 traditional timezone notations like CST6CDT, which has been
 updated to work on those systems as long as they understand
 POSIX notation with explicit tz transition dates.

 Will merge to 'master'.
 source: <20240410032812.30476-1-congdanhqx@gmail.com>


* kn/update-ref-symrefs (2024-04-12) 8 commits
 - SQUASH???
 - refs: support symrefs in 'reference-transaction' hook
 - update-ref: add support for symref-update
 - update-ref: add support for symref-create
 - files-backend: extract out `create_symref_lock`
 - update-ref: add support for symref-delete
 - update-ref: add support for symref-verify
 - refs: accept symref values in `ref_transaction[_add]_update`

 source: <20240412095908.1134387-1-knayak@gitlab.com>


* pf/commitish-committish (2024-04-11) 1 commit
  (merged to 'next' on 2024-04-12 at 7ef816cb64)
 + typo: replace 'commitish' with 'committish'

 Spellfix.

 Will merge to 'master'.
 source: <20240407212111.55362-1-Pi.L.D.Fisher@gmail.com>


* ta/fast-import-parse-path-fix (2024-04-15) 8 commits
  (merged to 'next' on 2024-04-15 at 00cc71a679)
 + fast-import: make comments more precise
 + fast-import: forbid escaped NUL in paths
 + fast-import: document C-style escapes for paths
 + fast-import: improve documentation for path quoting
 + fast-import: remove dead strbuf
 + fast-import: allow unquoted empty path for root
 + fast-import: directly use strbufs for paths
 + fast-import: tighten path unquoting

 The way "git fast-import" handles paths described in its input has
 been tightened up and more clearly documented.

 Will merge to 'master'.
 source: <cover.1713056559.git.thalia@archibald.dev>


* xx/rfc2822-date-format-in-doc (2024-04-12) 1 commit
  (merged to 'next' on 2024-04-17 at f2186bd6e8)
 + Documentation: fix typos describing date format

 Docfix.

 Will merge to 'master'.
 source: <pull.1716.git.1712911876943.gitgitgadget@gmail.com>


* la/doc-use-of-contacts-when-contributing (2024-04-17) 9 commits
 - SQUASH???
 - SubmittingPatches: demonstrate using git-contacts with git-send-email
 - SubmittingPatches: add heading for format-patch and send-email
 - SubmittingPatches: dedupe discussion of security patches
 - SubmittingPatches: discuss reviewers first
 - SubmittingPatches: quote commands
 - SubmittingPatches: mention GitGitGadget
 - SubmittingPatches: clarify 'git-contacts' location
 - MyFirstContribution: mention contrib/contacts/git-contacts

 Advertise "git contacts", a tool for newcomers to find people to
 ask review for their patches, a bit more in our developer
 documentation.

 Almost there?
 source: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>


* ps/ci-test-with-jgit (2024-04-12) 13 commits
 - t0612: add tests to exercise Git/JGit reftable compatibility
 - t0610: fix non-portable variable assignment
 - t06xx: always execute backend-specific tests
 - ci: install JGit dependency
 - ci: make Perforce binaries executable for all users
 - ci: merge scripts which install dependencies
 - ci: fix setup of custom path for GitLab CI
 - ci: merge custom PATH directories
 - ci: convert "install-dependencies.sh" to use "/bin/sh"
 - ci: drop duplicate package installation for "linux-gcc-default"
 - ci: skip sudo when we are already root
 - ci: expose distro name in dockerized GitHub jobs
 - ci: rename "runs_on_pool" to "distro"

 Tests to ensure interoperability between reftable written by jgit
 and our code have been added and enabled in CI.
 source: <cover.1712896868.git.ps@pks.im>


* pw/rebase-i-error-message (2024-04-08) 2 commits
 - rebase -i: improve error message when picking merge
 - rebase -i: pass struct replay_opts to parse_insn_line()

 When the user adds to "git rebase -i" instruction to "pick" a merge
 commit, the error experience is not pleasant.  Such an error is now
 caught earlier in the process that parses the todo list.

 Comments?
 source: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>


* ps/reftable-write-optim (2024-04-08) 11 commits
 - reftable/block: reuse compressed array
 - reftable/block: reuse zstream when writing log blocks
 - reftable/writer: reset `last_key` instead of releasing it
 - reftable/writer: unify releasing memory
 - reftable/writer: refactorings for `writer_flush_nonempty_block()`
 - reftable/writer: refactorings for `writer_add_record()`
 - refs/reftable: don't recompute committer ident
 - reftable: remove name checks
 - refs/reftable: skip duplicate name checks
 - refs/reftable: perform explicit D/F check when writing symrefs
 - refs/reftable: fix D/F conflict error message on ref copy

 Code to write out reftable has seen some optimization and
 simplification.
 source: <cover.1712578837.git.ps@pks.im>


* ds/send-email-per-message-block (2024-04-10) 2 commits
 - send-email: make it easy to discern the messages for each patch
 - send-email: move newline characters out of a few translatable strings

 "git send-email" learned to separate its reports on each message it
 sends out with an extra blank line in between.

 Comments?
 source: <cover.1712732383.git.dsimic@manjaro.org>


* ew/khash-to-khashl (2024-03-28) 3 commits
 - khashl: fix ensemble lookups on empty table
 - treewide: switch to khashl for memory savings
 - list-objects-filter: use kh_size API

 The hashtable library "khash.h" has been replaced with "khashl.h"
 that has better memory usage characteristics.

 Needs review.
 source: <20240328101356.300374-1-e@80x24.org>


* ps/reftable-block-iteration-optim (2024-04-15) 10 commits
  (merged to 'next' on 2024-04-15 at 3a2353c7f2)
 + reftable/block: avoid copying block iterators on seek
 + reftable/block: reuse `zstream` state on inflation
 + reftable/block: open-code call to `uncompress2()`
 + reftable/block: reuse uncompressed blocks
 + reftable/reader: iterate to next block in place
 + reftable/block: move ownership of block reader into `struct table_iter`
 + reftable/block: introduce `block_reader_release()`
 + reftable/block: better grouping of functions
 + reftable/block: merge `block_iter_seek()` and `block_reader_seek()`
 + reftable/block: rename `block_reader_start()`

 The code to iterate over reftable blocks has seen some optimization
 to reduce memory allocation and deallocation.

 Will merge to 'master'.
 source: <cover.1712578376.git.ps@pks.im>


* bc/credential-scheme-enhancement (2024-04-16) 16 commits
 - credential: add method for querying capabilities
 - credential-cache: implement authtype capability
 - t: add credential tests for authtype
 - credential: add support for multistage credential rounds
 - t5563: refactor for multi-stage authentication
 - docs: set a limit on credential line length
 - credential: enable state capability
 - credential: add an argument to keep state
 - http: add support for authtype and credential
 - docs: indicate new credential protocol fields
 - credential: add a field called "ephemeral"
 - credential: gate new fields on capability
 - credential: add a field for pre-encoded credentials
 - http: use new headers for each object request
 - remote-curl: reset headers on new request
 - credential: add an authtype field

 The credential helper protocol, together with the HTTP layer, have
 been enhanced to support authentication schemes different from
 username & password pair, like Bearer and NTLM.
 source: <20240417000240.3611948-1-sandals@crustytoothpaste.net>


* tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
 - t/perf: implement performace tests for pseudo-merge bitmaps
 - pseudo-merge: implement support for finding existing merges
 - ewah: `bitmap_equals_ewah()`
 - pack-bitmap: extra trace2 information
 - pack-bitmap.c: use pseudo-merges during traversal
 - t/test-lib-functions.sh: support `--date` in `test_commit_bulk()`
 - pack-bitmap: implement test helpers for pseudo-merge
 - ewah: implement `ewah_bitmap_popcount()`
 - pseudo-merge: implement support for reading pseudo-merge commits
 - pack-bitmap.c: read pseudo-merge extension
 - pseudo-merge: scaffolding for reads
 - pack-bitmap: extract `read_bitmap()` function
 - pack-bitmap-write.c: write pseudo-merge table
 - pack-bitmap-write.c: select pseudo-merge commits
 - pseudo-merge: implement support for selecting pseudo-merge commits
 - pack-bitmap: make `bitmap_writer_push_bitmapped_commit()` public
 - pack-bitmap: implement `bitmap_writer_has_bitmapped_object_id()`
 - pack-bitmap-write: support storing pseudo-merge commits
 - pseudo-merge.ch: initial commit
 - pack-bitmap: move some initialization to `bitmap_writer_init()`
 - pack-bitmap: drop unused `max_bitmaps` parameter
 - ewah: implement `ewah_bitmap_is_subset()`
 - config: repo_config_get_expiry()
 - Documentation/technical: describe pseudo-merge bitmaps format

 The pack-bitmap machinery learned to write pseudo-merge bitmaps,
 which act as imaginary octopus merges covering un-bitmapped
 reference tips. This enhances bitmap coverage, and thus,
 performance, for repositories with many references using bitmaps.

 Expecting a reroll.
 cf. <ZfyxCLpjbaScIdWA@nand.local>
 source: <cover.1710972293.git.me@ttaylorr.com>


* la/hide-trailer-info (2024-03-16) 7 commits
 - trailer: retire trailer_info_get() from API
 - trailer: make trailer_info struct private
 - trailer: make parse_trailers() return trailer_info pointer
 - interpret-trailers: access trailer_info with new helpers
 - sequencer: use the trailer iterator
 - trailer: teach iterator about non-trailer lines
 - Merge branch 'la/format-trailer-info' into la/hide-trailer-info
 (this branch uses la/format-trailer-info.)

 The trailer API has been reshuffled a bit.

 Needs review.
 source: <pull.1696.git.1710570428.gitgitgadget@gmail.com>


* ds/doc-config-reflow (2024-03-14) 1 commit
 - config.txt: perform some minor reformatting

 Reflow a paragraph in the documentation source without any effect
 to the formatted text.

 Will discard.
 source: <97bdaf075bf5a68554cca1731eca78aff2662907.1710444774.git.dsimic@manjaro.org>


* la/format-trailer-info (2024-03-15) 5 commits
  (merged to 'next' on 2024-04-16 at dca4784407)
 + trailer: finish formatting unification
 + trailer: begin formatting unification
 + format_trailer_info(): append newline for non-trailer lines
 + format_trailer_info(): drop redundant unfold_value()
 + format_trailer_info(): use trailer_item objects
 (this branch is used by la/hide-trailer-info.)

 The code to format trailers have been cleaned up.

 Will merge to 'master'.
 source: <pull.1694.git.1710485706.gitgitgadget@gmail.com>


* ie/config-includeif-hostname (2024-03-19) 2 commits
 - config: learn the "hostname:" includeIf condition
 - t: add a test helper for getting hostname

 The conditional inclusion mechanism for configuration files learned
 to switch on the hostname.

 Expecting a reroll.
 cf. <20240319210428.GC1159535@coredump.intra.peff.net>
 cf. <20240320001934.GA903718@coredump.intra.peff.net>
 source: <20240319183722.211300-1-ignacio@iencinas.com>


* js/build-fuzz-more-often (2024-04-11) 2 commits
 - fuzz: link fuzz programs with `make all` on Linux
 - ci: also define CXX environment variable

 In addition to building the objects needed, try to link the objects
 that are used in fuzzer tests, to make sure at least they build
 without bitrot, in Linux CI runs.

 Expecting a hopefully minor and final reroll.
 cf. <20240412042247.GA1077925@coredump.intra.peff.net>
 source: <cover.1712858920.git.steadmon@google.com>


* cw/git-std-lib (2024-02-28) 4 commits
 - SQUASH??? get rid of apparent debugging crufts
 - test-stdlib: show that git-std-lib is independent
 - git-std-lib: introduce Git Standard Library
 - pager: include stdint.h because uintmax_t is used

 Split libgit.a out to a separate git-std-lib tor easier reuse.

 Expecting a reroll.
 source: <cover.1696021277.git.jonathantanmy@google.com>


* js/cmake-with-test-tool (2024-02-23) 2 commits
 - cmake: let `test-tool` run the unit tests, too
 - Merge branch 'js/unit-test-suite-runner' into js/cmake-with-test-tool
 (this branch uses js/unit-test-suite-runner.)

 "test-tool" is now built in CMake build to also run the unit tests.

 May want to roll it into the base topic.
 source: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>


* js/unit-test-suite-runner (2024-02-23) 8 commits
 - ci: use test-tool as unit test runner on Windows
 - t/Makefile: run unit tests alongside shell tests
 - unit tests: add rule for running with test-tool
 - test-tool run-command testsuite: support unit tests
 - test-tool run-command testsuite: remove hardcoded filter
 - test-tool run-command testsuite: get shell from env
 - t0080: turn t-basic unit test into a helper
 - Merge branch 'jk/unit-tests-buildfix' into js/unit-test-suite-runner
 (this branch is used by js/cmake-with-test-tool.)

 The "test-tool" has been taught to run testsuite tests in parallel,
 bypassing the need to use the "prove" tool.

 Needs review.
 source: <cover.1708728717.git.steadmon@google.com>


* bk/complete-dirname-for-am-and-format-patch (2024-01-12) 1 commit
 - completion: dir-type optargs for am, format-patch

 Command line completion support (in contrib/) has been
 updated for a few commands to complete directory names where a
 directory name is expected.

 Expecting a reroll.
 cf. <40c3a824-a961-490b-94d4-4eb23c8f713d@gmail.com>
 cf. <6683f24e-7e56-489d-be2d-8afe1fc38d2b@gmail.com>
 source: <d37781c3-6af2-409b-95a8-660a9b92d20b@smtp-relay.sendinblue.com>


* bk/complete-send-email (2024-01-12) 1 commit
 - completion: don't complete revs when --no-format-patch

 Command line completion support (in contrib/) has been taught to
 avoid offering revision names as candidates to "git send-email" when
 the command is used to send pre-generated files.

 Expecting a reroll.
 cf. <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
 source: <a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>


* tb/path-filter-fix (2024-01-31) 16 commits
 - bloom: introduce `deinit_bloom_filters()`
 - commit-graph: reuse existing Bloom filters where possible
 - object.h: fix mis-aligned flag bits table
 - commit-graph: new Bloom filter version that fixes murmur3
 - commit-graph: unconditionally load Bloom filters
 - bloom: prepare to discard incompatible Bloom filters
 - bloom: annotate filters with hash version
 - repo-settings: introduce commitgraph.changedPathsVersion
 - t4216: test changed path filters with high bit paths
 - t/helper/test-read-graph: implement `bloom-filters` mode
 - bloom.h: make `load_bloom_filter_from_graph()` public
 - t/helper/test-read-graph.c: extract `dump_graph_info()`
 - gitformat-commit-graph: describe version 2 of BDAT
 - commit-graph: ensure Bloom filters are read with consistent settings
 - revision.c: consult Bloom filters for root commits
 - t/t4216-log-bloom.sh: harden `test_bloom_filters_not_used()`

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Waiting for a final ack?
 cf. <ZcFjkfbsBfk7JQIH@nand.local>
 source: <cover.1706741516.git.me@ttaylorr.com>


* jc/rerere-cleanup (2023-08-25) 4 commits
 - rerere: modernize use of empty strbuf
 - rerere: try_merge() should use LL_MERGE_ERROR when it means an error
 - rerere: fix comment on handle_file() helper
 - rerere: simplify check_one_conflict() helper function

 Code clean-up.

 Not ready to be reviewed yet.
 source: <20230824205456.1231371-1-gitster@pobox.com>
