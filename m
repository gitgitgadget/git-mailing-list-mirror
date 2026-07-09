Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC23749E5
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609389; cv=none; b=H2myH0UXlm5XR4h2YZl4wXkJ0ONBvAlKdKSb1AOhgkBN1c+us2LtPH2eTVNGJNUUuvnAcrm9CX/Q08IQprOHApvOoae+3mYo+Ihb4bIUfY2QcPbAlH8QXSXzyNBj4GTVGsBiOlnrLKo952CAoDSs/rMTXedVGHETogy1C+syhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609389; c=relaxed/simple;
	bh=ZYc/Gycpg/awk++RrUZ7e5SROK7yE9xYUzYwo9JHOio=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HfFvXwCvSUfXwd9MvvxUgeSVZylYTZKLe3D9tgdtYHdaOnhnPiklsh/bW5C3KXHSWmlrMo7OqHIKV8Z5wZEwGYufDDzK/qQVi1eMTLWjBXgDJxb7Ip0RrpVqhq/4HOHDZ+5l9ZuUb+pVhzf49Sg7viuxLqOxzK5biaKrS3xxQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LynWsced; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LynWsced"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92b21f65b60so63236685a.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783609387; x=1784214187; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k0sZdue0HNkjNvpj35gvOHyeCsbXm5uuxY9FIXuZQgc=;
        b=LynWscedoLoyjIlIyI4kR0AqzDsZGsn/lPenp53lE1wIs7FO1AEuzLDRf+8n2p86rw
         wW+my746hwjajwNPJzuRbKjpTVEQW/Pp/2/vWAZeWNEL4JLRGOmwlUCKdtiSOC1J0KCv
         G/YT1k1cce18z8Cy2yFxqOXi7/9K2A1Umi0p6fI527eZXGY2/Ou+vWundDUvQ6UlOob0
         i2wdH/Sjnz58cOq9GGC7MOSKmUru+VbHtfTDKmZaTom0raD8jKv9rubl/5BxzQbaIhn0
         Pb/fma6MtNd3NXFtD1tAskjAoBu5s2bGDm6e59kOj5LyG7LeISd4JQxeaEuK6ihBzjTg
         uMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783609387; x=1784214187;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0sZdue0HNkjNvpj35gvOHyeCsbXm5uuxY9FIXuZQgc=;
        b=cpmvi/W89Nd16OmQR4a/vP4SibjBEFA2AQBR3TiRQnxQQNV7yHLsyJMy6pbht9VLdd
         KcBWuLWRA/jqjQTLgMNwy2pG8Zv73omtzLiK1dN37/AFFaq2L8B/lGgHoQUXDFGUjiCi
         5KEUbwdkG6SUvZ7+mHH0rp9ZMb27JOnM9plGSjbEr+y7Vir27Mb411keAs8eFhjN/Kaz
         wKKE+l6abbm7b2bU4HgahvZZ+wdqCzIo9jRKr6c3PzhQ1kp8/t5dIoybauBSSZ6Cws28
         +CCrhhkd8zShP9KozLbalMvCOTNlL48pUe4VmGImbkT8W8Tnc9jyFTRylixKbBIwodV0
         NFaQ==
X-Gm-Message-State: AOJu0Ywo4dWwA3Rx1vIWculHTlkMQCxQkybfnZoIRT0+F+AxdH4r1eB6
	b2JWe6qDjQEPeFbzCuyW5EaGmQ8tZeG/UcmmgWGtfZL+J/01cQPU+Iinn3pZRg==
X-Gm-Gg: AfdE7cmKConqdkUyQz0kqRnNo5M8DZzSeWkCUzIZaQzpJJmI+ARqspVArITdjzXB7LB
	6xQym3WEZBCA8EQfCMScbWz4Ep0gBp2FF9PDytYy3dyl6go5NRspaOfTwWH8XLxcKx/yCbhiYDn
	SWtg2DF+/BOZ/gZ6ayEVnABTRShOmQG6aC5YLIlg/bKz4I7kdrAqiWwJL1plYZ6skzTX2xQYyaO
	0Gaw6BHj1GEYUOc7R0rX9W+jR/Ev2joJvOSvzV/GIiy1iqOcXMGVAAjS7fWo1Y+2qAYKT2BO9AP
	TvmOV1odrV1Nzy/qBfs2Qq7yHYH1/OkjawA0wnJa300rCtG8kJYOOWqx9EX0M7AjNq6A7pnBU68
	O8itvzAMVFT+d3SjIAC/24G3Nx7Ap1VNnMXNpVFZckN5zpBi+B2Ugk+1FTNnhP0S1BewrE7oxKf
	c/mVq2p8/jwdFwJ4E=
X-Received: by 2002:ac8:5a55:0:b0:51c:7aa7:e0e9 with SMTP id d75a77b69052e-51c9b986c97mr32527291cf.38.1783609386405;
        Thu, 09 Jul 2026 08:03:06 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b7671csm172513911cf.13.2026.07.09.08.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:03:05 -0700 (PDT)
Message-Id: <100efa22a9a2bb82b85c95fa2ce933311ca09ee3.1783609382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<pull.2170.v2.git.1783609382.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 15:03:00 +0000
Subject: [PATCH v2 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Count the number of steps taken in
compute_reachable_generation_numbers() and expose it via
trace2 to make it easier to detect performance regressions.

Add a failing test for such a regression, introduced in
199d452758 (commit-graph: return the prepared commit graph
from `prepare_commit_graph()`, 2025-09-04), where incremental
commit-graph writes do not see existing generation numbers
from lower graph layers and fall back to walking the full
ancestry.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-graph.c                |  5 +++++
 t/t5324-split-commit-graph.sh | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index c6d9c5c740..702ba9731b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1653,6 +1653,7 @@ static void compute_reachable_generation_numbers(
 {
 	int i;
 	struct commit_list *list = NULL;
+	intmax_t steps = 0;
 
 	for (i = 0; i < info->commits->nr; i++) {
 		struct commit *c = info->commits->items[i];
@@ -1671,6 +1672,7 @@ static void compute_reachable_generation_numbers(
 			int all_parents_computed = 1;
 			timestamp_t max_gen = 0;
 
+			steps++;
 			for (parent = current->parents; parent; parent = parent->next) {
 				repo_parse_commit(info->r, parent->item);
 				gen = info->get_generation(parent->item, info->data);
@@ -1694,6 +1696,9 @@ static void compute_reachable_generation_numbers(
 			}
 		}
 	}
+
+	trace2_data_intmax("commit-graph", info->r,
+			   "generation-dfs-steps", steps);
 }
 
 static timestamp_t get_topo_level(struct commit *c, void *data)
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 49a057cc2e..b41331e3dd 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -718,6 +718,30 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
 	)
 '
 
+test_expect_failure 'incremental write reads topo levels from all layers' '
+	git init topo-from-lower &&
+	(
+		cd topo-from-lower &&
+
+		for i in $(test_seq 5)
+		do
+			test_commit base-$i || return 1
+		done &&
+		git commit-graph write --reachable &&
+
+		test_commit extra &&
+		git commit-graph write --reachable --split=no-merge &&
+
+		git checkout base-3 &&
+		test_commit new-branch &&
+
+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git commit-graph write --reachable --split=no-merge &&
+
+		test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
+	)
+'
+
 test_expect_success 'temporary graph layer is discarded upon failure' '
 	git init layer-discard &&
 	(
-- 
gitgitgadget

