Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793233462;
	b=rXCnPgw4lQjsgSuyH47KUd/Wr5fdRHrog2PF5x2GnmdxwsPVsSKf4WwRfU1ibMFjOwgh
	 Dsd+hLVqq2TUjJ8rFYgfkDK6FBlNO3pwkj033yqY0a6anh8OiAMpaIybWWi3jidlbbj16
	 WGSalzpKWhhioK52dRDYcsuFGyl9wyQP1yqAG06klR/z1uDIwieOtn1K8vVtKa1FThAaQ
	 MWPRyZTfE0HJtEcByiY+s1nJlnP2P1+0Lb7MX9hY4HJX0K8x04K4v8gNI8yVnm3/p88bx
	 mHoSPPOTk5ex+avQXnE2tX0NJ7E279JQYafD/ywEZpLvfyJw4Tg6lgLVbQKFhh0nycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X/IB8D66ov7AokDuYAT+wxW4jrquQBv8Rdp0YNB/hSg=;
	b=wLjbByv4GfsHKov3GviEqcc2FMxn6xmvJzMZe7z04bwezEigX4PAkN4ztc8ERZCAXlH9
	 2orRE4rsVgvIra7O5/sUn+8YYipzL1mtP0L49qgRY/SWdmz/Ueb1y534zdp6PaMXZjcj9
	 D7svMUUnXrOFqwRrhM802JHDpS1xYEY724Xma3/sRl6oDLLtjksHQ1+PwcDoHjgAQsqF6
	 nx2jDx4plvmeSvjqT+r3OFioP70Va7p6kDVG5AtN6F3w6rxSSCb7OhkiY1wnp6VDzPhnV
	 hfEOiGhaflb3MswS/kW5Syd3eX2zh4LnYQRv8KiHW9Cuh8uqqGfhHnmOBqLRIQyBlcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2zc7w+T;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC13606A32D
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 00:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEC13606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y2zc7w+T
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df0b02fe91so159408eaf.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793233460; x=1793838260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/IB8D66ov7AokDuYAT+wxW4jrquQBv8Rdp0YNB/hSg=;
        b=y2zc7w+TyhkbYTqbYrX6+XIyozAOkd7gaFriQBjFnwOALOz5BZe6UF1S90+wyGWv6V
         WFkoF98qjWZW/RHB/4zCtw1U3AzMLM2p1KlSmjGRqSAq6RM77e8t/1AQtG0F3xxL4OVA
         ENLeQq59FuGBZ/R+YyET/cIZFCWVt1IL2DdbUWJNT/NPaCEe/qO10qRG+4GPOwi89MHb
         BIAfGWTO3K8G1xryAVgRypQD7AO93g7gXEmRvUcm6Av1Zg3D6PxC8mhBQTbxFuN4XU5h
         C5lR+3V62aRzHpgJ348Oetuc/dzxDVdlUveE63R7TOQe79frCsZnF2x7ryYNRCcooXj6
         vawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793233460; x=1793838260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/IB8D66ov7AokDuYAT+wxW4jrquQBv8Rdp0YNB/hSg=;
        b=ZaUTFRrr7mF9OGxIyZJZhjt/j86aSK0gLBZtbcsEmbUwMd0jIoLJakKjrVjd9P912M
         VIoZMlJyr6oWcEg2KmW2utqLqIqkNjQ7KNa/GUQrFJIzU39J72jO9ZI+/ybiBp/UKcxE
         dtGQLgn88Av3dtlDaYjzOuPZ4EGDajPhAhmYPsKVWoPVuSG8hIciYOK/d8zoQtEFJ/nn
         8FsHXUq9kNe9T2QO0nb9sMrmDyVAbKS+zPfdqxznoPXeXsGjLA050E87a3LbCc/zFHTX
         eZM8ZvTweg045AdVojHSXe8t67/kb7PX8W1mmY6lksbn5grAqZP/lQ5XDgr/bRkYCFM/
         v6PQ==
X-Gm-Message-State: AFq9FYJnFvclxTupiUnvEeYi7n1QU/wycLvO+Lylx+rENIL+xK2HW8gS
	RRyQADmx3Oje1Tv+KnjUpFJm6EKBoLGlZkCXn0pLcOsYOpYflldUH1aZGx7OCA==
X-Gm-Gg: AYBFou04Ej+mCaFYQa9k336O1G0LYBYUI15UovSk2lZJsiTuhlf3kEbR+jZUyCtQgVD
	Eq+uMGy73wDx9VcUM9VIvdMujl8spMKZo7pgudPb7Gy3urHwkbxndvHSs7T/iKPqc4sXvga/Yxs
	IfJAeZIbHjDKWks/JvVzNRcSGp6UBxcPIPiuBHUGnsyGtaeeVG3yZUgwN4MwEDZVpxW6YhyXlT5
	dyn0gbEpTGZFC/rr5UdV7xmYDSLH2ky7ISZ6yNA/XyFH+zJwCNcGuNUUM/UGOw1h2/EDl5TpMx6
	l9Cc7/IHH3IonK9/ZmBRv848mJecDvsjV22iWTKX/2vYaBK4bdYmp/tPFax6NEVJRDPpFPcFIUo
	PLO/Jg9/a77/6k9EA5Q6Z5phNbHMwF4cpAOZlpdiinDy2/g3U8fPow2zx6sEaUtE2FaghessZAM
	f+z+OQnW5J12FO9bJQjSpHW1lBnP6PEVnswjlxxY0mxwcNTJKUWLtpaW0M4kE/DDhR5ghS1ayeZ
	PsU7nA0FQ4C0Vo2LzmjfCyaYgEJajxwLQpp2MP9jmgM/BgwO1Ao0PvS7w6nyQuQ9ZQLaOUPzS1R
	SnMUwhIIt/IwItnu7jP8xaVAbhozrt37Z6p7uq6BAoFRgIR6oesigt/gb0ezGkX1QbV6eYA05IR
	K96N+NCwasLpVlA==
X-Received: by 2002:a05:6820:308a:b0:6d8:462d:2755 with SMTP id 006d021491bc7-714ddf3c652mr661125eaf.37.1793233460470;
        Wed, 28 Oct 2026 17:24:20 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142bb7942fsm2976439eaf.5.2026.10.28.17.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:24:20 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/4] loose: lift loose object index parsing logic into helper
Date: Wed, 28 Oct 2026 19:24:11 -0500
Message-ID: <20261029002413.3291184-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029002413.3291184-1-jltobler@gmail.com>
References: <20261022234007.3081825-1-jltobler@gmail.com>
 <20261029002413.3291184-1-jltobler@gmail.com>
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

Mapping entries from the "loose-object-idx" file are parsed via
`loose_object_map_load()` and inserted into the in-memory loose object
map of the corresponding object source. In a subsequent commit, a
temporary loose object index file must also be parsed and have its
contents stored in a map that is not attached to any object source.

Extract the logic for parsing a loose object index file into a separate
`loose_object_map_read()` helper function that allows callers to
explicitly specify the map to insert the entries into. The
`insert_loose_map()` helper function is also updated accordingly to
explicitly operate on the provided map and optional cache instead of the
object source.

While at it, stop treating all errors related to opening the
"loose-object-idx" file as success and instead only ignore ENOENT. It is
expected that a mapping file may not always be present, but other errors
should be signaled back to callers. Note that this slightly changes the
behavior of `repo_read_loose_object_map()`, which now stops loading the
mapping files of subsequent object sources when one is unreadable, the
same way it already does when one is malformed.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 loose.c | 87 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/loose.c b/loose.c
index c6f4ee0ec6..5f72c644f9 100644
--- a/loose.c
+++ b/loose.c
@@ -48,67 +48,88 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct odb_source_loose *loose,
+static int insert_loose_map(struct loose_object_map *map,
+			    struct oidtree *cache,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct loose_object_map *map = loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
-	if (inserted)
-		oidtree_insert(loose->cache, compat_oid, NULL);
+	if (inserted && cache)
+		oidtree_insert(cache, compat_oid, NULL);
 
 	return inserted;
 }
 
-int loose_object_map_load(struct odb_source_loose *loose)
+static int loose_object_map_read(struct repository *repo, const char *path,
+				 struct loose_object_map *map,
+				 struct oidtree *cache)
 {
-	struct repository *repo = loose->base.odb->repo;
 	struct strbuf buf = STRBUF_INIT;
-	char *path;
 	FILE *fp;
-	int ret = -1;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
-
-	if (!loose->map)
-		loose_object_map_init(&loose->map);
-	if (!loose->cache) {
-		ALLOC_ARRAY(loose->cache, 1);
-		oidtree_init(loose->cache);
-	}
-
-	insert_loose_map(loose, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	int ret;
 
-	path = xstrfmt("%s/loose-object-idx", loose->base.path);
 	fp = fopen(path, "rb");
 	if (!fp) {
-		free(path);
-		return 0;
+		if (errno == ENOENT)
+			return 0;
+		return -1;
 	}
 
-	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
-		goto err;
+	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header)) {
+		ret = -1;
+		goto out;
+	}
 	while (!strbuf_getline_lf(&buf, fp)) {
 		const char *p;
 		struct object_id oid, compat_oid;
 		if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
 		    *p++ != ' ' ||
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
-		    p != buf.buf + buf.len)
-			goto err;
-		insert_loose_map(loose, &oid, &compat_oid);
+		    p != buf.buf + buf.len) {
+			ret = -1;
+			goto out;
+		}
+		insert_loose_map(map, cache, &oid, &compat_oid);
 	}
 
 	ret = ferror(fp) ? -1 : 0;
-err:
-	fclose(fp);
+
+out:
 	strbuf_release(&buf);
+	fclose(fp);
+
+	return ret;
+}
+
+int loose_object_map_load(struct odb_source_loose *loose)
+{
+	struct repository *repo = loose->base.odb->repo;
+	char *path;
+	int ret;
+
+	if (!should_use_loose_object_map(repo))
+		return 0;
+
+	if (!loose->map)
+		loose_object_map_init(&loose->map);
+	if (!loose->cache) {
+		ALLOC_ARRAY(loose->cache, 1);
+		oidtree_init(loose->cache);
+	}
+
+	insert_loose_map(loose->map, loose->cache, repo->hash_algo->empty_tree,
+			 repo->compat_hash_algo->empty_tree);
+	insert_loose_map(loose->map, loose->cache, repo->hash_algo->empty_blob,
+			 repo->compat_hash_algo->empty_blob);
+	insert_loose_map(loose->map, loose->cache, repo->hash_algo->null_oid,
+			 repo->compat_hash_algo->null_oid);
+
+	path = xstrfmt("%s/loose-object-idx", loose->base.path);
+	ret = loose_object_map_read(repo, path, loose->map, loose->cache);
+
 	free(path);
 	return ret;
 }
@@ -223,7 +244,7 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 	if (!should_use_loose_object_map(loose->base.odb->repo))
 		return 0;
 
-	inserted = insert_loose_map(loose, oid, compat_oid);
+	inserted = insert_loose_map(loose->map, loose->cache, oid, compat_oid);
 	if (inserted)
 		return write_one_object(loose, oid, compat_oid);
 	return 0;
-- 
2.56.0.173.gf57c9a7388

