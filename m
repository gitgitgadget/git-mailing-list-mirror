Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6281DA2B
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lAl4VDbi"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834AD131
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 10:36:32 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DB95C38164;
	Thu,  2 Nov 2023 13:36:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=55hUiLOm9b1NH/RGtRwOthgvn
	vrhvhygaF/ah7xe17Q=; b=lAl4VDbi8yA5UVzKUDd8zWi4/gocgjK7poUMF8vmy
	qoT6NjOqsgde7qgVKqMbTfjpZUGFA3ZCK52SJiUa6THcMsZEc15UQD0W3W53c+qd
	OJXQMgOjFBEc7jfJ8UldEZpxfa9HF2b6cQaaO2tyqbwskmtDlAELa1yYw6EsME5o
	g0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D43D138163;
	Thu,  2 Nov 2023 13:36:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6AF9D38162;
	Thu,  2 Nov 2023 13:36:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.42.1
Date: Fri, 03 Nov 2023 02:36:26 +0900
Message-ID: <xmqq4ji4m50l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5A7A2E88-79A6-11EE-B24A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest maintenance release Git v2.42.1 is now available at
the usual places.

There is nothing exciting to see here.  Relative to Git 2.42, this
release contains the fixes that have already been merged to the
'master' branch of the development towards Git 2.43 that has been
tagged as Git 2.43.0-rc0.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.42.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.42.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is nothing exciting to see here.  Relative to Git 2.42, this
release contains the fixes that have already been merged to the
'master' branch of the development towards Git 2.43 that has been
tagged as Git 2.43.0-rc0.

Fixes since Git 2.42.0
----------------------

 * Tests that are known to pass with LSan are now marked as such.

 * Flaky "git p4" tests, as well as "git svn" tests, are now skipped
   in the (rather expensive) sanitizer CI job.

 * Tests with LSan from time to time seem to emit harmless message
   that makes our tests unnecessarily flaky; we work it around by
   filtering the uninteresting output.

 * GitHub CI workflow has learned to trigger Coverity check.

 * Overly long label names used in the sequencer machinery are now
   chopped to fit under filesystem limitation.

 * Scalar updates.

 * Tweak GitHub Actions CI so that pushing the same commit to multiple
   branch tips at the same time will not waste building and testing
   the same thing twice.

 * The commit-graph verification code that detects mixture of zero and
   non-zero generation numbers has been updated.

 * "git diff -w --exit-code" with various options did not work
   correctly, which is being addressed.

 * transfer.unpackLimit ought to be used as a fallback, but overrode
   fetch.unpackLimit and receive.unpackLimit instead.

 * The use of API between two calls to require_clean_work_tree() from
   the sequencer code has been cleaned up for consistency.

 * "git diff --no-such-option" and other corner cases around the exit
   status of the "diff" command has been corrected.

 * "git for-each-ref --sort=3D'contents:size'" sorts the refs according
   to size numerically, giving a ref that points at a blob twelve-byte
   (12) long before showing a blob hundred-byte (100) long.

 * Various fixes to the behavior of "rebase -i" when the command got
   interrupted by conflicting changes.

 * References from description of the `--patch` option in various
   manual pages have been simplified and improved.

 * "git grep -e A --no-or -e B" is accepted, even though the negation
   of "or" did not mean anything, which has been tightened.

 * The completion script (in contrib/) has been taught to treat the
   "-t" option to "git checkout" and "git switch" just like the
   "--track" option, to complete remote-tracking branches.

 * "git diff --no-index -R <(one) <(two)" did not work correctly,
   which has been corrected.

 * Update "git maintenance" timers' implementation based on systemd
   timers to work with WSL.

 * "git diff --cached" codepath did not fill the necessary stat
   information for a file when fsmonitor knows it is clean and ended
   up behaving as if it is not clean, which has been corrected.

 * Clarify how "alias.foo =3D : git cmd ; aliased-command-string" should
   be spelled with necessary whitespaces around punctuation marks to
   work.

 * HTTP Header redaction code has been adjusted for a newer version of
   cURL library that shows its traces differently from earlier
   versions.

 * An error message given by "git send-email" when given a malformed
   address did not give correct information, which has been corrected.

 * UBSan options were not propagated through the test framework to git
   run via the httpd, unlike ASan options, which has been corrected.

Also contains various documentation updates, code clean-ups and minor fix=
ups.

----------------------------------------------------------------

Changes since v2.42.0 are as follows:

Caleb Hill (1):
      git-clean doc: fix "without do cleaning" typo

Christian Hesse (2):
      t/lib-gpg: forcibly run a trustdb update
      t/t6300: drop magic filtering

Derrick Stolee (4):
      upload-pack: fix race condition in error messages
      scalar: add --[no-]src option
      setup: add discover_git_directory_reason()
      scalar reconfigure: help users remove buggy repos

Evan Gates (1):
      git-config: fix misworded --type=3Dpath explanation

Han Young (1):
      show doc: redirect user to git log manual instead of git diff-tree

Jacob Abel (1):
      builtin/worktree.c: fix typo in "forgot fetch" msg

Jeff King (17):
      hashmap: use expected signatures for comparison functions
      diff-files: avoid negative exit value
      diff: show usage for unknown builtin_diff_files() options
      diff: die when failing to read index in git-diff builtin
      diff: drop useless return from run_diff_{files,index} functions
      diff: drop useless return values in git-diff helpers
      diff: drop useless "status" parameter from diff_result_code()
      commit-graph: verify swapped zero/non-zero generation cases
      test-lib: ignore uninteresting LSan output
      ci: allow branch selection through "vars"
      ci: deprecate ci/config/allow-ref script
      http: factor out matching of curl http/2 trace lines
      http: update curl http/2 info matching for curl 8.3.0
      test-lib: set UBSAN_OPTIONS to match ASan
      decorate: add clear_decoration() function
      revision: clear decoration structs during release_revisions()
      daemon: free listen_addr before returning

Johannes Schindelin (12):
      rebase: allow overriding the maximal length of the generated labels
      ci: avoid building from the same commit in parallel
      ci(linux-asan-ubsan): let's save some time
      var: avoid a segmentation fault when `HOME` is unset
      completion(switch/checkout): treat --track and -t the same
      maintenance(systemd): support the Windows Subsystem for Linux
      ci: add a GitHub workflow to submit Coverity scans
      coverity: cache the Coverity Build Tool
      coverity: allow overriding the Coverity project
      coverity: support building on Windows
      coverity: allow running on macOS
      coverity: detect and report when the token or project is incorrect

Josip Sokcevic (1):
      diff-lib: fix check_removed when fsmonitor is on

Junio C Hamano (12):
      mv: fix error for moving directory to another
      diff: move the fallback "--exit-code" code down
      diff: mode-only change should be noticed by "--patch -w --exit-code=
"
      diff: teach "--stat -w --exit-code" to notice differences
      t4040: remove test that succeeded for a wrong reason
      diff: spell DIFF_INDEX_CACHED out when calling run_diff_index()
      diff: the -w option breaks --exit-code for --raw and other output m=
odes
      transfer.unpackLimit: fetch/receive.unpackLimit takes precedence
      doc: update list archive reference to use lore.kernel.org
      commit: do not use cryptic "new_index" in end-user facing messages
      am: align placeholder for --whitespace option with apply
      Git 2.42.1

Kousik Sanagavarapu (1):
      ref-filter: sort numerically when ":size" is used

Mark Ruvald Pedersen (1):
      sequencer: truncate labels to accommodate loose refs

Michal Suchanek (1):
      git-push doc: more visibility for -q option

Naomi Ibe (1):
      builtin/add.c: clean up die() messages

Oswald Buddenhagen (6):
      t9001: fix indentation in test_no_confirm()
      sequencer: rectify empty hint in call of require_clean_work_tree()
      sequencer: fix error message on failure to copy SQUASH_MSG
      t3404-rebase-interactive.sh: fix typos in title of a rewording test
      sequencer: remove unreachable exit condition in pick_commits()
      am: fix error message in parse_opt_show_current_patch()

Patrick Steinhardt (4):
      upload-pack: fix exit code when denying fetch of unreachable object=
 ID
      doc/git-worktree: mention "refs/rewritten" as per-worktree refs
      doc/git-repack: fix syntax for `-g` shorthand option
      doc/git-repack: don't mention nonexistent "--unpacked" option

Philippe Blain (1):
      completion: improve doc for complex aliases

Phillip Wood (7):
      rebase -i: move unlink() calls
      rebase -i: remove patch file after conflict resolution
      sequencer: use rebase_path_message()
      sequencer: factor out part of pick_commits()
      rebase: fix rewritten list for failed pick
      rebase --continue: refuse to commit after failed command
      rebase -i: fix adding failed command to the todo list

Ren=C3=A9 Scharfe (5):
      name-rev: use OPT_HIDDEN_BOOL for --peel-tag
      grep: use OPT_INTEGER_F for --max-depth
      grep: reject --no-or
      diff --no-index: fix -R with stdin
      parse-options: drop unused parse_opt_ctx_t member

Sergey Organov (1):
      doc/diff-options: fix link to generating patch section

Taylor Blau (7):
      commit-graph: introduce `commit_graph_generation_from_graph()`
      t/t5318-commit-graph.sh: test generation zero transitions during fs=
ck
      commit-graph: avoid repeated mixed generation number warnings
      leak tests: mark a handful of tests as leak-free
      leak tests: mark t3321-notes-stripspace.sh as leak-free
      leak tests: mark t5583-push-branches.sh as leak-free
      git-send-email.perl: avoid printing undef when validating addresses

Wesley Schwengle (2):
      git-push.txt: fix grammar
      git-svn: drop FakeTerm hack

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (1):
      doc/cat-file: make synopsis and description less confusing

=E7=8E=8B=E5=B8=B8=E6=96=B0 (1):
      merge-ort.c: fix typo 'neeed' to 'needed'

