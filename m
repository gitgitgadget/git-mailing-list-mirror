Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B51BB6BC
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248256; cv=none; b=rQ7idmzjXD6hkw/VUX60irLUV2ieodnfyt54v/G76pVAeBVZTsHf5sVjzLCBh2tvBE2rv7CUovAl9U7+s1Cy9cfo6nXZz6Uzenij+KK4xiDM2iJWqxxbGc+U38YxqhPTv4V8UxcK0GNm07Bso0aWq1D36ZWkzdImMV3yM4/BIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248256; c=relaxed/simple;
	bh=CP3z5fyItMwmNxLcCmGnkVWXeKZ4wImz2Hhsd6i5u9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ta3+Ecy/LjBVs2cCiNLWDZ+7f7K6dYlU/N0TZxtYTjknoXqGBEW7shY2yQytm7r7Jc0kFaYJoOB/+E/8odgViDlMCUhplaq503nxWDR/0QHMVhLI0LMzv7F8TABvGZjjGU1XKKIygUAncwMHqzFwvbfSMnI3d7iGg6e9TCb3eZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BFNLjYoV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTo5JWGa; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BFNLjYoV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTo5JWGa"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1621C114010D;
	Thu, 30 Jan 2025 09:44:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jan 2025 09:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248252;
	 x=1738334652; bh=l0EXULyVDXfhpQ3Px51z8P4RwpCCqv1hLYLhHqa0jz8=; b=
	BFNLjYoVXp002+78W65z3MlFEZ0exysxwNjknvaTjXHA9LhDtDnDfds/wg0j0/Ka
	7VKD7EnKc6wgbZHNBtAFpQHXil+SB5mhUd2H0CvHCZ9KFbNhg6L36KnPenzJE1KL
	YSOY1+MQSjGCOdTw6wNn9W/WF1NQ4xdefh7VkxlCiukfMyoqhwou7/76Z8EhE0Kl
	YGh4pD9Ni9FtZDxZnoCKrcKSlWlYNURruOW66qKJB0Pa0t54FAXqc/Moy0ukiJky
	YaTRGt33bDn6OgEPg0j4B7KSuwB9cPovGkVbKHY9hY777X/WUowaAhNQJCx3H1cl
	fXBIa94Tzk9WDDZLEx2uPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248252; x=
	1738334652; bh=l0EXULyVDXfhpQ3Px51z8P4RwpCCqv1hLYLhHqa0jz8=; b=D
	To5JWGaC/mZO3VI6EKWWWwRpGof2Oqzv99k0S2kx2YZ0PltrJz7ez0J03s+Bn3Pi
	gMPxjSPYDVmvCdpfWA3nrygMglFBQRNKzWkLMx6alALUBQ2ESUt1JhG7Uqt+lwNs
	+dj+2hn9sr2ugHQqnxdyrENmSlMHDJT1ag2dCUTPNfOU2gbKDISHWL//IQ1lk7m3
	mljOtbuMqBghJ6ZDd3N8NPXMOJmTWR6PeXS/upy+D46aog0EMzINQ/cFJDrkXHOc
	iA9XyOq/IwiqUKQ60OQghsJhnZAQqY7OSDy8RzoKc53USFpiNknSE32f+TX5hcsW
	gLs7XzjZEGE8/oy82TcLA==
X-ME-Sender: <xms:O5CbZ6Qk9FwiXc9SBTxVqAKz6NcLxeeFRVgXmgiCjR28vuQjC1w1xQ>
    <xme:O5CbZ_wNBTQvsMAMtv3B0Lpmxu5NdILy2Cjg6wUug0CYVRNHvbzjVj8NpA8iQiDmo
    iZ5HJhbL9phsJzyZA>
X-ME-Received: <xmr:O5CbZ320ZxQ8GDIev9g1GSJfrTaUfgYCdAxKMzuAYbusFdU5Qy7J4WkjaxX2wdFjr4PRmzsNlHmsC6FlLSct6hdPLyCCiw9McG5Ip2FabEZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O5CbZ2CTb-rXDKVslqFHP590NAF6cs2LY4K8KyLVAG8XZWw9CmjzlA>
    <xmx:O5CbZzjErWhEbA-PWTSgu0umit7AammXhO2acEDTr_4lu1w8Zaq4NA>
    <xmx:O5CbZyp4zaTacPnvH2PDvlxQzUuyNNh8N1QvGWzYTGksGLyNG3yh9w>
    <xmx:O5CbZ2h3x2qBLq1TJBPRjtJUhBXlyFg8cywwv6bL7ByI3suwjPi1RQ>
    <xmx:PJCbZ2sgKEwY0amrlmilq1NGVpM-2alXcRtTE2809z4z-mybdGbJScVj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e76fe7c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] meson: cleanups, improvements, smallish fixes
Date: Thu, 30 Jan 2025 15:43:52 +0100
Message-Id: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiQm2cC/32NwQrCMBBEf6Xs2ZUktZZ68j+khyZu7SJJSrYEp
 fTfjQWvHt8w82YFocQkcKlWSJRZOIYC5lCBm4bwIOR7YTDKNEobjfaE81PQk8SA7OcUM3kKi2B
 NTdvU55o67aDs50Qjv3b3rS88sSwxvferrL/pz9r9sWaNCgfbqm5UlrRx11I8sod+27YPN3yIW
 78AAAA=
X-Change-ID: 20250121-b4-pks-meson-improvements-3e575363e91c
In-Reply-To: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
References: <20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series contains a mostly-random set of smallish improvements,
simplifications and fixes to the Meson build instructions.

Changes in v2:
  - Redo the two commits regarding PATH handling. We now only prepend
    system-specific paths to PATH and handle the `-Dsane_tool_path`
    option the same.
  - Continue to propagate libcurl include directories into libgit, as we
    need it for "help.c" to resolve LIBCURL_VERSION. Reorder the patch
    to minimize the required changes.
  - Fix a commit message typo.
  - Include another commit that fixes the OpenSSL fallback on Windows.
  - Include another commit to fix linker errors due to out-of-memory
    situations on Windows with GitLab CI.
  - Link to v1: https://lore.kernel.org/r/20250129-b4-pks-meson-improvements-v1-0-ab709f0be12c@pks.im

I have furthermore pulled in ps/build-meson-fixes at 7304bd2bc3 (ci:
wire up Visual Studio build with Meson, 2025-01-22) as a dependency of
this series. This is due to a semantic conflict with 28911f7dca (meson:
wire up fuzzers, 2025-01-22).

Thanks!

Patrick

---
Patrick Steinhardt (13):
      meson: fix exec path with enabled runtime prefix
      meson: fix OpenSSL fallback when not explicitly required
      meson: inline the static 'git' library
      meson: simplify use of the common-main library
      meson: introduce `libgit_curl` dependency
      meson: stop linking libcurl into all executables
      meson: drop separate version library
      meson: improve PATH handling
      meson: improve handling of `sane_tool_path` option
      meson: prevent finding sed(1) in a loop
      meson: fix overwritten `git` variable
      meson: consistently use custom program paths to resolve programs
      gitlab-ci: restrict maximum number of link jobs on Windows

 .gitlab-ci.yml                  |   2 +-
 Documentation/howto/meson.build |   2 +-
 Documentation/meson.build       |  13 ++--
 meson.build                     | 151 +++++++++++++++++++---------------------
 meson_options.txt               |   4 +-
 oss-fuzz/meson.build            |   2 +-
 t/helper/meson.build            |   4 +-
 t/meson.build                   |   4 +-
 8 files changed, 85 insertions(+), 97 deletions(-)

Range-diff versus v1:

 1:  a4f1eb695a !  1:  932d79a814 meson: fix exec path with enabled runtime prefix
    @@ Commit message
     
         One of these paths, GIT_EXEC_PATH, is expected to be absolute when
         runtime prefixes are enabled, but relative otherwise. And while our
    -    Makefile gets this correcty, in Meson we always wire up the absolute
    +    Makefile gets this correctly, in Meson we always wire up the absolute
         path, which may result in us not being able to find binaries.
     
         Fix this by conditionally injecting the paths depending on whether or
 -:  ---------- >  2:  6bd07f35a6 meson: fix OpenSSL fallback when not explicitly required
 2:  da61c2a679 =  3:  94f9e45c56 meson: inline the static 'git' library
 3:  744754959e !  4:  669c811eb6 meson: simplify use of the common-main library
    @@ meson.build: test_dependencies += executable('git-imap-send',
      
        install_symlink(alias + executable_suffix,
     
    + ## oss-fuzz/meson.build ##
    +@@ oss-fuzz/meson.build: foreach fuzz_program : fuzz_programs
    +       'dummy-cmd-main.c',
    +       fuzz_program,
    +     ],
    +-    dependencies: [libgit, common_main],
    ++    dependencies: [libgit_commonmain],
    +   )
    + endforeach
    +
      ## t/helper/meson.build ##
     @@ t/helper/meson.build: test_tool_sources = [
      
 4:  172d3e07a5 <  -:  ---------- meson: stop linking libcurl into all executables
 5:  a0a1e548cc !  5:  edb9fba4b3 meson: introduce `libgit_curl` dependency
    @@ Commit message
         Simplify it by declaring a `libgit_curl` dependency that bundles all of
         it together.
     
    +    Note that we don't include curl itself as a dependency. This is because
    +    we already pull it in transitively via the libgit dependency, which is
    +    unfortunate because libgit itself shouldn't actually link against curl
    +    in the first place. This will get fixed in the next commit.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## meson.build ##
    @@ meson.build: bin_wrappers += executable('scalar',
     +      'http.c',
     +      'http-walker.c',
     +    ],
    -     dependencies: [libgit_commonmain, curl],
    +     dependencies: [libgit_commonmain],
     +  )
     +
     +  test_dependencies += executable('git-remote-http',
     +    sources: 'remote-curl.c',
    -+    dependencies: libgit_curl,
    ++    dependencies: [libgit_curl],
          install: true,
          install_dir: get_option('libexecdir') / 'git-core',
        )
    @@ meson.build: bin_wrappers += executable('scalar',
      
        test_dependencies += executable('git-http-fetch',
     -    sources: curl_sources + 'http-fetch.c',
    --    dependencies: [libgit_commonmain, curl],
    +-    dependencies: [libgit_commonmain],
     +    sources: 'http-fetch.c',
    -+    dependencies: libgit_curl,
    ++    dependencies: [libgit_curl],
          install: true,
          install_dir: get_option('libexecdir') / 'git-core',
        )
    @@ meson.build: bin_wrappers += executable('scalar',
        if expat.found()
          test_dependencies += executable('git-http-push',
     -      sources: curl_sources + 'http-push.c',
    --      dependencies: [libgit_commonmain, curl],
    +-      dependencies: [libgit_commonmain],
     +      sources: 'http-push.c',
    -+      dependencies: libgit_curl,
    ++      dependencies: [libgit_curl],
            install: true,
            install_dir: get_option('libexecdir') / 'git-core',
          )
    @@ meson.build: if get_option('curl').enabled()
        foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
          test_dependencies += executable(alias,
     -      objects: git_remote_http.extract_all_objects(recursive: false),
    --      dependencies: [libgit, curl],
    +-      dependencies: [libgit],
     +      sources: 'remote-curl.c',
    -+      dependencies: libgit_curl,
    ++      dependencies: [libgit_curl],
          )
      
          install_symlink(alias + executable_suffix,
    @@ meson.build: if get_option('curl').enabled()
      endif
      
     -imap_send_sources = ['imap-send.c']
    --imap_send_dependencies = [libgit_commonmain]
     -if use_curl_for_imap_send
     -  imap_send_sources += curl_sources
    --  imap_send_dependencies += curl
     -endif
     -
      test_dependencies += executable('git-imap-send',
     -  sources: imap_send_sources,
    --  dependencies: imap_send_dependencies,
    +-  dependencies: [libgit_commonmain],
     +  sources: 'imap-send.c',
    -+  dependencies: use_curl_for_imap_send ? [libgit_curl] : [libgit_commonmain],
    ++  dependencies: [ use_curl_for_imap_send ? libgit_curl : libgit_commonmain ],
        install: true,
        install_dir: get_option('libexecdir') / 'git-core',
      )
 -:  ---------- >  6:  95ceafc2f4 meson: stop linking libcurl into all executables
 6:  ab55efa559 =  7:  65d00e36b8 meson: drop separate version library
 7:  7226cd6388 <  -:  ---------- meson: deduplicate the list of required programs
 8:  55a372a559 <  -:  ---------- meson: simplify setup of PATH environment variable
 -:  ---------- >  8:  3dc35872a3 meson: improve PATH handling
 -:  ---------- >  9:  e996dc571c meson: improve handling of `sane_tool_path` option
 9:  2abab952c0 ! 10:  2730e0166b meson: prevent finding sed(1) in a loop
    @@ Documentation/howto/meson.build: custom_target(
            '-e',
            '1,/^$/d',
            '@INPUT@',
    +
    + ## meson.build ##
    +@@ meson.build: endif
    + cygpath = find_program('cygpath', dirs: program_path, required: false)
    + diff = find_program('diff', dirs: program_path)
    + git = find_program('git', dirs: program_path, required: false)
    ++sed = find_program('sed', dirs: program_path)
    + shell = find_program('sh', dirs: program_path)
    + tar = find_program('tar', dirs: program_path)
    + 
    + # Sanity-check that programs required for the build exist.
    +-foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
    ++foreach tool : ['cat', 'cut', 'grep', 'sort', 'tr', 'uname']
    +   find_program(tool, dirs: program_path)
    + endforeach
    + 
10:  a36529b4dd = 11:  9a54f2c2b7 meson: fix overwritten `git` variable
11:  2c60ae4349 = 12:  4604460ba2 meson: consistently use custom program paths to resolve programs
 -:  ---------- > 13:  9a6fd5435d gitlab-ci: restrict maximum number of link jobs on Windows

---
base-commit: 6dd4e543f2219290db9faa61b30f7f30a34e4b50
change-id: 20250121-b4-pks-meson-improvements-3e575363e91c

