Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2443635A
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307517; cv=none; b=Ii/UXqs83JSqQTE9SJEkcf1yZOeFC6vpN0H2uJ6h8vBYFRsXDehXonYqYIZwBqyMq8zLlBboOozoY8ulhmH0ZgVO7W5hapBocWPoxUAUaJX8qrPsimUjUH7eQpwmzNdUrE8V2bl52Xg/gfsqsPRXKOdKWSskslRuxAexxNNFn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307517; c=relaxed/simple;
	bh=jA67dP6GW6ngi+BuKJ6f0wxmq3wQhrgpOYFUPwgRR8U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lvbP5ZSgROnX+rWp/9vaxc86u+xIJK8pMF7GcBxXiI0zlxAgIk1qb26HvG4nuWYcKldpoDrtucY1AMAzx9iP4S3yQzxJ/NR8jD+EcLI+GilR0wzSuUxngPS6FZBUzVwb8zdRTgk5QJ2Qy4RwltPT4o+iII5Zo0+3axwO0sxdR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQB5Jl8f; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQB5Jl8f"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b8392fb4dcso1073229eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307515; x=1770912315; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnx3S5XV2HL1VBZX75iXuPtTk+lcDqe4lq1Px5dCOG4=;
        b=BQB5Jl8fjDrqxfrkEXMzgXFf5fWBoZ8HUUU2tE3fYw3eUGiarsTS8ZTpcNypurUb7r
         l/c4bwIUKdYKeU/H7OOgg1K0no/WgLkWeBIGY037JftleM9XbmTSahM1WxFCi76OfLWg
         4ONrTq5l4F+g9qjgG2cSZ7hBtW4ODTKrN6Z0BzYfl2d4yBfZtrZBqBgcJK6baAmkDcvF
         J+GPfeUorn59Jr61QKew133JHXC3RKKJjsuJHSZEKvk7JK8SRlAjrL5pfyRTDlRB/xeh
         nCPOgjbeDRlYKCBQRk7eYzbg2vsDkxZ6iUGULfLQTldPTZeC7UkVmDP5JSryG4Yh56JD
         2GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307515; x=1770912315;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cnx3S5XV2HL1VBZX75iXuPtTk+lcDqe4lq1Px5dCOG4=;
        b=T87lH/EvubzlD2Vo3L87JlVJ6o+YpQ+4G6j8q3aOzUn+EHqyJGxxMyl5bpAOd1rNrP
         j7SeqFvOy30RTgk8JGrAANOxF5e/JHUtHHkjO8A46uhwVZ4YW/rM0J2s1Zagkb/KyV/A
         asXyUgtnp5JW5+CFGRxSAwB+uCTb0wTjsaU+CyI969MbHmLQnjjEwEbE+p3zh4Ek6k6l
         ieWupdRZlVeyjGPfgziuD8l7Dx/8Yf6AOnb9Wxtn2P6vQsxSUeAzz/yBkZos+igmEdl9
         SZDJVWi82M3l+YpjJRZRRQijcI+hN78A9ELcduFnD9glu0R+Rc/WcgHYGGe6LR/6lJ/U
         gvig==
X-Gm-Message-State: AOJu0YxcVx8tDiHmUYrXOkBIa6P9N38i00gShIwfeMiSowittEw+yuYh
	fQRK3f/sP5MjbIwqSg1nrtySYGUsycPL1JfXAzz09BRkyjcaxphGnDf9CIhBog==
X-Gm-Gg: AZuq6aI4hnyQ2dM4AZDMXm4U1JuWtouaxzTrka4lxL3Dx+v/2B/+vggXrvhIys8r7Jy
	OucayyrKTz3tnEFZC958izYwxJPzxXHOJKLTSqx8/PS/hBka5x02I78IdVQW1DcQ/dnqRKZqdhf
	W0wenzl73l4nIVSWFPG94EVDyh4XHCoeUMGcSpCqghyCsZxMZ00uKzjI1OSWMdgS5oITeyyqCzl
	23QOLEg17sSU12quNJ863qtCObzGMZimHHQLYZvAK46X/Idl31vNlg3eSmjfYk14swMYu1VdmMm
	XzGF6aa6Q5uEctS9zcuRasGY/6G6NIuXJ3U9DC0f8gm72aTpHxpgjAlPmE1WjSFU/zTQTJr2CR7
	9pnJ2yg/vXrNp8UMHF8X2pdABfyp87gc76jZ7yJ8LZ1zqPGaDx5pi87KEMy77i2BuVz3g0+o8kU
	O1W4bT7wcZojSZKtM=
X-Received: by 2002:a05:7301:678a:b0:2b7:3678:2d29 with SMTP id 5a478bee46e88-2b832a28ecfmr3089920eec.29.1770307513692;
        Thu, 05 Feb 2026 08:05:13 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e1299bsm3956067eec.6.2026.02.05.08.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 08:05:13 -0800 (PST)
Message-Id: <d99a30a1a77f0f23468dba987da08b32dd9a92fa.1770307510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 16:05:07 +0000
Subject: [PATCH 1/4] trace2: add macOS process ancestry tracing
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
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

In 353d3d77 (trace2: collect Windows-specific process information)
Windows-specific process ancestry information was added as a data_json
event to TRACE2. Furthermore in 2f732bf1 (tr2: log parent process name)
similar functionality was added for Linux-based systems, using procfs.

Teach Git to also log process ancestry on macOS using the sysctl with
KERN_PROC to get process information (PPID and process name).
Like the Linux implementation, we use the cmd_ancestry TRACE2 event
rather than using a data_json event and creating another custom data
point.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/darwin/procinfo.c | 99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 compat/darwin/procinfo.c

diff --git a/compat/darwin/procinfo.c b/compat/darwin/procinfo.c
new file mode 100644
index 0000000000..e0d76d81ec
--- /dev/null
+++ b/compat/darwin/procinfo.c
@@ -0,0 +1,99 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
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
+	 * Recurse to the parent process. Stop if ppid is 0 or 1
+	 * (init/launchd) or if we've reached ourselves (cycle).
+	 */
+	if (ppid > 1 && ppid != pid)
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

