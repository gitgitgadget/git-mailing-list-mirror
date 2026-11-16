Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816109;
	b=K7D4b0dD5x3jzyCcIW1uwvhlNjVLEjYY4GiD+TjdpSz37wNkgaVbqw8wfpiB5IXkQdbD
	 oCLkHoEpurzhZMetpEkYkNZ4ncynJwq93rxsP3KLKBt1oxY5zUFWKb5ZCVPtiuFfNCNFt
	 H4FmeCKVrD/lXWWJBT24O/MUWB8HVSOqechcbNol0dCCrJB2JxQ3qPN9hb32TZbd44Ckd
	 LW6GiZRDO1olwiWX4r1qMQdHqDIc1MeCrkVoZUBwF6BCz0Azv9s5DylQrFjamtsi25YZT
	 bZ4YqyuKic9F2julbln9zlZ4CiC2kU73fIwaPI3XvAgGT2XXcpVxXInLwX5X0cxFeww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816109;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=cadKvdO3yvdHJzm8CdBeWTEK2Y+2eDsmHeTw6xiLmLs=;
	b=bnikwB4yNzN7GJHsagP/0k0YusTEvXMnTnfse+AKCkd19ukPVXO+AOKELfRBD6S0whhH
	 DK+R9toBzq/bSsHqCJhxwhwOIhZ8/EXraMyPHjuNqMj24F9FHZYcJHjEfZ0PDJg9y+QmP
	 uzc9CRglHVqQF1CJmDVIWb8B6uZm+9Mlv6flbdsNthfDmT4x9nl5IBD8OUJY7qDlEDcvZ
	 Y3mPrw1wdiIClVwCuAauLmmaZn8wsohCdz6GjA+l2xU/8pGg6wMOvVijyOFmJqsG0BPMW
	 QeeyfAS1VNtvtoBh4bhXF9aW9mN1Xlnpgwt8AK3MXZqbPtPn59BNqFckN8c0ijk73IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GV4Uf9sv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="zF/5LjZa";
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C4606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B03C4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=GV4Uf9sv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zF/5LjZa
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 133C11D000BC
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:01:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 03:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794816107;
	 x=1794902507; bh=cadKvdO3yvdHJzm8CdBeWTEK2Y+2eDsmHeTw6xiLmLs=; b=
	GV4Uf9svQUg7lVURUU5ZfIGKiRK9SGbXp+PwJxZOZniNfaWRmbv8X631XK/dkdh5
	MUFJ4fE0yC1TpP9uNcKt8yajJYHepj/W90ii94471sjX5f8nlRYi7M2LrLTvGmhS
	pUia9KzRJd2oqX+tszTfu9DJOJa4IhUtSBE3w3VXumwEHjyLfLcB5fHquf/bOTLF
	hATo7kBxeBQUlGkKxGzLJqMx/B0L7CLlfpX/EqYSq9gXp6xiuwWSLX074K4z3rHc
	HD+xSGZjRvc9zGqIQxi7sgBxFODI3bQW+M4YQvgRXl2dPHAJV+MLZbxJwhjHBqfE
	Vyk2GPLeLxaCrVw2dpmThA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794816107; x=
	1794902507; bh=cadKvdO3yvdHJzm8CdBeWTEK2Y+2eDsmHeTw6xiLmLs=; b=z
	F/5LjZajOOMZBpejraaQR0vDCshaE79xUtB9WsWWvBtLUzbLjqfg0OcqkceoX2po
	z7cSohWLMvc9Wi5Z1r2bIcf1y8I7wiSNIm5SBI4vgIL18vq/FgFmOvA0tgutl+LV
	NPkKK0knP3RCTbewrFGMUCSyJEL3anM/YzpA9BPxS/ht9QMhkO3lZwm7uqWz5n7x
	7iuyUAD0IMcZOgGn5yW+UaC823bo9CiKOWmyrU9aL92tT+jzFe1qiHIHfCR3JBDw
	WZndHgb7fm7aGde4rC4rydsz4hRS3z4/5ZNYDPq7usB0VYMnuS8trzIXcovBM6HY
	CZV9ZLVn8MftnqmXmAReg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816107; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:FINtMT6bSv1QkLsVVrPKJPthRKvKVW428Ve7CJOr4ASwlSL
	mEnqXDyZLCGBIzaB5xkadjLP+GPAxZIRUJ+IwOh7VppoeJuLHooOKKG5PWOr23nO
	KxNLSzGeF/nPp7VJrDC4GxijFSP7SD81iUGpy20nWb/UBrxVu1p8ihGKjAf5PSfO
	Wlg8ZK9v4tVvPBaA2BZZOwuBuSAg9993rc6GJPRBkLOGa0gSeYzSo0a7+GeDlW6B
	O7FZyaPsOZ6GE0eT9PuoiH7PEqEN4nH9T3lYIUmTG2+y+jMxoJFLyEbt4/jbQAmP
	/32ojXXiqZPjc3mECsMTYN98gpVcmtK0z4I2Hzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TFrfNSm9Sm5S9K5ozSTCWHfT1GgPTjNfYj8ClrwfhCE=:F9RFnW+VHXGv4J3Aqp8j/LzBgSlgarz64kVW1paC49M=;
X-ME-Sender: <xms:a7j6amRYxgYIzDESIFdzkSjlls_QPdBgxx7aUdFBmI-QK3-6D6plww>
    <xme:a7j6ahwaoSJ5XBNY2ICAlRZIdlW5592OJpVrCy3pMozdSEyu8855P6F5CCBzQj9BU
    NlgDSWmLF28T7zUaPqnmOpCwyGvQBGqjkMKAgdhbML98kop_YDxpdQ>
X-ME-Received: <xmr:a7j6ahc8JgqVtCCKDkJ25g82b3EwElC3ZcyUzwuSENUeDkvcDjFESA7dJ7Hd7F78sZdf3p8>
X-ME-Proxy-Cause: dmFkZTG2oj6W/WB6jBe/ZwbsCJxrjVRHLQazAgZ3FzzExBpjc2sc4Zhx6JwKmwxDK7I8nG
    TI/DZGJ2xCRXZaylrHf2QnoYxvJ1ofy2RRFs7pwizI7bOYBJWQyjV95Uk3O7FBV3/DsVMO
    Tir8WzjSvWnMnDiV0sCqbBZzNbbR2xpS/oTQhgZP6roAb9f6csLnl07x2I7MwwhpOtxEX5
    mucMQ1WEWlwCNqs+8z41eOwNgXCMUV7Xi2Zi2vyFRjNOfBCfWKxz0TQinQaGev/N0qDXLz
    IREsfEq00trasRh+2sj3dsH82RjNEEQJztALWyal1Mkl+HX7s7LcR9Hy+HT+iczf24DtEn
    7abImdrEx5ptqvq34ynuXTNFsHoK41qGddasJ1G9AREZo3Lv+tx8U/v949rY3spPus1tZA
    q9c24ThusEvuStdO5+a9Jayh1OO5Q0RQBw/13Y7RWkKtV/ZzL0VbENqJx+ncHzZgLD3Urc
    /zTWvkZhxsLsXuE1KHOaNfOzhr7Ws1X3REavV493ej19q9G+h08oU56DDgS3zXzbzdsYTR
    J0663QtIVqGdUu2mbInuOymG8xW4CNf0Z7YS1Y3NrnXnuo+jt3g9diUqfPchm+YNAI6Uho
    y62J7mDSK5Do/7Y3X5WXG3sc5izNW0xtr/xKwUa/1241Qgw09OmX9vQ10Fww
X-ME-Proxy: <xmx:a7j6atKIUisFta-N0clYYE52NowdEcOxXzE_hVWpcg5VUVJFvKfnkw>
    <xmx:a7j6aiFrb8CFa_RJ-OfaHVTWCJEqYt8IExM0HgCexwyMY2j1AgZLBA>
    <xmx:a7j6anoutAf7jOaGWENBjiXD4UhVADOTyxgYdQeV3GOKrJP2MO5Gvg>
    <xmx:a7j6arQYhqnTO0LJKAWeiL_AsXeo5VlPGrUVtypzDqxrIFTZldKWuw>
    <xmx:a7j6algWwquInR5Y0muiOjVqNZo1Eb1vYgA7EiRCdvG7UXPLjCrX0j2M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:01:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac28e1cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:01:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 09:01:35 +0100
Subject: [PATCH v2 2/2] builtin/repo: don't fully parse trees
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-pks-repo-count-objects-speedup-v2-2-9c8be218eaff@pks.im>
References: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
In-Reply-To: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
X-Mailer: b4 0.15.2

When the rev walk hits a tree object we read its content and then parse
it via `parse_object_buffer()`. This requires us to perform some extra
bookkeeping that is ultimately unnecessary as we keep those trees in
memory.

The only thing that we need the tree object's content for is so that we
can count its entries. But that can easily be done without having a
parsed tree object, all we need is its content.

Refactor the code accordingly, which gives us another significant
speedup when executing `git repo structure` in "git.git":

  Benchmark 1: ./git repo structure (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    9.635 s   ±   0.072 s      9.534 s   …   9.799 s
    Memory         3.4 GiB ±     0.0 GiB      3.4 GiB …     3.4 GiB

  Benchmark 2: ./git repo structure (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    7.676 s   ±   0.106 s      7.568 s   …   7.823 s            -20.3%
    Memory         0.7 GiB ±     0.0 GiB      0.7 GiB …     0.7 GiB          -80.4%  (5.1x less)

But besides the speedup, the bigger win here is that we no longer keep
these parsed trees in memory at all, which translates in a significant
reduction in peak memory usage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repo.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 45ac005c2f7..2c96a3ea577 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -820,14 +820,14 @@ static void check_largest(struct object_data *data, struct object_id *oid,
 	}
 }
 
-static size_t count_tree_entries(struct object *obj)
+static size_t count_tree_entries(const struct object_id *oid,
+				 void *buffer, unsigned long size)
 {
-	struct tree *t = object_as_type(obj, OBJ_TREE, 0);
 	struct name_entry entry;
 	struct tree_desc desc;
 	size_t count = 0;
 
-	init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
+	init_tree_desc(&desc, oid, buffer, size);
 	while (tree_entry(&desc, &entry))
 		count++;
 
@@ -846,10 +846,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		unsigned long inflated;
 		size_t inflated_st = 0;
 		struct commit *commit;
-		struct object *obj;
 		void *content = NULL;
 		off_t disk;
-		int eaten = 0;
 
 		oi.sizep = &inflated_st;
 		oi.disk_sizep = &disk;
@@ -889,16 +887,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      commit_list_count(commit->parents));
 			break;
 		case OBJ_TREE:
-			obj = parse_object_buffer(the_repository, &oids->oid[i], type,
-						  inflated, content, &eaten);
-
 			stats->type_counts.trees++;
 			stats->inflated_sizes.trees += inflated;
 			stats->disk_sizes.trees += disk;
 			check_largest(&stats->largest.tree_size, &oids->oid[i],
 				      inflated);
 			check_largest(&stats->largest.tree_entries, &oids->oid[i],
-				      count_tree_entries(obj));
+				      count_tree_entries(&oids->oid[i], content,
+							 inflated));
+
+			free(content);
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
@@ -910,9 +908,6 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		default:
 			BUG("invalid object type");
 		}
-
-		if (!eaten)
-			free(content);
 	}
 
 	object_count = get_total_object_values(&stats->type_counts);

-- 
2.56.1.763.g16177fe143.dirty

