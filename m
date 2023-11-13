Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949319BBD
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XB330UzV"
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744310DB
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083cd3917eso34522845e9.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871060; x=1700475860; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwDa/zirDJc5nfx2Jg49qoDCUK60ez7e62AeKwMOj8I=;
        b=XB330UzVLnDWNbUJfx8A74xYAmnYVmz3n5LyC4IxVTsC28aN74yimtBhWQxnMm8ak5
         6KAo2wATt+RJ/zXnLnybqS3aCmcpcy+CkKOPfENNqCXRyWeaJ35iPJCDRIrdATeKHXOx
         McaeqtwxrZM15AWrp7Mk7opd9DcjEN6SrLMquorUZTI+6SOWA8e7ozA2EApL3XGFWpWH
         beVkhxFVFIMOnAcC/kF75++FUnlBfjkGLJqMI/pNdKxSDqO4RQl1VA0SvMK1uXNZ/5RB
         9yvO8s7K9quTOUOEx8zklyukgFESICK1GvPs5f7DDqSwgT4EqIiOI0o4OtPS9FjB2TxZ
         /ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871060; x=1700475860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwDa/zirDJc5nfx2Jg49qoDCUK60ez7e62AeKwMOj8I=;
        b=qoBKmCWJBRlgjIZXAkzeXyiqHNp2xfZf4CcsFelYpskT4tFHbQI8Vp7w5FBsX9V/GS
         YTSfd52jm80KsFcmmmZUH2XRQOGHIKzgrXDL4bIt/5Ct3EVoetrifJazWzG6XzqpTAqA
         8/rfqm3ytxWaHmYtKdlHJmw3xFLNhY0zkrcnBsAUYf6Z6IxWF20ieev8V2++AkvLzfbj
         BqEi/Iv4fnQiNhu6KyHHqEARziBqplg1a+0nqfmktRpBEoc4ZywwXhFjYj5rD7loVTJ8
         X0uTFfL3aq6MF3CoIbQ12G1oMzKtcK7scQI5Y8jP1h9U3LL5N3Ab7dfwvMQ6A0oRCJg5
         LwSw==
X-Gm-Message-State: AOJu0YyMFyq+w9kyH0zfRpCj7i0XSZ73zanL3JY9ts3gdHiXZyl/4P6E
	RbWRIlRB1K6nGj4wvdk3nTZL/egrEZ0=
X-Google-Smtp-Source: AGHT+IFfjNvSHy4dLNK9YFHagGZP5725qzr6BCHPm7tHvh2FhK0vaniXd3CbX9mokNCCKhyKWZxYFg==
X-Received: by 2002:a05:600c:6001:b0:409:7d0:d20b with SMTP id az1-20020a05600c600100b0040907d0d20bmr5143353wmb.24.1699871059593;
        Mon, 13 Nov 2023 02:24:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b0032dbf32bd56sm5062384wrs.37.2023.11.13.02.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:19 -0800 (PST)
Message-ID: <e31be0d764f47c21519016729259f8d74a53e21f.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:05 +0000
Subject: [PATCH 03/13] spaces and errors fix Handled git pipeline errors
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
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 builtin/hash-object.c |  6 +++---
 convert.c             | 22 +++++++++++++++++-----
 entry.c               | 22 +++++++++++-----------
 object-file.c         |  6 +++---
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index b33b32ff977..9129658a37c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -62,8 +62,8 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 #  include <stdio.h>
 #  include <stdlib.h>
 
-   int setbinaryfd(int fd)
-   {
+int setbinaryfd(int fd)
+{
      attrib_t attr;
      int rc;
 
@@ -74,7 +74,7 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 
      rc = __fchattr(fd, &attr, sizeof(attr));
      return rc;
-   }
+}
 #  endif
 #endif
 
diff --git a/convert.c b/convert.c
index 4f14ff6f1ed..17cc849efed 100644
--- a/convert.c
+++ b/convert.c
@@ -1315,15 +1315,28 @@ static struct attr_check *check;
 
 static const char* get_platform() {
 	struct utsname uname_info;
+	char *result;
+	if(!uname_info.sysname)
+	{
+		result = (char *)malloc(strlen(uname_info.sysname)+1);
+		int index=0;
+		while(index <= strlen(uname_info.sysname))
+		{
+			*result = uname_info.sysname[index];
+			++result;
+			++index;
+		}
+	}
 
 	if (uname(&uname_info))
 		die(_("uname() failed with error '%s' (%d)\n"),
 			    strerror(errno),
 			    errno);
 
-  if (!strcmp(uname_info.sysname, "OS/390"))
-    return "zos";
-  return uname_info.sysname;
+	if (!strcmp(uname_info.sysname, "OS/390"))
+		result="zos";
+
+	return result;
 }
 
 
@@ -1331,11 +1344,10 @@ void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path)
 {
 	struct attr_check_item *ccheck = NULL;
-  struct strbuf platform_working_tree_encoding = STRBUF_INIT;
+	struct strbuf platform_working_tree_encoding = STRBUF_INIT;
 
 	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", get_platform());
 
-
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
 					 "eol", "text", "working-tree-encoding", platform_working_tree_encoding.buf,
diff --git a/entry.c b/entry.c
index df6feb2234b..f2a7b2adbf5 100644
--- a/entry.c
+++ b/entry.c
@@ -130,17 +130,17 @@ int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 void tag_file_as_working_tree_encoding(struct index_state *istate, char* path, int fd) {
 	struct conv_attrs ca;
 	convert_attrs(istate, &ca, path);
-  if (ca.attr_action != CRLF_BINARY) {
-    if (ca.working_tree_encoding)
-      __chgfdcodeset(fd, ca.working_tree_encoding);
-    else
-      __setfdtext(fd);
-  }
-  else {
-    __setfdbinary(fd);
-  }
-
-  __disableautocvt(fd);
+	if (ca.attr_action != CRLF_BINARY) {
+		if (ca.working_tree_encoding)
+			__chgfdcodeset(fd, ca.working_tree_encoding);
+		else
+			__setfdtext(fd);
+	}
+	else {
+		__setfdbinary(fd);
+	}
+
+	__disableautocvt(fd);
 }
 #endif
 
diff --git a/object-file.c b/object-file.c
index 28e69ed1e33..562d1344422 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2557,15 +2557,15 @@ int index_path(struct index_state *istate, struct object_id *oid,
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
 #ifdef __MVS__
-    validate_codeset(istate, path, &autocvtToASCII);
+	validate_codeset(istate, path, &autocvtToASCII);
 #endif
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
 
 #ifdef __MVS__
-   if (!autocvtToASCII)
-     __disableautocvt(fd);
+	if (!autocvtToASCII)
+		__disableautocvt(fd);
 #endif
 
 		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
-- 
gitgitgadget

