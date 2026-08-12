Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79930393DCA
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521194; cv=none; b=ccVEbBfXHBIozMKP55B8txYy1AdFG4v5b35wVZWUN+QckDikY7Dm4jGHSKcWW00iR/PuMy2iIYeZvxh3+GsmwyFcSG41TPelD+PsiL9wMbvyI/Vwtnp5dQam4XTZqYj8bNHXEIMhOLbOr+DOGKmGCUFdHMPxGwR5hrfLSoJGwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521194; c=relaxed/simple;
	bh=K60gN3CnsnwDPlxbjyhf3cZf88h3yS49poNTacXGbAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OU/TDkOQkdozpmepTJ4dY8lJq11x+M8913qkYNiTHgZ2CdaR5QGnL8TFHYBLnf2aIxxwFUfc9MHKXCfIRtQeu5YCdZqRWh4DvZFqrUmnBSRqzx5JxGMbwMPrMDXOxyihWt1vdspHZqOgW7UotWZ3X/And2q1HicufvvdN+ph0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhAKJKv4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhAKJKv4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84847482584so537858b3a.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521193; x=1787125993; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=rhAKJKv4p2YQUefrJpFdo4QkQoskOZilh7U3ZeBfmMvd4aZHD1JpLdz2Gh1bKV2qjO
         n31LHS2tAkswrxeIwiFCkzm5tpPkwN/I9NWGCUMZd0voUfro2NP8fa7hPK2aKSX4XAM7
         H3eQdyH7scUwTO9t+XWc4lDGcwezw4S5MWrvd782eSCucA9TqiR8DmoQvSETFK+DYYVr
         5J3l+UtAfAEtWMvn45M2/zCrrHSFUypPEbx4LiBVhe0eUOfCnNsnx6nga/rrp5Bmrj5d
         QvLpobf1SsKklCS+CedCWly/1v8ruVuZK2FKchunfywgbKCCJ41czGqYgkkeU7zGaD02
         bxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521193; x=1787125993;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=IDOFxda1IxdlS8QHlm83E3Xoal6J6XD52I4wiU10HfPIlJk6n+luLB4q+WFK8xjkkK
         IZDJMzvyV7O3nr+iK/sNVNtEESVtG5y5uji7MmF197sbyOOzg4xXAFwTl+OiR2tgopbL
         hLQuLymRXwbkVC2SqBEEzUeV8kyLta9hDdsNJysPPI/6YRWmbq+lsIqhLRIQNBNtl390
         2dVZjNL3AVwBclwGbRoxpfaOv4KGGJlhHRiPxMjr+FWBRZ0GvVLYislOgsJ/AV/Cuvyi
         ipeK8Y4qaD5FpMsjhI9rQKeCYhpIxoC7iwVw534ccQSAxwkXiCCxaACqs9vuUqxEFs3e
         AuDg==
X-Gm-Message-State: AOJu0YwkLx/Um8GevSjZeGi3VfihjSS9bizOpL+07gh/hym8lGo/T8W0
	ciQ3lBtdHPsteiX8YnpGliUCC2SDPeCBEN5IFd2HFxTnOdlrNIfjqGAXvnizYw==
X-Gm-Gg: AR+sD12tvKrUfc42L8siJuhhNngMXQX4zhA6z4V+/oJhdNbLDA1cre0uwSIJ7PSAA8c
	UAffOMtzgF8bCvw+6kUgkKU53Os/xpo44SkBVhlaMoZJ9XcCPGN3AL5yef2X+udV6XHy5s7R3gs
	98ntJKMKuqbwQSkeMB5mNkKfANh4tdLZmeEGAoGLIO+1ihcXhrkyjYSOQcskbL1k4Yoafc3+rpu
	H16/p1xdg8Q4gyLP3kslnYWPokgqv5gwyF8NS1xDjV68jmYT1hxfNsJc6jQ3Bxdnoh4H0XVcI1c
	HxPMbKUTAcYBPOwYOw8qbm+FMnnOYJ4MzL+2MlxRx2pI9yTAW5lr8KhCjqla4ZZu410dmR0Y6fv
	oK8ICyyZWpVTV9KdCVC2nsEOxlsfs6ZcVGOJRa50gUJbHk6Ml/43pqZeMypDYmmn/sdVAdHoYpF
	tj0WIWYtGzSaxnopYZk4EnHILfvLRyn/KXu4nEy9cHgaLREB1C21SJF11j7jifs4Atnw==
X-Received: by 2002:a05:6a00:2884:b0:847:852f:c28a with SMTP id d2e1a72fcca58-84fb64a393cmr3171981b3a.5.1786521192705;
        Wed, 12 Aug 2026 00:53:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1d2342dsm649894b3a.16.2026.08.12.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:11 -0700 (PDT)
Message-Id: <1dd6ac9295ca6ca2ab9a576f37ffef532b7732c2.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:50 +0000
Subject: [PATCH v2 10/12] mingw: always define `ETC_*` for MSYS2 environments
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Special-casing even more configurations simply does not make sense.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 88bbe1d78f..2f7d445eb3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -519,7 +519,7 @@ ifeq ($(uname_S),Windows)
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
 	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
-ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
+ifneq (,$(MINGW_PREFIX))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
 	ETC_GITATTRIBUTES = ../etc/gitattributes
@@ -762,6 +762,9 @@ ifeq ($(uname_S),MINGW)
                 ifeq (MINGW32,$(MSYSTEM))
 			BASIC_LDFLAGS += -Wl,--large-address-aware
                 endif
+		# Move system config into top-level /etc/
+		ETC_GITCONFIG = ../etc/gitconfig
+		ETC_GITATTRIBUTES = ../etc/gitattributes
         endif
 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -fstack-protector-strong
 	EXTLIBS += -lntdll
@@ -772,11 +775,6 @@ ifeq ($(uname_S),MINGW)
 	USE_GETTEXT_SCHEME = fallthrough
 	USE_LIBPCRE = YesPlease
 	NO_PYTHON =
-        ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
-		# Move system config into top-level /etc/
-		ETC_GITCONFIG = ../etc/gitconfig
-		ETC_GITATTRIBUTES = ../etc/gitattributes
-        endif
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
-- 
gitgitgadget

