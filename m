Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FB1D9324
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661190; cv=none; b=t9kLRYk/HaQ2Nb/vS8Oq6H7VD+ZlaLSnX2lMkN5LnaeZpoYlz5tAyZD4MgsaKhy3AkRAmRVYV4DftB0kS5U0AYIIiU67RwzAFGGlHb6q2EkOWB65I6FyjQc+jogkMI5nHpVX73ktrcsnConGQciXGD90O9/ZziTJxRY7SxXFFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661190; c=relaxed/simple;
	bh=A7isDPfkabMLST/hj9OJ1RlbDBo1TpkGRj5qmUW68TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eReLOvufFjx64kyhbuUfFmGKhVxOQSUqKd1zUShUrf7B3Q5VycsVrGOjN3xgCZQkwD9No47LOPNNTI8fxvba1w/FF0WefGJedv+flOsTnz/4iNX0Q/YMXeXEqNJCXuijsmatFyGHZm1K2uKXK1edKWxxrmVx+pokb+ZQ/6K5O7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FDIFFVr8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FDIFFVr8"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476b4c9faa2so59874741cf.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 13:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744661187; x=1745265987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iungRU7QzzZx5+AUgf9w9Q94sExP/fkRrdo0OnddCMg=;
        b=FDIFFVr8uX7zE5Fh84MT5DL6AIcxzNUqvtsMwwhHa67sBODBBLu9v7eYLAsi8TapFJ
         1OJ5s6IDWrgxz9VONUauB9ivbSwFhUIZ/BkIlGOROQlhKdCgfhWypPFohvszqgM+yoOG
         LjDHSU5jcR6ttwl7BhERPfrp+936CoOCaWGesrtCPG/5KWc783neZiSKOLI9N0247DlD
         exQJhsW+dBtiKA+yeNR+b3CbYL7VdSZLj7OZSRATYZdJ26MAK+Q6SIQLuTW9hFldicCo
         +kpM2lBXxEOB3jcfanRUU9Vpj0p/61hESx0P6o2hm6ETUNaYUKnG+yvQdaUuteJSBD9F
         +rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744661187; x=1745265987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iungRU7QzzZx5+AUgf9w9Q94sExP/fkRrdo0OnddCMg=;
        b=M8ztf0nTQFtaWvZs4koTxHgEw+ro7lHQpQPehXqqH0032a9QFRYr6i2BDnZnX8bqUC
         43FYhrvu7FqgXGJ1GtDsg4u2shcLYqvBogdR9dNvSUoVuuhFx9zOQggVKMZSfJ0loA4R
         8XwawaKIadye9O2dUAmZuiSLK41D0kYbpAH9bDHUhqvUBRvqybBwaNs5rpYJHArWbIGc
         d2NPNqzu+bQXqDtLmtVR2Q2jhZRYndBTY/r5ixAFYBX6PJzOKa1+oK9amqqzqQTccy6c
         OVOKrZ4JteNic0chmwy+pxpzxMazzuZL9zwNPZrSkphw95rZuKr8+FZYuke12NTIWjrt
         5Y/w==
X-Gm-Message-State: AOJu0YwNlSg98rmaoJr3LzY6Muv3slSDN4gSOcGOOANdZ6OOORP8NEnm
	et9G/CWiXnT2X0BPFeW0UNQRiI42aKllg4i330i/aVBjiqkRtT1N/ug7B3wjorjLvsWyRmr5OAv
	xNUY=
X-Gm-Gg: ASbGnct2R09pog5148tqBeXuEghTJH7ZtxtdHDsukD/Y6UbgYwfR5dMOujQrnI46swx
	ky49PRTAXUG/eDBGjL2p42vptB0iXgoLXmbPL5AbcJXo3CriURyxJ00HC6cLF/s5aBmnqGLFdpj
	CKDh8ImIxguDUl4HGbFv6REHGBXf7O9PGEH5eVyBW3Y+kCXX2CazJX2RzYa6Mdtfup3UpxanXbY
	FvqtI553DRLpENaaDA5waAWjnauUIITsFx6BIvTPNoFCD1In79yOudk/Yn3WpyfeQ6x7Cg6i1P2
	oA9Wz9Rzfuy3vMR0V8NmYOCBZInyGqEiv7MeFfU4GzAmAKAZ4lFkWJ5RDvuttumt3SojT4F9MBR
	wRbgRY4uNjSYR
X-Google-Smtp-Source: AGHT+IF695yH9aP94fbQ57H8ggSDvB3rzTSEBl8YIMSy6/mkVdfMJGntctbVXeRiOGUK+WLWjGWpDg==
X-Received: by 2002:a05:622a:1306:b0:471:96af:c005 with SMTP id d75a77b69052e-479775cce8dmr207918351cf.33.1744661185710;
        Mon, 14 Apr 2025 13:06:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb2d020sm79563271cf.36.2025.04.14.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 13:06:25 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:06:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <bccbac2ec5a14cc61a3a111e87c4db651d8dae5a.1744661167.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744661167.git.me@ttaylorr.com>

Once 'read_packs_list_from_stdin()' has called for_each_object_in_pack()
on each of the input packs, we do a reachability traversal to discover
names for any objects we picked up so we can generate name hash values
and hopefully get higher quality deltas as a result.

A future commit will change the purpose of this reachability traversal
to find and pack objects which are reachable from commits in the input
packs, but are packed in an unknown (not included nor excluded) pack.

Extract the code which initializes and performs the reachability
traversal to take place in the caller, not the callee, which prepares us
to share this code for the '--unpacked' case (see the function
add_unreachable_loose_objects() for more details).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 71 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 793d245721..1689cddd3a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3556,7 +3556,7 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
-static void read_packs_list_from_stdin(void)
+static void read_packs_list_from_stdin(struct rev_info *revs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
@@ -3564,24 +3564,6 @@ static void read_packs_list_from_stdin(void)
 	struct string_list_item *item = NULL;
 
 	struct packed_git *p;
-	struct rev_info revs;
-
-	repo_init_revisions(the_repository, &revs, NULL);
-	/*
-	 * Use a revision walk to fill in the namehash of objects in the include
-	 * packs. To save time, we'll avoid traversing through objects that are
-	 * in excluded packs.
-	 *
-	 * That may cause us to avoid populating all of the namehash fields of
-	 * all included objects, but our goal is best-effort, since this is only
-	 * an optimization during delta selection.
-	 */
-	revs.no_kept_objects = 1;
-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-	revs.blob_objects = 1;
-	revs.tree_objects = 1;
-	revs.tag_objects = 1;
-	revs.ignore_missing_links = 1;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (!buf.len)
@@ -3651,10 +3633,44 @@ static void read_packs_list_from_stdin(void)
 		struct packed_git *p = item->util;
 		for_each_object_in_pack(p,
 					add_object_entry_from_pack,
-					&revs,
+					revs,
 					FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
+	strbuf_release(&buf);
+	string_list_clear(&include_packs, 0);
+	string_list_clear(&exclude_packs, 0);
+}
+
+static void add_unreachable_loose_objects(void);
+
+static void read_stdin_packs(int rev_list_unpacked)
+{
+	struct rev_info revs;
+
+	repo_init_revisions(the_repository, &revs, NULL);
+	/*
+	 * Use a revision walk to fill in the namehash of objects in the include
+	 * packs. To save time, we'll avoid traversing through objects that are
+	 * in excluded packs.
+	 *
+	 * That may cause us to avoid populating all of the namehash fields of
+	 * all included objects, but our goal is best-effort, since this is only
+	 * an optimization during delta selection.
+	 */
+	revs.no_kept_objects = 1;
+	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.blob_objects = 1;
+	revs.tree_objects = 1;
+	revs.tag_objects = 1;
+	revs.ignore_missing_links = 1;
+
+	/* avoids adding objects in excluded packs */
+	ignore_packed_keep_in_core = 1;
+	read_packs_list_from_stdin(&revs);
+	if (rev_list_unpacked)
+		add_unreachable_loose_objects();
+
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	traverse_commit_list(&revs,
@@ -3666,21 +3682,6 @@ static void read_packs_list_from_stdin(void)
 			   stdin_packs_found_nr);
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_hints",
 			   stdin_packs_hints_nr);
-
-	strbuf_release(&buf);
-	string_list_clear(&include_packs, 0);
-	string_list_clear(&exclude_packs, 0);
-}
-
-static void add_unreachable_loose_objects(void);
-
-static void read_stdin_packs(int rev_list_unpacked)
-{
-	/* avoids adding objects in excluded packs */
-	ignore_packed_keep_in_core = 1;
-	read_packs_list_from_stdin();
-	if (rev_list_unpacked)
-		add_unreachable_loose_objects();
 }
 
 static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
-- 
2.49.0.229.gc267761125.dirty

