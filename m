Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EB3BB108
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782500560; cv=none; b=XTuxxiYNDWuRwc+UMtY/4fgNj6nEWsI84ieCsqX+xWIFjJwXxD2nSUEBk4ZJzq1pFsUmAs9qyF5ErKtW8tJG8aFkOreoTgAsfAN8bXkyAmjbv02DBI2VHhxnhGFf7+Eb9WphTZRTvQPQ1kCernIqVAmCmqmTQlg1tIoLLO86/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782500560; c=relaxed/simple;
	bh=YR1qsrLVN4BWT/wEotz/L5bSmrI5w7fy6F1ErED/QVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Db7kmi3jrtkQvh+6zf0463NOfa4JKy60M59mRYMCSgYcg/pLVU67/4S75A2HVgbMD6arfYXdKrIPaaOGyN3bjr5fR+ZmbLo5JPxWpFmYTt8kEcUHYqoqkKKp7kwhhmbtAnEZbTbl3kb2kvr7MiFUkt74wVKu8GJLVyIz/A+97hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FMaXd2HX; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FMaXd2HX"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-662b95934dcso1480404d50.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1782500557; x=1783105357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aKUjhde4FbR62MuN24GAW80o8kqZNhnVIr3MhFYpvrA=;
        b=FMaXd2HX03RZJi/J9We7l9SQHubdjQUDAn687qNHhMKZSlpiYJOzkdiWHGzyFndvx4
         lEqAB59MotMHQm16FKUB08nOthz0c27KW71PB2YsjPwA7fBD8L4gEBl0I/KCTFAcjFKC
         4fNyCjauq8zvjhk7/DC8jNqVYf1yQSlah4zrPibaELm+B8Kdx07rLjQaEfrGuAC8PLQV
         d1C7DcukFAis9hE9ZOoseUsZQE5hSZwOYMofrUapsaD5N1Wv0PK8iJq/0KAoB680sWeo
         6BXWVl4qlkupikxQZ5pTlldAW/M7HV4FObhnLUwlugag/4SZsuZO8A0wduy7EmMkdEu5
         1fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782500557; x=1783105357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKUjhde4FbR62MuN24GAW80o8kqZNhnVIr3MhFYpvrA=;
        b=a+oJCzQTpB0m9pP9U0y6pXByTcTICj84uJwWoNVgOCKedhyciELYdac3R5at3bbHT9
         TXpqZudIVWZ5En2NFyRkCFDZOJzixO0NAPLA3jLJhFySr4J3S3JxtGQRirTMmW44/k9N
         w2He8x/BF+xoBb7GeMqVXcOLcZuNiSceH8FjF1g7HXboLz4L5rCLumGlI5xGBjSWdiE0
         2l01HWh5Y1v78G0NBhR2B0t+X8EAg+fsKwbZCu9Vgia7zWCHdimjiSbtZkhh6NW0j30V
         PbV9DgIEzGWZgSSYJKzedRMYYWZc/NAbO7koalMp09jTp1EyNgcFCedRJJdp519rm9Oh
         lecg==
X-Gm-Message-State: AOJu0Yysj3l+r/mOdtNGrMQSJdUod8GXds6x5E4I/H0BvSfg27cR1lGM
	KMq6RnrAmvzyutb75ve2Sc2rQR9x1YK+OOaJvO0tZdLfLXjiGhOmHALJtxyzD/7U6jvvu5uw97F
	RIoDeVMbqHtPj
X-Gm-Gg: AfdE7ckRB4ZV+0c3W5nqdq2nQWfdpBTxMbdH4aGpd4zdgRdEqdODpNlV9YwLfjrR07q
	D1EgGjA5p0cGdT9O+R2PoNp1Tzo+F3aRGbPXbVokstJji7HxdpfnjHfKCVttVDa0T0Ds5Wxgl6c
	8QYua4dD84mihBfInX4vuIVBlSl7pg3hQDrSfrckgKZI0uJBiK6GN/QlIOPmtQnws7gp7ANXAMq
	VmnDGd55NIa4el+DnfHQpZgbidG7apbC727dhAKwnAJwnPla7RuAEd/g5us88GuSDS06JRSzWW/
	ooF3fP3bfqNmyJoGWqJfXXQyqZGNo7sjbo0RtGdsa/pKKnElvEx5peo7xb14BMIbQ2me1eQjfe5
	fNjly94bjhH9hi7TQLTUhbdGEx44E6wQjEOQCZL1s2bOOFZ+sHCzIN3JBHduF1PqIoSx5kmNA0R
	ggRf4hM0Hw5Bb5Cwvffu/QllahGKdbkk/Xp4IEs7l1n3EcGFdSuUKPV0IPu40RtdDxhyR4w2J5f
	BJUnBAqcl24wkUvqYG6/lvoWsYHk7x1lvLl3g9jJ8i1jCW110QH+bjpII3uqD0y4TjQExQ8RKzq
	jhBo4HvOvj8xIqAh
X-Received: by 2002:a05:690e:bc7:b0:65e:3df3:1c30 with SMTP id 956f58d0204a3-66487b4b196mr6022656d50.7.1782500555639;
        Fri, 26 Jun 2026 12:02:35 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6647f7a7eddsm3262620d50.9.2026.06.26.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 12:02:34 -0700 (PDT)
Date: Fri, 26 Jun 2026 15:02:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 07/10] pack-objects: extract
 `stdin_packs_add_all_pack_entries()`
Message-ID: <ded6e1110fedd20a960da2df27c55cdd9f741881.1782500507.git.me@ttaylorr.com>
References: <cover.1782500507.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1782500507.git.me@ttaylorr.com>

Extract the pack enumeration loop from stdin_packs_add_pack_entries()
into a separate stdin_packs_add_all_pack_entries() helper, and have the
caller dispatch to it based on the stdin_packs_mode.

This prepares for a subsequent commit which will introduce an alternate
code path for '--stdin-packs=follow-reachable' that determines the set
of objects to include via a reachability walk rather than eagerly adding
all objects from included packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 27048bbb4dd..29e43abb51e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3933,30 +3933,12 @@ static int stdin_packs_include_check(struct commit *commit, void *data)
 	return stdin_packs_include_check_obj((struct object *)commit, data);
 }
 
-static void stdin_packs_add_pack_entries(struct strmap *packs,
-					 struct rev_info *revs)
+static void stdin_packs_add_all_pack_entries(struct string_list *keys,
+					     struct rev_info *revs)
 {
-	struct string_list keys = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
-	struct hashmap_iter iter;
-	struct strmap_entry *entry;
 
-	strmap_for_each_entry(packs, &iter, entry) {
-		struct stdin_pack_info *info = entry->value;
-		if (!info->p)
-			die(_("could not find pack '%s'"), entry->key);
-
-		string_list_append(&keys, entry->key)->util = info;
-	}
-
-	/*
-	 * Order packs by ascending mtime; use QSORT directly to access the
-	 * string_list_item's ->util pointer, which string_list_sort() does not
-	 * provide.
-	 */
-	QSORT(keys.items, keys.nr, pack_mtime_cmp);
-
-	for_each_string_list_item(item, &keys) {
+	for_each_string_list_item(item, keys) {
 		struct stdin_pack_info *info = item->util;
 
 		if (info->kind & STDIN_PACK_EXCLUDE_OPEN) {
@@ -3977,6 +3959,31 @@ static void stdin_packs_add_pack_entries(struct strmap *packs,
 						revs,
 						ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	}
+}
+
+static void stdin_packs_add_pack_entries(struct strmap *packs,
+					 struct rev_info *revs)
+{
+	struct string_list keys = STRING_LIST_INIT_NODUP;
+	struct hashmap_iter iter;
+	struct strmap_entry *entry;
+
+	strmap_for_each_entry(packs, &iter, entry) {
+		struct stdin_pack_info *info = entry->value;
+		if (!info->p)
+			die(_("could not find pack '%s'"), entry->key);
+
+		string_list_append(&keys, entry->key)->util = info;
+	}
+
+	/*
+	 * Order packs by ascending mtime; use QSORT directly to access the
+	 * string_list_item's ->util pointer, which string_list_sort() does not
+	 * provide.
+	 */
+	QSORT(keys.items, keys.nr, pack_mtime_cmp);
+
+	stdin_packs_add_all_pack_entries(&keys, revs);
 
 	string_list_clear(&keys, 0);
 }
-- 
2.55.0.rc2.10.g29e31820dce

