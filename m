Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A630F7FF
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385030; cv=none; b=SpB1+60XFtLaXh629Ch75Z4vjgXBnZWrfw9qKhGsoHu+LC+4DRsYLvYfGCAwf1qJmBUT9YR8CqehFE++/nG/TLa+knld1KIGglpAhL04lyWew4HJSEQik43fNVNFybAf6lENxC5N+UgjMitSulnKVcr5FjGIr+mVOpSrAfD0DRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385030; c=relaxed/simple;
	bh=7aczUGbjxYkWZjWxMcnezu2mvRDAIHrcnDDS+a0ALP8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=LJdYXc4hDtdPr29SjAYzj5QHRxAHAy3jVylUMXZzs1hWSV6tGOsXx90DVD7s8va/EmM2z1vIM3H70My3PcqN4kLIBsSH6ufWz3JHDIQ+HlToYpT2SDSF9VFBEUm/71Bu+MggmMoJXU6kdCVNSWx3a4OooQ/V602etQ4898atoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9QYzrPh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9QYzrPh"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-88432cc7e74so3920639f.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 05:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756385027; x=1756989827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q71jxHLGEVBgVkzImaF84atXJ+7mkyuttKG4TtVa6oA=;
        b=P9QYzrPhGrdiZtVqtGKwAV+Yov6N0d2tLQ8N7CL6jacc930bjN5qTsD40+lSOtrAjs
         kztXLTl42jTG0LxQ6ox6/HPNQuMm/oisd9inLHBRY74IcdFGyEMjdWR4+cXvjDZS+j5a
         3cqDWZVYzO9whmOXl3H+7uvp85SHDInuXR59xflmGK6Hxeo6aFClVwAL0swq1WbY6teg
         ipLO+ZfSGpSBIQskgGZPTXjYrpdyJHKZ+evaHZS0P06X27XtC5HoPztf3aCtSkJSaXmP
         RTrqCwXiiUDzzkyKCuXjG1vXaCO0olGsXzO3JOe4ThuBB74+eMF32bcBVHErfGO0/tNN
         YpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385027; x=1756989827;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q71jxHLGEVBgVkzImaF84atXJ+7mkyuttKG4TtVa6oA=;
        b=fwIGwhPpJsPrciTjeP0fPYQmQ0uJ0RcZ1bh1UtlWc/guFg/cn9BfO21Q+9lujHKJ4X
         7ZjaetPGS5uZvEdlqfocyjBEgb43BKyqfxS/Bicvuhr2vhXuTAyP8mL8aaN/U3zjQ++X
         FZbkG614lw5yl8ktmGGXMMr5r+9V1oyKJxUaMOt1dOUz6NjRE3+oEkeZgsCnHIK65qge
         p24TiKRJKdBkiEz0CRjGxtbZe898xuXxaqXLva0DBmC9dfFedry5Y1uYFPLDmS4Pm1JA
         ZzQFDsVE1yrMg84zLneUx3MuVwT6emPR8yb6ZbSqJJRX2TISxjoFgb9QpXNEP5BceZpL
         pTSQ==
X-Gm-Message-State: AOJu0YxaYf8A7c0/RzJoxL0ueTCJSXn8kaBcOtiuxotZF780Clfx8BOp
	pOBemuINHoJGZH6Ey3oUiIdJnaVM8F4Ioq5mGYjzMWXDUUjvCksgY3vbohCeoA==
X-Gm-Gg: ASbGncs9TQTwwAbzgm7PyyMev5uOPF6t1FncEThtqBIpGBKxaf6eh4xBg7xJIFDBEe7
	IzgFbFCQBU2psadAzYkeLi5yjVWrZ+8L+1EY+bX+heS7V51/+TLs5OVZssivqLKUS7rjJm60sIi
	bs4esc2o1oY++Nor/e1xvlPUnDdU1/9Qp4QxBs4As6B4jmZf2QpfoYXoVdVClthV4BA5I7lc+Xa
	WsY/TxMPw2Xe3wIjzqukr0j+HZije6zTPPMhHAzc4ahK8kDw6AVtDLZAb8cWb0Y1Pk9RtuT+LZO
	W5Hdmo6LBnGqcs+W6FR4i2fpnxUgmPRawPgX/D6D6dkNJvkqV6zgRno5IoLP16PC0IW4Ya2ZCpD
	Zf3gkTKpblZhN3kccspmZyai1rTf2rClr7sAIoLlSPQ==
X-Google-Smtp-Source: AGHT+IEVI874+fJg4vRtOh1KXyHYcopyIoEx8SAux9GyxZKimajoW+Yujd3ztfE8A+HXYLXi9w5G+Q==
X-Received: by 2002:a05:6e02:1648:b0:3f0:fc6b:4e02 with SMTP id e9e14a558f8ab-3f0fc6b501fmr51614025ab.15.1756385027255;
        Thu, 28 Aug 2025 05:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.163.233])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f0693d885esm25988335ab.38.2025.08.28.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:43:46 -0700 (PDT)
Message-Id: <pull.2041.git.git.1756385026051.gitgitgadget@gmail.com>
From: "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 12:43:46 +0000
Subject: [PATCH/RFC] submodule: gracefully handle links in module paths
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
    Julian Prein <julian@druck.dev>,
    Julian Prein <julian@druck.dev>

From: Julian Prein <julian@druck.dev>

Due to security concerns the commit e8d060894448 (submodule: require the
submodule path to contain directories only, 2024-03-26) introduced some
checks and hard `exit(128)` calls for the case that a submodule path
contains symbolic links. This change was motivated by CVE-2024-32002,
which was discovered shortly before. Consequently, git currently aborts
actions of which some could be continued by not processing the faulty
module.

As an example, one of these actions that may be aborted is showing a
diff with diff.submodule set to `log` or `diff`: Let's assume a
repository where a submodule was moved and its old path replaced with a
symlink pointing to the new location. A git-show on an older commit from
before the move that also touches the module will now have only partial
output. If the submodule is the first file to list, there will be no
diff at all after the commit message. Other examples for actions that
are aborted after already being started are fetching and pushing with
their respective recurseSubmodules turned on.

Handle these cases more gracefully by returning an error value instead
of dying, if possible. This was done only in functions that already
supported returning an error.

With this change the mentioned git-show will display the full diff and
show a "(commits not present)" for the submodule - the same is done
currently when a submodule is simply moved. The fetch and push will
complete their action while skipping the faulty module and printing an
error message.

Signed-off-by: Julian Prein <julian@druck.dev>
---
    submodule: gracefully handle links in module paths
    
    Hello,
    
    I'm submitting this patch primarily to fix the issue described with
    diff.submodule. I maintain a repository in which this kind of move
    occurred, and I have diff.submodule set to log. With current git I can't
    properly display some older commits. Changing submodule_to_gitdir would
    be sufficient to address this, but I noticed more places doing the same
    thing (exit(128) even though an error value could be returned), so I
    changed these as well.
    
    Since this is security-relevant, and I'm not very familiar with the
    codebase, I probably lack the foresight to foresee all consequences of
    this change. For this reason, I'm submitting this as an RFC and without
    any tests for now. If you deem this patch reasonable, I'd be happy to
    write tests and add them to a future version.
    
    Thanks,
    
    Julian

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2041%2Fdruckdev%2Fpr2041-graceful-submodule-links-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2041/druckdev/pr2041-graceful-submodule-links-v1
Pull-Request: https://github.com/git/git/pull/2041

 submodule.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index fff3c75570..843ec48339 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,7 +1127,7 @@ static int push_submodule(const char *path,
 			  int dry_run)
 {
 	if (validate_submodule_path(path) < 0)
-		exit(128);
+		return 0;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
@@ -1514,10 +1514,19 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 {
 	struct fetch_task *task;
 
-	CALLOC_ARRAY(task, 1);
+	if (validate_submodule_path(path) < 0) {
+		// Add submodule path to the list of submodules with errors.
+		// validate_submodule_path already printed an error message, but
+		// it would be confusing if the submodule wouldn't be listed
+		// together with other erroneous modules at the end.
+		//
+		// NEEDSWORK: name instead of path would be nice
+		spf->result = 1;
+		strbuf_addf(&spf->submodules_with_errors, "\t%s\n", path);
+		return NULL;
+	}
 
-	if (validate_submodule_path(path) < 0)
-		exit(128);
+	CALLOC_ARRAY(task, 1);
 
 	task->sub = submodule_from_path(spf->r, treeish_name, path);
 
@@ -1999,8 +2008,12 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	struct strbuf buf = STRBUF_INIT;
 	int ret = 0;
 
-	if (validate_submodule_path(path) < 0)
-		exit(128);
+	if (validate_submodule_path(path) < 0) {
+		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
+			die(NULL);
+		ret = -1;
+		goto out;
+	}
 
 	if (!file_exists(path) || is_empty_dir(path))
 		return 0;
@@ -2555,7 +2568,7 @@ int submodule_to_gitdir(struct repository *repo,
 	int ret = 0;
 
 	if (validate_submodule_path(submodule) < 0)
-		exit(128);
+		return -1;
 
 	strbuf_reset(buf);
 	strbuf_addstr(buf, submodule);

base-commit: f814da676ae46aac5be0a98b99373a76dee6cedb
-- 
gitgitgadget
