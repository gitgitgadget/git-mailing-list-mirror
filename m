Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF481481FD9
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999868; cv=none; b=OWu4JfXu8K7lR0GROzEQu46vSGoj6rfy+UTZ921Mv2upEQo3I8WoR//xmrC/HwPRwEaYhJzMMxRPobvQjbt2PWsdlfbkIqWXnkUKE0TEp4fgN/qw3Gf7JksLFjMrHjP8FamjenrKvFu852S4OscHuigvBT26zQbECmKoiAjopts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999868; c=relaxed/simple;
	bh=Ai9w3jwZ+gi+eutVYHMUP1E70ymSk0Zk+uc1cyUyEjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpuBM0STPsfLeFW+tTNPsUJt9KYF1OsNOGmpInz7TBmvd+c11VwB7RRX8UPguWJTxaKXrYn62KuDxbnEbSjwptBkcqDMSTMGk+mw0d5Fz0EHMeF91rNg2x2FR+GKsDCRCHq2R4c4+wJKUC50Nn53gpEbz3N/t0I0JLUsUDUTbP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DrLZqGFA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C4uzKBvK; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DrLZqGFA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C4uzKBvK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5C2D7A0148;
	Wed, 21 Jan 2026 07:51:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Jan 2026 07:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768999865;
	 x=1769086265; bh=x0XqgeQ8m/K0SGL+8LZ3PURaW1Yaz+lWOc8CI4V1yC4=; b=
	DrLZqGFAG/IC0RRP6cGvalboQ7vcpXo+d6Ktn6y/E0fYg2tQWnSrepnEzro7umYT
	ino4c0r3eUSKB62mCgJMQulVRhtQs8hpPDwZYuudIdz93oBJnX9DnrrBLFZkLZoV
	r7PKKpAjIZqrNez277314FVnXn++AkTVVhUj93ozDwIE92cDgAtFE6lL4xQvIZi8
	qxba+MUVIvUaX8xg4JBPeSuwKQztGZs4/RL7Yll5g/xaT4brofts3FuUuBzP7jWp
	s8izrv9f7kvOyj4M/xABf0IrfVMjXZ/Azgvq6yYmNrfoOVA/ZuNjPmaigeBm51hE
	XelK0Cwgvm1FSp6bJiBUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768999865; x=
	1769086265; bh=x0XqgeQ8m/K0SGL+8LZ3PURaW1Yaz+lWOc8CI4V1yC4=; b=C
	4uzKBvK06RMZIVKeppDmLlv+mtSU7kbzjavYyGdYPEHspSVPnFe6m1mgD8TjVfYA
	DF35MVtsHHarzJdvTYgPc96tugeNlgIDtPNe8PD5ekv+srTMSytZNj+1IEaTvuPz
	zwe0NEQIg4lskc+cuhtYsWXJwCDUdAY9bwuhVKn26l8uABHRq7YQ6dQkH+OI2r0z
	ixKlZ+vN0gQMUMMCWNpC2zfK/nbGCfavM9Sux6QbncM9y9vUu4NS5v1AA//UtIRj
	9WzJIOUeUybN+jwqSQGQxFar4eugXa4lUZG57haM10JJP5D1sU4fhYDkI5iXqvKv
	puMo1hVBW2FfcpYzhGM/w==
X-ME-Sender: <xms:uctwaWc4Rppar3plfZ9uwBHYbcCjge3KjhEAVc-CGvMQb_-cTl0DEw>
    <xme:uctwaXNOtXrb04IFfRD5uHuR8geSPkFxSY1b9_VZjc1pNs10Mig03NNHJalUJvktV
    3zpdmQ1IYiSkPozwdimHlaKZiPhaFOAsqNs1uBJ2mKwH_CshoMB>
X-ME-Received: <xmr:uctwacjGm52HCxvZEfNuoCcGnJWEmTfDpo0Q6KEOVHP5bw5SVuXaqNYfT-TzB6RfguKmGbpb45p3RKeuQqPAB4fSqrt3dqhg9-HUkMpRVSM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeffedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uctwaS1ha5kk2fqmYvLkVfI1u7pgF3pAC_-woEHEPq12gX30fvQm9A>
    <xmx:uctwaegDxBSe1kHPJaUSupbQu9w_VLwy5VEX6ddv5OMvZ2FRZALcFw>
    <xmx:uctwaadnbguYQ5BTdjv2GklZ-uEMSy1dj62lsuXluzZh5hiPtB6PQA>
    <xmx:uctwaZk_AffMup7gVi3J4C6220VbajXZ5U59Yq_DYhHtJnWnf2u13g>
    <xmx:uctwaQA3aBJYoJEWgNlTk6zeGLfwNS3ppbpsG2adCNYz71bEaT8gTRHz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 07:51:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39e6ff86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 12:51:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Jan 2026 13:50:28 +0100
Subject: [PATCH v3 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-pks-odb-for-each-object-v3-12-12c4dfd24227@pks.im>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

When enumerating objects that are supposed to be stored in a new cruft
pack we use `for_each_packed_object()` and then derive each object's
mtime individually. Refactor this logic to instead use the new
`packfile_store_for_each_object()` function with an object info request
that asks for the respective mtimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74317051fd..223ec3b49e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4314,25 +4314,12 @@ static void show_edge(struct commit *commit)
 }
 
 static int add_object_in_unpacked_pack(const struct object_id *oid,
-				       struct packed_git *pack,
-				       uint32_t pos,
+				       struct object_info *oi,
 				       void *data UNUSED)
 {
 	if (cruft) {
-		off_t offset;
-		time_t mtime;
-
-		if (pack->is_cruft) {
-			if (load_pack_mtimes(pack) < 0)
-				die(_("could not load cruft pack .mtimes"));
-			mtime = nth_packed_mtime(pack, pos);
-		} else {
-			mtime = pack->mtime;
-		}
-		offset = nth_packed_object_offset(pack, pos);
-
-		add_cruft_object_entry(oid, OBJ_NONE, pack, offset,
-				       NULL, mtime);
+		add_cruft_object_entry(oid, OBJ_NONE, oi->u.packed.pack,
+				       oi->u.packed.offset, NULL, *oi->mtimep);
 	} else {
 		add_object_entry(oid, OBJ_NONE, "", 0);
 	}
@@ -4341,14 +4328,24 @@ static int add_object_in_unpacked_pack(const struct object_id *oid,
 
 static void add_objects_in_unpacked_packs(void)
 {
-	if (for_each_packed_object(to_pack.repo,
-				   add_object_in_unpacked_pack,
-				   NULL,
-				   ODB_FOR_EACH_OBJECT_PACK_ORDER |
-				   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
-				   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
-				   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
-		die(_("cannot open pack index"));
+	struct odb_source *source;
+	time_t mtime;
+	struct object_info oi = {
+		.mtimep = &mtime,
+	};
+
+	odb_prepare_alternates(to_pack.repo->objects);
+	for (source = to_pack.repo->objects->sources; source; source = source->next) {
+		if (!source->local)
+			continue;
+
+		if (packfile_store_for_each_object(source->packfiles, &oi,
+						   add_object_in_unpacked_pack, NULL,
+						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
+						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+			die(_("cannot open pack index"));
+	}
 }
 
 static int add_loose_object(const struct object_id *oid, const char *path,

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

