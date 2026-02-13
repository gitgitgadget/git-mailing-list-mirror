Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB67291864
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012510; cv=none; b=BeRec2LzeqYj3uYfgFPhvxhNMyFChai3H5hmjQC0m6IhXYGcCEMAOUCXEOBVB8V0f8dqDZ4FhR9M9c5G3Gih5YOkk729VADkIs3eqLeO0k4RiyzxZw2Vcq23aPHsGbYOW7BAfdun5+/e4JPlgyKQsgD+rXDhp7X1sqZzzqna6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012510; c=relaxed/simple;
	bh=qWzrddP3qezZgnwazJ14EUOpBErVeYzNZFS0tGEPSLs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MfWCRM/pfAA98vSOzRXP8cdZl9hErwcKCfE4k8JKHP0DSI4+6lx9HUHff1DiG/AnyKszQdj8CDIk9Zj3tYQHDQojSjjVhn6NfxpDl+mDyGuLFBg7YZrKIxZcLTuIT9Wxa9exVHIbUhWwG9gT91NiOJ335Cdp7Ds0K0w7EkErFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP0zrgQe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP0zrgQe"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a93ba42dso10605081cf.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 11:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771012507; x=1771617307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAZPb6tr5Taaw7oc3H8HmOr06I6rmeyk/uX7faKSGwA=;
        b=BP0zrgQeYgNNtZHSalvLdhlZDWN2KSvEl79/1uXlodZoLdWUXSK8Uz7E30hgJZNp8D
         uxLir3aCoftbUN6HCtWsLZWXTOGC1lM5KGojNtPeLvtZbA/4AIewZeC/WpVPXlEH6VX9
         huGisrlsjmpvuK/A/tf1Fw5UlbeevYPk4p0RlcO2HAI2Bjcu6ZD2hs7Bc621ruaxB4Bo
         O62RTKgc/Nj6oqtL+NdPkPLvdQ8qx5M2U6UKFRcD5NOraHnV1AD/IlOtTVkDt8ed9sjR
         igXL9HKWn41GEaNkbdm1MjtQnQMuiE7gbeWYtaycLCWVzxdLhdLuu0pxG4F4XwKJ0SCn
         R5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771012507; x=1771617307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HAZPb6tr5Taaw7oc3H8HmOr06I6rmeyk/uX7faKSGwA=;
        b=Z5mzup4JsfPTvHbcQOHUXUYiVTmXOQWH+wUkWnuxMWV/mIce8xzFESARwMWclTCsKV
         G0Vyu+dJLTMrCMKUMZI59I6IwDGGjeK6tsZahjcK9KB1QbpVw3JXPb3t15lfT0nOESHD
         OKlGuSl6zRO8B+oyiSBI7VVeLAgl/5InppJBu7jCp81meKh3+bhBZw0Gf9ZH3/rOi2d5
         6Nwz0oAQRguXmEJetvT58fyhbu9ylOoL4VNgSOTl1AewUro1tldZskCqzRLd/TBw14rX
         PO56FRimuDbYnBIDq+5JaTX5Dwau4K7qAfq2Q57NlPnyjmsXKsTLU07XH5NRCyg9K0q0
         lwaw==
X-Gm-Message-State: AOJu0Yy6PcTmmOf7BiaD4jBwrmL8KIFu9vBLFuz3RBT6uzixAjhw2X4T
	ZV1udGttMqx0RfluneJpo38ZSn4qMA4GWl7T/EHuYFv5D50EpZmeUZJ3aJ1TwQ==
X-Gm-Gg: AZuq6aJB+81e9B42/Fs9PC8Bv5rPJGxCdN+2UV6MWH1Cj+KEwZaN9izec09F/WAWgvK
	69EQ+MQUCeuIv7UA9JQa9gqFoRxjx1zZlBezm5uN9uvoNQcGh6oUk0tCjEhgYa90okfjnb+GS+s
	/QCR279i+1w/eg45QIw0Zkqz2c6PtQy08K4jZd+xWSIf/JqafVrsO6ku6wybGHS1EeO71yGIyXZ
	EcKcrzrDI7Ij2rS06i+bEY9m6kMELb9ryi3peDBAuLgZOXziLDGaybFYwrYr5KWliwihs8AJ6Gb
	N1tJzex1my/KJ71PPUpI8n5YKdzI9BpKiMtUyGUVvp2wYgCKaKkIrphGHMMztx3TW9daH+ZanP8
	Ci0/5l/DkbTlwIxgh2/FkcLRSyjHnuLgnKHzXqtVjEgYLXFZ1DmasDaidjQIlej1odQNeXSCTrm
	B45gHtUjjYVCNQr2bulQTEJK2c
X-Received: by 2002:a05:622a:255:b0:502:6312:8d6 with SMTP id d75a77b69052e-506b3f7d835mr8997261cf.12.1771012507446;
        Fri, 13 Feb 2026 11:55:07 -0800 (PST)
Received: from [127.0.0.1] ([64.236.135.10])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847ed9c4sm69973191cf.8.2026.02.13.11.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:55:06 -0800 (PST)
Message-Id: <2b02f62f0df7ad2ca5356813780577facf02a58d.1771012500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 19:54:57 +0000
Subject: [PATCH v2 3/6] trace2: refactor Windows process ancestry trace2 event
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
2019-02-22) we added process ancestry information for Windows to TRACE2
via a data_json event. It was only later in 2f732bf15e (tr2: log parent
process name, 2021-07-21) that the specific cmd_ancestry event was
added to TRACE2.

In a future commit we will emit the ancestry information with the newer
cmd_ancestry TRACE2 event. Right now, we rework this implementation of
trace2_collect_process_info to separate the calculation of ancestors
from building and emiting the JSON array via a data_json event.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/win32/trace2_win32_process_info.c | 50 ++++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index f147da706a..aceea05430 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -3,6 +3,7 @@
 #include "../../git-compat-util.h"
 #include "../../json-writer.h"
 #include "../../repository.h"
+#include "../../strvec.h"
 #include "../../trace2.h"
 #include "lazyload.h"
 #include <psapi.h>
@@ -32,12 +33,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
 }
 
 /*
- * Accumulate JSON array of our parent processes:
- *     [
- *         exe-name-parent,
- *         exe-name-grand-parent,
- *         ...
- *     ]
+ * Accumulate array of our parent process names.
  *
  * Note: we only report the filename of the process executable; the
  *       only way to get its full pathname is to use OpenProcess()
@@ -73,7 +69,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
  * simple and avoid the alloc/realloc overhead.  It is OK if we
  * truncate the search and return a partial answer.
  */
-static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
+static void get_processes(struct strvec *names, HANDLE hSnapshot)
 {
 	PROCESSENTRY32 pe32;
 	DWORD pid;
@@ -82,19 +78,19 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
 
 	pid = GetCurrentProcessId();
 	while (find_pid(pid, hSnapshot, &pe32)) {
-		/* Only report parents. Omit self from the JSON output. */
+		/* Only report parents. Omit self from the output. */
 		if (nr_pids)
-			jw_array_string(jw, pe32.szExeFile);
+			strvec_push(names, pe32.szExeFile);
 
 		/* Check for cycle in snapshot. (Yes, it happened.) */
 		for (k = 0; k < nr_pids; k++)
 			if (pid == pid_list[k]) {
-				jw_array_string(jw, "(cycle)");
+				strvec_push(names, "(cycle)");
 				return;
 			}
 
 		if (nr_pids == NR_PIDS_LIMIT) {
-			jw_array_string(jw, "(truncated)");
+			strvec_push(names, "(truncated)");
 			return;
 		}
 
@@ -105,24 +101,14 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
 }
 
 /*
- * Emit JSON data for the current and parent processes.  Individual
- * trace2 targets can decide how to actually print it.
+ * Collect the list of parent process names.
  */
-static void get_ancestry(void)
+static void get_ancestry(struct strvec *names)
 {
 	HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
 
 	if (hSnapshot != INVALID_HANDLE_VALUE) {
-		struct json_writer jw = JSON_WRITER_INIT;
-
-		jw_array_begin(&jw, 0);
-		get_processes(&jw, hSnapshot);
-		jw_end(&jw);
-
-		trace2_data_json("process", the_repository, "windows/ancestry",
-				 &jw);
-
-		jw_release(&jw);
+		get_processes(names, hSnapshot);
 		CloseHandle(hSnapshot);
 	}
 }
@@ -176,13 +162,27 @@ static void get_peak_memory_info(void)
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
+	struct strvec names = STRVEC_INIT;
+
 	if (!trace2_is_enabled())
 		return;
 
 	switch (reason) {
 	case TRACE2_PROCESS_INFO_STARTUP:
 		get_is_being_debugged();
-		get_ancestry();
+		get_ancestry(&names);
+		if (names.nr) {
+			struct json_writer jw = JSON_WRITER_INIT;
+			jw_array_begin(&jw, 0);
+			for (size_t i = 0; i < names.nr; i++)
+				jw_array_string(&jw, names.v[i]);
+			jw_end(&jw);
+			trace2_data_json("process", the_repository,
+					 "windows/ancestry", &jw);
+			jw_release(&jw);
+		}
+
+		strvec_clear(&names);
 		return;
 
 	case TRACE2_PROCESS_INFO_EXIT:
-- 
gitgitgadget

