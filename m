Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EBE484226
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946519; cv=none; b=A8STZIe3fLeeqUNnzslc3lu5Lr6GR6BCbqTyGMw7LtMMwDSleb7uPWumcxBNcTCZMi+mh/G9nKJe7mTycIsKrxIulD/wzR8/+FXiPuceHse4O3bv7NzTtxLajKQkYWAWWWs+p9RLRKcciPhc/eK17SQe970J2N+XRY75BDtsDy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946519; c=relaxed/simple;
	bh=81iHoAI/KT6xBAoRMTaVXIQHLhw6G8Afemgsy6et6pc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YjC9uBxBNBl3QxXRLmnZm70IPiNKqpcA0zddHM0DFJ+AwwBvlnUvSexd7fmpYkQaXtDJpgTZXNPiLbCHGdDRI0U0dEpzZ0xiln+onJd89g8pl41Z4cm33J0O6k8i81Z/8PuuzjW2gqr7fM16fMhsijGm1HvwDzOQzW8pqqVXyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA2A1aBf; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA2A1aBf"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb545db3afso887773a34.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946492; x=1786551292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Ylldsgxm0X49ShColpplmkasGP1stuJGaQ5HSaRUSE=;
        b=CA2A1aBfu+PwQTP5fsiGYYzzXPQgCckQS8ZZytPMszQ97vXaAJK6bSWnaXGA7ogvrI
         URemHexaPAqF7Q9ET62RItWX03MBdKjIIWZDmGKkiF/ctijY1Yb0wD3tj5T9PgJXmqSn
         tMKYQGo2YXJ3Vp1LmgRc3eEHZHqew2Fc/4d3w8bkd35qMLl09VTrJihZppSRRcLspBi0
         2f1ZSe6QlRIrwiXg3k3p1n/eBbaJDYvYo4LlQCPgExtOIHjWE2s7RUrfmyrjXK7V3hqb
         mqXQs6p83uWey+NQGt7p1NTZngS2jlHs9dP3LuMbphqDEJY923sXDku1YhiTpBczdD+k
         UoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946492; x=1786551292;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Ylldsgxm0X49ShColpplmkasGP1stuJGaQ5HSaRUSE=;
        b=hnZOF9YWU51cnlY3KJnFm4MM23hAnIviji7wa4VHvklN6JVUz7vwJiBlLMEtuJq8EQ
         /io9CGxT0PJ8TMa2mI2/PfzGnF3lKeV4ddNe/Ox+75N+SMH4NR/YIbX3IabcbClxYwk3
         O8n31w5jsR3HjC74hByKkKsEZf5gDA6n+Ncv+l1309LwWkP0jBpqPgpKk23UXESuJ22j
         0amwVlTRKx2juItUq/qONlr+Xr11XiAgQ31WZpdxdnWjQ0mtC+KMmOs5gk4NpCDBuDyV
         O4HLj6+baG1HIzgcJpz1HWrgVa84lo/iMbaZ/ut+hhxgessXd1ad09PkgiMBci9j8t/X
         w+9g==
X-Gm-Message-State: AOJu0YxI4isJ8HrAwhuZ9r8tyNMsT19JvvThkY9yIcvaqyd1tiydn/Nw
	s+Si8en/h6t4a9hGxs4z4MjJnERAQlam6ZCM5m16b52Lh/O/kZ7oWWQKSSCmUiZD
X-Gm-Gg: AR+sD118YNA8GmabG+HdI3O4UkwH12uhkuKin/JG2Ytnlh4jKOZyuegU4fziMor6ATU
	k+ob4H9uAojOgV1oc2fwTIkOjIwbRBA+WDeFBML7EGj2ZJLNW6Svdv8tZFAmNsFSNpjt7GG97x8
	jz34SMK7jQBjejKKHK/vHDaxUxWNeLqYDdWexRYAQPhPuCbR6rFQV4O1PIk82c+XLax+6uRbiVu
	6Zj+Gr4JvaIwd3rZxwUwKhB8mGbdmX4XlognpXsZw5iA8Oe5+62dKtnrmDmzQqQ6OHakeKDgtn+
	Ok6K+K3Gm6vlndU7iJplWaFV922rtII4+XkHgiDgnyNNjWBFUcW9BYKQGtS2NvfHxgU6V6rqs7L
	HcY/sZHMEO6FHlcSejtb6G6c3ym1bI0PdsRV5hpmZs4xr8/qyuL2ne0jyzVDX8GYwMszheulyN+
	Uw4Wam4XQCbjdjlGzaVpwStE/Lw+swFfcgG9CHv8o05iY2i9K+sbX7r37D9sXoq45pCA==
X-Received: by 2002:a05:6820:2205:b0:6ae:410f:c745 with SMTP id 006d021491bc7-6ae97033575mr3558203eaf.30.1785946492061;
        Wed, 05 Aug 2026 09:14:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93cbfa76sm3204236eaf.3.2026.08.05.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:51 -0700 (PDT)
Message-Id: <ca928b457959ab8bfa643c65f83ca1ec4289fdd3.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:34 +0000
Subject: [PATCH v2 07/12] packfile, git-zlib: widen `use_pack()` and zstream
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
 git-zlib.h             | 4 ++--
 pack-check.c           | 4 ++--
 packfile.c             | 4 ++--
 packfile.h             | 3 ++-
 5 files changed, 12 insertions(+), 11 deletions(-)

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

