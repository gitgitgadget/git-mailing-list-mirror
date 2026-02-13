Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD982773EE
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012507; cv=none; b=HeDBnLDkEwrYWdiURnDq74dkccpMjCZhsuBg7G3Tlg55BXNuleRSx8mX6JHQ0/1RI6ih2mcuv3xwD//7w5T1XkxZxWlfmIk1UrIFojOcItIrYLHi1Yg0zkgC6XOwHuMFqoN7mX8w9PgiPZLJm5GAEq916HUN/da8ccB9/K6U3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012507; c=relaxed/simple;
	bh=SnFAEoGLTWx/w9i0kfJcZ1rh2GRd1THcnDXCqPVGi8E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xii+CUUN2BYKjDwPE5zCW9B04F52Qtl6rvrl0BrFkZ5zfoAzQzMCURXwsmJlIc3i5ssUdyVE198qt/R0gljEsYZT1t49DP7k2mbN8aNV9UImWmuzDSpzbvyvUKtjcAdLSNLrOrLi828qmfs5XwDTEASIcFGUqv2mn9bLMGiSo8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syu8NEmB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syu8NEmB"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-896f9397ecdso14557366d6.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012504; x=1771617304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmIV03m5mKxEGoecOF03Hso1FtheT3G/Py0ixArHlmw=;
        b=Syu8NEmBUQH19ys1HLyMv+FPSf+81zZelXscAQhR51RKn0Ius61am5wJC9PQl/UhbF
         mc8pyK0zxH80aF2EfEmrvOr9dKfyuogYgMAmuBVZy+y5F+p1vlqHxL2Y3gHoL6cSXchm
         KoU24oD7AOrBITgFWlwBoEIc6aPGUiGlA5DF227cjn9NdHIB5sG7SoYdzyRy0T9/+hcn
         o2klWlD6/Y8uYyrZLjwGeL2KzwMRS/90fINjDBGjYl1tOgBtWiDYW8ltqclHXtfvF1d1
         3rcKpl6687czq14BqfckNp9wCpRdB2zCtyrCqBwRRrNVwqENp97U//W0nL8CJFiSSKVR
         AxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012504; x=1771617304;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hmIV03m5mKxEGoecOF03Hso1FtheT3G/Py0ixArHlmw=;
        b=WK862mkR2jOdnVY+ySHliWx5RxZMZFrDRtsK36cpavpEfAp+H4G7+BDj+bKxbNBV//
         n+ZanMILfA5yjVyutwl1k6n1drJGYuLdmSF4pSGoA8MOoXq3h3tTn2W/Du1ODSOvl3LI
         MpP4LDYfltHc5yqu6eSe6158GI1S8TiWtAT/tUgvanBCwmlrAJlFZYGlIGbg0qhPjJ44
         n9K2Hbs2B4ja40/1YaUo7y/ST11FVtnKrvq9B/4fxKxW9ye+YjSg3yVcrlySUl9qJWxW
         XEYlZqiN0DQBTkOj6obXC+aeHUvEO3zqMuplvcalReWiQV86kjBXswsuPA2ARLEicNft
         z7CA==
X-Gm-Message-State: AOJu0YzWKK+V44hJaOy6J0TM1zZHWVzm4yo4PxgfY0yguOsIzTWJSRWh
	nwDIPWuTC09/wyqNXe2WEtWDRvY1DY/5GqyVZyJPRXlRnn8PWSocNb8hJIaAkA==
X-Gm-Gg: AZuq6aLACVA/NPozbFNHVr2j+BvMQ2whsv+TC2Jaei3+hR4faxaE4q0lM1XaouJNdjQ
	7AFiEMjxtU/y0D4hgHlfGjvZ+Fx2cCAgmIelQy20c83pl/8cn8VrThEG6LKdur+XS9Xw/YMsPy+
	Ye8972LfNVFDecaubXl1tpe4X40ZdAFZxAv3DbuFqgi9FMnVqUq5In0ZOQi/c09QYRP+tG6b7X6
	hHuKKwPIstF3FuCNxggToB7SG0cXqeSgdlEWgDRcLLQoQdHuMBpe9P5XJHqOHdqvCUBmh6lkDXc
	dk9NZPKxPgQqOBJ62exVl5SKck3yGeziuHFM6yaN2DMM7dcud7+mldRxgolt5r2XmCE/PUJQaj2
	SdH77R5GX5YFNvWipo7lLpS2um3T6OtNAfm7Q0EgnGDtgaoQKiPWQrSJk65B5ZWkmnMEwe/UQpP
	AzQAhyQWq4zp0JhHBQmczCk3XI
X-Received: by 2002:a05:622a:189c:b0:501:4fe6:5a5b with SMTP id d75a77b69052e-506a8387d14mr47354431cf.77.1771012504053;
        Fri, 13 Feb 2026 11:55:04 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cd8b330sm81902246d6.29.2026.02.13.11.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:03 -0800 (PST)
Message-Id: <233f6cdd33efdd91dd5b4a68f7b02d53c32a0739.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:55 +0000
Subject: [PATCH v2 1/6] trace2: add macOS process ancestry tracing
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

In 353d3d77f4 (trace2: collect Windows-specific process information,
2019-02-22) Windows-specific process ancestry information was added as
a data_json event to TRACE2. Furthermore in 2f732bf15e (tr2: log
parent process name, 2021-07-21) similar functionality was added for
Linux-based systems, using procfs.

Teach Git to also log process ancestry on macOS using the sysctl with
KERN_PROC to get process information (PPID and process name).
Like the Linux implementation, we use the cmd_ancestry TRACE2 event
rather than using a data_json event and creating another custom data
point.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/darwin/procinfo.c | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 compat/darwin/procinfo.c

diff --git a/compat/darwin/procinfo.c b/compat/darwin/procinfo.c
new file mode 100644
index 0000000000..c8954f02d7
--- /dev/null
+++ b/compat/darwin/procinfo.c
@@ -0,0 +1,97 @@
+#include "git-compat-util.h"
+#include "strbuf.h"
+#include "strvec.h"
+#include "trace2.h"
+#include <sys/sysctl.h>
+
+/*
+ * An arbitrarily chosen value to limit the depth of the ancestor chain.
+ */
+#define NR_PIDS_LIMIT 10
+
+/*
+ * Get the process name and parent PID for a given PID using sysctl().
+ * Returns 0 on success, -1 on failure.
+ */
+static int get_proc_info(pid_t pid, struct strbuf *name, pid_t *ppid)
+{
+	int mib[4];
+	struct kinfo_proc proc;
+	size_t size = sizeof(proc);
+
+	mib[0] = CTL_KERN;
+	mib[1] = KERN_PROC;
+	mib[2] = KERN_PROC_PID;
+	mib[3] = pid;
+
+	if (sysctl(mib, 4, &proc, &size, NULL, 0) < 0)
+		return -1;
+
+	if (size == 0)
+		return -1;
+
+	strbuf_addstr(name, proc.kp_proc.p_comm);
+	*ppid = proc.kp_eproc.e_ppid;
+
+	return 0;
+}
+
+/*
+ * Recursively push process names onto the ancestry array.
+ * We guard against cycles by limiting the depth to NR_PIDS_LIMIT.
+ */
+static void push_ancestry_name(struct strvec *names, pid_t pid, int depth)
+{
+	struct strbuf name = STRBUF_INIT;
+	pid_t ppid;
+
+	if (depth >= NR_PIDS_LIMIT)
+		return;
+
+	if (pid <= 0)
+		return;
+
+	if (get_proc_info(pid, &name, &ppid) < 0)
+		goto cleanup;
+
+	strvec_push(names, name.buf);
+
+	/*
+	 * Recurse to the parent process. Stop if ppid not valid
+	 * or if we've reached ourselves (cycle).
+	 */
+	if (ppid && ppid != pid)
+		push_ancestry_name(names, ppid, depth + 1);
+
+cleanup:
+	strbuf_release(&name);
+}
+
+void trace2_collect_process_info(enum trace2_process_info_reason reason)
+{
+	struct strvec names = STRVEC_INIT;
+
+	if (!trace2_is_enabled())
+		return;
+
+	switch (reason) {
+	case TRACE2_PROCESS_INFO_STARTUP:
+		push_ancestry_name(&names, getppid(), 0);
+		if (names.nr)
+			trace2_cmd_ancestry(names.v);
+
+		strvec_clear(&names);
+		break;
+
+	case TRACE2_PROCESS_INFO_EXIT:
+		/*
+		 * The Windows version of this calls its
+		 * get_peak_memory_info() here. We may want to insert
+		 * similar process-end statistics here in the future.
+		 */
+		break;
+
+	default:
+		BUG("trace2_collect_process_info: unknown reason '%d'", reason);
+	}
+}
-- 
gitgitgadget

