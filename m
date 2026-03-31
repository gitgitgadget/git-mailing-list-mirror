Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3827FD49
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937987; cv=none; b=jv1p3MLNNckH6EJoBUCb06oqmzyV6v/FnofrbgngjU9JgVsDjRUfmvhgDWiQ45jCd6hVCbAoixvnp/KBuArzi+ZSle0wZkoC+XnkOLsCMS+LZDTwcVf5mweQYP+3WA6QSQSEF+Un+SP9dgdUegizMXqpGnRq0pZtjngoHVYZKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937987; c=relaxed/simple;
	bh=iWHi/Iy6Jg9VFB2Ce9XDASiFMpsfM1rNBVIoij/oyeI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aH/6GkAGwFTwfkDZVskowhw+QNDma4VjjBfF9/0n+P0pI/hv28VqKMqfQeo5N64E4Ut8sGcFu8VewQ+sG9pBUXicbKX7kVyhd2Pr3FqguZ2iP/R8gg2yVIuY8qkhKGdnyzsVk1lMvzNzrwKhwFMwwCKEKUwjeS7s7EGm5Rnx0PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBOha1bT; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBOha1bT"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41c420d1460so2103721fac.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937984; x=1775542784; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=FBOha1bTwJoiekB6osFIPukaN7ssaUx90YA+gS4UlHHySRsm7a7WAImj4iu7Jq7Y2v
         smY/ctXad8jcmeKfCNNJMMqQbdsuVBJhq1PM91Vc8t55Qtn4SdWr/3qcz25fo54vB5Ui
         /3FqyneITZRnW58zUlk/Ww9ldq4CdxDc//QFhKDejj/lvlkDKXSZzcRL+g4idhP7WX1T
         QCVzKDtJHdpllMR7pbvGHXLwg0bV6DwFC7c5gOmpErIluECJu9m7jPLc+tVjpsmkciGY
         Qviwgcf6ebZYoDHlpnq57g+ITlfktMYZtIFcTiVh70P5ggtT4gvarzCtSxXktvfJREiP
         isEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937984; x=1775542784;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+XccA/xUBXw7BUScvs447In5YHY/qkuIiroMUtuxbE=;
        b=WXxyxqz9HMwie770gYd4AGqpTTwY3fYBmeQA/zhIo+pMjDTerkyryThUyOPZYwRU7I
         HSQiXZJqj+UHkAPXWYBS2w/p5ZVO3Nyqvqqwtze2nrcqzrZaskcqgGTrvPKiuuWfjyuY
         aLJl3YyG4Jd6PJ4d2OnpmYfsq+nDYwG8vAZKf0k+DuI5fSO6Zrrxfb9dnzDatbYlIa4O
         88CZ+7Vvf7rOKE8ZQkax9YXQxAT8urJHVLKZoXF0QBafK9/OVesWF8cOIt3fle1BBbqB
         YdB4r4EgyPF8ym/mIFTJdCgEyNVZ9UuvHVKre23WtRfD+9hDM8Y6utPLwUA2Mt1cd6rF
         JQcA==
X-Gm-Message-State: AOJu0Yw1Sb0apke34buOXx7MP0UwO+/z8QNF8Zk8AFjt9U1GmP/6IEQ8
	l8S29Zw/mVMwXmTxSgyPXhZuFuxx+LhSbWfzTb2GvyW5cB3FxIq/w9Jh1HcUpQ==
X-Gm-Gg: ATEYQzzpdjw5m2TLCXYcCGBQI3hlZFyZDpps9etwQNGWQCwLTJw8QzQDsFmzMH3UYt0
	bV6/bw8Nu5Lj8UMIr1U0tA73C8JI5fOBY3ZNU0s2PdT5YPn9dzmSoJWUQVGW7DTdkeQCeKctgf3
	WdUbEjTdpq6cAajzeiva4rpx2XMccxLuZUU10DJKc1iaXwJVGQaxenwd5tY54TZtaMuaO8ZznsX
	NrY9tymJCFHAiBl5xo4qbapXiOWdlGWnB7+IOFerT9D9BTeFRrLZ7JyiAwd7Rfc4n3CSd/oZtDy
	/gTEdEKo/vSPzfDvRZBfJoErbHXWGTK0xihhO0sf5KmlJ3MbbpA3F/NuamNVLfnfyroCHiqNnRn
	NsySpXZM0SKoX3fh48pbPt4mc2mcH31YE/UcsSsrmRdm7CQqvfM+1zdBpj3hy/DN3q3oixRWMrF
	wjKcuG0o9PGkIXUEas1BIpEIbiwtejTRMLtjtYrg==
X-Received: by 2002:a05:6870:d208:b0:404:4166:ff59 with SMTP id 586e51a60fabf-41cec35e015mr7900270fac.43.1774937984156;
        Mon, 30 Mar 2026 23:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04c889fesm6104788fac.9.2026.03.30.23.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:42 -0700 (PDT)
Message-Id: <057b3098bcbea0302877bab0abbb9f9a21194f40.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:14 +0000
Subject: [PATCH v12 09/13] fsmonitor: close inherited file descriptors and
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

