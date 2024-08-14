Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D01AE049
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723631500; cv=none; b=P04QCCed0w2NCKSzIDGeRmGUPHshKChQtrG2xApWF/T7yOcN3jWnrrdc/BoEEDwp4ueBUViqjXGQ8dXqeaIUY5bxbAaTvvO0N54LePLCZ9ybPyxGCOrg3K1/pQjEkDnLuCVTLlVvVYcMNAL/VH83G8ki3CvKzrBYFMbXkTZyYLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723631500; c=relaxed/simple;
	bh=jgBi6oNQL+qdRE7utMh8FfsQo+FyxbRlKAjlGaLSrHE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nh9IkmX4buzyeqfFu42gHYScoiKBQHiR9BKdhIyxIssbJYO8SIYdoHAdMhTdoTUA8RoDbXi/RKhLEuYg1ou4yXmLI8gt/IGYHGdKKH9w2N6tj/5FAzB9BuPGB3HXviw0ukNUTqgqoitEkcnSBDnzgPxdzGK5I0Wg0BsAMKTy4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpRVH1gS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpRVH1gS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-429d2d7be1eso4226745e9.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 03:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723631496; x=1724236296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=XpRVH1gS3V08b2J7d5+3dpajhBtU9/6OgVgLp95W4FTE0qkiIsXONIb4OxJB95WZ+0
         9TVbJHCobW4NczYOp8/R/atZKrJOvF4Gp1wdBbX8q/5PMKIaOELHoGK8KFZqUr1f7M/I
         sb41XRTOcSPBXmbJsUprA2PNsklGaV3Zk8LyPctA6sv1+uOrVZbQsZ/qqN7tz0No8TJT
         XvEjNNKCCqMxv3zzBPo93w7jWAm8CVqRwjVyLcVCgUXLDZKeR+TyyqDTk4A0ZuCbGhrC
         81pHApO4+eCjGIj2ndR0GNCzT1N1ZZ0Ya3r2Vg7NWOHBGJUZ+iUtIBK2AonDM9zA6p+5
         JbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723631496; x=1724236296;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56hSNiOlt1LylH+n3beA4JrC5B+sMVlxoMQsGPznpV4=;
        b=MDOBRma/PZizMxhvMqA8ZawZ5apj0Z+/HnMW0PHFzgBjaaCNjXtnyEdvdAD+hBCIK7
         BaGKiZYVFTVQVzDhbSRhIx3k0WWlkkdxz8133apbfToK9LyHbilo/Atq5CFiSAvE/GmI
         EMciUeouaRG/iBoQg6VSTFV51Muc0tVvcsQjs4fpHc+jVBq3Mkm84igo2XQX4W7rurs/
         8aut1OegPgS0miiF8YBRMRFZM1mBFmxd4kty9Oz8gzhqVGk9QG9YEBfp5wGrcP5wvz7L
         kRiwjr4tkuM7Wm02KlY0qi4nY5Uvc9DUYcIiklEbfiQybzXoEZPV9n6N8XhOW9gI4tnf
         ZiRQ==
X-Gm-Message-State: AOJu0YyEDUkzWkpZhjcsLJ5ccE3iZNOIetzPcxvjsj0C8G4HadpN7Kyr
	J/oA4wD/BoOHVhTlisWrTR5MuxzQEG7Jhy7wPFGwMavj4yORV6k2Sy9Jiw==
X-Google-Smtp-Source: AGHT+IEQxSlY4LwCp/iiDl5uIrcwV6MeC/k3VQluReow/yleTzjl6ynJtTNrK+fWxxp8ho+v+fu94Q==
X-Received: by 2002:a05:600c:3b8f:b0:426:706c:a55a with SMTP id 5b1f17b1804b1-429d625a7b1mr44623615e9.2.1723631496074;
        Wed, 14 Aug 2024 03:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71dfasm15442345e9.38.2024.08.14.03.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 03:31:35 -0700 (PDT)
Message-Id: <cce9921bbd8825c3a12d32b2c8b62a2c4b06333a.1723631490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.1723397687.gitgitgadget@gmail.com>
	<pull.1768.v3.git.1723631490.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 10:31:30 +0000
Subject: [PATCH v3 4/4] p1500: add is-base performance tests
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
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous two changes introduced a commit walking heuristic for finding
the most likely base branch for a given source. This algorithm walks
first-parent histories until reaching a collision.

This walk _should_ be very fast. Exceptions include cases where a
commit-graph file does not exist, leading to a full walk of all reachable
commits to compute generation numbers, or a case where no collision in the
first-parent history exists, leading to a walk of all first-parent history
to the root commits.

The p1500 test script guarantees a complete commit-graph file during its
setup, so we will not test that scenario. Do create a new root commit in an
effort to test the scenario of parallel first-parent histories.

Even with the extra root commit, these tests take no longer than 0.02
seconds on my machine for the Git repository. However, the results are
slightly more interesting in a copy of the Linux kernel repository:

Test
---------------------------------------------------------------
1500.2: ahead-behind counts: git for-each-ref              0.12
1500.3: ahead-behind counts: git branch                    0.12
1500.4: ahead-behind counts: git tag                       0.12
1500.5: contains: git for-each-ref --merged                0.04
1500.6: contains: git branch --merged                      0.04
1500.7: contains: git tag --merged                         0.04
1500.8: is-base check: test-tool reach (refs)              0.03
1500.9: is-base check: test-tool reach (tags)              0.03
1500.10: is-base check: git for-each-ref                   0.03
1500.11: is-base check: git for-each-ref (disjoint-base)   0.07

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p1500-graph-walks.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index e14e7620cce..5b23ce5db93 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -20,6 +20,21 @@ test_expect_success 'setup' '
 		echo tag-$ref ||
 		return 1
 	done >tags &&
+
+	echo "A:HEAD" >test-tool-refs &&
+	for line in $(cat refs)
+	do
+		echo "X:$line" >>test-tool-refs || return 1
+	done &&
+	echo "A:HEAD" >test-tool-tags &&
+	for line in $(cat tags)
+	do
+		echo "X:$line" >>test-tool-tags || return 1
+	done &&
+
+	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
+	git update-ref refs/heads/disjoint-base $commit &&
+
 	git commit-graph write --reachable
 '
 
@@ -47,4 +62,20 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'is-base check: test-tool reach (refs)' '
+	test-tool reach get_branch_base_for_tip <test-tool-refs
+'
+
+test_perf 'is-base check: test-tool reach (tags)' '
+	test-tool reach get_branch_base_for_tip <test-tool-tags
+'
+
+test_perf 'is-base check: git for-each-ref' '
+	git for-each-ref --format="%(is-base:HEAD)" --stdin <refs
+'
+
+test_perf 'is-base check: git for-each-ref (disjoint-base)' '
+	git for-each-ref --format="%(is-base:refs/heads/disjoint-base)" --stdin <refs
+'
+
 test_done
-- 
gitgitgadget
