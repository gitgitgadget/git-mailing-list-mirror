Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B747AF63
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523198; cv=none; b=gizvQe3BLnCUp0Hb6Uiu5PHE0EFDWYfikRTLnzdhvxyG3Sn2Ij8S3FHWYMC80qpufWFJMRutY/lD9OA+wmdD/71W+7eiAsE+HjWWbmjJJkjH04WxzekxZ5EjFtRclGZdM37PZdZ8wfDlv046JBVcnIrFYnuPgoGIps8SZcGd6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523198; c=relaxed/simple;
	bh=nTXHQwu3QLdizBTHrK+ybPNNKM0SMygDXKITerB35K0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jQeHQ3UAJtnqRaVY0ANOZVDIN6WLyqmBO2xjY3e/w5i988AEVoIYfNzgIKl5FZRhwcMt0xMCb4oMGWw1Xf54fOpCy6tq49xUK8kGfli/sQ0HXRuU5ae9CFEX2bQEffgVSQMv75Cwt6WNYzY/LlZzRRpbg3bnz48471nYOHbNqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktz7b4Aq; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktz7b4Aq"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb856a674so58074806d6.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523195; x=1779127995; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=ktz7b4Aqah+0T9eCG5M7w2BY/CbuS8J/QjToo5Ga8dpft+2jUw85uqmSeLgMHbxswe
         hwS5BOW3mAjgeozsIkLVQ/jr89TG8SmImhvLQHMiQiEUhaMUP1KXMqneWyAtbfiVcNWa
         p9ShIf/gmm78lcCxi1ODezHYd3nHlH4F61Zjb0/kwu/vS17aElEjShe2rl4G+0Kkb17S
         Hy931W+il/b7MS3taHMuXVaA2+mypaSkm7l1DpMmHlwj6gSAIujffZWt65Y7bA0gdzUV
         +wYNl7GEVTSaANSz67BtS7gec5BQ7oz10II2KKzCAzNXCOZRaIyzCeh9ND44KixWBgA5
         xZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523195; x=1779127995;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2Yqv+t7tlgZOJN6JK/l54MNrO5W1gi7r91xfTta6PM=;
        b=sG2E6eXphRSpYH9C9NI5H4WT9rhQs764Aop+0/XvMPhgDjCnwIG4nMQwTAajs36akh
         qZdj8eIf/MXnPRaQFMeLq+NUVWAmDr3PdEaJLWv389clV6eGd4K7nVP27E6t1KKoN3AO
         S0ChkaLrUJa61aeOZzAmYXWYQhjyvqX5f49zZoSov4jxnAU8naP1lLjFwJXSLisbGfki
         L0x3JPmqLlnDCVizT3riU5XZ3JtwS56zMA7Q0qmk8ZqH/nJyx9YzNC5qA2frxztcT0Nk
         3asmmua36fkqpk8oOtcrSPv5EYXZhKfYPe500tpZza93TM4dhYaa0OSd+6OojGohZ4O7
         3ceQ==
X-Gm-Message-State: AOJu0YzR9V4uCwLIWC+eqK3U/yKiIYN8bFTfepFdqn2KoH9hAn7hN6/8
	b1Zn8l47NxO9CahQKfqggy3sqrCH/jPmklRdHfIC2JMd8PJVkfKhw/73sVRiSQ==
X-Gm-Gg: Acq92OEP303pESmlz+ZZXuyMSXu0G/1aFISL7oUicuhxFTND9e+MlibVHTrjm0WNjGN
	wwlQFSnjKKfhc90wLkhxkFoioDXGWKf+4lnhnsB+1Nd3Cnnrhrn/I0j7VkxQp5y35E2G02vF3ZB
	mRaabdx529OhOVxwIU5gTaX3tq+1Z+x6X1Y6GKxy5VxkdyROhzeVZq9Bxvhei1oMXy+wfS/GNNv
	odHD2m9i7R/I6MU8SQ1Vdxuo8/kU/1zz42pt/zRBtWxazbTYGHm6eXV1vhWaHyBO5qxrQ+R3GxG
	k4dCrGpAk5tcSDHDK9QdcUdBx17T/VmGW7HZn2JUtITwVDOz+vPgbu4z8J8oY3xJbvvq/+1XGZq
	VzqIm/1OpJJ+RLny4VrPm6PDMyRtAkazvqRate0mz6uLIUQJaV5KQc0g1kI+i0uU2+pGGZTjJKp
	Cbv/Yb7f/gyjcaEminwL5rZn/qOQ==
X-Received: by 2002:a05:6214:4709:b0:8b1:f2e9:2996 with SMTP id 6a1803df08f44-8c633567bb2mr5470396d6.15.1778523195129;
        Mon, 11 May 2026 11:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c7e4d4sm100345596d6.26.2026.05.11.11.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:14 -0700 (PDT)
Message-Id: <77329cf8f45b948f3986d004be72035c75ce40da.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:00 +0000
Subject: [PATCH v3 03/12] t/perf: add pack-objects filter and path-walk
 benchmark
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
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Add p5315-pack-objects-filter.sh to measure the performance of
'git pack-objects --revs --all' under different filter and traversal
combinations:

 * no filter (baseline)
 * --filter=blob:none (blobless)
 * --filter=sparse:oid=<oid> (cone-mode sparse)

Each filter scenario is tested both with and without --path-walk,
producing paired measurements that show the impact of the path-walk
traversal for each filter type as we integrate the --path-walk feature
with different --filter options. It currently has no integration so
falls back to the standard revision walk. Thus, there are no significant
differences in the current results other than a full repack (and even
then, the --path-walk feature is not incredibly different for the
default Git repository):

Test                                             HEAD
-----------------------------------------------------
5315.2: repack (no filter)                      27.91
5315.3: repack size (no filter)                250.7M
5315.4: repack (no filter, --path-walk)         34.92
5315.5: repack size (no filter, --path-walk)   220.0M
5315.6: repack (blob:none)                      13.63
5315.7: repack size (blob:none)                137.6M
5315.8: repack (blob:none, --path-walk)         13.48
5315.9: repack size (blob:none, --path-walk)   137.7M
5315.10: repack (sparse:oid)                    72.67
5315.11: repack size (sparse:oid)              187.4M
5315.12: repack (sparse:oid, --path-walk)       72.47
5315.13: repack size (sparse:oid, --path-walk) 187.4M

The sparse filter definition is built automatically by sampling
depth-2 directories from the test repository, making the test work
on any repo passed via GIT_PERF_LARGE_REPO. For repos that lack
depth-2 directories, a single top-level directory is used; for flat
repos, the sparse tests are skipped via prerequisite.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5315-pack-objects-filter.sh | 129 ++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh

diff --git a/t/perf/p5315-pack-objects-filter.sh b/t/perf/p5315-pack-objects-filter.sh
new file mode 100755
index 0000000000..b009039c89
--- /dev/null
+++ b/t/perf/p5315-pack-objects-filter.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+
+test_description='Tests pack-objects performance with filters and --path-walk'
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup filter inputs' '
+	# Sample a few depth-2 directories from the test repo to build
+	# a cone-mode sparse-checkout definition.  The sampling picks
+	# directories at evenly-spaced positions so the choice is stable
+	# and scales to repos of any shape.
+
+	git ls-tree -d --name-only HEAD >top-dirs &&
+	top_nr=$(wc -l <top-dirs) &&
+
+	>depth2-dirs &&
+	while read tdir
+	do
+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null |
+		sed "s|^|$tdir/|" >>depth2-dirs || return 1
+	done <top-dirs &&
+
+	d2_nr=$(wc -l <depth2-dirs) &&
+
+	if test "$d2_nr" -ge 2
+	then
+		# Pick two directories from evenly-spaced positions.
+		first=$(sed -n "1p" depth2-dirs) &&
+		mid=$(sed -n "$((d2_nr / 2 + 1))p" depth2-dirs) &&
+
+		p1=$(dirname "$first") &&
+		p2=$(dirname "$mid") &&
+
+		# Build cone-mode sparse-checkout patterns.
+		{
+			echo "/*" &&
+			echo "!/*/" &&
+			echo "/$p1/" &&
+			echo "!/$p1/*/" &&
+			if test "$p1" != "$p2"
+			then
+				echo "/$p2/" &&
+				echo "!/$p2/*/"
+			fi &&
+			echo "/$first/" &&
+			if test "$first" != "$mid"
+			then
+				echo "/$mid/"
+			fi
+		} >sparse-patterns &&
+
+		git hash-object -w sparse-patterns >sparse-oid &&
+		echo "Sparse cone: $first $mid" &&
+		cat sparse-patterns &&
+		test_set_prereq SPARSE_OID
+	elif test "$top_nr" -ge 1
+	then
+		# Fallback: use a single top-level directory.
+		first=$(sed -n "1p" top-dirs) &&
+		{
+			echo "/*" &&
+			echo "!/*/" &&
+			echo "/$first/"
+		} >sparse-patterns &&
+
+		git hash-object -w sparse-patterns >sparse-oid &&
+		echo "Sparse cone: $first" &&
+		cat sparse-patterns &&
+		test_set_prereq SPARSE_OID
+	fi
+'
+
+test_perf 'repack (no filter)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all </dev/null >pk
+'
+
+test_size 'repack size (no filter)' '
+	test_file_size pk
+'
+
+test_perf 'repack (no filter, --path-walk)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk </dev/null >pk
+'
+
+test_size 'repack size (no filter, --path-walk)' '
+	test_file_size pk
+'
+
+test_perf 'repack (blob:none)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --filter=blob:none </dev/null >pk
+'
+
+test_size 'repack size (blob:none)' '
+	test_file_size pk
+'
+
+test_perf 'repack (blob:none, --path-walk)' '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk \
+		--filter=blob:none </dev/null >pk
+'
+
+test_size 'repack size (blob:none, --path-walk)' '
+	test_file_size pk
+'
+
+test_perf 'repack (sparse:oid)' \
+	--prereq SPARSE_OID '
+	git pack-objects --stdout --no-reuse-delta --revs --all \
+		--filter=sparse:oid=$(cat sparse-oid) </dev/null >pk
+'
+
+test_size 'repack size (sparse:oid)' \
+	--prereq SPARSE_OID '
+	test_file_size pk
+'
+
+test_perf 'repack (sparse:oid, --path-walk)' \
+	--prereq SPARSE_OID '
+	git pack-objects --stdout --no-reuse-delta --revs --all --path-walk \
+		--filter=sparse:oid=$(cat sparse-oid) </dev/null >pk
+'
+
+test_size 'repack size (sparse:oid, --path-walk)' \
+	--prereq SPARSE_OID '
+	test_file_size pk
+'
+
+test_done
-- 
gitgitgadget

