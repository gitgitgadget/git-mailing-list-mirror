Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D935B137
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096245; cv=none; b=YVlgVemFRr7z8p5o+Za8LotSNj8Z9rvV9S2JAeTVplekUc9sl/2S67WRC0bkx6kRmgpR+bV9iGBCfUVJJiXWmLTBcWoyJNQMEt8rDjcj2/VYrRD4QEWMo2Zw9tFtLedO6NX4MtK+txX1MKUiQOix0is4+xNSdxWJp+v6VqLjrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096245; c=relaxed/simple;
	bh=FHKHQBvEjrc1xsk3yUJEuWPhDGiZ7o3nl4fyCQtB5Vg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E/AwHN4tY3rREyJvlETEe46ClyI/sud2Yift+RRIpnX+9ig7VATRNghkvGAfDak0sgOokxbMbgLrOsJ3u1Q4h0aTYP2XcdnOMuIrnCBSqdS8Pf9dc88Z/pZ60YdPBlCDmqgZwgNerb6wYfS68M87QZWgJR5Mz5pG5/eAkTRMa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw2ZxqeY; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw2ZxqeY"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b714f30461so1021154eec.0
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096243; x=1769701043; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECcgHZIsTrLvN3Iq7C4nCOeKWlWV54F0mLmweBLGch4=;
        b=Yw2ZxqeYnY+LFsB5FixUdICoNTEU9PmIkCUiioysDvxbbKr1o9yOOdoxum4i+6iucJ
         rieADnAuQwHdLaGMXEfq4WdgcwBFjcsCAd3KXOC8AX0JE0+CJ8dP5x7JBlb/PXwDWErn
         AtYpnaODXaEgFpwhqn0Ueutj8GaP/Cp3nADBlU1zNGjiwiz5Mmz9ldOeAcHbL5daxBTo
         Y1Qjj19RHXwhMIv7EMAHNtsa+8TrghPomWsljjWXC02SPRFOnZobjSw8jL+9XSUSlQ8r
         ECtkYlm4O0zf70XbnFz6PQtMdABW+BZAM9eAINlsgvC9qdqGYeWhNjs08YtbwW0dRgA3
         gpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096243; x=1769701043;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ECcgHZIsTrLvN3Iq7C4nCOeKWlWV54F0mLmweBLGch4=;
        b=onq3LFvdooUk32hvm0sjx8PHDTF68tZPS16figr8aW+26O6JK8N795i8vpuZlB3Qy1
         c1obPh1fwXRTPoJmFXPre9UunmhZDk0z7oE0R9hbMPw4aONxxeN9pVXqGUZZpGGNZeeY
         tkQZUUQFZ4lra47UAqXd/fFMA8j1i0Z8Uxh3dR1Wm0GEtZiKglE8CoYYZsV9Vyp/41gr
         enJ/I0VpOMe1wGizdWa2L8C+aMZEiX4ug3/kAlnun3FirUrR+ne/NqHr5DlUx1rIfPNe
         aCPKKCYBjpHUX4cydVwdJ+I9genOEAP/Vfg/d1gGDHn3ufuBIzoe1AD+2rqVj3Ih87xb
         4urQ==
X-Gm-Message-State: AOJu0YzN83ypO2j3h8u2DqvIt+hVQ8QeJVryApVVxNC+Fr1kqHToqa3P
	RWFXwXLkNwXvJb/Nfh8pUZHmTXWofdGbvtnmhXkjRGxS1fe8BvvuoBUJIVoHIQ==
X-Gm-Gg: AZuq6aL+n0eOOK4TwJa+m4JhuJYhnj/1PYsPXBCHwceXba3apCuPsINo6o8Guvch/KF
	ZynckASax29BAv2p2/AFe6qDC1bRrtja+mNlSF6W/mxUSDxibbIZm+dLlWKrgjeZQb9T33HT/6J
	aVQrtho3+O6QFR7NVEslOXFRKU36UDQ2+wG2XfrhiEVKhn7JRcyHBihhWnPkBtbOCU7EiwoueSM
	q7XdKxVZnTje2ehcVk/WtxflHgYCjVDmhqcnQSHKNmLV1Mu20OZJojA37xjiJv2vlloOwCF49Qs
	oU+M03yL3Pq2Gd9NBGWr6MpsN/FKgwjO09WDhplWTRG/6mV7ESWPtklCHu8IOJtFxdxlzAh3Dh3
	5W+iFTm8uovUdo8onyFqnxOjY6y6T24doW9Bqijb2yYf+jm9hoTrjXawUJV3/5kPVSkhe5kVDyO
	hAuKdUFArBmRD7Z4x8nShcKtevEw==
X-Received: by 2002:a05:7300:dc03:b0:2a4:630b:c789 with SMTP id 5a478bee46e88-2b6b410c863mr14991322eec.37.1769096242529;
        Thu, 22 Jan 2026 07:37:22 -0800 (PST)
Received: from [127.0.0.1] ([172.215.217.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7093325e4sm9838998eec.28.2026.01.22.07.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:37:21 -0800 (PST)
Message-Id: <pull.2138.v27.git.git.1769096240.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
References: <pull.2138.v26.git.git.1768766353.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Jan 2026 15:37:18 +0000
Subject: [PATCH v27 0/2] status: add status.compareBranches config for multiple branch comparisons
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im cc:
Jeff King peff@peff.net

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: add status.compareBranches config for multiple branch
    comparisons

 Documentation/config/status.adoc |  20 ++
 remote.c                         | 192 ++++++++++++++----
 t/t6040-tracking-info.sh         | 337 +++++++++++++++++++++++++++++++
 3 files changed, 512 insertions(+), 37 deletions(-)


base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v27
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v27
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v26:

 1:  27a46f8d9c = 1:  27a46f8d9c refactor format_branch_comparison in preparation
 2:  caa761f615 ! 2:  0993420fc1 status: add status.compareBranches config for multiple branch comparisons
     @@ remote.c
       struct counted_string {
       	size_t len;
       	const char *s;
     -@@ remote.c: static void branch_release(struct branch *branch)
     - 	free((char *)branch->refname);
     - 	free(branch->remote_name);
     - 	free(branch->pushremote_name);
     -+	free((char *)branch->push_tracking_ref);
     - 	merge_clear(branch);
     - }
     - 
      @@ remote.c: int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
       	return stat_branch_pair(branch->refname, base, num_ours, num_theirs, abf);
       }
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      -	const char *full_base;
      -	char *base;
      -	int upstream_is_gone = 0;
     --
     ++	char *compare_branches = NULL;
     ++	struct string_list branches = STRING_LIST_INIT_DUP;
     ++	struct string_list processed_refs = STRING_LIST_INIT_DUP;
     ++	int reported = 0;
     ++	size_t i;
     ++	const char *upstream_ref;
     ++	const char *push_ref;
     + 
      -	cmp_fetch = stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
      -	if (cmp_fetch < 0) {
      -		if (!full_base)
      -			return 0;
      -		upstream_is_gone = 1;
     -+	char *compare_branches_config = NULL;
     -+	struct string_list compare_branches = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     -+	int reported = 0;
     -+	size_t i;
     -+	const char *upstream_ref;
     -+	const char *push_ref;
     -+
      +	repo_config_get_string(the_repository, "status.comparebranches",
     -+			       &compare_branches_config);
     ++			       &compare_branches);
      +
     -+	if (compare_branches_config) {
     -+		string_list_split(&compare_branches, compare_branches_config,
     -+				  " ", -1);
     -+		string_list_remove_empty_items(&compare_branches, 0);
     ++	if (compare_branches) {
     ++		string_list_split(&branches, compare_branches, " ", -1);
     ++		string_list_remove_empty_items(&branches, 0);
      +	} else {
     -+		string_list_append(&compare_branches, "@{upstream}");
     ++		string_list_append(&branches, "@{upstream}");
       	}
       
      -	base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
      -				_("  (use \"git branch --unset-upstream\" to fixup)\n"));
      -	} else {
      -		format_branch_comparison(sb, !cmp_fetch, ours, theirs, base, abf, show_divergence_advice);
     -+	for (i = 0; i < compare_branches.nr; i++) {
     ++	for (i = 0; i < branches.nr; i++) {
      +		char *full_ref;
      +		char *short_ref;
      +		int ours, theirs, cmp;
      +		int is_upstream, is_push;
      +		unsigned flags = 0;
      +
     -+		item = &compare_branches.items[i];
     -+		full_ref = resolve_compare_branch(branch, item->string);
     ++		full_ref = resolve_compare_branch(branch,
     ++						  branches.items[i].string);
      +		if (!full_ref)
      +			continue;
      +
     ++		if (string_list_has_string(&processed_refs, full_ref)) {
     ++			free(full_ref);
     ++			continue;
     ++		}
     ++		string_list_insert(&processed_refs, full_ref);
     ++
      +		short_ref = refs_shorten_unambiguous_ref(
      +			get_main_ref_store(the_repository), full_ref, 0);
      +
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       
      -	free(base);
      -	return 1;
     -+	string_list_clear(&compare_branches, 0);
     -+	free(compare_branches_config);
     ++	string_list_clear(&branches, 0);
     ++	string_list_clear(&processed_refs, 0);
     ++	free(compare_branches);
      +	return reported;
       }
       
     @@ t/t6040-tracking-info.sh: test_expect_success '--set-upstream-to @{-1}' '
      +	)
      +'
      +
     ++test_expect_success 'status.compareBranches from upstream has no duplicates' '
     ++	(
     ++		cd test &&
     ++		git checkout main &&
     ++		git status >../actual
     ++	) &&
     ++	cat >expect <<-EOF &&
     ++	On branch main
     ++	Your branch is up to date with ${SQ}origin/main${SQ}.
     ++
     ++	nothing to commit, working tree clean
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
      +	(
      +		cd test &&

-- 
gitgitgadget
