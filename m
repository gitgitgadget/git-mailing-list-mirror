Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186752E6D0A;
	Tue,  8 Jul 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993983; cv=none; b=iU7Hl8Xh77pYDBp/2PNuDmtZ5zxhlLlYuEgHeQD8i2OKSEllTwBAgqF/H7z6m+Ur3LDR1fRqi99NWJdaXIg+wR5lKr23WjNdvMuMrAY6/19wQwbJ0pA4bnUc6Fx2U+cw6iQzqzrdITl4996OtsBmNzY1q3Pcsjl79MHb2/HNHzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993983; c=relaxed/simple;
	bh=WL9qbGGHqFwSq7nIOklWqRuuQeb8h3O8JSKvPf4DkXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9mtL9OPmSmiC2hjpQp11t3GnYkAestCzN09v9HPh9FNNGMRUxllZaX4r/Swqlx2sm0hYTS73Uicq+TBICdlZ/53Qg7/X/rp7ytBpqgP+JAwmuothJk8vpFjOoR/tmh9PNvI35miCcvO9G4msJGEu6AR15YLp2wytf+obwrn6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mxFEV1+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNSuDRzd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mxFEV1+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNSuDRzd"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A7D31D002C5;
	Tue,  8 Jul 2025 12:59:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 12:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1751993980; x=1752080380; bh=cFcOEE0CyG9AGdCAyEWEe+70bjeiG3r+
	X4smHoiZEEY=; b=mxFEV1+51GTLTSo9nhsSa97FVvRElfrb6ChlqUF1y7XGPJcp
	RPf9DAJIQoq4JincDmyuqmJkC5uE0KMViFAEnbWL9EmlUUzNl81UmEr4zt3PS9yD
	WqcJN1wuA56tcdGSSopaYnmMBFhSA9iDmPbDeL0Ko9GmgV7c02SruRT4E0o0cHec
	sp1igZD+0zTMYj2UTeqX332rnpTd/iXvNGVURDiv7fJjbtUTarnbb4OgtcMWkYjJ
	v+LHhTqfQ4pGMIaLwgd46LEBMpbJNhAr7YeoVU4cR4SbKfcAXIho0iFOMsnhYzBn
	tUJ3E1qGSZFrjnRE7SxhqExT1Dzlvynrb1k9Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751993980; x=
	1752080380; bh=cFcOEE0CyG9AGdCAyEWEe+70bjeiG3r+X4smHoiZEEY=; b=M
	NSuDRzdKqJSpteFrg3GPy6JsiEsgugbuQJtozyYN5lHs4IbzZoRdZEyYTMlmq7uA
	wMj4bGW+qnZ7KMt4oJi1Pgul3vZYDwZ5SDx4T1G79J+veKXFBYBd/crtD88/CULP
	ED5LSQMpWkP5F7jETIXuabiKNm83dioAJrP5EF8CQOaURfBLu2gewnSY/sAki1ZO
	5cmW5QzlUS3HAzJZ2iBvBtx7oHePGf2nCn5JUQ9+XtUPCNjrCqwXFaKQqPkSh6V6
	P10qGt0TKvvRJhib/we8IH0szNCeLlwHl2fucBM4+Fa+LhukUqxi9qHEDygIe0hI
	b+LPqLiylKc710U8Zn2qw==
X-ME-Sender: <xms:e05taFnup0KidEZpOUh91ccOEuQ8_wvH3GYmvapxqeSvMmMpmcQCvw>
    <xme:e05taLyQ4LgmYalFv_bqtz5wK_RKaXfORNXFZUJUmIKQc-5BeMJFrNFAiLj8_kBlh
    PoehjFEx9dEWPqM2Q>
X-ME-Received: <xmr:e05taKr-_vx9YXrI3v8udlAwy0Jd4jtGkyuzXDKW0arTVIwjqgCqGoOoWwijjsqcwlH_JNkD9sRv3ShdXQnJHXp6VXtRDxQ_JLWxqG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehjuhhnihhosehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    euueeivdfhvdefudehteehueegjeeiudfggefhfeefffefhfefhefhjeekfeeufeenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtghomhdpoh
    hrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhssehg
    ohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlfihnsehlfihnrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjuhhn
    ihhosehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:e05taK4u5QCO12RJeP4ZncNiDrcp1Crp6W-48eZg7TNcFDJ3DTRCBg>
    <xmx:e05taBcQMSE1VHnUiB-FH4Y0mN9WRJUKel2YEHfEW5uYAdI7Dt1veA>
    <xmx:e05taP7xO4w_qa08C7n1JBKihzvYsnwXghJiIVxJB_SP8bj3SLFJEQ>
    <xmx:e05taIsRzTLIp8i6a4qSDeHiO-BqXGgN9h1Yv038eP8baO7fV_SqvA>
    <xmx:e05taHSFZau2bAD7qFb8cYhY7sik6i_o7TRr-uk_FgmKB2D4UEIfpqvj>
Feedback-ID: i1ffb436d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 12:59:39 -0400 (EDT)
From: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
    git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.50.1 and friends
Date: Tue, 08 Jul 2025 09:59:38 -0700
Message-ID: <xmqq5xg2wrd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A maintenance release Git v2.50.1 and others for older maintenance
tracks down to maint-2.43 are now available at the usual places.

This is a set of coordinated security fix releases.  Please update
at your earliest convenience.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v2.43.7,
v2.44.4, v2.45.4, v2.46.4, v2.47.3, v2.48.2, v2.49.1 and v2.50.1
tags:

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.50.1 Release Notes
=========================

This release merges up the fixes that appear in v2.43.7, v2.44.4,
v2.45.4, v2.46.4, v2.47.3, v2.48.2, and v2.49.1 to address the
following CVEs: CVE-2025-27613, CVE-2025-27614, CVE-2025-46334,
CVE-2025-46835, CVE-2025-48384, CVE-2025-48385, and
CVE-2025-48386. See the release notes for v2.43.7 for details.

----------------------------------------------------------------

Git v2.43.7 Release Notes
=========================

This release includes fixes for CVE-2025-27613, CVE-2025-27614,
CVE-2025-46334, CVE-2025-46835, CVE-2025-48384, CVE-2025-48385, and
CVE-2025-48386.

Fixes since v2.43.6
-------------------

 * CVE-2025-27613, Gitk:

   When a user clones an untrusted repository and runs Gitk without
   additional command arguments, any writable file can be created and
   truncated. The option "Support per-file encoding" must have been
   enabled. The operation "Show origin of this line" is affected as
   well, regardless of the option being enabled or not.

 * CVE-2025-27614, Gitk:

   A Git repository can be crafted in such a way that a user who has
   cloned the repository can be tricked into running any script
   supplied by the attacker by invoking `gitk filename`, where
   `filename` has a particular structure.

 * CVE-2025-46334, Git GUI (Windows only):

   A malicious repository can ship versions of sh.exe or typical
   textconv filter programs such as astextplain. On Windows, path
   lookup can find such executables in the worktree. These programs
   are invoked when the user selects "Git Bash" or "Browse Files" from
   the menu.

 * CVE-2025-46835, Git GUI:

   When a user clones an untrusted repository and is tricked into
   editing a file located in a maliciously named directory in the
   repository, then Git GUI can create and overwrite any writable
   file.

 * CVE-2025-48384, Git:

   When reading a config value, Git strips any trailing carriage
   return and line feed (CRLF). When writing a config entry, values
   with a trailing CR are not quoted, causing the CR to be lost when
   the config is later read.  When initializing a submodule, if the
   submodule path contains a trailing CR, the altered path is read
   resulting in the submodule being checked out to an incorrect
   location. If a symlink exists that points the altered path to the
   submodule hooks directory, and the submodule contains an executable
   post-checkout hook, the script may be unintentionally executed
   after checkout.

 * CVE-2025-48385, Git:

   When cloning a repository Git knows to optionally fetch a bundle
   advertised by the remote server, which allows the server-side to
   offload parts of the clone to a CDN. The Git client does not
   perform sufficient validation of the advertised bundles, which
   allows the remote side to perform protocol injection.

   This protocol injection can cause the client to write the fetched
   bundle to a location controlled by the adversary. The fetched
   content is fully controlled by the server, which can in the worst
   case lead to arbitrary code execution.

 * CVE-2025-48386, Git:

   The wincred credential helper uses a static buffer (`target`) as a
   unique key for storing and comparing against internal storage. This
   credential helper does not properly bounds check the available
   space remaining in the buffer before appending to it with
   `wcsncat()`, leading to potential buffer overflows.

----------------------------------------------------------------

Changes since v2.50.0 are as follows:

Avi Halachmi (:avih) (1):
      gitk: encode arguments correctly with "open"

Johannes Sixt (27):
      gitk: treat file names beginning with "|" as relative paths
      gitk: have callers of diffcmd supply pipe symbol when necessary
      gitk: sanitize 'exec' arguments: simple cases
      gitk: sanitize 'exec' arguments: 'eval exec'
      gitk: sanitize 'exec' arguments: redirections
      gitk: sanitize 'exec' arguments: redirections and background
      gitk: sanitize 'exec' arguments: redirect to process
      gitk: sanitize 'open' arguments: simple commands
      gitk: sanitize 'open' arguments: simple commands with redirections
      gitk: sanitize 'open' arguments: simple commands, readable and writable
      gitk: collect construction of blameargs into a single conditional
      gitk: sanitize 'open' arguments: command pipeline
      git-gui: remove special treatment of Windows from open_cmd_pipe
      git-gui: remove git config --list handling for git < 1.5.3
      git-gui: treat file names beginning with "|" as relative paths
      git-gui: sanitize 'exec' arguments: simple cases
      git-gui: sanitize 'exec' arguments: background
      git-gui: remove option --stderr from git_read
      git-gui: break out a separate function git_read_nice
      git-gui: use git_read in githook_read
      gitk: sanitize 'open' arguments: revisit recently updated 'open' calls
      git-gui: convert git_read*, git_write to be non-variadic
      git-gui: pass redirections as separate argument to _open_stdout_stderr
      git-gui: pass redirections as separate argument to git_read
      git-gui: introduce function git_redir for git calls with redirections
      git-gui: do not mistake command arguments as redirection operators
      git-gui: sanitize 'exec' arguments: convert new 'cygpath' calls

Junio C Hamano (2):
      Git 2.49.1
      Git 2.50.1

Justin Tobler (1):
      config: quote values containing CR character

Mark Levedahl (13):
      git-gui: _which, only add .exe suffix if not present
      git-gui: use [is_Windows], not bad _shellpath
      git-gui: make _shellpath usable on startup
      git-gui: remove Tcl 8.4 workaround on 2>@1 redirection
      git-gui: use only the configured shell
      git-gui: remove HEAD detachment implementation for git < 1.5.3
      git-gui: remove unused proc is_shellscript
      git-gui: avoid auto_execok for git-bash menu item
      git-gui: avoid auto_execok in do_windows_shortcut
      git-gui: cleanup git-bash menu item
      git-gui: assure PATH has only absolute elements.
      git-gui: sanitize $PATH on all platforms
      git-gui: override exec and open only on Windows

Patrick Steinhardt' via Git Security (1):
      bundle-uri: fix arbitrary file writes via parameter injection

Taylor Blau (7):
      wincred: avoid buffer overflow in wcsncat()
      Git 2.43.7
      Git 2.44.4
      Git 2.45.4
      Git 2.46.4
      Git 2.47.3
      Git 2.48.2

