Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E321A459
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573559; cv=none; b=rTs9VzruuUpaXoSlUMNgMvN18jX1E3IxvRqknk7vEj62jTfwVqUMsJ2X7ZRMwaVLyHP+UIXjfEe6TaqSPobDcSzMdYkQK4WV/+gxP2+zOE9YWQAjp9HLI8RCDW1Y0bHIyhxUSTGbGpDWiKIkImfisyiSL+hOfTFQDmflXYElmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573559; c=relaxed/simple;
	bh=LnhxmzzH9hJBo2s7PzoHxANt8srpn0rhPluYKlaS5ts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=boXgrL2r4ejzDGWIOCozCrLuw0FSHES0A4kX2b1+xN47yHgCKO1vGtNj0SKOYyTLR2OkNJRDZdy4zsmRpt375OyLN5SqjGzy5s9LXOAoFk3HgnTK5xF/SwWm3E22NCHOF84A4Sfszap1t1Y0ibn4Hrfx+56WkgRCJ5W7dqe2R1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYNY7FQ1; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYNY7FQ1"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ba895adfeaso3570950eec.0
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773573557; x=1774178357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1z4i61+LBWi+Y/gg/3tj5s5ylj03i6DtxiMrzZUlJw=;
        b=GYNY7FQ1JOhLtlK2gcvxwKgOIdNR4Z2ime2lpX6qovyRxN8rMaiBq0c+Gi3Vnfo4BI
         B0ayhFbX4Y+SFmfXL7+AE9vFvypyKkOmimgrNxGNcFonRcBJs2ccIVM+n3qmwHsGlTdU
         bF8P6a8YqyJuVLdkoxaMXDfgFXg6ISbi+GFaK8sAqF8dQ8tN/vo74Yvtv5UovmxEnRyz
         sJgueGnIsMqB5jSZTskvu5IhYHbLSvf9fPr+KlwW5gQKLQbb6Tko5eFFFQg6/Y0py5EZ
         jt7+dPRT4o9lp8LjzI7favVubvNm/LFpOVIXJSvJ01b34r0OOI/uf5dHRZ+bEzxBlETC
         ou5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773573557; x=1774178357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1z4i61+LBWi+Y/gg/3tj5s5ylj03i6DtxiMrzZUlJw=;
        b=pVgzzol3jNRIip09pcjY9Y3qcbMaqxyhR9e9nj30JuZiPDAQ1L16SFgWREh83c384R
         5RThWy993i8MQjzYmugylrvj1WuChkzuMLQGgUfnbAQofTXxtL0cUIBqegv3+CFJfGnG
         RqJZ3HCDKh+9bRJr8US97Oh827S531KQFUnKC7489M1kmB/HklhXH5TK69wKNEsnG05p
         nWPPHKsQtFfA9V/jApDud6B9UU7v1bvQo45+rT2AwIMRC4cemnAJFKdw7ULgWscnmR1Q
         6rLdC9Gb1V9rLlgYRRvuUty1iUpJJLz4wyUIcV28GihJsWLpBINZ0DUm49JU4qNfdFVd
         GQMg==
X-Gm-Message-State: AOJu0YyKI0Iwhv0C9eApPFwdjxYOG6rjP4zXdQJGDxlJShaYLggyb9R1
	jnvX/tnNeJL0eyw7zYRiptZWqML5XZSIK+70cXej1HyWVoyaAlsxLa0sI2HG1w==
X-Gm-Gg: ATEYQzz3Hmgd6fx+76NvR3Br/NxyA9yktx8RhVloW6ekhj5lZ2XdT8YTamXGQrNSfUu
	SYN9ClWH1SKgl+UTxX5EPjxzCVyxDB4XivNb2AcNm5BeGd+5opo3j5c+qH/iZQRek4GbXgCX3G5
	FXW34RRuTv/kAPmXMEMyULt1MQOltEBq9ZsdBeHDUc8ljIb8iFa4tvnqSU4uKvrQHodPhJJsOgx
	f3D7J0oRgD/XPha2/tc+dGKJxmqKCvSSh6QMx8E9wGhwVGhXuKuvT0XCs7tv7hANM8YT+19ZLkQ
	NuBRCOXtNV7w2Mkcs6W9Ld/ciRGlOsME7QtvyccPcPWK5b81a4+yCla+a7koV1ZsxhVs5ASADgC
	BjChVMDbP8nQBTVQFINA8UdSyNISKIR5vr6w+LSMJ0FNKYLcX4sZeu2M1Q6ajsH1o8tLqwW+utF
	+tftLJajjFqB1pKMZ5CdRTIoNeGMk=
X-Received: by 2002:a05:7300:df49:b0:2ba:6854:8d4d with SMTP id 5a478bee46e88-2bea554ad4cmr4315575eec.20.1773573557119;
        Sun, 15 Mar 2026 04:19:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab57588asm10462309eec.31.2026.03.15.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:19:16 -0700 (PDT)
Message-Id: <00d8920498fcc5dff2989f869fdaac2ed9f42d17.1773573553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
References: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
	<pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 11:19:10 +0000
Subject: [PATCH v5 1/4] stash: add --ours-label, --theirs-label, --base-label
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

