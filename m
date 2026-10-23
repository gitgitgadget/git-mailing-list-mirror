Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740381;
	b=DgVc9WNo09y9S0muX7PXkxCTfZEua7AslSNn+Ql35Lw45zO97LFCOxPW+sekmexoArN5
	 5PxKxO7KNj1QF6+0QGmpIN9reWr4oOkfAwYZRBSULhPy74YeSxSL04HdPUCeFjuxj6/To
	 RjwyFKhCOReskIjnKsRIVrcrW0hjsmVFCBhWLrTSXYB4XGb0oIlVGRFfzu8+tMgnA45cb
	 slDLe/LxV66McJxfFbjbFRdO0CkVedzhgHkfIqXlR0mOruEvYxwH/0SiaPInXYsZI+e91
	 Uo4krbWYeG77EdSUzFrKJRD46uwBfn9jJWVZlWQKmKkRdaMMY9RRiw40tUtEVAYvCUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AMW0J07wOSd+yyZ9gMJBxPKEukP164cLLLMFPnFYBas=;
	b=ZTxCS8jyjBgCe6hJaJpV1UDCXXOly/JY70Nu/Dg6+bPAU1ReZjmMcHj3P5tpFKJGrnmR
	 lqfb9ox4jwvTgiSr0wfmZQj80thcSYztt9TR38GuhCjSvThhNAx90K6tUPFsXOD1UUBpq
	 vqiAoRyXGdv6kKzCZ3dVe0JEpRvnouksTab3+IfudecWH+GuGVkEqYbv8kf03MjMw+87p
	 lRDS6udJU1NLwVdRKrDNGDypD0dK5fhXG0/ww19rYFtY89gZiPi47K90lT4VcNftdgic5
	 RF6bVrZ1lqbCtNsAlngpJAdo1LEJ0aclvWDTPRMmSMnkgTWbftEXHOC0bdoi15ymydA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AbO7GZoU;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792F606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5792F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AbO7GZoU
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso278573f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792740380; x=1793345180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMW0J07wOSd+yyZ9gMJBxPKEukP164cLLLMFPnFYBas=;
        b=AbO7GZoUcSq3sOBz9FpcSfnG/oBcusKUSuhSDg3oIOURMEIBNIvzQLDvLlFAWtt+3X
         10wHIc0hTov32BfcN0oH5jqiNmUPWAlcru5MLO9K9EmRaTipu/O5aLdP52SUdxatR3Ix
         H4eccTOs3gikTNkAOMhNXDCV1FiKsvq+MLE0l1a7O6Ymd7MtEqK0ntY91DVAB1YDkOXl
         imQutD14u+uEEq9ORpeey0yX1ETSn1f8kRnUDJ40TuxGaZ3pCsi2GjSN+VL7lyxmfpGY
         gJvaiwfh7dmkvXZk0OwVu1wZ+vQ+iUGbWxs4EbTGK7QEiP4R1Q5Br8vyQtEquTo4Xa3Q
         BBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792740380; x=1793345180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMW0J07wOSd+yyZ9gMJBxPKEukP164cLLLMFPnFYBas=;
        b=hb8p8nh3x0x7q53kxDnnfVXSS5RrHnK1JORy3FC+g9Qzo9KEBOJzJxvzlJ4U6wY14X
         FDYSrsZjEk/fJ1PK+nYnWw3TGzzRjvLApyrg+1U2SAuV0iYayUPfJ3g7dse53Gs8Jk8L
         HlQfs+Y6ePKS/j3Ep+z7DdZZCx1hVWzVCAtpzNAP+SZZRbF8ACsVBj7rTNRyeZJdly5P
         0FMG9AJOHnZ0Oq2opLh3OukR8UlkvLMmN202PAWs1eVdon1/W3CgiwsqTEahLKpwn6jC
         9LB7Sdt081nOLaAgoVaHrYSJP4Lquq6FNZzvnumZRBZiki+EKDtzX52ofsGcxDl/5lO7
         yj4Q==
X-Gm-Message-State: AFq9FYKPnKIjo8LiJnYAiRbiGkzE4DDRqIJqqF9MwZX1qY+A0DU2lkcF
	Fy5uaGYzua9ok8GFXCLnKnjN/L3TLYk234OL85KEYIvwRuThAgbLdX6ry30RpQ==
X-Gm-Gg: AYBFou0TATImbgt0/qpaybtYye6lFHZARCyYm6AH5ivavncAOIMajpEY/eb1kldUCFi
	80UHmTPX7NwqrxxQGw8D78KoNgOEB6L5xFpTxVsu2ppAQlTtQHuiv1wV8npAYUgyfAdsWqoegWT
	VPagMTvoe79slJOvcoh3dbf6zdlcYBUymzutKASnJOtOJjq3XalOXYOqtvZXkg3A3p30Ml9smDJ
	OUnVH5K464e0ZfaV7sAYZ2DIhNInrI6cI7+vw++A8Nupi0sBEPjKiXcFeHtPcrbs5X6WL1/l3C4
	7ZJhd3uyDWDrM9OCnSsrAD1eVNQ12gfd/fELRexZ+0yIYKzzQo7Dq31pf3N4hzpw+ZBXQwnFyAP
	BmQ6XSLPxPR70vBXItYZaxS0cif4m0NScsPNFaJilITodXEslLtyRUktcI1FYKTvxhavdOhpneY
	zLZqeQB3YK183IIGd73a8wIR0YHFzr68/qXihrvdF9mSL4+I2mkzfuK65eIBe7e0eiwWiDHEAEJ
	GfxTxYRUXIhh9gNZ0VgCLy2Cvmc7RLb0KQ7NNcnb3cHk7QtuIFApvtEVEp3HK/qp725YtS6hgjw
	w7AGPmamEzHZJXpw/8CDFHwakE6kWS4KLqPqPIm1YrRhwjCOux13GGRDgR/AK15JeonOoJNNlHP
	dHTwA+gBgA746vHhPsS/Zesv/lw1eejJwts8b7mgyuYrf71uLX07haz2Eh3y7q9pivsP+v+uQPK
	4Mm3/ZuZ/ERaw=
X-Received: by 2002:a5d:64c4:0:b0:48c:557d:ab24 with SMTP id ffacd0b85a97d-48e3854e27dmr1842770f8f.4.1792740379574;
        Fri, 23 Oct 2026 00:26:19 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38055da4sm3228024f8f.43.2026.10.23.00.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:26:18 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 03/13] loose: add a flag to control whether we write mapped OIDs
Date: Fri, 23 Oct 2026 09:25:48 +0200
Message-ID: <20261023072559.3204273-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.215.g47fdf2208c
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Right now, we always write the object to the loose object map.  However,
in the future, we'll need to temporarily store some object ID mappings
in memory so that we can rewrite other objects, such as when we're
indexing packs.  Let's make this easier by setting a flag indicating
whether we want to write this to disk.

The bottom six bits will be used for an object type in a future commit,
so pick 1 << 6 as the write bit to avoid conflicts.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 loose.c            | 5 +++--
 loose.h            | 6 +++++-
 odb/source-loose.c | 4 ++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/loose.c b/loose.c
index 8d7ea27448..090681b4b3 100644
--- a/loose.c
+++ b/loose.c
@@ -212,7 +212,8 @@ static int write_one_object(struct odb_source_loose *loose,
 
 int source_add_loose_object_map(struct odb_source_loose *loose,
 				const struct object_id *oid,
-				const struct object_id *compat_oid)
+				const struct object_id *compat_oid,
+				int flags)
 {
 	int inserted = 0;
 
@@ -220,7 +221,7 @@ int source_add_loose_object_map(struct odb_source_loose *loose,
 		return 0;
 
 	inserted = insert_loose_map(loose, oid, compat_oid);
-	if (inserted)
+	if (inserted && (flags & OBJ_MAP_WRITE))
 		return write_one_object(loose, oid, compat_oid);
 	return 0;
 }
diff --git a/loose.h b/loose.h
index 6f0c8554ca..19d3be26a3 100644
--- a/loose.h
+++ b/loose.h
@@ -3,6 +3,9 @@
 
 #include "khash.h"
 
+/* Should we write this object to disk? */
+#define OBJ_MAP_WRITE            (1 << 6)
+
 struct repository;
 struct odb_source_loose;
 
@@ -27,6 +30,7 @@ int source_loose_object_map_oid(struct odb_source_loose *loose,
 				struct object_id *dest);
 int source_add_loose_object_map(struct odb_source_loose *loose,
 				const struct object_id *oid,
-				const struct object_id *compat_oid);
+				const struct object_id *compat_oid,
+				int flags);
 
 #endif
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 3c0c85f3e3..b58184f31d 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -848,7 +848,7 @@ static int odb_source_loose_write_object(struct odb_source *source,
 		return -1;
 
 	if (compat_oid)
-		return source_add_loose_object_map(loose, oid, compat_oid);
+		return source_add_loose_object_map(loose, oid, compat_oid, OBJ_MAP_WRITE);
 
 	return 0;
 }
@@ -970,7 +970,7 @@ static int odb_source_loose_write_object_stream(struct odb_source *source,
 	err = finalize_object_file_flags(loose->base.odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = source_add_loose_object_map(loose, oid, &compat_oid);
+		err = source_add_loose_object_map(loose, oid, &compat_oid, OBJ_MAP_WRITE);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
-- 
2.56.0.215.g47fdf2208c

