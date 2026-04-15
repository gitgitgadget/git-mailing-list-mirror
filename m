Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD733A759F
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259679; cv=none; b=slKANXW/+fbr4jETsQ1ZlfdWgghuPq/7MJWzMPmOZGOKTyTPnaBlGvxc4Bvlr+VgvLhpLdtDA7y+Dh7smFceo2sa6OU+5zWno1wtYGs593wxMRcUkj/ROutka3zVjx90Wzkc2f53bTsx/1/Z3wBHj02UR6VCQDIYv3Pohi2JQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259679; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AY1nFNrcxCXl4hSAB0y9CCywpFLg5KOxoD8VWM/nFiGhHxC2RERwRJ7mI7aPSnMnBiqJF2sM/JxJdPcelqbAFJ0G/whLrL4ufL+ln5sWDRXItF33VFMepv+KYpdVJgjOK22yfeIAVs+l4RshY5mpVvTQFRVxPNibd5HkG9UFoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcakhLvf; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcakhLvf"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50335b926c2so51449911cf.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259677; x=1776864477; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=RcakhLvfZihPsdtfyENDmTKXQpcJ5dDXoLbPj/D+Sw3FkfNIKNnv4+xO7CCx55Xcno
         FiN6du+y/TfXcFJUQYlfKR58DAMUUfI3eJpDEW+F+2bPwTpheRboZXwf+TKeiT3ez+qG
         YFYxsG40y6YsJktp4cmcT5dvJF7bs1Fgtuit0PQTEMJadXu9kwr7AXocxWOxqwVNTv2v
         jAHxMu9LL9C9HdiGskD6JZxevyo1S3TxfrGr27y9hmuocAywElOOgDUOEEmcymL6qFEc
         lqwIB0K+C9e7B22dCSkc1JFNCpNyPnZJ/EMWU5PKaf2x2FP/KDGA6ACG1+TXFA7IBnqY
         uobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259677; x=1776864477;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=YXk0TF5fDDoGZBnL+4B5r3KxDHncWdagTeWmqOM2A6vm6atUkQAjv2tkaPL2U84HOx
         XVf0sa49W2dboTTtT2/OinY4HicWuAPT2cwrMlBS6VX+rBOcBAbGMSZsxdHPzlLT+mkV
         KHB8D3KIRvU5B+9dkWs29XNfuvXcISbNQ5Qr0TL1eI3b0fRLJV+qBihR7KuD06qs5+kx
         RzatvzH/sanFVje2VI/DbpucCTcVrVHS3pe0FhzQNhb7pqlibmOx8miSNfUJxYZeuFQZ
         9aWXKCt7uVhulm6N2ffvPqdDUkNOPH5dWisYXhFWhyPP5ngfl7eWHJvrfZN88YeqzAbO
         fgHg==
X-Gm-Message-State: AOJu0Yx39RBEsGh/+9umLBLWANSJUmJ9oyvswk9q1s+ifk6DI3+5AbQK
	JDHJhvHs5hXkU8BqMlufNfXPgP8W/HSTZbO8mGtol2klkqeqJwZFCup8G6jPcQ==
X-Gm-Gg: AeBDiev92urufoPlXDlte4yk8Loe0DZM/O/ow9lj1HOcXlcDk9qhd1SeIRJE8PjBphF
	Qnq4MlpPLmu7Hb0/NNCkQOYlxgdnCxmsdAOjZ00Et6FeN60sn2Sbjxtr6GzNYDV42aPsZbFyzVi
	tbfWoKIcsQh/ON5JKjYpnGhLQ5PzUdNRCi+zMhuoH50HawU+1prlyQbY/kmM7MGELUZsW4Yp7Kd
	ameU3Po8/yWQ5SauXtPEBOWRHJ6xDucmUP+k1KvCsttlIUgWByqWQUOG/HDu6KrUjEB0sKLhcjV
	7WzomWweIVLtfgiC3Ey8fYIj1RcOWCAnTq/rudAjt8t4tlej0ejzTFM2JpvY7rUwFag7H51hdHq
	t0nEvwBcZJ/F0Oimxq71YnkZd1skuFjWf4GlLRkqAK3/Xu0AWXkKkEP1lNT9UdWDFoBWpQNPavs
	DiwSuK6AFbQ54M4pfJjDVvjxRSBQ==
X-Received: by 2002:a05:622a:49:b0:50d:8db0:7abb with SMTP id d75a77b69052e-50dd5c6c883mr334803551cf.42.1776259676540;
        Wed, 15 Apr 2026 06:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9da11sm12740311cf.17.2026.04.15.06.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:55 -0700 (PDT)
Message-Id: <22d425ebebf3a81b0e89caddf4fe1b4a94005c58.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:34 +0000
Subject: [PATCH v15 10/13] fsmonitor: close inherited file descriptors and
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

