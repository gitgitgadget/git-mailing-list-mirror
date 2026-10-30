Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357912;
	b=HMl5So0VoqD6y3RhJblplukqBMZVRK77/qWmygS5Noel+fxZt3nmINP/xb/bu7yCVsNT
	 vikNOo6+qLWQFrZXDI6Aex6igQl/LYe2RiX/IRnTu154vaue6pq8VxabWTPmJ/d5yY7Ti
	 IRL1MU4JhXXqiuZm8bws9JgxNhxPiTOjZ7arjdtd7k8SKJ2jJ1ie1fA/V0u8QDdd5zf8Y
	 bc0t0eKUDjbJNqiP/v/1sCvaRgyhwO81+IfxYKd4rR5fmhDQSPuR0S3mMCNh/e/eqb4qg
	 y2pwxwo68j6P++1RA5aBvYZn9mBZs3ZonW2NrTB88Cr2JuIAELZ0YCCVqqFolUz86gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zWlK2WaYjYPEMNyoVZMUo+k9kT/8U8ddKxtZw3m9xq8=;
	b=cBwBKnsZIthjtQeqi9+oIGuv9ksVxuteOEfM9lHsGkifJqx83K645/jp4e3EuUYJKM4c
	 J1Q2tHBCq0kZfV2ViThYH0i1MiG/U3yvBnIlz5FKuTnXwjYPVQ+Hwzlw89VQ0irzN3G6f
	 O/tiaMU91yAY2FFxcyqjNloYDZ+tcDPLtTVSJrS3UkohJRudugM2S27ovxcMfNlMbidiP
	 9zDwZZqqy//m1wYzNQnNoXCxXTN8Z7nZB8vfHTD7OXL7zR1TSGf9iF1PW4Z+tw+8hTNA2
	 g06oMvofsfPcL7inBL4Ve+YqOX8tHyep282XApHg7zvsPWmqiJRcJ8tuVlNZ14xx+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMJI0v9n;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2372606D288
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2372606D288
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vMJI0v9n
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5720b0a57so9298685e9.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357910; x=1793962710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWlK2WaYjYPEMNyoVZMUo+k9kT/8U8ddKxtZw3m9xq8=;
        b=vMJI0v9nDiohPEtKbQ3GK3iRuziKLL27XGOaj6dLcuamGr1g1XJJsaYEx9Tqi8mNCb
         zwFxj1cSpkJsLRuULjV7ecygNrBuqy+Oap4GlkwhAfE8oeBEICe6aa14Ogfv9Bu238XS
         nIKOgPGUG/0XXOmoI3XlKC5atNq1QDBX3acYivFe7X9q7RJuo8rk9r7OqnHS4N6AhSzm
         poH/f9sBZhsALwGmTvKmuLs1SSvmT1nYASg4h8uG15q6Om9ArZcuEULWSIELzUmT3Dd2
         riZ/qRXZlLQ7etQ8SK58X4CyeJcvPwKHmox2x9xUAiRvtua8Slo8Kr66c53fzyHQcTV+
         DXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357910; x=1793962710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWlK2WaYjYPEMNyoVZMUo+k9kT/8U8ddKxtZw3m9xq8=;
        b=lnFwmxCNABVC0biDpq4FENWOLLe8+qPG+pcIssdWG4m3pEGVGqTFOeOLMi3qI+x4MM
         bXrhHeSAf6PrWSaTUq8IFpBvL2I3/xgWZAoe5Vuz0kf9TfcdIadiZtYggsiFQzbi/Fgz
         CBai00XmrPLDKM8dV6lK+o2GAfJ3hdAdJJzO1UWvbKVdAapKK91c8Dkpt7mGooWQUg4V
         4uov+7EWXKPXYQxpt2Rc8BCR8N5reCH3EHAV7sDgQHXArjjm73puFZAwm9yVoMDuyZ3n
         ZCiP2W7kUE5H0DP5UXKTNPYCZfnwE3FYK24BRwICaXqBc9qsWZQGyC3I4p1LlqS2ie77
         Xe0Q==
X-Gm-Message-State: AFq9FYKM41YCNbM3ljc4laYV5BeDYB1rlQUzNCBfSKfY7q62FDg42aGX
	qHdvzgRLUKpHX7a1jAYa7chFLPZBK3HNofMj7oPB4aYP5DSEwVQCF3K3bmsAkA==
X-Gm-Gg: AYBFou2RLI1lpBdUmLOmxioBhl5yLetdr+VzOjoJ23oE/FtyY0viQrs0+U4EJOJGjUQ
	cc4x0Vk6OMjDkoXr5pxvdKMuiBTxOx2uqytDUwfk+DLDT0JDNif06kPKVSTaqpjhVjTUXwbZURz
	0oz8d7v6GPV0AtKGTmKpyGu2pWicj6qBT5RTUkoxckErcwakCRf71QDATreG4vALRwLOQ3T6KYl
	hmcTiDFsWnAoJJRnTocSI4PtmOe+bIUU+SU1mbFqfU7bgrrCVCEXRIWRhAoD4t66UHciwW3dofb
	XIUXfb6uyUBcBdwqK/8pGxBXGirOu9ihzZ3KlW9mu+br/jXDQC1kTHMPhDAqjejuEq/t9HBrZuN
	kOmfLbGecOWyni15sNuHwE2gcQpce8NCn4NHc47psG550XwQ1gqtDtuddiBm6/H8jHQY0aYyujO
	fiwzYSVmePBjZ10Cr4kpSEQcPk63guGF8mYGTKH9FvEI3O9mfSox2N+aieRLFJlbdSg9mepMb1r
	peJqcOZafXoZ6CeOexZVi6PwOtTTFDIxgZbGaa0TbRN9M70VP/4N9qr0RrkdiUO4ZM9UgOWuqmZ
	VotsyVQ2i1HyUEIIOpsBgF8TnHSlZYINVtAwFAwevcflZS1CZkShsUdqTXFjwYJpuX30thI=
X-Received: by 2002:a05:600c:4715:b0:49f:ffa2:1c72 with SMTP id 5b1f17b1804b1-4ac17567cc8mr39411835e9.11.1793357910260;
        Fri, 30 Oct 2026 03:58:30 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([205.147.30.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b727c6sm2677980f8f.16.2026.10.30.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:58:29 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] tree: use size_t for the size of parsed trees
Date: Fri, 30 Oct 2026 11:58:23 +0100
Message-ID: <0b1d1c5668c89e3329e246d787ec80a161bd1dac.1793357680.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793357680.git.gitter.spiros@gmail.com>
References: <cover.1793357680.git.gitter.spiros@gmail.com>
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

struct tree stores the size of its buffer in an "unsigned long", which
is only 32 bits wide on Windows, and parse_tree_buffer() takes it as
such, although repo_parse_tree_gently() gets it from odb_read_object()
as a size_t. Callers then pass tree->size to init_tree_desc(), so with
the previous commit a tree of 4GiB or more is still truncated on
Windows before it gets there.

Use size_t for both. parse_object_buffer() still hands an "unsigned
long" size to parse_tree_buffer(); it is shared with the other object
types and is left for a later change.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 tree.c | 2 +-
 tree.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree.c b/tree.c
index 53f7395e9f..d37b9bc7b1 100644
--- a/tree.c
+++ b/tree.c
@@ -172,7 +172,7 @@ struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size)
+int parse_tree_buffer(struct tree *item, void *buffer, size_t size)
 {
 	if (item->object.parsed)
 		return 0;
diff --git a/tree.h b/tree.h
index 677382eed8..50f0b15af4 100644
--- a/tree.h
+++ b/tree.h
@@ -10,14 +10,14 @@ struct strbuf;
 struct tree {
 	struct object object;
 	void *buffer;
-	unsigned long size;
+	size_t size;
 };
 
 extern const char *tree_type;
 
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid);
 
-int parse_tree_buffer(struct tree *item, void *buffer, unsigned long size);
+int parse_tree_buffer(struct tree *item, void *buffer, size_t size);
 
 #define parse_tree_gently(t, q) repo_parse_tree_gently(the_repository, t, q)
 int repo_parse_tree_gently(struct repository *r, struct tree *item,
-- 
2.53.0

