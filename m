Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914BF3DC4BD
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981457; cv=none; b=AUqohHLrHO7ni/2lR7IfkVEJkwxDhrFeLfLZBdP2CwPWSBZfz6rOtcbk1zrIdfmu4NXiXCmmLHrgaV5kxbQtI/vQv386rA0LJWOTXTk8t6ZtxrCGzUJ9mGvLEZiGl8hERMkzc+MPJD48hjSogBS2fD70EkLpJL88fP3DYRFi1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981457; c=relaxed/simple;
	bh=K60gN3CnsnwDPlxbjyhf3cZf88h3yS49poNTacXGbAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HR6i0JxsBquIxR00H505sIou85XVhpxWPlNTJ5BWufhtCDtHZXt1HET70/gNnj9D3XwJoDtKvRJqciUdTZbIBre3jwvl4rDAV4dRaej9URS+xXb44RZH9J0F5AMWmNpShRifgtUMsXcS7VMbPZA5dGOCGZwPdIVl/VhBdSi4Ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URyruCG0; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URyruCG0"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso8005847a91.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981455; x=1789586255; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=URyruCG0lk6HgyNDGQREQA1ytOqV/8G7blVeCQu77A3lwOGjFDLNSe+XsPbg22nbQv
         A+f7LlH25zjK96f0EJNn+OabouQifb5ojNH/tXvKmFmVbT40b9HkfHFq6yNO9ok5xlPf
         X/+JCHb4K6BBWEQl5T1yZhbr6gn/NePC1A2zBRlN0ECFfVGkjkGl2rI3G2ITZ7JsGic4
         nthXW5jAk0FYebgVtWAosqoVDD2Udfz0V7U8NcsyoPT3/Dq8bNYykhQXiBozR7Uw5eFx
         /cRCg5KGGkUNPPGRTu7ltDmnUuOheNiXu5eExvBV+S0nPWeXIe0qLymap6JSLVwXGPAe
         XyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981455; x=1789586255;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trmP1Np1a9mBCEUqkoeT5C8Z1lh1laiWfhSi1Cyfagw=;
        b=ff8f2O1CMZA1POkq0Lv1ujnN6Xo8/kMXXTiWImsehgPuqJa0pywB4Q+20GWnn3Z8Ee
         QpiXyW7gU7ojEdMG6IsKIFwOg0SzM37VjxgwSVhuLJ5RN3RTb2Fdhw8wy1Ge2SrqpmcG
         X7ISyQCv1+3R2UBoH5ArFWfK4Fc/JSdgYmsEGbOJollPDNMAV7iuN/Q7Bi746BiqR8NU
         m9bbp0bttE1eJGc6QD2kDe07R5cqMtKVmguBlsQLoMCANA+4nl01c+u8qCL+QeNwJ1b0
         Op28PxdDU5HfN7bObUio7v0G5CLAICK42qHR2Avbl4RB7ovJ5VzspbQgLBFin7uW0HKP
         L8og==
X-Gm-Message-State: AFuF++ml1l0rZ40DjZOcR3BJsJt03HqLcpGXwN3L6DFDlB8+iY9l80xV
	tcPhTeDuVTulEeFZ0fhJ8/RFBuXh3fFzQfoSJhIc5ahu65ZwavmqnF0LZUZznQ==
X-Gm-Gg: AYBFou0qjoFwU6z2LlvXYBZJBc7nz0FNGKWhLNo0l6cfFcnagjdFY+KRCQlcTFA8oPX
	OAWtMYyv9LHqX5uhJd4i9Mj7mSlHCyyimdMTb9VCDDq6vfmkN8JZEffexqvLlYVpYqb/ic7DNKB
	LMkRzGrhVhWuWZhWN65jKcZIqUsZGr5PPNOB585dwulphI/7tTujBwowoEKLhlOGjNaQdiFkyaJ
	KNRFfFQ+Kaa7ED/DhpOGdTyUidXXu7iUKnq6rwJ9/6QaL6TOepyqYrjajN35YjSa6qP9N+j/eAf
	WoGk3WyKvJN3hadf0w5xcyU3iRssw02m4qwmPjniJWRdyKb5DTtCyAC/iMokr4yMZFzJ1P6hF+9
	IAz62IwzgrsTskkPv0WT6mz9EmycEdHlynK/U3JK3zD9y3Psq3s5WZIQXwoHulzvofRQyxpnEGx
	05q0DSbMRQQ75IXgdI8YgKouXBwB7S1mrVm25dgTXDwVO/Kdz+GqkV7R1jHgD4+s/JZXrRIr+9
X-Received: by 2002:a17:90a:d647:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39b261074camr52971534a91.6.1788981454925;
        Wed, 09 Sep 2026 12:17:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33987ccf483sm6720952eec.20.2026.09.09.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:34 -0700 (PDT)
Message-Id: <b8cc067e9236ead076811b337de72a75a7af52aa.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:14 +0000
Subject: [PATCH v3 10/12] mingw: always define `ETC_*` for MSYS2 environments
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

