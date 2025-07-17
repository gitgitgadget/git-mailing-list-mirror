Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81319AD5C
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716063; cv=none; b=LHutFY2H6wPDkWFdSpm3lhX3F+VcsUTeueOuBcq1gE3uRkXKSBZKAKU6xcftONx4BlwHHXbpbAWC7mkHx/1LiLYjXf5dWOymSOY4P0GPf1Rr5CjJkhakucni9k48CGGjCnFRIhaOo/t5x7facECIdv0cY8bACbcrUjIs0pH60T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716063; c=relaxed/simple;
	bh=DpnUQrb19GoTtmykqzkly3RG5vdALJSoAs4xaQev+Mc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=s7kF95JwIBcdDrNUzuwLYrT/xNYNaMJVC4rI1b/VuyfrcqjMZLe9DyF5aplWIMAKp885I/pfyqFuqSHXPZZFPA1OiNXxoJakAlQCg8FaSAx8reUY4tyClw3JatrkH3wcL2/SNvs+O6pfQf49ookd8QtFIRFtSTE1I18+hWmTYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJG6VJX4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJG6VJX4"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45611a6a706so2011345e9.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716060; x=1753320860; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioN8aETL30G2VEfYv4FdGTXnRpnxg9BqxdmfmnGSflY=;
        b=FJG6VJX4ygwL8kA6yY4cwsWI/FX+mnmalTmK1Kk02iVEsD/YnrsCCv4OEFX2bpmZyD
         mZfmAoEpO4DI4oCVkP3vKDU1Cy8Fnejh07Gurk8jSArlg0h4ly9V1EiDivzQcA6RoN6Y
         LLBBI5aDq3Lqu0/TuCG5u2VToak5+TAVQW10c0yLeArLj/N+z3WYhAIX6L3l34H6G55O
         FfpFRl8vJeQhlxivObci4IN425KeekJwpfSlmw2VMw8VqD9BD8pmcVrRLImD437pC6Kb
         mN1OhmkAJt7ravT5hpdxheTN+1SbjZ7FXTiUm3+Q2Q9w9/4jDwI8IC7GEdRt/HB2+v/w
         YMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716060; x=1753320860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioN8aETL30G2VEfYv4FdGTXnRpnxg9BqxdmfmnGSflY=;
        b=dlfPXLHPUILk7RI3w0+bQzttaDqQiu7Tdh67DmFO9qbJqNja0vaa3Cn/mV73PnVyoQ
         crpVOKv03IDlTuIK82kouKR2WJdAXbDXadfiy1G5ZWD3uyAhDg2lzpw+YbLDjAqtyaeP
         48lUQ0Yj8qsRtggjFS8DplzVlR2S5Z+vDw6tw5D7D2ICxadBNv6lR8IASXEycKvLcQUA
         YEE4BPKE46j7NqaQXmLcrZFErpYIKleagKpYtrX0wgSMbumnE/RcB1U7DURvQZYYBfTM
         hfIoIZWjkoOS2G/ZeZTI/b5IQo4r4lPwYlxWf5zHFjT7ut2M/PdlI7TyrzYhwFnxAT7S
         dy4g==
X-Gm-Message-State: AOJu0YwryIUbfisAGMWHQr3HRtmNtYv2bGE32ezDECBHaHrKZaJO8YLg
	aGWek+vNeNtUvWXzlG+MVu0s4aBVrgxr0Be+eF2fXaFRBnl07tGmq9lcp+oZ5Q==
X-Gm-Gg: ASbGncu9StqZwvDZ7LIh+VtID3AaPmcyNfH+V4Ys9EK8Fxz3l7YOWsPZf6799USg7jc
	/HNb6khdGiMGq5TKOmAk0uFnAN6eWX6L9mSBSW4VECvWn+Nn7dollJEWMrx9tL/SYzuvxCITbWQ
	LZxPxlgzK6HpDDSNfyTLAZT9xOeA04lgdwgczVsdXQ2DWSxi6uMeEQhXTZHhs6HygJyqqFUavtD
	UyYgcV4DCydgLtsjxofohf394at7YmShsdGHSGGuOsKgmcaZsOeTow0jDvCjOuOE7NZALCK7zHD
	/uZ7SSudao4wYdeyGcDKXhD/NxX9JtbGbtzrm9dzc4xAucKQUpu7tkp8jf2U2n0TVtpN9B9Bo5Y
	1mgAiN4gTwXoVw1tptupkAQo=
X-Google-Smtp-Source: AGHT+IFmrZaSqQa5RgtQCX1RB3raZWwvttPpvvukd7mzkCC+hQhcpZDPF9wX/wRZoXvpimP/qPRl1Q==
X-Received: by 2002:a05:600c:4f08:b0:450:ceb2:67dd with SMTP id 5b1f17b1804b1-4562e38afc4mr40444395e9.33.1752716059579;
        Wed, 16 Jul 2025 18:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80246asm35651265e9.10.2025.07.16.18.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:19 -0700 (PDT)
Message-Id: <fd9a20a392265a5aaed27301a3b324164bb0af86.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:10 +0000
Subject: [PATCH v2 4/8] dir: add generic "walk all files" helper
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
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

There is sometimes a need to visit every file within a directory,
recursively. The main example is remove_dir_recursively(), though it has
some extra flags that make it want to iterate over paths in a custom
way. There is also the fill_directory() approach but that involves an
index and a pathspec.

This change adds a new for_each_file_in_dir() method that will be
helpful in the next change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 dir.c | 28 ++++++++++++++++++++++++++++
 dir.h | 14 ++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/dir.c b/dir.c
index d2b0a5aef670..2e567ff92746 100644
--- a/dir.c
+++ b/dir.c
@@ -30,6 +30,7 @@
 #include "read-cache-ll.h"
 #include "setup.h"
 #include "sparse-index.h"
+#include "strbuf.h"
 #include "submodule-config.h"
 #include "symlinks.h"
 #include "trace2.h"
@@ -87,6 +88,33 @@ struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp)
 	return e;
 }
 
+int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const void *data)
+{
+	struct dirent *e;
+	int res = 0;
+	size_t baselen = path->len;
+	DIR *dir = opendir(path->buf);
+
+	if (!dir)
+		return 0;
+
+	while (!res && (e = readdir_skip_dot_and_dotdot(dir)) != NULL) {
+		unsigned char dtype = get_dtype(e, path, 0);
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, e->d_name);
+
+		if (dtype == DT_REG) {
+			res = fn(path->buf, data);
+		} else if (dtype == DT_DIR) {
+			strbuf_addch(path, '/');
+			res = for_each_file_in_dir(path, fn, data);
+		}
+	}
+
+	closedir(dir);
+	return res;
+}
+
 int count_slashes(const char *s)
 {
 	int cnt = 0;
diff --git a/dir.h b/dir.h
index d7e71aa8daa7..f4235cc12a2f 100644
--- a/dir.h
+++ b/dir.h
@@ -536,6 +536,20 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
  */
 int remove_dir_recursively(struct strbuf *path, int flag);
 
+/*
+ * This function pointer type is called on each file discovered in
+ * for_each_file_in_dir. The iteration stops if this method returns
+ * non-zero.
+ */
+typedef int (*file_iterator)(const char *path, const void *data);
+
+struct strbuf;
+/*
+ * Given a directory path, recursively visit each file within, including
+ * within subdirectories.
+ */
+int for_each_file_in_dir(struct strbuf *path, file_iterator fn, const void *data);
+
 /*
  * Tries to remove the path, along with leading empty directories so long as
  * those empty directories are not startup_info->original_cwd.  Ignores
-- 
gitgitgadget

