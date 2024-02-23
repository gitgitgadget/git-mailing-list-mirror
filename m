Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F5B1A731
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677272; cv=none; b=lDRTaJQQdpMyHyr4M2ctvldHChpJpvTI6bOShKKNFjnr/moR6qHwujKH+5xhJK1JwUmf0dNJkUd2K5A0MklFJol1iwt1PF6Rankmz2ZsI5X1/v3mQwX9BZlyaRFNAnDxgcjnlJqc3qglnm/oymZrvRiZ9a15YbHl+4nD5aTJfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677272; c=relaxed/simple;
	bh=CWSOJRx5fGiD+VWfre6qxlFaVX4Agto1Xz0sb8/ndRc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Loa4ibhUJH03brz4mdrOD3UPaXvKzG5R7Z9RrnshQ50k1yz/G6xdIa8gWHPnZeLxi1elgW1ewQupcvogSOU9ilJWUXvIweBkf3E7bB+tCxfGwPKNeMSnw08/IEnArUZUSIFsotRhzvmxpRCr8Z2CHBPEPgFF05bTEKv1Tkt8oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVVBrnkA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVVBrnkA"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5129e5b8cecso797074e87.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2024 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708677268; x=1709282068; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwYeaUigHoLqe07Dyr7OAsD6q6DCJT125jNN3V4+eZs=;
        b=OVVBrnkAAAo/U95xA6zDfZu3P1sQzU8fxTl0ziHM75vD0pZMNYP/pq2mCi2W5C4AAB
         badcQC9FVipal0vdc9SCyAHcgrzifGqGDOU/iLT6ktlGzO071XveZ/nfXRoV/6klQe2j
         fJo9/NYLzqATgq9w0utsHLR7drLhoHUOJpnFqktxV36GIk2EZRoiq3JiVKWDyYn9dl2V
         gChRAqnvq6LMafVH2myIwgAhw7dx6KgefKF6uQhq5KN0snT7ohdJ2Nm+FJH3gqBpZfbE
         6nGrnmyRZGRdLSdVoaOWqClSesVqdgsshMwZ+D1L8gN1BFa2/JleeRLzcD0P+C+K2f8w
         kXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708677268; x=1709282068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwYeaUigHoLqe07Dyr7OAsD6q6DCJT125jNN3V4+eZs=;
        b=YM7VFXrxM+vM3xgLLgG4iUFbin3YdnDSvU+ii8u6ojDmWqmzvQIZLGHjCc5NWLiGMR
         tQXUqcbDelbZsMBW1UiEsS8ISdDugIq1mLkMJFA+4rJXWt7/ptGGTlF7RLLAbV+6aB+s
         Enf8cfOq1Y3M/p8pY7oQEa410mKYjNoqZJuo0N3Fbrpn+dX1t/6ULeMQlZMTKvUnMoAx
         ZSaBhVtZ618Vv/q60GwGZ9kSTA/pzh7qLt17gb53w/FHHYyf8zVZvz0tjAbLYmei+aB7
         sHQTtzpG/4KoeLfOI/Rv0jePuPOR6w2dRNva8STWTZbveZD4cQmK1Fw3Db2q2mg1ENjG
         qz0g==
X-Gm-Message-State: AOJu0Yw69cjih03ENjrVlGINS/ZQY2+JiIqlojSpinWRA88tS1WPJEYX
	K20kw28dS0wbURxcIA9ib+asvSiieoFeEoQcWqdaQnc37FFduN/O+ooHXEar
X-Google-Smtp-Source: AGHT+IF2cQIE/VnSn3dLFpAQ6CDTt6kIVHlk+P6V+6Dl230/oczMgdx+ZeJ1uGwDTyLShRkO5ntTaQ==
X-Received: by 2002:a19:691d:0:b0:512:a2c7:e44c with SMTP id e29-20020a19691d000000b00512a2c7e44cmr741422lfc.20.1708677268176;
        Fri, 23 Feb 2024 00:34:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600c3d0900b00412945d2051sm1185185wmb.12.2024.02.23.00.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:34:27 -0800 (PST)
Message-ID: <11b9cd8c5da5e6792ce940ea29d2e93e57731555.1708677266.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
References: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
	<pull.1651.v4.git.1708677266.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 08:34:20 +0000
Subject: [PATCH v4 1/6] merge-tree: fail with a non-zero exit code on missing
 tree objects
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `git merge-tree` encounters a missing tree object, it should error
out and not continue quietly as if nothing had happened.

However, as of time of writing, `git merge-tree` _does_ continue, and
then offers the empty tree as result.

Let's fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c                      |  7 ++++---
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6491070d965..c37fc035f13 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1659,9 +1659,10 @@ static int collect_merge_info(struct merge_options *opt,
 	info.data = opt;
 	info.show_all_errors = 1;
 
-	parse_tree(merge_base);
-	parse_tree(side1);
-	parse_tree(side2);
+	if (parse_tree(merge_base) < 0 ||
+	    parse_tree(side1) < 0 ||
+	    parse_tree(side2) < 0)
+		return -1;
 	init_tree_desc(t + 0, merge_base->buffer, merge_base->size);
 	init_tree_desc(t + 1, side1->buffer, side1->size);
 	init_tree_desc(t + 2, side2->buffer, side2->size);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 7d0fa74da74..908c9b540c8 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -951,4 +951,15 @@ test_expect_success '--merge-base with tree OIDs' '
 	test_cmp with-commits with-trees
 '
 
+test_expect_success 'error out on missing tree objects' '
+	git init --bare missing-tree.git &&
+	git rev-list side3 >list &&
+	git rev-parse side3^: >>list &&
+	git pack-objects missing-tree.git/objects/pack/side3-tree-is-missing <list &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-tree.git merge-tree $side3^ $side3 >actual 2>err &&
+	test_grep "Could not read $(git rev-parse $side3:)" err &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

