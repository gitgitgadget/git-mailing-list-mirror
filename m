Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29B372B27
	for <git@vger.kernel.org>; Fri, 22 May 2026 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474286; cv=none; b=trg0zJQid6sE6XTm1+Cv5H3MdHCJZmUFSrVx3egHRmOEQH85lvQR65v/TEwa4QYj6lo/Ac0tEALfjPhzamgOmTUIWufcFY4ed9pM40dNuMoGjJWmvfbBBisxkWJneffC/Z23G4ZLFsAWWrAuQq/C6kxZLcceEihCdBPiAu+VM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474286; c=relaxed/simple;
	bh=LeFyMe1118DgmUpEzzW0gHeKJ1oDj3ht5PPWWKvxZs8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u42VmlF4W7cUZ58xN8eD0lHT/CDVPKKOsirneZushhkkU9LpsbeKhR1zTP0RpW+EFQGQIJOh2XdFA/i0kyU4dlq8OpMN7/iX7dpjfBL6JN3jyhojhRpyh5Dbz3sEHW0sRPlmdyNt+XKWL1OPBx6nWVmv6L04JsnTdCLbASESCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9KJEoFT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9KJEoFT"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e63771eb0so75706501cf.3
        for <git@vger.kernel.org>; Fri, 22 May 2026 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779474282; x=1780079082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHxQNnJxu4IDUH4opT2oLg+oXtRGUHkxZKbc6hRI9/4=;
        b=d9KJEoFTBK0YWO7peWKu+12yjTeR8vucrU7dadlX9Lp2A157/aVOXtmRYjEj5IX5Hz
         QFAS5BqzWqjDrWE+oCJjBnbNZGxcQbVp6Gnh0psJUE3oeOdUtostWqf5jk1CIZRS4PWQ
         yajWUlolXhzpy4tTAJfbdv6DHvtOykYHvc956YhfHRjfyhVajMb9Q3vrFhPeRxsTjy2X
         l2G1lIwxQmWHNex0X9SVyzYUlX/TRvDufcEmC1PLSiFuVoI6IxaezVExBzHvyazMp6d3
         emWTzC96eOHF0MwKgfGpUjIJ+7l8wuw9neq99wbdDD7+L++B5osvX+WJcjJOcQD5GOO3
         JWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474282; x=1780079082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHxQNnJxu4IDUH4opT2oLg+oXtRGUHkxZKbc6hRI9/4=;
        b=QMToXYRMADc8QaVkNApiyWL3vhldCa3GTXIRIuLKnIlnmcyQAAQgKg6grd1t6F64cn
         I3wunH3hj1t4eu/oxYYo9ztsfGuTKKHXyLLl37okZxdbTHmOnEtv86F4H1d/rMkJA5mX
         2T1g1oJ89FND3CKXd8/+UpQ+C+4vebS8s312Rnl0Ao+tQkMSWbTjDVszc2982bd14oon
         QJHuO2kRT/x6XVyi71Zvs2CIE5kWXyhF1bQmHI/pBrBnYN51fALolL5/2XYJeu4lbF/t
         lChGW7IeYfa4R0sVzbcrX/VPphKIAYwLItROmfmt6MQy/5Ug4TTEvbkH1EyhFUSjVgHR
         S20g==
X-Gm-Message-State: AOJu0YyVG71KmXjTUYbpf9VemrSbEh2imU537E1t7Dol+Im7xvRQPil1
	8yKa9oRZV9zg0JHqMEJqQoBWauenkxQnONzpoeYX1e7n3v59adkG6ZJi8o8XPMNa
X-Gm-Gg: Acq92OEab74UhGLI9TKZ+KCyGQvQ3zPIAZ9iGGQisv8CV4VeW5/3dzuCv2r0/ORL6yG
	WHQzLrJDLOFHcCYyUXe/+9nTbPDa6yWudWYQjTv/jYGwvDFxfjuJtpSQUy6SfMNdZFA4Jmro2Ev
	ocpS9vCEW5yS3Hu9l7H75SEosw9Nm0hOFR3/JyC/ixdeUyirHvTL/X2z/9Bx5cnmfOTHd1CWnXb
	p0BbRcGMAmqDkSyFwE/wwAJN+wwxcwrXMSYq/KqBd9WHY07zV8CPMUHva+MIOFY3iFKO6XVid4d
	whNVIqlUEBKdoamj8jlvvChn91NZU6HAdZQ2C4SysIceaC1Oi6I+dwmaum4kZUUlZopBQRTgUbA
	THt7MkVfHI+hQ4Pr4HHtAaUB1ipKYL0Yw3r9RZikw97KRSsmOrJ0SwzfBaBaSwRg0nq3ERINy6l
	AezbZiHW5OX7IyEhvIh2H8yXGB/gs=
X-Received: by 2002:a05:622a:8588:b0:50f:de06:45e2 with SMTP id d75a77b69052e-516d436f402mr54986981cf.31.1779474282185;
        Fri, 22 May 2026 11:24:42 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.123.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b25a01sm22669341cf.8.2026.05.22.11.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:24:41 -0700 (PDT)
Message-Id: <697ef716d234e432dfc5e4b54f35ca527d22aa5e.1779474277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
References: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
	<pull.2101.v5.git.1779474277.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 18:24:27 +0000
Subject: [PATCH v5 03/13] t/perf: add pack-objects filter and path-walk
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
index 0000000000..445ff25be2
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
+	git ls-tree -d HEAD >top-entries &&
+	grep "^040000" top-entries |
+		awk "{print \$4;}" >top-dirs &&
+	top_nr=$(wc -l <top-dirs) &&
+
+	while read tdir
+	do
+		git ls-tree -d --format="$tdir/%(path)" "HEAD:$tdir" || return 1
+	done <top-dirs >depth2-dirs &&
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

