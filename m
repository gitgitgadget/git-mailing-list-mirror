Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AAA3370F4
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251374; cv=none; b=MfFTN93hBJEfBZv4qz8CZwgtUgtjnrUrtqhylI1y9IU8AClqTYnhQqVufZ5OqHZ5fmvMOwew4dAzdi/5x2KwcSzwfObd7z8vFIYUsCAr8x6ym6EihCRQaR7Qi6ZSwdiqt7NvlHmy92B/Ql3MUIjzgN+RrMSoO1bRSWsMnwYSyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251374; c=relaxed/simple;
	bh=N4bl45+ugHBhJTK8b1LEjbjDMqTcTFmnyc9du+YCtG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hNr+1fAsJKCLHGBtDp4N9tfOyfgGC9mdq21+38jVRk1B4bzZknJobJCUVwltUedZ9zvc8O1SqCzcKBoBXbJqkI7ZkN0kWPrEgaGcXASEdJyq38ofSjJEZWWUuwIxwOYVyF5w6T8niavMAkDtjWrXWshs5DtmHjf80ihril7BH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XB33NhRS; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB33NhRS"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be19f05d7dso325090eec.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251372; x=1773856172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=XB33NhRSc89WPpV8o7g6OeZUoZWgs2NJLKUgTgyyWPk55raehp5cwGqj1HvUGs6nll
         kt8ivH9VshD1X1jp68mhmTKyCp8a652wWC178RM5zes3K/EoTX1t3/NOPM2UD0hYsPFy
         Aog5wL5iJexoYEyGZGuwQA76+pifnZ6O9Cyh5bJ5RrvZ3p1J+RwB4995Zy1qVdaLBdGY
         WqE4PQ032/QK49ahhCe1eQu+lj3dua1JnI/bvixy/lO2ssJ0wdW+InWRHixm34ZQH3M3
         fkJYCz9iJqa4+TFscSTtPUUChvhaHtMMFNzbP3piduhgLWEcXqg4oLdcNotrCOfCinDa
         z39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251372; x=1773856172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=CgBso6nOpOWjQdNmmOXNoIQSKzH8dmt3eDMsvRW8VUDeDZwb2qYrP0mRhrzF727UOc
         p3hytcnsDxHB4BCLPP13bA9CSDVDxh254HUs5x+iA9JydTsjW9ZxRFPWTpONmd96ziMz
         cK0cYkoqRFoOaQkRyEXiKI8wvgdNeR5EnlcoMXL6gio89eUNP6mdCt1EJ+Nxn1aOT6kP
         JvBLD4gAAF86XhdDKeRiq5guvxfiQlLsDJuGftwRZ7Br5jGTRSBweZAg3sjCObpNS/T8
         tUfBspmwizHonLnZewUbFWalg8DKO7D7nh+d8wAg4vSAlllDaWa9jQlk8NCOdaiMaaxX
         /bNA==
X-Gm-Message-State: AOJu0Yz7yx3jvcKzdozt6+crOhDCL+t5CdVFU0gk//0lkTF9aygUJEja
	StAaGjvOrd7fWv2A9zZ3lrNiCj+IVo4Y54rP2yA4DT0nv5zfLGMW5of+eDgywA==
X-Gm-Gg: ATEYQzwGhEZHvyVVls/LxN7fYNJ5Ng4BGPB8A4aQ1QwFLyQSIj55uW4+I/4svQnDYMh
	3y11EcGXvchhJ/BVqsQJ5RZiqSXP/3mfE/vtDw2CSUXvUAwESy2kvULRQd3zdWTRxmNRDCtWTHY
	SnFvxBCqgSu7jZllDf3vCgHGrRAv9mztFl0InLp/nGi9+xumCgcg3OwRBnmX5O0kvCk+opl0Tqu
	gay8Tq6n3xIsuJLSSq1vTTNqWi4b4+dKgQ1s/HbRgW2G8VYONxxa5EU1TMmqXYrjEI1rnTnd3W2
	Y3q1GNbYVmnmGUaR7RHrv4Hsav/Vo+yhZWokk4UtYazc1GnXmfDVM5AxUOtr+2y3HqFFhaP1ta8
	tNoDzngN++RNKo4M71QcxU9vKLF4gO0O6vs3YcVexDYKMmSX3JXr3FTvpPOSCNZOx79ZSKeWYAv
	Il5JciluAErnV/8xysuuGlE0nfEfY=
X-Received: by 2002:a05:7301:1699:b0:2b8:261a:fbdf with SMTP id 5a478bee46e88-2be8a53e34cmr1442717eec.39.1773251372270;
        Wed, 11 Mar 2026 10:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.192.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa97dcfsm3239962eec.33.2026.03.11.10.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:49:31 -0700 (PDT)
Message-Id: <eb5639dbc3571fde15f2d93cf2d137b8df775d2f.1773251369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
References: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
	<pull.2233.v5.git.git.1773251369.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 17:49:27 +0000
Subject: [PATCH v5 1/3] advice: add stashBeforeCheckout advice for dirty
 branch switches
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

This includes:
> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> New advise_on_checkout_dirty_files() function that lists the
  affected files and suggests using git stash push/pop
> Documentation entry in Documentation/config/advice.txt

The advice follows existing patterns established by
advise_on_updating_sparse_paths() and can be silenced with:

  git config set advice.stashBeforeCheckout false

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         | 27 +++++++++++++++++++++++++++
 advice.h                         |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..8752e05636 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,6 +126,11 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
+	stashBeforeCheckout::
+		Shown when the user attempts to switch branches but has
+		local modifications that would be overwritten by the
+		operation, to suggest using linkgit:git-stash[1] to
+		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index 0018501b7b..e1264f525c 100644
--- a/advice.c
+++ b/advice.c
@@ -81,6 +81,7 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
+	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
+
+void advise_on_checkout_dirty_files(struct string_list *file_list)
+{
+    struct string_list_item *item;
+
+    if (!file_list->nr)
+	return;
+
+    fprintf(stderr, _("The following files have local modifications that would\n"
+		      "be overwritten by switching branches:\n"));
+    for_each_string_list_item(item, file_list)
+	fprintf(stderr, "\t%s\n", item->string);
+
+    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
+		      _("You can save your local changes before switching by running:\n"
+			"\n"
+			"\tgit stash push\n"
+			"\n"
+			"Then restore them after switching with:\n"
+			"\n"
+			"\tgit stash pop\n"
+			"\n"
+			"Or to discard your local changes, use:\n"
+			"\n"
+			"\tgit checkout -- <file>"));
+}
diff --git a/advice.h b/advice.h
index 8def280688..c035b5d8e3 100644
--- a/advice.h
+++ b/advice.h
@@ -48,6 +48,7 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
+	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
+void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */
-- 
gitgitgadget

