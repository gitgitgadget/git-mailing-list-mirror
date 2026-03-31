Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5937F745
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937983; cv=none; b=WMf6Q+tUPr84c9/bIAFTQ7DvSeIdhrYsrjVuv5qxdaydP59niLwDnB2wCGAmFA3V/vD8dOwtO8YcScXs394UFjnz392P02ZWkh5LLKrtXnMm8JnZs2HkU6xq2uuyhvIve7S3RGDgv6T+6N9kh//wcu4b3eocQJ5cqjvX0TZFArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937983; c=relaxed/simple;
	bh=okdl+0uUaqS6blDRN4er+hR3UqeoFu6NWPRmZZPDXeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jHQfOpHtdNWVtzJjD4RG8ZYOjsevD4RHvTQlZCdmwddubIFKpmh2JJ93n83mLcYzyhXs2X8HeioqOtoq3pFCBawi/TFssU0472DVlJ/daArXlNqpruQdB0yHcbt2nctd1Pv5KAka2fATrYW4AXVMxuI68jozo0xTWPGAjC8e/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqqdkM3N; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqqdkM3N"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40427db1300so3169880fac.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937981; x=1775542781; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=aqqdkM3N7JMWGLS0KnP7wmWp9WO4044TyMLg6c+94FlybEYJVqLz0Hyjap5i+Srgoz
         YjajBgm/UPcH/03qLj888atXM4CdDCO+egL5GaPzXxakxyDEj1VHR+1YODJvFAMb2tlp
         ODFI23MXeTNbgRTzEVzVJ2UKTVPm9Mfk6/kBlwfPwTsKVXhG+71C//m/svUNdWYW8cEW
         TSibJrUU7NEBPCmv770ZzYlVIx/dSB7s2fSFbQrnKng13M79OixDUBa6tjKSERhkjdjx
         7oFwnr6M0qcpP/ilR2SukXxYvK+sMk/6ab+fl9h5ogaNPYVvXvjG/BEm3OwMlDUc8ud2
         1mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937981; x=1775542781;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=DnjWEE3CbkEeOdFsIEnoE7J8FqacUBkyiWeqM5vW9v2By/VqFsQrvmS96AqSuR5KHD
         4fdQwqVoWByunt0neqlrVWnJBYGVUiOsV/tgAyhjCOYF48XYia04z6oqS48oIUUPbDKJ
         aJnmSrslUlOdjkIYwIrjTo/m56npeYtPzgvotgccmbdOPl6mSMcDqPk/cvq6Kskxl6fg
         frqHoEOye1DpdgM26KdTgTFjpPlF+SQHmNszruZYkBqGqvUzktaWtCBuy3K8GExJj3jp
         vUezqOwQ/AGoEFL90CuF0kYzuejtes9OmvhJRk7yY1Mof/g+nEd0+o70ccYsg/vHt6wc
         QmFQ==
X-Gm-Message-State: AOJu0Yx5ATle4RCFZWUPq8WjEwvJpqb50lBfSim9S6K/bwyib2DKR3jA
	Q0VoRuMNQK1HoecScIl4IddNHiNvwTstAFkejL+KVbFyhvRC+QRYdj30EPvbfQ==
X-Gm-Gg: ATEYQzxIyJkAKwwMwKaXd/h3/FWYVlyAnUlnMOVm6ENXaX0MKg+BDykh+rAhL6dQdX1
	NupwfIOmpYH8IY06fBSNM7M/Om+AE2fAxr4lsylrTt6nMp/YfIvV7mI850eeg4ds7lvSBT15EFY
	POpgTvEwtgQ1Y4iYAH9w4VdZ3zP0uQTNKq6EDJsbgZkiESBHhKxr63POMXhbXWfTxL1kdkzXsAu
	c2Nddlgp0StddyqTvWhNsNNiTwtyfKNH4PreeHubIrlb+qsf7DBL4iWH00ltjaUlSKdlvNM6kab
	zM+l+PzyRcHP64/VMggzUe/gY/5l3yuH+a5OQKaLgQpbiJi44ls2xGPHeo7gNr01iqwABa2vdK7
	T9zJWS07r9i1bZrr8xujAKaWZW+hXa2Oxh9vz+1OzGXD4TKEffxl+xmeTFkoRdkdEVt7CLeO6GE
	wBWlHq4IRLDWdUesTMOpnpSHq+j4s=
X-Received: by 2002:a05:6870:15ce:b0:3d1:d26e:e163 with SMTP id 586e51a60fabf-41cec097d5amr8557994fac.3.1774937980576;
        Mon, 30 Mar 2026 23:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d049523a6sm6164086fac.6.2026.03.30.23.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:39 -0700 (PDT)
Message-Id: <50f5b4676e531c944ea40eaad265b14c2467a808.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:13 +0000
Subject: [PATCH v12 08/13] run-command: add close_fd_above_stderr option
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

