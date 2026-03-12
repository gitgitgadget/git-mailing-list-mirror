Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8033822AF
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345600; cv=none; b=E6qvRqc082mrmTKZlNlCnB3yhXp1C1paiX+5nCXlIHO+p6uli4/BuPhL2rOCk8PyuN3pjjLgdnq/4qpxm6Jbuu7d55kWRBVAI6i2PktmgptoszPylmWW0bfkA+s1kVK9JjcC/uai3eWGFx8K+ohMj8Ol06HLTHOyFSuaB5yg5Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345600; c=relaxed/simple;
	bh=hKGzLP0H4zyIJPLbRVhaobwtymJ9RjPnoenNl7MTplQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBEQAhxLlFhl775VTAUZBRFPrBPcMp2RKAu5Hdlm/VSHaCI4L7tfwisXtgJnw4K5bp3whiN9Xf2ZxzZ1rpMOu/9IGfNr1vKNeqGBfIUdfVXHjaFaQDGorwat213dpYPZtp6dxjU3cp2jGo0C/UYf9lD9C4uvt/7EKhZTY771Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbxZqrWm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbxZqrWm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso954855a91.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773345598; x=1773950398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VhYsT8CLN87MOLUevvkRhJiYchUaB44ILmcTxezcYk=;
        b=PbxZqrWmliCCje21gSB6lxwGHnk3TYR7B7o25Y223CuPj/nCiCrpPYAuKF5ujiou59
         eO+A9rYbD47qH3/0IvXAt15zTl0E54HejseHgyIiYlt/TiP0zSRUnJ6fCCBVa3jFj9ag
         z21J9YP84a5lHopg/A1ssryPIuRjKyvI+VuDSADizucezLab6mjdOTTcctNdqtFI+5KW
         HxFkNgjyHAVtfm2iI9jd4Xcu5IesQJgdVuNd7r5u4UAH4GIbzx+o9ohZOi4E6bHe/+1j
         bsisy3+47MNTYxUL8/BGfXpLF02risQObfVKsCYdlNNDlw76iLrpDew9oudfGR+x3Z4N
         HBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345598; x=1773950398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VhYsT8CLN87MOLUevvkRhJiYchUaB44ILmcTxezcYk=;
        b=bNUDalyNREWkVClwE+Ut9zY1D7u3ZScZ1wgnmc0RvH7QM88rDOIBhGKu59XW0JhStZ
         0YBunJ06HVcOHZUkhXoIdMx/rI03DKtQO/yrlxURVFuG5Icqz8jqCG8IN9UYe2eacqoR
         61V0M9BKQjq381YjItFqcZ6JsUkCSSqKzt+teCoYrRLxSwN5drKH0gRZgFkmyl/S0eRY
         Y/oH0Ai/pwHRv++6/CNMvtsvXAUQto6TAgjXT9ybMvj+4pyZgYxzgK7wVqIIOfcde2Pj
         +1irYLf2au91wT2+Abr7k5UXF2+B4hR+Mmy17RwmrJLTbDHXczbFgqCRWUMKia45fmqX
         ubJA==
X-Gm-Message-State: AOJu0YzXVRaWUZDgxQwIGvEo7oYlPxhaM57ilNkhHjpDwQb/5IJeGY3O
	9GLySaWFGfBhTGTkD4x39AQ6va5Mf/rY8hBGzITcIxyqIGRB/38L4Z5pL0vVLJxgMO0=
X-Gm-Gg: ATEYQzyei6YLSBcVndzF3qBjuTOKUA0K3DagGXjs+DLn++FQcwBE/RXuf4t2hQGAh83
	ybSJDFkaBpRbdJjM+02q+ZOpUigfzZgZHimtwIYg98NoXyVRdKCawR/GTE35qserU64HGaJIqwU
	yfjjRaI4wcvfB6ftDaWMWDT8k5zuQb0+JbqP7AeTI2/UM9ae4SlwQJedXfLlFASL1AwS+H+D1wP
	7TmSrbVTGKpgeM2+/xWs0vvFXuyYCZ4nb8IQijR8UVhEEQH42XSHJLh0ka+QXwplbnHaMG3D270
	wFWDYvzhybL4PxXfhQW+ZsE4gAG33DFj1M/ctoF/RW48eYAlEA9iEm+GJl31O67CBCoOk/mPr0m
	d61OX2+B8u/bWCeT6z/FoRuz3KE2KiWBClBR7dtIiNSO3S7sXglbWXnKK1A86UeluJOVbxz1nz9
	EOIhTa6GDEYyN6FZ6BvaM6lGhW1LEveENrUy2TmMAVpNj+4pfFSj8oGG+03A==
X-Received: by 2002:a17:90b:498b:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35a220532eamr648522a91.25.1773345598509;
        Thu, 12 Mar 2026 12:59:58 -0700 (PDT)
Received: from CPC-yingh-DJJP7.reddog.microsoft.com ([70.37.26.35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e660dcsm6378020a91.5.2026.03.12.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:59:58 -0700 (PDT)
From: Andrew Au <cshung@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Andrew Au <cshung@gmail.com>,
	Copilot <223556219+Copilot@users.noreply.github.com>
Subject: [PATCH v3] transport-helper, connect: use clean_on_exit to reap children on abnormal exit
Date: Thu, 12 Mar 2026 19:55:59 +0000
Message-ID: <20260312195813.4006430-1-cshung@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311184206.GA1911377@coredump.intra.peff.net>
References: <20260311184206.GA1911377@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a long-running service (e.g., a source indexer) runs as PID 1
inside a container and repeatedly spawns git, git may in turn spawn
child processes such as git-remote-https or ssh. If git exits abnormally
(e.g., via exit(128) on a transport error), the normal cleanup paths
(disconnect_helper, finish_connect) are bypassed, and these children are
never waited on. The children are reparented to PID 1, which does not
reap them, so they accumulate as zombies over time.

Set clean_on_exit and wait_after_clean on child_process structs in both
transport-helper.c and connect.c so that the existing run-command
cleanup infrastructure handles reaping on any exit path. This avoids
rolling custom atexit handlers that call finish_command(), which could
deadlock if the child is blocked waiting for the parent to close a pipe.

The clean_on_exit mechanism sends SIGTERM first, then waits, ensuring
the child terminates promptly. It also handles signal-based exits, not
just atexit.

Signed-off-by: Andrew Au <cshung@gmail.com>

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
---
Thanks to Jeff King for suggesting the clean_on_exit approach,
which is simpler and avoids potential deadlocks from the atexit
handler in v2. Also thanks to Junio for catching the inaccurate
description of the PID 1 scenario.

 connect.c          | 4 ++++
 transport-helper.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/connect.c b/connect.c
index eef752f14..5039adca7 100644
--- a/connect.c
+++ b/connect.c
@@ -989,6 +989,8 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	strvec_push(&proxy->args, port);
 	proxy->in = -1;
 	proxy->out = -1;
+	proxy->clean_on_exit = 1;
+	proxy->wait_after_clean = 1;
 	if (start_command(proxy))
 		die(_("cannot start proxy %s"), git_proxy_command);
 	fd[0] = proxy->out; /* read from proxy stdout */
@@ -1447,6 +1449,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		}
 		strvec_push(&conn->args, cmd.buf);
 
+		conn->clean_on_exit = 1;
+		conn->wait_after_clean = 1;
 		if (start_command(conn))
 			die(_("unable to fork"));
 
diff --git a/transport-helper.c b/transport-helper.c
index e95267a4a..6633a999b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -140,6 +140,8 @@ static struct child_process *get_helper(struct transport *transport)
 
 	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
 
+	helper->clean_on_exit = 1;
+	helper->wait_after_clean = 1;
 	code = start_command(helper);
 	if (code < 0 && errno == ENOENT)
 		die(_("unable to find remote helper for '%s'"), data->name);
-- 
2.43.0

