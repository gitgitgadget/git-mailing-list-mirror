Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB262EA468
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449606; cv=none; b=Yhpjzpu4OEBaHXXfHWmpqjzNQATiq13ZHOsue0akzRC2eBSyyawLBcJLDdAVDXxyd9zjL/q6c1F/11gVihDv0EaZqeP77P/O+POsWkfPqOF0/94i+VFmsX3YSetc3vNuAEFrEuqnxugnaZki4ma9nOQ5SJM2Sy/sHmoatnbDnsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449606; c=relaxed/simple;
	bh=x8rTtbszX+y5SnctRaF05aY+ccEbHPmS3djNtBbz9xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAiDtftmkrHHnK03bV89yt+3RCc4N770gG/gf8nFXOoZk2bELGumj1tYe7a0kP98aPj9kzpV9rCFSI4grBEfpvEbZVlGW0rcpnjSJrMV1rIynsC3dCv8CW76i1YKwnS4H0/p43bsi9kc/WAqLEkor0PFL6PTcclTdoJPzLU1wrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDblrc3j; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDblrc3j"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94abd52b274so93754241.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771449603; x=1772054403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Z9f0UvDhCeLLG2Ae6MEDVoFJdawK3rnfl7ggCMhQi0=;
        b=KDblrc3jYmUcGyLM84Wsoi9jVAouTkB7+FmkCIc4ROL4Ch+aozOI1RAuGMwR9ysbfS
         bRGQFY+ET4AE0pYtVNPDGTBq2MA5vo7fkRcV8tww90WxKBDrcS1zs/OvlS6dDgGT9l33
         +ZZb+BX5z6uZmOaqSWZeZrakmCVBAtbIczMX3FLsLQQDugpf3yDhlk4a1OLym9M/luNa
         qvqTt9Q/MFqonyi+hekW4G+CTq4SL8/wZD1aBIuLQ6Q2KkgAm+uyjQSICUubY320P5PI
         xu6BoZIpwTI8sVmgpCP3ubpyAeYm95mKC6OpRd9o5Zc85MLDJ+8+UXrefxIdNSyg3sS1
         zDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449603; x=1772054403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Z9f0UvDhCeLLG2Ae6MEDVoFJdawK3rnfl7ggCMhQi0=;
        b=EtwIzkDcDw0mHS1a/5LJuQPYbmsMoc6yhmGUH6BqODJw3mIc125ThE9CtclvZ4U8mh
         Og1IDjUrFZT3vRvDdmUkehYUpNUFEyuflduN8JLP+SCuat/upNebpq8tVL5Fc750b8Ea
         /ArHBoWdxhWWTS1DbRD5AYN62/DvxgHB8H79qoFJ3UdR3d/2O8ULgFCaHpF/p4vGroCM
         kJQRPUjc9W1cePSryiqJmzoRBD0HdW3mhd7mSUGC/tyyACKVCQQQbJNMzldWkSfie92v
         fXjayoL2XpziCT2hoDvvqed2yFI79u04qsinJvaSWeb1ruIvEgdUMNkx3vpoDYilmlHv
         bWWA==
X-Gm-Message-State: AOJu0Yy2Wvg+02J7MIVddhcqLzaEAb3RxwmBfgYXUYmqfI3R2lcc4e+E
	n+kM6PURRtFf5Tx2tEN+K4pOCblg3Eoxt2vkf6ivxrnSQQghPShL5uHm3J/FVA==
X-Gm-Gg: AZuq6aJtEnfEgMxJK0z9uYPclxJhzFecXg6O/MQvrhRpVTZXFCnkZrC11NueLTlZdr2
	5JFEKnnTEt5QGjE/3kSLQCb8Z1B96/hepU4wKlxhQBpJoJs5XfEMF9b/4hD4J8VhikDbQFs7fuX
	M51YI8MJGUj42HRTogPI04yUspLB7FdM5q3fqf/TdYf0BspMisiXB1oKZLfl3zhg6LGhrkeMz1K
	QbDeXUabHtTxNI2mklwLdYcJbnVzpSoYH9t7ThNm+PbR7yHTrlzq/Svzml2dzDiCr3d4oRcHRBa
	GhR+X5wSfbAwZRMgNgzYK1Uys1bVNOs3iucXrRkMSD+aNjOD4dW4uoxLaKpATrKc5dMRRceVHgU
	69/XSYDoykKi8AWoaPE+8HMd0QB0qECo3E0k4Ha99Q/ZN6bWoF9G7C7beI7645i61tON4BWDtiX
	1KA/meo3pCqMNmZkgdkJRTT+QHIwv0/pmDKPvnUKjPnG0mn2Ar4FGJUkrizJ1ExOwNTxcCxKujZ
	235
X-Received: by 2002:a05:6102:956:b0:5f5:487c:83cd with SMTP id ada2fe7eead31-5fe7fdcfe83mr1010130137.40.1771449603459;
        Wed, 18 Feb 2026 13:20:03 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:a068:d017:8d32:248])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afcdc345asm12326301241.0.2026.02.18.13.20.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Feb 2026 13:20:03 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 3/8] repo: replace get_value_fn_for_key by get_repo_info_field
Date: Wed, 18 Feb 2026 18:08:39 -0300
Message-ID: <20260218211845.96009-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the function `get_value_fn_for_key`, which returns a function that
retrieves a value for a certain repo info key. Introduce `get_repo_info_field`
instead, which returns a struct field.

This refactor makes the structure of the function print_fields more consistent
to the function print_all_fields, improving its readability.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/repo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index aa9a154cd2..c60a41ba7b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -78,14 +78,15 @@ static int repo_info_field_cmp(const void *va, const void *vb)
 	return strcmp(a->key, b->key);
 }
 
-static get_value_fn *get_value_fn_for_key(const char *key)
+static const struct field *get_repo_info_field(const char *key)
 {
 	const struct field search_key = { key, NULL };
 	const struct field *found = bsearch(&search_key, repo_info_field,
 					    ARRAY_SIZE(repo_info_field),
 					    sizeof(*found),
 					    repo_info_field_cmp);
-	return found ? found->get_value : NULL;
+
+	return found;
 }
 
 static void print_field(enum output_format format, const char *key,
@@ -113,18 +114,16 @@ static int print_fields(int argc, const char **argv,
 	struct strbuf valbuf = STRBUF_INIT;
 
 	for (int i = 0; i < argc; i++) {
-		get_value_fn *get_value;
 		const char *key = argv[i];
+		const struct field *field = get_repo_info_field(key);
 
-		get_value = get_value_fn_for_key(key);
-
-		if (!get_value) {
+		if (!field) {
 			ret = error(_("key '%s' not found"), key);
 			continue;
 		}
 
 		strbuf_reset(&valbuf);
-		get_value(repo, &valbuf);
+		field->get_value(repo, &valbuf);
 		print_field(format, key, valbuf.buf);
 	}
 
-- 
2.50.1 (Apple Git-155)

