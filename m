Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7F371072
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740144; cv=none; b=LmehWFNtIIYm2nxeEuWv7GX7xaIOTTMv21sCGV0FbeK5AzVMmlQyXvsD0HrFeTvi9t9JbHln4qao7k2X+P/elvjbfpIS3hrXugxv154wZYjJVNkUWMu1DX40Hvix6o5CPOroTcnVvaVPClt7jvyFubNoayyVY8xjlIwYdsn5vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740144; c=relaxed/simple;
	bh=LnhxmzzH9hJBo2s7PzoHxANt8srpn0rhPluYKlaS5ts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ayqWblikYLH3ToI+zqvoK47Q221DYTL1qC5wN4cPrMcda8pACvg98G0cZ1S8BBn57ML9/gVOGyfXgLbdM+bbD62tTi7XeC3paH6y0zAz8PREnfNJ/nDdAUUpc8RnapI0GgcqFqKoBKKYWjSW3xnuFLYtiLQj7OggSxNEByI4uY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GacMven8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GacMven8"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0603ee486so9732995ad.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740142; x=1774344942; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1z4i61+LBWi+Y/gg/3tj5s5ylj03i6DtxiMrzZUlJw=;
        b=GacMven8pksye719/aEeFmhBaamRaAHSFlANb57c3F7kBfkYFY1bdu35KFZXdLMJlI
         gTd5wyBRCCd5ZPDqAd1xl79j3Jcg7x+TAiOTkicELMyD7gr5HpcwvKcYbkzDzYiIQfXB
         V7EVmZ6LxLnko7qFO1gEogfDl90pRli/yEEWoE4A6XtvhN4EZK8bKUiJe3cK87MjG6Lx
         y1VTqMzUL4x88Yu+uP+erWoWHndQETRNjJyiJ5EvErGnZ9SwDNf6tinR82jbBJd9nSm0
         /Y2x1lZrwqsm27rk0NNRlxZ2kvBcEHzut3HweuCtGHXkiyI471N5QHHKue86tItZLCDz
         fR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740142; x=1774344942;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1z4i61+LBWi+Y/gg/3tj5s5ylj03i6DtxiMrzZUlJw=;
        b=D0icbq6KGcQQF3P8g2Tv3+L2fzGm6NECCjTFsuxCOlqqn0sZhdCS4ipy9obh7w87FQ
         QfzMaQZINsqN4AgYb3xB9ixWM3EU9mwgo3VBD1Ht8GCNVWVhQQ9s8scAfigYY6rWnlTa
         tdkyTeBKqi93/GLfEoUArO5D888tKSLRioYbJVcKEbtDhkY0mOeGwqb6tP3RbaJM3gA5
         mEtu4Wfl2x4s0E0qMqfOpxLKZPrnotlFnfAFHV06ol9l214UMzvQyWoGcWk16d4Uwttt
         CAAdbL+VxFBmpZTltk7l3L9QTijombqCJzmeFywiO9YRAUl3U+VCaWaNrrYnep/RbwSg
         ikCw==
X-Gm-Message-State: AOJu0YxhcOamEhHrBlCl9dKPTJY42fGiCd7/IeNGNKqNz/xlu2y+pd0G
	SaITAWLYzlJaO7zlc6viyyryNqq9srhe9xCVlzFkOw3RX5Gjx0U/IK5Ur7Y+wA==
X-Gm-Gg: ATEYQzwJ7isrP/A3fDSmsFZY0k2YdcpZBK7T9gzuvtvBna2ZVExCKX/6CaiVUbac4A6
	yxfdwGx3S/H5gzlVu9NvIij+H8GaigcugUQYpJ/JMMU2INFCcNqnwk4TKSUM0F0ylzHrQT39qYg
	BalFcg2TFkZ2B6Ej+CpsqcerwRiUyFzNr0GIltfuY7v0Q8u5+oD74MJk6+YRbJBEvuAFF4rHsy7
	23lBnjVmdAQydzWj6ktOv/Q8F1jzlyTGC/0wZVei4VG5QryOw+04qInP62X2z9iyEk+zt8fWwT5
	dAKhx/e3TiIeZ8R9jA7Lv45a6fVwFrOerEb8+oM1jC8EnhYOn43/ww4okyCQErAzPrh4IxAgf71
	esMNUZGES+imkFn8FxR+qqBkPvZJtU9npqiAZwqDzWUwze/rnGSH/3OMvsP82RQ0CEU+2X1ztGb
	YwjvFpSYui4sh4oZWVKgHFnLL3t7yPiYe5Yg==
X-Received: by 2002:a17:902:ea0f:b0:2b0:6323:1739 with SMTP id d9443c01a7336-2b063231bc0mr32318795ad.41.1773740142093;
        Tue, 17 Mar 2026 02:35:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.3.221.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cde9sm161640365ad.15.2026.03.17.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:35:41 -0700 (PDT)
Message-Id: <cd9c64ba60ef72accafc779438db816fd0abbf27.1773740139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
References: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
	<pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 09:35:36 +0000
Subject: [PATCH v6 1/4] stash: add --ours-label, --theirs-label, --base-label
 for apply
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Allow callers of "git stash apply" to pass custom labels for conflict
markers instead of the default "Updated upstream" and "Stashed changes".
Document the new options and add a test.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc | 11 ++++++++++-
 builtin/stash.c              |  2 +-
 t/t3903-stash.sh             | 18 ++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..43650a3c1a 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -12,7 +12,7 @@ git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
-git stash apply [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
@@ -197,6 +197,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
+`--ours-label=<label>`::
+`--theirs-label=<label>`::
+`--base-label=<label>`::
+	These options are only valid for the `apply` command.
++
+Use the given labels in conflict markers instead of the default
+"Updated upstream", "Stashed changes", and "Stash base".
+`--base-label` only has an effect with merge.conflictStyle=diff3.
+
 `-k`::
 `--keep-index`::
 `--no-keep-index`::
diff --git a/builtin/stash.c b/builtin/stash.c
index e79d612e57..252e4df3a9 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -44,7 +44,7 @@
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..dd47c1322a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,24 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git init conflict_labels &&
+	(
+		cd conflict_labels &&
+		echo base >file &&
+		git add file &&
+		git commit -m base &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		echo upstream >file &&
+		git add file &&
+		git commit -m upstream &&
+		test_must_fail git stash apply --ours-label=UP --theirs-label=STASH &&
+		grep "^<<<<<<< UP" file &&
+		grep "^>>>>>>> STASH" file
+	)
+'
+
 test_expect_success 'stash create reports a locked index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
gitgitgadget

