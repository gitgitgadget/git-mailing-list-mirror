Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3D3A8CA
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHhmxIEU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28c0565df34so1660940a91.0
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 09:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704819683; x=1705424483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TT7MzCOyqrgP6LOOzCUYhKLhH9zd7if8KoBqRRVYOxY=;
        b=gHhmxIEUWQ4V5R2g4fRzXYic5U/cbnoBF4dU0PbUdjOlAOYW1sqal/pV0QkfHRYqoD
         JlVCOQWmY1Fx7WcYzOHLsz472Zzrh/FvNQE30jkorqcjitaWerhdJxIUuLcZ1m7uE9In
         sOy10MDNYIXyK/631twZ/1W+WFBeBHUlt/8QEhuDlOFk+Jwt3shBH/31/zB6ikrhfjUQ
         dtDXmqtD8iPFayKc4IwtA9s2V7Km3OOhowJJQ7JcmvNQKmIx+DDETieI1LZlLUo9pb0Y
         9V84A7lho3NaRrlK8Wl1b4jFYwYEXXeevCo9JD3kSFbsPafsTRVH2qE5igHOADJQm6Oh
         26bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819683; x=1705424483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT7MzCOyqrgP6LOOzCUYhKLhH9zd7if8KoBqRRVYOxY=;
        b=Ypo7GfVh9/BxKBkuBq8d5yRr/W3Dxk6+djekHCm5d0ypmRmQM/QoqJPMYT5vwdNBm+
         p+YBBzZ37vdbQUTOf9dIsM9sCP47GwoLRLv08e2T66PXXLA3znKabpwL2broDKj3qiKC
         nQxZG2/wCeYNxy5zqPwf41pmIwvhUPuRxRAYO8MmPjOHUOE85IAjVQxZ4bAWWYmaUR/O
         u5qZdi/Z52JwPfgpCFy0CWgQd/LvNTYDfKekKtZyrVuh4GI0Y3TkAxtiaIwtiNTTpTZQ
         yPC2ViDYqL98V+kIaKRll5t94ibdiH3JRlLWYXkkyqyyk9lGp9o0Mws/oD3PLXS12RMO
         +lyA==
X-Gm-Message-State: AOJu0YzLi53rvlelKaTE4jm4bRfQ6RH+JLAudb3xhKYvpsdPnzNBZxnQ
	K+lHy1pQwzEYNWy5SQSbrxzr1uV8g0KSK37Q
X-Google-Smtp-Source: AGHT+IFVGYC9LHJmKtHynUWCS7KZY7IaEqbFWKitT7KJWla/rD8eB8/H7NRFg2SGjB5gKUC62/1QuQ==
X-Received: by 2002:a17:90a:588b:b0:28c:38ef:5b40 with SMTP id j11-20020a17090a588b00b0028c38ef5b40mr2608623pji.90.1704819683041;
        Tue, 09 Jan 2024 09:01:23 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709027c9800b001cca8a01e68sm1985851pll.278.2024.01.09.09.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:01:22 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v2 2/2] t7501: add test for --amend with --signoff
Date: Tue,  9 Jan 2024 22:21:23 +0530
Message-ID: <20240109165304.8027-6-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds test for amending commit to add Signed-off-by
trailer.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
I believe there are many existing tests which already cover almost
all of the scenarios. So in addition to this test, I have also
updated the FIXME comment to remove signoff.

 t/t7501-commit-basic-functionality.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 9325db1f66..376a7d59cc 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,8 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, test reflog,
-# signoff
+# FIXME: Test the various index usages, test reflog
 
 test_description='git commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
@@ -442,6 +441,18 @@ test_expect_success 'amend commit to fix date' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_commit file file content &&
+	git commit --amend --signoff &&
+	test_commit_message HEAD <<-EOF
+	file
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	EOF
+
+'
+
 test_expect_success 'commit mentions forced date in output' '
 	git commit --amend --date=2010-01-02T03:04:05 >output &&
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
-- 
2.43.0

