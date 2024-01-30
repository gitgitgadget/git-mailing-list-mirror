Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB805914F
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 08:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604803; cv=none; b=D0l0bQDtHc7gCia63x+H8cC9eZ+vuM37xrcTlu+Zhwh1VuPFsGMv84MemptxHOpHtKSZQeVvI1Vt4H/ZUJhg5gmZC6peSKyZvC3G3irQ16sr6+ywpityo+g2uyPIAwNfoz8gRC22PIkHV/p8J5wP8VBQnXKENEMez7NYv+Ff7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604803; c=relaxed/simple;
	bh=SalBpUFKv5uEkaletforTEJJ6NbCBcST4grHagE3llU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YjK7tXjd29oqpVE7QCBymI0b9UutoB1TZPwBLUrkfmWmCeB7MxQsN9Olo3F+PSMFTCDVxnj7+jS6H1g//HSyziXSRNmxOm+kmNZ8A8uV0/lCjqAse3c0dOKmOEJyg97+zzCujnSY2NS6wIC/9CCtoDAukIpTu2OY4amEHi7fCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANrVD2Wt; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANrVD2Wt"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso50675745e9.1
        for <git@vger.kernel.org>; Tue, 30 Jan 2024 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706604800; x=1707209600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbXMWkn0db7t+n4oJKUqtgIyP6Eh13OW81Zv9cagBtU=;
        b=ANrVD2WtGmXUoBjo8i7TB7+kyC3Nc+7ZBxer1ksa6c2KXfoCra1dKF0+E4r0OVCgV/
         CUkr7pzj0Vv08cOsLEsXUJB+LdAKTfRODwjg2EAqao4z+iL7q6NCcZP1W0WTcE8VuR9o
         aGMXVEwk8pFfNF+oW73iIeNGTusnN5hHaHXPtrok0fG8RFXn/KjdV1zSiG2f2sGeV47h
         17ZIJidQiN0clcQk//hfQqNq+u5u3Ta5+gifM79GOUFcSkTZUfrF5T2kz3ax0ewOzNwX
         YX/PD9sdlX+NlVHMwTow28rztfRN4VRiUPEwItcRnSQGXKYtjK0BIif+IZ/VZr8IlB+9
         /Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604800; x=1707209600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbXMWkn0db7t+n4oJKUqtgIyP6Eh13OW81Zv9cagBtU=;
        b=C41Z2+LtQ4Y0S3nqZ7eXyC5PZ3aBhyu+6HH4DhaVVr+PTkbWhzMG+Axr8dLLlpPFEk
         GIWbKXE0hsBSArVlxmjocUpuKAYUyo61DOOh3bsXNRZc3UnJuksV2M/Dv+YBRpDcrQCx
         eIFZP46s8YD4yK1VwWdmbAaFvp0mIrcpIPDxol/9uV58TmSk7O94ZdoIag/0K8kTICKF
         cT0Y7utyTD/8ZwkbwfCTcvCxBj8Rkl8bSL5IsECQgTCXHrBFvzx5AeHucICtxHvDeB4F
         iTtq+NxVB/VxUso8Bvc+fxYT528Fr6Z2QR1AsMr2QyxhfgTy1dKAF2GcScmVl73D2Wj+
         N5wQ==
X-Gm-Message-State: AOJu0Yzz99fC8iNz/4l+Bn7mJ6jdtMZDZB9cAuT1iSK8HyfrybgOwMoH
	hYYxFOoddsnHNprhNx4PwFLSf8RuQjkYFQAp5h8G63mZAQoe6/umPoAQIf/5
X-Google-Smtp-Source: AGHT+IH7zH++dQ5yf9ANG/b2beRo/ebyP9P59+ZKzASNMZKBZ9fk7xQ4oWF6BV8mZ1dFcvSzBlXZHw==
X-Received: by 2002:a05:600c:1987:b0:40e:f536:cff2 with SMTP id t7-20020a05600c198700b0040ef536cff2mr5879505wmq.2.1706604799935;
        Tue, 30 Jan 2024 00:53:19 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b0040efcd70cc2sm1573759wmc.45.2024.01.30.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:53:19 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Denton Liu <liu.denton@gmail.com>,
	Paul Mackerras <paulus@ozlabs.org>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] gitk: add "Hightlight commit name" menu entry
Date: Tue, 30 Jan 2024 09:53:08 +0100
Message-ID: <20240130085308.5440-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When working with diverged branches, some patches can appear several times
on different branches without having the need to merge those branches.
On the other hand you may have to port a specific patch on another
branch you are working on. The search with a SHA1 cannot be applied here
since they would differ.

This patch adds an entry in the main context menu to highlight every
instance of a commit.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 gitk-git/gitk | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d..4b15230a16 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2672,6 +2672,7 @@ proc makewindow {} {
         {mc "Make patch" command mkpatch}
         {mc "Create tag" command mktag}
         {mc "Copy commit reference" command copyreference}
+	{mc "Highlight commit name" command highlightcommitname}
         {mc "Write commit to file" command writecommit}
         {mc "Create new branch" command mkbranch}
         {mc "Cherry-pick this commit" command cherrypick}
@@ -9002,13 +9003,13 @@ proc rowmenu {x y id} {
     if {$id ne $nullid && $id ne $nullid2} {
         set menu $rowctxmenu
         if {$mainhead ne {}} {
-            $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
+            $menu entryconfigure 9 -label [mc "Reset %s branch to here" $mainhead] -state normal
         } else {
-            $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
+            $menu entryconfigure 9 -label [mc "Detached head: can't reset" $mainhead] -state disabled
         }
-        $menu entryconfigure 10 -state $mstate
         $menu entryconfigure 11 -state $mstate
         $menu entryconfigure 12 -state $mstate
+        $menu entryconfigure 13 -state $mstate
     } else {
         set menu $fakerowmenu
     }
@@ -9481,6 +9482,22 @@ proc copyreference {} {
     clipboard append $reference
 }
 
+proc highlightcommitname {} {
+    global rowmenuid autosellen findstring gdttype
+
+    set format "%s"
+    set cmd [list git show -s --pretty=format:$format --date=short]
+    if {$autosellen < 40} {
+        lappend cmd --abbrev=$autosellen
+    }
+    set reference [eval exec $cmd $rowmenuid]
+    set findstring $reference
+    set gdttype [mc "containing:"]
+
+    clipboard clear
+    clipboard append $reference
+}
+
 proc writecommit {} {
     global rowmenuid wrcomtop commitinfo wrcomcmd NS
 
-- 
2.43.0

