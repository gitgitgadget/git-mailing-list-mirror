Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8297C1BFE18
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 07:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728370899; cv=none; b=cuPyVK6W32Ch0TtNflY6qO1ut0Du/FRU6eD1hziPrykT4b2DRwwbo+xYyjbUD46dmfpzw6XN6JVYXf6CcZe4kDoUY8Uvfojwou+iLSJeD+DxEhFtipYbwpBCQhecg0VyGH6kE4RHaEh+zqXhVpKIhieeNBaKrKflMfNSCz41c+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728370899; c=relaxed/simple;
	bh=qBB6Ihw5wgA3K6iBHMyTEEL/GCwC+Qkrk5gize6OMO8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=jvw6q3TaASqxRXIMcnXMDcNDGSl/o5SYhiFAe3Gak1V9Xu3Bh181kuvpTnmXRXvTKSpq03YX/YK91LAwvni8KRysznAZazgc3UuXEGiDhp1EBfUfIfhuJyXeX+lk5A2BH40geSs+88e7hQ86OF74fuB/FNZk80aSmaD5W9UAKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcI9e6tA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcI9e6tA"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398df2c871so5545474e87.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728370894; x=1728975694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QtbMuQLlU+EphKCaNNR1W7BFH6sc/FzCXQM8VZ97kMA=;
        b=QcI9e6tAsFd52Iaeebm4D4dE9ohVqIIQSHryL+e19aPSqeOw914ATWZWeKeMB/v0Ht
         UjgEwuFTUVOps7F073pxMCS/ls6Zu66Vufmum0GY3vDmHYIkTvV0ZXlBFQAsU4nXXZRg
         H84s6UUp+bIlGoKjV7+BH8YNNE8mqXCbn7kVK/VDhT25D04BN+SnfwpO9Y0r0b2LW8t4
         Dm32tDo70XwTnBPMLSSpIMk4+Us6bMnP45+36yjjXw9YHfUXtrd83Xg2zYgYiyhEyrTn
         DeDzDVSGOrro+MTtKGw6wCUqAKNTwlw7nOhJLcdK2snnKgKJlChMyuQJD/JXQld+hUIb
         J1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728370894; x=1728975694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QtbMuQLlU+EphKCaNNR1W7BFH6sc/FzCXQM8VZ97kMA=;
        b=dVhpRqOF7jtdUIp0YqmTAd2Ea8Q830BOgW34H1XRIY8mqL5ogrsMrO4Qhqx3AlU9zu
         zZELXcgz2mBKtKLs35w3ajg8vK4KP1jQCVC5yD7/yiz2OWw2ar5h9Vb/SJIxjFcn42pm
         4crGEm3yqQ7D4CtAOoZMWqEpOM7Vp1Sjxo4Z4qXPUq4i+2UTRZAyRyIgSr2EJeBrEBox
         xRe1n9mcOF6t/FNJtFswpLqjnd4inGEpoZoooEQK6XWVBRRLdNccCYtsnAOgsnZMot4y
         A72uwEzUpfCt/XSvECQtrOiBbFcFtgb3W8f5icCtMJGlpLzbkzVuHfZxNflNHDDKA44q
         DLHw==
X-Gm-Message-State: AOJu0YxjtUDZ+WKLBULZd2K5nfZQUXpTGbN4H+xlNkmd/9urcd4bpOor
	BYCBUn/ghii5lq7IfzqP1c8o28v5Mv004gofVXp2QH0IMikPnFmjYv4rHw==
X-Google-Smtp-Source: AGHT+IF+3yswh52vD/d00jrTaX/kjLQizXyfLXsOoM4TDcpb5BbG5Oxe2yveghAqUCV4nQBCHkHXsw==
X-Received: by 2002:a05:6512:15a8:b0:52c:8a12:3d3b with SMTP id 2adb3069b0e04-539ab9c6f26mr6353813e87.56.1728370893749;
        Tue, 08 Oct 2024 00:01:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd3a5sm3957188a12.41.2024.10.08.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:01:33 -0700 (PDT)
Message-Id: <pull.1809.git.1728370892696.gitgitgadget@gmail.com>
From: "Abhijeetsingh Meena via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 07:01:32 +0000
Subject: [PATCH] blame: respect .git-blame-ignore-revs automatically
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
Cc: Abhijeetsingh Meena <abhijeetsingh.github@gmail.com>,
    Abhijeetsingh Meena <abhijeet040403@gmail.com>

From: Abhijeetsingh Meena <abhijeet040403@gmail.com>

Modify `git blame` to automatically respect a `.git-blame-ignore-revs`
file if it exists in the repository. This file is used by many projects
to ignore non-functional changes, such as reformatting or large-scale
refactoring, when generating blame information.

Before this change, users had to manually specify the file with the
`--ignore-revs-file` option. This update streamlines the process by
automatically detecting the `.git-blame-ignore-revs` file, reducing
manual effort.

This change aligns with the standardized practice in many repositories
and simplifies the workflow for users.

Signed-off-by: Abhijeetsingh Meena <abhijeet040403@gmail.com>
---
    blame: respect .git-blame-ignore-revs automatically
    
    
    Introduction
    ============
    
    Hi, I'm Abhijeet (Ethan0456), and this is my first contribution to the
    Git project. I currently work as an ML Engineer at an early-stage
    startup, and I’m excited to contribute to this open-source project.
    
    
    Why the Change?
    ===============
    
    I came across this enhancement request on the bug tracker and found it
    beginner-friendly, making it a great opportunity for me to get familiar
    with the Git codebase. The ability for git blame to automatically
    respect the .git-blame-ignore-revs file is something that can streamline
    workflows for many users, and I felt it would be a valuable addition.
    
    
    Feedback
    ========
    
    While I’m confident in the changes made to builtin/blame.c and the new
    test case in t/t8015-blame-ignore-revs.sh, I welcome any feedback or
    suggestions to improve both my code and approach. I’m eager to learn
    from the community and improve where needed.
    
    
    Community Need
    ==============
    
    There is precedent for this functionality in other projects:
    
     * Chromium
       [https://chromium.googlesource.com/chromium/src.git/+/f0596779e57f46fccb115a0fd65f0305894e3031/.git-blame-ignore-revs],
       which powers many popular browsers, uses .git-blame-ignore-revs to
       simplify the blame process by ignoring non-functional changes.
     * Rob Allen's blog post
       [https://akrabat.com/ignoring-revisions-with-git-blame/] discusses
       the need for ignoring revisions with git blame, and a commenter
       specifically suggests that it would be helpful if Git automatically
       respected .git-blame-ignore-revs.
    
    I hope this change aligns with community needs and improves the git
    blame experience for users.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1809%2FEthan0456%2Fblame-auto-ignore-revs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1809/Ethan0456/blame-auto-ignore-revs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1809

 builtin/blame.c                      |  8 ++++++++
 t/t8015-blame-default-ignore-revs.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100755 t/t8015-blame-default-ignore-revs.sh

diff --git a/builtin/blame.c b/builtin/blame.c
index e407a22da3b..1eddabaf60f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1105,6 +1105,14 @@ parse_done:
 		add_pending_object(&revs, &head_commit->object, "HEAD");
 	}
 
+	/*
+	* By default, add .git-blame-ignore-revs to the list of files
+	* containing revisions to ignore if it exists.
+	*/
+	if (access(".git-blame-ignore-revs", F_OK) == 0) {
+		string_list_append(&ignore_revs_file_list, ".git-blame-ignore-revs");
+	}
+
 	init_scoreboard(&sb);
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
diff --git a/t/t8015-blame-default-ignore-revs.sh b/t/t8015-blame-default-ignore-revs.sh
new file mode 100755
index 00000000000..84e1a9e87e6
--- /dev/null
+++ b/t/t8015-blame-default-ignore-revs.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description='default revisions to ignore when blaming'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'blame: default-ignore-revs-file' '
+    test_commit first-commit hello.txt hello &&
+
+    echo world >>hello.txt &&
+    test_commit second-commit hello.txt &&
+
+    sed "1s/hello/hi/" <hello.txt > hello.txt.tmp &&
+    mv hello.txt.tmp hello.txt &&
+    test_commit third-commit hello.txt &&
+
+    git rev-parse HEAD >ignored-file &&
+    git blame --ignore-revs-file=ignored-file hello.txt >expect &&
+    git rev-parse HEAD >.git-blame-ignore-revs &&
+    git blame hello.txt >actual &&
+
+    test_cmp expect actual
+'
+
+test_done
\ No newline at end of file

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget
