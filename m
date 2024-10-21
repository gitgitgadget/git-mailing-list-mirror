Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032EC1E571E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504698; cv=none; b=JRgEA/apIcuUaZPpE/fFvRt4jQDAeBeCdhXXm6doKTOYN8t8fDSNxkwpGMXJFz63kh3KtIhpaY4nMsPhnx362It1YBhHqJPPsO9S4aM8SfzRuhXdyERc7N/xHNuLdrBhv1hs2YZvA4934yMnspUpguAEEumcOezo5+fHy0gqPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504698; c=relaxed/simple;
	bh=CZzQ0MmakROjBrudbp65US8AUaz8Rc2whzrrsq2BLdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFUCtK0fbzfb9Ftc4EHNEq+epmfR7gbIHEYQeP3GWwsJBQZpNf5YUryNRvd+G9e1cpbJN6dEz7jb4dViG66WerEE/BjaIre9PQllMubU1v9sNLBCEbJnlWWHvlDej14J3JtP1d5Uct4l0FRapSnGuukW5Glmc3jSlkqMUWk78gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih4bGNmJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih4bGNmJ"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a99eb8b607aso441518366b.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729504695; x=1730109495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1egi0q3Z0yAC5qR00pLsZi766LDkZglc9y/WTWbkxXU=;
        b=ih4bGNmJYv8mi0Fwzl7YXHQjAetibaorvbQSDjLmcuAAkpAv6TtKVdHfEbTNhHzyq4
         1hfFChKBRgxEHpsot70txNw8cIPmwppV39PvUteM9WT1uyrBMR78ouOhYCH5T7055EgZ
         F2vSEGDJ7VFZLJi7+Hj+ibO1IOIOjP76h7QUORKkR5YsB7KF9VgmxALkBIUve6J4OSjQ
         /zfXNmZTGm3b73Sofr7TMlxVHY8/s+1Du6xuVHwPBjv1xVdIsvEnh+UfHbAw/7t/Oa0D
         PaEMUiFkQlFrA2QU6jaSuGhgjF3hCyACbyGp3y5WjSaAWdCb0GRcR/XlRMuD4Cdut/uR
         mUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504695; x=1730109495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1egi0q3Z0yAC5qR00pLsZi766LDkZglc9y/WTWbkxXU=;
        b=gB67Brt7aCxoZaObGxV7343zpe3BEMOvcpJg6OjTkf2EQPXIO08t0MA+z9+V87wg7s
         G+bx9He+P+j3bPGjdCVEfWaSvFtGeN1o++hoH2lTpKJr7BG9i3LEFf8aoVdvUakBS8s/
         SwNJACpvPSXvOYQ64zJ67hAKIvGlU/lCxD/hkeN1/CwD4UwS/HwrxlRzhEeMhXSMQYt1
         IrC41PF05ykkRO2f5Ou1ZmfR3Tbl1dIPXrSl399cNPK00WNIXm4Fi/xFZ1BzEkk+GKCG
         kzQi1m2xfcFB6VpasfVmPGztN2GI2t853d01FMLY1p1/YvKI2KB/4yEQNXis259zGXr7
         YLtA==
X-Gm-Message-State: AOJu0YxeelqRiisTYA9T8BAF8ST9jj4ymUFQJUQbc81ldrYPfvt69T4G
	p1eoer0bFSPd3K99FYWdX/ZQwVn6V57G7zHOgS30E6Hzq8qdW9DHuOvWsK5A
X-Google-Smtp-Source: AGHT+IGyMKOjJCJQvcIDripDZKBbHuav+W/LSNWYryozRApGHuyaGmCRdaY9i6WjswNcoB66I/HBAw==
X-Received: by 2002:a17:907:3f1e:b0:a99:60c8:f2c4 with SMTP id a640c23a62f3a-a9a69a668c1mr970294266b.15.1729504695113;
        Mon, 21 Oct 2024 02:58:15 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d631dsm187122266b.17.2024.10.21.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 02:58:14 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org
Subject: [PATCH 11/20] packfile: pass down repository to `fill_pack_entry`
Date: Mon, 21 Oct 2024 11:57:54 +0200
Message-ID: <11ddc363c27d93f0c716bfaf9ce2cecf71ed421e.1729504641.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `fill_pack_entry` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers. Let's remove its usage from this function and any related ones.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 packfile.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/packfile.c b/packfile.c
index bf70fd60a8..236c5c0479 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2028,9 +2028,8 @@ struct packed_git *find_sha1_pack(struct repository *repo,
 
 }
 
-static int fill_pack_entry(const struct object_id *oid,
-			   struct pack_entry *e,
-			   struct packed_git *p)
+static int fill_pack_entry(struct repository *repo, const struct object_id *oid,
+			   struct pack_entry *e, struct packed_git *p)
 {
 	off_t offset;
 
@@ -2038,7 +2037,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	    oidset_contains(&p->bad_objects, oid))
 		return 0;
 
-	offset = find_pack_entry_one(the_repository, oid->hash, p);
+	offset = find_pack_entry_one(repo, oid->hash, p);
 	if (!offset)
 		return 0;
 
@@ -2049,7 +2048,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	 * answer, as it may have been deleted since the index was
 	 * loaded!
 	 */
-	if (!is_pack_valid(the_repository, p))
+	if (!is_pack_valid(repo, p))
 		return 0;
 	e->offset = offset;
 	e->p = p;
@@ -2072,7 +2071,7 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+		if (!p->multi_pack_index && fill_pack_entry(r, oid, e, p)) {
 			list_move(&p->mru, &r->objects->packed_git_mru);
 			return 1;
 		}
@@ -2134,7 +2133,7 @@ int find_kept_pack_entry(struct repository *r,
 
 	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
 		struct packed_git *p = *cache;
-		if (fill_pack_entry(oid, e, p))
+		if (fill_pack_entry(r, oid, e, p))
 			return 1;
 	}
 
-- 
2.47.0

