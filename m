Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4087263B;
	Tue,  8 Jul 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994118; cv=none; b=CPVlkCtgZoJjrmIWeIeqW3urC6dolMTvOGlZPzuJaK4hfmEcsX64DkpxowgEX6F+8nNWazMBHSHKCT4jX2u3ND0LjTA0NKGXdhozEevoVhvGfoaTU/sHW9YRno4F010bX2o1rG5FSKNNuuuvqzpdxlyAZc3asZ2Dpt+PolGXdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994118; c=relaxed/simple;
	bh=WL9qbGGHqFwSq7nIOklWqRuuQeb8h3O8JSKvPf4DkXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A5e9YoAYbwEA56NQzgC7w0lKjKQ9CCEmMe75zLdZmezD1nUG1gvs5au2gX54oF7x3qljmlRYDabbYsl3bzjksitybSynY5qtoqWc/RLXqvk1r2KifFIGjs/+Vq4b2Z+MzfRfpZpD8Cvguvo48gwwGGhMJ2FxZcOnDM7zOUQ/YQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nEKya0LQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NH87Jbac; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nEKya0LQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NH87Jbac"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C572B7A014F;
	Tue,  8 Jul 2025 13:01:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 13:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1751994114; x=1752080514; bh=cFcOEE0CyG9AGdCAyEWEe+70bjeiG3r+
	X4smHoiZEEY=; b=nEKya0LQ4pF3k7weFu6ibM/ltY5AeYWwrpjfvYKk9XImtZ8h
	bhz3PTfALfRXZrREozvsCtLJERb2lxl4LRR23qjT0a3Dq00NB7m1HOmv4pYJhBsA
	wf4oxXuBlr/dJxBLB6Go5EKQ1Y64fM0H2o5o7voPyUbM9cbceK+WtHGTU/OxmDka
	BDRULheN8lZ6/Zpoke1uLbMLVAWEjkm3PlmxyVZd0AXri8myAcIVHW097RJ1SA0T
	0eYOkgNSUsrpEp3uvOrwZCfCsspyJGXgzcVqtbfgjIW1Q+GGFVcpw8+XHZLyTL1R
	RNG2blM3gKnzWS+YJuvUH5GhCFJ0o4plfF9gSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751994114; x=
	1752080514; bh=cFcOEE0CyG9AGdCAyEWEe+70bjeiG3r+X4smHoiZEEY=; b=N
	H87JbacajlVK7c7+eIwPLCRe9PznQ54KIz3Vu4YHE0kN8HZBvDbodUNmEncx8UZQ
	3/lVXMSzi2UkcYDkORWAOgNG/0P2TdA9c7lupJRQSXHppAkuXKnH3JCEQm5U3hgj
	5Vy+7qcW61FVcVk4dp3IE62SWfWk3DFBEAUnkft1qpHgxdR4SRL+efZCmtm/TZEv
	zbaTTlNi7eKZ1suOpBoH2AZ2j+9mTT5gOy4IWWkA8C/v38vx8MVU1FevUgxSe3S+
	hgACeHeCHaKmEtmEUE8ADAo2rIJ7iyfKytJ9P48JbfDv6AGP36X1vyCVlld4lQrk
	rES/BFymU84kyzsMAZMJQ==
X-ME-Sender: <xms:Ak9taNnZVKTbRG1qXe8lzC5OzxeCLn6JCNmWM98lBCmIw5M2NJHJ5Q>
    <xme:Ak9taCTtJuMiyJP8orHco7yLzutWmSfpzWDjgbRXPSK5ty9K-4IUf8rcDE7OV1i9o
    fuSPyPOyM4doXagzw>
X-ME-Received: <xmr:Ak9taDOeZ9QESZtsClKqKVbg3gJ4x8mjm4XbkCELEjxnhQ2sI-NKGPKfhp9IlJFcrFkTMlYxBvnvnIaZF9Y36XKYLuyJvqjq-bRMYiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefhedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeugffhgeffjeekueffledvtefhgffgtdeigeegkeeikeeiuddtieejvefgkefhgeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgohhoghhlvghsohhurhgtvgdrtghomh
    dpohhrrdgtiidpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtqdhprggtkhgrghgvrhhs
    sehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:Ak9taDVBLyGShA9EAuq1X_PQx8KCgbN7gdbs4iY6hOU5N5XOJ0tqJQ>
    <xmx:Ak9taCdIvcOcdIGF1GNw2ygCHLUIyOFGO8pDZ0ux9X_UxwMWdvhx-Q>
    <xmx:Ak9taHtVcV9RqfmNOl_568rfLlfT-V2ikHMJ6gg2NPyJ66ycjsVBiQ>
    <xmx:Ak9taJ8RE3PhzLIrigdx_VOjxoG4TGdHnTBaWrbbmgDjvLId9pE97A>
    <xmx:Ak9taIEyboFZAD_D5AP1sfNuNR0Rcpi0iH2O0AUhkStj5BgTd98Wp6ST>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 13:01:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.50.1 and friends
Date: Tue, 08 Jul 2025 10:01:52 -0700
Message-ID: <xmqqzfdevcov.fsf@gitster.g>
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

