Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841E6317142
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352206; cv=none; b=gehnqEIC/VxTEmAFh5lwBBASezgpBuUxQx9PU7YCUBqmnzw30FlJ51gtHr8wdaDKopx8PWtoOX9xQRxWVChYQz9Jmv+qenJ/pux33hkNyKQ+QMoPHMxswDq1wGF784cZ013usiYOeKBY76Xjw6pcSEQpX7J5LLTZ9NINFLZ+Als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352206; c=relaxed/simple;
	bh=9GGGNZYWY5fm6zh73lvchrt8OQ+OfkjHqZko+E7uez8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNjo7fnyQXZ838GYk2wfnNeDmMPXBfTwfRMDubNU+g9SrPE4e7cT3lkfRCHXIhfIHD94N7Wb6rB+Y3MDHGMqv3QFjpy2i4cDypvUp4I6xg0P4wu3PuGRc5HYsoFvw2IS5scCCCU4OIvSBppk6dT/QEFVG8uZTUTIJWsfBhNL8iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwkT6NSl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwkT6NSl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73c990a9cdso538338a12.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773352205; x=1773957005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Onqgamr83YwlRu86yLf/iqsTvRk7cRJpwb5jp4lfpM=;
        b=hwkT6NSlxdTr+Tw5rVgBwG6yCBiG1pDTAr4A0sG1QQ7t766H2LMU6c73BvX5ddc6zq
         kYIP9ykS/xKsMaEraybVGpBf13Gmy6jh6WUUgzRMmf/tnjDsk4crFa3lUDJ8YnRc8I51
         rywsgyvcw+fBF+WTlyB88yLi6aswcOSEZglVmzBL6UvnzKYxtDYD/2kPPZpm635nyCQY
         sJkvv6yFxqz/IWki9BdnMUCNyEl4fih+POKHqC83G+KCYgxrF9SfxzlAc+Tz5uSe8ONv
         NN4n8EU27dH2P5qS+Jta0sYrW690K37XiHhWqT6VgAzOLm1a8oIYzXJ9YAQwnGYhKWiO
         jW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773352205; x=1773957005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Onqgamr83YwlRu86yLf/iqsTvRk7cRJpwb5jp4lfpM=;
        b=T8uV5LPzw/UuZ0993xkRVDhmRdaIZOlSXAOwaqd1Jl4XIg/L7lJhu7Y6MEi9nyoG1W
         LU/nGUZga7WV2kZrQ56ETfAvycn6MahP6iGGbrmlPlhoh40M5+KmGqOU5bnFHk2fUNpF
         uhMlHIKfWTHJ/gKjWzx/s3bntS91iZBupuFLEduj7Do1wRvATKfeVifBA6cDct3WGpGN
         VcBQF8cFtDG93TZ27d9mZJtn0ebisdOgfVSdnS4bzezwP3YqszZ+RF+60acbW3A9Fh8l
         AdmT0H0mCZtvIf0SuMO/vIhnVyAzvxFNKSEJeUOxud2McWJkopv0d8sZyxaUWaRDYs4q
         rgmw==
X-Gm-Message-State: AOJu0YyNdhXoJ7EBiDN+R2q41tUySQAdo5sfjtUFY99JGPoFbp9m7zct
	hkz+pcX2PW9DGm5mby1H/4XTm9aFiMKSjtLFdgUNuuh3n91kYqE1h6npr7I5S9Lwse8=
X-Gm-Gg: ATEYQzxKA94bCYrR8eFpJJ8My5ElTefGka41Bi9g4CHm5QLSHadZUBCvCxeqFIo6+cv
	KxOvn5pJqrxGcxmYgwnsX2cqoqKTe0zxFEDIoBw7BcJpxIHmRfuz/NBHosd2fQmXbltCAxlsdOi
	kJhJRNavNbljnWfMNRPVyilzLa6GqjMjE23KbiwpkJEa34O7ifwsWM3W7ylussxAXiE0Xw7+a+v
	XBawWH79yK0Wxs5icb31e/gMeKiO8qH6nXH40liwxmP5VEhDQf7IXdCRMf+ILDcyOLdAg4VXLN8
	LudUeCnmETf2uTIK1BP15QxGxkEJjFs9DvlsytSJXkP3Hs69pvKU7k3+DH+imr1ZX2v6W6ErHzW
	NPmv/MTg5a5h38I170Pv9gBxW6brkysZ6P/alEPUoFcAhPGX7CRWmwqPp59CzQ9HPna0DkWWs0s
	2LvD6KWKTIyemK/x4K6oxi0pemo19C9BO3xx7lCoRzcnk1w5E=
X-Received: by 2002:a05:6a21:2d42:b0:398:97dc:5534 with SMTP id adf61e73a8af0-398eca28bb0mr707432637.12.1773352204586;
        Thu, 12 Mar 2026 14:50:04 -0700 (PDT)
Received: from CPC-yingh-DJJP7.reddog.microsoft.com ([70.37.26.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf9ff73sm6174108a12.29.2026.03.12.14.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:50:04 -0700 (PDT)
From: Andrew Au <cshung@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	gitster@pobox.com,
	Andrew Au <cshung@gmail.com>
Subject: [PATCH v4] transport-helper, connect: use clean_on_exit to reap children on abnormal exit
Date: Thu, 12 Mar 2026 21:49:37 +0000
Message-ID: <20260312214945.4050010-1-cshung@gmail.com>
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
---
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

