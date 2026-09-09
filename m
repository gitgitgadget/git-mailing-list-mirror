Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08513B774B
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981454; cv=none; b=mHrvSjt5EIBKuBpGIwyLlVFez/KsX7a3I7BTD0nNY868xB6i6JPOGqWk8ihyptGGkJQNFCnGNiqhw2X6A1Urh8r5wNlznCO3UXlAz+hctbMWLKxTcS5qnz9+YUN9Eg2ZUKAaVLfspnntObbT/toczoDE4gaJUUjEwZe1MZZA3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981454; c=relaxed/simple;
	bh=SzMZSNl+idV6DvL2Oa1b7HhlQlrMBBAVJxiE8qLiPSc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rr90ItAWRGKS5pfxlAX3MaqBRfbIDfXgcLmX+66tQ6pzxSvURTzGhPx8cix+uxv/D8aeX25O1G7caP71PxheIPqRMTbJUPvDCAnAWlTKpnqlnSH5eIn9jCsQk8LlYvAB6H5xw51PGD6qkP7ng8Q7L+y2+zVAIL9ZLJ3iT+CYG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jURvHYnb; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jURvHYnb"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso1291004a12.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981451; x=1789586251; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1QWsMNogeqjKFEgJjMDvo9DHa4hUGfHcMq7WuB/p8Aw=;
        b=jURvHYnbBVKheR7FeRRgaBh4LqSULHRPX3UHVlzidXG8HtZHIk9RUcRxjO1vLfa5TU
         4g38+6kqzfKOJXJL604GcPGCLhlwU7DBvfintFnoI84XCaIsRdnhpgYeHEAmo9KjyL3v
         55+h1ShnZ2j7HuFepc/1P0x0gzX2YrAA05Gu6Hz+EUrY0Xkzd7cXBnrU2/X4gQfNSd1D
         Pv0T8jazmSEFPeUE106N/tUsz08OxT8JgiYzOTPWaZBKO3AauGdnCuS3aRpQmTl6X/xA
         ruskmzozSgo9bR7lZj53QfoJ/Ua18eopyzJyTtUD+FD94wCJ0Z4TJS0GUpboeXva8Q5K
         F2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981451; x=1789586251;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QWsMNogeqjKFEgJjMDvo9DHa4hUGfHcMq7WuB/p8Aw=;
        b=g0oRQb69/aXOvl6lnGBanpaR2R2VY+NqhsTeXcrgZLixE/IOaK/NMqaILXZ5B6Pt/E
         ZCkpYjxDEgTaIiIuNogz2Y/ycGkg1WngONtcF033orblKil7RUNRQkFZ8XEmljHXJGmn
         X1VI0AeAUML8VUrNy/1wBGk32A4e7MD0aQDWDyPoAtI91Okz4yycub3Ax5qO9oRWGte9
         OE+YaHNF2dcQnG0xkDenICHIZ1sBTho8+krYAB9HQmyXWFiORBY606MP7BIHHfNveaAr
         0dqWxl2kfkIhE7BnNiGij/VahjgRfk0DI5asfXmc+FXbvLR3FspwI4O7aySaJ/KLM5fC
         PmEw==
X-Gm-Message-State: AFuF++lWPN36rcbnXcXI+0dG/Tav8a7r5Cfw51nP1yvSDJT6C619UBJE
	xhVTCA4ThtUpvgveDns+MgJkHBrpcrsL3hZgtPv4Ns+V+YlkmnEH0hV8+DdDGg==
X-Gm-Gg: AYBFou1jlmR+/7RlV9jMaUiUZTdOjeDzk7a7DbVa4vf+OjCUjQEfy4ecUKJFyXACeFJ
	R+ZrTrhig1SkSvz+KzQeCaCnuNZW4CeE6t2ARV8WeSqCZ4Rp7Dv7YkwIWmvM326NGyHcN3mXtLa
	njlKS4xTGxPLc6b84UjzWz5qowA7GjmcMQT2rJEbVG5GxMqma+JDEL3I3f+5uEB0OvqxiLf8Bqy
	k8aCgJqlEvktgDv5dL7WwDqGOVS0tTWvf3GuP4mhBJl0AJWLgTYuv08p3zIX3tnKsU75MQBt0VP
	Wd7OWzvwuV0cOYdt2tTMS3TitU34XWrhTfro3dBZa7ZRexcpsO9t53H3Vdwv+BW7hdhU8oO80la
	V0SAbSy5bqtdW8xlU6QHSbHXgkOhT8okvXX8FkqaX2PfygJjXYr8cK2nrqQxeGhZwqtNQNGPmOY
	eJzSW2547F+rDl0Gb8kl3f4gGEC0tReq10YISOUusSTy9OMZPeQ08CqYspqDIGwafPaMLIwqt4
X-Received: by 2002:a17:90b:520e:b0:398:9be8:ea65 with SMTP id 98e67ed59e1d1-39bac3c452dmr11695315a91.18.1788981451460;
        Wed, 09 Sep 2026 12:17:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1435c2ae6b5sm722073c88.1.2026.09.09.12.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:30 -0700 (PDT)
Message-Id: <4cc14553dcddbd7fb1a49864ae988bad19626391.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:12 +0000
Subject: [PATCH v3 08/12] mingw: rely on MSYS2's metadata instead of
 hard-coding it
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

MSYS2 defines some helpful environment variables, e.g. `MSYSTEM`. There
is code in Git for Windows to ensure that that `MSYSTEM` variable is
set, hard-coding a default.

However, the existing solution jumps through hoops to reconstruct the
proper default, and is even incomplete doing so, as we found out when we
extended it to support CLANGARM64.

This is absolutely unnecessary because there is already a perfectly
valid `MSYSTEM` value we can use at build time. This is even true when
building the MINGW32 variant on a MINGW64 system because `makepkg-mingw`
will override the `MSYSTEM` value as per the `MINGW_ARCH` array.

The same is equally true for the `/mingw64`, `/mingw32` and
`/clangarm64` prefix: those values are already available via the
`MINGW_PREFIX` environment variable, and we just need to pass that
setting through.

Only when `MINGW_PREFIX` is not set (as is the case in Git for Windows'
minimal SDK, where only `MSYSTEM` is guaranteed to be set correctly), we
use as fall-back the top-level directory whose name is the down-cased
value of the `MSYSTEM` variable.

Incidentally, this also broadens the support to all the configurations
supported by the MSYS2 project, i.e. clang64 & ucrt64, too.

Note: This keeps the same, hard-coded MSYSTEM platform support for CMake
as before, but drops it for Meson (because it is unclear how Meson could
do this in a more flexible manner).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 21f53e3f7e..3a90995587 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -465,14 +465,8 @@ ifeq ($(uname_S),Windows)
 	GIT_VERSION := $(GIT_VERSION).MSVC
 	pathsep = ;
 	# Assume that this is built in Git for Windows' SDK
-        ifeq (MINGW32,$(MSYSTEM))
-		prefix = /mingw32
-        else
-                ifeq (CLANGARM64,$(MSYSTEM))
-			prefix = /clangarm64
-                else
-			prefix = /mingw64
-                endif
+        ifneq (,$(MSYSTEM))
+		prefix = $(MINGW_PREFIX)
         endif
 	# Prepend MSVC 64-bit tool-chain to PATH.
 	#
@@ -755,6 +749,10 @@ ifeq ($(uname_S),MINGW)
 		BASIC_LDFLAGS += -Wl,--dynamicbase
         endif
         ifneq (,$(MSYSTEM))
+                ifeq ($(MINGW_PREFIX),$(filter-out /%,$(MINGW_PREFIX)))
+			# Override if empty or does not start with a slash
+			MINGW_PREFIX := /$(shell echo '$(MSYSTEM)' | tr A-Z a-z)
+                endif
 		prefix = $(MINGW_PREFIX)
 		HOST_CPU = $(patsubst %-w64-mingw32,%,$(MINGW_CHOST))
 		BASIC_LDFLAGS += -Wl,--pic-executable
-- 
gitgitgadget

