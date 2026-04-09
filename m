Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8F1A6829
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775710796; cv=none; b=Yd3yQtckmEWkJth7fdE3fRpMES01ej4uIwt0PQiWyjriqnRJPwoaHrh0rdA0xlVU0TVs7wsLy+CKFbZ+d5wAoz+x9yqbtFRKRVIi3jR6uNUliGhQnpuWvqkaf1mK1Uz2EwltblfCYXQlzng+1nF6jD1Pbz2brl3nLgwep2WTML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775710796; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gM5Frx81SbDULrDlVCg5EY6DTD9cucy3yIgYdHjnMa+ExHLe9NlbVaE22meypUPPDhTvxt0S5U16dUrm0u2h0qBzMMn05YgDgnQXjKvDMnwnXxXuoLYaioTfZ7moupwPwtgHpkgfeudMYC6OIRK1/mgyeGnRsNwZez159+i/Gqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjyjVdSN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjyjVdSN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d6b9bca48so7234981cf.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775710793; x=1776315593; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=IjyjVdSNANV9gBBTrFHyDs6zM1kGn4ZWMoYTWEUA6tjSRhE78gC/jKATKz/YafOjxb
         THUGFf8Eg6sZ0mKmCTnH62Ff6IuyXa8rN3ZFZ5js6VHsdqQqAqs9KbehjRb3PvVehhTe
         kQ7N4yxhv4KphNR9nrB1cLBc/cPKpSFF0HDAwoYe58/JJ7ec/Fkz1kSO6K2R3k6UDiHz
         3bavPbTP5AgeDrq34Cjc1ci+rzGsWp4swkGa1kL4my3jE7RUAbonsN//of9x1ds3yXMf
         IBcDWXY6O+P7awEDN9LYAERNDBrgJ91QX+yjYD4O0ic7cLjeksGEVNm6g8mAvwCmEfpZ
         nceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775710793; x=1776315593;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=b4PgmdBE1hRP7bbrQEyBF12kU5Wt/IgpK/59DSiQUlork53lXd/sslpMtjsAXumNLq
         NzK4uTp3NZrY1zYq+ZsIw66kKKtNEqi0aXe9nMqXJRhF1XRukUFxxstfMd5ZrXlBlenP
         Zuj42INNeX5QpbgSfhdnX+0x5j3Hh54CX8GfnG4qwR7BzYePwPRD7ypZf73RXFa3zdNX
         JN1Yachd+5oMGxmQh0JUeX3BK085pNNw+oR7+vyjiMQP7d3vh0M3VXBbPScEV+1FPnPW
         0Y8vgU2M4MpyChje6Aimlxepkprsoxqng3qUk4ant3kgWp4SEgh59xxiM3Pc7VJ8wsXW
         CLGQ==
X-Gm-Message-State: AOJu0YxMDHLEFvtINDKJ6/iLfNRrQ0a4aNN6r8k4T/zhwjWtr4sJZp5z
	GZKoWU5vrA+u1tqGokbEneu7jH7jNn1o92wvz150r69lBoT64C+TN43enrAsvg==
X-Gm-Gg: AeBDievW5htYp2y+ENKFjEUj2OKlCtjXtAH2XGvevTM4yvaGTILpWFCpz4H5ABnH+Xz
	qlZZcGrPADFQ0HlFo3KJnfTBZyS/Ngb8noJ5c2wMOa0oxy+ty+Nk6a3XEd5Lct/TAjGb/DOLhlb
	zz52sLMdczqBPqk4tQmo/HpsTDGrgr1E1NV7CGuIW+1cbx6YaISR8jdryTP30BZCNdDs3/wqOjJ
	44J/Vpk3Uz6rVMpR88XGUuEDnNa7qzWyTotSUeDOIBen8aGxgW6VsZtky4E3ykwAf/sWzXWsm0I
	Haz13wF4r10pTrm8YuU6XHf/BY1T92KvD0cjA4M5tovnS11lepP7DxEFYXId68tKdjXTC8TDOdv
	UOrGa72FgWKaB5obPKApBdQ9uA5vWoeTbFGKo+pAM26edGxM9LgJmAa0jfU2CWEWgO1u4Dt6KTB
	djQgYTa5JGrPcPK5fsizm2m/dncwI=
X-Received: by 2002:ac8:5856:0:b0:50d:6e4b:d8f4 with SMTP id d75a77b69052e-50dc21529b8mr34265991cf.21.1775710793248;
        Wed, 08 Apr 2026 21:59:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.153.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d84ab853dsm133782121cf.27.2026.04.08.21.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 21:59:52 -0700 (PDT)
Message-Id: <22d425ebebf3a81b0e89caddf4fe1b4a94005c58.1775710775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
References: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
	<pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 04:59:32 +0000
Subject: [PATCH v14 10/13] fsmonitor: close inherited file descriptors and
 detach in daemon
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

When the fsmonitor daemon is spawned as a background process, it may
inherit file descriptors from its parent that it does not need.  In
particular, when the test harness or a CI system captures output through
pipes, the daemon can inherit duplicated pipe endpoints.  If the daemon
holds these open, the parent process never sees EOF and may appear to
hang.

Set close_fd_above_stderr on the child process at both daemon startup
paths: the explicit "fsmonitor--daemon start" command and the implicit
spawn triggered by fsmonitor-ipc when a client finds no running daemon.
Also suppress stdout and stderr on the implicit spawn path to prevent
the background daemon from writing to the client's terminal.

Additionally, call setsid() when the daemon starts with --detach to
create a new session and process group.  This prevents the daemon
from being part of the spawning shell's process group, which could
cause the shell's "wait" to block until the daemon exits.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 16 ++++++++++++++--
 fsmonitor-ipc.c             |  3 +++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index c8ec7b722e..b2a816dc3f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1439,7 +1439,7 @@ done:
 	return err;
 }
 
-static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
+static int try_to_run_foreground_daemon(int detach_console)
 {
 	/*
 	 * Technically, we don't need to probe for an existing daemon
@@ -1459,10 +1459,21 @@ static int try_to_run_foreground_daemon(int detach_console MAYBE_UNUSED)
 		fflush(stderr);
 	}
 
+	if (detach_console) {
 #ifdef GIT_WINDOWS_NATIVE
-	if (detach_console)
 		FreeConsole();
+#else
+		/*
+		 * Create a new session so that the daemon is detached
+		 * from the parent's process group.  This prevents
+		 * shells with job control (e.g. bash with "set -m")
+		 * from waiting on the daemon when they wait for a
+		 * foreground command that implicitly spawned it.
+		 */
+		if (setsid() == -1)
+			warning_errno(_("setsid failed"));
 #endif
+	}
 
 	return !!fsmonitor_run_daemon();
 }
@@ -1525,6 +1536,7 @@ static int try_to_start_background_daemon(void)
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
 	cp.no_stderr = 1;
+	cp.close_fd_above_stderr = 1;
 
 	sbgr = start_bg_command(&cp, bg_wait_cb, NULL,
 				fsmonitor__start_timeout_sec);
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index f1b1631111..6112d13064 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -61,6 +61,9 @@ static int spawn_daemon(void)
 
 	cmd.git_cmd = 1;
 	cmd.no_stdin = 1;
+	cmd.no_stdout = 1;
+	cmd.no_stderr = 1;
+	cmd.close_fd_above_stderr = 1;
 	cmd.trace2_child_class = "fsmonitor";
 	strvec_pushl(&cmd.args, "fsmonitor--daemon", "start", NULL);
 
-- 
gitgitgadget

