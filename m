Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333823;
	b=3b5PWmFokIIv7jFLeonIR5PBUyv2HyKw7f0NPJst9IOEsyRBObgqgPLX0+ab0G8VYOBs
	 SYSvk1n2uAOSh4/d+COs+ynYllxfqaSmLXogcFxEfnXMPbvWw7Y4TuZ9Fv7RMi/NSSoi+
	 M1QJyL7EeV5DMH3tk0sHCSD4xI8s0UatG4T0PuhmlzM4xNtNJ9Pr6UJyAHgyhC1kz0A//
	 j5AzgoH+XtYbRe1B6NTGEQtD6hQujeR3wFbsu6/ymqOpjq8rUcL34jzWN6T+QjRvBVxO9
	 As0zNRi2AwwGNXLCdHYZPJCA5M0SthihOYbpRKW7SKA6wVF4Slhb6P60aarBiMKgHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333823;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SV5lfvyALcY7fOIZa8sYuWFYmplZGlp6Nmi9Q1LMY98=;
	b=LpDPFayfre0jaQ2NhMeThnI2OZD5rZ1IWjsh55eLH0O5weRR2zIvElKw47xloe8vvtEh
	 jpXUPWaOuBRgcRehPhEUQKSnp2nJVJm1HegTBA3OhqBgtULtVBZHjwVl47XVm2GBiVKlW
	 xKfQRCFjXle5cGgTY1ytVxpeYJUW7rVFWtFBqiqc/K6q26pRfZR7WOzylcO3OhEiq6Wzt
	 nbdbFL716R9i8UC1RiX4upZQ6hpN0RCMdRPetW5ljzzBPLgYLXXw1Xz7XhSnrCry3XHxk
	 iGFx7lsRH2zMPhtv3fRvT2kt+qhl4lppdqYTnGPbSpm4yFW5EeBfDUWBbdhWwmbVXhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YmmjZ8sv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Wtpo4zL;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B42606A31C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 18:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2B42606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=YmmjZ8sv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1Wtpo4zL
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 14D2E1D0004F
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:03:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 13:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1794333820; x=1794420220; bh=SV
	5lfvyALcY7fOIZa8sYuWFYmplZGlp6Nmi9Q1LMY98=; b=YmmjZ8svx3IrfrawJe
	08QbAPwK/V71GshUr0jjDL0rJdDTMtas2AoLEHQftXZZO48701i49doqE5YaCGIP
	CGb14TBZ8nBufeqcEXadS3DzrcrbH9+Lr/V3NIV4MA9BKpJ4axqbiwzScmrVEbfy
	A9bWSXTU7cYuAlGNEjbzxSbj2YObhV3iZldH5MdURFO9D1+yEuSaeLvAgIM7po6h
	zoqYTRQHPabbx2o7Zgyde3rsX5Tc0sPagGuXrTkkwT5XORE6U2jx+mTZEmzvLyqX
	2Q3OqIKPREEpJLyaZ6hN50VQzVf7MHO/evINqV+jJ4K9TzcfA2fuWjEy2Ifaxf4W
	gBTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794333820; x=1794420220; bh=SV5lfvyALcY7fOIZa8sYuWFYmplZ
	Glp6Nmi9Q1LMY98=; b=1Wtpo4zLYaJO6WiywJTb+qPY+sUtC5SGK1XVIxeTg5bI
	TVYDmclpFbX8kiLkJZGBkldBlWbAni5aKa6e6ErOu2SIvMMG24Y59huD1bNVn9n+
	32YLxHZ6M8TS1V8sK04k7wnHk12C7g/RvJPJ/PGIoCg8YN1LXrhiW1lI2LKPskMo
	MftFqmmEr7xYh7DbxmbAPaky0nW35h6jCZK4BToIxJfhKShysFVY1yh8T5WqKcn8
	nTGJHFH1oavxOgAuGDMas5XIAhbAvlHMPbYprQ9pNCwOvAaxQ5QxCxaxOMHv7Lt9
	Aek+DZp0l1jLljhsTcIPM45vZ10b6IKAhApZaIMV/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794333820; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RJvcx8rwD2BaE4YH1TGN96F6rVOBAepgC17YK940cfX54sM
	hO5Uj+j9sjedKI9Y5WHKtEjziEWFcGldx1BRv+FJ7B3tHKanuLIh3ZIrkgZ2sDqA
	m3SOqbHFRDGi4CzOG8kqXEly2elyBSzapivtCSoSqZBRlPmDTpT2u0n3m4xp8mZQ
	Ogv6pX9eDtxUEFRS1K9N1ftiMHf/BgnaSuTtcJ6R3CMzgcMJnyTjQN4xS86Knsrm
	h8P+cxFJkRWw2OLVGoHqsltUVVgYkaej0+B11k/1vy3xWFbqbBdEAzFZKrmai38g
	l3EH0JAxdFT/eJ83PNvSGmqhICKCWUU3cgZ/vgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hknBrsLWmV7bc2wYGfVkx0hD9DjxRkZl2jCpy/R2Yg0=:9D4gpE7pohI/tnlX3w5BcDIIWAcG5WfazULMTtubLsQ=;
X-ME-Sender: <xms:fFzzalIRc50ZK1TakdVYBfTfMoXNSztzJu2F-Lct_8rsPlM9AU6PIA>
    <xme:fFzzaqlBZyxybqA7gtxSRwLYEuUCdYLnEH_rAk11gI9jmP9Vxtd0FcNIHosYrWQf_
    ioJqZ3hEziFxjBx_1sNW5OoSFum983vEkwMbFBl6UCkqlR6C7r7sgU>
X-ME-Received: <xmr:fFzzatQYVxHQDJV0TpyVWYrwmYQtSiNrAdyLTZUEk04Q9hPhoourgAcQbE-SFvdN5JfHFlwxw3KlNaklngYzbbbwaPML9qIxaas4>
X-ME-Proxy-Cause: dmFkZTFDppKHxyfs+5VvozjtsCb5z31aW5M0Os8c1oMy2eSOH8CxudA8IW4cSpbqIRH4/R
    0TRGDvMYzZ+SicERL9WCIwqfIxYpoYQDt/8V/0wwadjH6YdMpNPqVvRy7Y6OAS+QcmoCnJ
    sbaYFSDRBl2gf4g7cIlEomvklAVzFwfSL73q5n7nKvzjt6IC5SHvssXVKJYE3UxDGfLAnd
    +MvmYuRmmrbe+dYLMddr9NqJrSpc2Np4/uCia0s5PMBg1SiKT/SmlK8BjpbkNQV7LrIzxF
    MPSfer6IcR0BO+hkdpNZJy9jBvu0XNorz3dMzFz6fZKxjqrTFd7kNsdruaWDw4Te+iJKoM
    /HD0b0GF4NK322fqPOQJKtOFck+2S7dGWVpQOU6V5aDA+a4WCXL4jUlr46qNMC5sfOHZML
    YJO/a61JrwCKL5xpnlQljMr3cFrJrpmUxH1tNgODkLBs9cpqzr2zbauEcPAiu+3CaXVa29
    uUUWr+sUh3HQer5R1npUJsRxnQbI5xK0mlFRruoL0ehsVaDRc8WoN4Fwfz/d8wz/tJoIq/
    hoXjyY8p9tGZtLQKj40n6aa/jooR2OkExNotj30Qr3fHzeTJz4cfwSp121jsrYRfhNsvXe
    bsW6hB4trjc3pn6ZiDo+HiIfKSlrknaSnmC1iOwyxDoCQUmYlyG1oVv/maYg
X-ME-Proxy: <xmx:fFzzasIdv-XxLSiFCJmRe7l3zsEy8xg-fjCin9eFNN8T6VIGHWPt_g>
    <xmx:fFzzajDeIE2Y5vYXAfpnWH--0JO4NlobQRtcgzXEDFYnJ_fEx8RKDw>
    <xmx:fFzzalBN8HX7lF_07OJnGfR2DRQiayuOiAtXrJDEEAJyiZDzQk0emw>
    <xmx:fFzzalD1J0ggVgUi6PLDXVBESF9IxG9fE1vLVOcvXb22YEcH4c03Zw>
    <xmx:fFzzahIucb8w5Vy3vUZUijd02p-59xbtzTvp49G-BYDp86GOIY6Ebgbl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 13:03:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git 2.56.1 and friends
Date: Tue, 10 Nov 2026 10:03:38 -0800
Message-ID: <xmqqh5hosgw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

A maintenance release Git 2.56.1 and others for older maintenance
tracks down to maint-2.43 are now available at the usual places.

This is a set of coordinated security fix releases.  Please update
at your earliest convenience.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v2.50.2,
v2.51.3, v2.52.1, v2.53.1, v2.54.1, v2.55.1, and v2.56.1 tags:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git


Credit for organizing the set of these releases goes to Johannes
Schindelin.  Credit for finding the vulnerabilities goes to Luke
Martin and pwn2addr.  Credit for fixing them goes to Toon Claes,
Karthik Nayak, and Kaartic Sivaraam.  The xdiff hardening is based
on a patch by Jeff King, with help from Toon Claes and Christian
Couder.

------------------------------------------------------------
Git v2.56.1 Release Notes
=========================

This release merges up the fix that appears in v2.50.2, v2.51.3,
v2.52.1, v2.53.1, v2.54.1 and v2.55.1 to address CVE-2026-111760,
CVE-2026-113408, CVE-2026-114466, CVE-2026-114467, CVE-2026-114469
and CVE-2026-105437; see the release notes for these versions for
details.


------------------------------------------------------------
Git v2.50.2 Release Notes
=========================

This addresses the security issues CVE-2026-111760, CVE-2026-113408,
CVE-2026-114466, CVE-2026-114467, CVE-2026-114469 and CVE-2026-105437.

This release also backports fixes necessary to let the CI builds pass
successfully.

Fixes since v2.50.1
-------------------

 * CVE-2026-111760:

   Recursive clones are susceptible to Remote Code Execution: an
   attacker-controlled repository can be crafted in a way that exploits
   a bug in Git whereby Git can be fooled into overwriting a gitfile
   (used for submodules) with a symbolic link that then points to a
   directory with malicious config or hooks. The config or hooks may
   have attacker-specified code.

   See <https://github.com/git/git/security/advisories/GHSA-vp2w-7xxj-jvxr>
   for details.

 * CVE-2026-113408:

   It is possible for a server to advertise an unborn HEAD that contains
   path-traversal characters (e.g., `refs/heads/../../../TARGET`). With
   the files ref backend that can lead to ref-updating actions to write
   to unwanted files.

   See <https://gitlab.com/gitlab-org/git/-/work_items/809> for details.

 * CVE-2026-114467:

   When Git strips the GPG signatures from a commit message, it only
   accounts for two signatures. A commit message containing more than
   two signatures therefore causes a stack memory corruption.

   This can be triggered when using `git merge` with a tag which
   contains more than two signatures. As such, this makes way for a DoS
   attack which can potentially also affect forges when such a tag is
   pushed to a remote and a merge action is initiated.

   See <https://gitlab.com/gitlab-org/git/-/work_items/810> for details.

 * CVE-2026-114469:

   Git rejects patches larger than ~1 GiB, because its patch application
   code does not work well with large files. That check, however, only
   considered the size of the patch as it appears in the input, which for
   binary patches is much smaller than the size of the file the patch
   describes, as binary patches are compressed and encoded. A binary
   patch that inflates to a very large size therefore slipped past the
   check and crashed Git with an out-of-bounds read.

   See <https://gitlab.com/gitlab-org/git/-/work_items/811> for details.

 * CVE-2026-105437:

   When merging, Git computes the size of the buffer holding the merge
   result in a way that can overflow for very large merges, which can be
   triggered by a large number of conflicts combined with a large
   `conflict-marker-size`. The resulting buffer can then be too small,
   and Git writes past its end (and, before and after that, before its
   start), corrupting the heap.

   See <https://gitlab.com/gitlab-org/git/-/work_items/814> for details.

 * CVE-2026-114466:

   In response to CVE-2019-1348, `fast-import` disallows the
   `export-marks` feature by default. The features
   `rewrite-submodules-to` and `rewrite-submodules-from` as well as the
   option `export-pack-edges` that were introduced in the meantime also
   allow reading from arbitrary paths, and are therefore now also
   disallowed by default.

   See <https://gitlab.com/gitlab-org/git/-/work_items/812> for details.

 * Defense-in-depth: read-cache: reject cache entries with over-long
   names.

 * Various fix-ups on HTTP tests.

 * Test update.

 * HTTP Header redaction code has been adjusted for a newer version of
   cURL library that shows its traces differently from earlier
   versions.

 * The `imap-send` command was adjusted to work with OpenSSL 4.0.

 * Replace macos-13 used at GitHub CI with macos-14, and macos-14 with
   macos-15.

 * Work around a bug in the iconv library shipped with macOS 14 and 15
   that fails to correctly handle stateful ISO/IEC 2022 encoded strings.

 * ci: fix broken jobs on Ubuntu 25.10 caused by switch to sudo-rs(1).

 * ci(dockerized): raise the PID limit for private repositories.

 * ci: bump debian-11 job to debian-12.

 * ci: skip CVS and P4 tests in leaks job, too.

 * mingw: drop the -D_USE_32BIT_TIME_T option, stop using nedmalloc, and
   only use -Wl,--large-address-aware for 32-bit builds.

 * Update GitHub Actions jobs to avoid warnings against using deprecated
   version of Node.js.

----------------------------------------------------------------

Changes since v2.56.0 are as follows:

Beat Bolli (3):
      imap-send: use the OpenSSL API to access the subject alternative names
      imap-send: use the OpenSSL API to access the subject common name
      imap-send: move common code into function host_matches()

Colin Stagner (1):
      ci: ubuntu: use GNU coreutils for dirname

Collin Funk (4):
      global: constify some pointers that are not written to
      gpg-interface: remove an unnecessary NULL initialization
      bloom: remove a misleading const qualifier
      dir: avoid -Wdiscarded-qualifiers in remove_path()

Elijah Newren (1):
      read-cache: reject cache entries with over-long names

Jeff King (30):
      revision: make handle_dotdot() interface less confusing
      convert: add const to fix strchr() warnings
      http: add const to fix strchr() warnings
      transport-helper: drop const to fix strchr() warnings
      pager: explicitly cast away strchr() constness
      run-command: explicitly cast away constness when assigning to void
      pseudo-merge: fix disk reads from find_pseudo_merge()
      rev-parse: simplify dotdot parsing
      skip_prefix(): check const match between in and out params
      revision: avoid writing to const string for parent marks
      pkt-line: make packet_reader.line non-const
      rev-parse: avoid writing to const string for parent marks
      range-diff: drop const to fix strstr() warnings
      config: store allocated string in non-const pointer
      http: drop const to fix strstr() warning
      ref-filter: factor out refname component counting
      refs/files-backend: drop const to fix strchr() warning
      ref-filter: simplify lstrip_ref_components() memory handling
      git-compat-util: fix CONST_OUTPARAM typo and indentation
      ref-filter: simplify rstrip_ref_components() memory handling
      ref-filter: avoid strrchr() in rstrip_ref_components()
      ref-filter: clarify lstrip/rstrip component counting
      find_last_dir_sep(): convert inline function to macro
      ci: bump debian-11 job to debian-12
      test-lib: allow lazy prerequisite snippets as here-docs
      t5551: handle trailing slashes in expected cookies output
      t5563: add missing end-of-line in HTTP header
      revert: initialize const value
      curl: add support for curl_global_trace() components
      http: handle curl stripping creds from effective url

Johannes Schindelin (19):
      ci(dockerized): raise the PID limit for private repositories
      ci: work around Debian 12's HTTP/2 authentication failures
      ci(vs-build): adapt to Visual Studio 2026 default on windows-latest
      mingw: drop the -D_USE_32BIT_TIME_T option
      mingw: stop using nedmalloc
      mingw: only use -Wl,--large-address-aware for 32-bit builds
      t5564: use a short path for the SOCKS proxy socket
      checkout: use size_t and st_add() for cache entry length in update_some()
      read-cache: use size_t and st_add() for cache entry size in read_one_entry_opt()
      cmake: stop trying to build the reftable and xdiff libraries
      t1600-index: add expensive tests for over-long tree paths
      ci(vs-build) make the VS-built git.exe adjust MSYSTEM/PATH
      Git 2.50.2
      Git 2.51.3
      Git 2.52.1
      Git 2.53.1
      Git 2.54.1
      Git 2.55.1
      Git 2.56.1

Junio C Hamano (2):
      GitHub CI: macos-13 images are no more
      ci: skip CVS and P4 tests in leaks job, too

Kaartic Sivaraam (3):
      git-compat-util: add st_add5() helper to detect size_t overflow
      xdiff: use size_t for merge buffer size computations
      xdiff: check for overflow when computing merge buffer size

Karthik Nayak (8):
      base85: cleanup unused debug code
      base85: introduce a new `chunk_and_encode85()` function
      test-tool: add command to encode-chunk base85
      apply: reject binary patches greater than MAX_APPLY_SIZE
      apply: add tests mismatch in binary patch size
      commit: rewrite `remove_signature()` to work with multiple signatures
      fast-import: add safeguard around rewrite-submodules features
      fast-import: add safeguard around 'export-pack-edges'

Patrick Steinhardt (15):
      build: tolerate use of _Generic from glibc 2.43 with Clang
      ci: fix broken jobs on Ubuntu 25.10 caused by switch to sudo-rs(1)
      t7528: work around ETOOMANY in OpenSSH 10.1 and newer
      meson: simplify iconv-emits-BOM check
      meson: detect broken iconv that requires ICONV_RESTART_RESET
      gitlab-ci: update to macOS 15 images
      README: add GitLab CI badge to make it more discoverable
      t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t4141: fix inefficient use of dd(1)
      t5608: reduce maximum disk usage
      t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t7900: clean up large EXPENSIVE repository
      t: use `test_bool_env` to parse GIT_TEST_LONG
      gitlab-ci: disable RAM disk on macOS jobs
      gitlab-ci: enable "GIT_TEST_LONG"

Paul Tarjan (1):
      t7800: fix racy "difftool --dir-diff syncs worktree" test

René Scharfe (2):
      macOS: make Homebrew use configurable
      macOS: use iconv from Homebrew if needed and present

Tamir Duberstein (2):
      t4205: compare huge output without diff
      ci: use twice the CPU count on both providers

Toon Claes (6):
      meson: ignore subprojects/.wraplock
      meson: only detect ICONV_OMITS_BOM if possible
      meson: use is_cross_build() where possible
      connect: validate unborn HEAD symref-target in protocol v2
      connect: validate born ref symref-target in protocol v2
      connect: validate ref names in protocol v2 ls-refs response

Torsten Bögershausen (2):
      utf8.c: prepare workaround for iconv under macOS 14/15
      utf8.c: enable workaround for iconv under macOS 14/15


