Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C754854F5
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632970; cv=none; b=KS3hUhZfp0kSjP9irMRpM0qwStyw5v5mSCjo6LKdwcOSSkZYvbO2ixFtHdHOjcQyR1sMviL/mH+fApG8t4zhbxd0LgZyzRGfoz/OJHGZqlE8aA7sAbejJxDqoicfsP1rFqPQIW0n6hsU3CyMnEVn0EQITH90SfKipBh/R+NnINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632970; c=relaxed/simple;
	bh=EZTgRbvzkoMzbsVPYV5UTbmUx7HcxYeRzr4UTgiAZlw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tDj5XtDbi1C2DMRUSlLCXknAtKUEMtn4FHV067eiitljh9+m8EvwlwKbPmcYMBLcKvKEgK1vkVDgOY7AWi/tvl86k1Vc4bminHOegYrokKB1kbbEHI5GrfR2mLpLIokt/F86QG1Ni1TdUrrXwhYXuI+mP+B9vCHehCg5GJ5RVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU4omwF5; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU4omwF5"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso1367146fac.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632965; x=1787237765; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fBNwzj8PAVseYF059xChSKbCJ2OrAmcyMJbovs2zLY8=;
        b=hU4omwF5myz+EQncH3ajTkJmY7pzu7ydfyiuFU06sU4LLlTqg8Rk+AvfNpaRjkwOap
         O754OFCiG81TT1ZxdOvGgP2ay3P6iTxP0AE/8Ou9Gs0Dh+UU+uJHUV/W0uIQi4o9ffb+
         0qrrufXbq/DO1H+PpooEW0qPwi/IOdVcg/GfiEFMc9x7vxzYt749//gcD/juU/wFp0HK
         d59e8+x+0jgswLd36b8oD9tBo46Gb9Wkxm8TdVErhUk6j9wpdRE6NFZfqfzEhjRq9QN7
         BfaJ3jqSkBdl2Yh0qmWJMfM8MGQvVBNARAHzQ1IGSZjP6VyzK9f9wQxSQ7IZ3Oey8iXr
         9Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632965; x=1787237765;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fBNwzj8PAVseYF059xChSKbCJ2OrAmcyMJbovs2zLY8=;
        b=tAhvGCaKYsMtrSL6AdsXj6lIpzE2jvwA/M8mYsibsnY/c26FW2zzNp0Gj+rFFGcoxq
         i8HIHQTG4822+0jT9Jj3wWkzz6A9UmGKUUYm7qiO3PlPB98TTmETjTOn1OpxO8RhCnHI
         I4Rg8jYAB095qGo/jTw663qQIiPIDGqgNDr6a8hLIA1TNr45kVSa6H1qjePJlUy6TMcA
         B6qYXU9BXQe26pOBHDfU0yERDZRwj1aQ3mzlDg9Y5qxe7XaFB6sIT1tn9lGCXb6gW23w
         PoZHdMlcq5wQ2gaKet3SvSEWNHPSAAWCV5vpEPAg4Q+LcU4m8NMw+c0utVKIPyeVQ95j
         TZHQ==
X-Gm-Message-State: AOJu0YxwbRLXi/KWD6HX3ry7nMwNzNYwayCL7oaGwfIp8uLJ4mN6cjf+
	mZeZUX5bfzYI51xtmqHuw9eaMusI1ArR+GgYSes9nuhx2jLcop5eazFUIkNd1A==
X-Gm-Gg: AR+sD108yc0cWz4gapItqy4ehKoQqjeBtf4XXUll8O+3X8nBtVpwFxcUbzF9ix5Zje3
	7UZiWUHwfqtsBIajEBB8jajEXlDsjuNd9wRBTo0OSw6xlFg6QWUSKq390nfrr4UkS8A+Zcg9MDu
	nPf+DyJEpkeLmwNFzT4z/hX2ggHgLzkVItiDT9YgZHS0w14IPVyPUVyxy6ldRljHzEGor189R7k
	+E2zI/3+WByXiuK4q2EuaMFZsCotJ6VExlTYz3Ea/Zr/9AXiX96VjQoQ1YfJQnO689lpf7Cx1PG
	BQjRkqVeoFKqX8s82aQdcf7Abh4UFVlwxH46wkt9BCNXMcDDwKJ534XHDwpZUjkbht3bEc5cdkx
	S6yU8Q4azh1IveJaLYv7hJUvMcflXVX24r9Kni+rB5dtut5Lsw9Rs8+10eqeh2vJzzuqkngVYG2
	9XHt26b7CkbSwGAcTKODNwNHMkP+bCeyh6/zYCYAUdAjwToQRI2153WkC72BqKbuM=
X-Received: by 2002:a05:6820:1c9c:b0:6b0:ace7:c406 with SMTP id 006d021491bc7-6b0c41b6d80mr5669299eaf.4.1786632964864;
        Thu, 13 Aug 2026 07:56:04 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e656ef711sm1792777fac.15.2026.08.13.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:04 -0700 (PDT)
Message-Id: <e4528f9034099bfd13aa189ba6e4a225389da035.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:45 +0000
Subject: [PATCH v3 07/13] packfile, git-zlib: widen `use_pack()` and zstream
 avail fields to `size_t`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Bundling the two widenings: four call sites pass `&stream.avail_in`
directly to `use_pack()`, and widening either type fencepost alone would
force a bridge variable at each. Doing both together is the simpler end
state and is the prerequisite for the `do_compress()` widening in the
next commit, which is what lets `write_no_reuse_object()` lose its last
`cast_size_t_to_ulong()` shim.

The unsigned-long locals widened at the other `use_pack()` callers
(avail / remaining / left) hold pack-window sizes bounded by
`core.packedGitWindowSize`, so the change is type consistency rather
than a new >4GB capability. `git_zstream.avail_in`/`avail_out` likewise
reach zlib's `uInt` fields only after `zlib_buf_cap()`'s 1 GiB cap, so
the wrapper already accepted `size_t`-shaped inputs in practice.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 8 ++++----
 git-zlib.c             | 2 +-
 git-zlib.h             | 4 ++--
 pack-check.c           | 4 ++--
 packfile.c             | 4 ++--
 packfile.h             | 3 ++-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08c6d294cc..87aa8f44e7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -488,7 +488,7 @@ static void copy_pack_data(struct hashfile *f,
 		off_t len)
 {
 	unsigned char *in;
-	unsigned long avail;
+	size_t avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
@@ -2261,7 +2261,7 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
 		struct object_id base_ref;
 		struct object_entry *base_entry;
 		unsigned long used, used_0;
-		unsigned long avail;
+		size_t avail;
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
@@ -2773,8 +2773,8 @@ size_t oe_get_size_slow(struct packing_data *pack,
 	struct pack_window *w_curs;
 	unsigned char *buf;
 	enum object_type type;
-	unsigned long used, avail;
-	size_t size;
+	unsigned long used;
+	size_t avail, size;
 
 	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
 		size_t sz;
diff --git a/git-zlib.c b/git-zlib.c
index d21adb3bf5..a3b32d9a86 100644
--- a/git-zlib.c
+++ b/git-zlib.c
@@ -33,7 +33,7 @@ static const char *zerr_to_string(int status)
 
 /* uLong is 32-bit on Windows, even on 64-bit systems */
 #define ULONG_MAX_VALUE maximum_unsigned_value_of_type(uLong)
-static inline uInt zlib_buf_cap(unsigned long len)
+static inline uInt zlib_buf_cap(size_t len)
 {
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
diff --git a/git-zlib.h b/git-zlib.h
index 44380e8ad3..0b24b15bd0 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -5,8 +5,8 @@
 
 typedef struct git_zstream {
 	struct z_stream_s z;
-	unsigned long avail_in;
-	unsigned long avail_out;
+	size_t avail_in;
+	size_t avail_out;
 	size_t total_in;
 	size_t total_out;
 	unsigned char *next_in;
diff --git a/pack-check.c b/pack-check.c
index 5adfb3f272..befb860472 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -34,7 +34,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned long avail;
+		size_t avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -71,7 +71,7 @@ static int verify_packfile(struct repository *r,
 
 	r->hash_algo->init_fn(&ctx);
 	do {
-		unsigned long remaining;
+		size_t remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/packfile.c b/packfile.c
index 1d1b23b6cc..629fe46a6a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -620,7 +620,7 @@ static int in_window(struct repository *r, struct pack_window *win,
 unsigned char *use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		off_t offset,
-		unsigned long *left)
+		size_t *left)
 {
 	struct pack_window *win = *w_cursor;
 
@@ -960,7 +960,7 @@ int unpack_object_header(struct packed_git *p,
 			 size_t *sizep)
 {
 	unsigned char *base;
-	unsigned long left;
+	size_t left;
 	unsigned long used;
 	enum object_type type;
 
diff --git a/packfile.h b/packfile.h
index 2329a69701..3cff8bdcb9 100644
--- a/packfile.h
+++ b/packfile.h
@@ -240,7 +240,8 @@ uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
 struct object_database;
 
-unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t,
+			size_t *);
 void close_pack_windows(struct packed_git *);
 void close_pack(struct packed_git *);
 void unuse_pack(struct pack_window **);
-- 
gitgitgadget

