Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316168;
	b=z8PKOzc3CudIvNCeODjZgobsGq/HcrSlkcldzLtlopuVeBj/mLuX3a+cWBXRY3KpZ3Hd
	 8N7wibOriwuYomeUSEqef1uZ9jTePbDkTouYhtRyHTP3qcZtMoJsR1RXfw4zTFsO+sXIr
	 9S3GpFngaEDGsomLcgYDfJoNVDrUy6RROnDSDIs/p8/Wrrg27fqMtz5IXD2nLFJNE593C
	 SX6+jNr5qHiIxr9mKr6zrL5iB/LorjiIRtlxY26qUjbtqEVrzlZQOUYzRF2l44EOVQJj/
	 i5fBWjpLkvHYv1OgtAhEYAjRl442iJ/++e9fp/YSgZwkAwWECyy5S46oDTOJ33nzG/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g4cGgBPlzKLZLL6n/RFdLtciFZ4uhQOI456c6NFs0Z8=;
	b=0yiJ7Pdcs/MlrJNT6ykiCboZLSneGglY2Ou0oPAjVQI5oX3aTFjqeEvLXAYASPBN+SFf
	 X5BqcRsNbL2FyrnHfQTJs0XISwoc8MNddLPnrZGjIDVveLO+Z/A2Odfz9IwKcIm7oUtx4
	 w2bimYpkliObdzg+rLdzwoyrSZln2H09kGRUdk46HzGKvdEeYW1twER4I3HGa+gBH6AlK
	 NizI5MgA2R4cSNzAOk6a4twkjiNeR6VWKJH4SGFLB6gPP+5/m8oq2ZjaXDpcZRgsebO9Y
	 OtKn7VJDjxHmHQl6RZ/dEZXOlcDaQEXDk6oxQJV0SAti0PgmHRbIqtoqRv/j6OcZFnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGHbSpSl;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FDE606A32A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 23:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FDE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cGHbSpSl
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-8490a7d6696so129861a34.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793316167; x=1793920967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g4cGgBPlzKLZLL6n/RFdLtciFZ4uhQOI456c6NFs0Z8=;
        b=cGHbSpSlUG0HNVQys0dZ6ZJ0/QP4gvNPDocw+7zsFHdDSRmk5dV+3y43gbK4xC93wB
         qgzPpwzzZqK8JMDf5IfOevACb/BJGrE/HQsQSJDz8ciNj/o7RcK29XnUIJ0n0mFcIo5V
         BT5OBfkWX/89LlCabnOtH6tfmmxLshcP4zJVZ/BSkStNGdQfzUtLYzVfBBkgkIzI/gKX
         9TgyKybjWB05EiqysGgiidyOIQBjp1W3zFh6wvIUd69v1aMDmOb/Wn3v59RVhrOOCguK
         JACEaM8z2NZuXjDZau/NKkDiLWex6WG6yZTUIQDMV+uAJ9lUX9Ys38IdUSeRxYwOHNWP
         Ao5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793316167; x=1793920967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g4cGgBPlzKLZLL6n/RFdLtciFZ4uhQOI456c6NFs0Z8=;
        b=DucrxMZzobAFMxTv1RGZjrpmSVWMB3tnG7H4mPUbHoTYW/Gc2XDYg7rW/HaqnXUJnI
         WHvKS+qx8aWPJFaqczOINsSSLDlXERZTQKdrq6wvJr03lccGIaLiOXdLgNEbV/1h1vwo
         YbbFd7GOz/waOddXy8Te3MnoLzaW/WdAPRcS+qp4Iawrva3dZVeH0pAmE2QEMlToFgsf
         aKH8J/jo1N22KbA+BUZkNjPf0FN3rFvzJz6/XI980ytSNp+hl1c/OH1zAxbWxZNh70Is
         GVMpbdmnLZei01uqhE0zJwcH2I+xKuaxOtQ0son0XDCOS6DOyKRQ3IWQ00HC8qS4eWvM
         UC6A==
X-Gm-Message-State: AFq9FYLH/LTGO1p2vT3YlrQQQ+mgaxt5yH/apzjPb2BtgRD8UBnyXBsf
	ehNNdIrPtVQAcUmzfAQMusbuQH8RBts6KDMaqTyBxjeMUQs16yuZlh/3eQBmTQ==
X-Gm-Gg: AYBFou1eUxKLEluV4CQfQUtiEc1zvTh+aY1R3r5g4fBCTBT66pBFHbCDFtlGygJkSMI
	8KFBPJTXZQD6oWKJC8BEIe4OeipOXB4UmTROdnMhZtkTAx0RYn1/A+mLeHK2mjfE56vb5Lj8Rp8
	/Lcwj9nZOPEhhCX3H6pr0wl4+6kfpWD5IoIPivh8WQ3nkVvxhhjBrDF0QxtaefZpvmA3hNcm5d5
	LoMeqgnlbnAdw5hW21xYSldlfwH1TJIufbmGkq0RG2j+MnuM0stk1YkFio/XzXJZnWTwFNowtY5
	XwEha/PVtsNOXgqJmVKtryzXkRQnWzIYGfbd9HlPBX03HohbtTwWSxZ67PnQU02cjZJs7woChJR
	6wdPywNk9LSAfsjekQtuZ33qu1sk68x9DfryHCCF+EAX6De2t0niL6bYPpFTneKgcZif9QPDYeY
	pGpGUFeOn8nldrO7EzJYzn3UMJTxFMzL3Qh83chnCvWwWEPKIKH+V3q96B4iPoSGNZmoDfoCihL
	TQrN+HnrLixNKrM46E29aZD9ezd1kxcb9TMjo6sNtV4uqoyBSehC24CwTuPYUb+swnCGi1YYvlz
	6bTF36Bd6E+bb2B6gAvvQXXeRV7Fb+vSK9/SJt+Bsi6GqRpKiWvUb0BMDnyeq4+CWOW6
X-Received: by 2002:a05:6830:2e11:b0:81e:bb3a:7ebc with SMTP id 46e09a7af769-85d365f1e4amr509983a34.26.1793316166671;
        Thu, 29 Oct 2026 16:22:46 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm694924a34.15.2026.10.29.16.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:22:46 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/4] loose: lift loose object index parsing logic into helper
Date: Thu, 29 Oct 2026 18:22:18 -0500
Message-ID: <20261029232220.1245827-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261029232220.1245827-1-jltobler@gmail.com>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
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
object source. The cache is made optional for future callers that may
only be interested in updating the map.

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

