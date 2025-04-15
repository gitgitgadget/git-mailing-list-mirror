Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FEC2BD5AA
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757222; cv=none; b=J/HEZQ8pKhkBZc5EhzCsoECEBM7pG8a7YGazKX4BkY9ZuTYyj0L6n7GkWydX/iJntC5lioP5lSK+sNp4CWivrXd1+67w+5Ge0INa3DZ4jvQTGUFrd4zCXbHJ6CNYJYIFRpBq3j+cMmcUirsiPhlmu88E4/hjF1t9wpx34i3Am3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757222; c=relaxed/simple;
	bh=ELrf1JqNaTOTgDlEQ2EbTuV3AH6cksprrpznX1E14Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhjQVrJ021n4M5UA8i9k6+3BKNZiKvqxusdApyOgNUdX05He9IyQwQ8HhdR0m7VMM02F+kZ8/5FuXmfXCajgSaTRdIg+9WDF0WfjkZ2bSx6CCh85OwoFLjJq6ZetTSnfs7KaBRT4W9PdJcZKMg4KfYCULgNXhZ3InF42XblI07c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=kzkgWzeT; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kzkgWzeT"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47686580529so64059581cf.2
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744757219; x=1745362019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lqVsSO2M0rsqeART2rhJrSYaB5f+IKmzy4Q/yUCFlY=;
        b=kzkgWzeT7LVdNEpHPgg+GpQm0Opb2J9aJOHPqJD3PmoBZewa/A3ZYXGhO2yTmqm/Q+
         wzCy14p6IXpmYTHttqC68gPTCIvW16+eU1bKYzj6VKRBC8dkLMc2waLhteNE/JVpuHm8
         o5bSQZCdS3Rz7jMN/L54qja3nKyDFLTzeWXY4ZQ5TdG+xTV6uG1ZplQtR/x7SxKYeLcE
         dC+RFmePYcy84tw7YmiXye5GpAhn2a29tUM+fMwtMuurREKiHEeEOsAT5NONqwO7BkaS
         QkLVnH/5WFDuZNbwV1rbkLuj97VEicXdzlaWeZU33CrC0yL5Ohlg7XjNjBSg3TLJEBnB
         64Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744757219; x=1745362019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lqVsSO2M0rsqeART2rhJrSYaB5f+IKmzy4Q/yUCFlY=;
        b=pTombWlucN1I1Acz8gCDFIzDoCMvltzJ5m9xPiIFT/B9NdlmXGsjckQNPvHfSOdhMM
         VWOdSVe07+HEU05DZTlqKygbCCF5YPbZhX2RiaFryaTe5+yVP+xkSmDvA9tMth3pu9N9
         1G3Q2blEGm1WUUzyRgNeZpyutu84CdVg2Yiw6VyukH7YgzgQfeuM52A4aPiW6LLryue2
         5qasoNxewmVcfVslKZrSLq7yAChT0AJYsZG4S1fvSa6PjX8kJXpKDpIkpOAO5I1LfTew
         L+pufGeWRqBe7GkjPWNvEkyYfOjmo1pp7wR92sDYIhPZItUB5oveBJekU8nvlIuSvBww
         6tQQ==
X-Gm-Message-State: AOJu0YyBpwLZti7uEkhKrojNQ5G6aJXRZnb8Gwei763U9fVMeUwFd3kk
	yF0PIhWnkJrPqRoVajmHDM6il74dCEFYuenBUhJ77BeUDO0qxbY+rHAcDMsvQzhjScxwKnFvk2b
	zBRM=
X-Gm-Gg: ASbGncuOSZiA1IGWtCdSM8n/N2WhpxN1PIgvMF9YMY8kw/E1ToBBr5Ws5dPtXAqE0+4
	vGumkxsDRTEjzcOrd9RkCxYijDlfPWp1zIsdxV+JsXx1J31KdYU6gTUCMzrC+fRZrbw8Oh7mYDc
	ML/VEw2544vtTb4fSwqjiTQsqW38q53EmF4q2vZiv97rzXDK1yvkP2E+TWx54HrPjX6NtERqcuc
	ZQ4k2DF8G4B5Txg6RJIMMiMtjTCq2ic0LkvzjQEJ4M/28oUaSEiHjO14f0MIfaWJSXiKdt8Hvlh
	Vc8BxSDrkRJv8IaJGVaHkyg24hh0JMu+0J+WlxR60116ctssq6zA7JiE7APneTRYdQ67/L+cSJx
	x+Y+U6YelpdeY
X-Google-Smtp-Source: AGHT+IFdbc3mohfT1mDPA7mYVDdFDxbIYXPfXIY/2vp3L+2eylwgy99S32jQ0P+7prL2kP4wrhu1Tw==
X-Received: by 2002:a05:622a:2c3:b0:476:75d0:dbed with SMTP id d75a77b69052e-47ad3af0159mr16644021cf.44.1744757219257;
        Tue, 15 Apr 2025 15:46:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c917034940sm5593885a.53.2025.04.15.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 15:46:59 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:46:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/9] pack-objects: declare 'rev_info' for '--stdin-packs'
 earlier
Message-ID: <2a235461a611d7abd90311c51174e2ed85eafa1b.1744757204.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744757204.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744757204.git.me@ttaylorr.com>

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
index a293267074..d60cb042c9 100644
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
2.49.0.230.ga662d77f78

