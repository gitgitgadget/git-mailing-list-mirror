Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BF279793
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419161; cv=none; b=jjuC6V8jQ4U+HIAJDMwW0w8ATiZStmNQ3t4Rlm9C+ansF+QeLp9bPKLwJH7Z9/v6mO/mogWnT1KIU7M9vSHd2Iqkm9FjvrSGCwIxMMjCVHK291RUqW4unTeWzVUnbkljRYWRWOoL6MQpvvG8vKI/STXjHDA00xwXmvzd8NFmNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419161; c=relaxed/simple;
	bh=qwpIY17GL0WTipGAN3jlCvk1fiLBPQ6hkVDTyH1hWJo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Vtr03txork7fB4eCiGSKCsjDgsBw9f3fjlrQcdZHkhBEuL0pEwz6QaC51zhbzX3/H9ko/FqMTnZbDflK1Ik0w7MuAN44lc2RQRHVQce8Ov5AJinVhF5Un98rfVcGMBiHYgf0r0O3n8nt1wB7HsEX2cpRZdPWbSXFc52Q5W7emdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/FdOTQa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/FdOTQa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442d146a1aaso21322385e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419158; x=1748023958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5FzD1eRSw6YykBNc0qDMIPthAstZGA4+28GDerX75k=;
        b=P/FdOTQaNVJToNgPogELYSkHghw4SXfn6oJGepPkbQLkcKDVBnReR7C4xR2AX3Gj33
         Oy3AF+bUrkxNmL9W8tr2lQjhSjYHyuu3Mo8iluiGfo8U1oXmxsQ+JY7qgQW6RV63HK0s
         QloFkgEOJEsT2GTJt6lu51BvGhobMdHNmouC4LNxFvCufbKIwA7ZmRvZc76T6SWCezKK
         76AAbEhQvz2xt3uZ3vKXp68UPx5RWMmLKsazqE2Z6kgNX8FqwY2lIYO9B2WXXxZz6KO5
         Qc476C+OXaAvUes23/0omD1MfHhaqN5rGZIe249x6G1unvzV7o98cqkg9yszQZf5hFzF
         fIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419158; x=1748023958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5FzD1eRSw6YykBNc0qDMIPthAstZGA4+28GDerX75k=;
        b=svegK4j6n3ZRsWZyfGA+0nvLq9skdZihVeZSwcQTLc5yum0l6id7q58KWdW0kUcMgm
         gOFSxfNdfzEOInI7aKuxDgdEJbpENH4qRUbVPqZqi5udLxb+P87YZNJPKV64TM7i716i
         2C/MdDUs2oS0S4+XcYXcRWEfhOdzvqw4kV9cNwzf6IcAzTxYYSI6p80PPtaREIAk9Xj2
         poOHrgbgQo4KRs5UbtlZ9lopHFOtc9N72iuk6CtxInehZH9NSQco90YQgjN6vsNdDrVL
         FmxZact51If8y1s4ozddWl5nPnXV9GA1i24pdFooVwcblNCe9+/hWHy5XxhKV4mb/cyu
         4t4w==
X-Gm-Message-State: AOJu0YwI1i0B/UL1LopyXmJMC07FpOP1v3C7Yp65kDirdKfIN0m8myMi
	CznnuFcg4mfJXBY/cQ8Ok4dbGIz1Ru+CyTSZkrxLZi+x9Q+DJ0OwalrEkf340A==
X-Gm-Gg: ASbGncuOjPWkd9lSWPKkko210S2WqmfDIREjFdVF9zwZhbLjSn9V5Dj1IrSruRwJGyv
	WCGP9i6D7HTunwKtKITWTw5DpeF3gVm4eKMhBEzoZGi1Sjx/olaIHTt5860gcRSw90DG2hiKmiS
	pQMe9KlNi7IwIF1cltQBJYmqvKrJxmuumhzraqgUF6TCECwFHlMThScm+OqOrkgiTqPKJw8Pq8s
	86ezxZFvVzyfZdMIrS7GBNMlwWv7laAO2GbYhUtZCedrNJ/+uixezgAFtKfXXMOtCxqRGU9f71L
	CsPKjz5R/cDcWQm7Weaj1hzXQyL2sHQWFRAQQG0/BNj2xJtaMIRr
X-Google-Smtp-Source: AGHT+IHKZqZOBbSiomrsc3BzBvzKPxBeeui8k+74J2X9hGpF8sTdkOnygwHDBc7/m+V5a+JwEfrbYw==
X-Received: by 2002:a05:600c:1c12:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-442ff0316bamr27535575e9.20.1747419157742;
        Fri, 16 May 2025 11:12:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a5b4sm3556124f8f.21.2025.05.16.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:36 -0700 (PDT)
Message-Id: <18241d382072a95463189d558d5873b867fe9bd4.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:12:03 +0000
Subject: [PATCH v3 13/13] pack-objects: allow --shallow and --path-walk
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There does not appear to be anything particularly incompatible about the
--shallow and --path-walk options of 'git pack-objects'. If shallow
commits are to be handled differently, then it is by the revision walk
that defines the commit set and which are interesting or uninteresting.

However, before the previous change, a trivial removal of the warning
would cause a failure in t5500-fetch-pack.sh when
GIT_TEST_PACK_PATH_WALK is enabled. The shallow fetch would provide more
objects than we desired, due to some incorrect behavior of the path-walk
API, especially around walking uninteresting objects.

The recently-added tests in t5538-push-shallow.sh help to confirm this
behavior is working with the --path-walk option if
GIT_TEST_PACK_PATH_WALK is enabled. These tests passed previously due to
the --path-walk feature being disabled in the presence of a shallow
clone.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c  |  5 ++---
 t/t5538-push-shallow.sh | 10 +++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index df3cca0a668a..a87546530632 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -210,6 +210,7 @@ static int keep_unreachable, unpack_unreachable, include_tag;
 static timestamp_t unpack_unreachable_expiration;
 static int pack_loose_unreachable;
 static int cruft;
+static int shallow = 0;
 static timestamp_t cruft_expiration;
 static int local;
 static int have_non_local_packs;
@@ -4490,6 +4491,7 @@ static void get_object_list_path_walk(struct rev_info *revs)
 	 * base objects.
 	 */
 	info.prune_all_uninteresting = sparse;
+	info.edge_aggressive = shallow;
 
 	trace2_region_enter("pack-objects", "path-walk", revs->repo);
 	result = walk_objects_by_path(&info);
@@ -4695,7 +4697,6 @@ int cmd_pack_objects(int argc,
 		     struct repository *repo UNUSED)
 {
 	int use_internal_rev_list = 0;
-	int shallow = 0;
 	int all_progress_implied = 0;
 	struct strvec rp = STRVEC_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
@@ -4881,8 +4882,6 @@ int cmd_pack_objects(int argc,
 			option = "--filter";
 		else if (use_delta_islands)
 			option = "--delta-islands";
-		else if (shallow)
-			option = "--shallow";
 
 		if (option) {
 			warning(_("cannot use %s with %s"),
diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index c406f9d7ed5f..dc0e972943a6 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -153,7 +153,15 @@ test_expect_success 'push new commit from shallow clone has good deltas' '
 
 	# If the delta base is found, then this message uses "bytes".
 	# If the delta base is not found, then this message uses "KiB".
-	test_grep "Writing objects: .* bytes" err
+	test_grep "Writing objects: .* bytes" err &&
+
+	git -C deltas commit --amend -m "changed message" &&
+	GIT_TRACE2_EVENT="$(pwd)/config-push.txt" \
+	GIT_PROGRESS_DELAY=0 git -C deltas -c pack.usePathWalk=true \
+		push --progress -f origin deltas 2>err &&
+
+	test_grep "Enumerating objects: 1, done" err &&
+	test_region pack-objects path-walk config-push.txt
 '
 
 test_done
-- 
gitgitgadget
