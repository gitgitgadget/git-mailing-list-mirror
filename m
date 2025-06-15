Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE2A3207
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749998816; cv=none; b=e51sn+fQdaziJAzOQ9aVl+djv8jAqmuzMtQFgDR/z4pe1hc6JNbCj4OP6maCBcurZUFJ9y5euNTK2U5l66fEqVNeJHHSwebJkLzXkZlr5U+uXHj1WfC0KT5m2+uyssTqh5TznXAsc+kAl1sIb9Ro+JW6uOqzpXZl7gWsENXdM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749998816; c=relaxed/simple;
	bh=JziBInJxydSVEzENq/ZuHvAtdGNjYeGePEmEiCk63PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWOVO3/iF7koPP8WAJwnUJvUembUyg9yyeU8598Mm9Ynzv6Q/t1WM7At4Xa8cnv+Wf8J2KrjCtK3yminrA+osRpTYBbKP/oANyMYAc2Bc9xMdJ3VcyxrmYr5ln4E24W2tnjxJeNIDjSczxSWqlTymFC8gwPVZCOUt/a1pSlIUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqUyAOM9; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqUyAOM9"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso2826439b3a.2
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749998813; x=1750603613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c90U1AjcYu5TdOu7MSjzHR/Nmwcr4Pk3GJ3Yc4f18zM=;
        b=gqUyAOM9bH9I8VftJDL/tamBBQw9pEClJK+O/VDwG2RlBJ524Vn1m1dsdGB5a0IQtR
         pm5WyXLrkLHmP0nICGnEtq9fPXAZCiV5AxfMeAyr/ZmAVMj7PplkqmG0z5Th/TF9Lfb6
         JtluhFtysudy2HzIhWrVmzYN/wFM+f5YzHHyDBxRkqUnA+iG8Bk1uFw4X2V4Kh5Z+Ygv
         z7YDy1FiYOCC+PyCrEEON63AHSq/iX1Nb1D58z9Rw4B20zkZIDhVMRBakIh/k4iniAjA
         PXG0UBKi+/9qZvbVSG5rBcM6CrlCvV1yy4bITqr/EBCHIoKcEJGpt8iDQx2OOYXjvFKo
         HK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749998813; x=1750603613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c90U1AjcYu5TdOu7MSjzHR/Nmwcr4Pk3GJ3Yc4f18zM=;
        b=v0Niud75OdpCyn86nKsN5RkFtJaTfpFo6heJW9w9k24+DwVz/68dSPaAo+Hw6EicV8
         fsR+oJx19qRHkcZwgPqRVUYCup6M9leSzWwN8VQ6/W45xxz50DjN/RlPfgTxa0IazVOS
         8FHYL7myZ8cadIx4PZzzHPnu/XWymjCRl3e+imH4/xNVxo6hog4zUxC1Uwe2xX9u/xPg
         uqesLYFaD3jZn3FkBBd2lhaJjxQUeY3xdAHBOeLOP3n8P2q4Et2IMbu6PQu9abhnviRW
         OYPG+SY8SRbYejh4KvZX7V1YSz8DLDnUl1Dluu4xqjQaBMXJPCCfsrp6MAWrkmcwUAS7
         VUIw==
X-Gm-Message-State: AOJu0YxrHj6DA8J8XYXVe1ZJxm3FkU3fKu7HH2RbS5Q9BlrGqBQ6fLE1
	pSI3e5U3WxNkDEN2JvZvTVOHaCyumuMhpmzy/D1jDrbUny95mAl57GcxVNXDBcWWVuMW7MQt
X-Gm-Gg: ASbGncv5HSrrNc+tFdXrfxHKdte3eCoHRHF5T8AfWlH+XmVYLhF8sBDEP+buSFt+Ped
	7+WqlO5tDa6OUn0//j9LEwQIESBJp+jZ+evHELtKWiAMY+0cxzRfyFPrq9kfAkSv04+MLXh5oj1
	2+8/KTSCh6ORnxC4UenAVql5uuao7Z4TPvfgpUxMMttySsC21ISEce6k1nanTSfXJQio/mDMLN+
	eGa+WvussJauuxVS1HqcRLz1jRqsp2/vMbdnzY7fJIL8RmyeUH2G31JTtydUS4iO4qyWj9Ocy3J
	Mn1BGIXgkdF75KuuHwKxj8F+ZUYwk4WlZ8P7CLOe0np1WD2DqgE3361QAMQ83PBug8UtLjqNJaK
	xenc=
X-Google-Smtp-Source: AGHT+IGrRFqaaEf/FTl6uJ9FxLz/vFz9bAPp3hoz1bsF5L/lzHZHFaurnuumFVnbrpnybtG+RPGC/A==
X-Received: by 2002:a05:6a00:4646:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-7489cdedcfamr8469496b3a.3.1749998813159;
        Sun, 15 Jun 2025 07:46:53 -0700 (PDT)
Received: from r760 ([188.253.126.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm4950180b3a.20.2025.06.15.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 07:46:52 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: [PATCH v3 1/2] git.c: remove the_repository dependence in run_builtin()
Date: Sun, 15 Jun 2025 22:46:03 +0800
Message-ID: <20250615144604.1447302-2-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0-rc1
In-Reply-To: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
References: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
 <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_builtin() takes a repo parameter, so the use of the_repository
is no longer necessary. Removed the usage of the_repository.

The comment preceding trace_repo_setup() was originally introduced
in commit a9ca8a85. Since get_git_dir() modifies global variables
such as git_dir and git_objects_dir which only valid when inside a git
repository. The intention of the comment was to emphasize that
get_git_dir() should not be called before confirming that the current
directory is indeed part of a git repository. However, get_git_dir()
has been renamed to repo_get_git_dir() in commit 246deeac. And later
in commit 73f192c9, repo_get_git_dir() stoped calling setup_get_env()
anymore. Rewrite origin comment message.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 git.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 77c4359522..7fa81dde18 100644
--- a/git.c
+++ b/git.c
@@ -462,12 +462,12 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	precompose_argv_prefix(argc, argv, NULL);
 	if (use_pager == -1 && run_setup &&
 		!(p->option & DELAY_PAGER_CONFIG))
-		use_pager = check_pager_config(the_repository, p->cmd);
+		use_pager = check_pager_config(repo, p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
 	if (run_setup && startup_info->have_repository)
-		/* get_git_dir() may set up repo, avoid that */
-		trace_repo_setup(the_repository);
+		/* avoid repo_get_git_dir(), repo must be set up */
+		trace_repo_setup(repo);
 	commit_pager_choice();
 
 	if (!help && p->option & NEED_WORK_TREE)
-- 
2.50.0-rc1

