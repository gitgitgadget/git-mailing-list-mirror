Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517943BED42
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537093; cv=none; b=bh5kE+iMY13Eyij6IsHc5r5iJy8FmemFsA5gbbTI2X0ojTlLQyZHa5GxfRuFjFgW+5Bli51y2IfkJCh9uU1Avo/65uXVZqbkvjaGOWRvOV2nxHGj+YPxj2NpOMXEG4l8kI9qC79U4lukDtU8r6bJXNn0WhT0MiDCXXTTMqjaY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537093; c=relaxed/simple;
	bh=FVJuSUVKePoAVqDzlzt4AfyVeAfme2i4pwSwoe/87u8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m/bfiTc/Ouy6ywB+VuC4t2G8z8CYo25oCjiDeJkovZMmO3bHgGx+25O6ROB0ygsdMbhRHR/GfNeB+aRjUk1ZCNAE6NdFBsjGyv3eeR+GWM29+V53elZ3comD+4BIMV8PhVsdMYZIdoXsfb5YTe+88eG5HHWmkQXwo0qOjJesu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgdwUctC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgdwUctC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d8f265cbe6so9110985ad.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537092; x=1789141892; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cx+MCD13jGIX8BHMCKBXALjD0HVZNvZVay1jApAG+yI=;
        b=OgdwUctCltjKdEz4lQP+T+ryCyNcoXI7fdYgnDO8fXndgPsLGxoLtMdmUVDxtlGzfn
         nqJVofM7MgBvYK9dZouN7TigDEUciuhP9fk8M+F7S7KUtwW63J4Vn8YZEWbqLW8Dfk6X
         Gg6MhpTqanKABSya7mB4vh+PkhF8uzBkr99tEL9JF1n8GAW4r1gtQPUBebjWT9kpGjCb
         lCS9uHHkxMCx4M8DAHchfYQXPeewrrb9Q2Ajad5bekAikVn424AJBHSyf56RSqQjrnbk
         MZlXbXnsIKgrI9YVUaeXdMRLjs7M4NGntM3zbOCcH2C0oYnbup2XiK0nE3UBt9P3gcad
         fNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537092; x=1789141892;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cx+MCD13jGIX8BHMCKBXALjD0HVZNvZVay1jApAG+yI=;
        b=gXmjgdmgv7ruDdwl0/8dNu+W8qg2Hr5XtzXghb2cn0Ami8zeUKOqSQlS7YVzfS2oBF
         Z9N/5xAK7BVvqGT20BIXcLOf5xjj/rFKc1Gf9sFG3AEmwJxnF8cKD1ZmfxxaEsbQv8wi
         aQHyRKe5qqHLfRucm3ufOQehwBLceLjWbMvGb6nwvS3pCLFEt4aeFNdjrWEJXF2XmcFB
         ufXsCjtYBDkCPf4jXXJmnk6V9FIPYX6ox8ajr2syE2bTPf2qqBqrfve/ft0F18KHAdh9
         aXr97rZlM+9eGmjrWO/dftlWNqzedhn612F3SoA2LoRtGRur2Z4MS7uX/YjCt0VKRbZ5
         X+uw==
X-Gm-Message-State: AFuF++l1A4qOzAyoWrxpg9Iz7T9VAQMXuKcw9O+i7SnumMVVZeJdfV8T
	7TP5BVKfxW1fqXDmNAdrCk1p6dmgWXogAab2S3UyAtORo54gnmrLtQce5clbTOkN
X-Gm-Gg: AYBFou3bpe7ca3ir1NNKcMqvVQ4NezzOAdSCg7WCqTlbee8e2qgEv9oDcLsgzBLu4Iu
	ZTMplrRuxsQn6QohawdDGqTl2JLhK7JYAGcuZWvvkL2jzaZulJXga0HIs6H5EqdTTsWHaWntkKy
	c5MAUanv4o+8EQ7ykczBL0r8XDxAxjatATJH7Y6Y3t39vlXzCIWlxjhBd4sEl3+SFhJOR+ugTdA
	Rd15i05IJEKDRBr97saVKk1FE4LSpyg3xQ5dRYQhITtn16hGO7uFjIHklU0/VpzKUPO/FNDq7fT
	kUctapE1EGpQLP6ul+aIo/rhg2T1IcZ6unOKDZqbFVBQdecMIYJIZWOvkF8q2sLq4UGNbPmk4uR
	ka/i+98qF+9r/8zIy3uXLC7pE7hmIEDageKPbG0BGolcP/Ox+bKo7ocovxYktxJ3fMxTyIXMUH6
	qoSdf+4NvYDMazKthAlxNwBkTVS8NxPv+g9bdPxwsT64zS6zRBSmKkYoiBDcKrc9Y=
X-Received: by 2002:a17:90b:2f46:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39b261e763dmr11022759a91.15.1788537091336;
        Fri, 04 Sep 2026 08:51:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.247.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534df1sm8776598eec.7.2026.09.04.08.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:30 -0700 (PDT)
Message-Id: <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v2.git.1788537086.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 15:51:25 +0000
Subject: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is
 done
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

The apply backend of "git rebase" runs "git maintenance run --auto"
from finish_rebase() once it has applied its patches. The merge
backend, "git cherry-pick" and "git revert" do not run it when they
finish. They create their commits in process, and only the "git
commit" they spawn for an edited message or a resolved conflict, the
"git merge" a "rebase -r" spawns and an exec command start it, in the
middle of the sequence.

Run it where the sequencer finishes, so that every sequence ends the
way the apply backend does, and so that the next commit can keep it
out of the commands a sequence spawns.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                     | 18 +++++++++++++++---
 t/t3418-rebase-continue.sh      |  8 ++++++++
 t/t3510-cherry-pick-sequence.sh | 10 ++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 65afd100d9..67e1c38762 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5313,6 +5313,12 @@ cleanup_head_ref:
 			return -1;
 	}
 
+	/*
+	 * We ignore errors in 'git maintenance run --auto', since the
+	 * user should see them.
+	 */
+	run_auto_maintenance(r, opts->quiet);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -5577,10 +5583,14 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			res = -1;
 			goto release_todo_list;
 		}
-	} else if (!file_exists(get_todo_path(opts)))
-		return continue_single_pick(r, opts);
-	else if ((res = read_populate_todo(r, &todo_list, opts)))
+	} else if (!file_exists(get_todo_path(opts))) {
+		res = continue_single_pick(r, opts);
+		if (!res)
+			run_auto_maintenance(r, opts->quiet);
+		return res;
+	} else if ((res = read_populate_todo(r, &todo_list, opts))) {
 		goto release_todo_list;
+	}
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
@@ -5698,6 +5708,8 @@ int sequencer_pick_revisions(struct repository *r,
 			BUG("unexpected extra commit from walk");
 
 		res = single_pick(r, cmit, opts);
+		if (!res)
+			run_auto_maintenance(r, opts->quiet);
 		goto out;
 	}
 
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
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 5777dff496..304981ccd6 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -721,4 +721,14 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'cherry-pick runs auto maintenance once it is done' '
+	pristine_detach base &&
+	GIT_TRACE2_EVENT="$(pwd)/single.txt" git cherry-pick picked &&
+	test_subcommand_flex git maintenance run --auto <single.txt &&
+	GIT_TRACE2_EVENT="$(pwd)/sequence.txt" \
+		git cherry-pick anotherpick yetanotherpick &&
+	grep "\"child_start\".*\"maintenance\"" sequence.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
 test_done
-- 
gitgitgadget

