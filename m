Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9AD401A1A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538101; cv=none; b=ourdfjee6g8c+ZUUco3/2LZXETrlFPRF/wRykYQmpu/GE3ifz3iMWjBLRU4qt70wMDzfz703B1ZQV1SojcVfawMgfQn4fQS3RXex5SRM9QtbvEHq0/4xkc/FN1V+x8cwXcJP3GFL1n2kzbLCjlG4Jl+Z0UR8DNpPuDhoArkqxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538101; c=relaxed/simple;
	bh=2jbqF8ZNR5RlwomFUeDpMktmFImv0BDTgDMI8RvgTcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I9x4IoSXUSscvvQ4b6p3CQXGj2ZS+6xCZcIoXSt3oHF7Q2Br8eyraimKPF0N0YIOEqBcYmdtucGpJPyFsvUfALMkt6ZQq4sLofpkQXOoMrP/aoi0K98Bm5z4FEKpiWZ5mYZxsnwMv+jmtleeVxqgaU2aEhU2PkYyYeTVCaLzY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9Aj1pOz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9Aj1pOz"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc1aced74so182161985a.2
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538098; x=1775142898; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=O9Aj1pOzp6YRHv26B2UcEVAmMT/Fq3Ievi8gA+QZFZaNyiS1HWbV/mi8wafdl2V02H
         7FiJuub555Je+Mv2XIprE24avPcwQOdv9sc04RHWRd4IBBmqLhITPEGsNZPe5542w8Nm
         59TXkf7JVxM3uje7zrGz9UmUrATl7hMrKT7DaGOaL2AqAjG7gXi/eJVHasFV4wLjShC6
         oW2IQ6NWJP8Yjg3ffP/pQ5Sh+VzXLCBvdZVeXTFeYHyAq2qFk2IHDki3Zbj9ZdFjr8+4
         0QLNKb0hrp4R/5R9tZK6v0XGOdUS8vNuHI6fidrGYEcIqsKPVnLS6FY3brl2AUwdMdfY
         5l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538098; x=1775142898;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSO2EfFjgUUq2OxrqJqOBJYCMqN8qTa5wF2tm+02jFM=;
        b=DFcGeOJGp3fe6BJpC4j+3fChHIp38KbsGDNiLcwdTGkJPLtKyX9Mall6Jq0duvSIb+
         /GU/DvLkzDFLrizxr8SwAKtAahcvwrTOO61ZUJLhUImOYtb/cxVGRRDM8Iae9tXISSeE
         nYNGg5OoPxdqUw/TMxIWMFc150k6gjp5Y6teYst8xXP12GWQ77xkQxE9Y6v04VH55FGu
         QnDtFBpzGljDJW3WHbuhOsT7fMoITwUBYpcr9HOKIhzU6KT1BX+ISbhiWIYVyGXQsMk6
         rzAPQ0foxsDJ+PZ0B87Idc2Xhsx0iX+cUBBXtBuAqMu0FeRH4ZwmMs88a/wqZWR40vtu
         U4Fg==
X-Gm-Message-State: AOJu0YyiDP9sIWMDs4TOmN4vlLQtEVyQgaya2UXhPGhB3SBzK9QwI1Wv
	xl4M+Q5ntKAneKSZfY7Yatz9gDy8cDzdTsyABNrKQC2J/vmCLGl+UGHdieuY1A==
X-Gm-Gg: ATEYQzwb1QxTFqSS5yl/kEADgsUDbdQnC9S/t9K5Z/9SORFN98IjpHJ89nskoRA0j9/
	YdssmFEkBzvgzrgmj4GebUZXmCtFiSWMqm5zJCnUUD9Sb4lhgXJsFPDGpn4N2nn/alL6liImPbE
	wsIAqxRLNhgxWJQXN780ZmuoI0Uhy9efZkbMPaqF0FNeuUMFItHxn1NiMO14rNdzMW1YdunZ/wJ
	/vPLKfJ/kF+q0N6j2jlYzpCEQEUQMCM77RKmTJfMCS4NkoFSfV9KhYjXJGN6ukmrwQ3wqmyvvNp
	cPvNo+Rxvy8hAP8JdEHtf4Sv3bh0cgFpr/CiQtd5XCiDGilCoMMtEiq7xlJs6UATURGFZLpF1L/
	3HuA8acLbyrcmReimQqWt7ntkeRlg3vs/IK3X1feQRBroptby2NdBLRO7tmeYKBvfsKu6uzDwh6
	jduwGpDFrXj4w1v7l4bD0a1bsv/A==
X-Received: by 2002:a05:620a:460c:b0:8cf:dd63:fae7 with SMTP id af79cd13be357-8d0010126c5mr1028958485a.34.1774538098231;
        Thu, 26 Mar 2026 08:14:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3c993csm256759185a.16.2026.03.26.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:14:57 -0700 (PDT)
Message-Id: <55a45b2fc81895d2b712f126f716a8152d73fc93.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:50 +0000
Subject: [PATCH v3 2/6] t5620: prepare branched repo for revision tests
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

