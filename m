Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84401DE2BC
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737285589; cv=none; b=erkGENRMoJuSdD8Zw8Ws3CarmIM8fot8Js1nd/0dTkeK+4CEOAMiOV3TduPe6fhlfzQpGHxuPJumksyo5iBpxobiuL0a8kTjHV4Y8PuO1VyVGKrOPq1bLLbPF8pZC5rCFXW460b8SseBKeC5oRSuFtIKqEAyRg3w2Um/ew5/uWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737285589; c=relaxed/simple;
	bh=v5ZUwpdDJTd+G1HB8XKbc/aglyDr+icMlkaRjQZ/uYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh1+7Svx+2zlQHZnYRhhAqpmm+MW+keilInYRMN2vx70PV1n2GRV26SgEE6SOwUJoaiZjM+s+brOuk8hZ24C2DzpjrHKg1qyyBcoiilFVxKsE215xYQ4SBKFNX1IeWZyLDsGyTVx/yjLHHHKQnFNk1tERz/d1JUG++pj75C3Iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inlq/QLi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inlq/QLi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-216401de828so61439035ad.3
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737285587; x=1737890387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHr0b/L9kX+cQqJbGdo8PiMkNCQ67VIUO6zbVBkRdv8=;
        b=inlq/QLidDZZzvyg4klkkYYBYig2FdFi/gUly3/6ROJTXiTkLqhyZMaOfaFB7medLB
         7trPwQTcUsWUCQ9yNLY8M/31IMlsZ9QIsU4UnFdZucS20wMYzp5/ag46X2XQZjrnU+e5
         5S6hkRV0YZcPHi6uV60q7zOIhinl9AQDd6vFI7Pky7ZfAfT2A3cgCz3/bR/cR/DtD9FE
         3ZusW2Gq6BTWSmEoybn70tSZZclm43MMEthMgqyw/DqbJtRCUIQgSXaesJzT/06heMId
         utwQt5xAfMD+TokSMgvYSgeVlAe8YCGjmQSedgq82uqHuJIxmWnwTENN6jQgAyV5Jkrp
         WYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737285587; x=1737890387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHr0b/L9kX+cQqJbGdo8PiMkNCQ67VIUO6zbVBkRdv8=;
        b=mgm9AxLdj7J1EhuZfLmo8x4EOeZ5fvx5pzlXwOJmZA15nqUGuYjl/tlEuI70N1V9Ps
         dZGxw9tD7TS8SShAV6WcCINIAo+X2+qTWQeGIN1lvnBoAOTzEWtXDn/LAV7oW76aoFW/
         g+q33Lj27b/VcMxSHb236Hzp+0dK3txv0WRBr48WyUheDZ6OoZiiVyedkgjRqy4fKOHc
         7ArmUTljfKxx3DeA0sckdhoiSw32hVQzH3M1ZU8ud3Z4WuMaKABrXPrVnQcCGJhQZB5F
         Z9Fb/0IP5mHO0ZJpLM3XFt1xKAJk/sFCWAJ65NWwRqMWzLMM30WYk6l6WcPhDrfSiYJW
         lHCA==
X-Gm-Message-State: AOJu0YySD5hB+H7YJc7u7WUi49yayUX3C1FGLsFGgesEsMnlvqr8CqUo
	INs9nrakby5lCpGFDcvB28XlWx3/dwzwd7U724ndei7iXsHCFC0T
X-Gm-Gg: ASbGnct2ub7Ca9GA+oAF+rYdXReAFt2fi3NLIpDKeVj1mp2VoVQBJvOhRBqzI53pY29
	oBiZkYRs4b9aXRpLTYCpVHbd/2q0jHxNhknJSnmnuoxEQsP6Rb2mkfWj2bosUi6FmdqnoMXJhuM
	AzQSah0l0zxfBd54FT8EAdT6x9H6x0lKRf/8ZFHGgYsXvuafNSg+qOMUb231zoDHzQ5ciUTluur
	hx69JYVTVyEU4Ct5p9I85lnSz5eMp3yu0YjqeprE1p9fzXV5m5kcXUTMGoJhziyD3PPzJMh
X-Google-Smtp-Source: AGHT+IGhHQteYK11nAGQPCJVCHg14AHz/uAoUKOOvVyg97D8jieNxnBYKtWo36HEY0ei1gQuee75Wg==
X-Received: by 2002:a17:903:41c4:b0:215:7faa:ece2 with SMTP id d9443c01a7336-21c355813f0mr145211405ad.35.1737285586913;
        Sun, 19 Jan 2025 03:19:46 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cfbd01fsm43031415ad.104.2025.01.19.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 03:19:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sun, 19 Jan 2025 12:19:29 +0100
Subject: [PATCH v3 4/5] pack-write: pass hash_algo to `write_rev_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250119-kn-the-repo-cleanup-v3-4-a495fce08d71@gmail.com>
References: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
In-Reply-To: <20250119-kn-the-repo-cleanup-v3-0-a495fce08d71@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 toon@iotcl.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5970; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=v5ZUwpdDJTd+G1HB8XKbc/aglyDr+icMlkaRjQZ/uYM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeM38XxHM5ENcZEvdCbJAeABlLEEFVGXZbhX
 3VuFrdgsRTULYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnjN/FAAoJED7VnySO
 Rox/Vl0L/1YYunSfL5VIn4Po1FVGOQ8thgg3U9IQ11c9plIyMnrZAoVNWJwPbsi6ItBa4CFTu0/
 +92yTQhNGTu805Rtq3EZQAmn0ZAV366Kd0IEShzoK7iexecVMHTvYJYfIEwSK8vG7y+m3xHrrfc
 eE0u3k6n5ZciXNcvky8Fx325B1oSsGiP4gUq6yFljJwKd9DVEuzDrD3EJmoHLb3QJsRU0RVW1+S
 RW/MDH6J8p5p5zVTCnqKduESkSTobxJzWuPj+BtwxJjjQta7gFpkPz4v++JdikbQeRNABNmE5cl
 ckJmLPBnROqtqTYv07w/33tMY4VCGhBvjpIxjBhPXqoGU8X6OQFKyta7JJQmdYVMWVabByvkhqv
 iILW6SFDNF1k8lLs2UCfwRyp2aw7qnaMFiJwqWPuRUXCD5Q7mU0YkRvzJEWUOHJDu9HUcKOz5e/
 LQeefAi11GgXDR4guQ24tAY9ce2K5u2CMoGesjWsibwF/VI2hINsHl7fn8knMz3WrUZ9sdh/su4
 xA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `write_rev_file()` function uses the global `the_hash_algo` variable
to access the repository's hash_algo. To avoid global variable usage,
pass a hash_algo from the layers above. Also modify children functions
`write_rev_file_order()` and `write_rev_header()` to accept
'the_hash_algo'.

Altough the layers above could have access to the hash_algo internally,
simply pass in `the_hash_algo`. This avoids any compatibility issues and
bubbles up global variable usage to upper layers which can be eventually
resolved.

However, in `midx-write.c`, since all usage of global variables is
removed, don't reintroduce them and instead use the `repo` available in
the context.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/index-pack.c |  6 +++---
 midx-write.c         |  4 ++--
 pack-write.c         | 21 ++++++++++++---------
 pack.h               | 14 ++++++++++++--
 4 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index d73699653a2227f8ecfee2c0f51cd680093ac764..e803cb2444633f937fafc841848dae85341475f1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -2099,9 +2099,9 @@ int cmd_index_pack(int argc,
 	curr_index = write_idx_file(the_hash_algo, index_name, idx_objects,
 				    nr_objects, &opts, pack_hash);
 	if (rev_index)
-		curr_rev_index = write_rev_file(rev_index_name, idx_objects,
-						nr_objects, pack_hash,
-						opts.flags);
+		curr_rev_index = write_rev_file(the_hash_algo, rev_index_name,
+						idx_objects, nr_objects,
+						pack_hash, opts.flags);
 	free(idx_objects);
 
 	if (!verify)
diff --git a/midx-write.c b/midx-write.c
index b3827b936bdb1df12c73fb7d9b98ff65fc875cc3..61b59d557d3ba46a39db74c62393545cabf50f2c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -658,8 +658,8 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
 	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex_algop(midx_hash,
 								    ctx->repo->hash_algo));
 
-	tmp_file = write_rev_file_order(NULL, ctx->pack_order, ctx->entries_nr,
-					midx_hash, WRITE_REV);
+	tmp_file = write_rev_file_order(ctx->repo->hash_algo, NULL, ctx->pack_order,
+					ctx->entries_nr, midx_hash, WRITE_REV);
 
 	if (finalize_object_file(tmp_file, buf.buf))
 		die(_("cannot store reverse index file"));
diff --git a/pack-write.c b/pack-write.c
index f344e78a9ec20cea9812a5eaffc72ae0b7e7424d..09ecbcdb069cc9b0383295798ceb49cbdc632b64 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -194,11 +194,12 @@ static int pack_order_cmp(const void *va, const void *vb, void *ctx)
 	return 0;
 }
 
-static void write_rev_header(struct hashfile *f)
+static void write_rev_header(const struct git_hash_algo *hash_algo,
+			     struct hashfile *f)
 {
 	hashwrite_be32(f, RIDX_SIGNATURE);
 	hashwrite_be32(f, RIDX_VERSION);
-	hashwrite_be32(f, oid_version(the_hash_algo));
+	hashwrite_be32(f, oid_version(hash_algo));
 }
 
 static void write_rev_index_positions(struct hashfile *f,
@@ -215,7 +216,8 @@ static void write_rev_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-char *write_rev_file(const char *rev_name,
+char *write_rev_file(const struct git_hash_algo *hash_algo,
+		     const char *rev_name,
 		     struct pack_idx_entry **objects,
 		     uint32_t nr_objects,
 		     const unsigned char *hash,
@@ -233,15 +235,16 @@ char *write_rev_file(const char *rev_name,
 		pack_order[i] = i;
 	QSORT_S(pack_order, nr_objects, pack_order_cmp, objects);
 
-	ret = write_rev_file_order(rev_name, pack_order, nr_objects, hash,
-				   flags);
+	ret = write_rev_file_order(hash_algo, rev_name, pack_order, nr_objects,
+				   hash, flags);
 
 	free(pack_order);
 
 	return ret;
 }
 
-char *write_rev_file_order(const char *rev_name,
+char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+			   const char *rev_name,
 			   uint32_t *pack_order,
 			   uint32_t nr_objects,
 			   const unsigned char *hash,
@@ -280,7 +283,7 @@ char *write_rev_file_order(const char *rev_name,
 		return NULL;
 	}
 
-	write_rev_header(f);
+	write_rev_header(hash_algo, f);
 
 	write_rev_index_positions(f, pack_order, nr_objects);
 	write_rev_trailer(f, hash);
@@ -568,8 +571,8 @@ void stage_tmp_packfiles(const struct git_hash_algo *hash_algo,
 	if (adjust_shared_perm(*idx_tmp_name))
 		die_errno("unable to make temporary index file readable");
 
-	rev_tmp_name = write_rev_file(NULL, written_list, nr_written, hash,
-				      pack_idx_opts->flags);
+	rev_tmp_name = write_rev_file(hash_algo, NULL, written_list, nr_written,
+				      hash, pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
 		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
diff --git a/pack.h b/pack.h
index c650fdbe2dcde8055ad0efe55646338cd0f81df5..8a84ea475cda902936ee0b6091c5b4d462606be8 100644
--- a/pack.h
+++ b/pack.h
@@ -105,8 +105,18 @@ struct ref;
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);
 
-char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
-char *write_rev_file_order(const char *rev_name, uint32_t *pack_order, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
+char *write_rev_file(const struct git_hash_algo *hash_algo,
+		     const char *rev_name,
+		     struct pack_idx_entry **objects,
+		     uint32_t nr_objects,
+		     const unsigned char *hash,
+		     unsigned flags);
+char *write_rev_file_order(const struct git_hash_algo *hash_algo,
+			   const char *rev_name,
+			   uint32_t *pack_order,
+			   uint32_t nr_objects,
+			   const unsigned char *hash,
+			   unsigned flags);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes

-- 
2.47.0

