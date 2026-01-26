Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66AF32E6B4
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421099; cv=none; b=EvNhxHKO9RtLb1vf5SSm6+qEO349h8+gOdq3tGEOg3kAvCGNUtwOhWz8lOGwY+H5VwAIcQJc0/qw1oKbTEd9X6NGUigoq2rTJvCUrBDSrpewv94IzKTMsjG8Asok71SSsxotrftMB0MkcwKgGDxZYIhVqHZUD2RUmgzkcV1ZPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421099; c=relaxed/simple;
	bh=Wkv57ye2gOXZQ1jmx6F4BKvA0/KdysuWCMPU/hJL91M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo31eSwDwnko9rznjncaTo6Dd5GKPRl/vAU070XdnxRxqQ5LziKNxxRCg23bWCfok+nUUbB/NQQ01zaiTHRXLDUJd6Sctx5tZkcGzZ0ROc7SX6/YXI+AfnZCfoYfDZiVgPQwXAE8MfxNsTZ609W4bVyOO9NSVu1w0Ev0ln6yu7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=blAr3VSl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wH0IyXD6; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="blAr3VSl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wH0IyXD6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CA0901D00085;
	Mon, 26 Jan 2026 04:51:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 04:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421096;
	 x=1769507496; bh=2+UWcXXz5zUMfjUGKv8zcFbGvVIiEx35mcItt/KzZFQ=; b=
	blAr3VSl93OgdAeq5c/bI+hxeqZvoCVh2CQ/H39wAoqYCrPW8GllL7pMr3yXd1pz
	VdOmNzjWcIjnJYsJkjG4/ggNJYGxp6U2DpdRvi72Z2XiyO2E4GgvUFmzNHYZjJaT
	v7wFKcApp6foCN7VLnMCxy7orDsjl+yh3ntsIi99Vx8/BUO7H27V0BMIvgv50D5m
	tt3wNdFWm6Ngp1Co360IZ17fPBB444q7fUv4j0/zqpXhZATsHsBcGGgwZE4xOOuu
	LmpfWSq0AsC8mosHg0ScYqGFyGeV26AQdGqx9xeqrOZA7SQAAyR2cU0kwZVnquRU
	5OWI8ZMgZKlmUdXgIZjrCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421096; x=
	1769507496; bh=2+UWcXXz5zUMfjUGKv8zcFbGvVIiEx35mcItt/KzZFQ=; b=w
	H0IyXD6Su7mGYxfIxvcqyHeADnGT0QwcXatWQZ4uU0pmjF6M+SP4QgCtMPVVXT6C
	avPOmcNm4sKLHsgTC/V+eTkvg5dBmF6/jLgsldbf50lfbZLgKWq/9pFYjuRoV3fK
	a4usBZsJ6oBLoYYVMUuBjaQ5FOIMmKYO/SF0W51RweTaaX7njIUr2IX7VLm9J0sz
	KKe475Hc/dpCUtLljfjP+xI15mtyb/68dIzA4oDJXxwI50Cl9pA1NoICkOgwp6Du
	yCtZAfd7buyjX4gPKO/+ynIr9UY3bcqjwOhdazrypOQNU5RwHbxOCkGVdUvXvNf6
	ILHKAb2v9rF+L8YdoSyWA==
X-ME-Sender: <xms:KDl3adl79dXqBYv8qCtHvJRS9SFK1FXF_SfcbB4DmYymZVyytfuAwQ>
    <xme:KDl3af1xBWQy2vGqYAY0bDJdfFZnOmoAUhymHMRA_4SeyYTfx6a11KyaGwe5IxfdT
    X8XveNlfjHgE5Xqb-I3OSkMu_aDGBHXRTsyCUpTZVzNQERF0pJIfA>
X-ME-Received: <xmr:KDl3aYrk4GNKaI6Rj-HGX61240bLXaQmdCcuz-NsK-QBuOOua77MOJKG7cWtghobPdAY5p7zWkbJ8yNJFJTWjPqMtnNJ20mLRWvO2LMny34iqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KDl3acdYbchaKOEVdvz7jo8p6P7_WQKiu9O9DHw3KrrI5qjjm2u34Q>
    <xmx:KDl3aXrMBqvcZFwhGTCvmltOeQpKOBjMciM4i_x57lcJlgZf3FjOAw>
    <xmx:KDl3adH5qIiVOYIPn1M0_VucACILcIxCAAOSjqit9_S1R9op28C6zQ>
    <xmx:KDl3aXs3-xITf1UpNMeoRUsZ3xlUTbmT6C61OPuAjnyQeqaXdlrpWQ>
    <xmx:KDl3aUJbEXwTk1Zv0j4mAPDeS7Sb4Z2oMpcaAhdTpBeZU13JNATCDWYa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbba4e18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:21 +0100
Subject: [PATCH v4 05/14] packfile: extract function to iterate through
 objects of a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-5-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In the next commit we're about to introduce a new function that knows to
iterate through objects of a given packfile store. Same as with the
equivalent function for loose objects, this new function will also be
agnostic of backends by using a `struct object_info`.

Prepare for this by extracting a new shared function to iterate through
a single packfile store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 78 ++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 33 deletions(-)

diff --git a/packfile.c b/packfile.c
index 79fe64a25b..d15a2ce12b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2301,51 +2301,63 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, unsigned flags)
+static int packfile_store_for_each_object_internal(struct packfile_store *store,
+						   each_packed_object_fn cb,
+						   void *data,
+						   unsigned flags,
+						   int *pack_errors)
 {
-	struct odb_source *source;
-	int r = 0;
-	int pack_errors = 0;
+	struct packfile_list_entry *e;
+	int ret = 0;
 
-	odb_prepare_alternates(repo->objects);
+	store->skip_mru_updates = true;
 
-	for (source = repo->objects->sources; source; source = source->next) {
-		struct packfile_list_entry *e;
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		struct packed_git *p = e->pack;
 
-		source->packfiles->skip_mru_updates = true;
+		if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		    p->pack_keep_in_core)
+			continue;
+		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		    p->pack_keep)
+			continue;
+		if (open_pack_index(p)) {
+			*pack_errors = 1;
+			continue;
+		}
 
-		for (e = packfile_store_get_packs(source->packfiles); e; e = e->next) {
-			struct packed_git *p = e->pack;
+		ret = for_each_object_in_pack(p, cb, data, flags);
+		if (ret)
+			break;
+	}
 
-			if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-			    !p->pack_promisor)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-			    p->pack_keep_in_core)
-				continue;
-			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-			    p->pack_keep)
-				continue;
-			if (open_pack_index(p)) {
-				pack_errors = 1;
-				continue;
-			}
+	store->skip_mru_updates = false;
 
-			r = for_each_object_in_pack(p, cb, data, flags);
-			if (r)
-				break;
-		}
+	return ret;
+}
 
-		source->packfiles->skip_mru_updates = false;
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, unsigned flags)
+{
+	struct odb_source *source;
+	int pack_errors = 0;
+	int ret = 0;
 
-		if (r)
+	odb_prepare_alternates(repo->objects);
+
+	for (source = repo->objects->sources; source; source = source->next) {
+		ret = packfile_store_for_each_object_internal(source->packfiles, cb, data,
+							      flags, &pack_errors);
+		if (ret)
 			break;
 	}
 
-	return r ? r : pack_errors;
+	return ret ? ret : pack_errors;
 }
 
 static int add_promisor_object(const struct object_id *oid,

-- 
2.53.0.rc1.267.g6e3a78c723.dirty

