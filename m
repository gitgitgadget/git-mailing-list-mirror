Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF4364939
	for <git@vger.kernel.org>; Thu,  7 May 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169621; cv=none; b=G4xAsriEVnMNoaE3a9TcyXd+H5MxoFAUMYJhUJYhoZNkety/GLk1lw5kSJLVTvMIgY3gRvH8ojigXRg63U7B4oFyn9JJPtbwmYcieSzUgzKrKezGAPkKMnHpz/ypnIG3/yLQQzI/WU3aDtL6gejoEcmaBvEcN81+jAeBcSq/ob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169621; c=relaxed/simple;
	bh=+1031/BIuu5w5bmwZL7zvmLRDc1207zloVWZ3ZrE3dg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jO4ggR9M2AqQpbCDNkTSkC0wGYtM1WLmfjHueFonVSE6Y2eaVI822gm1ZP/TaWovbkc5pI8Tb9NafhzSxXVv9pGsW56pQ3VZDspoi9RQVhmRkdblhX86PHT0P5rhzUZGypvIOE2J8CS/hmKXhrDGirKvOkzsf+oxfT5M58ia0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBZsfDdG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBZsfDdG"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so10752687b3.2
        for <git@vger.kernel.org>; Thu, 07 May 2026 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169618; x=1778774418; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EYIRILD95+N7j7AcrhJBblz2+6G7Q1uP61NTL0mcDY=;
        b=QBZsfDdGWw2bXHf5Se+aW2pBbLAmwxZA9L73RNEzimoQMCbNT0d3/vPLsFkGgD3MVO
         3hKzVstIZvF4Fu2BQqyGY2yTGYkqC/Dbx8VN1FlHqDUBwSTFKz3aRfCRNcsS03Kv6g5Y
         q4fP1E25R8GzgFWhnjOhSfuIk1YzdepFW22cSxGjMihmOeTjwdW+QlzrVGSmWIAsXN3V
         w0djC24oyEnD8A/isxmlKX0vYYLhdIp8zpJp5TGw4QInvCPqqfx37qZbyXd7mK9pbDAi
         qi69XPZM0I0AEffYVf315Rcn4GKAvILWcAPr5COCUm8Iq2l6crT1SoWAvTPKY2cIUZNm
         MrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169618; x=1778774418;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EYIRILD95+N7j7AcrhJBblz2+6G7Q1uP61NTL0mcDY=;
        b=fgXC+Q3NS1IoTLYa5J9d3jXFnM71RVqDM9BFxrASXbfoP3+d6y390IpAQI1YWd/wAS
         b2cymaijyP4Qey4lP9/0udaPZMD8SDYwZd13pO9lqu+ZBLPiEbkWE4CB2qP7AZMqrxFI
         /Vovw31ALfKggKwr1vKE0V2PHFvQrOVNSjFs3x89/Uz3aYsdB4Y5pZp5XLJbUWx2yWAy
         7IGPG+p9F7iAVrmby8zA0YiqI8DZBBGdOBTRZ7gBr2DSU0dTx7i1PxuKW7vozJFoNvNo
         e/Gav1cA0LOF/fiPyPZU6fgLSXZRqTSGsmmVbm0a6ZzuEHrmuhD3tAXHE3CjiEKTZ496
         cWrg==
X-Gm-Message-State: AOJu0YyKYHGY6xtjFyM726/z6mzW1Ja4jVSSvNDApenxDNxD79ltFM3D
	WgzJVMdgsqiOm6ok7FUrvJHcDvJalM1MDlGj50OnlYgKksP1crwTulOzpXniHA==
X-Gm-Gg: Acq92OH5Q4+BoiKFgP/JKDTF39dDFnRwTHKxEW7OU5bM9x7ptlbYGFzK0AgPqhqZQcq
	+1uinbvojn73LEZExpdbG1Ah6HFVt4dz1r1Eg2y+N7h0NDZfsfHb9Q0gxv6ma2bUq8TV9hFrw6G
	mLK/INz2bDoMfO5JNWu7QTz2P5Tlt6gMohA8rB1opGS1fP8jf8/9g8bh3sXQIP16g7so4/zfRFQ
	eUCjEYb96JFdn3CPtk32abX5w29j7QteAC2Cyl9NSjxizBK9w6T6UphcMsWvhyixCO+KzdTCJ5M
	agRKMOQxUmK+RZUr79KMq0n7naM9dZlnvv2jyEIoxf/HyrihqrNDL9wKvLA44zplWqKvUnyFLaD
	w8Nwd5qYTDUfkJSfxqJ+zcqTbot0iX6sWli9/N+COmbhusAVfOl0NikSWAWFQAYQBPrWrl5fbJ7
	QeCzjqBgc7gLBAhGQjCzUTuW7aHHh8iZKhN6EIPw==
X-Received: by 2002:a05:690c:9:b0:7bd:a6ea:c507 with SMTP id 00721157ae682-7bdf5eb1db6mr97408227b3.25.1778169618075;
        Thu, 07 May 2026 09:00:18 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.153])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66839f63sm97114887b3.31.2026.05.07.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:00:17 -0700 (PDT)
Message-Id: <7b5daae659f491ce8a2ba52d02ba7172106120d8.1778169613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
References: <pull.2104.git.1777811392756.gitgitgadget@gmail.com>
	<pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 07 May 2026 16:00:09 +0000
Subject: [PATCH v2 2/6] mingw: drop the build-system plumbing for nedmalloc
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

With the previous commit removing every opt-in, the build-system
plumbing for nedmalloc has nothing left to switch on. Remove it so
that the upcoming deletion of the compat/nedmalloc/ tree is a pure
file removal.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile               | 17 -----------------
 config.mak.uname       |  1 -
 contrib/vscode/init.sh |  1 -
 meson.build            |  1 -
 4 files changed, 20 deletions(-)

diff --git a/Makefile b/Makefile
index cedc234173..2f490d402e 100644
--- a/Makefile
+++ b/Makefile
@@ -283,13 +283,9 @@ include shared.mak
 # Define SKIP_DASHED_BUILT_INS if you do not need the dashed versions of the
 # built-ins to be linked/copied at all.
 #
-# Define USE_NED_ALLOCATOR if you want to replace the platforms default
-# memory allocators with the nedmalloc allocator written by Niall Douglas.
-#
 # Define OVERRIDE_STRDUP to override the libc version of strdup(3).
 # This is necessary when using a custom allocator in order to avoid
 # crashes due to allocation and free working on different 'heaps'.
-# It's defined automatically if USE_NED_ALLOCATOR is set.
 #
 # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
 # feature.
@@ -1511,7 +1507,6 @@ BUILTIN_OBJS += builtin/write-tree.o
 # upstream unnecessarily (making merging in future changes easier).
 THIRD_PARTY_SOURCES += compat/inet_ntop.c
 THIRD_PARTY_SOURCES += compat/inet_pton.c
-THIRD_PARTY_SOURCES += compat/nedmalloc/%
 THIRD_PARTY_SOURCES += compat/obstack.%
 THIRD_PARTY_SOURCES += compat/poll/%
 THIRD_PARTY_SOURCES += compat/regex/%
@@ -2267,12 +2262,6 @@ ifdef NATIVE_CRLF
 	BASIC_CFLAGS += -DNATIVE_CRLF
 endif
 
-ifdef USE_NED_ALLOCATOR
-	COMPAT_CFLAGS += -Icompat/nedmalloc
-	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
-	OVERRIDE_STRDUP = YesPlease
-endif
-
 ifdef OVERRIDE_STRDUP
 	COMPAT_CFLAGS += -DOVERRIDE_STRDUP
 	COMPAT_OBJS += compat/strdup.o
@@ -2983,12 +2972,6 @@ compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
 	-DGAWK -DNO_MBSUPPORT
 endif
 
-ifdef USE_NED_ALLOCATOR
-compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
-	-DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR
-compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
-endif
-
 headless-git.o: compat/win32/headless.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) $(ALL_CFLAGS) $(COMPAT_CFLAGS) \
 		-fno-stack-protector -o $@ -c -Wall -Wwrite-strings $<
diff --git a/config.mak.uname b/config.mak.uname
index 3636b98238..25345e02c6 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -491,7 +491,6 @@ ifeq ($(uname_S),Windows)
 	USE_WIN32_IPC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	# USE_NED_ALLOCATOR = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	NO_REGEX = YesPlease
diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
index f2d61bb0e6..3d58f7307a 100755
--- a/contrib/vscode/init.sh
+++ b/contrib/vscode/init.sh
@@ -202,7 +202,6 @@ cat >.vscode/settings.json.new <<\EOF ||
         "\\bUSE_STDEV\\b",
         "\\Wchar *\\*\\W*utfs\\W",
         "cURL's",
-        "nedmalloc'ed",
         "ntifs\\.h",
     ],
 }
diff --git a/meson.build b/meson.build
index e896bc15a1..0e00c6c57e 100644
--- a/meson.build
+++ b/meson.build
@@ -698,7 +698,6 @@ third_party_excludes = [
   ':!contrib',
   ':!compat/inet_ntop.c',
   ':!compat/inet_pton.c',
-  ':!compat/nedmalloc',
   ':!compat/obstack.*',
   ':!compat/poll',
   ':!compat/regex',
-- 
gitgitgadget

