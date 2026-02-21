Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039333DEC7
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718398; cv=none; b=Q2c9p6YL/62QrMeZjE+S4nGDhCvQQBi9x4w5SnDAijNpmzI1V2DIHm9xb0KjFjuYAWHS1/ZBTEt+iocfTFp0nXQEwN9dp6QD6ThanYHfH7u4e6lpQg51BxtezxyVeUgd5iDBOZLgEVTfmNu1Q9KT16nUYRyvBRWv5oCxyZWMn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718398; c=relaxed/simple;
	bh=zIiUPTQHzg/zuZGGbIB8pmbCRLl9/QEPKBPHkEPwAKQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e/JFjmL6kUY/owbXjvRkSsq6IJI+Z5xxJYD0LWnhZkwDz0qgqnFN2+Immvk5WEmcwyxXg0xQ9hhah4AXxjWJfrNEi8CLI4UNBM/qMAitNYQjklropQTM3ZX0+RNgrcUTbHBHMhudGi8FgTDV3FVw0J+6fPImJaEhwdC2kId5kqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFTepkZZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFTepkZZ"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8972a14e27bso42903276d6.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718396; x=1772323196; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4ALP6Po6HY++BIj+P4dfA31R5AxvChdVG0wPRiuzxU=;
        b=XFTepkZZiHsVMoKUC9cUfaL6mfddY3zuOjiiwTcBL2ouPY65PM7G4Y+aywtmg11VlO
         avbkWTDeqNsG79eL3qnOAqVYdn0nnyIdPHwVXiyhsS+/j0aVAlktL7TrsPLMlxbp9Iz9
         UcZvW8pwHxBcSRPmFSY4W2/lHD4smdmsKNrah1m4Yvx8HLUhOlPDwRgeomQ9uEly5V1k
         mTHJwpxfcmMOQPv9re2yCF6CfEKFxbRNRPFnwDbByjB1y1ZXzxc0u9x48WMVS/i+SZe5
         PQS9nzv6CUutpDcxIzU17o4EhiPAzs5gggI3xpmcydfC8hTRy0X0X6bHdyLWNhgc2X+y
         /QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718396; x=1772323196;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N4ALP6Po6HY++BIj+P4dfA31R5AxvChdVG0wPRiuzxU=;
        b=YGj8O7Y159Itb2voI/2xCQssbpXyE2N33CN6yeVYxAMhAA1qcwoqnUW/CpAqxmj6ir
         TikYh+XoBAsK2McPP3ol02UJl0hbtENEdPK32pm+p1iqHQn35HcpDYPUtzlnteZwmOaj
         R9yKtu0K3zdJT0i0CeyBdzU4cRCezGQVx/Q7DT4ukRw66ecT0gATHE+6/hFqjuEUartz
         BWIOdsl7+iSk4/Ii3NH4+GEIviKPbHGTp1irhAgQRaS8j1bT2+cb4KCLq2T1St98Ruio
         9QdIHgvPtwIuIKSBpillx5W2Nz5BwZ5YIgRar04ZKhlVgu+EpENDbDi3Iga1ESlW3qzp
         sUpQ==
X-Gm-Message-State: AOJu0YyGSfZkC3Fq7b7wR2bI+LPa1q7vNTZl1KRQLd+sf64aSRFN797j
	w6Ndm3q9xfW9sNfZXrsQ0LBBCMeibS+4a61KzDOlUU8iDVfip2NvA5bBznAjyw==
X-Gm-Gg: AZuq6aKcqLHk3adDNrif9C+MjJwdoSu1hqX8u5nLTinpYFBW3Yj9uH2ihlOBDqaX64S
	aXq15iEFAB++bq1OG4Z8tQHUbIduWzBQRnEihKvjJenCz0Ge+kBdFTlhEZ93CZi0Ybb9y67S54E
	04ygJJdmylxt+DCV6Kj25S+PXWAr62xMDpEFaIzTEfy3IMIdX+qP5Cc91BNYS9Gt4US3Smkzlmf
	G0NXp3brmQh/cBSKEpZpZlXADnNEE2tgJJ1+zRloo0ASpb77hz4iCJwqAvM1VsyJzofXsiVIW7X
	8cHW4z0E7cSxgozCfgiqU2emFO6Odz2NLd3SkDjE9NStqTEqu9JLpKSiNv1+uhfEDmG7LDPnxFn
	zhC7atBjIC7trOirNmltzx/fppT5oTVDWspGeFiK9GytuwQcHTACrSQDW9F2/sf3ruIXt/6HCol
	B/lmdsutRU5j31gnTWL6OXnr8N
X-Received: by 2002:a05:6214:482:b0:897:a78:ebe8 with SMTP id 6a1803df08f44-89979e5387bmr66098116d6.28.1771718395773;
        Sat, 21 Feb 2026 15:59:55 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6dffadsm29792881cf.31.2026.02.21.15.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 15:59:55 -0800 (PST)
Message-Id: <e75334a5cf04264250c63f9bf5ee745456aecf0d.1771718393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:48 +0000
Subject: [PATCH v3 1/6] merge,diff: remove the_repository check before
 prefetching blobs
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Prefetching of blobs from promisor remotes was added to diff in
7fbbcb21b162 (diff: batch fetching of missing blobs, 2019-04-05).  In
that commit,

  https://lore.kernel.org/git/20190405170934.20441-1-jonathantanmy@google.com/

was squashed into

  https://lore.kernel.org/git/44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com/

without the extra explanation about the squashed changes being added to
the commit message; in particular, this explanation from that first link
is absent:

> Also, prefetch only if the repository being diffed is the_repository
> (because we do not support lazy fetching for any other repository
>  anyway).

Then, later, this checking was spread from diff.c to diffcore-rename.c
and diffcore-break.c by 95acf11a3dc3 (diff: restrict when prefetching
occurs, 2020-04-07) and then further split in d331dd3b0c82
(diffcore-rename: allow different missing_object_cb functions,
2021-06-22).  I also copied the logic from prefetching blobs from
diff.c to merge-ort.c in 2bff554b23e8 (merge-ort: add prefetching for
content merges, 2021-06-22).

The reason for all these checks was noted above -- we only supported
lazy fetching for the_repository.  However, that changed with
ef830cc43412 (promisor-remote: teach lazy-fetch in any repo,
2021-06-17), so these checks are now unnecessary.  Remove them.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c            | 2 +-
 diffcore-break.c  | 2 +-
 diffcore-rename.c | 4 ++--
 merge-ort.c       | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 35b903a9a0..9091e041b7 100644
--- a/diff.c
+++ b/diff.c
@@ -7176,7 +7176,7 @@ void diffcore_std(struct diff_options *options)
 	 * If no prefetching occurs, diffcore_rename() will prefetch if it
 	 * decides that it needs inexact rename detection.
 	 */
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
+	if (repo_has_promisor_remote(options->repo) &&
 	    (options->output_format & output_formats_to_prefetch ||
 	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
 		diff_queued_diff_prefetch(options->repo);
diff --git a/diffcore-break.c b/diffcore-break.c
index c4c2173f30..91ae5e8dbb 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -69,7 +69,7 @@ static int should_break(struct repository *r,
 	    oideq(&src->oid, &dst->oid))
 		return 0; /* they are the same */
 
-	if (r == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(r)) {
 		options.missing_object_cb = diff_queued_diff_prefetch;
 		options.missing_object_data = r;
 	}
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d9476db35a..c797d8ed2f 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -987,7 +987,7 @@ static int find_basename_matches(struct diff_options *options,
 			strintmap_set(&dests, base, i);
 	}
 
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(options->repo)) {
 		dpf_options.missing_object_cb = basename_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
@@ -1574,7 +1574,7 @@ void diffcore_rename_extended(struct diff_options *options,
 
 	/* Finish setting up dpf_options */
 	prefetch_options.skip_unmodified = skip_unmodified;
-	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
+	if (repo_has_promisor_remote(options->repo)) {
 		dpf_options.missing_object_cb = inexact_prefetch;
 		dpf_options.missing_object_data = &prefetch_options;
 	}
diff --git a/merge-ort.c b/merge-ort.c
index 0a59d1e596..27a58a735d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4438,7 +4438,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	struct string_list_item *e;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
-	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
+	if (!repo_has_promisor_remote(opt->repo))
 		return;
 
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
-- 
gitgitgadget

