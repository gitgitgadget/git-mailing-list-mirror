Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED39A2DE708
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530740; cv=none; b=AYmp1d37pFm4sv/bq7YV/mk8oiUfJp5JdcmxKsxK6I6kGbyOplYitcSPP4dIXi44wSlFk/NikY0+OgkKhztmdghkgKayKwFAepbBL+iVklQwpkvO87VZ/eIFU/POLQuTmOtRgSb3OzUZRoG1yAP6AjakIM/2tvrzWy09C/BKzYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530740; c=relaxed/simple;
	bh=4NebW/EVn6a5tg9sdCD3ybtczTo8y/T/TAnmuJHFrKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9SB0jLklJp5gJz6Q9q0O1BnaZ9asOWx1cXGZajxLnni6cV/9KzlYMwJ9VJFBwqbat+bpdfOBvDVij/uwid+cs7suIoAXdAmHPy/vJ127IOiQm+z7N5/NEnBrvsxPClV89wYHliPJMX5aVDYlRPwfxssZgIT933ekQl4IlL8o1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KTw8hKmm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KTw8hKmm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cfb79177so46421365e9.0
        for <git@vger.kernel.org>; Thu, 03 Jul 2025 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1751530737; x=1752135537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dJxwRedniM1F+KF2l9ErXMkWca5D1KaiOoxs68Mqnf4=;
        b=KTw8hKmmuyqA4ryZfekBhHQn75yTdnT+3k/AUrnF96MWZ2cYkWZXDrH3YJhrAvOoVr
         yZP9J1nRmyh4cYAwM8r30oNiOMV2ZUNy6SL7c/k5TQMGi8JVyfYUmYuv5z6hKkBsTBo4
         8lEPzsI3p8JIROYiIbFAOdzeAxSGiEYQn7JFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530737; x=1752135537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJxwRedniM1F+KF2l9ErXMkWca5D1KaiOoxs68Mqnf4=;
        b=IXt8Z0oDxK1IgQujg0kGldbFFHWI9heRX1McqS6Ku3EbgNIYiAGDUg95Et2NivTJUY
         MAL69ZC7GkV1VYQ8Rl9Xj49AuwvtYEamo6hAC2i6F91TgrDktbsoPPEF8dPXw4hL5vjx
         qEFfegWW+exAuFsUwdh6t+/W8T7CFvtx/3C+aVdXmlAK8hAGy4Id+yx8XfPKKPFWejAY
         nr9DHX7ZOQjkkftUT2iLlCFoaCRXyA4J7KOQfkaVQ0H3tgzi+l5eT+OeRkGMrq3DvQKp
         IlUBOQBM96f68Re2rd1zdXEGo7fxh0++XkSyplfIJ1wTWub1BnfYCFS101n1nmYmcdKR
         CfEQ==
X-Gm-Message-State: AOJu0YzkmZh3flxnN+24yPDlDRW7s5rJGuzMEFAGklRjEJEAsPo2mBkq
	AXZazmulrzKqZo4sy2nNviXp/89H+Q1XbvldDZA9b8Iv+legJPNL3T0o3oN6ldVL/m6YaT2oH6Q
	Rg7Po
X-Gm-Gg: ASbGncucCzmlVG+QIio4Axcd/rBglmNoeLlxr8N9o2jRs5mKVmYew61qNKKOPzgf+vX
	3dfu381uGwgwk+62Bp5e1lfnkJ97rKjITjIVzlVG31KjxDQR4Tn05E6nIJAfUs8JUCXWE5FYgQt
	iFm8cKPldfhRDhOr1HRQx2z2+D+kdtEVNAxDlRJ98z9QCKf7RBe9Nhg/E6QzbNin1F1h67lhwvq
	5aBlzhuQC1g4Gf3jjvCozl2DoWUNHCrwE8vKqmvZTkKTVJxIReEaFvBTdmewSnd7WWboY+NxqZG
	ddl9qfuFhz+OfVlQTaILBC8n+QjKIQTlgYn5eOwoXGzfVM2PPA8aj/UjKnJxDL9kJMIToY1Ymsq
	dPiejAy2IUEMdhvqSVnRyPt/LoAUg3fLrSjdt4lU4+W3weScqk8ZJSkwiiLVyEprUuQ==
X-Google-Smtp-Source: AGHT+IEl5uZsblwzZu6LPoAGCjCDKXF/sJ/z9OcnYjdUCvYypQAlgw6MKau/VA+POtJJxjkOZ+GzxQ==
X-Received: by 2002:a05:600c:8115:b0:43d:fa5d:9315 with SMTP id 5b1f17b1804b1-454ad209a7amr9942605e9.33.1751530736468;
        Thu, 03 Jul 2025 01:18:56 -0700 (PDT)
Received: from nomnp-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2a01:e11:5420:5c40:9846:5f60:fd47:f869])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9989328sm19138895e9.18.2025.07.03.01.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 01:18:56 -0700 (PDT)
From: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarulasolutions.com>
To: git@vger.kernel.org
Cc: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarulasolutions.com>
Subject: [RFC PATCH] blame: avoid failing if ignoreRevsFile does not exist
Date: Thu,  3 Jul 2025 10:18:38 +0200
Message-ID: <20250703081838.190603-1-francesco.nicolettap@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting ignoreRevsFile globally makes the blame command fail in
repositories that don't have the file present.

Check that the file exists before trying to parse it.

Signed-off-by: Francesco Nicoletta Puzzillo <francesco.nicolettap@amarulasolutions.com>
---
 builtin/blame.c  | 3 ++-
 t/t8002-blame.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 944952e30e..e4236f0ebc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -868,12 +868,13 @@ static void build_ignorelist(struct blame_scoreboard *sb,
 {
 	struct string_list_item *i;
 	struct object_id oid;
+	struct stat st;
 
 	oidset_init(&sb->ignore_list, 0);
 	for_each_string_list_item(i, ignore_revs_file_list) {
 		if (!strcmp(i->string, ""))
 			oidset_clear(&sb->ignore_list);
-		else
+		else if (!stat(i->string, &st))
 			oidset_parse_file_carefully(&sb->ignore_list, i->string,
 						    the_repository->hash_algo,
 						    peel_to_commit_oid, sb);
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 7822947f02..24010f544c 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -173,4 +173,10 @@ test_expect_success 'blame with uncommitted edits in partial clone does not cras
 	git -C client blame file.txt
 '
 
+test_expect_success 'blame with ignoreRevsFile set but not present does not fail' '
+	test_commit A file line1 &&
+	git config --global blame.ignoreRevsFile .git-blame-ignore-revs &&
+	git blame file
+'
+
 test_done

base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
-- 
2.43.0

