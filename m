Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA04387596
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014002; cv=none; b=jCE+9sm1Vs95qo5h39lp8RH1UKVQSRgQA3IwlmQ7zk+Z1Dr5Kc78eMWLDwVdi0sYujMPqLCzkpmktT/W767Okg9ccNNKyC6SA6KEOxa8vlHlfyFnqPX6ooh/d+iOQbpYibAzkTPhKo/sHpEZ6QQwjjIhYHUiQ2UVHBb/K++0N0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014002; c=relaxed/simple;
	bh=/dQ43lGME8Jc4jWqITd37EDlmlD4OWBS4crozUTAqe8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ODTu8QjU59GgEVRx0oL3WXqIMmeYyKYErHgyq3MzDZu2kBneVrTIoD17qZlumvc0EgyuW6aChdO7tMtjQ5hNmwAi+/62PUGIjxHxI/sW5vuv4WNIpRAGguWr4uiu7437p49KcZa8EsQNSUObSzAnFK6Jgx0QmA419EiKw/V7mcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+uXOoeu; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+uXOoeu"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664b05d408bso1984235d50.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786014000; x=1786618800; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJDSnyY6iZd531+d5vCFBTo6Lg0t1LhcByB4b99XXtM=;
        b=b+uXOoeufO+n83bW0BviSi9RaZZjyYlEz49gJdZianFjj3JKm0nylecRowTR2mlHOi
         O8GBUGT6xrGZBljzksHGO7T6G5158E+xgimysOORrOpav/0fRgdpckATkMR6XybmtQM5
         mtY6VNZ1tEFIoSLqthUxpo+WYtzuloG+4xojfqT696v3m742BbvJ189zKeyQ2Muvw9mC
         jkrA3ei71/YfIUVfVx8LbJSW1vuodu1FsysuMpiKn2iksN+47ux1yolIxh3Q23li3bL1
         gmwNiwjX6nAybJcx+yZzdInsA6F98gzLMcoR+DNzTLuAloZtdJy7lM6sIohNsUFiqR45
         wLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014000; x=1786618800;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJDSnyY6iZd531+d5vCFBTo6Lg0t1LhcByB4b99XXtM=;
        b=pLbwb2njFIq8jNjFgj9Bsw2YKCOCNmC+VqjIIq2T4baDEAGTS8vVm2WkbkPHglZ/0h
         1HAjLUZV4TZlYGydlJQn5RBjzkBWjv+9tWMxx4KDwLov2lapRUopw6Wq+wpjSpcbUl5/
         zgpyNCPWEydd5fLRbp9rHhX1+IF0HP3kToCYXlmYbZPuwA9k7C7AN9J9icW/8WoFie6D
         AygTX31WlU0cqYt7qke7npi5nHAF+FZlYTt+OSgaXC70zy0dF6LjYN4dX16Ai7eDofU3
         rNEprDCiQ9ebAnmw3t0WwPYFfm3jpxyuktBq6rlMCjoA7KNogkmjT0BzdCSx2QY+1s04
         kqGg==
X-Gm-Message-State: AOJu0Ywy0MtI+M+Q78/8z9xBDww3ZgJ0AowZWUI6NT0wUCaLy3GqQUny
	At/f4Kcl3daPQgMqB5PCtVBMBhLoJ7b+LsF45DOzFevULXVliMVSMvjIDKqNxw==
X-Gm-Gg: AR+sD13JTlJ9XXaX4fLod7+aYjvvsA1TM8qx5IPU7j77SHWPeFdImqsDCoPMAYaAkji
	F7lfVkxfd9hb71VxFOcS0ZP0/j3Wpr4yz1lJvDx5plIN3R+xFG9jqydop5p1svaifBcaQzKTB80
	A31Op+PxM+HCOG+cdcrRm/ae5bxoOh4HOCkc+8GJPyMYc7glJcbNKR9PGBa37rTI78/Uo0QdqNG
	tbf/BXTHQ6EE26Mv81WPV9STgH7pqwgsOxsEyk+zpMWKgkmdtmkeoGsmxmTzz5GZPhxfFZjaUzi
	ZzqoiHqXt69UEYdKOL6UxUMGhyQ6QST9jwuRxwW1NbZIEUDIp7NvsYQlcZ3wfmq1r5NM/0ZF/+1
	KwTRUPw3F+F69NZ380BQ0el66XJP9RuE/e6Ca6YaVve7oopCAbEC2DfYaKpVWnwEalbosvaIJVx
	5s1OHn1CCXFlNAE9VQUDj2gby83TXUJc+ex33fe3wslhF2Iaiz8FZDqE+fE7p9ZxiERVthTnuhB
	GU=
X-Received: by 2002:a53:a3c3:0:b0:669:586a:8673 with SMTP id 956f58d0204a3-6699aab2136mr6187919d50.21.1786013999678;
        Thu, 06 Aug 2026 03:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.50])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6699136a3d5sm4796379d50.1.2026.08.06.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:59:59 -0700 (PDT)
Message-Id: <490be76befc4689d463d472829c0271351b69a43.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v7.git.1786013982.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Aug 2026 10:59:36 +0000
Subject: [PATCH v7 05/10] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_EVENT. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 +++++
 t/t6600-test-reach.sh | 44 ++++++++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 8541264136..d59e76a2e2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -113,6 +114,7 @@ static int paint_down_to_common(struct repository *r,
 	};
 	int i;
 	int gen_ordered = 1;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -138,6 +140,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -194,6 +197,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 698b831a6e..45aa26cd44 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -153,24 +153,34 @@ test_expect_success 'setup' '
 '
 
 run_all_modes () {
-	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-full .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-half .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished rm -rf "$graph" "${graph}s" &&
+	rm -f trace-mode-*.txt &&
+
+	for mode in none full half no-gdat
+	do
+		rm -rf "$graph" "${graph}s" &&
+		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
+		true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
+			"$@" <input >actual &&
+		test_cmp expect actual || return 1
+	done
 }
 
 test_all_modes () {
 	run_all_modes test-tool reach "$@"
 }
 
+test_paint_down_steps () {
+	for mode in none full half no-gdat
+	do
+		test_trace2_data_singular paint_down_to_common steps "$1" \
+			"mode=$mode" <"trace-mode-${mode}.txt" || return 1
+		shift
+	done
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -244,7 +254,8 @@ test_expect_success 'in_merge_bases_many:self' '
 	X:commit-6-8
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_all_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many &&
+	test_paint_down_steps 45 2 25 3
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -329,6 +340,13 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'merge-base --all commit-walk steps' '
+	>input &&
+	git rev-parse commit-9-1 >expect &&
+	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
+	test_paint_down_steps 81 80 81 81
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

