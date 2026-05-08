Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4F3DDDB0
	for <git@vger.kernel.org>; Fri,  8 May 2026 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244669; cv=none; b=YMglilHrWKtLRuEme64u2dhkjNxVJEdNmjTVWgrJt1S+VBN4+UyUTayy2gBTVb9x8uyR8vKRkwr64tQfzNIc9TZ08FlAm55HQszEBl1onVPMmma5eyozaHYwtj6kF13upuTmdwZk2QEOV1hVL+XTI9F+WDFt20euxQCeQOqtUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244669; c=relaxed/simple;
	bh=+1031/BIuu5w5bmwZL7zvmLRDc1207zloVWZ3ZrE3dg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KMzOdQo9TiM9AuRR5uTlJlXaszU5u2aom7oXLOiDUQDLeFaTV0rx5T1KglpV+1+n5QS6TqwHe3PJTA6iilvm0wxCRH2CUx6hwPqI+nbr8sqi75lhVweP2G/GKi6U93ceSsw5KYHUHY+D/Ku7yjbRMmfazPEVRCORALe31JeUrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNNVqHo7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNNVqHo7"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d6b9bca48so23801991cf.2
        for <git@vger.kernel.org>; Fri, 08 May 2026 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244667; x=1778849467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EYIRILD95+N7j7AcrhJBblz2+6G7Q1uP61NTL0mcDY=;
        b=YNNVqHo7mh5W6hzZGQSjqPQurW8QJZ0tS+DDkgN5z0MEyPDcT3ZS7P4qJx19EgRj25
         Mhvjd7AZH57FP3qNiBKuQpCeBU7xDLQrmhvvydWBatvwEe+RDUP8jGEHTp4dAtI9IC72
         u3WmnKU1poq/lLU5sstQPTsN/RMxG2rGqZXn86819hon0RKpf/qa6R35xflg5QgjpN2c
         CUPDMEYcH37ysmoYzjL/rjmR84ma6pUiWNmARDQYayX2XWYAczmGcVcvZ7SyPuM+/O3m
         b1+iJ/5Njs64n4XBm4TEsL6fY+igi3lBij5hXFbZNwrqJfHcuOVybz26M+Qmfh9b5Wft
         zl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244667; x=1778849467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EYIRILD95+N7j7AcrhJBblz2+6G7Q1uP61NTL0mcDY=;
        b=BZFAnANaVzYVlFkz6S8AduZoowM1sIRLPBlQ/plCCywW6OL0I1rvH8fAKSBYYEkt13
         SjNOQ4WiM7m4D5hrqArAVi2ZyviRClIrJgt2W8gUD9nrTvL6BTC8wYL5AXsXvesTh9GS
         XfeMQ12oZAKXJnCJ5kh3JmGpGX73MVLae1vJe50lqtiha266Vp9mE4Cp6dN2t7XL1Ty3
         OUM3F5tMZ9iw7mntQ7Xpw+1VkeyrGwLT/U1A4vdvABomRH1Ft0Ypwuty0oaitsdGpMLF
         oRj45oB1sJXfz0yFwsUcPm2d7aVS4km+z1duwVW+r+7KdnSu8D1H7GjEQrTOGbVXIkFk
         dnpA==
X-Gm-Message-State: AOJu0YwAmT6LVAhVAogtA5BPDJsIfPFZwgkzQd30xPhkbDkTFiNSrXNQ
	THM13wEcpQoF2ic3w8gkiRSOMWDfRd4Fo3bUgu7Cp5JnGxPu7amM181jq8mbxQ==
X-Gm-Gg: AeBDieuYNDWp2QnelkLtoeDawRiwkfRXab5c6Qkioy8E5zHYY32NAsSK0oL/14Omaz0
	VHrYv6LWFTIF5wD1I/jnLgq7jqh22YSL3GGFp1Ylaef+RCWAsVtk50sM4w/VcoQVn46kZ0+FisM
	TyXy5ITOVhv+0xc9CM+nWusKcqmQSAshx0v5f2s47DGZE1opKCQPcjQEcta43HBkdI1TfEHH3h+
	cqBHgZx94XLDCO+DYyAWM9SZn7I9NAm+tUuleUrL8R7SvHsDo7WeQMK4YTB24aO9DsaGL/VSZiK
	UQU+55kDOB56jcWcNC3+k86JMmYVkMudm/SRKZ3d8RmoUVZ3o74Nn+N+2r9WOF3tx9F1+ToLWl1
	bCjaEdAW/NdPyMStlMLmNeKlmFVed5cPMyTTM38r5CQT1C6IP7hScd6JkwHitOjsXdN3bzOz/2+
	+HtrQITPKhaX46Qoj+15Q3aCj0puuV
X-Received: by 2002:a05:622a:6096:b0:50d:7f4d:93cf with SMTP id d75a77b69052e-51461bdb40cmr170744691cf.8.1778244666770;
        Fri, 08 May 2026 05:51:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.176.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e6336c0sm16974491cf.2.2026.05.08.05.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:51:06 -0700 (PDT)
Message-Id: <7b5daae659f491ce8a2ba52d02ba7172106120d8.1778244661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
References: <pull.2104.v2.git.1778169613.gitgitgadget@gmail.com>
	<pull.2104.v3.git.1778244661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 May 2026 12:50:57 +0000
Subject: [PATCH v3 2/6] mingw: drop the build-system plumbing for nedmalloc
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

