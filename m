Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2630E7AE7C;
	Fri,  9 Feb 2024 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499482; cv=none; b=Kcb3zx2XfMRIQ6mr/e++USrQ1RlbGkntn3Ptmqx3d8OyLAFxKmZI+Szr796o3r7qm1J8mxyGoA8y9e7AlAk3MHt3VqtpGfTP8QeYP8sJdfQ4AvFLa5yQbr1UGi1anctWLUWHP72tPSCkw7lcR0xTMEsvP+mJGVuU4XaJA60FccU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499482; c=relaxed/simple;
	bh=DuCZGSgSWVt6wv/8iFDabIywc/tZNNd4F4Fx6RmwFWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWffHfXDX4H/QUOy5JoTG8IApGo5gjkgpQgCt9z3iL90yKkv3IYYDU6dRMBaCnx1PrJLVnu3wrfpffMATFp6IkRDu8+YcuTaEbpEK8ZPymLwwxGgHTXmmj69BCuu7Cn/K/76UcJ/8n3I6zZ16DJ/7s0BVJw9DEozbzlBhmucdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dLUAk/uY; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dLUAk/uY"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C55291DA16E;
	Fri,  9 Feb 2024 12:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DuCZGSgSWVt6wv/8iFDabIywc
	/tZNNd4F4Fx6RmwFWg=; b=dLUAk/uYz5Wvi/QjBILNK50FNd4A6q1hPz2Yi2DRf
	Cr/BmqBaOToRHj6oOrYFS7mL6lI6TYZOaB9g8zF6opbiCKOHn3u8TgeAkG1oGKEu
	ec9mdYu2cI/mxnR9deZo8dUmVz3Udf91JQ3LRY1VqBGqQsJ6agFmDBAUWRyNgeC4
	1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD6531DA16D;
	Fri,  9 Feb 2024 12:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 268C21DA16C;
	Fri,  9 Feb 2024 12:24:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.43.1
Date: Fri, 09 Feb 2024 09:24:31 -0800
Message-ID: <xmqqttmhh7ow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 166F9968-C770-11EE-9325-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

The latest maintenance release Git v2.43.1 is now available at
the usual places.  This is only to flush the accumulated fixes
on the master front down to the maintenance track.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.43.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git 2.43.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is nothing exciting to see here.  Relative to Git 2.43, this
release contains the fixes that have already been merged to the
'master' branch of the development towards the next major release.

Fixes since Git 2.43.0
----------------------

 * The way CI testing used "prove" could lead to running the test
   suite twice needlessly, which has been corrected.

 * Newer versions of Getopt::Long started giving warnings against our
   (ab)use of it in "git send-email".  Bump the minimum version
   requirement for Perl to 5.8.1 (from September 2002) to allow
   simplifying our implementation.

 * Earlier we stopped relying on commit-graph that (still) records
   information about commits that are lost from the object store,
   which has negative performance implications.  The default has been
   flipped to disable this pessimization.

 * Stale URLs have been updated to their current counterparts (or
   archive.org) and HTTP links are replaced with working HTTPS links.

 * trace2 streams used to record the URLs that potentially embed
   authentication material, which has been corrected.

 * The sample pre-commit hook that tries to catch introduction of new
   paths that use potentially non-portable characters did not notice
   an existing path getting renamed to such a problematic path, when
   rename detection was enabled.

 * The command line parser for the "log" family of commands was too
   loose when parsing certain numbers, e.g., silently ignoring the
   extra 'q' in "git log -n 1q" without complaining, which has been
   tightened up.

 * "git $cmd --end-of-options --rev -- --path" for some $cmd failed
   to interpret "--rev" as a rev, and "--path" as a path.  This was
   fixed for many programs like "reset" and "checkout".

 * "git bisect reset" has been taught to clean up state files and refs
   even when BISECT_START file is gone.

 * Some codepaths did not correctly parse configuration variables
   specified with valueless "true", which has been corrected.

 * Code clean-up for sanity checking of command line options for "git
   show-ref".

 * The code to parse the From e-mail header has been updated to avoid
   recursion.

 * "git fetch --atomic" issued an unnecessary empty error message,
   which has been corrected.

 * Command line completion script (in contrib/) learned to work better
   with the reftable backend.

 * "git status" is taught to show both the branch being bisected and
   being rebased when both are in effect at the same time.
   cf. <xmqqil76kyov.fsf@gitster.g>

 * "git archive --list extra garbage" silently ignored excess command
   line parameters, which has been corrected.

 * "git sparse-checkout set" added default patterns even when the
   patterns are being fed from the standard input, which has been
   corrected.

 * Unlike other environment variables that took the usual
   true/false/yes/no as well as 0/1, GIT_FLUSH only understood 0/1,
   which has been corrected.

 * Clearing in-core repository (happens during e.g., "git fetch
   --recurse-submodules" with commit graph enabled) made in-core
   commit object in an inconsistent state by discarding the necessary
   data from commit-graph too early, which has been corrected.

Also contains various documentation updates, code clean-ups and minor fix=
ups.

----------------------------------------------------------------

Changes since v2.43.0 are as follows:

Chandra Pratap (2):
      sideband.c: remove redundant 'NEEDSWORK' tag
      write-or-die: make GIT_FLUSH a Boolean environment variable

Elijah Newren (12):
      treewide: remove unnecessary includes from header files
      treewide: remove unnecessary includes in source files
      archive.h: remove unnecessary include
      blame.h: remove unnecessary includes
      fsmonitor--daemon.h: remove unnecessary includes
      http.h: remove unnecessary include
      line-log.h: remove unnecessary include
      pkt-line.h: remove unnecessary include
      submodule-config.h: remove unnecessary include
      trace2/tr2_tls.h: remove unnecessary include
      treewide: add direct includes currently only pulled in transitively
      treewide: remove unnecessary includes in source files

Eric Sunshine (1):
      git-add.txt: add missing short option -A to synopsis

Illia Bobyr (1):
      rebase: clarify --reschedule-failed-exec default

Jeff Hostetler (3):
      trace2: fix signature of trace2_def_param() macro
      t0211: test URL redacting in PERF format
      t0212: test URL redacting in EVENT format

Jeff King (24):
      parse-options: decouple "--end-of-options" and "--"
      bisect: always clean on reset
      config: handle NULL value when parsing non-bools
      setup: handle NULL value when parsing extensions
      trace2: handle NULL values in tr2_sysenv config callback
      help: handle NULL value for alias.* config
      submodule: handle NULL value when parsing submodule.*.branch
      trailer: handle NULL value when parsing trailer-specific config
      fsck: handle NULL value when parsing message config
      config: reject bogus values for core.checkstat
      git_xmerge_config(): prefer error() to die()
      imap-send: don't use git_die_config() inside callback
      config: use config_error_nonbool() instead of custom messages
      diff: give more detailed messages for bogus diff.* config
      config: use git_config_string() for core.checkRoundTripEncoding
      push: drop confusing configset/callback redundancy
      gpg-interface: drop pointless config_error_nonbool() checks
      sequencer: simplify away extra git_config_string() call
      mailinfo: fix out-of-bounds memory reads in unquote_quoted_pair()
      t5100: make rfc822 comment test more careful
      mailinfo: avoid recursion when unquoting From headers
      t1006: add tests for %(objectsize:disk)
      commit-graph: retain commit slab when closing NULL commit_graph
      index-pack: spawn threads atomically

Jiang Xin (5):
      t5574: test porcelain output of atomic fetch
      fetch: no redundant error message for atomic fetch
      test-pkt-line: add option parser for unpack-sideband
      pkt-line: memorize sideband fragment in reader
      pkt-line: do not chomp newlines for sideband messages

Johannes Schindelin (3):
      ci: avoid running the test suite _twice_
      packfile.c: fix a typo in `each_file_in_pack_dir_fn()`'s declaratio=
n
      trace2: redact passwords from https:// URLs by default

Josh Brobst (1):
      builtin/reflog.c: fix dry-run option short name

Josh Soref (13):
      doc: update links to current pages
      doc: switch links to https
      doc: update links for andre-simon.de
      doc: refer to internet archive
      CodingGuidelines: move period inside parentheses
      CodingGuidelines: write punctuation marks
      SubmittingPatches: drop ref to "What's in git.git"
      SubmittingPatches: discourage new trailers
      SubmittingPatches: update extra tags list
      SubmittingPatches: provide tag naming advice
      SubmittingPatches: clarify GitHub visual
      SubmittingPatches: clarify GitHub artifact format
      SubmittingPatches: hyphenate non-ASCII

Julian Prein (1):
      hooks--pre-commit: detect non-ASCII when renaming

Junio C Hamano (13):
      orphan/unborn: add to the glossary and use them consistently
      orphan/unborn: fix use of 'orphan' in end-user facing messages
      revision: parse integer arguments to --max-count, --skip, etc., mor=
e carefully
      git.txt: HEAD is not that special
      git-bisect.txt: BISECT_HEAD is not that special
      refs.h: HEAD is not that special
      docs: AUTO_MERGE is not that special
      docs: MERGE_AUTOSTASH is not that special
      doc: format.notes specify a ref under refs/notes/ hierarchy
      remote.h: retire CAS_OPT_NAME
      archive: "--list" does not take further options
      sparse-checkout: use default patterns for 'set' only !stdin
      Git 2.43.1

Linus Arver (3):
      commit: ignore_non_trailer computes number of bytes to ignore
      trailer: find the end of the log message
      trailer: use offsets for trailer_start/trailer_end

Maarten van der Schrieck (1):
      Documentation: fix statement about rebase.instructionFormat

Marcel Krause (1):
      doc: make the gitfile syntax easier to discover

Michael Lohmann (2):
      Documentation/git-merge.txt: fix reference to synopsis
      Documentation/git-merge.txt: use backticks for command wrapping

Patrick Steinhardt (31):
      ci: reorder definitions for grouping functions
      ci: make grouping setup more generic
      ci: group installation of Docker dependencies
      ci: split out logic to set up failed test artifacts
      ci: unify setup of some environment variables
      ci: squelch warnings when testing with unusable Git repo
      ci: install test dependencies for linux-musl
      ci: add support for GitLab CI
      commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
      t0410: mark tests to require the reffiles backend
      t1400: split up generic reflog tests from the reffile-specific ones
      t1401: stop treating FETCH_HEAD as real reference
      t1410: use test-tool to create empty reflog
      t1417: make `reflog --updateref` tests backend agnostic
      t3310: stop checking for reference existence via `test -f`
      t4013: simplify magic parsing and drop "failure"
      t5401: speed up creation of many branches
      t5551: stop writing packed-refs directly
      t6301: write invalid object ID via `test-tool ref-store`
      reftable: wrap EXPECT macros in do/while
      reftable: handle interrupted reads
      reftable: handle interrupted writes
      reftable/stack: verify that `reftable_stack_add()` uses auto-compac=
tion
      reftable/stack: perform auto-compaction with transactional interfac=
e
      reftable/stack: reuse buffers when reloading stack
      reftable/stack: fix stale lock when dying
      reftable/stack: fix use of unseeded randomness
      reftable/merged: reuse buffer to compute record keys
      reftable/block: introduce macro to initialize `struct block_iter`
      reftable/block: reuse buffer to compute record keys
      tests: adjust whitespace in chainlint expectations

Ren=C3=A9 Scharfe (14):
      column: release strbuf and string_list after use
      i18n: factorize even more 'incompatible options' messages
      push: use die_for_incompatible_opt4() for - -delete/--tags/--all/--=
mirror
      repack: use die_for_incompatible_opt3() for -A/-k/--cruft
      revision: use die_for_incompatible_opt3() for - -graph/--reverse/--=
walk-reflogs
      revision, rev-parse: factorize incompatibility messages about - -ex=
clude-hidden
      clean: factorize incompatibility message
      worktree: standardize incompatibility messages
      worktree: simplify incompatibility message for --orphan and commit-=
ish
      show-ref: use die_for_incompatible_opt3()
      t6300: avoid hard-coding object sizes
      rebase: use strvec_pushf() for format-patch revisions
      fast-import: use mem_pool_calloc()
      t1006: prefer shell loop to awk for packed object sizes

Rub=C3=A9n Justo (1):
      status: fix branch shown when not only bisecting

Shreyansh Paliwal (1):
      test-lib-functions.sh: fix test_grep fail message wording

Stan Hu (2):
      completion: refactor existence checks for pseudorefs
      completion: support pseudoref existence checks for reftables

Todd Zullinger (2):
      perl: bump the required Perl version to 5.8.1 from 5.8.0
      send-email: avoid duplicate specification warnings

