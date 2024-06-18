Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142B13A272
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698716; cv=none; b=jw4InFVi/fYGFnzWkEFOYIgzDuS+onaNgQBPCIOA5JVH3G6qTsTLYTLeLp57OKKY+65lM8IwfDrvd+ajl9VReLw0WD3gsw57h1dU/t9ZftwN0XllGVXEKLDGxvmT9uL34v6/Kv4vjAOR0c9xXUqSaPjKBFLvhtXUV+tMRxFLZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698716; c=relaxed/simple;
	bh=FCEIirvyWI9fSrdamnTUFyP+fki2xypFIo94MXQtpjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hZKz7p9tmeXMT3sBjd7cULrCmr9QHwVauCzOMmRZM7r7ILGVlRxiRPUEfTqaYry8j1OtYcSoDw8fa2PMAQFcSsY3TzXq4sQnkqeWo7wGL61DIybM/ysmIYcI4cqFWo7sPcYwvY2P7K9E9HanrmcyWLN7hi4MsIsa6AnqO6xKuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gub4S8Db; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gub4S8Db"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70346ae2c43so2385893a12.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718698713; x=1719303513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mi/YS2+xeYSf/7U/MQSUxtW0c0qSIfyJZyjsPey06l8=;
        b=gub4S8DbAmazIoxiR8OpfpQRZ/xYb6dybZ4n4wzbVZ/2phTUbP+LNoQ7A33uC22oz/
         7569y9nkaXh61mk+hdtb6VIfW85+weunMnxO+55xi/TxpZTdwwdN/Xxm///gCEE6psd0
         9krt03TwvqGpSBOHaXDmmD/D44c2vcRFSkEbhsKEGwlKRhYXtYulq/82ZV8z55LCNaLn
         0d5pRQS7yWUzUN28mhMLJ9CR0i5uM8gLvwWtj8KLRJwxTjaoRHDMKHir7Ev0edfsFZxe
         gFk1+409juPdk+aYDVdHsEmxYkrJaNx9O4Gt/o/JOPCRtUINIWOFq3k26W9THeV4iqHg
         5rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718698713; x=1719303513;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mi/YS2+xeYSf/7U/MQSUxtW0c0qSIfyJZyjsPey06l8=;
        b=S4PrCr00XBE1hEQCn6bMi4dtrTSyjMzLy4FYd26yPAiQ45CTBxtEoNOIw3vZWckdEI
         +g/IiEsNZ3V5Z3MfiD0QOnYyjFu1FRThTvGTFLXSWbNzsvMeBltH9NNC1oOvxw4405Ew
         GxCwVxSxOWz6eFGxd4khzwC0XMZkgsZych2mVUBv/My2R6timPuMtknpcRh7xtbYa4o+
         4lRhdSaaOivO6bAL3OugdLxCznhXTPLfs9jKfw/x/ywTgfinWk4nSWI836Tgc1fdZDIF
         wq4xIQWLx64kap2h5Va6UNjLUwaDsr4RHW4BzaIlbnRJJThs1hYVlh9IOLjynN3/iSJw
         eH6w==
X-Gm-Message-State: AOJu0Ywpn5MGW3toaXlw6dsZByJQQiOP9ko8m5p6rOol8ugq5SS5UlnW
	mwMxI5Cf81T+TNOWDHlDz2/dA2AjN/47NimxXQPCIdAEIfMc8jBB575nJw==
X-Google-Smtp-Source: AGHT+IFWCahkBYQM42FmHmLHDarzbFZipCAzCiXrfVQfurka4kVrO/uhlfAOookIC0Ds/DhujWHF2w==
X-Received: by 2002:a17:90a:bb90:b0:2bd:801f:dabd with SMTP id 98e67ed59e1d1-2c6c8b2cc35mr2705415a91.3.1718698713402;
        Tue, 18 Jun 2024 01:18:33 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a7607ad4sm12511708a91.34.2024.06.18.01.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:18:32 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:18:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/7] builtin/fsck: add `git-refs verify` child process
Message-ID: <ZnFC1rne3SBemacT@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612085349.710785-1-shejialuo@gmail.com>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..10d73f534f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -896,6 +896,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1065,6 +1080,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

