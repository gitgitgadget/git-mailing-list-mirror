Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D352D9796
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259678; cv=none; b=c3UUOyQIqB3C+BHk7T7CPM9uJ3ay0tvVYDkmAXyQaqD1UmzIIcKmYum7yiAZGIFtS1kl+DAKMvE99s8pvO7OaLyK743NqSOMIrzL6H6UJm8kMR7DNR3IPCtAJsV974uGPIQyaZd42tv2GH/BREBcK3r+aeYI3WGsH/H5gVE01MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259678; c=relaxed/simple;
	bh=okdl+0uUaqS6blDRN4er+hR3UqeoFu6NWPRmZZPDXeM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JH67UTF1EjdT5pUq9O63qR9LYFEN6POrKMljNtTa5TlzfHsNsEj+w1WAjvxbMEtD5J04BA2d25f7+3Ic96Xt0BbLq6YdUxjYKDcjphJkuflefo2EtgTjWO0q24Km76REwm9XPdwldNygVumnpalRD4gmlZ2QHoEtND2D9OpBpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMNfAfDE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMNfAfDE"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d00cf835b7so818896185a.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259675; x=1776864475; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=qMNfAfDEBG2RwJeQ2FDdmUpuwPMi1uIGE46/38/Ts1KBLqCo7MDZPVDO5tZNsYEBmo
         nLwPwdjCOcT3pDCicXTwrrVANxEB4mkFadouNQet4G+SrZhEYIiYauZ0tYPpFsff0s3U
         tJ5OBPOk5yJLs4SF/FffqMIOiMqGYSyYl5oRuT9ddU+HvbAaTrkbYZrwf8iMT73D9TT7
         l08+myqyuTcItJxYRKLylZfmpIycRC89xkvxSRZaLrZQUeXA9wX9Ohb4bCI0P0eKhf7g
         6MyfSrmAA5oFfR4CbN8ejOdKI7nUcWSfkAEu3qDOK16NZ8+i2x3+pwas3I/hSuRDZzUt
         vWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259675; x=1776864475;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PffDS7jGun3N+EJo+Gp9zmhN5XDrSZ0tZDgx/HswZFE=;
        b=hkOKMqd9GcB2WPc42J4xQ7YiLSxL3PdcjPn7R9IOhk4p5NuDZo0LUD6OD1suWEO1bM
         Q/IsiqRs/Z6fOSb4yLDrxBXB/HRufpgFh3slfANCFTveHeyhLyVvU/dpCFp6/MrxMrS8
         XyUCp2Fds92k7612BePKdVmJtuLAJ7NiiQ2+CL8ENR+v6J5KYbL+eZQv4O+Q8IdaBM9M
         J9emufp/Tc/YXvo1+IzZBI1Gq/HgVLNX4I8PlPfSHStynUgf4Vcq2PA4AuFUOo0b0Ob0
         VorNNW+hoJ5E4VTNXPREtsiRFIlgKEbipQynRvBOx+/CPHWV09tvYg4ADCQK4qwJDCf1
         oEIg==
X-Gm-Message-State: AOJu0Yx/UKEX2VPYr7p3t4l3Clj7mUnVf0XcMCraz9ThCJYZ/1fLVsZ5
	2kSgPVGXBsnCt4ARaPouIdI35djW6z88AyKoZCOM6/ND5mmsHNH1BNFbOG9msg==
X-Gm-Gg: AeBDiesGLzXdNdxgiRWjPAHAw1SyzT3tJzPnXDThgbSZDsppBxZPP9sbNRmmKWGOEoj
	QkFlNn/NwjUKV6LeY2SECJrAuhzsBF30G8hDZR4lArYHvbFfKIe7PJ6YthiG3UW4snSIcnFHazM
	3yKhoj9FQRly4iF/zKkZKB9hwfcQupFSmB226GYB9ZGKZaGhU7PwvDoQ5g68CKgi9pdFdxG+BoX
	QBrqoB2QiMKSP0m4A0Hp43bpvTmXBedalkVFrXylo8I3o1sjxk7z2kz04hnAbNFXXDSbqKosFKd
	XegIRNx2s5RBMkRuy+JCT5k1m6PsiYOiahmQEG9hSInVvICfKxvNtJqpNSBgzqxzEDWlHgD8Olp
	STbjFxbQHpDIarOLKO+4xVepy29ayQKs8HK/B7GXrPDf0vzlHEQUNJiuaj9tL4dDt3dduD+O5sV
	wMWrVbX2p5fbExAtS9dK2ugNYkig==
X-Received: by 2002:a05:620a:4504:b0:8d0:3c58:c7c5 with SMTP id af79cd13be357-8ddcfe9dd49mr3222178485a.58.1776259675114;
        Wed, 15 Apr 2026 06:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4ef33b2a6sm117342085a.14.2026.04.15.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:54 -0700 (PDT)
Message-Id: <5791edbef245a00c158a8c865a0a9eb052151fbb.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:33 +0000
Subject: [PATCH v15 09/13] run-command: add close_fd_above_stderr option
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

