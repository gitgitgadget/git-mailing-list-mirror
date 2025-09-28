Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979519C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097247; cv=none; b=bbNZanH8dn6E3obiXPDE9hcqaORVUQBwlERJvoevg7K037AaZ41SRABhCUAEjY7eh15IBGln6j27hkLi1W7pOBhT3127onzXVVbcdBJkxLgc1suKh9piA6ReYRkmWDSq5u+5bvVJnvzgGUfJoDOknhytL8G5xGJdbJsRATUwYMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097247; c=relaxed/simple;
	bh=e3OxlYjX7SG/OuSyY4iue3HIMAsk6vow3hf4wi4jSNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txZd8c30SyHFstxyNnS88OktnyrbOLAvAznGDRGzjugI0bTym4Bo2qMNp2aQUgdo4b3pqg4lnyPXn10KElNVdyOY3zemFyG9S1+6JHRwVzU9nwQUh7R/zb6Rq9ygH+wJeda/6QwjajwhMmRte2RXFoITYAkeWLMK2G/2l93Ph4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SzZpaL5g; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SzZpaL5g"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-749399349ddso48393567b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097244; x=1759702044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zSlh+5z3nj+CPpwN/ejkm/e/3mEAotekxMZHvJb4wO8=;
        b=SzZpaL5g4TUJyeK0H+bDr5mTaeos92owjBXX9Hspv7t3cO0UuqsVUvuhuiioyYfL8q
         BBB3LU87tu4jULr7xf/KLvmYiGwMjgbUEWsm1eRM/x+xw5atGi1GpMkFnrJjat0AME11
         15aStToXQnaoJ7JaOI/AiHeVJ38cunH0IQF19ZYfDr2oBVeFDIKGFgQ17oDLpcunZUj0
         SZdEk6C5MSlMaHjjT3A8FAMdaD/wbqd5lO6bCvfxTI0vNdHZHYe4jVl6d45Klx2yJZ2z
         QNinrlObnVHdeQnrvSp2GPWTdY8E9aOUCm4pb5UPnnGv++/TDhGssQrnk3VFuTAhhJeW
         SRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097244; x=1759702044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSlh+5z3nj+CPpwN/ejkm/e/3mEAotekxMZHvJb4wO8=;
        b=FQwQvCpuiwHJaptpIBulzAQV6e8zC2QxKg5c0EIrQoygL/KCZlWuOOhhO5U/lkE5DM
         o9iz98GGlK8l6zr5VhHAJgoDWz3XvI+LXmErNNLD8V2G4eEveD8N7EvapBhLb0kJIGrc
         Ca6kjdldWdKJBDwTMknugwzNwDqxmtHvic/djyiPJEmaedOLmpB21ToDmDiK5AsofiZk
         +izI/DpyitdVTF4KYS8WMhdYSnBdSp+/KiM8/zKELA2V1wCvmg/KXgQfz5We3OyUAyfh
         ZvlnBt8A6ebBoNcEosRhISQADMkExiPestSewgq2PjpCe5K+vMTz7V49ZTZkaql0RuI1
         yu8g==
X-Gm-Message-State: AOJu0YwpijKVJN18U2BphK77DggNT0rzLKkEDrdpm2FkxwXvJsW7a/Bj
	PF8F0/pynL8A1DuQZc1ht3/Icyt6TmWJASJhj80OSTPJ3POfe4dUq107udQeULO6hi5Biot4k9T
	4nroQTZ8=
X-Gm-Gg: ASbGncsoFtEYiog86HsuG9jLDFt5qSgw/iTuQys4WtDid4TAZg8IvU3hjH8tAh8aOCH
	rtRkmacvfdpz/B/3THAOsvrPE4HQ9th4ot9zUNk93aj9DkGQdTL/rowCT8eYirhAbdtvKJZ1949
	HlzHLsBqlZE69JqAeuD/o7NLdjp+Dx2G+UHTitwMG38hi07GMa1HvgJmV7GQmdQlpTTL+4NZKlD
	7OXzssXyPwxYofKl0CMYUmvWjV92aQKu0o6DFtCdMBnlWKVUgvanKvK9R1lSFebBO+9C+5KZkDx
	XXKtG3kd7/OoasUclx8DrxxKdzhLTSywyOpyPOo6MlIEqIOu+9p5NIfE39pzzCgdCEGShJmxGC6
	+EBoo/danBZ3bQdkS0ZuPQCONVgNbeVVmWSmat2VjKKdfmxEbjwrjZ/qnS6uaG9kuuUwq8FX6dQ
	6WggfA3hc+AVd3appyaGme1HVy+Q==
X-Google-Smtp-Source: AGHT+IHjR/jMU+f/+0EpjGnrb8Cv6DddYF01d+UT4vy8Ksk06CS1e81G1IOM3tOrUB0wWVfQF/Gcgg==
X-Received: by 2002:a05:690c:2d0a:b0:72c:126c:a997 with SMTP id 00721157ae682-763fabe0612mr144819587b3.22.1759097244430;
        Sun, 28 Sep 2025 15:07:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-636d5b1d94asm1937691d50.25.2025.09.28.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:24 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 03/49] builtin/repack.c: avoid "the_repository" when taking a
 ref snapshot
Message-ID: <866e43b0cd74a7bbc13870c66ffd58ca8387aa9e.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Avoid using "the_repository" in various MIDX-related ref snapshotting
functions.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7223553bed..113f5fc67f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -771,6 +771,7 @@ static int midx_has_unknown_packs(char **midx_pack_names,
 }
 
 struct midx_snapshot_ref_data {
+	struct repository *repo;
 	struct tempfile *f;
 	struct oidset seen;
 	int preferred;
@@ -784,13 +785,13 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 	struct midx_snapshot_ref_data *data = _data;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(data->repo, oid, &peeled))
 		oid = &peeled;
 
 	if (oidset_insert(&data->seen, oid))
 		return 0; /* already seen */
 
-	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
 		return 0;
 
 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
@@ -799,11 +800,12 @@ static int midx_snapshot_ref_one(const char *refname UNUSED,
 	return 0;
 }
 
-static void midx_snapshot_refs(struct tempfile *f)
+static void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 {
 	struct midx_snapshot_ref_data data;
-	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
+	const struct string_list *preferred = bitmap_preferred_tips(repo);
 
+	data.repo = repo;
 	data.f = f;
 	data.preferred = 0;
 	oidset_init(&data.seen, 0);
@@ -817,13 +819,13 @@ static void midx_snapshot_refs(struct tempfile *f)
 
 		data.preferred = 1;
 		for_each_string_list_item(item, preferred)
-			refs_for_each_ref_in(get_main_ref_store(the_repository),
+			refs_for_each_ref_in(get_main_ref_store(repo),
 					     item->string,
 					     midx_snapshot_ref_one, &data);
 		data.preferred = 0;
 	}
 
-	refs_for_each_ref(get_main_ref_store(the_repository),
+	refs_for_each_ref(get_main_ref_store(repo),
 			  midx_snapshot_ref_one, &data);
 
 	if (close_tempfile_gently(f)) {
@@ -1397,7 +1399,7 @@ int cmd_repack(int argc,
 			    "bitmap-ref-tips");
 
 		refs_snapshot = xmks_tempfile(path.buf);
-		midx_snapshot_refs(refs_snapshot);
+		midx_snapshot_refs(repo, refs_snapshot);
 
 		strbuf_release(&path);
 	}
-- 
2.51.0.243.g16eca91f2c0

