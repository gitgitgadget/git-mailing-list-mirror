Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EF384244
	for <git@vger.kernel.org>; Sat, 29 Aug 2026 07:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787986841; cv=none; b=X+hcAHa8xU9aZDlYjLnho0ClLSsNLdK6SiaDAEdoAjPvUmJET4yAi64tWXSfj/Xh+WuuTxPbim26RNzXQjV0g0zIyjZpFKejbzTYgNVoY6pp/Tbj/GbtESonYPf33Lfr0k0fMoaobJFeJfDGqpidZC/9Sn0nkN/GieQCITwEi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787986841; c=relaxed/simple;
	bh=V/blUPsU/FGmBxxqg20D7H6NZp2IsP3qN6i4aGITe30=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EJ9WyiOrFmKeFV4INMgSsjqbRf30Rqebw17GRc+9J4a8gGGimAEy+ahibEfoSxhabq1/sH/uOmZ/PXIfA0kjXHXQVZ1zj45+I8QHVL8CODFjiepY5Y25G3t/0T8xlsgMs1Tzs7A0/d5rA865/tSXoa2Jl4gaNWsjUHJsoCoyAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTbUUP62; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTbUUP62"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso980474a34.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2026 00:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787986835; x=1788591635; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z1Gvi27EBY7jxIjXW77iMlUlNbLtCav43HZLeeP32Mg=;
        b=GTbUUP62x303tDbj4JzwfCsWaqVzLcxYzcKuoxglNhEi6qJG3npqBYuW28ews92WUk
         /Y+ozar6pVZbDdvwGh90uIHVuln6qo4gqpGwZjsrdnaqGNCBl2hCfz761zXyAuQGa87g
         4U1vyhnLLlWGDOr9ghiGJGQYVDRrwzvyIXeKpW1sMISjZ/eYRPaKMKlYmy4bd31DsyQy
         oArsfXOTPaZ5Boq1r5bcv4LXgqW44xvzySONKs7wvwjOkwoJ6ICcpGoW64MoK1l+xPhu
         zeWfIS+C+43Ys80tS8j2MsZsDfTMK4mgrdDNYOUetQywMchmDtw8RzZHUP4zA3Zqx/5Q
         EiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787986835; x=1788591635;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1Gvi27EBY7jxIjXW77iMlUlNbLtCav43HZLeeP32Mg=;
        b=QLNbDJ8OcrSE63EIXk/A1gn+mJVUNruROknBgOGsjaCLsSEStZH8kvHjqgEOTLXc/U
         d7r/JHHCA3nBh7YTV9i3vn0sDcM/xrrO1vFnYANrFrXj1pFuuhaXDWW7ajXoL7MG+JVS
         PMglrM8moJmGmeTUCfugprb8JxtUgjh/nTW+c3xj+NBVbGafYv9pscqllvTrnbvgVu5Z
         Ceqfgq0tuxEX78Ccl4TauaZdCdSVyHml8uMtcORM0fnt0d/3xozGDp1+ORMu2SfMA0S0
         pqdEc9mk+9wUP2SEQw4n4b+ZuNPTKKvEOzcI173ozviofqHpWBYvjRddkER2E9eYi7gu
         1/IQ==
X-Gm-Message-State: AFuF++kXaIKAXfmnLr81zdyB2Qg2lkv8i1rv15ek0O+z+laZYFeDjaVw
	nwyIb6hZhRoDodXBH1aMH9VWi5EVNqTxd4oErojLwaX/blkliOVolxJ266g2N+9U
X-Gm-Gg: AR+sD10RcvkSjaMhkZ8iWBBlPOv+n13SbQULRarMQFHPWM30vGBOUJctst1nEwouoVQ
	OKZfTuXAaszgnSZYAS8eax4fM6wOUDXYCpejwg10ln7Z4D/3zrdWr36eodxw0yM9pJeMy+OoxL7
	cWluCsdSmbY01t6oyoqDrXG/KpBEAvHymLKcaOTgoiRoFxoYlIGi/JIivl63OWd5ce1/s4mnSNp
	kRGRehqO5PsoxpFwG7luUX4Kles4yM8lu/nFlasFC3IGhjKlG/e+e4GJOO60yzLayAj4sBY+I26
	i1F3/xq95ywyCKEf7yseqa0+0xBoPKJRHRRyeI+59t2OOaEXTbZsENqrSdfiySQVpW1J9loOX78
	QOBmkp6rIh/WUH/4PaagSDMgGGUdhRGIhoawn+sXwmSuYW4mrBwih84gFuGrpKuStx7j7T04QUZ
	0x+HkUcQwTx3ZclLaGlwIJAzYSHn7Q3On1t9OTKJ7IJD8przcwaXeHGWGtn4I+pb5wVTUi3MRX
X-Received: by 2002:a05:6830:4406:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f4f2624dc3mr15354163a34.15.1787986835342;
        Sat, 29 Aug 2026 00:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.5.228])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa99d87fsm3008274a34.20.2026.08.29.00.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 00:00:34 -0700 (PDT)
Message-Id: <36bf2ce17be1a4da1ba92d5eb89ce49c7e00be9d.1787986831.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Aug 2026 07:00:28 +0000
Subject: [PATCH v3 1/4] replay: fail gracefully when a merge input is
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

