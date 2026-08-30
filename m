Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19F264612
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788097362; cv=none; b=MHx9pZjqfxWTXM7srm1XlOPAzptA9MzxJyji/cPBklTb1NOtBuqHjunfZrIFPynLtZoa1hTyxWWt9wRw+Ue+JeBAKXqFQBQ7w7OgsVde3xUko2+PxvYEI2K8/v431A1ro0RiD0jW5G++avEiiArr+aynB08WRDxiHsBRY0XqxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788097362; c=relaxed/simple;
	bh=L2byxbzfmgmztf3oWpX30QeO6F+tQrk9HtEtC12w6m8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VzI0VXrvxV4fSHkbYLjrbhkNBQn7Momw1IULGAaVE2gbIz7ZMU+/s6p+LTUgCmZpeoAGvhLWBE7P5LW6IIEfbvXVtgNccUCgFCICaG4lVGcPylyhMXyLwjgWtMsMCGvEdbmlE6h2o28UPEV/T6LXptGURUXMW1h1uZ5sIPPb0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SatyLDIk; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SatyLDIk"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2528537a91.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788097360; x=1788702160; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KaKZRwMv4zPn9cdnYxnOv26qIcXwsxizXNA6AZMYhns=;
        b=SatyLDIkbhgxBvkFytwxsLczkDpsnSLCukKFXBZ7UOLVGuIQOHEV5RG2t8LMDDyVj2
         eLW27XCPU20biILY2IEzl1Ox6dnBXi1iK9Mu7VHNVcHuv6TdK3tRf8Zr1t5wUsUzukh3
         aZJyzPsmIbsUNd4KsVHE0cHApX2r/yHFUYLk4o458tJ5KyLAbsH1uF8rWlS7BfTA66d4
         4aB1D9d2+Iq6ybB3pshSZF6s5OLkw0O35ycsmPpr+396Sy+5NIdk9W79Td12eGBBFVwb
         L530N9k1NC+tMgVdV7LajKPPtNe1dfRy+wHH28HXOm9a3gIER07dwSnJg+xDDqgcLGwF
         sBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788097360; x=1788702160;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KaKZRwMv4zPn9cdnYxnOv26qIcXwsxizXNA6AZMYhns=;
        b=Un8Mov9UuKvH/A9G62YjfaxMLTgI4/Rwnrk9wBaA6b1AhdQtF7koC1zQybbwN30aj3
         0+WEwJ8xeu4hXAXpTkQ+DQoNY04CrIroXBKnGQkX6Syqm2lAm0zRgl9mc+u4ONJnlNoA
         SLgVZbxPSDMA9EegPahdb+kGUi1YBRVKTx4pZaA3ctP8JQwPLFYEawl43s8vsJsO5Biv
         Z0UaMJIEysxCqvEru0BBB6HtGJT3Jb5Nw5QWSBZC37UVPlgbQFVlDHStmWeU+45tT37R
         U9LMg4Dvh/25c+GjWl/Q8U83vlt8DEWBtxD3Q7NpcNSE58pnnbteZ5EPu+ZgOLpPVBGZ
         vv5A==
X-Gm-Message-State: AFuF++mWwEvTQG4w/7jJbCZmDCtJYOTNLQW9YATZYMaC6U3k+28PDY38
	sgeJcGZMqYU09ywFWx2jALlbef379rwCyGYA23ULaGeX7QhNzWiXbCJQKHxXRw==
X-Gm-Gg: AYBFou1XqqOqj4jg+3AI+ZHFQI+y+nnPhuIfKXTKJ5kEhbHQ7q+4Yi5BtoSzlM3XVdO
	Gta5m8CMhgOlpGNs3+VwKGd5gRD/hYjSyFreqNoT/UfqwLlFm96LeLZXcEQQZDgds+nFSPK6Aw5
	UPp7tBOXKjYtL8PGdsX8iHTUMRvWlIIA+GDxCSFF5pfOX3zxUdhlixtcAc9318GPsH/BVmubROp
	1dymkPYwNHFvfWzedajLdgHMZ8JXJt+BhyJRG8vbr9sQ5r4/fOXb/i5r55OpvR3GJKkJ5dGzHXd
	K4/9zRMM44qIU3keqf8C39JF7Bj8LHtcggQ6bkJhKb+JYY1k2YRO3c0J2XP0jKHTAmHVwCmO4b5
	1eu0W29DaLx0GLt9LJgiwPrvIKHfsxOTUYKVMD/z1tpWF05bpq6pFHh9Tj/tA0BoHcie86Z0iI3
	bYb46MtIFBgWs8F9NgRhBYaDZiziJu6GAwBamNs2AZ80oDuSjxoyeU3FoHtkI9vaRzNw==
X-Received: by 2002:a17:90b:2f0f:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-396d0d92d15mr33698379a91.3.1788097360400;
        Sun, 30 Aug 2026 06:42:40 -0700 (PDT)
Received: from [100.87.176.22] ([112.133.220.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm21729689c88.10.2026.08.30.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 06:42:40 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
Date: Sun, 30 Aug 2026 19:12:35 +0530
Subject: [PATCH] typofix: fix spelling mistakes in comments and test
 description
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-typo-v1-1-d397c8dfb301@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2MD3ZLKgnzdtNREU0sgTjQwSlQCKi0oSk3LrAAbEx1bWwsAmHsslFY
 AAAA=
X-Change-ID: 20260830-typo-fea59ea5a02a
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788097358; l=1725;
 i=hardikxk@gmail.com; s=20260827; h=from:subject:message-id;
 bh=L2byxbzfmgmztf3oWpX30QeO6F+tQrk9HtEtC12w6m8=;
 b=/JPnrX7p7iHuexD4uGPdzQMdQfE7cQ4Q7xXHs8PSqRHwFdatFfFheIYK9cDx3pdszA3BvaNvr
 vvqJEk87CnnByVLntmTUI9237OUj3dDfQ/WYuT+t3HQy1yS5XAUMerv
X-Developer-Key: i=hardikxk@gmail.com; a=ed25519;
 pk=56yFuFlLHAdRemUZghoGHVCijEX767atrut3dPD0thQ=

Fix spelling errors in the following places:

versioncmp.c:           "fractionnal" -> "fractional"
git-gui/git-gui.sh:     "occurence"   -> "occurrence"
t/t0022-crlf-rename.sh: "similiarity" -> "similarity"

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 git-gui/git-gui.sh     | 2 +-
 t/t0022-crlf-rename.sh | 2 +-
 versioncmp.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 15dd2b3a84..cc8a05517a 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
 	if {[file pathtype $p] ne {absolute}} {
 		continue
 	}
-	# Keep only the first occurence of any duplicates.
+	# Keep only the first occurrence of any duplicates.
 	set norm_p [file normalize $p]
 	dict set _path_seen $norm_p 1
 }
diff --git a/t/t0022-crlf-rename.sh b/t/t0022-crlf-rename.sh
index 9bd863a970..328c6e5903 100755
--- a/t/t0022-crlf-rename.sh
+++ b/t/t0022-crlf-rename.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='ignore CR in CRLF sequence while computing similiarity'
+test_description='ignore CR in CRLF sequence while computing similarity'
 
 . ./test-lib.sh
 
diff --git a/versioncmp.c b/versioncmp.c
index 3a81b17bc1..f1e451755a 100644
--- a/versioncmp.c
+++ b/versioncmp.c
@@ -15,7 +15,7 @@
 
 /*
  * states: S_N: normal, S_I: comparing integral part, S_F: comparing
- * fractionnal parts, S_Z: idem but with leading Zeroes only
+ * fractional parts, S_Z: idem but with leading Zeroes only
  */
 #define  S_N    0x0
 #define  S_I    0x3

---
base-commit: c73e85354c275c9d409b26445089bc16940fc527
change-id: 20260830-typo-fea59ea5a02a

