Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A0225768
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890563; cv=none; b=HbkPGdL2wnmZxZzKq/1k4IMLowvvAR3sLPma0AMfaPAX8ZRRV5X99Q0Jgui/h7Hj0+j02eF3r9PNchfdhl3yLS5BhflkNqaL2mq8qW8xamVEaiAU7O58aKUBAxZK5ghp7QJlTrXMvQRWSmWTR/Gz+QSEWYOS9I4E/qoI2J2XZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890563; c=relaxed/simple;
	bh=gI+98YUuukIVltXYPCUOqNLnfdKZwFxJ12aXa364/Z4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cfrAWqntXrzNs/YIAeRRFZwLsP6ff3rRN8ycWQsfsYQjO9iNaHbPGW0zfNB4chz4hV7ym+95jtPlZsfrW1m5naI0BqicNpd0AIAGoBfdsHPc6R0/hjP/eBYDxD1a0wJ8y+hbV23WhiWUlz3bxuEv33uxdP1yWMN6eRbsNHKx8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i43PMgIJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i43PMgIJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so2898045e9.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748890559; x=1749495359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0qtGfYX9eINUBeuxPoRGVJ3WzzBIUVYLCSB5jMbW+Q=;
        b=i43PMgIJF2kf6u32zdkN2hEkFEqJHsqVtvw4gFoUp/P1t+1qTHy8cnL6MFVzDf/90l
         j2NR/E8M4+J/GHMgn3rlEPkZ1HWduta6vX1YvRs5djqYDSJ1soOPKk1+Y7tvlg2qXQ42
         wrXrB5V5AMWZoK9Wsz75GK7/Uexsn6+h/cSD82Rv9SwDqT8pm6NWZr5zxJk1EKIKK4LE
         fyF20iXPPfkB1eSj98LNFuI+RKmALQ1a1TntqFV7psqqSXpcay9MUonBPjBI+jm/HLld
         afSX/LE9VWVl30m745fIorKbD2vq8Kb38zQB6q8/RNO6XipwTH1Pqh1DepBbxzFvccON
         Mm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748890559; x=1749495359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0qtGfYX9eINUBeuxPoRGVJ3WzzBIUVYLCSB5jMbW+Q=;
        b=NXk05FMf/CtGY+XVyyzPpggCL3SlW+Rg2/HeP2bHdBKCvPyVxMH7/BqLer6zeVnkds
         WCEauvyqVzbaFHMsUTX2mf9IdyctQ2hpf0kGWjXjGtn+LMylFYs7KWhC9td1J9D+ypPp
         +iNewcBztkUdf/h4xbJQ0z8hM9q3Rs/exahiFHV7/hBvdfFvKb54ehwzMNRqAewAZDDY
         1P1WVdYSrzQsayej8v3kiY7P1lOxvV3MIziMNU3bY3nkO67EsOPVln5SXGb1u/HTYNH7
         Yqta6QkqlJ0nB93UmfHk4LP0RALjg7lhqeJswGYpRWwRi9KTwIcHFW0JET3vDOn7b7Py
         NTEQ==
X-Gm-Message-State: AOJu0Yw9YBg2AuHn51pV7l6RKfnjNhSpud16f/MCuzZoKvz9vIIexeE6
	XefSw74NQgzMActuesjR2K8xjs2pQp5QtIHeLk5ehFaiwnXnd9tgqZAoiMYVwQ==
X-Gm-Gg: ASbGncsdO8BZAWTs4PIaN8M8KJRupRpaoE03qQ7iIK9eOQQ7hn9tpMkGbQSFZKBG1PA
	6JoySeTCMvknGnHNU40Vl9o0oA6fI9qR+r6Kkyjy8IF2dn8LZTYhhRO6eKK5Zbldf9xbOP83aGs
	Th+EfcA+gm8jOGNfVzo6zDZTTnBkKCbbEaXSHzJ1yAvby4O9wEqFnoLVermFbJQ36kD5fof8yDB
	/StyoFqiRdr2kcS0xafkigUYs5DqF34DHkK5A3wv5DicSoss1ST4EOe0tqxqwFbKOulHOTimJxI
	12oW09A/Zmp/EeEw7lphAE/gKTtJvBYG1fZy9/p5FxM8uMf9e09u
X-Google-Smtp-Source: AGHT+IHUQHsJzFY2+WxBs3PTT7ze5azEm9iWFBycUzVVvdWyoEenHFFep3zxU322JaYZsSX1rGUS8w==
X-Received: by 2002:a05:600c:8b0d:b0:442:f4a3:a2c0 with SMTP id 5b1f17b1804b1-451e397d9bcmr4968995e9.13.1748890559066;
        Mon, 02 Jun 2025 11:55:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73ee0sm15697552f8f.46.2025.06.02.11.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 11:55:58 -0700 (PDT)
Message-Id: <980ab7f7ef56944df78530dcc9c79b54d1450806.1748890555.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 18:55:55 +0000
Subject: [PATCH 3/3] cat-file.c: add batch handling for submodules
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
Cc: peff@peff.net,
    gitster@pobox.com,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

When an object specification is passed to 'cat-file --batch[-check]'
referring to a submodule (e.g. 'HEAD:path/to/my/submodule'), the current
behavior of the command is to print the "missing" error message. However, it
is often valuable for callers to distinguish between paths that are actually
missing and "the submodule tree entry exists, but the object does not exist
in the repository".

To disambiguate without needing to invoke a separate Git process (e.g.
'ls-tree'), print the message "<oid> submodule" for such objects instead of
"<object> missing". In addition to the change from "missing" to "submodule",
the new message differs from the old in that it always prints the resolved
tree entry's OID, rather than the input object specification.

Note that this implementation maintains a distinction between submodules
where the commit OID is not present in the repo, and submodules where the
commit OID *is* present; the former will now print "<object> submodule", but
the latter will still print the full object content.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/git-cat-file.adoc |  8 ++++++++
 builtin/cat-file.c              |  5 ++++-
 t/t1006-cat-file.sh             | 25 +++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.adoc b/Documentation/git-cat-file.adoc
index 5c002c0499e4..180d1ad363fd 100644
--- a/Documentation/git-cat-file.adoc
+++ b/Documentation/git-cat-file.adoc
@@ -373,6 +373,14 @@ If a name is specified that might refer to more than one object (an ambiguous sh
 <object> SP ambiguous LF
 ------------
 
+If a name is specified that refers to a submodule entry in a tree and the
+target object does not exist in the repository, then `cat-file` will ignore
+any custom format and print (with the object ID of the submodule):
+
+------------
+<oid> SP submodule LF
+------------
+
 If `--follow-symlinks` is used, and a symlink in the repository points
 outside the repository, then `cat-file` will ignore any custom format
 and print:
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b11576756bcc..4b23fcecbd8e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -496,7 +496,10 @@ static void batch_object_write(const char *obj_name,
 						       &data->oid, &data->info,
 						       OBJECT_INFO_LOOKUP_REPLACE);
 		if (ret < 0) {
-			report_object_status(opt, obj_name, &data->oid, "missing");
+			if (data->mode == S_IFGITLINK)
+				report_object_status(opt, oid_to_hex(&data->oid), &data->oid, "submodule");
+			else
+				report_object_status(opt, obj_name, &data->oid, "missing");
 			return;
 		}
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 97052b3f31f1..f123ef1e360a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1220,6 +1220,31 @@ test_expect_success 'cat-file --batch-check respects replace objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'batch-check with a submodule' '
+	# FIXME: this call to mktree is incompatible with compatObjectFormat
+	# because the submodule OID cannot be mapped to the compat hash algo.
+	test_unconfig extensions.compatobjectformat &&
+	printf "160000 commit $(test_oid deadbeef)\tsub\n" >tree-with-sub &&
+	tree=$(git mktree <tree-with-sub) &&
+	test_config extensions.compatobjectformat $test_compat_hash_algo &&
+
+	git cat-file --batch-check >actual <<-EOF &&
+	$tree:sub
+	EOF
+	printf "$(test_oid deadbeef) submodule\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'batch-check with a submodule, object exists' '
+	printf "160000 commit $commit_oid\tsub\n" >tree-with-sub &&
+	tree=$(git mktree <tree-with-sub) &&
+	git cat-file --batch-check >actual <<-EOF &&
+	$tree:sub
+	EOF
+	printf "$commit_oid commit $commit_size\n" >expect &&
+	test_cmp expect actual
+'
+
 # Pull the entry for object with oid "$1" out of the output of
 # "cat-file --batch", including its object content (which requires
 # parsing and reading a set amount of bytes, hence perl).
-- 
gitgitgadget
