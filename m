Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D3393DFC
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498117; cv=none; b=V/jI67WNRbD1mK1RfcHt0VTTY5LH517Ms0JxsXvFAfcznoeLqPT9qz+XCpHYoRDhLsctDuB0T1VhL3AjPNhF1SapAzFfiY5i6dh0/5B5RP/1MVSP9pyp0biQU76W4XB85DgzArbpc2Rjuy8TVVUdUrqFJ5HDkGTQUA+grkoJ9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498117; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qSmaoLgl3EvGmRS6CqTVoSj+oUH2LzfKdsBs8COmespiVaw9W4rREUJeY0N7xKlTT5AWZY93YIA4aadmE6o1RVkHhc7qu8OJAXsXhVMybnRhYZBIlfjoTqPV6Hmhc46Cvd7DfM7wYESBkYLWg2rhUy+Go7RySpl3P+Dg+nTsyrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW6APXX+; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW6APXX+"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4514970eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498115; x=1776102915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=eW6APXX+4KYBklWzELx/4zamaFETULLXTfTYPXZEjoptd5BVbjViG5+YqiGxfuR1n+
         rOhIPTAKTdxvwT5q5LVdTvi9r6shHRBWdsNdMIiQLXF8GtJZUXQAJzZBRutkNfhayYTh
         Jy4U3mdej2lWtU2c4sp6n76HR7EtLz4ULeoubWKEib1VtpWWIY295tknb8/Fu++X8l8R
         cslLIVwHvC8Psmv9z55LeeiJ9+QdecZYheNCcFZNmRmTz7vfN7PJqGDLAwB94CpUkVQ+
         K4voQiDtu+6+t+vz2dPVhFSgFjfNvBk6DIIQDp1EpkicW6VdWc4+bAqhRCzGL2ahKFvN
         DB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498115; x=1776102915;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=mhAksX/4tTC/R92E5ps5YLVueqE78EoZPKRL9jW+R4nXUM/dTdKHOf6dbxVpHSBgKl
         rNvl32jbDpNfgIIfQtEctF8yWHsaa7+NfxLfdvh7YicT2kSarhvnc9Kd6yii++QJFkAP
         GMDXWeDsK25HIybz2Wj0GGxw74GGfDzaCkPBDmPcV3WiCw11g/ZAR/Opqj97DD7QQ9UC
         zzRVPKsy5XBTF4nlt3TZkbJ0uuCA43+iG1hnYS6E1wvSLjRyFOeEwWYZxRXUxwsRvNCl
         iOYafo3Kd9PoCsUGWvxp0I6VmwPflxO74Iy7mKW3Jr9mqlPYiQ4XvGEZ4ZyjSwErb7vG
         a7oA==
X-Gm-Message-State: AOJu0Yzx6SniHYid4RF9a4sUFfmpwtdjlCBwK8KWNkqdU0JC0ItoIltH
	ypxpGdIa1eVtgcfZi1nrw8+WcosrfMvZEUm7GQH6OrcEtvnpsxuY+pLlpCYAVw==
X-Gm-Gg: AeBDievlGJX0y/Rs/Dp/IRPESulDKioM+uGFpS6lolykbvCGy9N4WSZ30q5wi2yaobk
	lre1bFbCzP/Ti3FSJP21QYS0Ex+18Osv23CdhDWIAK3pDWe/+z1shwW5j3C+qVTUiR+ZvQwT3+y
	SzjwCweJbTebriCEtGqrUn9B8bL6znlqE+mgu3D4njPbG4GdXgUleKIDgJTEcTQ6qdeQ425W5Fh
	/yerzwxru4+JGwQoh0XCa1oVWRq8yKjLTY8wykI3PeO7bCd7P6aB3P/mKyJ5D0pClxld80FI75P
	PqKsYKqRTkRhyYBkPSk3UphvGnAKMw23m9iYrd8Cp9vNjqUcufogUEVJPavYImric//w71hgSf8
	aoFBBa1couWJhFUAF4cJ1Q8bQxgb6J9GuIaXNycnJkx5GsXr+w/7OFJmhZBT+oBCfD+mTcjTvdX
	1cZXjVGihf8wnvmPQna45fYSLqc38=
X-Received: by 2002:a05:7300:dc8e:b0:2c1:3f85:756 with SMTP id 5a478bee46e88-2cbf9fe3608mr6131174eec.11.1775498114564;
        Mon, 06 Apr 2026 10:55:14 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cf1af62347sm5425592eec.22.2026.04.06.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:13 -0700 (PDT)
Message-Id: <2bf134a041159dbbb4982a31ddf242b5331ad31c.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:55 +0000
Subject: [PATCH v13 10/13] fsmonitor: close inherited file descriptors and
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

