Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9B1C5D59
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713135; cv=none; b=q7QcOFxZE7m/pTWmrcL099zW8s21IvnVGVFYoLczrctg+5A2oFpAidA6qbVykdFv7C4lp2Z61bU2mM7Q4K4bfI4/i+JPE/xta7mGhj6/dCXJFM/kNv+ZxnxvcIxUC4vjV0ToorCjmm2/pNTh/XvslT19KWcyDcIOH6LZ5RDVOO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713135; c=relaxed/simple;
	bh=ZUrUWs2bBr4WRrHY1jOEnKRj2SNFZugbjqSKgTUfqsM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eYb24Cn0vX5SvO7PFsy1rm2eL3DzjPc5W8KNNWTWIwuRw2iOkj+f2Yr9rOpbxX7sboPGqOm9YUTtWepEAgt3D/GaZb2HG+PwPfyeB+sRAidku1N18RJeQF6X5EwP71WnT1573I8W6sEk84//ipnY49OXk5wiNBVRckZjY+25X+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=OsSz3RgB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="OsSz3RgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763713129; x=1764317929;
	i=johannes.schindelin@gmx.de;
	bh=b6vHWSZHoXtGCspBXpVOPnjMpy8E/3Q7Pvyc3b4Bt5A=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OsSz3RgBw17Ak1cGlS2Q2B7c80/UffIPtrY3aiu5iLjrilV1upENWlTKZ3G1/kfF
	 8jsY0wkw+wShjsNhmrvj5ZTCU2xOoXumFFNR2LQCQS4ZQcuhQwcUq3C5GVMMaQyJz
	 pTI/emzj0t7PTB42+ktlvgtmSzC1jzQqODA626nmZRzi1WLXF/wg3hAxVxuMSd6XW
	 Cpe4L0FQRjrBajknYD25EBdvZu5j4wCMHIXUUEcEf+zzujvAsT82q3RSiVZVQP6E4
	 InijLQR8mQa4HH3rufbZ6wpUleeYzHtl2RbCe5uINj1URcC9UYzDZgcYH5rJW/BbT
	 DNwJGOZH7SQTDGb4Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZktZ-1vbXgc33pf-00Qcea; Fri, 21
 Nov 2025 09:18:49 +0100
Date: Fri, 21 Nov 2025 09:18:47 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ezekiel Newren <ezekielnewren@gmail.com>
cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Karthik Nayak <karthik.188@gmail.com>, 
    Eric Sunshine <ericsunshine@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
    Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 6/6] rust: support for Windows
In-Reply-To: <CAH=ZcbB8cRgCTp-Q_CxJ4VFNY1+w+C20zgx9bMre4-hNmPrD7g@mail.gmail.com>
Message-ID: <dc753c0e-eb93-948c-55f7-bb0e91772c83@gmx.de>
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im> <20251015-b4-pks-ci-rust-v3-6-13810af33bd5@pks.im> <CAH=ZcbB8cRgCTp-Q_CxJ4VFNY1+w+C20zgx9bMre4-hNmPrD7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Y5LvtGqVxcBjT4x5vvQod/Gf9y0SQYiHRXSzTrqAZ85r9bWbfsq
 i/nlrlwCgB69eq0B9hCEsFT7OXzMrMsiigxVBuJbo7xZYwDpll2rXKtWaJmwBgTkwRHuNO/
 tVMs6uaKMJqx3CKYzj7ccHB+uZST3vXl31IgVr16gbRoUhQW2i5nT54exiFUvPUWwNvzc5u
 S8I26tuLMtJMAn8gDVBUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZyseL/PjxbM=;qcwX+0sY9uo6d4UYWarIKSoGQDF
 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
Content-Transfer-Encoding: quoted-printable

Hi Ezekiel,

On Thu, 20 Nov 2025, Ezekiel Newren wrote:

> This is a retrospective review. I completely missed this patch series,
> and only noticed its existence after it was merged into master. The
> core problem is that these changes assume that windows builds only
> ever use the MSVC compiler, but that's not true.

Correct. I had actually worked on a solution to this in Git for Windows,
but due to time constraints (after factoring in the usual time tax, other
priorities dictated that I wouldn't have time to see it through) I hadn't
had time to contribute it, let alone engage in reviewing Patrick's patches
(I had actually not even seen them until I had written the patch and
verified that it fixed the issue).

Here is my patch (with proper handling of MSVC, but obviously it no longer
applies without conflicts):
https://github.com/git-for-windows/git/commit/0949ff2ad5d1d085b10c63029c65=
293416732851

=2D- snipsnap --
=46rom 0949ff2ad5d1d085b10c63029c65293416732851 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 24 Oct 2025 14:49:22 +0200
Subject: [PATCH] meson(cargo): support Windows again

For over a year, Git has been moved to a more modern build system than
it had before (GNU make, or on Windows optionally CMake). Naturally,
this new system breaks Windows support left and right.

For example, c184795fc0e (meson: add infrastructure to build internal
Rust library, 2025-10-02) added support for building a Rust library, and
it fails when Visual C is configured as compiler.

This is the reason that the `win+Meson` job of Git's `master` branch
fails for the past 16 days, i.e. the latest 9 pushes of the `master`
branch as of time of writing. The symptom is:

  [697/905] Generating src/git_rs with a custom command
  FAILED: [code=3D1] src/libgitcore.a "C:\Program Files\Git\bin\sh.exe" "D=
:/a/git/git/src/cargo-meson.sh" "D:/a/git/git" "D:/a/git/git/build/src" "-=
-release"
  cp: cannot stat 'D:/a/git/git/build/src/release/libgitcore.a': No such f=
ile or directory

The reason is that Visual C's output is called `gitcore.lib`, not
`libgitcore.a`. Let's special-case Visual C and use the correct filename
in all cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 src/cargo-meson.sh |  7 +++++--
 src/meson.build    | 10 +++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 99400986d93..c14a08c592d 100755
=2D-- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -5,6 +5,9 @@ then
 	exit 1
 fi
=20
+target=3D"$1"
+shift
+
 SOURCE_DIR=3D"$1"
 BUILD_DIR=3D"$2"
 BUILD_TYPE=3Ddebug
@@ -26,7 +29,7 @@ then
 	exit $RET
 fi
=20
-if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a" =
>/dev/null 2>&1
+if ! cmp "$BUILD_DIR/$BUILD_TYPE/$target" "$BUILD_DIR/$target" >/dev/null=
 2>&1
 then
-	cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"
+	cp "$BUILD_DIR/$BUILD_TYPE/$target" "$BUILD_DIR/$target"
 fi
diff --git a/src/meson.build b/src/meson.build
index 25b9ad5a147..b2473c46994 100644
=2D-- a/src/meson.build
+++ b/src/meson.build
@@ -3,6 +3,13 @@ libgit_rs_sources =3D [
   'varint.rs',
 ]
=20
+# The exact file name depends on the compiler
+if meson.get_compiler('c').get_id() =3D=3D 'msvc'
+  target =3D 'gitcore.lib'
+else
+  target =3D 'libgitcore.a'
+endif
+
 # Unfortunately we must use a wrapper command to move the output file int=
o the
 # current build directory. This can fixed once `cargo build --artifact-di=
r`
 # stabilizes. See https://github.com/rust-lang/cargo/issues/6790 for that
@@ -10,6 +17,7 @@ libgit_rs_sources =3D [
 cargo_command =3D [
   shell,
   meson.current_source_dir() / 'cargo-meson.sh',
+  target,
   meson.project_source_root(),
   meson.current_build_dir(),
 ]
@@ -21,7 +29,7 @@ libgit_rs =3D custom_target('git_rs',
   input: libgit_rs_sources + [
     meson.project_source_root() / 'Cargo.toml',
   ],
-  output: 'libgitcore.a',
+  output: target,
   command: cargo_command,
 )
 libgit_dependencies +=3D declare_dependency(link_with: libgit_rs)
=2D-=20
2.51.1.windows.1

