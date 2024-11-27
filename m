Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5F20110A
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724936; cv=none; b=FvmMfaimN26GxYHka8aLNyzTcBuS74o027ugJsn5WI4PbQ1sZ0AuZ7RZrA8F15DRzjatpz+PhzIxGSapcYjp6R1AAEV1e+u6kY+h+9a1WIjhv/KQYEBzvAqCYvbpYCoY1ytNp0njPVpgjNCLqI4AUBruXuIQWZvztQaUnCnhbgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724936; c=relaxed/simple;
	bh=6a1VFJPVXDs5jabZQCbDZTOicBHDx9PUoLnrc0lGE08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ez9O42Vmv/IaF2NpFwFew6RqoU0W6OjSPMcnaGATHPsoeb7+pzZ5tMeGK7rt6rCSnkUqvYQM1YqRU6HE454zszHBFZ6q+o4FLnst7UvAkaIUjy5S5HG1zljaXbHPW5TEsLgiZU5ovIsult+83p2LOgkggVyyYdhVpiH4qStuW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI1/gcF7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI1/gcF7"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa55171d73cso188350666b.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732724933; x=1733329733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmhvgX5BH9CzW1HnudCRhcXTQ7nywhYaIjRkUW8X3hQ=;
        b=DI1/gcF7mu1lRhH2QLIDJ07r5WJUSKerK9TVSjpSGLfupf4xW3VxyAFrE5oHSGJigG
         1e69716roNyytZYL5iKtzcBpaOc/7bbCmyzt/H1yZIeMqzHlAr1dlCtX5CSLXGLc6Z7D
         qDJJcWKWzkl9SgcZ1Wd8xHfkMcitE9Ss7vGlL4Y18NftHTOoZiSbquUkrgIB6nyQjduR
         cB+loVM8dyqqz+8mv4VSJoq8dnzlA0JsHnPoL6iZT7kTWVZmEUlGgEpcTLu2kQSO04XK
         tuuRRQQT0S1LQfgBeZv5O0NcF7eXSZbapulCATR0I8LGf83OcEzrBp0QTiYpSENRe8fe
         XTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732724933; x=1733329733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmhvgX5BH9CzW1HnudCRhcXTQ7nywhYaIjRkUW8X3hQ=;
        b=aAQk2v42/q6agOsHSgw1zk/Zld0JezEjBjOthZgboEhgeiPmyjpV/syac5xYB1CdYu
         XzluZiIVhRWqjSKxb5pw/+AQX3vSrzJnelDnE9uAd9kzGFfsw7K4yh92XeGYyX/X13pg
         xmmB/Y66xYXqXV2usKWwvJ31UlLvkK0ZiIMBbEZNKYYCgkdd18zQYeOV3Z1HD2fprPgq
         PjV7dLuOD68hF2yA7938TmsjrGIe4wpgNligOHA7RplRGKFxmpzEVXe93vXH9LKgkajm
         kehafiTZOUG6icIrcMmBz44KLVigZ2pYvh8qPjYtp9Ymd5Z2H2qabS9S44pvMrf0Thu+
         R6jA==
X-Gm-Message-State: AOJu0YxC72sHq6o29et5kOvsF5ZaukC3K/NcCksNgTUfabL8IF4soudu
	cTWeAUJhWp3+wno7ssrnOoNCOjLpZ73O7qRABZiyZVZ/53OwFRlR
X-Gm-Gg: ASbGncuFXElpuwbFPYGaqv6qi7ZqcCQxvsGN30GUAnbtsSZlf4U6VJq2bONIfM/MIOW
	dK8NhUT59CQCPni6sF83/lYak4m8/PRStR2WHqU7vvpaEAwmHJSE8/HnYvP3d+6BLGRgNBpyxUD
	UV4Ntr6/blxKIN5cMTIfOF75+m53YHHdfZOksj9Sk2qvs4qpHWnLmZ8MbKRTCw0ZnzIAMEX0Bw2
	JkEF6qmDBRaar0RK8VNIsXOHYfhL4cFtDlyEFZodrb/pbxt7Ixy/7Elvl2KPg==
X-Google-Smtp-Source: AGHT+IEmmX4dhWcTyAFwKhp0C26iSzKhpSdJPYQ01t2+bsKazNvTnJTWQnG0+fPixf8YCNfy7qwjHA==
X-Received: by 2002:a17:906:3147:b0:aa5:4d1c:78aa with SMTP id a640c23a62f3a-aa57fa9a3e5mr309955166b.5.1732724932854;
        Wed, 27 Nov 2024 08:28:52 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:5640:4a6:5555:68ae])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54e15c169sm420042366b.67.2024.11.27.08.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:28:52 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 27 Nov 2024 17:28:31 +0100
Subject: [PATCH v3 6/8] midx: pass `repository` to `load_multi_pack_index`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-6-c5a99f85009b@gmail.com>
References: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
In-Reply-To: <20241127-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v3-0-c5a99f85009b@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, me@ttaylorr.com, 
 shejialuo@gmail.com, gitster@pobox.com, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=6a1VFJPVXDs5jabZQCbDZTOicBHDx9PUoLnrc0lGE08=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnR0i93yidHj62B6JEkhTM9it3KmqGTT9mpV71W
 f4+4CN7VsqJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZ0dIvQAKCRA+1Z8kjkaM
 f0kjDACLad5qRmJXbjvvh9XRgErI3UEDNhJkxCHY070P24dXH+HcUqnkkyqjHg0CakDhcWE1iyW
 HC5xWl8UNv6Pb4jes0EYhVWWfNu9tZFNuyPTJqWj01VJAl4SDsUBFZlGYMgjEq+VttB0wiwv1YK
 Inl2oq7wxelE+hRqSBtWiHLU17v5Wu9plnQToG5UvX113SJySsu4TnehHJnVfyXRkdrkTkQ61OW
 tR8OlFEOHzABwyQC92V+lxKKVUWY9mQ7nB/IH/OE+FU/oZcyKiR07Ytu4OI04vxyjTnwlH4mM90
 KTsCwzGXOYjjC9NzFnJnb/LNA9xTz7u7TE+nnL7BjE9MeS26G2h2i7i/m5dxXvj3tr8hMN6Hdyc
 zMmtoJ4TF//daOmEP4+fkqdjVbdbSDVmLFDn9JOPouTZnmSBSVpblbi4x0PhkKwOeaZsv4SJnuj
 jq3m50q36hjU79lLQ1pKjEQLEzC9OKmnaVYc8tE5wV3iq/cJYTxb5EDGiviCRNgvESSD0=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `load_multi_pack_index` function in midx uses `the_repository`
variable to access the `repository` struct. Modify the function and its
callee's to send the `repository` field.

This moves usage of `the_repository` to the `test-read-midx.c` file.
While that is not optimal, it is okay, since the upcoming commits will
slowly move the usage of `the_repository` up the layers and remove it
eventually.

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
2.47.1

