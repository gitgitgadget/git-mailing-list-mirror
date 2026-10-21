Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607137;
	b=RiJJ1t58l+ivxSGu3BmgR+UMOy0Z4oszhVGgjCD5jhLrC52hq74FWGVEzneiwO3hfeUB
	 DOmd5VdUQJp1Tm3h6owjmyfLOtL/3yhPOCUInnCjhgVR6IJInwJRGbHkW3F1P9hhiD8Tz
	 nMPDcqeeFM9X78+lQC9bXkWC/BtQhdWfsApRcYD0uuFY0Kqk7OBclLLtTGgOLBf95hD4/
	 LU+4IlC13n2wUR2iG5R+OT9Di20FMZbWtZgQ5PfZVv6N5KntSZxPHTxCTGh4G1YKGaYpP
	 a9Aw+pBtVmpH2FkgnDZEIKcKQGwRZ7w91qdKFZ9bZv5ir70xrcnnjNynKPZJeUc2ijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
	b=Fs3j4B02LMymmZa3NbNCludtr8AkHggMWNf56rMVBn9nZmowU/+zv7zspRUBC6gmRnNx
	 XGA1CZ6/UYUdIWmD+YvNpS40r2cFawuATiV2OcL1EP21nYj6j5A3I8aQAuoJvI3Sa2hsc
	 +G9GP4nSISJISstwLzjfm7a9KdxgRd/EmyZ1C8uDkTWLGPk8xxp2Um3IyrYHFDQMhNjz/
	 llvD9Q6UItAZNFbv8Dtg/bXqZi/98tOgfyoCM5pjXHt8kPFjYkKgYKQVikfBpmYt1KlLi
	 STq5IzJdAaLDXC61lnc8nY1z5QaG4RDXnRpVRiV2Hodv4ea8E5jyzWcyg9+UD+6ihSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s5gLt2D+;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5BD606A31D
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A5BD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s5gLt2D+
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-8439fe796ebso680636a34.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607136; x=1793211936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=s5gLt2D+GRthYU/rKjr9m2NNjjsw9zTegHhtCzXDqdOy2TP+60RkX5myGF0pATkOpm
         wum+1sjdRj3q4XPRycG0TgH1sshDgzQt0w1QTrV5BvzoNY03LwcTe3IwpU/h/v3LCK0U
         mjnK6zviHX4U0yX/O1JH0bcjui61EGIif+l2yHOJQHmV13OIK0OevTBW7T8E/CqOhYqb
         rxsQvB3fcwSd+70f0680L+AfE71wAQ8z9n8cK0RX1uJAAuZVWToTsYv8tQycGfxDPC6d
         uWzjbNEuq2OKi5bn7UzXYJ5XBhhmai45xd/W7L8E/trxrBOn73rgb9iepnCABEXBffvr
         iQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607136; x=1793211936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=l4VuROjGeQxDI9G5Qeq++FgVmLpjxTgGvE8UfvLBt5BLd5uTDUMs4fGZlqTw9ZxGeL
         LxL3/1PeqKe9t6/HPci80XFTHIQ1Ap0xuCweKO+yRMJh+1dBSF6g5PM09UUY+z1YEMJO
         ShEPntJP3swZYH73K33IUsLMVIP038ZchO5Q6mcEBuyNey6oLR9e5NK0hEPFJxpG6qFI
         ZdtOsjmR5hgmU/rPACnRHWz7bNcy8tjOnVAZ/EBhLl8ae/XdfTP5mCs+xMZ9oZfSjekT
         uSMS5LUb96jMq1l5cWIWS94fUSCiJKGylpSvmbV7O+gNOcRuaZdoiB4JaXYPpV/9id1J
         Sqgg==
X-Gm-Message-State: AFq9FYJc6ypjQEMLUS9c+IZYJtzw3AWcNn9fDmXBQbfy5DKYSEZBVhUB
	FuBaB4spbJYDDVZmDdjPhfu1nbzrgHv7aQbP1U31nrQMb1xjEYvMyCkFtQLUQA==
X-Gm-Gg: AYBFou3/GqRaC20vOx4aatadQjdB3i5sLpH8gdLSyDCoNHq6hKDMTxcJV9FMG2VTrPS
	VC0UdlAvkyBsLjZyvINXD5bduxg6tEczeahQn9gC/8GCk2Os6e1uQKeu0CgDPzW3UKWI83awBQo
	Qi67zh0ZN0lFEwu5lfJ6M0pSIXBmOEhwXouPTsOxbAfhtr5nkCBLWDHvgfc5FEv89d57Hk1ky9G
	LB9JADvMXpcxTdZKoYmnjHyhy+zoq7aTj2EaMyfImjZ8SzfNBuiKb7So+ZhFw2zs/3ZEP7ryM8a
	4u/lkGAni+Drh0yzlSoUWd/0oZ0065CZgVShtvohZun8JWyLxCjiO6qZCIO/fV6ZSAoZiTGGrHh
	Pipdkj8Ivu1KK8DrByAOslN8OiiYPStq7alOZPLPs0LmrG9LGO/EO4usPu/97UlFNGct+shyVpF
	9tRP6a1VwLKrTimUm4KcnPzTtJJUBjAUvgZyTl8f8XclHh7ob1cxHgoJebYF4klJc7K8U+MlOJq
	3+1bV8eKfkvTNRof9H3Lygd8RbJkYcHTNTMNVNBrZhf7BL9DduPgt01f+LlCmMI7eTpWCDElHMD
	zifhTOv2kSu7tHpxPRI=
X-Received: by 2002:a05:6830:4c04:b0:822:e81b:3ec4 with SMTP id 46e09a7af769-84d07a0556bmr2558084a34.7.1792607135970;
        Wed, 21 Oct 2026 11:25:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd9d3csm2831887a34.9.2026.10.21.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:25:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/4] pack-write: make index-pack output comment hash agnostic
Date: Wed, 21 Oct 2026 13:25:25 -0500
Message-ID: <20261021182528.3055494-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261021182528.3055494-1-jltobler@gmail.com>
References: <20261020132900.1208343-1-jltobler@gmail.com>
 <20261021182528.3055494-1-jltobler@gmail.com>
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

The code comment in `index_pack_lockfile()` explains the expected format
of output from git-index-pack(1). As written it explicitly mentions
SHA1, but both the git-index-pack(1) output and the parsing are not
specific to SHA1 and also support SHA256.

Update the comment explanation to be hash agnostic accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 85674e4b72..b1311c9923 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -476,11 +476,15 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
-	 * The first thing we expect from index-pack's output
-	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
-	 * %40s is the newly created pack SHA1 name.  In the "keep"
-	 * case, we need it to remove the corresponding .keep file
-	 * later on.  If we don't get that then tough luck with it.
+	 * The first thing we expect from index-pack's output is
+	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
+	 * name of the packfile it has just written. The line is therefore five
+	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
+	 * "keep" prefix tells us that index-pack has also created the
+	 * corresponding ".keep" file.
+	 *
+	 * In the "keep" case, we need it to remove the corresponding ".keep"
+	 * file later on. If we don't get that then tough luck with it.
 	 */
 	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
 		const char *name;
-- 
2.56.0.173.gf57c9a7388

