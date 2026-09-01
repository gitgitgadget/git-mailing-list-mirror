Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3038E8CC
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272516; cv=none; b=okkNXYErGVEssUEKfhSqKdwc9EVOHjBZRQG9zIlIqmLE8Bx/ITv4gJHB67cWsiJE74N9snyPl33lN2eR7EXSrq2dxX9fOwbIcPi1GR5/k87+QgjxCeqVVP8iRoo2I9vUsIqdLyVpIUeTIVc0hGtVZ/DOEtaEuyoOtAFN9nsq96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272516; c=relaxed/simple;
	bh=VhPiiQPBt4bV2IVLYGykO0jLIN73YCj+uY3Qrz10mbs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DiGknijatFj45Ywey95A7xwotiuxrbs00YZ4c0ifLqEYzyR5N1RNoWkuO+5O3ka4sgDhidkS/pKvt98vW8LErwdK3gqxmrkZOTXNhjItubpyActHO/cS/RsXQn/pKRxFB2VAcs5yCVVoRtBps4VG4lGOdjNh0iHcOzgJMzJlnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQrbE1iz; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQrbE1iz"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936623c6dd3so114082785a.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 07:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272514; x=1788877314; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=erFLYHvYkJXXp1Iz+TexscG3VUIqDMEbI92tjpQ88HE=;
        b=HQrbE1izUeQi6ExNneLjKBqdZpziDbZR+HLJKwvjOGRs5UeW6meXgJseo+gDUovbaX
         cT6CQY25Wwm9aaQqWxaNXvBzFK+P02ymm7vc8d1g2RTT9JNETF6yTqRPkpI/3M+bEiQS
         z/5uZ99pxzMP6e6evLWhGYMIdNi9D1JZKrgbMfyrGiZo+FOWsp0JgtV84KWKYHJvk/7a
         K6c6cVLzBHfhyqB6I3NqVPLBx1vGrrUJU1GPINhioYdayLBb7vWwDWJdcObemSq9aNWi
         +u1WK7hdz2PR3LzNuXqgBo7uJ+kXG7QVs6Vb9eBMkuBhyWv0A09i9OhbJ5O/334kJRCA
         KEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272514; x=1788877314;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=erFLYHvYkJXXp1Iz+TexscG3VUIqDMEbI92tjpQ88HE=;
        b=ewF9XnDxbLiq268GAEJniCplpSZFmVjQqQmtA/5E9yAFD4GlTL/+kvaTQ+OR+EAEoW
         fNf/f+6rxu04xSjzydWxUAZEsX/8oN4CcTze32MhXpLQ181l94DmiVtmzsDZok9zFHO5
         /tJ9bzYYoRoDmqKxFXJBw/MIM1/uK6WnHaPRaVhYUrFubZShA4wVNuqvO0cj3/o8x4lb
         awUIeZjEjJAe0LjHHUyErpoNh1tcaAuEg4u9YtpSAHy0MR6/tDWqV4mUPTRzkJhwpr3l
         ttYRArJb9rZDJgUodrjBZNmuMaWOV5fVtRN3lv8aMp4R1t5vKtjuQbeBBMkcx5BYfK0T
         YMog==
X-Gm-Message-State: AFuF++lRNlApR6fINLRK77d611RBk5QTZcFZi+CegkzKYc9xj39x0oVY
	gqkz98XzzNmf/+kbtqGoBGsJ/YJxWJ5IVF9dxQeUPnGIr5hdpEYTBJJgWXOPdUTY
X-Gm-Gg: AR+sD1089y76Ve1aolrQrLS82kpiyvt1QNc0m1s5Lbjbm9mDo7TGJ7bC4IByL73+6ga
	cq5TVSiZ2umNcb5D3nRk/qsMngBRvzRbSSU1uj9orBuHypsIIZM9KVHc4sVesYenKZXbX32hbAp
	VG37dPRB/rcgwehPiTa3RCBKhjmDgf6wUisYtqvYUGiBH8DWtk0ssmjef6sgUBEf5EwY04WcQ21
	eiGGRJDeyWg+i9RRHRkZpfrn8YzvGZWaMZmu4nyPYIU1h1w8orAO98eXmKB/AnIQvmJ3/1ELMQl
	QMwrauiE41VK/N5OJcqQ0e3YsBI/W0biOxrRZ1gz971O8IyyV1slAuxr3lmkkzCvIt/v2vTxjyP
	zeUbpeqPin8Zo9Ix4i2vL4nvVvt5VIO5Lawgi/Vc4WIceAMX4O+dDugf0WChtQTm0dIxbbELD0w
	sLY+mGLgev2bn9hfH+s3JgES34hRE5jKpjMnSlELj/vGqO9aDB8k6wW2oJ8ro22WX6
X-Received: by 2002:a05:620a:5687:b0:939:4baf:5b99 with SMTP id af79cd13be357-9394bce9476mr609544585a.18.1788272513521;
        Tue, 01 Sep 2026 07:21:53 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.218.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9393adc1dcdsm485058785a.36.2026.09.01.07.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:21:52 -0700 (PDT)
Message-Id: <2b7f58a037592325c2cb9b52bf8f1ef434bd6202.1788272509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 14:21:48 +0000
Subject: [PATCH 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git is built under MSYS2/MinGW with Rust support enabled, the
Makefile expects `cargo build` to drop a `target/release/libgitcore.a`
that is linkable by the same MinGW GCC used for every other object.
With Rust installed via `rustup` (the way it ships on the
GitHub-hosted `windows-2022` and `windows-11-arm` runners that build
microsoft/git), the default toolchain targets the MSVC ABI; cargo
then writes `target/release/gitcore.lib` instead, which the MinGW
`ld.exe` cannot consume:

    LINK git-shell.exe
    D:\git-sdk-64-minimal\mingw64\bin/ld.exe: cannot find target/release/libgitcore.a: No such file or directory
    collect2.exe: error: ld returned 1 exit status

See https://github.com/microsoft/git/actions/runs/27341625000 for the
full log.

Let's define the correct target. Re-use (and fix) the existing
`HOST_CPU` variable for that purpose. Avoid relying on environment
variables that are simply not defined in Git for Windows' minimal SDK
that Git uses in its CI runs.

Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile         |  3 ++-
 config.mak.uname | 24 +++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fac3e8879c..bf2a11c08a 100644
--- a/Makefile
+++ b/Makefile
@@ -959,7 +959,7 @@ RUST_LIB_NAME = gitcore.lib
 else
 RUST_LIB_NAME = libgitcore.a
 endif
-RUST_LIB = target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
+RUST_LIB = target$(if $(CARGO_TARGET),/$(CARGO_TARGET))/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
 endif
 
 GITLIBS = common-main.o $(LIB_FILE)
@@ -993,6 +993,7 @@ endif
 ifndef DEBUG
 CARGO_ARGS += --release
 endif
+CARGO_ARGS += $(if $(CARGO_TARGET),--target $(CARGO_TARGET))
 
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
diff --git a/config.mak.uname b/config.mak.uname
index 0b63be10b7..720d9ba3ed 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -758,7 +758,29 @@ ifeq ($(uname_S),MINGW)
 			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
                 endif
 		prefix = $(MINGW_PREFIX)
-		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
+
+		# A rustup-managed Rust on Windows defaults to the MSVC ABI and
+		# produces a `gitcore.lib` that the MinGW `ld.exe` cannot link.
+		# Pick a GCC-compatible Rust target triple matching the MSYS2
+		# subsystem instead: `*-pc-windows-gnullvm` for the Clang/LLVM
+		# subsystems (which on Windows is also the only choice for
+		# ARM64, where no MinGW-GCC port exists) and `*-pc-windows-gnu`
+		# for the MSVCRT-based MinGW subsystems. For a `staticlib`
+		# crate-type Cargo does not invoke an external linker, so
+		# `rustup target add <triple>` is sufficient.
+                ifneq (,$(filter %ARM64, $(MSYSTEM)))
+			HOST_CPU = aarch64
+                else ifneq (,$(filter %32, $(MSYSTEM)))
+			HOST_CPU = i686
+                else
+			HOST_CPU = x86_64
+                endif
+                ifneq (,$(filter CLANG%, $(MSYSTEM)))
+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnullvm
+                else
+			CARGO_TARGET = $(HOST_CPU)-pc-windows-gnu
+                endif
+
 		BASIC_LDFLAGS += -Wl,--pic-executable
 		COMPAT_CFLAGS += -DDETECT_MSYS_TTY \
 			-DENSURE_MSYSTEM_IS_SET="\"$(MSYSTEM)\"" \
-- 
gitgitgadget

