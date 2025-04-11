Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DC2BE7D5
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744413993; cv=none; b=LaCVDas1uIVSLvdD9fTwSPz3SNpKFjsHJEXTzHoaYmLT6y6lPAzKtkM6ccdGIcKcKQXvHXEPKEBhReVTUQGrCCNat3IJtfhhVu0gFOXJwlbYi4XorA45osc2pmz3AmqxSz5uA7sEKddGLOXHzuPXQ5ZVgO/QqTnWF5yCXvzGUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744413993; c=relaxed/simple;
	bh=c24m+17HE1RXJ10noVgS/Q5FOmgJYbXBD5illFWO6yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTnJqNEjp0Om0hlVYtYX0qV9CrHGNnCjw2OVJH9uvBwhLnOxwcRm+UF4/JjrQUsZ3gONVsLzlSHO+C/kAeLVAm2EU2I9tFHBSX1Vea6Zl5sP6OZXbmKMCj19OGeUZabJ5l399w9mVCpt1nKy4X0Kw8O0Dyh5TMc2exdZlIWZo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K8nBOKFl; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K8nBOKFl"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8f6970326so24100436d6.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 16:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744413991; x=1745018791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJU7WfGVi/UhdTa13q43AKA4Fob2sPhv2kiSw+epyWI=;
        b=K8nBOKFltF9umyzcxvNF39c4XDBkKish3wxPKL8OOuSwombE56oifyYj8gUZHSCXre
         ux3LaRQJmTI7W528MHHlxtRIFdHvEPtAMV8vWmdPHaHGJb2VrksFv8aRcfGN7xoqp+MC
         k99Z11dIvXOUZs/z2A23Ff07vrG6nz//ps5cvUITimem4nmu+h5QnyBxPBTjOqNRTe3M
         AQFO+ILxyVEp6XvMu2U5UFGOurGbp/0ZC4LaV4fK/OZUSqY12YlfYeQjbjYWu2q4iTkz
         VkzM9ur2n/Xt0BDRNf9wOlkR5WlwHqlR7YOHgJNm/ENM9auQKlcQHhR1XonOjCkcDstx
         kjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744413991; x=1745018791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJU7WfGVi/UhdTa13q43AKA4Fob2sPhv2kiSw+epyWI=;
        b=Bb3cp06ZGIWtPOzSwRWoUsRyZgmGo1MaU0C8uKS9KkSxA/PpP78I0w2+iwTzmXQOU8
         ySYosLLqg0YFYsOqngcSCB20IpO1dA5ckbmrxtJQrnVnnKKozAmudp66B90HCiPRigZp
         9/AKzWDQoGoj0BKxIfmOYpOHWFPAV+TPRYq/KpPh4+yFE2oTVLH+KlgKk5yw7sbtSDjJ
         K5yc9BRRIC1RmHzCaBbU6Vf7OZSMMqhZb65l+9TurGMDu7dce4y3lrNcLjWzMu1zKfc4
         +QOqjqx6nhq2nUbisMGutMaUSx3M25Pb6Y+xiBsjsXlJZ3Vh79G44RnFOteKKdJZAgab
         P4SA==
X-Gm-Message-State: AOJu0YyiIm7jG2EOqP0XziiGxnVOcgancJA3q5KeZHDUdOiAcuzZX72+
	BvQcg2uSUxwknGe2bbJxsUhmvN04L1JMzReavd4m5azwosR40uZERnAiqTfK79dHYE4mETOQV5x
	PGcg=
X-Gm-Gg: ASbGncsxemU0rlM87+iW8DzSamoBozXiS7C6atn96ucaYpIN80/AVpKOuIYbc7h8I6V
	Iz6IBVrMLneGP4jDuwnkvr1HZdSBB1UpYQsLk2xREl+X3uqVcZL0my7znIy6ev4V+LAkG0V7wMn
	T9Wfyx0dsPs8XlcUVw0/DKm07kXMrXTkU4NHfPfkYERYxDamm0ETR8b44rfQwDnkKeeLCCgZoBg
	8r9G8WrxiRErRoU2PqwtlWBv0oOBuZwXhJsAbRH0Ec25S6IxlUmizaEFRhHjE/z/EVZN+d2ZV+C
	70a0+zP0Rev/CCwfUJOy+KKcT9Huiwj2tsOfRhHJDGVS+TjisHC4meCWO0ClEZk47RG/WCJIJVR
	fVFWckC2pfCyE
X-Google-Smtp-Source: AGHT+IGPS115Cmr4KUTW68oq6tHPrsumhkSkGLJtAe4Kr0DGy+s9Au3HSEUde31TWNaWJoMUBia8LQ==
X-Received: by 2002:a05:6214:5003:b0:6ea:d49f:ddeb with SMTP id 6a1803df08f44-6f23f137ee8mr78976896d6.31.1744413990761;
        Fri, 11 Apr 2025 16:26:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f99bsm43628556d6.25.2025.04.11.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:26:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 19:26:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 4/8] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <07a91be3ec07183d440e5ba6d579995d63c6ef85.1744413969.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744413969.git.me@ttaylorr.com>

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
2.49.0.229.g19b69c1246

