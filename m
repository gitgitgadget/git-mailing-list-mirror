Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375FB21256C
	for <git@vger.kernel.org>; Sat, 16 May 2026 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778893260; cv=none; b=F37d/1Gn3VVhC7to9KyaSn8lWSGjPB4izGbrKglZCMfP8/xEeXdf2MdMUMtsXz55uUoO6Micm6J3iv3o4eSoKSh6XNqOE5/zIyZosEo41+1a3ULToS4Gp2RXxx+sa/k6XMUkM4/Jwu3Irp2FjJ78qiC/CnsGRFnYW8cb5bTmwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778893260; c=relaxed/simple;
	bh=951ruRdpMyMBfQ5ZCZP6Hhr90gYtXUp/yUfNyNv9dRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y3fPcBdt3t+DjQXIFatwaYcLb3RNdyAKXo+Lum2IQONJqTpUCA5Eq6vpBNEO9Qa+O9nTjiNDRYYhigsiGUcuVlMGJYEkkiYA/5eb5p8uh7d0sSreXfZ0LW5UzsLWZ9ZNKDTrAC6F7w44jgexGGJTvE9BBISpPG2zudoeAaaIkuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0FI1ISu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0FI1ISu"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c5d8f45465so504817b3.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 18:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778893258; x=1779498058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r08TUlztwCs8x8DH5nUPyi4+0/TIChAeCcLyrWsdSr0=;
        b=o0FI1ISu1Ep5ruVfdu75ZVMzLwdgJBrKscyXhC/9TSsG6n1O36Pd6vPWvMvJ9+mZre
         zJkoXsZ6RXJ8YS5VojbWz0QSdQVNMoXlDWbpNaDudUhZQf+KH4FFhtF24wK6+8fjW9oi
         LesvCe2TedFyZ7iOCoCe/aXV5ASaFrv4iBLMhIH8R9bNE09U0CgzQsyfyaelV/kTNLxY
         Ndi+q8mDvw6NXm4anJD/CjFi+9byerVLCb+D9Qnvr8toEG0X8UzL/z09xPkvnkMCPEX6
         hoGRUMI7DSXqr4iKtSyqEn7PJYy1RKd/lUm1KXiO09hpbdFTJghjs7IREg8NNLetJjnK
         36Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778893258; x=1779498058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r08TUlztwCs8x8DH5nUPyi4+0/TIChAeCcLyrWsdSr0=;
        b=Kxm7HFz9JqMWVk7zQ5uUJD4DBL2azvrL7R4quBWPlk+C6b8Wpj+h96RsLXfd1HlGR1
         B4FOao48/I3QqiWCreJh721uqcY+X2zekK61xDLqtN/uYzz72DTpB3/joP/NsTl5JAIY
         VrpT1a/Q6q8/X6AyrP/YWRY22wBhFOvTzGiV61vxZwwmNJnQ+0WuIivCtUXrv/nI8Tgh
         7U/knV16018nVChAUQlQ/jYJEmOUeE3WhUcjiTlC5ol4y8wFHAW/GTbsKBetxM1845xN
         0+PTBz4oaImyvhN/VN8feSYZXiAekj7VWLGaI61un4+p0bAL7iPWeWkOVUQ7imwwVUcx
         i1Sg==
X-Gm-Message-State: AOJu0YwDIsSk9PfLSjnopUKZoMq1kzkJ/m97wj4ot+T5gCVn3JlvKjMS
	v9LDH0TTmQiTDht34c/LeqNDly19Toh1Vmc/UBBFbvBF/ZcSm0fPrniIDn15a+64
X-Gm-Gg: Acq92OGrdLQk0m2/uCS9dWWWjoP5R4YgPUWybSCy/GKjPTvibrkS+Ud0EBtsBM9RJl2
	HRKFIAEc7yQo/njkraYoYk0KPoE1XnlcLbY6HfDfib0OcYbMGPH5Kr/0PdTlcy6mmZIaxUr8Xuf
	v6+AEXs0VFaoR8/R/GC+x6nlqMZpTKiyGm3CWN9BlN2R2MFAUxwa8R/e4coDzzLnH3AZ+xpbsQ3
	gasfUHRF3WER0Tdw3l7cNt3uol67egSNM/oxzUvjOXNg2xv8mZyEpD8EmNyx+wu8Ou4dCmssg8r
	XfHm59sWMu6zm5bHlZS73JgkjUNR7K6C/v/E9Ysz+GlUiXKNTaBZIOUCW4gHUpGxV15kqyqGv+Y
	n0F+4zvLNJDdON1YHVhUQtbt9DBV7e8JnkbusW6/OC8MraDuAbKwodONSsvi9nz5N6cbKquExzz
	8BIxRgSE6XtJ9GgXdyLSVcGgyb5xaEG+bzcx2CzLq/u5RPDczmgI8ldzClQsCU9g==
X-Received: by 2002:a05:690c:921a:b0:7bd:5c7d:4b15 with SMTP id 00721157ae682-7c95a56fd03mr59361067b3.5.1778893258100;
        Fri, 15 May 2026 18:00:58 -0700 (PDT)
Received: from localhost.localdomain ([24.196.231.228])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f28b810csm36904917b3.14.2026.05.15.18.00.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 May 2026 18:00:57 -0700 (PDT)
From: Clinton Phillips <clintdotphillips@gmail.com>
To: git@vger.kernel.org
Cc: Clinton Phillips <clintdotphillips@gmail.com>
Subject: [PATCH] Documentation: fix typos in user docs and release notes
Date: Fri, 15 May 2026 21:00:56 -0400
Message-ID: <20260516010056.94508-1-clintdotphillips@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pure typo fixes, no semantic change.

- RelNotes/2.49.1.adoc: "updates to to Fedora base image" -> "updates to Fedora base image"
- RelNotes/2.49.0.adoc: "which turns out that that the object" -> "which turns out that the object"
- howto/revert-branch-rebase.adoc: "I happen to know that that merge" -> "I happen to know that the merge"
- config/bitmap-pseudo-merge.adoc: "psuedo-merge" -> "pseudo-merge"
- technical/bitmap-format.adoc: "included in the this psuedo-merge" -> "included in this pseudo-merge"

Signed-off-by: Clinton Phillips <clintdotphillips@gmail.com>
---
 Documentation/RelNotes/2.49.0.adoc            | 2 +-
 Documentation/RelNotes/2.49.1.adoc            | 2 +-
 Documentation/config/bitmap-pseudo-merge.adoc | 2 +-
 Documentation/howto/revert-branch-rebase.adoc | 2 +-
 Documentation/technical/bitmap-format.adoc    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/2.49.0.adoc b/Documentation/RelNotes/2.49.0.adoc
index 494c8309..35684515 100644
--- a/Documentation/RelNotes/2.49.0.adoc
+++ b/Documentation/RelNotes/2.49.0.adoc
@@ -118,7 +118,7 @@ Fixes since v2.48
    placeholder signal (e.g. "--option=<value>").
    (merge 5b34dd08d0 as/long-option-help-i18n later to maint).
 
- * CI jobs gave sporadic failures, which turns out that that the
+ * CI jobs gave sporadic failures, which turns out that the
    object finalization code was giving an error when it did not have
    to.
    (merge d7fcbe2c56 ps/object-collision-check later to maint).
diff --git a/Documentation/RelNotes/2.49.1.adoc b/Documentation/RelNotes/2.49.1.adoc
index c619e8b4..697f0f22 100644
--- a/Documentation/RelNotes/2.49.1.adoc
+++ b/Documentation/RelNotes/2.49.1.adoc
@@ -9,4 +9,4 @@ notes for v2.43.7 for details.
 
 It also contains some updates to various CI bits to work around
 and/or to adjust to the deprecation of use of Ubuntu 20.04 GitHub
-Actions CI, updates to to Fedora base image.
+Actions CI, updates to Fedora base image.
diff --git a/Documentation/config/bitmap-pseudo-merge.adoc b/Documentation/config/bitmap-pseudo-merge.adoc
index 1f264eca..a0604a41 100644
--- a/Documentation/config/bitmap-pseudo-merge.adoc
+++ b/Documentation/config/bitmap-pseudo-merge.adoc
@@ -88,4 +88,4 @@ more useful).
 
 bitmapPseudoMerge.<name>.stableSize::
 	Determines the size (in number of commits) of a stable
-	psuedo-merge bitmap. The default is `512`.
+	pseudo-merge bitmap. The default is `512`.
diff --git a/Documentation/howto/revert-branch-rebase.adoc b/Documentation/howto/revert-branch-rebase.adoc
index a3e5595a..d56dde64 100644
--- a/Documentation/howto/revert-branch-rebase.adoc
+++ b/Documentation/howto/revert-branch-rebase.adoc
@@ -27,7 +27,7 @@ $ git checkout -b revert-c99 master
 Now I am on the 'revert-c99' branch.  Let's figure out which commit to
 revert.  I happen to know that the top of the 'master' branch is a
 merge, and its second parent (i.e. foreign commit I merged from) has
-the change I would want to undo.  Further I happen to know that that
+the change I would want to undo.  Further I happen to know that the
 merge introduced 5 commits or so:
 
 ------------------------------------------------
diff --git a/Documentation/technical/bitmap-format.adoc b/Documentation/technical/bitmap-format.adoc
index bfb0ec7b..59859c80 100644
--- a/Documentation/technical/bitmap-format.adoc
+++ b/Documentation/technical/bitmap-format.adoc
@@ -338,7 +338,7 @@ the end of a `.bitmap` file. The format is as follows:
 * One or more pseudo-merge bitmaps, each containing:
 
   ** `commits_bitmap`, an EWAH-compressed bitmap describing the set of
-     commits included in the this psuedo-merge.
+     commits included in this pseudo-merge.
 
   ** `merge_bitmap`, an EWAH-compressed bitmap describing the union of
      the set of objects reachable from all commits listed in the
-- 
2.49.0

