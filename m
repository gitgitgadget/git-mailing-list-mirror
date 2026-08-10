Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34089360745
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388696; cv=none; b=f7LFEXvtX/IJkJFokqzT8RAjKAZGA85Q6LUvqq9Mn6kvt1jenp/USc8DgjJj6JHKFsJ9Yqq+Z001VB45yvfsuPT54QwwaFj2AfOEy/ZJ84fbzXaLiNfl8PkMWt1vtljrWSmn74x1PgqTuqepCeMJtvIZHISIOZ6yl1MtreZfqqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388696; c=relaxed/simple;
	bh=9w7aDpS7s4uR/pnf0+KxJQ08aTx9fNk8Rcsb34B70kA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YEPO49eHQVyhFNCvY08nEkvq2Ahp5eFqCdGulUfxZrLTpmAfPOURQxV9nr8b0HAO2ekZLurCvAd287Cd2zFC3yNugyJ9I2GzkSeusDDFtydIMTuHC1UWKwRN5krYnvWsPs5ArT3qZQzLYbrC7kV8ilQ+TRLT+8vj3Dzm9aSGWh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLAIF0pU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLAIF0pU"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so1675536a91.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786388692; x=1786993492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=90gVAOHwqd0dne/ZnoiBMTS3wlCJ3nqu19pB1eamHl4=;
        b=nLAIF0pUkzzbQt77ROF5i1P/dCkV+Hx3rP/3gjZIe3zjnDPV6tb1nslqq5t9A5l8Lt
         8wbZ1708hDA0emtS7AnZPCoHQ4HRiNfr0aEBwsFgbaIpGoTPmJDdKxIANA9KMi0GM1SA
         aTdPCwdop+QApgF+hwbM9brct2YgxgP+OlzrhWi/c0/a4nQ5IK0qQ1n9/FG0OgqPTB5o
         uYJZBS4qKPrLqDuWFky/7+8sM8iez/0k7UwSwbOaaSB5u/Cg/kUfRZ9JUWCT6ELPHlqM
         AqccJn/togzjo6kzaeNW+i1xXBgsDAOtuT1lPMUg3JX/seSZPeh6XxXDGny6O72yDrx2
         nZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786388692; x=1786993492;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90gVAOHwqd0dne/ZnoiBMTS3wlCJ3nqu19pB1eamHl4=;
        b=Wi1Pvs1NQRXIqwLxAf4x0Kofu2HCdJtyXA4+RMQQGC7OB7P+p8PR4TIFkWhNV2esiO
         TnJy4/SMRh75bqKDn8DQYkyNchQ9eOBB2mAPIl9xkk510XuYLOljlLCyMKPyQw2frYSs
         ZvJaJhlPzDgCeAT/W00qbaMFLWiw58nsKXoqHpQnm90jYmFOWJMiXN3arizyvVecT2eL
         PCBogPABDDV+HuUq9UvSorzEjbNrCLtiS1yDJe0yc0YSxo+zrL4IiA4dSieczv7hLv6N
         iRfr1m/sQcWLYqn6f7hJGj4KGodVeingQ4BQpnYc+7qI5os/SM3RxKVtaKqZFVnuVVRo
         zZzw==
X-Gm-Message-State: AOJu0YyTWwMWhLjtH/Eh+4+Cd94nWiXrMBXMuInVUjBJVmAr49GcMsnw
	Is/EmUaEPlG9MshhMNmy6WcZtccFb1CJP51fuxyaT3O6xN25B4OFHkHF525QsA==
X-Gm-Gg: AR+sD119ALe0Y6w3badlfQqwfCWdu8fYvfjVja3QcaVJ5Efxi56AVjg5QAcPm9Ut+Yc
	/MN+PXju0M9VpeXX1YZ0+MjtcY894Grg7UhRNtHcIA5cy9xsJ5Tu2nkA/n1xI4kzw5wjt8qY2Eb
	+qVsGTHIW5XSzxZDLQ9SGbkTOVboQ3mhIzI+15nSqfGpjSk8uOu0aQJAMo7fHh9vgxha5YW0HC2
	gq9OCnyKOfLR63CnKPbrVevZx48PvwCQYzfeFUpHVXWKTnuSM01w9PF7aDhty+42UOz7m1v++Y0
	CkiC2Bhn4UBhQ4TYVrpoZU4d6KSqhacVAg0mg0WzhITYJ3o1lP/E2JYAKIE5wxU82/i2LpF2MiL
	rhhj+MThS9L0yzPJxxRlDy//Db3C46apCP7k3cch+tkmogP5v5FEW4GR+ETzJgWlHuNdQF3ovFR
	/tl64588/wMLMvJMbVh1RxuvyN79oMCAneMjTDshil4EYb4TKqrbvigKrhaq7keLU/
X-Received: by 2002:a17:90b:3847:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-3909d89bd69mr24337522a91.10.1786388691767;
        Mon, 10 Aug 2026 12:04:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.186.238.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5381dd3sm657420a91.16.2026.08.10.12.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:04:50 -0700 (PDT)
Message-Id: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 19:04:48 +0000
Subject: [PATCH] sequencer: release the ODB before spawning git commit
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of 4557f1add261 (rebase--helper: add a builtin helper for interactive
rebases, 2017-02-09), continuing an interactive rebase uses the builtin
sequencer, which spawns `git commit`.

The child may trigger auto-maintenance, which may need to replace files
for which the sequencer still holds resources. See
https://github.com/git-for-windows/git/issues/6315: on Windows, this
produces unlink retry prompts that cannot succeed while the sequencer
waits for the child.

Resources such as file handles or memory mappings must be released
before spawning a command that may run auto-maintenance, as established
by 28d04e1ec197 (run-command: offer to close the object store before
running, 2021-09-09).

Release the sequencer's ODB before spawning `git commit`. The regression
test uses the legacy-delete trick introduced by 69ed0e35a754 (mingw:
optionally use legacy (non-POSIX) delete semantics, 2026-05-07) to
trigger the failure on modern Windows.

Assisted-by: GPT-5.6 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    sequencer: release the ODB before spawning git commit
    
    This fixes https://github.com/git-for-windows/git/issues/6315

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2198%2Fgit-for-windows%2Frebase-release-odb-before-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2198/git-for-windows/rebase-release-odb-before-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2198

 sequencer.c                   |  1 +
 t/t3404-rebase-interactive.sh | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 57855b0066..83952d96e3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1127,6 +1127,7 @@ static int run_git_commit(const char *defmsg,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	cmd.git_cmd = 1;
+	cmd.odb_to_close = the_repository->objects;
 
 	if (is_rebase_i(opts) &&
 	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 58b3bb0c27..8f81c80fd4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -65,6 +65,24 @@ test_expect_success 'setup' '
 	test_commit P fileP
 '
 
+test_expect_success MINGW 'rebase releases object database before committing' '
+	test_when_finished "rm -f .git/hooks/post-commit repacked packs" &&
+	git switch -C repack-rewrite primary &&
+	git repack -ad &&
+	write_script .git/hooks/post-commit <<-\EOF &&
+	git repack -ad &&
+	>repacked
+	EOF
+	(
+		set_fake_editor &&
+		FAKE_LINES="reword 1" GIT_TEST_LEGACY_DELETE=1 \
+			git -c core.commitGraph=false rebase -i HEAD^
+	) &&
+	test_path_is_file repacked &&
+	ls .git/objects/pack/*.pack >packs &&
+	test_line_count = 1 packs
+'
+
 # "exec" commands are run with the user shell by default, but this may
 # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
 # to create a file. Unsetting SHELL avoids such non-portable behavior

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
