Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB8634CCE
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023890; cv=none; b=VwTlGaskFoDdx8raFgF37pANY5GcRLksu5JQPB1603eTGy05zuAhE6JBTB7syTR4d91s1ZxDy3ZsSgjmQaCo5ICDbc6yH7ghyI61s5ajx4aySuvhcg9dte4d9+O0Ryul3Tz62PsfS8T3MASlILfRUjkPoWW8GcZF0QD7xJ4AWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023890; c=relaxed/simple;
	bh=22duSLKBpnPO8tdWPRiEvZ20QK8bADKoWmOKuulL8WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcNtgVb66xqISI1XO8Tmyot0FnSvuCRMtNWSx58/l7OpBjOxbyl8dYe25wmHpmDsJIEkftyQoSHlYnTabCT87NXxPDdSbH2mQaGYZGfnRWA9+tZdBTV4Vlj2K2qQVR7qPGztGafLHA1VfVaYA1JMSP7F4GI5APIl5I/GcfJFxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ggLmOdPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXvGW35i; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ggLmOdPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXvGW35i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9CC777A00EE;
	Thu, 10 Sep 2026 03:04:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 10 Sep 2026 03:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789023887; x=1789110287; bh=+DdO91WRXA
	/7TaN1G2C8rlLbtYJP/zV04r5XieXAkB8=; b=ggLmOdPGjk5Ib8aQgIsl+ZjQ5J
	WlJn2S3gzsWZ9WTNZQaHfN2ZAkR5S2OoWPJMepRE83/mEeqej6aqgVo3vH2hHb6L
	4Tby2xjADtfNm/NptUuAD4wL/tuiIvXgNtNg2Gif9SkKO1Py4EE5lwObhoHYu+yO
	1ZUR8zbyHVibQ1/REH7SS+27InwlG+n8a2ZD/K+zSUWS2FMCGE2dTL2+uKhb2ffw
	YJ/Gz6qriNKSGQNg6ozubIliiWzjs37w4SFPBIQfWIpW6F4wiEULXcqVzI3QjnG1
	MDk+EeXRZozfcpm2tOGdTMOhgyJNWD+OvokGuVBKVVEd+5C50gHO3EVKNSeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789023887; x=1789110287; bh=+DdO91WRXA/7TaN1G2C8rlLbtYJP/zV04r5
	XieXAkB8=; b=DXvGW35i7+L17L1m38+dD9UHSbYTSaoPsNs9mDhO1KjaTeKAucv
	k3gI64lcbl/sIG9oVHjUfKMhtlxuur3btxBZ5JblI0jhCkr9EprdGVMHEZrTxN9q
	F54hbStKE5cAs9kFyr4j1LnvsCJ5gatvIp/DfNItLtriGGlkFpnXbQE8a842vRT3
	TByBey5cSfoRF1OIBh+g7La6iTDu+h6Ewuyzdnyc4nTRDtK/+KGLHyEQ8O/eNBAq
	Q1I4VR0tNyfW6bA08+aBWuv7vQMLmIoK+QQcyUVRfcGKZ9VgDgTAmJ0HrONWPh+U
	j0Ga0O/jvivMQ8mFJJo7qGyHXmiwT6d/IkQ==
X-ME-Sender: <xms:j1aiaoGon2LQM7FalLu6PK9bvCOnokXbEpuAiUCgZvuXoUuRCfNB7w>
    <xme:j1aiaoOLd7_FNFwUuKAI3riC-Onq2K9xcmukvOlJBTOETSs-0fCe1dP-3gwnGCLZ6
    JbI29E5VWaPQ9ieV57TbR5iJpOko2FhmWJRVtZ8kNOrK9K-UMfJAQ>
X-ME-Received: <xmr:j1aiaqerFMdR79zcbVUZHEB4reSsKBb_t2M3W4IJBrN_BgDxIdBqpg>
X-ME-Proxy-Cause: dmFkZTEk0L3HpALCiE6TtBb2I5fX0Zczcp8mWSvz9GNppDuMaOOnFDKAGvua+JfzvLj2YV
    4AERTVSa891OlpMUszD3VICN4plONrXhxLC5O9Z3nt7GIZxpo9EdZ/FMubPvVkIcMB3Oie
    yI6+bYbEh6GUb/uk987wiRp5J12vLFwNZYObzHi7s1mXlKhLRofb8OjikDx/msYLz8JWWC
    lH5CkPgQF0ndWDNJJd2J+hKmZczCnC2rFplQ9BQvFsKHTIkO3xvcDzQjs6rW2iQhjKL1Vc
    AhdEp4LKJD3kYswbSL67jDHBPg/2G4rQFCBh+esst8hnYb/Ba86kmeIkI/DwOM4atuFXBn
    bjZJlFaW303t927wVuxn9rfAub2IkIMJYs9hnJzLF5SiFlBrX38cax8CqOKjGMsz4EFOYT
    RhQ+mzd1rJBIS4mOgxbpwxMuvKvcx33BLH1e81COXOJSPc98CQEdNiM6H9Sb1kWNnXrSWX
    pDxKuZJRjmXl3bCUfMv2xnqSLFhLtRP32PqrAxa53WVA2mqE7Y6AzKAUQsERaOnP4sjxUD
    iGeC0QiiFNK44EtkzjHZ77oSauQhb5cPlSWBb23lsFDWPYoX4YXmcT6w5buS26/w4KyV0y
    o12dqioktJXb6O4IPtWEdKRAJBc9OAjfKPuRLwDlz2GMcjI7mFKUD1Hi9I2A
X-ME-Proxy: <xmx:j1aialtKmutMq5I0eg1UuU3TziLoh4FVopCaSok5s7_vlPU-GiahHA>
    <xmx:j1aiarkneZpvGL9Qqogps2cCHs0MKncjclHef2Pc0U41HUXNj0LToQ>
    <xmx:j1aianx5zq-D_eVtScROQzH-HuEVt3n6hCKFK-sSnwHo3rEB-RWbbg>
    <xmx:j1aiatNpmDikImb_RtksuXRMLu35YSRSrbr2iv6ZBNXli2lVlB3jjw>
    <xmx:j1aiate49xe-zrhp8fCSgVnUZlWq4YQLVuqNf8A2KdRYyBtBbkSb92wa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 03:04:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3b5ae618 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 10 Sep 2026 07:04:45 +0000 (UTC)
Date: Thu, 10 Sep 2026 09:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>,
	Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 6/6] last-modified: keep per-path Bloom filters for
 wildcard pathspecs
Message-ID: <aqJWihcFmX7tPio5@pks.im>
References: <20260901-toon-speed-up-last-modified-v4-0-a09949800404@iotcl.com>
 <20260901-toon-speed-up-last-modified-v4-6-a09949800404@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-toon-speed-up-last-modified-v4-6-a09949800404@iotcl.com>

On Tue, Sep 01, 2026 at 11:10:26AM +0200, Toon Claes wrote:
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 8ab7944314..bedccb3ace 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -370,6 +375,14 @@ static int last_modified_run(struct last_modified *lm)
>  
>  	prepare_revision_walk(&lm->rev);
>  
> +	/*
> +	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
> +	 * without a Bloom key. Restore it so the per-path check keeps working.
> +	 */
> +	if (!lm->rev.bloom_filter_settings)
> +		lm->rev.bloom_filter_settings =
> +			get_bloom_filter_settings(lm->rev.repo);
> +
>  	max_count = lm->rev.max_count;
>  
>  	init_active_paths_for_commit(&lm->active_paths);

So the revision subsystem is unhappy, but we basically force the bloom
filter settings in there anyway? That feels a bit fragile to me. Is
there a reason why the revision machinery itself specifically needs to
have the bloom filters populated, or do we basically just have to set up
the bloom filters so that we can access them ourselves?

If the latter, can't we instead store the bloom filter settings in
`struct last_modified` instead of forcing them into the revision
machinery? Something like the below patch on top of tihs, which still
passes all of our tests.

There might be good reasons though why we can't do it this way.

Patrick

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index bedccb3ace..dabd0b7c34 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -58,6 +58,8 @@ struct last_modified {
 	bool nul_termination;
 	int max_depth;
 
+	struct bloom_filter_settings *bloom_filter_settings;
+
 	const char **all_paths;
 	size_t all_paths_nr;
 	struct active_paths_for_commit active_paths;
@@ -117,9 +119,9 @@ static void add_path_from_diff(struct diff_queue_struct *q,
 
 		FLEX_ALLOC_STR(ent, path, path);
 		oidcpy(&ent->oid, &p->two->oid);
-		if (lm->rev.bloom_filter_settings)
+		if (lm->bloom_filter_settings)
 			bloom_key_fill(&ent->key, path, strlen(path),
-				       lm->rev.bloom_filter_settings);
+				       lm->bloom_filter_settings);
 		hashmap_entry_init(&ent->hashent, strhash(ent->path));
 		hashmap_add(&lm->paths, &ent->hashent);
 	}
@@ -265,7 +267,7 @@ static bool maybe_changed_path(struct last_modified *lm,
 	struct last_modified_entry *ent;
 	struct hashmap_iter iter;
 
-	if (!lm->rev.bloom_filter_settings)
+	if (!lm->bloom_filter_settings)
 		return true;
 
 	if (commit_graph_generation(origin) == GENERATION_NUMBER_INFINITY)
@@ -294,7 +296,7 @@ static bool maybe_changed_path(struct last_modified *lm,
 			continue;
 
 		if (bloom_filter_contains(filter, &ent->key,
-					  lm->rev.bloom_filter_settings))
+					  lm->bloom_filter_settings))
 			return true;
 	}
 	return false;
@@ -375,14 +377,6 @@ static int last_modified_run(struct last_modified *lm)
 
 	prepare_revision_walk(&lm->rev);
 
-	/*
-	 * prepare_revision_walk() clears bloom_filter_settings for pathspecs
-	 * without a Bloom key. Restore it so the per-path check keeps working.
-	 */
-	if (!lm->rev.bloom_filter_settings)
-		lm->rev.bloom_filter_settings =
-			get_bloom_filter_settings(lm->rev.repo);
-
 	max_count = lm->rev.max_count;
 
 	init_active_paths_for_commit(&lm->active_paths);
@@ -530,7 +524,7 @@ static int last_modified_init(struct last_modified *lm, struct repository *r,
 		return argc;
 	}
 
-	lm->rev.bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
+	lm->bloom_filter_settings = get_bloom_filter_settings(lm->rev.repo);
 
 	if (populate_paths_from_revs(lm) < 0)
 		return -1;
