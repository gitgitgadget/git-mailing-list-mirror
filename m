Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CD34AAE4
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947612; cv=none; b=N0plS6yHoEkPjC2n5aCDIN75wKx51ow1LAQY6OLHkqVLTvLINt+KG8UPIsfzdyUQS1mxn8CR+2S3oic+YUvtagj+s7HlfqwdSnXctjBfsxWLTr6oEGgT/kbx7qTMPsrAnbxsRO/GXo8rqaP8YILDuV3D9WXuiwreqXUU88Vqko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947612; c=relaxed/simple;
	bh=97XwWPXaJNo+ZJVT4V+iRWUqyjXiG15UBNQZUGymQAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NP0rtsei2iQ75Z+fzWATHktl4YvTX/+QmN8BvzUoivNCwGRPvPYwRE1JC0AmnPduM/VWOly1envIEXUYvTHmIy1m1BWeRkABvzjGxZ1N32TziCsyquTje633DBZBeMWWQjZtVG8w57rXGRKj8sEkfcTD0OOpeo64hJf+uhk97Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jvlgxPpi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHrXNXaP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jvlgxPpi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHrXNXaP"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 862EF140005B;
	Fri,  9 Jan 2026 03:33:30 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 03:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947610;
	 x=1768034010; bh=C46MLbKTI3z5Yd/qjjnbMdfE3L78dejB6XUnLJs0w+I=; b=
	jvlgxPpiVa6a63BsbEAKq9cwJF+wr1DDSWG4a+D1jiVWO3xvVR5DRxGVQ8FHbB4K
	BGiu9ynz+IHpfR0/lx4j8o7DMES7tpLJLAjLZMcahZEsBWp/uN5/0E4dbWxswnQd
	fZO4ABgOxHJrSkvqC6XNYDJaA8blc+NPdfiJEFz/QWdRajKB42TALoWkhNl5UdUJ
	FjlxzGS1EZtBqVHH0GjuLvFtvk+r71ugUX/KYZBsR4lLh6ZA9+AON4GVX3JrF0aY
	vc+rJ2VRc07nQ6lVjOYJMyJXsMtr5C3opar0b0rJ0wtrRgdW3SDltyMuF6ZweET/
	caWS7g5eTQfonVwTMs+Kmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947610; x=
	1768034010; bh=C46MLbKTI3z5Yd/qjjnbMdfE3L78dejB6XUnLJs0w+I=; b=u
	HrXNXaPMS4ki36wz/CcdfOzw3nYMtQ6USV8GFMRdEdT/kY3BEADFYyzr353VZwt+
	I5iSNytBZrsE22j3TrMyI72ge5CGVXjcpW+UYwftndns0vsGuntxIJp7KkDygMIS
	ActC5hfBbsl3BRVFaplSOa8axolFaVFi6Pri+asLn3o/PFXLQX8KnUhMehgzyjeG
	6h9a7Ya0/nEaUDC4bFlWLLEmQpug27tOw/dPH8TkHJnAw6sFMyC1hXevBj0ZHKpK
	NkJinDc+5DiAF9Vyldyxcf3EAXEB+aCow7BprvHudhHkC833+60WSowIufZ/ju3B
	EC+UGKlgjUXGee4mBNqDw==
X-ME-Sender: <xms:Wr1gaQLFfI6fLbf2EFhc13qQ7RWAdvL8iB0q_CU7PoYcBa_SJ4SWIQ>
    <xme:Wr1gaXJuJoFVqLigCa78E7qeRtg6dlAj5av7oGg58qvjw8dZjKXvqqR9QxYdboAGx
    u_3_4sZ8eMNpduFYVbThnIlP7rh7-3u0UZQ7mgFhcjX9m0vUW5HOA>
X-ME-Received: <xmr:Wr1gaVuAmZ83b2D0Ee8z-23BIToU0gGYliGYEobZZKCCd3nYTm8c_PJiwX0Whb1jc144B9z-g3OO5Am6zQmg5rGZIgtVqLWte0LfTQjrtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:Wr1gacR2sfTHbR8pbb8E7ODgNaRYdIBU3dpXNf0UE4q6dZYXOyV3EA>
    <xmx:Wr1gaTPfNMJYKgqTK_284WRpThZyZV3afA3b8KvxsBVez6m9F9DqKQ>
    <xmx:Wr1gaZYopXw2GjbhojgKBKODCUM_v9OlpyjdBKpYq8YEr_LOlmrfIQ>
    <xmx:Wr1gaVwf_HqWmxgbITFI3O9MppeFiTBdVf_Mc7pFmemdWSHBC-ZFqQ>
    <xmx:Wr1gaev7B94qGy_N6rJ2Tna7G-p9RBWsRhRTvl037zVdkZpDrSOHeHPE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79f18459 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:14 +0100
Subject: [PATCH v3 06/10] packfile: only prepare owning store in
 `packfile_store_get_packs()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-6-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

When calling `packfile_store_get_packs()` we prepare not only the
provided packfile store, but also all those of all other sources part of
the same object database. This was required when the store was still
sitting on the object database level. But now that it sits on the source
level it's not anymore.

Adapt the code so that we only prepare the MIDX of the provided store.
All callers only work in the context of a single store or call the
function in a loop over all sources, so this change shouldn't have any
practical effects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index a0225cb2cb..c46d53b75d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1092,10 +1092,8 @@ struct packfile_list_entry *packfile_store_get_packs(struct packfile_store *stor
 {
 	packfile_store_prepare(store);
 
-	for (struct odb_source *source = store->source->odb->sources; source; source = source->next) {
-		struct multi_pack_index *m = source->midx;
-		if (!m)
-			continue;
+	if (store->source->midx) {
+		struct multi_pack_index *m = store->source->midx;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
 			prepare_midx_pack(m, i);
 	}

-- 
2.52.0.542.g9473a8513b.dirty

