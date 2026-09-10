Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83530EF63
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020346; cv=none; b=DEOK7kfJCSBodBH1MnYlUgIc06madNjWOnzydJrPnbo2XsV7wHEXFyQGbK/dzwwbvPggIk90jBXXH0Y8H8TKOVjA1ivHLaVFbw4VCZTYZLRC1EdzUlmw+BDrh72XJq6p+BPOQeOUJo+vuUoHvYnGBavnhJz1GQJmJP4ma9tjWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020346; c=relaxed/simple;
	bh=SDF8Ql2vpVY0av+drlmcTo8RRZG6Yykl0TCxjjJBukY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IO15FGH264t67Hoi4/1YDiwIr6R5jA/un6b7ucHwMFE8Oqva1hHDVF87pRs6GGdN6F5791Q7xJrFi9Hu6aCSUvRMJJDe8Rr3rbZW+BlhsD2T6fv1xOqdzswhQQSNOZxQxcI21dmxLIPAL1xTfmO2CS2OruR66qAkprGiwgSQIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFyW4kMc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFyW4kMc"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso5710399a34.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020344; x=1789625144; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kpQiXvffdWMtOKACJATYQ5TENPZ1ZDDtkQoppdCWGhQ=;
        b=OFyW4kMc8TB1Bt5Bk6Hyhf7uR2PxavaY7aMvD5GNbj1oQll0FYODNACGfH/y1EyGNU
         R9kdRO/YT/uHOOLmDEvMKLJ2W/t6h6r340IzvJYKKgIxhv8kqKzuj+Ox7SdQcmHcetfe
         +j9HraGUcffeRxJ5WxRxVaVgZLLpWMrcvat7Nx6+r4I0s21LDvtctYic2l/h0Cql4AHj
         wIUJJ9X5yLmUn5I3t0joJeiXth18CRmKCXSadnxocVkePgys2Qecob81k/GuVyOSDjxe
         yINFnMFmS4fcaA5heh7ssNiPR/Bqx5QFf3Rzxhe/R/lM5LKcdmV+jI110+VTHIS+GtUQ
         /UvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020344; x=1789625144;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kpQiXvffdWMtOKACJATYQ5TENPZ1ZDDtkQoppdCWGhQ=;
        b=hABrCFReDcYc9wGnAMYvOuawGzSDR3orx+Czubg+N0Zgk6oWWVpaxyd5cTQcmIuWoQ
         ACOXJuDEolVpoG6pwyaYtAactPho/oTeENybqxcL678f/MRLJEt+n/Gc4ScY+9nJF94Q
         SZG9zRuV5DiczYqSiP/bnj065JZXwQBGzeegitNssRZ2zIoCRXmhcDGdZmYqQhM8nXjh
         AfhSVmvyTwbX71po4/BFdCJ0sQzUOrH9zJrvC0aL1tncIuNLj9cXBOkw5cj3l9rrDXv2
         MJ4c5WhCew3AKS5O7Rh7+ItLNdrP1yFQNIPpqbBQAUpDsCasEpg5QEbZ8T1dUzIZH2D7
         7luw==
X-Gm-Message-State: AFuF++m14l7t9ookQCziJoePkcC0d5ECrRuFZYMBpGqVu+jIyzElaikl
	jJPYcZSms4XfN9eQk1k4Pwfr4MpePqzUSwSDkZWicec+4ORkMIwSTC6Y8psxYA==
X-Gm-Gg: AYBFou1jaNbAH9ESncqReuoNSf2AoE/W0SeYM2sRdqDZF0in19a2GxfzHeiMFoLagpE
	5+o5S290ArhG61ZXzQ6Q46j5ktslgQhWswji2pIJ+dCr8G/GESe1ZhqphYGwzeQdi+uHAjuIDy9
	v3FEBMQvKEii++3VMl7tuuysxed3YbMN0coAvshKmq5utIOtLR5BH0WeIlPV/miNQqeuTOCDiBR
	MwEUX6PViVip6SuiWqq5FpIjv/j6yMtDY45gII5Xfb5cfBaY9Ev+kih2FKhLlcU8AHK3fsch2JM
	3wuDdesmQuIIljmJjnn44B1Iqt+PH60zfwp5hRB/2dT520R5hXt+lgDiUzLsRPqRZctKjejvHA2
	mEScUoZYa+J3ldlcuMFp+8v5ZxYdVi9MBXOCR9LuoRQhFxDoiWkjsjoIhmA3Rt6ckMp3bLV+rX9
	P3w4XD5zVwzQKJ/kQzRu0B9SKEYsHKDFNuM1EL7hEdg32bnd5DeYiEwu67t9Pc9TY+0GUw5HUE
X-Received: by 2002:a05:6820:4d03:b0:6b7:83d6:2931 with SMTP id 006d021491bc7-6b783d62f12mr18899065eaf.52.1789020343743;
        Wed, 09 Sep 2026 23:05:43 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432424d27asm65561484c88.2.2026.09.09.23.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:43 -0700 (PDT)
Message-Id: <b5a78f65b64ea415489f4c8e359636d1bb68bda0.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:24 +0000
Subject: [PATCH v4 10/13] mingw: always define `ETC_*` for MSYS2 environments
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Special-casing even more configurations simply does not make sense.

Helped-by: Johannes Sixt <j6t@kdbg.org>
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

