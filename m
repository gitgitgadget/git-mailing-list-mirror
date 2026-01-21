Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443F6481FCF
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999859; cv=none; b=mopNpGU9fvMqg7urE//wQ8LUasfgZc/VJbmbMY1SlsJwrKK+xuja2ZqsnKlTG/PjW0Z9tLrCBze0dRmn0ZClutidaI0kwuoS+/BpAXlfkt8hl/yuALxTCzkFvLS4o+x21owsm6aDzUYgk87oegiv1vDyCk8/fsyfcmveDtGP7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999859; c=relaxed/simple;
	bh=TIzkqrfiK7tsZ1Vnljemt4K5To+kAqmyCBMDrIl6kmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bYofGg/uUYTEmp5pb25u3LYqaNXyaOnNiSKWvZeflyYK9zAB7eldwIdHMpmV8zlLTJCt34yAXSHCPh66TZNmIOF/o7dw5h5gclwUxi8W1dudTn4KHd4OiEJrEyAyyZDueu7aH3G9AXl4aKXBePEajBrsdAYajE0ma1yaKpu+9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B07eIdgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDjr4jQw; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B07eIdgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDjr4jQw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4EFD07A0148;
	Wed, 21 Jan 2026 07:50:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 07:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999855;
	 x=1769086255; bh=Pm69Fomtm9auJjGU0PHLDIXQcXEqkJ3rnW+hseBWLpI=; b=
	B07eIdgS5KbtdztBkE1qnhi8bQEHxl18CqZukpldFAgbUTshu1QbankpYcfu1q27
	XIjkhoyO1Q9a5tzvtm6Avt0URNK/JyZQcwNxFaCr/Pi5TOfqR7lE1AUV9Y7kPfZZ
	bN1cCiFTEh1ZBqpZEke6o3xwfifbB6cDJ4uHBIgU4B0NMTUdaIsjPrE6wj+VhaRe
	lGx1ppwOSkx3m6Y1s/Odkdj2icFJvkonEmmJhPF1SiyNzkHAwZczLLEtbB2XPotB
	GR1tcPY+GieaKoXtEYXuO2HuGdfu3Jg/o0gPZKzuzBO145rK7KYLEdjyEeQwJg1y
	T/sMuSlOnEVO9aPS9rl0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999855; x=
	1769086255; bh=Pm69Fomtm9auJjGU0PHLDIXQcXEqkJ3rnW+hseBWLpI=; b=P
	Djr4jQwWjs7nlmUW39KOpYVorTUTZenKNVOe0YZV8N3zFlGOIxcjkPaFl1E5CLXQ
	ycn5Ms/taR1VrWC6sZyVBr5LWDUmOmZI3mrRqSVSscuoMblq4QuqT1PQT69+Z9K6
	hAIhZHrp4lwUSD0fkbldXk65ZVDxFk2oh7qXiq0c+HuT79Aw4gF3bhgJgkJHTmX8
	gubHmGh2jO9NZ2HfZoHQqbEnL0pSl1q1uzjBtYMMaRZ+rSymI4KSuYkqDVRxFPoV
	ir7BJIgI5+EXsUmWuHWs47Z1NhuslRdi9MLCBdAvyguEYyfrxkOzReRgqU9Rm4yF
	bjfYjTUjZZrSSRDYmDj4w==
X-ME-Sender: <xms:r8twadkWOcalJ4eirAKPea7g3ZKbPRUikm6ABXShbSJBCPGmVDeJGw>
    <xme:r8twaTa-y1xwJ3Hwm1-N3ZAVfL56V5vK1hUNPflqkGOxEymrRpo60k1O3R7qFIvsA
    X8_Hvbsqne5I1yGQkdlwJ9idyZs8vGWLjqXHzgK-KacZpzsR-Vi>
X-ME-Received: <xmr:r8twaQOPjJZelu7p6HfYK4t9uuLK64StJBSOUMt5Ur69XD8uEBy1YLyKJzLzdeqv_w9XEl-gOzlJgYOF-X8S9SV_wpK1sIZ4nKLsHFFTsXI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:r8twaQbMWoCVxJ9LW-e6kVhaNkrKgIIbf9nkVDqaAcM0E1i0qXF9yw>
    <xmx:r8twaW2QFNLIhoZL7id__aaRsY0-7KFUev16Uj8gCllFOhMcTWWqnA>
    <xmx:r8twaed_6h6A9zt4lJtQ4Q-yM97cphZX8ljgEAPck_3hMNRQlaVZYg>
    <xmx:r8twafHl4i6SNpILU16WqccmB-j8rtNhUvTNYnEWBRYuS3fgdtZYHA>
    <xmx:r8twaY1-oOlRi3zrGBESm-B2TV5tuZr9T98xC8LJvGCKycIRWYXur6n_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:50:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81da0d65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:50:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:25 +0100
Subject: [PATCH v3 09/14] treewide: enumerate promisor objects via
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-9-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

We have multiple callsites where we enumerate all promisor objects in
the object database via `for_each_packed_object()`. This is done by
passing the `ODB_FOR_EACH_OBJECT_PROMISOR_ONLY` flag, which causes us to
skip over all non-promisor objects.

These callsites can be trivially converted to `odb_for_each_object()` as
we know to skip enumeration of loose objects in case the `PROMISOR_ONLY`
flag was passed by the caller.

Refactor the sites accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c        | 37 ++++++++++++++++++++++---------------
 repack-promisor.c |  8 ++++----
 revision.c        | 10 ++++------
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/packfile.c b/packfile.c
index cd45c6f21c..4f84bc19d9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2408,28 +2408,32 @@ int packfile_store_for_each_object(struct packfile_store *store,
 	return pack_errors ? -1 : 0;
 }
 
+struct add_promisor_object_data {
+	struct repository *repo;
+	struct oidset *set;
+};
+
 static int add_promisor_object(const struct object_id *oid,
-			       struct packed_git *pack,
-			       uint32_t pos UNUSED,
-			       void *set_)
+			       struct object_info *oi UNUSED,
+			       void *cb_data)
 {
-	struct oidset *set = set_;
+	struct add_promisor_object_data *data = cb_data;
 	struct object *obj;
 	int we_parsed_object;
 
-	obj = lookup_object(pack->repo, oid);
+	obj = lookup_object(data->repo, oid);
 	if (obj && obj->parsed) {
 		we_parsed_object = 0;
 	} else {
 		we_parsed_object = 1;
-		obj = parse_object_with_flags(pack->repo, oid,
+		obj = parse_object_with_flags(data->repo, oid,
 					      PARSE_OBJECT_SKIP_HASH_CHECK);
 	}
 
 	if (!obj)
 		return 1;
 
-	oidset_insert(set, oid);
+	oidset_insert(data->set, oid);
 
 	/*
 	 * If this is a tree, commit, or tag, the objects it refers
@@ -2447,19 +2451,19 @@ static int add_promisor_object(const struct object_id *oid,
 			 */
 			return 0;
 		while (tree_entry_gently(&desc, &entry))
-			oidset_insert(set, &entry.oid);
+			oidset_insert(data->set, &entry.oid);
 		if (we_parsed_object)
 			free_tree_buffer(tree);
 	} else if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		oidset_insert(set, get_commit_tree_oid(commit));
+		oidset_insert(data->set, get_commit_tree_oid(commit));
 		for (; parents; parents = parents->next)
-			oidset_insert(set, &parents->item->object.oid);
+			oidset_insert(data->set, &parents->item->object.oid);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		oidset_insert(set, get_tagged_oid(tag));
+		oidset_insert(data->set, get_tagged_oid(tag));
 	}
 	return 0;
 }
@@ -2471,10 +2475,13 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 
 	if (!promisor_objects_prepared) {
 		if (repo_has_promisor_remote(r)) {
-			for_each_packed_object(r, add_promisor_object,
-					       &promisor_objects,
-					       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
-					       ODB_FOR_EACH_OBJECT_PACK_ORDER);
+			struct add_promisor_object_data data = {
+				.repo = r,
+				.set = &promisor_objects,
+			};
+
+			odb_for_each_object(r->objects, NULL, add_promisor_object, &data,
+					    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY | ODB_FOR_EACH_OBJECT_PACK_ORDER);
 		}
 		promisor_objects_prepared = 1;
 	}
diff --git a/repack-promisor.c b/repack-promisor.c
index 45c330b9a5..35c4073632 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -17,8 +17,8 @@ struct write_oid_context {
  * necessary.
  */
 static int write_oid(const struct object_id *oid,
-		     struct packed_git *pack UNUSED,
-		     uint32_t pos UNUSED, void *data)
+		     struct object_info *oi UNUSED,
+		     void *data)
 {
 	struct write_oid_context *ctx = data;
 	struct child_process *cmd = ctx->cmd;
@@ -55,8 +55,8 @@ void repack_promisor_objects(struct repository *repo,
 	 */
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
-	for_each_packed_object(repo, write_oid, &ctx,
-			       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
+	odb_for_each_object(repo->objects, NULL, write_oid, &ctx,
+			    ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
diff --git a/revision.c b/revision.c
index 5aadf46dac..e34bcd8e88 100644
--- a/revision.c
+++ b/revision.c
@@ -3626,8 +3626,7 @@ void reset_revision_walk(void)
 }
 
 static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack UNUSED,
-			      uint32_t pos UNUSED,
+			      struct object_info *oi UNUSED,
 			      void *cb)
 {
 	struct rev_info *revs = cb;
@@ -3936,10 +3935,9 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(revs->repo, mark_uninteresting, revs,
-				       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
-	}
+	if (revs->exclude_promisor_objects)
+		odb_for_each_object(revs->repo->objects, NULL, mark_uninteresting,
+				    revs, ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (!revs->reflog_info)
 		prepare_to_use_bloom_filter(revs);

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

