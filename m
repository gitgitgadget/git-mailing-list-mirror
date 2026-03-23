Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FE3976AF
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774266027; cv=none; b=MXpJqd2TXvC/7N3VfCfxsGN1ipjxIsphay8WdCy3KcY8gTDFSFfHWYX5QnBb090CUTLzb7pIjA0OT27brfeF0eudWsL+BDfz3Ey2Fbav4sJ6DSVn36Qh6zTYUov/b7T5q77Fc6Vzb1SLrBWv63Rn+24cPdb42gZGb6GHLhinA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774266027; c=relaxed/simple;
	bh=2jbqF8ZNR5RlwomFUeDpMktmFImv0BDTgDMI8RvgTcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fdHse2xkwjulQh0157/PMHT7Eg6F7thTUKrL0yg28qQjIvZt0iatFmpfwFx95OtN29bejM5dKB6UkRfqsWQY8ToAsdMbH160fUY5wxinsoh0rLgLTn5d4zVixTN9AuXPbcqjOMFqV8ouTBRX99solSo6iEIJB6/IEfWCue5aNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK6V+mgJ; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK6V+mgJ"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c1092cc08cso415201eec.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774266025; x=1774870825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=LK6V+mgJS+JB/7QwfCsLP2ACRCkEogWf0toyx6jrceRsrIuOrWOXlICHGY2s+asnsS
         0kIcOcbZGRTvXcJtP40Yo6FXcV7ejo5XQQau6L9rHBFfVwJtBIj1aC1mM6GnGbpYJrRs
         Ut6/N3gV5nQ/K7+BBnd24Rvh9C+Bya4/mS6GmVdb/0aOBIA+BmbI/oWcaiBBqWV4kMpx
         fuVYtF5gmQPMMoiFBaEFBGwkbiorw7lPva07Y8SRsSrBlkojr3MrRqON/M4pfz6yE53o
         fmfZNuYk21GWr6gnjxU5AJb2MXOzQicGhvpK1GuEC4tr0OtbwS9IIeH9VhZ9T2RSQD9E
         MtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774266025; x=1774870825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=MdSiMCO90JHauttjoGKS2FmU07kSvG68a2DHlaZbf8RKWbaYI620OksWg+GcumX7B8
         E7d+NIVBbHpR9eYde8SwmJrMi8uSBXRq6CbvQPyfv0iU4TvmCkdgV6PTIIZZPHgUGUCC
         wMXYgBdorM2VKyC2Qyo0vO/9feXdoeTSv+x5cE8dsFKFOTsQKuxq3pyyQkqDpS49hIuo
         QZRNATN5rP74QdAiBwwLdZT/einBw992VPejDdWt5zoWO82BdmM2qRh2X4CNqqU6NHQ5
         r3SF6TaLwBspSJ8F6tcX7w2zFnU9SkjQdiaMPd0BHN+sbfZnQ+dM+gkqYoR2rmacqBzc
         ZsMw==
X-Gm-Message-State: AOJu0YxfRBV7DMy86BfwUQyrsmn2x/yiv98Vq84fNhmdUNYbv5pIMsiI
	x+h2O/zrotN1HB5VVfaVtCvvUVMKs0MKIZkIx2mjK/+OweZ0bsk20K02ehxXFw==
X-Gm-Gg: ATEYQzwEFyd8ShUyDRyvGV5j9zbGXc1vm2np0hZ0HH55492c7lLUkwqc0y0ximd1/c2
	PnpEgcYg5OqOnp2t77h6LJje3He1mNOork3vmW5vt3sZ5Svp+KWG6KsfEYLQJX+BeXDeRsjgkQd
	YHLu4HvT7g3C4MutUDK8WDokvImKk5/Kh+sxg0RaoBBS+IDpZR4X61ieD9Yy+c0q9b8b8ec3UUD
	AiHCFphZxAG48n6CxUyl2ate2zjzFxtTIz1SOKBsiD0ibckNktwI2n4y54kAFrzUKRCTh7ld7K7
	/9YsuTXnlGMEuU5Kq9hZR2js2xtGmeHiqt2yUQhshTYn6Mhr7GmrflLOqqN9j8ceVEdBiMVp510
	0NiAFf+gGeuAVl20nIMKSoYLlOizRx4hXb9Og1+x+q07//X40SnumKvea9/VFeUotHPVqkEx8aR
	TnOCFvI5QuBNeIzRTaUBs/7mK27DE=
X-Received: by 2002:a05:7300:8ca6:b0:2c1:778:d897 with SMTP id 5a478bee46e88-2c109752f8dmr5548991eec.21.1774266025000;
        Mon, 23 Mar 2026 04:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14bac4sm15843840eec.4.2026.03.23.04.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 04:40:24 -0700 (PDT)
Message-Id: <55a45b2fc81895d2b712f126f716a8152d73fc93.1774266019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
	<pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Mar 2026 11:40:15 +0000
Subject: [PATCH v2 2/6] t5620: prepare branched repo for revision tests
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Prepare the test infrastructure for upcoming changes that teach 'git
backfill' to accept revision arguments and pathspecs.

Add test_tick before each commit in the setup loop so that commit dates
are deterministic. This enables reliable testing with '--since'.

Rename the 'd/e/' directory to 'd/f/' so that the prefix 'd/f' is
ambiguous with the files 'd/file.*.txt'. This exercises the subtlety
in prefix pathspec matching that will be added in a later commit.

Create a branched version of the test repository (src-revs) with:
 - A 'side' branch merged into main, adding s/file.{1,2}.txt with
   two versions (4 new blobs, 52 total from main HEAD).
 - An unmerged 'other' branch adding o/file.{1,2}.txt (2 more blobs,
   54 total reachable from --all).

This structure makes --all, --first-parent, and --since produce
meaningfully different results when used with 'git backfill'.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5620-backfill.sh | 52 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 58c81556e7..1331949be4 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup repo for object creation' '
 	git init src &&
 
 	mkdir -p src/a/b/c &&
-	mkdir -p src/d/e &&
+	mkdir -p src/d/f &&
 
 	for i in 1 2
 	do
@@ -26,8 +26,9 @@ test_expect_success 'setup repo for object creation' '
 			echo "Version $i of file a/b/$n" > src/a/b/file.$n.txt &&
 			echo "Version $i of file a/b/c/$n" > src/a/b/c/file.$n.txt &&
 			echo "Version $i of file d/$n" > src/d/file.$n.txt &&
-			echo "Version $i of file d/e/$n" > src/d/e/file.$n.txt &&
+			echo "Version $i of file d/f/$n" > src/d/f/file.$n.txt &&
 			git -C src add . &&
+			test_tick &&
 			git -C src commit -m "Iteration $n" || return 1
 		done
 	done
@@ -41,6 +42,53 @@ test_expect_success 'setup bare clone for server' '
 	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
 '
 
+# Create a version of the repo with branches for testing revision
+# arguments like --all, --first-parent, and --since.
+#
+# main: 8 commits (linear) + merge of side branch
+#   48 original blobs + 4 side blobs = 52 blobs from main HEAD
+# side: 2 commits adding s/file.{1,2}.txt (v1, v2), merged into main
+# other: 1 commit adding o/file.{1,2}.txt (not merged)
+#   54 total blobs reachable from --all
+test_expect_success 'setup branched repo for revision tests' '
+	git clone src src-revs &&
+
+	# Side branch from tip of main with unique files
+	git -C src-revs checkout -b side HEAD &&
+	mkdir -p src-revs/s &&
+	echo "Side version 1 of file 1" >src-revs/s/file.1.txt &&
+	echo "Side version 1 of file 2" >src-revs/s/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Side commit 1" &&
+
+	echo "Side version 2 of file 1" >src-revs/s/file.1.txt &&
+	echo "Side version 2 of file 2" >src-revs/s/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Side commit 2" &&
+
+	# Merge side into main
+	git -C src-revs checkout main &&
+	test_tick &&
+	git -C src-revs merge side --no-ff -m "Merge side branch" &&
+
+	# Other branch (not merged) for --all testing
+	git -C src-revs checkout -b other main~1 &&
+	mkdir -p src-revs/o &&
+	echo "Other content 1" >src-revs/o/file.1.txt &&
+	echo "Other content 2" >src-revs/o/file.2.txt &&
+	test_tick &&
+	git -C src-revs add . &&
+	git -C src-revs commit -m "Other commit" &&
+
+	git -C src-revs checkout main &&
+
+	git clone --bare "file://$(pwd)/src-revs" srv-revs.bare &&
+	git -C srv-revs.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv-revs.bare config --local uploadpack.allowanysha1inwant 1
+'
+
 # do basic partial clone from "srv.bare"
 test_expect_success 'do partial clone 1, backfill gets all objects' '
 	git clone --no-checkout --filter=blob:none	\
-- 
gitgitgadget

