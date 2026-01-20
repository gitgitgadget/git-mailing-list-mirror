Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0A47DF89
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922812; cv=none; b=IVOcLGmyqw55gzK5tsljj8Ww5o/EpFckhBJVtdIxD28y1M0fxF+SrzRTLLe3krShivAVZxLlzf+WRR/cRvHiSpF7FgXhWvRcID5KPxzi3FHKNo+JaOyaGl1Du+VnS5dR41x54fWWQPWyt3NlogBJYUDGeC6F5WyMnC37I+tYcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922812; c=relaxed/simple;
	bh=Ai9w3jwZ+gi+eutVYHMUP1E70ymSk0Zk+uc1cyUyEjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iaO0YWsVX+UhYNesEtYQvP7VRqKmHdSPyDQYFhEP8oVN7vaFT5ceNBxGbPbSHySa+mQCpd/qxvQkQrWDRrPSc9n999uBuMG7lZX87BAqN7sIk52HRYLOSNw05AdLpPdK4rc+mTWYxRlxUaLw67dEmWiqzBktLjDjM8TDuqRO+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g9jFfDyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WgOaamog; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g9jFfDyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgOaamog"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 50E771400050;
	Tue, 20 Jan 2026 10:26:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922810;
	 x=1769009210; bh=x0XqgeQ8m/K0SGL+8LZ3PURaW1Yaz+lWOc8CI4V1yC4=; b=
	g9jFfDyIgE3wZWb1W0IHXvAF9NRITN1BKae1a6tBUP7v7BaFu56sCggYEuI4g90M
	feC8eRxkrI4w1WJe2hBB5+Qz9GJIxiwLuerqlIc0hLmCtdF8R8MVP6B1PmVNLzX1
	Ulv3fnvBLP6naoYLb4qEiGhYB8XGcCbqp54yPI0Q7XpbZZK7I/rkREJlXyVjyd5h
	07nMwSHJ/l+KEAeOtklVBg+mGC3PlcdHINqQw1tKwUSUmVCi+amPAalu2wDZWZ7z
	/XsdBrCdGLP/7KKqJbcZodvyW9F2EDBwARHfhyumwn4y85mOZv4Y4PQBqJAsSww/
	kcVsfz24ekvq1ppVimZsaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922810; x=
	1769009210; bh=x0XqgeQ8m/K0SGL+8LZ3PURaW1Yaz+lWOc8CI4V1yC4=; b=W
	gOaamogGtboGNe7BJdDnbq0DIhtXRhwerroAx4J4Ji6Tqd18EhsFKBaya2p9GQgo
	MZqSqRgItdsHxS0pEjj0QRJO+gUiVdFY59ED+zTtdBcr6LKW5TB56a/hFXd3RYKx
	QnQGgiHtK6CGEVM3qzZ/eFtsNCyMsC4+ZLEYJAgeXYKjl4PcK5tVIActl2HP0VEn
	zFoIoua/NiQXpq0601DsCcdbbtOyi2tJ5hWYwY169j+Zc0e10tMq7/e5Sl/ReCbn
	WkgrXaVKB0oNCuniy5/L7LfrMKPvbqNjNKNltzgDDw+oljNMw4Gx/TVLHOFTRzj3
	/qOtRl+RifMfJWMW1Bmbw==
X-ME-Sender: <xms:uZ5vab6YTmHH4qTFg2PGIvJxtTpCEmI7brnViBfX-dxUtQgnI4KPsw>
    <xme:uZ5vaX59CAIcbQ_m2wcwcRyhyCJbaEeQ4Uy3rIbxy7JUOreMyTKQHi57mkNsbXxPx
    NptkV7hUxuHuDjK_pfd7S0CKcBEq3GWbLQzpO6jxn5LZIraApVdhJA>
X-ME-Received: <xmr:uZ5vaXewbuBrvVxyGJxlYbJNJJ75Ys95THG6uDg4Awu3ttnTc3Oo6fGCfuo-ezS4waDE6L1TRa-6Y6ncn6JbCmiXSpYrkREWYLuQ0APFag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uZ5vabAagLpjzICcA9LlHpQWZfXQ6lJSnBurtQrHXqelltVwCxVa9w>
    <xmx:uZ5vaa-yBmhWwnJJZ8lGs13Jb9La7C_hVt24olT8OjPV3Wgl2HVxrw>
    <xmx:uZ5vaWKcTRkLk_kLm7r3ZmQdp4WQAgyy44ZixqhcMfIIJW0LCfr76Q>
    <xmx:uZ5vaTi1zi4gsA2BCNxkdg_Y_rpw9ZW3I93pZAqNCSlHQdHX_dQe_w>
    <xmx:up5vafgVLsaGekqM3FptgFxqBrrFszPEdDJ0sTJo3kALD9ku-t0scIRF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 120b9f35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:26:08 +0100
Subject: [PATCH v2 12/14] builtin/pack-objects: use
 `packfile_store_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-12-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
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

