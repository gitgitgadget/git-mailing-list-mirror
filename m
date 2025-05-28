Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446F221F30
	for <git@vger.kernel.org>; Wed, 28 May 2025 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474423; cv=none; b=sW+pZ3HNG6DYCtGO2afoN4HqQeg+tjrfDWieD/UQGvM4Hn+OPKr+hMLmlJXE09vV3y8ukLopAj3dUADAYKOgO0Qn99YgQBbKaoz6pmBGkqliWCFd64qZ3U8XqxXOsAFqisL/SL6mAMHl+hiqQya98xED2qprwNZBZV7tr4+reag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474423; c=relaxed/simple;
	bh=/Ow27EZM2uiRY7Jo0eBjx5QeWELrmaw492VwM83S2B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldVtKb58uLixzjuV6lXxEXoe/NjWK7CoeQA5gTIEIJNpCtNpRWs/9g5JDxG+ILA80p3sQMNS0nPsiiONuYubL/wsgdaBsr7PF0/F7VO1UG008SyjKWrOpA1K5hPvKT5aSCR6WlPafmovokGz4geMYhb/+YTaPYW3zjxgjcPzbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MbR6bqB8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MbR6bqB8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e40e3f316so3361547b3.0
        for <git@vger.kernel.org>; Wed, 28 May 2025 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748474420; x=1749079220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uanz1QAQCNLKR0oATHOO2gpQT+iwqJ3Xm/bdxmjPE/g=;
        b=MbR6bqB8I7PtOC20IzhUw95EqbA2Mw4//Clmhj0Ssqa2B9Nou5aZTuGVdpxXci9Cas
         wrB/CVaLG+KJGo9nAZwtu6nVJlPxxFCk3vi05+FKXG1oo1G3+2/+spB/MNfRI/avJPA6
         dHYulqvw5nSxE6BYQ8InOayqgiXgX0gHxj5lRwss7A/Yd/pyTTgDIowPMBnTnRG9cUT6
         kCbdAqwe395F1vqt9RyIu1h3A1bBwcYo4A2OG5gYY8eMrCprLGtYWfemV8Z6+0rGuu6j
         AIX0fhbaaTi02e7ng7Pf5UQA2+RGdu+ED5f63N8z7o55AuuykoTMHD5SRhO/5DytHNff
         a8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748474420; x=1749079220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uanz1QAQCNLKR0oATHOO2gpQT+iwqJ3Xm/bdxmjPE/g=;
        b=qv6LnMzPywm9kw8QNNIhsv9AoRuZtsqZkV+lzbcxQzazKtYTE6CBevb7Vo39NIvgU0
         bar+ENeUBFvYxu7F1yjQ90lVokyD8HMn19/KaVJgHNlJnHmFcxjdoty2WZXLFtAVBoeX
         JNCOADjTFa8Bn/lbEcPH8m+TTn7uny1c7rQ3lSg1sNbyucH0WoSM3n79l33mW7OdQ0Kr
         m5F4VN9bYWqgN1SRK1o+A69I86Gu7b8m2NyPoUBF+bjuti71H+n4ndvceInDWO60bxG3
         wTa5OhLUY1j85SAzOAcSh/LXIuglblp3yeNht7a7WDW9U6nriDBlIa2l3gDR/Te3aKrn
         h0Xw==
X-Gm-Message-State: AOJu0Yzmqswpb83cFRSNm7eBHaK3Xem2QIWUUbodMZ99CWUAIm2mivG3
	CmeG2sIxmESRUQKf7uVNAyydyDV0HGQ+msZx+Ou2RcSIUt5YNVnPe+qTopCsiK1LvtbMvw4bo/6
	eAI/F
X-Gm-Gg: ASbGncvMJS5uVeni/qD37cYn9EfMLc/GhvCTyHTV5lo+0DAUnKSP/m1ClA5Cg9PRzhV
	pBvSIVakNI5mmJ0QhnNfybmHJBxHsY6Sp1SuBgit81wj5MBd4M/60uDMx2N8/nabBXKjuF39sAl
	+UpEvS6cEZDFFq4OghkF65iq8zQCAI0BS54CtBpfj51wrwBWAVIPdIruqKCZviYM78pg+92EMKi
	HLJuKo6V3g8iU2GEVIFkFkWPOzh7JuXUNu1Lo4ONt38hFxhnfS2I8qAdfV4FJuBjbuPmj4l1g78
	okC9jhVNW/kQhgKKQbSLgp06WV0i0A/1RfMYjxxS1ejgHohq6sETzrVnlqpqz/uXF6av7yn/9Fu
	p0E6ZaliDrvSNeI7bbojf4L4=
X-Google-Smtp-Source: AGHT+IF4Rmoj6D9VMHd+s8AGCPnH/uycUu5QFV2oXh9+35vkmnGD32TSiIJqKdTmELqDhmbp0vkoXA==
X-Received: by 2002:a05:690c:7405:b0:70e:2d17:84b5 with SMTP id 00721157ae682-70e2d770a5dmr241067547b3.0.1748474420552;
        Wed, 28 May 2025 16:20:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ad00dbasm349307b3.111.2025.05.28.16.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 16:20:20 -0700 (PDT)
Date: Wed, 28 May 2025 19:20:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/9] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <a797ff3a83bf623592384fc7652e1f1ed0d5d49b.1748473890.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

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
index 3f6a7c62e6..88071b4d8c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3558,7 +3558,7 @@ static int pack_mtime_cmp(const void *_a, const void *_b)
 		return 0;
 }
 
-static void read_packs_list_from_stdin(void)
+static void read_packs_list_from_stdin(struct rev_info *revs)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list include_packs = STRING_LIST_INIT_DUP;
@@ -3566,24 +3566,6 @@ static void read_packs_list_from_stdin(void)
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
@@ -3653,10 +3635,44 @@ static void read_packs_list_from_stdin(void)
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
@@ -3668,21 +3684,6 @@ static void read_packs_list_from_stdin(void)
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
2.49.0.640.ga4de40e6a8

