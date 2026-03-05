Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147F30EF84
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693737; cv=none; b=Lrx6qbUH6VeERpe+spvTJsd3IqTVyRu6v9/dE7Y1aluy1UYna9Q41HV0MVjZTPctivZn0hcuDheMNl2G6oMEMiGVBA3fgWMk2x3uN2byg1TOwulGblBLCt9EucQp+s2PdH4kFAaX/Vuc3suNYVKXhfnx8fBk0el4CsCUOw9kJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693737; c=relaxed/simple;
	bh=okdl+0uUaqS6blDRN4er+hR3UqeoFu6NWPRmZZPDXeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JdzMCtPnWP+ExpSdsPJK5CWwfuFMs2RJRoqOc5kV1gLNNyaCsgbNY+E6mK2gaK88MQ84qF7VqLJNphqajD1Zmcw7pUJTd/6FatVO248X9bJiI2q3oAih/7FnfUZJvAf3glP/NYETVkhYFTrc/kxL7+CEvsqLcPWTPVXXraA79SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfl7aAEC; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfl7aAEC"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be36d8495eso695039eec.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693734; x=1773298534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=kfl7aAEC2u9ApUx7K0+RSgzkN6ao9lCmlTJOEPHmNz32NPd3PojFsf3Z8L49Pdt1N+
         FrSzCya+v0X8/gIGAh8KgrV94lBuhCBGDNqAO2Fr1G0/jTiPK/C3KpNP5aN2AV2OrFs7
         +Estga8aUVpmY7xzrN4519Mv2bwcvydPMGA/+eGd18xER1AKln9+nZYmQcuUmSO+BAVZ
         REuUWILwHvF8iYTWtLQbTdPVAEEVHdihLBaiuV7PXUtFGoeV2lqToEYzkJ1QABMdDeui
         nUw3NjJSNAu/uIm/7+hgyORMvOcoZOCaxY305kroMjRWLny8Np4NXQcD7OvjJSAZdjUW
         z9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693734; x=1773298534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=LumHeK99C7yE/jUIImjR0MM9QZgg8himnXUeDRP8dpf4Si7GIf6cqMXKNc02IeeMS4
         5LPVFuckBMLdYLOYCWz+zO0ubxzBeTc5tPbmv2D8vIya/nNaLnXEFOBrZNw62OhYYVCR
         BOX62WSgy+HKOA21zA3rK3bISkyGHD2zwmZJxl5qctj0lWwd8iiwJoKE0jLGCXTAlVGZ
         e+EagqIP4pg97lTcb5mmUp6k5ohdaLC594bR1Jmng8rFwOXbcLnwSWnruNm8r78+Ntja
         PA1aPT3PXnPKBY3FmGDOC6uaUkGHBzUEb9ynmuN8h5xF2CU1mN7Hm0+cP/FzaN8kvnFL
         Tnow==
X-Gm-Message-State: AOJu0YyHTXcugbYDw/QpLN6Muxw+K7IVLH/s0tUUiSvcR9QkO6y3Jc3k
	QwTgwc3Zhxd+MQG6n+rWKpDdT1tFRAm0pOzoTQOmvkJGCbkp7giOVIpRPRfrTA==
X-Gm-Gg: ATEYQzyoewxfJLOM0SNBwpPlf1emhwcF2slm9macqOowh0uoScPIgiigKCd9qhuL7cA
	nv5wWP+a2ngUzhgU4LVnZQR8O+YCvj+YFZzpMZSKKMIEluCzusV3/ANCNiMUgOAoMC/+IIqtN/R
	2z6dCevhDzHiHJrGXzwIzLlRKkB3OVrjSXtDFInD8wbZMfLUNaqrg5nR4q1pGYJ6ZqaexXnh668
	z91ku46K1VICuDptC5/8xHH1RtUDIgZR+a9rSrje+mTSow05D1FoXGR83MXceZXgSTKhoPvAwK0
	0HAg02UpvXbmv2AuXDjrODTvaHSKasTNzXTgHALJwRCyQyl3OeHR7Z0ArlgNtseUmCJ0iXr9x43
	t9Wbn1Kf/hkrGrlhDUScw9kYQIOOJp55Y3+XYWsxDITHOkyCHfWeWzmZjIhIsr10XfZO5pNKp3D
	vbfSaCCsk+O2PW/pkW2DrR+X+9OA==
X-Received: by 2002:a05:693c:4098:b0:2ba:76e1:39fe with SMTP id 5a478bee46e88-2be3e2a66e1mr350207eec.6.1772693734487;
        Wed, 04 Mar 2026 22:55:34 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1ce921dasm6057997eec.10.2026.03.04.22.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:33 -0800 (PST)
Message-Id: <50f5b4676e531c944ea40eaad265b14c2467a808.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:08 +0000
Subject: [PATCH v11 08/12] run-command: add close_fd_above_stderr option
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

Add a close_fd_above_stderr flag to struct child_process.  When set,
the child closes file descriptors 3 and above between fork and exec
(skipping the child-notifier pipe), capped at sysconf(_SC_OPEN_MAX)
or 4096, whichever is smaller.  This prevents the child from
inheriting pipe endpoints or other descriptors from the parent
environment (e.g., the test harness).

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 12 ++++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..f4361906c9 100644
--- a/run-command.c
+++ b/run-command.c
@@ -546,6 +546,7 @@ static void atfork_parent(struct atfork_state *as)
 		"restoring signal mask");
 #endif
 }
+
 #endif /* GIT_WINDOWS_NATIVE */
 
 static inline void set_cloexec(int fd)
@@ -832,6 +833,17 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->close_fd_above_stderr) {
+			long max_fd = sysconf(_SC_OPEN_MAX);
+			int fd;
+			if (max_fd < 0 || max_fd > 4096)
+				max_fd = 4096;
+			for (fd = 3; fd < max_fd; fd++) {
+				if (fd != child_notifier)
+					close(fd);
+			}
+		}
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..fdaa01e140 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the child from inheriting
+	 * pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

