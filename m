Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDDC3B5F59
	for <git@vger.kernel.org>; Wed, 13 May 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707146; cv=none; b=M4hm+AxopQa8/K3TdMO57rveiSsGXQdGvtt1CKfNT9gROpDQKAAvIevwdEJiKQXHQyLUgoN4FH9CHrt9rPtHVxiIILDJLt4/gzyF9Fb11/UJbKOxZ5wna/3C4t8yhK9DjUo4JljtOW0xlWlikV1f/v9DkyR1qdEU4f+awpm/pMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707146; c=relaxed/simple;
	bh=9h7l2ESkqFBfnr00L19F2a2WWMFx+X/yIdxtJRd5+ZE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YJjAuopPeQXznOqdh6Ds4ouO/bAHwpli3tTU2YCzg4YSqFiH5apfs8y4N42ulaZOHJj8Bu1CWaVOWnFv4QqCSdzWwCyZRagTtRjjW02jfDVwwMaJ2KUb/+VIn8pv8QrZ47GvJNE7bAnrt2Cktq/LGoF+E/eqh/nDNzxGoQMw4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5iNsiNN; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5iNsiNN"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13354eb66baso3724609c88.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707144; x=1779311944; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtpPMl/rJAh66bjWlmDPQHVVCZHqd0cnxL4UAR96OPM=;
        b=J5iNsiNN82TOSas0YtLPRXMsKobHVH6a0PoH0p5EfxyIAdCIEP2necWgoOuzBy5QUU
         uAAZub/itzTt2KeMR4o6kAFt6A/KxRnFkECT8m2qYMmTGH25sGmtHRUT9N6pOyJrZn80
         V+5NKh7kkEaeiysx4j3PpkIAREvifXdgWCqtGqLQ2lnj8bIRtvmOMyOFb3XtdYNCyd9t
         XAE9JymUMKBsSTPx1fq77+uadB7UuoIJ2IX29gOzMid/uFkyMZ1RvRZtMHCQYHCU8/PN
         bO+0KZ8TvKzCJ2o0O/Kjh/g6aSwMic5o1qNX//l4O1SMwYUZkZFP7SuvJF3rYe6VoORA
         Hwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707144; x=1779311944;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtpPMl/rJAh66bjWlmDPQHVVCZHqd0cnxL4UAR96OPM=;
        b=q/99opt2yheJx2WgausclzFhtt8qZLC41DRDAa4awAzO1vbyqKSvVzO7euDTW2wDGH
         /MuAUPnc+/VEniJ9xWCDf93ZnFH1N06VrIqL5Vi/WpR+M19EQrwju9an9jdt5BzR7sPS
         8klPVMjLGfT7I3Ofi3HmUxdhT4XHDVlQAolp+fvsDl1gg99cwTitvP2UF/kbsrWyS4zI
         8uP9BXvFx76ZD97Y109gAN7uJWeXvUmgbd3s12Q34yh27s/T7qxNWhZMrw5qYHeCp17A
         2CAuJj6aHNjwOXof8C4c4Z0pzp1NWW88GoZKUhq3A5fWUATxTJY5l1xMsAD2g78eSeoW
         bvyg==
X-Gm-Message-State: AOJu0YyFbceeSGe32idCMOzj+FOdd01e8QdzSrE2RZ0uAH857J2xch26
	QxWO8NiCqnP0nkHaUWK812bJjuEHmW4IftiM8mi2h/fbKZpRKBNQLbvFjr1DL023
X-Gm-Gg: Acq92OEaD1M5QAlwSGR2WkHNPCtfiIPLQopZL5VgB2Qd0LR5oQ6THbHe9H6wbK3HD4c
	A4X2CO5vHUk58NkJiPCwSdK6VK1yZ9X/MS7Z3jlCzIbZlpHISsza1ZRgTBmK6z65fmUx0bAcTI/
	RIhABGLBZux0MT7+0VNeUtJHNo1UPeIXIWV+wXW8U0rVvTGizdZsFUazFYHnE1h0WPsdlRV/CCI
	GQP5KAk6CRRT8FE7KFiHImLcOgpa89EVaOZIyDEuMx3IQb9DQ2QZx6c6C4LQYgK42cUZEzj7jzN
	d2v9+HJths9pk1O0twaldep48qyXXsGxGq4BzzODZnezDG7jFg5nMSLGoCfBPLeFKodj7GiJGQM
	u/xWhSdBqh+JiZsUKGyRQT0yacodfI6PleAE/r3lvSlDxcBhvFOeR6joo4yyW8F7SUKQtinDPY2
	1ZScMF87KmZ6eRgu+QrCPMDpFuFA==
X-Received: by 2002:a05:7300:c87:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-30119f6e52dmr2816926eec.26.1778707143656;
        Wed, 13 May 2026 14:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm555490eec.14.2026.05.13.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:19:03 -0700 (PDT)
Message-Id: <fb8a0f9c43d4e41712839a93c4db6a294a7b5285.1778707135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
References: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
	<pull.2101.v4.git.1778707135.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 21:18:45 +0000
Subject: [PATCH v4 03/13] t/perf: add pack-objects filter and path-walk
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
 t/perf/p5315-pack-objects-filter.sh | 131 ++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100755 t/perf/p5315-pack-objects-filter.sh

diff --git a/t/perf/p5315-pack-objects-filter.sh b/t/perf/p5315-pack-objects-filter.sh
new file mode 100755
index 0000000000..21056abfc0
--- /dev/null
+++ b/t/perf/p5315-pack-objects-filter.sh
@@ -0,0 +1,131 @@
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
+	>depth2-dirs &&
+	while read tdir
+	do
+		git ls-tree -d --name-only "HEAD:$tdir" 2>/dev/null || return 1
+	done <top-dirs >depth2-dirs.raw &&
+	sed "s|^|$tdir/|" <depth2-dirs.raw >depth2-dirs &&
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

