Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D31CFEA8
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678161; cv=none; b=qEdpfyJSLr9GjZAijTuWiQO57yFh5tgv9WU7ykQZExFnsVkourhonabeP10PovY6WtWagAB/f8jwuboR5U2q564CJbidvkUoAf6dtInLQViwrjK9qdOAXUsXYyi9C6YVe6o5Aj9Wq5AChm7A9c1iB4mPU/hMoqunoCbfe/P7MUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678161; c=relaxed/simple;
	bh=emel8BYEA7ZZyZ0FZHuwGa2OPJZ41kdcDurYxtvr3bI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBf8eSz+gbBh0AaygQPi0E/cSb594yRkC8wsDRi4tJQ3h9vSEn9at3Yv372dUCi0pEIViBYpqGZER77x/RYwjRW46bfeJ50jEExpduLO5gpsM0ctcX4Y3dcoz7cKNeOYbYGYHI0r1GPkV0MqLdkPSKodEIZ5cxAxH6kKVz7JhAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hr12Rg0J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr12Rg0J"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa2099efdc3so351896566b.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2024 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731678158; x=1732282958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vg14a2esrRKODTt7jVEJTF01xkZsMNIxC/blRaGklb8=;
        b=Hr12Rg0J8oIgYw2Ngp99ZA6eU7wWzGdKTjWzAgwUx81LEPQiGtn5UJaX8kWC8Rukpd
         yz2ZaJdKl/qPpMfeLxLT5RcLWYfPT42SslAy//sOAIi4GuPh/JKH+1aOShz5nU162b9P
         3NZzNakGAWgoUFt1pYzjSx/j5GJR6bcj/nna+74QnVoyqkSWBanyvGJSJaL8Mqb0YG2s
         Svk8SshGvP/YBN5xNbu/muqddJFoUfRzMPWPBzTD8FtTyfkz2miV3i2ysRUEgK9pcKlV
         +lQ0ssq/b6GblBu7YPWrx7d5IyHPVS9a1NKzYfWm/aBjrk9JBkRL9LmznCTgWtYm1tnX
         YvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678158; x=1732282958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vg14a2esrRKODTt7jVEJTF01xkZsMNIxC/blRaGklb8=;
        b=lhZU1HsFxVObQK8VItEIr4xm6pyHE/GdJzQCQAtb4KMvYY/WGxSqpw575JIVYmYPC6
         fyt4CF7oPVUPEfV/eMeaI6MKakUJedSPURnwpA/FndEtUWelXtHVbtceSa7yrwE4PXJv
         IKN02AyCD+K/dWZj3j/4giDhCNcQgDF+yitlitYmTm0AYlYCbBcio5b1KRiQb2k5rdxS
         YeCphwB7bYWUbET2+yudayJT0uGYITx8H42f8clXomk5pqARh5+gzL/IeC5pFu1VRwOl
         ofaaVXScE3QPQElciSBYtptiYNKYzkQPC5SvVr5krHg3dBT6PMbsh0Sq/K/IBFmJTkiD
         CLgw==
X-Gm-Message-State: AOJu0Yxa5xS7d3Z6FeklLXKYAVV+WQc/t+fx0KhX3cUkegHBXe/g8jcd
	h9lTviUrmqRSeDr3O25VZXGAe/FSqfqBB2Cv088Dn8D7VOVezsk/
X-Google-Smtp-Source: AGHT+IEUJimTK/5qBG/V8rpFnPUacNSI6NRiu7Yi2ot6t7eTrVLiK2W0WYAXAwd0jiLcSw74X3FKug==
X-Received: by 2002:a17:907:e92:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-aa2076eb6b3mr695940166b.14.1731678157964;
        Fri, 15 Nov 2024 05:42:37 -0800 (PST)
Received: from [10.82.5.93] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26a69sm180753966b.34.2024.11.15.05.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:37 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 15 Nov 2024 14:42:18 +0100
Subject: [PATCH 5/8] midx: pass `repository` to `load_multi_pack_index`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-5-761f8a2c7775@gmail.com>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, peff@peff.net
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=emel8BYEA7ZZyZ0FZHuwGa2OPJZ41kdcDurYxtvr3bI=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnN0/IL0KDGzosKXqI/5R4h5CE4ofLaVooaNrQj
 4l5IoMukwWJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzdPyAAKCRA+1Z8kjkaM
 f4V+C/9TDxm7wcH6vmijd9jBLOkEcZgGl2zGmRnpX9PTrGrWv2XmKELSxDDcZb1rKB6UsE7Q0Cl
 ye0NaHM/lSTmgFba19Kcss6McwADdCzDRC2POHabky7rGNUJ/enavVRAZ4lSFnG6jApSSsZfwWw
 5rij5cvaLD7CrY06lN/2T6dGzSEb7IPurf91J06UeGDQC48/7vmCJYjPmsDjFnYfKKq4dmkXSU1
 XTsFwgSE0Fb+hDxdbb9fS65hU4y8LtJxWly6s+Fk0ycjR9ipillrQp5Vm/ijGSfthUfG2t9gNsy
 tz3RSkQkaPuw8v7WB/cgCRxNQaPd/gmfYZyTo13hyO+BGVgglgRgcWRh7hL2oNGeYKp31OS0DjT
 e1fXPGO6x3GRJGoSd5Twj7f2uYduGBzD2Ec28ZkLY8xaJvMcaB7bn2OcECRRzGFI/KXy6JYdFeP
 nIRpPgbnV5OJwi52D1SAz9T16n0x8vqoehfgCEI6uNf18ENlMF6sF6SCy9oouFiakVk+k=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `load_multi_pack_index` function in midx uses `the_repository`
variable to access the `repository` struct. Let's modify the function
and its callee's to send the `repository` field.

This moves usage of `the_repository` to the `test-read-midx.c` file.
While that is not optimal, it is okay, since we'll slowly move the usage
of `the_repository` up the layers and eventually remove it entirely.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx.c                    | 11 ++++++-----
 midx.h                    |  4 +++-
 t/helper/test-read-midx.c |  8 ++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 6f0fb8285af14843da132ef1b0c3a8bdd06732c9..98ee84d4a8bf388906634ad695ff39acdaa2c6d5 100644
--- a/midx.c
+++ b/midx.c
@@ -372,7 +372,8 @@ static struct multi_pack_index *load_multi_pack_index_chain(struct repository *r
 	return m;
 }
 
-struct multi_pack_index *load_multi_pack_index(const char *object_dir,
+struct multi_pack_index *load_multi_pack_index(struct repository *r,
+					       const char *object_dir,
 					       int local)
 {
 	struct strbuf midx_name = STRBUF_INIT;
@@ -380,10 +381,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir,
 
 	get_midx_filename(&midx_name, object_dir);
 
-	m = load_multi_pack_index_one(the_repository, object_dir,
+	m = load_multi_pack_index_one(r, object_dir,
 				      midx_name.buf, local);
 	if (!m)
-		m = load_multi_pack_index_chain(the_repository, object_dir, local);
+		m = load_multi_pack_index_chain(r, object_dir, local);
 
 	strbuf_release(&midx_name);
 
@@ -727,7 +728,7 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 		if (!strcmp(object_dir, m_search->object_dir))
 			return 1;
 
-	m = load_multi_pack_index(object_dir, local);
+	m = load_multi_pack_index(r, object_dir, local);
 
 	if (m) {
 		struct multi_pack_index *mp = r->objects->multi_pack_index;
@@ -881,7 +882,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 	struct pair_pos_vs_id *pairs = NULL;
 	uint32_t i;
 	struct progress *progress = NULL;
-	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *m = load_multi_pack_index(r, object_dir, 1);
 	struct multi_pack_index *curr;
 	verify_midx_error = 0;
 
diff --git a/midx.h b/midx.h
index c37ad5b5242b56d21fd76bd59957a1bdb82786ec..78efa28d35371795fa33c68660278182debb60ab 100644
--- a/midx.h
+++ b/midx.h
@@ -97,7 +97,9 @@ void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
 void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
 				 const unsigned char *hash, const char *ext);
 
-struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
+struct multi_pack_index *load_multi_pack_index(struct repository *r,
+					       const char *object_dir,
+					       int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 struct packed_git *nth_midxed_pack(struct multi_pack_index *m,
 				   uint32_t pack_int_id);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 438fb9fc6197fc465f79d9a65b719ae315fed373..fc632369618917e2d8cdcb77bd9073c61e1544c1 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -18,7 +18,7 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 	struct multi_pack_index *m;
 
 	setup_git_directory();
-	m = load_multi_pack_index(object_dir, 1);
+	m = load_multi_pack_index(the_repository, object_dir, 1);
 
 	if (!m)
 		return 1;
@@ -82,7 +82,7 @@ static int read_midx_checksum(const char *object_dir)
 	struct multi_pack_index *m;
 
 	setup_git_directory();
-	m = load_multi_pack_index(object_dir, 1);
+	m = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!m)
 		return 1;
 	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
@@ -98,7 +98,7 @@ static int read_midx_preferred_pack(const char *object_dir)
 
 	setup_git_directory();
 
-	midx = load_multi_pack_index(object_dir, 1);
+	midx = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!midx)
 		return 1;
 
@@ -121,7 +121,7 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 
 	setup_git_directory();
 
-	midx = load_multi_pack_index(object_dir, 1);
+	midx = load_multi_pack_index(the_repository, object_dir, 1);
 	if (!midx)
 		return 1;
 

-- 
2.47.0

