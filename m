Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F331E0E14
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673397; cv=none; b=rc/cWrEszjkkpv8nlTenpn9AFFMLVR4lz1fq953TvTF6rkCvbRSJQYMtXbI3FjhyzyTPTPEWpAsb0Lm7H2vv2v6dIh3k+AMrinDDBYFe4vGIXRH5hlc9YqjjBnM+6h/Z4Jj8xdaqmkUujrZRwDyDNZq2+PkCOpCmJG4OoATFh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673397; c=relaxed/simple;
	bh=VvCmxyOmQMmrmKtBdr6ZuDjYmUCvrr5W6Ur/sYICLd0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l0mLEuS6YZGysLhNtkrIaAtzdDwF0dnG/Obxdz5wpMQCV1wizZjYk4dOIKopSvNX8gOWHqA7CceH/RM0uC8apM4uydRS5LDZ0bcyRAyDOqLU6+CZLNNeWFjKn1zVs/MFjkIbNRhQ2Smh+QVC511GB+MUtmWk/4X8uRheJ560w+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOcDAw4m; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOcDAw4m"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899a9f445cbso93302566d6.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 17:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772673394; x=1773278194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvQ8tcfw69qi1IJt0t52H895At17eMQIkBtu4h0+qrY=;
        b=hOcDAw4m6WICNXXImmfZ8ZaTfub7PXhIYXYeXSVwVG7duLrygpc8xyyVOjMm2aFEEf
         b2rTbh30AEzp9OhtnVaXwvkOKBREXmVHrm1sDVTM7bvov3KTeIUuYdRbSCySLxmgmdsm
         3y8nvivcIVO7IZlRwCE4l+ftyRJ6W6RdVK0NSF5T9w96WtZC01JCYH/EfftwHZLKWHZI
         R+hlUP1jvZkYYROQrYArLbAZMOOE22neb4E4spT38g1YaBRAj7lH4Ynr1NeAcxv+bd9n
         xMlApfdS08SHRYnojEy3MyGO08akDuF/4r+oYXdvXvEEr2DB71pI5IMAR/w+QIDTk9Ak
         g9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772673394; x=1773278194;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvQ8tcfw69qi1IJt0t52H895At17eMQIkBtu4h0+qrY=;
        b=V6HiGv7elhP40xUpvmuKuFNtdtfi7BLl+LEWoAYp1aNZWV3q9AeJLfgiQO/IINqvvl
         IX6WDVxtqVvXghHv9Xj5OKrK8J7/yg/gLN564oL9MHhYBTiK2jTstIYVOO30tcxACzCQ
         Bh2GMLPDx+5jTRiAE7FDGN/45AVHU6zQHicHeEAs6U48wrG2eFH/FXtTkhR02KnOtYUW
         Dc7IUM/IWj2KOMxTNBqYNck2ahYCMuUN7vGtS6fUesS/IZ2pk1O4BI4B5JudAWWYtu8i
         Acjioj0OxPu0tJBXC1SWu5YEdzprH6zjs788woACQvSjkZ55oGY0Xr59Hv2wOs2seSLh
         yebA==
X-Gm-Message-State: AOJu0YyictIg1QArFVjrIuB2NfrvtoFi0wDpLegsf1ssmks+Mlv5MSGi
	J2toYGCOk1xJqFS2Yv69syaNPIHA7A7aU40YQrNvZ9iiOBZdi5L4YdR49TxKveu6
X-Gm-Gg: ATEYQzyb/Tqg5sn6hhHCyjmSY4EboSujjLHYGyJPKw7CqDs32JhOYxugcNSPhA7BuRc
	RV28QUkt0ndVWayN+KgKIU+A7TNCYMsk8F8KOAdd6Oijfkzwp/7P6DFEw5DLOEKUk/LDjEAWuFm
	q17f9JqE/o/c1PIXIQH+EuD/SAmywsnihykA3ark5yLxFq0LGcUdtI7rOQrMGVn5z+mILGyhFiC
	A0nu8ObM0veNd262j0ieXog9hYvTm4S6AfWunr4HUqvBFNjBlDMdFW98oGi14WxcIu/9uPZvSJj
	l5ba9nYuLQiPC+V/Od6cDMWrKUhj4i+kDtAhl9sXw1F32TxxtlGfeotPuXzqd4irmP421DBbjmN
	WF222c7NsWq9ZKpd2/vgtsO0rAFCCH3vRq693W+AuKHqJOWh93S/aavrJ0yug3FAWCyf0hJIUIj
	DyuVFfDZISiTS+b0LtX808NRw=
X-Received: by 2002:a05:6214:dac:b0:895:48c2:aedc with SMTP id 6a1803df08f44-89a19aee83fmr56214576d6.39.1772673394617;
        Wed, 04 Mar 2026 17:16:34 -0800 (PST)
Received: from [127.0.0.1] ([51.8.152.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a0bb6e27asm50207696d6.2.2026.03.04.17.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:16:33 -0800 (PST)
Message-Id: <39dcfbb7c8f870d8c520772563f1a3b0380929e0.1772673378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
References: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
	<pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 01:16:14 +0000
Subject: [PATCH v10 08/12] run-command: add pre-exec callback for child
 processes
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

Add a pre_exec_cb function pointer to struct child_process that is
invoked in the child between fork and exec.  This gives callers a
place to perform setup that must happen in the child's context,
such as closing inherited file descriptors.

Provide close_fd_above_stderr() as a ready-made callback that
closes file descriptors 3 and above (skipping the child-notifier
pipe), capped at sysconf(_SC_OPEN_MAX) or 4096, whichever is
smaller.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 18 ++++++++++++++++++
 run-command.h | 16 ++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..cfbfe68b33 100644
--- a/run-command.c
+++ b/run-command.c
@@ -546,8 +546,23 @@ static void atfork_parent(struct atfork_state *as)
 		"restoring signal mask");
 #endif
 }
+
 #endif /* GIT_WINDOWS_NATIVE */
 
+void close_fd_above_stderr(void)
+{
+#ifndef GIT_WINDOWS_NATIVE
+	long max_fd = sysconf(_SC_OPEN_MAX);
+	int fd;
+	if (max_fd < 0 || max_fd > 4096)
+		max_fd = 4096;
+	for (fd = 3; fd < max_fd; fd++) {
+		if (fd != child_notifier)
+			close(fd);
+	}
+#endif
+}
+
 static inline void set_cloexec(int fd)
 {
 	int flags = fcntl(fd, F_GETFD);
@@ -832,6 +847,9 @@ fail_pipe:
 			child_close(cmd->out);
 		}
 
+		if (cmd->pre_exec_cb)
+			cmd->pre_exec_cb();
+
 		if (cmd->dir && chdir(cmd->dir))
 			child_die(CHILD_ERR_CHDIR);
 
diff --git a/run-command.h b/run-command.h
index 0df25e445f..375d2c731d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,14 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * If set, the callback is invoked in the child between fork and
+	 * exec.  It can be used, for example, to close inherited file
+	 * descriptors that the child should not keep open.
+	 */
+	void (*pre_exec_cb)(void);
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
@@ -149,6 +157,14 @@ struct child_process {
 	.env = STRVEC_INIT, \
 }
 
+/**
+ * Close file descriptors 3 and above.  Suitable for use as a
+ * pre_exec_cb to prevent the child from inheriting pipe endpoints
+ * or other descriptors from the parent environment.  On Windows
+ * this is a no-op since there is no fork/exec.
+ */
+void close_fd_above_stderr(void);
+
 /**
  * The functions: start_command, finish_command, run_command do the following:
  *
-- 
gitgitgadget

