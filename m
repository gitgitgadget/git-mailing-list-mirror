Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDA3BF67A
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378341; cv=none; b=CNZE7cNZXzy+e2PEyMtMUvXAl/erKI2460Ewz1HJGphJC+/DUKaLX47ntSvWLcM+nYqKvzY0QlHNGf9RerZkwpSunD+20QqzJnKJ3utCGHPhXIg7ZNg6VBJqkIqKFtw7I2d4owpuglzOqSsosO2FNVo+dYLsmeKCyNgc5giAxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378341; c=relaxed/simple;
	bh=0iTpiH+GqxosFP1vcOYy9y02k15D3wpUNMZn4KpT9rk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cUKuivwiDVwRey9Q70C1gDNEbjob9e853Y0738xXjFvxLHALHgxFo02FweGnXHsWlyzP0h1+VW2qn+OUc1rmNweXCnBGilm08wXIQ5eNghX0jyzERxsGh1b/VfJXwa3uroDq396H+iN5Yj2/Av2krlLgdHIXdZxB2KNwlx0Du7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFYHlNwG; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFYHlNwG"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92c7a0a701aso173581185a.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 15:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783378339; x=1783983139; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=XFYHlNwGIK5ybsss8mVMrSp5NQSwwNt8XVbawaz+DtgfrCPP/pHOyYQ23yWtk+mrka
         Bido/lTDI2wnJtZSryMvEUU0ADzRX8YuySaguVAmWRVoHllY9FDjQGPf+zuB6XDx+lOG
         FPtYqD0+BmegWKQH+KFzEirWrEUaZheNEwXKhN5gTh96pgQ2lZnYkRQrSCDWlBJfJ0ng
         ke6ciS7hgUX/NgaFOhckzvATnR2keFXCHrl0g7ptNx+oxIDFB5WQB3ZDJIhpaZKsXzyl
         mdUExiWYdenA8EjIzgK2QRq7SCWfUNeGXRhG+1WKWWBRq2T6BiM5+JV3X53wclL3Bh+h
         Dnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378339; x=1783983139;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=XMLR7FD4agZ9sz4M4JUxY7zwbdFNoB8TRcPuTnI4Vp0MLntVnuEhqyElV3VHKrFwBB
         VFXJpW3iHASqb7CIzFV6sp6tdr8m+PhP/IGpv2hTEO7edKsfFLExEkYdOHNgRhax/9Ge
         oFqc6NjOdZNKd9uZ7MabSvY/VtR4/7j2Zz3FbxaG/qJ/mc3/yATnEANKOHb8BFpgLimq
         U41rtzxj4pKS1Q2RsO5+N9uDR2VlivU+rSft5iOMGfwLHNoQeAi8AOkR9vbW/mwAibLL
         tawwuoN113YdtI5cYoMcTKW1baBg/eN3RbeF00WtoMU/855YHB7O9aTB1fSYM05Vur+j
         touw==
X-Gm-Message-State: AOJu0Yy93bfMxdpEuRMyj1uZBc3Zvoga/puboYiHKhT1ZQ6ksuXz40EX
	A/hEK439bvoHN0mhh63U7PdfuUmmdiR/NIJUoQ5S49CVA36feURCn2XGQTsvnLKG
X-Gm-Gg: AfdE7cmB4dIfEoWPYvC8lr9fwAhjW7z0B+eu3Nflw6kIMObMRpQfT7WlgLdf8L0RMhy
	mzuL9TXo8yOYRFqIGprWELaH9YMO4PkjQ5TtGL78Faj4Yi6baSyB5lY4ofDsKAtmjyEjxK83EV/
	GvBWj1X+ZdSwria0l5ZzdVrG69lMbgWyrnTvJKJZ+7ijZ5YSU9BEYfRT8LmJY1yuQxusVpNaxyg
	a5tBqKTAhjIYwo0E5+C328SLmOUnv1Bcs1aiz7xiLW2gxfJVVs8x5+tBc/wQdvNiOauir3e5CEW
	nBbFkQ0aVzvp98+sXYKC6DE1TjLJd7Rw2mZFfwaRpy0PDAnXz/gxFU5+xKqCmLeQ6ngKVyTKCGO
	Ir8ivjWvJGEwXrq9Vb9nha/AuJQM7hL0W609G7QK+jRIziBmMHXNdnolLj3fxvP+OtetVjlgo90
	o0977rM2whXwrdyq0=
X-Received: by 2002:a05:620a:408f:b0:92e:c118:18d5 with SMTP id af79cd13be357-92ec1181f88mr17286485a.76.1783378339142;
        Mon, 06 Jul 2026 15:52:19 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.72.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccdd5csm1071133685a.36.2026.07.06.15.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:52:18 -0700 (PDT)
Message-Id: <0d215139406350586ca67554b90b47c0ae42a9fb.1783378333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
References: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
	<pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 22:52:11 +0000
Subject: [PATCH v6 1/3] Makefile: add $(RUST_LIB) prerequisite to osxkeychain
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When Rust is enabled, the git-credential-osxkeychain helper depends on
Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
("osxkeychain: fix build with Rust") updated the linker command line to
use $(LIBS), it omitted $(RUST_LIB) from the target prerequisite list.
Without this prerequisite, running a parallel build ("make -j") from a
clean working tree can fail because Make does not know to invoke Cargo
to build libgitcore.a before linking git-credential-osxkeychain.

Note that we depend explicitly on $(LIB_FILE) and $(RUST_LIB) rather
than $(GITLIBS). Unlike standard Git builtins and programs like scalar
(which define cmd_main() and rely on common-main.o to supply main()),
git-credential-osxkeychain.c defines its own standalone int main().
If $(GITLIBS) were used, $(filter %.o,$^) in the link recipe would
match both git-credential-osxkeychain.o and common-main.o, causing a
duplicate symbol linking error for _main on macOS.

Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
specified, $(RUST_LIB) evaluates to empty, making the Rust dependency a
clean no-op without needing intermediate variables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..7db38ecce9 100644
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
+ifndef NO_RUST
 ifdef DEBUG
 RUST_TARGET_DIR = target/debug
 else
@@ -950,6 +951,7 @@ RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
 else
 RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
+endif
 
 GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
@@ -3019,11 +3021,13 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+ifndef NO_RUST
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
 
 .PHONY: rust
 rust: $(RUST_LIB)
+endif
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
@@ -4074,7 +4078,8 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
 
-contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 
-- 
gitgitgadget

