Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9D3C942E
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684461; cv=none; b=YCtfyTOarUUulen3dT0OG8Q+LmhVHEpesqOLiR7HR4eOUigS6dB+86Mz1H+Dxx4JlsAdtC9BKa3ByrsaCu9N2dxNEEoT23HK2wW1HJZ3aZceom9Cf3v6aCsF0sXghGGmpEmlMeTwxwx8xTDXWV83vsA5w6+HKhiQgXUOkk9jS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684461; c=relaxed/simple;
	bh=V/blUPsU/FGmBxxqg20D7H6NZp2IsP3qN6i4aGITe30=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jJFdPiMcbAfcU2S58vT9CQLwXKAGaEZxlYKA32k+hG0dSwi9a+OSWnYlCVCW15Zs0kbcmjE/GZbeUt7Olqo5gj4ZHQQkh/UAROGQ1f2BjmxFn9KuoZ97p0cS97RcsAm9xzn9Yl4JZpL28xyBm6G7H5f2KjP27GEjUsrRiqSOc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n3My2mvZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3My2mvZ"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so1398176d6.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787684432; x=1788289232; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z1Gvi27EBY7jxIjXW77iMlUlNbLtCav43HZLeeP32Mg=;
        b=n3My2mvZSj4yxfZhqoLoYg5kMzoGcsyYMZfwUqoM92Hez8A6STguzJp2sOQYLhLmuK
         reenwcckAQE8MWShSCkhWJzWRBioppmvMkPe0bv21klkt8v2BMm6419p4TM88pg2eTSn
         GPUExhciP4VAGUH42hgMjn3VSK1HWUp5dGEOqXBxBXxiCyUhQGreGaHsyYycUAL9B+nS
         phYU8YhcntNw9+o8BzFmqXP3DhSrYAXkiHRgWbPd63qGskLqRyOMFg3YTNXSQ4bVwHor
         mjtD36MWcv7BbDlFp6u5EU/6JkEW1gts/XUqPp0vbVIdFUq/1Y7mpGuVwkhDD0lXcBHW
         MH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684432; x=1788289232;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Gvi27EBY7jxIjXW77iMlUlNbLtCav43HZLeeP32Mg=;
        b=dsG2prF/e+LLtsVxYUXDBJvpsZJFo7ho/ZqWAgMoRwejKDWpxVhI2JtYOTyXpnebjx
         /rwX+huTjKKfBT4xS/EClWz7NBNQTY4SugUORACrMAwbulFi4Qd+DRVeute9VGD40OTQ
         j9JOK7XMcKuavIt9EurJS+VpTumL66Y6VZO7jkpZB6WmyivxuRhdVQ6z5DAValE5WyFo
         7kUUgtK/VjwrKzLDXsw0sgm8L6hp2rQ+wmzVtoKnXENH6If+aYbxtjAjWHvOGzawkwSe
         KRSxYI90PPZDtWr44r4+GkXP+8CgqeH1ftZq9v78l9U6iROKnmnMJBZQdvHnu8chuEXQ
         HnFA==
X-Gm-Message-State: AFuF++ndvM4g8ntv0QxrncGJRDp49wFw/LrvqcLLsIg2MuQYRAI0MkXk
	EjjWv3Ffgyf1xiKhdanG8AEOsUsA5lWrx6MrIiH1MrLvwpTlAgSp+JwpvOHO8MY+
X-Gm-Gg: AR+sD13YX7wtwieMTa6oooRQb90BQ9vhSr743ZUZ4eBaNXcolXMLc3xCWF+TrbBMDvR
	yyPsNbWl/8I6WNplMODQTFaYOAfchTT8UNnQs7yWE8fHs8uE4fm3dy2y53IqANbvSnbE51GmNgB
	aCNsLHuRl2WgalOzxcH8g9l4YrsYy4pYoXEZ5wG+3iUgg3Xwp2vsEuC2mytUoCM3vvffqtrFuN0
	3tWuY5i4l8zAX+hGJ9/Cn4YjjEdRXLQC3WjUYEMm1RfrZaq3TFLOWiC4O20SjHBT6cwR90qGL9C
	o3t6haS80qvWQmz1OjwTUdkVyGLV0y2vn8w5xDY9F8Q29hdicoQ/JtVj24AN3ZtrKG4FpZimMhn
	lxMvX4388owe/RwPBn6UTx09oHEBeK5kjC4k2ZdBg5lvNpp5ToAKgfUwcXq9DiBCNHKDO+WBa1n
	iKPJyM5gu1IUKB+yuHwfetj4paY7cMjDfdH3sJ8m+/57bBoHlU0q0Cxkxftt2qtHlR
X-Received: by 2002:a05:6214:3988:b0:8fd:d5a7:f970 with SMTP id 6a1803df08f44-90cc787af1amr10202256d6.11.1787684432358;
        Tue, 25 Aug 2026 12:00:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.245.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc6415888sm5645316d6.19.2026.08.25.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 12:00:31 -0700 (PDT)
Message-Id: <36bf2ce17be1a4da1ba92d5eb89ce49c7e00be9d.1787684429.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v2.git.1787684429.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 19:00:26 +0000
Subject: [PATCH v2 1/4] replay: fail gracefully when a merge input is
 unreadable
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
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When objects involved in the merge cannot be read, the merge machinery
will return early with result.clean = -1, and result.tree left as NULL.
pick_regular_commit() tested only "if (!result->clean)", ignoring the
case where "clean < 0".  That causes the code to try to use
result->tree, resulting in a SIGSEGV.

Handle clean < 0 explicitly; the merge machinery will already have printed
messages such as "Could not read <object>" and "collecting merge info
failed for trees...", so we don't need to add much detail beyond the
fact that the merge failed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 replay.c                 |  7 +++++++
 t/t3650-replay-basics.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/replay.c b/replay.c
index 463c900d6c..33e21b2032 100644
--- a/replay.c
+++ b/replay.c
@@ -327,6 +327,13 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	merge_opt->ancestor = NULL;
 	merge_opt->branch2 = NULL;
 
+	if (result->clean < 0) {
+		error(_("merge of %s onto %s failed"),
+		      oid_to_hex(&pickme->object.oid),
+		      oid_to_hex(&replayed_base->object.oid));
+		return NULL;
+	}
+
 	if (!result->clean)
 		return NULL;
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 3353bc4a4d..12348b4a5f 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -565,4 +565,38 @@ test_expect_success '--onto with --ref rejects multiple revision ranges' '
 	test_grep "cannot be used with multiple revision ranges" err
 '
 
+test_expect_success 'replay fails without segfault when objects are missing' '
+	test_when_finished "rm -fr unreadable" &&
+	git init unreadable &&
+	(
+		cd unreadable &&
+
+		test_write_lines l1 l2 l3 l4 l5 l6 l7 l8 >f &&
+		git add f &&
+		git commit -m base &&
+		git branch base &&
+
+		test_write_lines l1 l2 l3 l4 l5 l6 l7 CHANGED >f &&
+		git commit -am side &&
+		git branch side &&
+
+		git switch -c onto base &&
+		test_write_lines CHANGED l2 l3 l4 l5 l6 l7 l8 >f &&
+		git commit -am onto &&
+
+		# The replay works while every object is readable.
+		git replay --onto onto base..side &&
+
+		# Removing the onto tree makes parse_tree() fail during the
+		# incore merge, driving clean < 0 with a NULL result tree.
+		onto_tree=$(git rev-parse onto^{tree}) &&
+		obj=$(test_oid_to_path "$onto_tree") &&
+		mv .git/objects/${obj} saved-tree &&
+
+		# Ensure replay gracefully handles the missing object
+		test_must_fail git replay --onto onto base..side 2>err &&
+		test_grep -e "Could not read" -e "collecting merge info failed" err
+	)
+'
+
 test_done
-- 
gitgitgadget

