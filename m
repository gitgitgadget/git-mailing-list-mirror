Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE912EE262
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891176; cv=none; b=SpegHG3U8zjLHNiiF2sYOAZJNu7mMRfDkgPuxny6PCfMGODsCH2l03fVSTiBt43muzE7cvZhpAFZfVKqHA4yO1pENKYzMzETlYt7rm5fiUAnw2AYjtU6G4tH5G8DBNYUusVR9A+M0LuKsRPEUSfGWS9ab5xSE5ZHRyD6Cv5jHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891176; c=relaxed/simple;
	bh=XI7lKVHKtumTnxm++dShzYXkVhBm4cEENVKwksDp57c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4r/jNmz0wrNAZltdfw+aP7DhTat9ufi7YFnC28vgnZgPaVSSeAqza8+blBG2dyVtsmIvB7t3s1twbIsj64Coz1EWa35YkmbAzGnec3fxWqkxz8qiQ9dOmsMFOG95gCcO0sRbuXUVpkIfXPHlC8N4Fa5URuHjnXLhOCACV1L+HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=We+sRwoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FA/Junpn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="We+sRwoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FA/Junpn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BD02140012D;
	Fri, 31 Oct 2025 02:12:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 02:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891174;
	 x=1761977574; bh=No3j+gyTaBQKnX6yaS0fnjDTAvMi4PpwAMmaSisBj+U=; b=
	We+sRwoe0y5GoXFGiTzEf0PDJ/NR7XwjS3Sw44md7Aed1LF1rdnTGdXC6siKOm21
	4FtWHEav9LXdtFfLMXpNZTu4msPvVtqR8J55ErF9hZj2e7A4Rd7mwViMBICPuf4b
	1H/KSkEAs16AwC+GlVjW0Zg0G6IarTEOKIc63a867Fw8hgqsyTCyt7SJrUWtJxdt
	dVtWpgi14bKg7n1dO0RzVXMmMaj2KDTi5PjhM84L3Vo73lvXulbo2levJHx5QzYC
	hjMJPkytZ2BAEib05ux71Wxl/gQiFH++qa4oMCfAnTRWl/LE1FOisitCq19FPXxl
	+smSNAcNoiKMqHi6YLAmyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891174; x=
	1761977574; bh=No3j+gyTaBQKnX6yaS0fnjDTAvMi4PpwAMmaSisBj+U=; b=F
	A/JunpnfF3fYtS1PE79eyfW/LPOdQyAGzq84KfC3MpLmF+zR1JIci4ltbsS2m8EG
	+W/oD1lT/75pF6iPShgcnEBgLyT5NHymbNkBrBnv6P3abNejXTokyxGZCLKUnmp3
	AAUtGkUxMYM5j/J9RsOM8WMvOzP7frXdAeEpeWmeocl9E5GDv+a1F+xL3FBp5+k/
	/Wxego5CDuZuF2NAKlT4NSdLEW5+cdyV6ifAaBxtzajRqGBY55pq9nKB4erxVzvh
	VpCYyM0KMhQiEYc55X3W/50BeDP/5iYihnJZKqQbio+34uPiZ/yFk66RGsPEv/gA
	ram7nmxL/slzUWGt+KlAA==
X-ME-Sender: <xms:ZlMEabvywMXwecBL-exeVnJ2jsHCQWL6XUXZ-INKdtLmbB4hGqQVzQ>
    <xme:ZlMEaT5TcS04MTipP996SCH2fqFHYJKh475BXYctAH3zC6Dybfmug-LG8F0wGKvjX
    TcTbHXeCWpAbMK4RtNWYuu9aQ5PmkGSLpf1svL7z2fyFUph_ixp>
X-ME-Received: <xmr:ZlMEacItsN-3PY8DvMydcxMFrgXZyZMZs5lNj3lySyAO2lhiXUbtS7bp_h3Pp0Isug5QJB0tA2IGGy972MUbgFfbBiCZJQbI_tpGUvwllzO8kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:ZlMEaT5Lwtqd4qVLh-tY43glDUi75FV71wxCKyhROtTTsTprxdflQw>
    <xmx:ZlMEafw43T_ELgsJsBipQdBSEl1nRKt16OuqKcEgsohQsB-a1VIJ7A>
    <xmx:ZlMEaXYsRQ0dhiXmtx3vpHKLZ9e_u03OUIB4CVT0I1q6x8l_KbeiHg>
    <xmx:ZlMEaRT8AIuKOZ5fhNrzc70RlesamgrjMzRBm2PvJ0gcaJaXTuNqFA>
    <xmx:ZlMEaf42UqW2gYs_JR-sgdOY_p6jtkG3NY7zRUJsgDcLLn89w0e0ef-x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:12:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6e630f51 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:12:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:39 +0100
Subject: [PATCH v2 03/13] odb: adjust naming to free object sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-3-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The functions `free_object_directory()` and `free_object_directories()`
are responsible for freeing a single object source or all object sources
connected to an object database, respectively. The associated structure
has been renamed from `struct object_directory` to `struct odb_source`
in a1e2581a1e (object-store: rename `object_directory` to `odb_source`,
2025-07-01) though, so the names are somewhat stale nowadays.

Rename them to mention the new struct name instead. Furthermore, while
at it, adapt them to our modern naming schema where we first have the
subject followed by a verb.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/odb.c b/odb.c
index d2d4c514ae5..77490d7fdbe 100644
--- a/odb.c
+++ b/odb.c
@@ -365,7 +365,7 @@ struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
 	return source->next;
 }
 
-static void free_object_directory(struct odb_source *source)
+static void odb_source_free(struct odb_source *source)
 {
 	free(source->path);
 	odb_clear_loose_cache(source);
@@ -387,7 +387,7 @@ void odb_restore_primary_source(struct object_database *odb,
 		BUG("we expect the old primary object store to be the first alternate");
 
 	odb->sources = restore_source;
-	free_object_directory(cur_source);
+	odb_source_free(cur_source);
 }
 
 char *compute_alternate_path(const char *path, struct strbuf *err)
@@ -1015,13 +1015,13 @@ struct object_database *odb_new(struct repository *repo)
 	return o;
 }
 
-static void free_object_directories(struct object_database *o)
+static void odb_free_sources(struct object_database *o)
 {
 	while (o->sources) {
 		struct odb_source *next;
 
 		next = o->sources->next;
-		free_object_directory(o->sources);
+		odb_source_free(o->sources);
 		o->sources = next;
 	}
 	kh_destroy_odb_path_map(o->source_by_path);
@@ -1039,7 +1039,7 @@ void odb_clear(struct object_database *o)
 	o->commit_graph = NULL;
 	o->commit_graph_attempted = 0;
 
-	free_object_directories(o);
+	odb_free_sources(o);
 	o->sources_tail = NULL;
 	o->loaded_alternates = 0;
 

-- 
2.51.2.1041.gc1ab5b90ca.dirty

