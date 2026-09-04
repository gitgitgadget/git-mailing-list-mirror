Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DC385D9E
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508431; cv=none; b=l8iKqWAXqadumwa3fBd+aPof8kNo5CAn1h2Fu19SH4gf5ZN0tLsJQs4R6NAvu2G03NS5sXxlLd4Q3RmCQCQqkxmY5m3OlUV1qY2Jb4IqMwXhFzzgN1d//INhOxjAmELo8mKiXkpRN8S7Mf+Ed183CICn00AU07cPPTNB1eFuoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508431; c=relaxed/simple;
	bh=vnwq3lLZKL0LGUmXILqql5Pank1crLy+FxYeHJU6n9E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nG08BweNa+6b6E9VUhTkP5Lh8Tzq7bKqRFkD/tZh3HqB6CQarCTV3e4yAfWYQb4fdeH96aUqjjERu4nzeazkOmovedq5XcFgm07KymkWeGAvb7L+lV0kc6hHTrOdIC4Z33oDGRHs5MH4n8ru3JHFOFrKPo9PqRzaqJJPAdO3Gyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ySWYaV; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ySWYaV"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5304310b3e0so8603071cf.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 00:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508428; x=1789113228; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ht29EA8p9bGKHjKxK50zw4VZhRA6YkHNUT6RlgltNXY=;
        b=C5ySWYaVy7JHPPZukIf3Mg7ZoDgmGtX1HbiOq3glT8SBBXLcqj/nvGPA1tAfo+i4mM
         Vo9hPNOMBJ+e7qzT6bbJhNWFPUknXMnscDpGeMBWqUKxbBgkyhxHA4p/t7lBQvqoEIxI
         fwFGSxcpAF3wwNn81BWRAcaeZ7XqWW4MRI/B5S4S8hVc3C2q4jQgvQDTA2LwuhFzqpO4
         r1eZo/FmPSCdn79ZwaXHeH9pyOis7Rj1J8BEJmRX22V0yBR4eYa+920HC9ugY49alEpl
         tKnqBwEJEyx7U2hhi1fF37VL1rrBQ6jBOBtdZqa7TuHlLAVUMPQTBsZghQi3goxLQVxQ
         87gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508428; x=1789113228;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ht29EA8p9bGKHjKxK50zw4VZhRA6YkHNUT6RlgltNXY=;
        b=EAmdRL+NyibrHv4Is90arVhklG5sI+VJAiZ3dStTDmDnOb8LtI3f4QnozsCp46+v0X
         yn2NP2yTsDcgIQZgbklvSmG2mlJvM8MUKuynzf28qqs7E22Fr2qHanQWtgTf4y8oikKz
         N/Gj3vuHsm49qP01HGDKE5lZ0Dvb3iaNT3nKetgTfvUyoYe4nq1JRE5X7gAjqL3w/SlW
         zBAH+lWC2Imwt1D+W7aq52+RNQ5PTTzHmfyv4j4hM8QhtblfBFrC/7113oWwM8tu9fAO
         l3FU7/iXO5jlvUcBAcb9Hy+kkngLrl5V0qg+R7ALam4m10gJtFpOQENeZRPgJ60MQ5to
         bwqw==
X-Gm-Message-State: AFuF++l82sZfnYaDq1BgouQs+xSnKim6Np/OausXsxd6c/zPDPjnb3S5
	Y8bEG4rSdSdKIqfrukWnJms5qMWVbk8Rh9EXyqOomopEzyoUR5K77/dd1pnOCrZb
X-Gm-Gg: AYBFou3hFsWMrbkwh8WLvCFhx9S2nFgoP9EOq0m2CPkB1WujuElpvq5PRb3vxmmDS4L
	hI8aQdAPiCDeUtlsiE6N0g93mz7PMATI5/DJ7+NZxl1tmostGKVwxfkpCHcuaYimhGr3qzeQqUv
	GZWPQs1H0Yxrr9VymqCPYMHL+SKvE0Uoxpl8jJ50zWfUdctIgHjLHRIY0kLL1DSyEcwRzDcOOad
	awBTYuQQgsnunO8sESRnz4pA78d4WLXAXD27GQ1fSiHKtC8qoRG0hgRu4M4t4Vl7ELNjTrAZe46
	r+/aQTTauc+CU+khNpeVwCEZoUXWVkKZHibNumMLiMon4WVeEY+VCkJBDiUTrdGinfXih7otZuO
	FfcCXnLvqH52KA8zvtkv4I6uuCzPQnneynQlfclSqgw1d6ll+ihugaRkyTTivanfbfImCO3ThVB
	2duumPbta2tfhnuX0mEMT5bIiLDPPpT7nSLvhhYnuRdHvGesYMGS1Eoo7qDob4ZZyJ
X-Received: by 2002:a05:622a:4d48:b0:52f:a196:79a6 with SMTP id d75a77b69052e-53054989e92mr48780361cf.33.1788508428440;
        Fri, 04 Sep 2026 00:53:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.149.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530541436b1sm15398771cf.12.2026.09.04.00.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:53:48 -0700 (PDT)
Message-Id: <3415a4dcbf3c83f85aed3d806d897f5f4906715d.1788508426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 07:53:45 +0000
Subject: [PATCH 1/2] sequencer: run auto maintenance once a rebase is done
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The apply backend runs "git maintenance run --auto" from
finish_rebase() once it has applied its patches, and so does "git am"
on its own. The merge backend reaches finish_rebase() only on the
paths both backends share in builtin/rebase.c: an abort, a branch
that is already up to date, and a fast-forward. A rebase that
replays commits never runs maintenance at its end. It creates most
of its commits in process, and only the "git commit" it spawns for a
resolved, reworded or squashed pick, the "git merge" a "rebase -r"
spawns for an octopus merge or with a strategy, and whatever an exec
command runs kick maintenance off, in the middle of the rebase. Run
it where the sequencer finishes a rebase, after the autostash is
applied, as finish_rebase() does, so that both backends end a rebase
the same way, and so that the next commit can keep it out of the
commands a rebase spawns. builtin/rebase.c could run it instead once
run_sequencer_rebase() returns, but the sequencer is where the rebase
finishes, and the autostash and the state cleanup that surround the
run in finish_rebase() are there as well. prepare_auto_maintenance()
closes the object database before the spawn, so the sequencer holds
nothing a repack would need to replace.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                | 5 +++++
 t/t3418-rebase-continue.sh | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..f58ad254be 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5297,6 +5297,11 @@ cleanup_head_ref:
 			run_hooks_opt(r, "post-rewrite", &hook_opt);
 		}
 		apply_autostash(rebase_path_autostash());
+		/*
+		 * We ignore errors in 'git maintenance run --auto', since the
+		 * user should see them.
+		 */
+		run_auto_maintenance(r, opts->quiet);
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index cb5c3a1cb5..2c34cf8a01 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -395,4 +395,12 @@ test_orig_head () {
 test_orig_head --apply
 test_orig_head --merge
 
+test_expect_success 'rebase runs auto maintenance at its end' '
+	git checkout -b one-exec main^ &&
+	test_commit F4 &&
+	test_must_fail git rebase -x false main &&
+	GIT_TRACE2_EVENT="$(pwd)/finish.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <finish.txt
+'
+
 test_done
-- 
gitgitgadget

