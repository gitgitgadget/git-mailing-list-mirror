Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F014025484D
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518568; cv=none; b=fd5smmbbwEyWPze9l0Y1Cr+ufg9W78VlLTqnvcwuBQ4Tx1YG0dpZSRbR1rCtlPi/KKnMiEhQW7UkFiO0bl5PFsd7xJd9FINYKvwRh6O6roy6mJ5MHnL4gPtNLxjeF2hZq3uajkqXAimD/PHsnpyljrZkbnYWCRz+dEZC+Kppl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518568; c=relaxed/simple;
	bh=XnkLk9QmzdjyH3eF2gwhPNYYi2S9EP0kVxG853wkKRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUqIgz3/boJDMRwLKp/XqDUkAVfqtTTVU5qr9uGRIHeDaV4qsP1fysDTIKcZttRE9MpFrPVztN8O277YvQkTM7U6godTSswy35pRjCwuMdVMSS08dWX1CA81VhHV3ZexqoTW/ws6CR8X4IXHtGN7vhir4oUtpG8yHzOzrM6+NQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tA2Ls3XO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lE+gyXr+; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tA2Ls3XO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lE+gyXr+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1DD01EC044C;
	Wed, 10 Sep 2025 11:36:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 11:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757518564;
	 x=1757604964; bh=gmnGtabFFPs5V218lhkNs7afhRKHr3b9jeRLhL7blQc=; b=
	tA2Ls3XOTRevKNri5ZvVZwY794Fmzh186zOObyrgU7XUHUEDsTEaeHtehcocg8sm
	raq5+9YS/7SdBgiVZ2ezgjHiBc6tnkdRcvbmPx/LrBeH+fXncjBMNVA8kuUb+SqJ
	IoQv3mLPXtr1emmsx3MXiFEJRxRmLAO5IiZdCEOlbjioUPVTr44t/M2Bn/H6kO31
	Gw1xpwCNUqkKNybhbtvDszNJKmefSQFOXPs2o23vCIxS4RbOgOETTM+ELw8bf6gv
	ggixMm3sO34NFVPMGqz8F/oB44vVA0xVprBeWQQYLyTcE0OhEC+uRtIND95z17zP
	MDTUtdqa4oYtDlN1Fb2nQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757518564; x=
	1757604964; bh=gmnGtabFFPs5V218lhkNs7afhRKHr3b9jeRLhL7blQc=; b=l
	E+gyXr+W12qampK66D22ETk+CQGrho6XtRLG3jCLavc4hjD9kdqbmgVUxzhKce0Q
	ae1USGaP+qvWCayDKhsGBuAFXbTh4rbYng8THM02UfVxag1N1TJ8D1Alc8fu/Spd
	F3ovtWHcmVmneb1H06F1tlkd9x6PwnLqAG3hYAnlhWOS4ZWNnFE27+8ne1wgwCaW
	Wo0guPMV7WRc16NYYrI3sNvWRdCtp+8F2zlxoAhft2R7RiWqOrXC3JIpdgb19UmR
	Uh+14i3nxclbcXqEXIOkpai4qrH8/5MkiCah8obupweW8iaKieo7aIDs5Weca17a
	adDnuswxZJgadtEzniCTA==
X-ME-Sender: <xms:45rBaDOs2hjkc3_jngzPlVY4K-atiTaWN2iXxjE9FBnqNyqCkp2XTg>
    <xme:45rBaOG0kEe770l3SyY6Q7tc0qcdjKiIgLejxdnCm-Z1A7RhS_hvBQj0qW65a1Cg6
    RoBi4TCLjT0R6FPtA>
X-ME-Received: <xmr:45rBaJs-wN9_bRbwem1pb2CIiRAtGquqQgR2HJWM-y8ZHAjC3_t6sxvudnIRGLrNO2xHMCwa8I49QXrZoUXt7CWew_XGuG7A9eyRnI9XVzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epfefgvedtvedufedutedugffhjefgleegheehffelgfegffehieegvdfgfeehuefgnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepnhgvfihrvghnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghonhhtrggttheshhgrtghkthhivhhishdrmh
    gvpdhrtghpthhtohepphhivghrrhgvqdgvmhhmrghnuhgvlhdrphgrthhrhiesvghmsggv
    tghoshhmrdgtohhm
X-ME-Proxy: <xmx:45rBaOSJxMpQMs-hCLcGlsKT-Sk7tYpaNVswCuNTmz87ee1NLGaAKA>
    <xmx:45rBaDOyKNsY1xp3EYzgGdd0UjGX76BORry7046MJZj9nhhpzSNYww>
    <xmx:45rBaM62nPW1B5XbuhsBUsx4-lfwOfrWlegCTCsB_csNw9OBCyiHow>
    <xmx:45rBaOVcib2sxzEHOJyHAchm_8M2G-vE2u1Stmu07RZLDwDzKZV6pg>
    <xmx:5JrBaM_p7G8Ap_qJwxliIAT-cw5qJieFNS7Yll60e1OQdr2L3odZnlfN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 11:36:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a3e3bd8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 15:35:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Sep 2025 17:35:47 +0200
Subject: [PATCH RFC v4 1/9] meson: add infrastructure to build internal
 Rust library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-b4-pks-rust-breaking-change-v4-1-4a63fc69278d@pks.im>
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
To: git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>, 
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Add the infrastructure into Meson to build an internal Rust library.
Building the Rust parts of Git are for now entirely optional, as they
are mostly intended as a test balloon for both Git developers, but also
for distributors of Git. So for now, they may contain:

  - New features that are not mission critical to Git and that users can
    easily live without.

  - Alternative implementations of small subsystems.

If these test balloons are successful, we will eventually make Rust a
mandatory dependency for our build process in Git 3.0.

The availability of a Rust toolchain will be auto-detected by Meson at
setup time. This behaviour can be tweaked via the `-Drust=` feature
toggle.

Next to the linkable Rust library, also wire up tests that can be
executed via `meson test`. This allows us to use the native unit testing
capabilities of Rust.

Note that the Rust edition is currently set to 2018. This edition is
supported by Rust 1.49, which is the target for the upcoming gcc-rs
backend. For now we don't use any features of Rust that would require a
newer version, so settling on this old version makes sense so that
gcc-rs may become an alternative backend for compiling Git. If we _do_
want to introduce features that were added in more recent editions of
Rust though we should reevaluate that choice.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Cargo.toml         |  9 +++++++++
 meson.build        | 10 +++++++++-
 meson_options.txt  |  2 ++
 src/cargo-meson.sh | 32 ++++++++++++++++++++++++++++++++
 src/lib.rs         |  0
 src/meson.build    | 40 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/Cargo.toml b/Cargo.toml
new file mode 100644
index 00000000000..b9a41dbc792
--- /dev/null
+++ b/Cargo.toml
@@ -0,0 +1,9 @@
+[package]
+name = "git"
+version = "0.1.0"
+edition = "2018"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
diff --git a/meson.build b/meson.build
index e8ec0eca165..234a9e9d6fd 100644
--- a/meson.build
+++ b/meson.build
@@ -220,7 +220,7 @@ project('git', 'c',
   # learned to define __STDC_VERSION__ with C11 and later. We thus require
   # GNU C99 and fall back to C11. Meson only learned to handle the fallback
   # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
-  default_options: meson.version().version_compare('>=1.3.0') ? ['c_std=gnu99,c11'] : ['c_std=gnu99'],
+  default_options: meson.version().version_compare('>=1.3.0') ? ['rust_std=2018', 'c_std=gnu99,c11'] : ['rust_std=2018', 'c_std=gnu99'],
 )
 
 fs = import('fs')
@@ -1702,6 +1702,13 @@ version_def_h = custom_target(
 )
 libgit_sources += version_def_h
 
+cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
+rust_option = get_option('rust').disable_auto_if(not cargo.found())
+if rust_option.allowed()
+  subdir('src')
+  libgit_c_args += '-DWITH_RUST'
+endif
+
 libgit = declare_dependency(
   link_with: static_library('git',
     sources: libgit_sources,
@@ -2239,6 +2246,7 @@ summary({
   'pcre2': pcre2,
   'perl': perl_features_enabled,
   'python': target_python.found(),
+  'rust': rust_option.allowed(),
 }, section: 'Auto-detected features', bool_yn: true)
 
 summary({
diff --git a/meson_options.txt b/meson_options.txt
index 1668f260a18..143dee9237c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -71,6 +71,8 @@ option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], valu
 # Build tweaks.
 option('breaking_changes', type: 'boolean', value: false,
   description: 'Enable upcoming breaking changes.')
+option('rust', type: 'feature', value: 'auto',
+  description: 'Enable building with Rust.')
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,
   description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
 
diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
new file mode 100755
index 00000000000..f29745beb36
--- /dev/null
+++ b/src/cargo-meson.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	exit 1
+fi
+
+SOURCE_DIR="$1"
+BUILD_DIR="$2"
+BUILD_TYPE=debug
+
+shift 2
+
+for arg
+do
+	case "$arg" in
+	--release)
+		BUILD_TYPE=release;;
+	esac
+done
+
+cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
+RET=$?
+if test $RET -ne 0
+then
+	exit $RET
+fi
+
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a" >/dev/null 2>&1
+then
+	cp "$BUILD_DIR/$BUILD_TYPE/libgit.a" "$BUILD_DIR/libgit.a"
+fi
diff --git a/src/lib.rs b/src/lib.rs
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/src/meson.build b/src/meson.build
new file mode 100644
index 00000000000..734de0b4fa9
--- /dev/null
+++ b/src/meson.build
@@ -0,0 +1,40 @@
+libgit_rs_sources = [
+  'lib.rs',
+]
+
+# Unfortunately we must use a wrapper command to move the output file into the
+# current build directory. This can fixed once `cargo build --artifact-dir`
+# stabilizes. See https://github.com/rust-lang/cargo/issues/6790 for that
+# effort.
+cargo_command = [
+  shell,
+  meson.current_source_dir() / 'cargo-meson.sh',
+  meson.project_source_root(),
+  meson.current_build_dir(),
+]
+if get_option('buildtype') == 'release'
+  cargo_command += '--release'
+endif
+
+libgit_rs = custom_target('git_rs',
+  input: libgit_rs_sources + [
+    meson.project_source_root() / 'Cargo.toml',
+  ],
+  output: 'libgit.a',
+  command: cargo_command,
+)
+libgit_dependencies += declare_dependency(link_with: libgit_rs)
+
+if get_option('tests')
+  test('rust', cargo,
+    args: [
+      'test',
+      '--manifest-path',
+      meson.project_source_root() / 'Cargo.toml',
+      '--target-dir',
+      meson.current_build_dir() / 'target',
+    ],
+    timeout: 0,
+    protocol: 'rust',
+  )
+endif

-- 
2.51.0.450.g87641ccf93.dirty

