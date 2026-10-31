Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446789;
	b=Ir0i653vg8EIqEB1eVuNSLLFZhKmDE3YzoXkGWkQ4dIdmRCtuyd11N5g37klQUNUtoLL
	 7XC2QM8GpSzj3Un9cyRzZd03TsSEQRZjCI45PlQ8MC3iPZAZLBAGoQYpy7mVR5ckxHMia
	 W7oHtQuKLMYCZ0gvMcFQg65VHdZkRAQPBCJbgUukRGnSruc9HzZohJAvGCJpZdgpCicQH
	 b8Hn7Qboq7IrNbjRytwKV54v1xGjJ/8Em3zb1XAnRzVJq0lokU1U8do/0JpdKYiY/6UuY
	 QFt5nB6eZIehrXrs5v54JwuhW6CUMX3+dsqzAVjP5wrlrtOVy4fol5060irc+xp7Krg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8p9GbalgbMvhbko0eMxSIpNpIqieLkSd4MvrE9fuiSc=;
	b=P4Ywhl+3t6xaZBrZnOaB5ciZxJyLFhF1uIL5KdApPmuwuLcX3db9r221EqtUQEkTlJnj
	 IlBIrh3Ir/EQHaIsnqmPSweyz4MxJlasqGe+aDGeZGImrFPJU7bBdkWJLJEY8+3v/dai9
	 WkklbPXMJ/wBo24E4gGQs4PdMqsEWEf91zuvgVnWZh22ni/CRGP/SVAlatn9eLDs4Detn
	 mKSed2PCc1AxWL7JtcNrgh/jvZdNENbS3L9NU/0ql5C78BK8N7Y0uOwo2/Z1sRb808d8K
	 lzJmdmlPFVQceqJwiOKbiByT0Q/FNhZXuV0xrzcUlgumFRThTSksYSmUFdte8l/rQ1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niLb88ey;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748F606A323
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7748F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=niLb88ey
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so9406645e9.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446788; x=1794051588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8p9GbalgbMvhbko0eMxSIpNpIqieLkSd4MvrE9fuiSc=;
        b=niLb88eynncR6SjH26cHisLoHp0sW4mjor37urbhqIxeo5fZ2Vuk9gVtD9lLhz7QHH
         Za7flBKQJld4ruqEUbJY/8LxY2lTE0G+JFQbZPEIPDwZljuTIbAKVsguWbExTSDHRhu1
         108u104mhmdVXn5ZMJWZgniRMT4bO1Rwr1Lk21Wr89/Ys1DbCFFKpkSEQX4243YOadR2
         D0jX5/vDlLk6m2u+w1XdKTjecZZRDLL77SbQOINgCS9RWhVdVYImdFAycXSUcboI4dit
         qj0WhwjXZWQQVzliumM6Yoa8JAQjXu6kEojebRVCpoLDB6PoGeVZ4uOlT3mc5mecC5EC
         0VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446788; x=1794051588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8p9GbalgbMvhbko0eMxSIpNpIqieLkSd4MvrE9fuiSc=;
        b=1yJY6qjd6z94cVH3QENbsgmcZowqUX1ORrweFhK7/vN3QlVu1Bs+Y4MmEDH2kjD3sr
         ayBEMWVkTuaRYolAsQPSMgJBSWfZPBB4+RDeXUp9BgD3eFUVUFoPGPHPIe2nbMUZJbDl
         /02FY++y1F+NzISGetS27dUGwdxWEzEG8LKa45UaxWf094YeF4Z/+Z45tbZ7NSl6M08j
         i1pedWMyF4or5r7BNMlPoeWVgsmYBC/P+ggr0dURlKc/hBVjyo0rIkecMo6W4KUVaqju
         prdhFHwmA/UZcuqzhq69GmOglHj6/iD/XHePmguuVdH6Do7k3oUV++PVmSc9rX2OJPoa
         PC2A==
X-Gm-Message-State: AFq9FYIF+9wzHF1xYRrQbHZ3Dh0gGPF5cA/QBYpzkGfFAEnnbrR3D/Up
	CLFX/sdHbEP8Yro1Bx8llrJwl1bjKF1eFWDHtbVbwpnXax2xXydif39Y9VLQTo4/
X-Gm-Gg: AYBFou2FHnYAWz2xPXFb1ypUgFjObrn1wu1hlfA/UhWSdgjg1yikJ+S9JR6atCVJ3ls
	7e9uuU25kOBCrLeTRxyk58GlmCsCANrw7oR6fFRgpTDR4WNSyASDGMGlQ2yUAgxD1UbS34FVomZ
	gtpjHtnmYCys88Vus3AQWvCb762PSxfSPaZR+IvmoED+IyoVVOFpTH9hHZqvBBA+Y+Xd8qdOoo5
	v7VJUyT0xkx93CIInUlO8IijJ19FoJikAwrlNZTB52Y1SSK6/5A26rYQDK3dvsftahVf2i9/YOk
	cvzkHf3nlbGVM/q46EfVeTwD/jPcYAFMibdWIFXGiOCOpyfLueg3mWGriXoI7zo7wjpAlR/fuue
	JXG8T0wYSvvcKYq0elglzg2iNy7HcjBWDmt6ZF605P2qjrEnDLIHdeavaEe7fgYxVnEMqOEN4ho
	bxfysX/WAQXD4NTy9ZfLk+Du+fMF5ZEKFFadeggTE+L5hdIWFA78lVoNUDwEJq7IBIKJw4Z3w1R
	8l16/h8B3UBLLN8xx7U32hQUW8eeFkdh3owaFuiunU6aB4tT74UHaQ9lkSXgsaprGn3wn7omCvW
	wsW2X2pgWfGs1KTQi60YC66/PCPdhRbf7EYlDuia03TF+TuvP/ZgXpBCm+5Ktgo=
X-Received: by 2002:a05:600c:6215:b0:4a1:a45a:88f with SMTP id 5b1f17b1804b1-4ac187a6c3amr104757645e9.20.1793446787906;
        Sat, 31 Oct 2026 04:39:47 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8345366f8f.23.2026.10.31.04.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:39:47 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 4/4] pack-check: use size_t for the size passed to verify callbacks
Date: Sat, 31 Oct 2026 12:39:38 +0100
Message-ID: <87b0d2bd96ad2e62f770c556eca9589bf7aad11c.1793446357.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793446357.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
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

verify_pack() in pack-check.c passes each object to a verify_fn callback
(defined in pack.h) taking the object size as an "unsigned long", even
though pack-check already handles it as a size_t. This signature is also
replicated in struct odb_fsck_options (odb.h) and implemented by
fsck_obj_buffer() in builtin/fsck.c.

On platforms where "long" is 32 bits, running "git fsck" on packs with
objects of 4GiB or more passes a truncated size to fsck_obj_buffer(),
causing parse_object_buffer() and fsck_object() to inspect only a
prefix.

Use size_t for the size parameter in verify_fn,
struct odb_fsck_options.object_cb, and fsck_obj_buffer().

Triggering this requires processing objects of 4GiB or more on a
platform where "long" is 32 bits, so no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/fsck.c | 2 +-
 odb.h          | 2 +-
 pack.h         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index da90cf84bf..9f62aa1f4e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -390,7 +390,7 @@ static void check_connectivity(struct repository *repo)
 }
 
 static int fsck_obj_buffer(const struct object_id *oid, enum object_type type,
-			   unsigned long size, void *buffer, int *eaten, void *cb_data)
+			   size_t size, void *buffer, int *eaten, void *cb_data)
 {
 	struct repository *repo = cb_data;
 	struct object *obj;
diff --git a/odb.h b/odb.h
index dd85b880a7..9cb36ed5ad 100644
--- a/odb.h
+++ b/odb.h
@@ -197,7 +197,7 @@ struct odb_fsck_options {
 	enum odb_fsck_flags flags;
 
 	int (*object_cb)(const struct object_id *oid, enum object_type type,
-			 unsigned long size, void *buffer, int *eaten, void *cb_data);
+			 size_t size, void *buffer, int *eaten, void *cb_data);
 	void *object_payload;
 };
 
diff --git a/pack.h b/pack.h
index ada506b5c5..d9649c6ee0 100644
--- a/pack.h
+++ b/pack.h
@@ -88,7 +88,7 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *oid,
 			 enum object_type type,
-			 unsigned long size,
+			 size_t size,
 			 void *buffer, int *eaten,
 			 void *fn_data);
 
-- 
2.53.0

