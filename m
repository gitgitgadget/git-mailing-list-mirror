Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55A37D10E
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358103; cv=none; b=nrVGbc4C+umjTRESKRkYX9eXy5vk7Ynzhgipe9Gm2M78Jj+g16e6heLaS0NbcXNSp0V9DeBngcBKIpFHLg1PQVQLoeOB/vz0+pzsztBlFP8sZcNjipS6ANO+dDmmpQ+DJNoZM4TBf1ya5xuPi+88XDzdmXe9O0+Z2BsFxenRh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358103; c=relaxed/simple;
	bh=jM6pb6HttKFADGTxEQlN/IXmURH2kLmwM5OIpr8R9Rk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CdonXlFZ3+PEU2DLQheC6SwvPgtUW9KCbAD0F+3GLdbDjdBCxoNjl0eGMscv/N/1Zc2sQvce6LEJWvx20FEUKOYrXkV3Kva4VKJiTAfCmeNl+QZcOI41dVmdosTN13vAlVpX+q9mQC+QczhGNnXT10tCuT4YWOaTPFJy0piuoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD+4zZyT; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD+4zZyT"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6a1888969ddso1893735eaf.3
        for <git@vger.kernel.org>; Mon, 06 Jul 2026 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358101; x=1783962901; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/hJfA+iGkpllhIagvsyPecyDYJ7kBGB17acOgFLJjA=;
        b=cD+4zZyT6XfeVpZLt6ZvgroL/WUJncrVpUcSJNBRzgnYEhGD79YkqG3XigPq0z5eGR
         7vFwkFalJtCnhx2nmKqnD2U45aYHNw4ucQssqryeEphmlaMeIOp6CJ2YFuEzZGY+l/ZT
         1gGSSOkhicMhRXnd0dUouKB5mJ1+HLw+xNoBkdyz8Xm33sI4M0PjnYAYLk6wiEXKgzFt
         tXXNNOrp/Y4xybUCPa10hHcHytZQg+x27SQkJbPM+QplJLkqQm6h6vV082OQlfEe13y7
         GCaTw2DnT2HBVMr0oa+o5WdYw52kV+sarHMXG2hsQRMIMsysqJtMqaUNvtM49xsW38G9
         AOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358101; x=1783962901;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A/hJfA+iGkpllhIagvsyPecyDYJ7kBGB17acOgFLJjA=;
        b=ceStSQdOXaw5z2JPfOad3362w4bSMzOw2mHPMkyKAwCLe1oJmuyteFEp4JKwSHrV5I
         /l/TKleALWFcTTts/HBi0zw3NRDlzd6e4lIj1czXB4T/Kz9Much9PvWdTUdFSDm/c7QQ
         vxZdkDLqqA/w44vn8EF6pzspAuvkvDNdIV2PrjAmXz8XUXPK/YLJHpsiKrHuVxK/6mdd
         wcgBFvs8FdZC2I3+AXOsi9I6LMRzXnnfOHTjoY1ebNgxOkvDw4xUcScrpDH2xAufcV/p
         L19ZbpkyO+Laq+VMmm8T9ZbdhCWm+3RhYcDuiHMRwtDTkrv9XyOZ7njrRclbEn8QvV6/
         jd4w==
X-Gm-Message-State: AOJu0YzTMuUuAYB7j1eWVqWn8zs71asfZ4JjniB+4t1ZZSYFR4Z2DRr+
	FwCuTc63JK/8doCn1YW162hxQV0ZUKANwCdBzh/E5fH3VdLKWfcy0g2382APBA==
X-Gm-Gg: AfdE7cl92UVRpNkuvHeEXkNprlyrWVle0/L2J19E/5yaN9Jx8fXhtS8X4V5fBalszQq
	EN/xq6eBDI0APMea9F7qofUocVkNc/ga8MvT7BSHw73KxFDKxGwF+STYN66o2TU6/TKtp7QvqK2
	r+/NTnaiLQiQvhAlc/e7idQlcUJV0N+UeBmcqqnDJKrRrDrNqXiJCl6qWYd2DyI7gIMD9lm5oV4
	9VrDC2i+QYjsJzRaeyEXK3Qui/Md0uRmc2uNyvtPycT30orLTjLatO7uWYLpUk0oDKsW5Fd6eMN
	6Y8U1cM6wEyQxFI3wB59hanpyDQ4CYrej3gi12K4JmvZGsd2bGvYwm/CeYD6tDctIJv883PJwdA
	SoyDjIiUjJwQy5Fb2IDZsDfPwznH5BVoWo3ntpkjMjRw44JyEHjVkokL8PyYyX+pNXP6ekh0NDk
	2YY6WFkL4XG7hMQkCiQkQhhIfqAA==
X-Received: by 2002:a05:6820:80c5:b0:6a1:656a:9a03 with SMTP id 006d021491bc7-6a35551257fmr830522eaf.70.1783358100657;
        Mon, 06 Jul 2026 10:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.32.69])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb13d624sm11113307fac.1.2026.07.06.10.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:15:00 -0700 (PDT)
Message-Id: <e0bb18ff0191de384ea3c947bf26ee07834782cb.1783358097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
References: <pull.2288.v4.git.git.1783188355.gitgitgadget@gmail.com>
	<pull.2288.v5.git.git.1783358097.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 17:14:56 +0000
Subject: [PATCH v5 1/2] Makefile: add $(GITLIBS) prerequisite to osxkeychain
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

All other core Git targets that link $(LIBS) already depend on
$(GITLIBS), which bundles common-main.o, $(LIB_FILE), and $(RUST_LIB)
when Rust is enabled. Add $(GITLIBS) as a prerequisite dependency to the
git-credential-osxkeychain target to make it consistent with the rest of
the codebase.

Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
specified, $(RUST_LIB) evaluates to empty, making the Rust dependency a
clean no-op without needing intermediate variables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..7f4be97b90 100644
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
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(GITLIBS) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 
-- 
gitgitgadget

