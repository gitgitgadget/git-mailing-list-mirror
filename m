Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9D54FBD
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006205; cv=none; b=Eyl/e8+YPl7J+Wx3B1N8PgTfr8FgBTmTYpaRf5gbhxpN6GHJ2yX4zH+6iUbUqMJhfqOp8/HG6iMEpbju1K6hxFgUfVGeV6rYvbBgeiA/mAs9VuyQLcH9HKoE0ynqgu0EFg7iWsSxeOeAo8wzqqtiMLTdJg1WS5itkJNSt2S7odE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006205; c=relaxed/simple;
	bh=vz2tBQl0UMbSZXsZsuKDWeVP6ygDPREpIeIdkDDWhyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PB1GcP9YakHbXhZc9QTRSgvHnl115gmCq+P5JIDDxBHLjtuIBJoVWCBykqzCOzEgqzGwesh83d0wTC3j5dNnNILOoH9Spj/L48utecn3tCZcN7RDJble+z5ixgIjwqh5NcIgRItSyOhL/hUvGNw5RZWk1dCw3X145y7AKVvNgiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PhZAfxzv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PhZAfxzv"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22a8df1df8fso2819494fac.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712006203; x=1712611003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzsJuIkSJEK+5iJ5Jl3zSZ2oJLwXLnndaSfXdzuu7uA=;
        b=PhZAfxzvk2AGUPVANK8/gqvON41u0OJlWokNsUmYFvaaDrsEs90qu5Sa1RnDWySvHP
         Q/tOVPCq13T/hCnHQJcpM9ermCzs0+OfKCP4+D6JRMwJrcsWTCLzK8AYsguiY0QmxRJs
         7+ut1NUdC+PLgbLf0zm0whNEmL5y3eHPDTq8oYotWAgOZ5IWlUliFF3awQGwOtmXaAJL
         w94fIpV+OXKsEtV2v2AtK58HBJ1d0ldZIyC5+uQYQVZUvfHKSLnMmoWTCCYE1hyBnrJd
         /O2lnNZqQwVETql2ROeocPl2DYsQ0lImkF3hKafkXAe6AvyboIOglZhMDKAlImVzqREg
         N6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006203; x=1712611003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzsJuIkSJEK+5iJ5Jl3zSZ2oJLwXLnndaSfXdzuu7uA=;
        b=LsQCKEvmbkJhCXo1raTMr/EMBq8LiiK0jOTDNHCxvLmRa+ofiLKVFeFBrDvv42b8Zr
         A48atVmo/lgASXIbi4CTs8sgA14DciMLi15MsTmqFJ1nIu8oMfXwR0qvjSAPx/caXKWa
         jNEHQrMocOmtQizvL9q73516IcbjXHTUrj9SiqQO7z8t9TM29JCAOvwM6z44G3fccVPw
         l+ORdcF+UIBkmLyCKl0pBDCIXSHN1nzp+nXZKhi4DVv9/PTChjQTmL3/Y/0MsSADaXeM
         I84feLzg3o1bwvko3+HkbxtRMe5hZSb8GXKYqsBezo9Omikfv1lB8AkyMGnu8JRReemp
         hkxw==
X-Gm-Message-State: AOJu0YxnJ0X1v+Fr3Va9lSWOVn2GveYKtRHKQ/R2FDWOcBYJHpxuwqNt
	x1WhKA1NCiZzVYVyCYAL/tWH5Iv9yYB0hDNWOJXf3qSlgKVFO/bOkuvVqPs/QQOhB4GWO74Yfkl
	kB1M=
X-Google-Smtp-Source: AGHT+IHztvvwp+fAW0aZh4ir47ZkWn1GnMXr85bbqOl0rxY5lg1ehPTUNE35xLyv04fShLLZyNk/pg==
X-Received: by 2002:a05:6870:6124:b0:229:eb17:3c19 with SMTP id s36-20020a056870612400b00229eb173c19mr10628422oae.35.1712006203290;
        Mon, 01 Apr 2024 14:16:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ex9-20020a05622a518900b00432b5c9b9ecsm4755324qtb.14.2024.04.01.14.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:16:42 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:16:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 3/4] midx-write.c: check count of packs to repack after
 grouping
Message-ID: <b121f05a32b6639e6d8d28c8c7eb8fef1c7bfb59.1712006190.git.me@ttaylorr.com>
References: <cover.1711387439.git.me@ttaylorr.com>
 <cover.1712006190.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1712006190.git.me@ttaylorr.com>

In both fill_included_packs_all() and fill_included_packs_batch(), we
accumulate a list of packs whose contents we want to repack together,
and then use that information to feed a list of objects as input to
pack-objects.

In both cases, the `fill_included_packs_` functions keep track of how
many packs they want to repack together, and only execute pack-objects
if there are at least two packs that need repacking.

Having both of these functions keep track of this information themselves
is not strictly necessary, since they also log which packs to repack via
the `include_pack` array, so we can simply count the non-zero entries in
that array after either function is done executing, reducing the overall
amount of code necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index 906efa2169..960cc46250 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1367,11 +1367,11 @@ static int want_included_pack(struct repository *r,
 	return 1;
 }
 
-static int fill_included_packs_all(struct repository *r,
-				   struct multi_pack_index *m,
-				   unsigned char *include_pack)
+static void fill_included_packs_all(struct repository *r,
+				    struct multi_pack_index *m,
+				    unsigned char *include_pack)
 {
-	uint32_t i, count = 0;
+	uint32_t i;
 	int pack_kept_objects = 0;
 
 	repo_config_get_bool(r, "repack.packkeptobjects", &pack_kept_objects);
@@ -1381,18 +1381,15 @@ static int fill_included_packs_all(struct repository *r,
 			continue;
 
 		include_pack[i] = 1;
-		count++;
 	}
-
-	return count < 2;
 }
 
-static int fill_included_packs_batch(struct repository *r,
-				     struct multi_pack_index *m,
-				     unsigned char *include_pack,
-				     size_t batch_size)
+static void fill_included_packs_batch(struct repository *r,
+				      struct multi_pack_index *m,
+				      unsigned char *include_pack,
+				      size_t batch_size)
 {
-	uint32_t i, packs_to_repack;
+	uint32_t i;
 	size_t total_size;
 	struct repack_info *pack_info;
 	int pack_kept_objects = 0;
@@ -1418,7 +1415,6 @@ static int fill_included_packs_batch(struct repository *r,
 	QSORT(pack_info, m->num_packs, compare_by_mtime);
 
 	total_size = 0;
-	packs_to_repack = 0;
 	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
 		int pack_int_id = pack_info[i].pack_int_id;
 		struct packed_git *p = m->packs[pack_int_id];
@@ -1434,23 +1430,17 @@ static int fill_included_packs_batch(struct repository *r,
 		if (expected_size >= batch_size)
 			continue;
 
-		packs_to_repack++;
 		total_size += expected_size;
 		include_pack[pack_int_id] = 1;
 	}
 
 	free(pack_info);
-
-	if (packs_to_repack < 2)
-		return 1;
-
-	return 0;
 }
 
 int midx_repack(struct repository *r, const char *object_dir, size_t batch_size, unsigned flags)
 {
 	int result = 0;
-	uint32_t i;
+	uint32_t i, packs_to_repack = 0;
 	unsigned char *include_pack;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *cmd_in;
@@ -1469,10 +1459,16 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 
 	CALLOC_ARRAY(include_pack, m->num_packs);
 
-	if (batch_size) {
-		if (fill_included_packs_batch(r, m, include_pack, batch_size))
-			goto cleanup;
-	} else if (fill_included_packs_all(r, m, include_pack))
+	if (batch_size)
+		fill_included_packs_batch(r, m, include_pack, batch_size);
+	else
+		fill_included_packs_all(r, m, include_pack);
+
+	for (i = 0; i < m->num_packs; i++) {
+		if (include_pack[i])
+			packs_to_repack++;
+	}
+	if (packs_to_repack <= 1)
 		goto cleanup;
 
 	repo_config_get_bool(r, "repack.usedeltabaseoffset", &delta_base_offset);
-- 
2.44.0.330.g158d2a670b4

