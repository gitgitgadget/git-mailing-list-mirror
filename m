Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8A21B8F6
	for <git@vger.kernel.org>; Fri, 18 Apr 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745002745; cv=none; b=Og2DmStcNcZ30Dr2oImtTxOXE6k1CxVDt8k8OAY/RG0zGcySd66LgrotICq6qsVCydb14b7aBW9wAPoTbF65NtJ3g0Y8sVwLRk2oHB5J1IwAWpPOPim73z7KGzFJxCl03p61wERbZZZ/2YazqJbNXLp2v/8tEF9Yx3evVY6wePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745002745; c=relaxed/simple;
	bh=SFPYWepFuGcunDc/wYdsVlXDemyeW6/I6BoghmFIywo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yf/y3KzDivaF9VbIYp1qEz/u1vP9OYnpyfhXlJlnEgugO52ObUjq4ZPJtPSn4VcltQVNl5Ud558POaqOAi/tEetjcJ8bmPCGUZ/k9eLIAMhDu2inwrHfUrYOc2LTwzwXg2nWdE3aET9Fzs7ID2fVdeGDDG4d8CWBwW4+9RiTzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adK6Q/eY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adK6Q/eY"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22622ddcc35so32988145ad.2
        for <git@vger.kernel.org>; Fri, 18 Apr 2025 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745002743; x=1745607543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9H06ASHFfj+/Y8Aj0cB76kJm+MLkOXvd2aIfCP7Nzow=;
        b=adK6Q/eYTV0bp2M7FZq0VBA5b6Mk94s1GTqW5ZwVjz/Tr78lDIFYDT2oReo7o40um9
         H/kJJlxj1E105zerHs0TlnN1e6BUCfSYs9+nyDRRz4t7TD5RAT+WhD0e4qwT3QyhWt1y
         aH3w95F/JOOCDcplyPES+sm5KHxMJ90cRjZjo72DgCl7YONfl576C3JQHqP62Xoe+SVO
         v5LyHxdllZ3k2GQUcLlZdLVdaYw88TluyTqDIcRH7SYCDnxWYRSXrTduSVMmM1wdr4Jo
         7xOGdKnep1ufvD85FNWbfEn7v8vn2rY8bkuhNyXQy2H+02+JKPhRMd8dNaya9+Ba6PRf
         7qNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745002743; x=1745607543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H06ASHFfj+/Y8Aj0cB76kJm+MLkOXvd2aIfCP7Nzow=;
        b=f+4xLsOMKnOOEAqTi56Za3WnpSyPHPGoKYuMM9cNfTUDEzFYfn/uecoEBeJTChtH/k
         lz5eisdvHZIoWDsNTQujGn7J/EoW9Ui1LCzYO4DsI169lRP26Vuxf7MXB/TeFeGOKo4y
         7ix/5622SUUKQUAXpJuW9PMksTi2BDAdUvLEyfrn53PYXD7t2q9I4A9UgNbRIy3addGu
         LWuqR+WZ8XstEBtXW2ITuNC/ZZnK+81v7sn0djPnVU65oBs3YCRKwlMNH4D9olG2JDcX
         W1tfT3lH9M9ohAa7zzP08tRhuVmPV5GGmoY/KQene4y0/qZ4IxL6mUFSdLbIcK7awpbX
         ZsYw==
X-Gm-Message-State: AOJu0YwGz3ZJVfA8kTTy5R+eQkdvjIbkqLnHOrm5nJs+U2zu3p9JVW7p
	d1Euz2dWFNG+Si3b6eAiyo0fl2L7aoh76L0qxUYdnYeUESze07izLBjF1WNt
X-Gm-Gg: ASbGncsuO78upTyBmbdQ16kAMZEBX1ndCJLSTaR15XU0o+LIZpcwV3ygp/Nk6Yi+L46
	cipeqJiRk++viY3wHmJeJVfVoPNpCuvTzxVGt1Dw1tXehKpVW9MFrT30G+FN1txjal0QE3OCRpU
	r6Km4gu9BooBSJknBfm3WgOE+nyGrCzFEIynARVfWAZU/w1RjCBEH1FLc3x7adKwikYqo29TyKM
	S5p8cwsha/oXrPamwHDcBAEnZD0QXZvMG5YGbyueyauqHdKVAWJz6+AuSS3ybtLuDQYh/87f8Qf
	ulTW6SOu+vgRwRSAHfjF/ndo93g+PqFgP5xbfqGstUH/9o31gQ5u1WKx
X-Google-Smtp-Source: AGHT+IFVEgi8vCi+n9noFtxgV6onOk2MYRG0UXMSHrMqlEdyTrE5tNYhfAN8cfD5P8qC3Qn2OTSpYQ==
X-Received: by 2002:a17:902:d4cd:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22c5364235fmr48754235ad.45.1745002743042;
        Fri, 18 Apr 2025 11:59:03 -0700 (PDT)
Received: from localhost.localdomain ([157.119.45.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdb365sm20402635ad.19.2025.04.18.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 11:59:02 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
X-Google-Original-From: Abhijeet Sonar <abhijeet.nkt@gmaiil.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Subject: [PATCH] environment: fix typo: 'setup_git_directory_gently'
Date: Sat, 19 Apr 2025 00:28:48 +0530
Message-ID: <20250418185855.52950-1-abhijeet.nkt@gmaiil.com>
X-Mailer: git-send-email 2.49.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhijeet Sonar <abhijeet.nkt@gmail.com>

Above the declaration of git_work_tree_cfg, we have:

  /* This is set by setup_git_dir_gently() and/or git_default_config() */
  char *git_work_tree_cfg;

It can be verified that there is no function called
'setup_git_dir_gently' by running grep on the codebase:

  $ grep -R setup_git_dir_gently .
  ./environment.c:/* This is set by setup_git_dir_gently() and/or git_default_config() */

The comment, introduced in e90fdc39b6 (Clean up work-tree handling), is
the only occurrence of the name 'setup_git_dir_gently'.

It probably meant 'setup_git_directory_gently' as that is a name of a
real function in setup.c. Correct it.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 environment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index 3c32367c28..970a407753 100644
--- a/environment.c
+++ b/environment.c
@@ -106,7 +106,7 @@ int auto_comment_line_char;
 /* Parallel index stat data preload? */
 int core_preload_index = 1;
 
-/* This is set by setup_git_dir_gently() and/or git_default_config() */
+/* This is set by setup_git_directory_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
 /*
-- 
2.49.0-rc0

