Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30224477E41
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922784; cv=none; b=P1DhLLJ+ORyldnGhmkOr4IfKlKtHGNG5VISTtO0MF/yWwbYvICpsLK5EJNW4CQLhPzmE4sWqDtHvEqjvJWo9Rm3UuSntmBEFGRd9mokvG4gchpqTHC8wJ1EAcVDpW56c+D+Z7pFgCvzsa6/tET625NHjY/USvULV7j9uQKns+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922784; c=relaxed/simple;
	bh=xbYgNUWj4+m0BjVlhY1zI/gZmzZhwoVkCZ6j1gX/xX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEn0vA6OZW3lQ9l4S4LTSilg6fWYL6hl0gOGan2OYOA76KLxxI51Ya3dX0t8j6ccX8jH3mMCFfVuh347Y69wrfct/v3NnTEG+pN+S/35G4l2XRNereTaBDvwaGi/5CvqIburl2L2C42QCaF4FI7qqw/J51P2IqbfqWc4a/9MsM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/tnFZr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/AYCkZO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/tnFZr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/AYCkZO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 903B47A00D1;
	Tue, 20 Jan 2026 10:26:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 10:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922780;
	 x=1769009180; bh=9IK9tGmUznhWX3U7/oLqpH/mUDkpXY5mYRpgaEbKs5A=; b=
	T/tnFZr4l1rZs3Kv3mGtSVRSUquKpTaKvToLtiq0tYCAgZG3UOdTmzZO2xWZH9pK
	/U4pnVKv3uNpGT+i5Q13eB9xLPfrW5bij5mV0PYsIc2I/2XazyB/PjBkuFm2Shw/
	XzVBufugWPZCR76YfG+s54vyQpWOVWNMIazIl6/wzvS+KAkSe3PrjQxyuo0ri4Qj
	c+gTzRNUjFtCqBDFscRZxmZpfaoz2QGQdye2P1+WJg+QmjBsEDk6s4hKmR6Lq1Fu
	3ZyRi1t1EA5/bB/G7FeiMwmvV5b/rIfzk9j3Sprr2ZvD6LLxykBbiQBh7m0cObBw
	tE7XY9dwKSC2/oPTjEO4VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922780; x=
	1769009180; bh=9IK9tGmUznhWX3U7/oLqpH/mUDkpXY5mYRpgaEbKs5A=; b=X
	/AYCkZOSoJXkFMLrt2ubo50HMg1G9iN6BaCx0UckPS+K2Xp7d0sSqtVU3ccUQKLY
	zBpBjYvIraByg18k8xjTkYcyTT2T9NgMPkbN0eFWHIyRA0hFGTMYzcxmnHV8WGx9
	z25OVO5a7m83wg21x9AWRjgozCPujTxweOblPBz9DlgoG1lR34uSHYgzLVUjQ4wv
	14isy1EyjuQfpZhiumj3ztbizxBsLUQ78plupe6aeDW+4SodxC8kO9zGCIrRrSTl
	yJUSSZ7WuTcTvCa96zbXWRzlbARlTIWlgEQAsYdKGo2u4Iw7HDVTJelE/bz/Tq+J
	d1DTzV81yhI5QQZVpJMnA==
X-ME-Sender: <xms:nJ5vaXYstnWPXoPoF8L5NFOjeF0sHscj2INu0_OUuAJJbIYeOFgtPQ>
    <xme:nJ5vadayeX7_xiUeCAIKWGXo4UOysZNBf5InKoTvgBXm2vIajus6erO8ecQfQY6Dl
    g99ArJvra2T_VIpxinIkbr_cBZjP7KsfI5Zx7-h3rsfC0RrP9QPtQ>
X-ME-Received: <xmr:nJ5vae92rw_QUkoH_KMuethA-1DbELqwpKp9MImOCw-5JJmNz1o5WIDW-hFh4iFTAuYwopjFZF3HlLiULXk-UW0DGrDpGxVZXzKTerC7Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:nJ5vachrBBJEz3dOONcotGW7_TA1xIkE5LMfNjqk1nLtaS5S-yTf-A>
    <xmx:nJ5vaefJWB6qRpQagOM8YzPVgz5rKj1yL4YZHYUOb7Tdqoj1Ts3wmw>
    <xmx:nJ5vaTrPvXJb7QpwVJ-bzStf-hSV-6rj2tJrMXxLIZ0Yk1_ktNzesA>
    <xmx:nJ5vaTBrYkDbufIdsNWdiTkm-UUGw58oeRkpDu5jZXpqCfNQtDzYFQ>
    <xmx:nJ5vaef9Y8lE6ddYLn1syp1ecA9I13CpVnEgYAUc5ZZH7JZUzNRkecv5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:18 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cdace754 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:01 +0100
Subject: [PATCH v2 05/14] packfile: extract function to iterate through
 objects of a store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-5-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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
2.53.0.rc0.250.g0ac79233d6.dirty

