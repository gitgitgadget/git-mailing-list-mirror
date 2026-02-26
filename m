Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B021253B73
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065663; cv=none; b=DVKmQYW0q6dGzxVsFhFI0Bo2vCsZ6Y+fg+7ioIYrFWFCaUqaLxQH2GeGkjHieryW2dXZA+oS1DLT5lQW1+eQbYjAOZX9OkDfdWJGRBNGFqPnbedoshM0qY3UZdAv6DVsa3CclgkA5TxV2eXNki0Ck/dMrULlY3squwAlcGq6rCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065663; c=relaxed/simple;
	bh=JOAUQgtalMHRhgdNV/YeiqvOLi3+yXa+k5LuMfKxqRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VbjK8LUNjusaPK/xESYCsmKxDEz5vDpXu7CY4LcQUtkreAPxrGqMJX/zmp7QzWgv5qCs5X+GPZR5J2COVVqPix9zWe/Xxcx2jsE9Cqjp4F5o7hNMtVphRtx8nIRaXZUrm5K/Ie+G9cIyM38Zd6l+U2IRALOIz3vdeDu/syAB7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL1JgqPO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL1JgqPO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1277e072e2dso794841c88.0
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772065661; x=1772670461; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbDNRmr8p87w3ZUQ1LQGNLGseO50776wwblaeHGbHPU=;
        b=XL1JgqPONBXV7NcrVKQ7OIhinBYv4NAycTxzsU+vJuV+DQDkhXcvBqdVDVa7fZuQJE
         cDzry0Dd8pT4GNSBG6wllfaBCmyWgNJAgWHp5swhHYgM+H+Nw8tXTJ5H2ZgpCPdP0TcT
         eZ8auZoEW2XdmwPy3nrGLje98/KX48NLm1mLS3W7/kB1jNTcCIgjdRS2M6StqKhWO/vx
         kiysFSoki++D6ziZMDGd3A2lzy/lNk0YgLVrIfxIEos/Y2H0O6+GR0q2JH/31TKv3yWg
         YLV2Xt+zQqM1yHLxwYYI+wlABR2L52lyaN4j8vGFk9DtMB48l5ZwEaV3GL5R9p783fu+
         y+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772065661; x=1772670461;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbDNRmr8p87w3ZUQ1LQGNLGseO50776wwblaeHGbHPU=;
        b=kVoRC/Smb6hD3e2cbzohBnpJ0BUNJV0E5Hqzyew9zTmfWa2zrCDvEWi8nfX8PvAznV
         N64fnolsgBBqfbDR0WCG5zsYBQeYfyiOScJ6GC1gmTehAKaShnCKB+wM+lKfV8req4oJ
         v6sbO9BfFPHDsH445MIHpfMLvR1XrS/o05r8valpKoUAD01t8m0ankPk4yyawtw+pdn0
         H46P2QIdHeUrW9gJYqYq7C/GAw66pqS2yDxRqCo/9SfBvIoKnr7FUE+SXlZ+yh8j8yTf
         KodwYEl5eRPTZMvGozWIE+EMxrr4QA3FT6aziWHXeq7gq6kIXFXo93UQRvn03h6ZhnK1
         3Ltg==
X-Gm-Message-State: AOJu0Yz16SztzTItsWQRIcp8MO2y1Wr5TIWcrwEPJDTKqCM2/r/0AApj
	z+umcau0vJLnsyN2k89dmg/Pfv5Xiyr6XPYyt0MMX4iJHqaZC47GiDGl915uRXcz
X-Gm-Gg: ATEYQzwCpt4VmAEV813hlqV2mHsimHtZq+IFwUb2H3KQ9+l/GKdCrzroSvUcAhZmchV
	iTxx7FG4kAyLWjuf3CFMjfBPwU8+jOInqt3zhrBk0jBVpXarRXdLIKE+OMUpUHbUitdaBgsRPA/
	8mLxyNxPYUOE6zwgagAdduDyOFb5+nU8wy2VqyTFhKntrKBFldfCqcXUsd3F1Cq+7kE4afIFt5K
	Lrq1+MdqyEOWxF9SMZnCkXkk1NQx0/wzjEpjLLateY0LXfArfmD2Zr6WJQ0hMDKz40Hqzx5bz+H
	nmKQEjsYNn1QrLNEui+b6vitgpa2wPPsTMvEk2GuzUsJsNEfGSdCMC/WSEt/U2UK4KpNCP+H5Np
	joOaIoyBTsi/Oe+QQKdGT2/Lf333GRjd+l3/Lb2D/nY0Ca+BW55SbVOGFzEym/+Yf44kGVe756d
	G54kFbPJ/uQx4hGBDtzksEeWvoug==
X-Received: by 2002:a05:7022:322:b0:11b:a8e3:847b with SMTP id a92af1059eb24-12789062f85mr461085c88.5.1772065660979;
        Wed, 25 Feb 2026 16:27:40 -0800 (PST)
Received: from [127.0.0.1] ([52.159.229.150])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127899df36asm497302c88.4.2026.02.25.16.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 16:27:40 -0800 (PST)
Message-Id: <c684fc90946d2944e1f6f9f09a882fcbc2b7b393.1772065643.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Feb 2026 00:27:22 +0000
Subject: [PATCH v7 09/10] run-command: add close_fd_above_stderr option
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
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

Add a new option to struct child_process that closes file descriptors
3 and above in the child after forking but before exec.  This prevents
long-running child processes from inheriting pipe endpoints or other
descriptors from the parent environment.

The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
capped at 4096 to avoid excessive iteration when the limit is set
very high.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 run-command.c | 11 +++++++++++
 run-command.h |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/run-command.c b/run-command.c
index e3e02475cc..cbadcf5ff8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -832,6 +832,17 @@ fail_pipe:
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
index 0df25e445f..a1aa1b1069 100644
--- a/run-command.h
+++ b/run-command.h
@@ -141,6 +141,15 @@ struct child_process {
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
+
+	/**
+	 * Close file descriptors 3 and above in the child after forking
+	 * but before exec.  This prevents the long-running child from
+	 * inheriting pipe endpoints or other descriptors from the parent
+	 * environment (e.g., the test harness).
+	 */
+	unsigned close_fd_above_stderr:1;
+
 	void (*clean_on_exit_handler)(struct child_process *process);
 };
 
-- 
gitgitgadget

