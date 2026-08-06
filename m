Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9E42AFA7
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015361; cv=none; b=TNZ2jspY/gDd/zHDxexGit+cuSgRvBOfSIKNIX3vPj257wehCIFY2oQ+05Nb3xkYIyZY3iyp7RlgFvmM/U/S3qixsWC35UPQuj+B+NLa0jmCsmzXQHz+9C3ipYFwj5A4Q6J/QSfvqVAOfhfUQ8I+5jAiEkLSSKJB/1V+VqFX/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015361; c=relaxed/simple;
	bh=Qse7PaOzQJIhtzxdo/rx1UeQZDWSB22UfQQ+q0I3zvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRBDpbvpJ/AgYv7MuVrqrMqaamxiUFPZq8BZwQ+OK24tqnAzR+f6TSDmUxqSHRbNgMP/PZnZnXf8s16ZKxkfn3286h3g0s/Z98UpgdxMRCMM2ZtX8VmqSe/3ywGN00ubYY1kC00Um1buehbP9LjE41gSQ4jpxp768I0icatUbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhDI6ZYO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhDI6ZYO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e7109321dso1382812a91.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015360; x=1786620160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAnwb0ostPjE+9QGc7bPn9abTh9gHGmhBYoFx7R67tA=;
        b=YhDI6ZYOJi3pjOiYbVXHi948WrBS69MZDAm9vF5LsNzbeATl6wZeK0F/GulUZuM2qr
         dKaq+ZxuOuZz3NIHlMrSn2a74SpAdX23QEcAhhlFBqsIP+iX3vlspoP2ZuR8bEWyrmvX
         LIe5O87/BnabhHJ+CtwvKx4vTrXRpP6uRjbZzuS8eT4SCLupbBaIAB4glzxPNY8KERdk
         NJAo+mwx2O70G4D63m43JcGLD6bCxdY11iha0ZSGa665yfn9Gb6a5BBLdY6Ulm83O3Vi
         Rh++BaMwjrQJt87SC6fkaJvYhoZy7CLIWhA/CRt5+GIESzDFdoJWnpo6TDFboLQXJqw5
         yaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015360; x=1786620160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAnwb0ostPjE+9QGc7bPn9abTh9gHGmhBYoFx7R67tA=;
        b=dzWo/pU40c5SQ9qlDCtefB1PDS3JVJVUj6GzqVgOcgpEV9EthhXiyWQsWakRERGp0r
         /yNGRQFzoUuOxHKAPXJajOJVNKcS7D/Ab3nYvkX+E4g5HERo/DhHpH+mfPh0IjhZW9Ps
         67U7tFsQPdBtiFyFDm6qnOkvabVRZ/Mj6Yt2E0oCBkWiUrIjZPBppS/op7DTtvX2dCEh
         jkGuoRdBI9Po2+YN0sBdBW94iwdPqm8ROyVvivPKiCvJHpEi+kem9nF2/37PrwGMy8PN
         NwIWsy0I4fQ0CPEFcztkuB+SxucdQ2xXhKEH7ETMs5YJsryOADKH5vnGOKJZIeet6Sg7
         E2Fw==
X-Gm-Message-State: AOJu0Yzw/XIvI0/JWi6p+G7NhXSCdAlqrW7Nfp/kKBGXT03W3SZD8dw3
	Ahd2KkQRO9uQG7iRE4OGqcjTCRK/Si2OT/3J6/KG2XYeHmmLvFBZsXXNTV8tLd6p
X-Gm-Gg: AR+sD11fn312F9wzkJ9wzHcNJ60hjc5HfBk4O0wajXKkEIZHT4Njmenk+nFxZI40BRz
	EFBK+Ik1JlZCfjfXpTq7yrBeXflZ8K1NaODmZ/aTb/TFnpSvxItJunbIqFMRLdORwl/Ahc1dN6l
	L5nMnz1G2GqW3dBcNqpFTXe51rBCpXl9YB+bJbOJi39VcY8yPsOSudHHX2Ch/b61k/nID8iAlkX
	6Y3z6pI62CUnCxzwfWE2TcyCZvf54spDwJZmv61sfDJRSpGTmOyoRYZf7uM3YG+0OPAlWs/CVZx
	yGBcDyuUEV3iVemTVU3VWfIW+x5JPb3Yn18Ykuvs2cZakDHP+4ZdhmpAo0lzQ4WsaXQgD17eZHi
	0PUlwcrSAFbE4MoXeZrKg41p2f5X0OxCXfUSe+bfvcH8X9NPz/YUWOhYQ4y89+sbxwItAU5ZWYD
	LYM6qrFur8dEMGPCwZMgrOsgqg4nIHXXYkk6TTSOqIJripuJH3e1AVRh5Ut18q1YGpZF03S15FH
	L/91Jkcth23mVIX4OHByDCty8bGTrJ0O6aonyGXR2p9S3LAc96wAhJH46/YmWAalVAsNDnNkq2a
	FkCUTwiPRoLYzEhQYRQQI5Q=
X-Received: by 2002:a17:90b:3c84:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-3903c54ac31mr14852154a91.8.1786015359750;
        Thu, 06 Aug 2026 04:22:39 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:39 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 5/7] builtin/repack: actually drop filtered promisor blobs
Date: Thu,  6 Aug 2026 16:52:00 +0530
Message-ID: <20260806112202.75067-6-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make --drop-filtered remove the enumerated promisor blobs instead of
only listing them.

The drop set is computed before repack_promisor_objects() runs, and on
a real run it is passed in so the rebuilt promisor pack omits those
blobs. --drop-filtered implies -d so the old promisor packs, which
still contain the dropped blobs, are removed. Without this the blobs
would survive in the redundant packs. The existing repack machinery
performs the write-before-delete and fsync, so the drop is crash-safe.

The dropped blobs become absent locally but remain recoverable from the
promisor remote, so a later access lazy-fetches them back
transparently. --dry-run keeps its previous behavior, i.e. it lists the
candidates and changes nothing.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 14 ++++++++++----
 repack-filtered.c               |  1 +
 t/t7706-repack-drop-filtered.sh | 12 ++++++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index c5f39cef00..a20589a7ae 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -286,9 +286,6 @@ int cmd_repack(int argc,
 		die(_("--dry-run only takes effect with --drop-filtered"));
 
 	if (drop_filtered) {
-		if (!dry_run)
-			die(_("--drop-filtered doesn't work without --dry-run yet"));
-
 		if (!po_args.filter_options.choice)
 			die(_("--drop-filtered requires --filter"));
 
@@ -321,6 +318,14 @@ int cmd_repack(int argc,
 
 		write_bitmaps = 0;
 
+		/*
+		 * Dropping objects means rebuilding the promisor packs
+		 * without them and then removing the old packs, so the
+		 * redundant packs must be deleted. Imply -d on a real run.
+		 */
+		if (!dry_run)
+			delete_redundant = 1;
+
 		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
 
 		if (ret)
@@ -446,7 +451,8 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(repo, &po_args, &names, packtmp, NULL);
+		repack_promisor_objects(repo, &po_args, &names, packtmp,
+			(drop_filtered && !dry_run) ? &drop_oids : NULL);
 
 		if (existing_packs_has_non_kept(&existing) &&
 		    delete_redundant &&
diff --git a/repack-filtered.c b/repack-filtered.c
index 79ba6d90aa..e6c35c23de 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -120,6 +120,7 @@ int enumerate_promisor_blobs(struct repository *repo,
 
 	/*
 	 * Apply the filter to find which blobs exceed the threshold.
+	 * The caller has to_drop and is responsible for clearing it.
 	 */
 	ret = list_objects_filter__filter_oidset(repo,
 		(struct list_objects_filter_options *)filter,
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index 453053cc18..88c2bb0857 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -134,4 +134,16 @@ test_expect_success '--dry-run does not remove the filtered objects' '
 	git -C repo cat-file -e "$BIG"
 '
 
+test_expect_success '--drop-filtered removes the promisor blob locally' '
+	BIG=$(cat big_oid) &&
+	SMALL=$(cat small_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k -a &&
+
+	git -C repo cat-file --batch-all-objects --batch-check="%(objectname)" >present &&
+	! grep -q "$BIG" present &&
+	grep -q "$SMALL" present
+'
+
 test_done
-- 
2.54.0

