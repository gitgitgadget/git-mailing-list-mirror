Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57796C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417D6120D
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbhJGU1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbhJGU1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E96C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so22613428wrd.13
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y30qGrQx8eAssNy0LFqmXOHt40qdRcOF8U8iy1G9OtI=;
        b=d4WUWUoRzCVk++wvB7p+s9e80PP6tPljdxtAFLgv9QgEu0PuA45YFjMyT5l97Xnf5P
         Yi5iQxKK8M3WT0lXRtxWKPwu/nmgOl9F4EC+X0TbW1mx8MkBS/RU1Gr7tSdFlNva6OAz
         CrQ/4s0BPi4lFBP2vgbvAUvpptd1HgIcyS44OHkmx4DAoi9raWjDppF5jLolldqXhCap
         0hc2CFxVqw7ARpbSWYer2rGdBtb1pNJ4CF1wEyQn7XzLGlUFM8dlprruCZgqv6O9CRsB
         oKH+LVbyjvYEVSu+XYI8FekjVDuGqffqi5q0KRxQkXyGy3PUw4tIGE+F0proU84JnseX
         7QAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y30qGrQx8eAssNy0LFqmXOHt40qdRcOF8U8iy1G9OtI=;
        b=Ecqf1tz9MxAVKCL9B/goUHGUoS9sl/O+MwLWAXOFUxp0GMyQRr/VmEdkS5mwAUOsax
         whur9DR5i37KdwsW8xVm1+Z7/IAXmxPwO1aSwanwNZAuplG0S9P00/BfHtmmDC0z9rR+
         5iiim2sGBopmeMiay3s10FyYQEePzF1jbeG9kFzr0P+OAM9bMEC0Vmz/HHzzMytwFFva
         YXiX0GEluiTIWCZaStvVisDFhCPnJ0CGDJA0DzzsmKq5aLwLKtHa/XMba9Ph5AZ8jrbe
         sPCCQnQXEgPbVgtfWQuZmlb8ZaiODeFuglLnhGSFZmxKJgj8MRsFjKIuTotor0iUHjK5
         vIBg==
X-Gm-Message-State: AOAM533SyZrOk9gaHEV7rNfHhjBNL28by4x6L9cFCLSkmM+cYxeEPnpY
        n+hxAFgxNQZ4lyVBaXIEvOZtmJyvvNs=
X-Google-Smtp-Source: ABdhPJxfL8qUIQRKo7rwJgRSPNsyW06PdbMTUadJeNDMWYHcA9FE0TUBDFG9PlzqWUFGNt3ZGrP85Q==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr6871179wmi.122.1633638319949;
        Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k17sm379895wrq.7.2021.10.07.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:19 -0700 (PDT)
Message-Id: <bf51bc9ab0c724600806085ed387eb743161e250.1633638315.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:24:59 +0000
Subject: [PATCH v4 03/19] reftable: add error related functionality
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The reftable/ directory is structured as a library, so it cannot
crash on misuse. Instead, it returns an error code.

In addition to signaling errors, the error code can be used to signal
conditions from lower levels of the library to be handled by higher
levels of the library. For example, in a transaction we might
legitimately write an empty reftable file, but in that case, we want to
shortcut the transaction.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/error.c          | 41 ++++++++++++++++++++++++++
 reftable/reftable-error.h | 62 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 reftable/error.c
 create mode 100644 reftable/reftable-error.h

diff --git a/reftable/error.c b/reftable/error.c
new file mode 100644
index 00000000000..f6f16def921
--- /dev/null
+++ b/reftable/error.c
@@ -0,0 +1,41 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#include "reftable-error.h"
+
+#include <stdio.h>
+
+const char *reftable_error_str(int err)
+{
+	static char buf[250];
+	switch (err) {
+	case REFTABLE_IO_ERROR:
+		return "I/O error";
+	case REFTABLE_FORMAT_ERROR:
+		return "corrupt reftable file";
+	case REFTABLE_NOT_EXIST_ERROR:
+		return "file does not exist";
+	case REFTABLE_LOCK_ERROR:
+		return "data is outdated";
+	case REFTABLE_API_ERROR:
+		return "misuse of the reftable API";
+	case REFTABLE_ZLIB_ERROR:
+		return "zlib failure";
+	case REFTABLE_NAME_CONFLICT:
+		return "file/directory conflict";
+	case REFTABLE_EMPTY_TABLE_ERROR:
+		return "wrote empty table";
+	case REFTABLE_REFNAME_ERROR:
+		return "invalid refname";
+	case -1:
+		return "general error";
+	default:
+		snprintf(buf, sizeof(buf), "unknown error code %d", err);
+		return buf;
+	}
+}
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
new file mode 100644
index 00000000000..6f89bedf1a5
--- /dev/null
+++ b/reftable/reftable-error.h
@@ -0,0 +1,62 @@
+/*
+Copyright 2020 Google LLC
+
+Use of this source code is governed by a BSD-style
+license that can be found in the LICENSE file or at
+https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_ERROR_H
+#define REFTABLE_ERROR_H
+
+/*
+ * Errors in reftable calls are signaled with negative integer return values. 0
+ * means success.
+ */
+enum reftable_error {
+	/* Unexpected file system behavior */
+	REFTABLE_IO_ERROR = -2,
+
+	/* Format inconsistency on reading data */
+	REFTABLE_FORMAT_ERROR = -3,
+
+	/* File does not exist. Returned from block_source_from_file(), because
+	 * it needs special handling in stack.
+	 */
+	REFTABLE_NOT_EXIST_ERROR = -4,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_LOCK_ERROR = -5,
+
+	/* Misuse of the API:
+	 *  - on writing a record with NULL refname.
+	 *  - on writing a reftable_ref_record outside the table limits
+	 *  - on writing a ref or log record before the stack's
+	 * next_update_inde*x
+	 *  - on writing a log record with multiline message with
+	 *  exact_log_message unset
+	 *  - on reading a reftable_ref_record from log iterator, or vice versa.
+	 *
+	 * When a call misuses the API, the internal state of the library is
+	 * kept unchanged.
+	 */
+	REFTABLE_API_ERROR = -6,
+
+	/* Decompression error */
+	REFTABLE_ZLIB_ERROR = -7,
+
+	/* Wrote a table without blocks. */
+	REFTABLE_EMPTY_TABLE_ERROR = -8,
+
+	/* Dir/file conflict. */
+	REFTABLE_NAME_CONFLICT = -9,
+
+	/* Invalid ref name. */
+	REFTABLE_REFNAME_ERROR = -10,
+};
+
+/* convert the numeric error code to a string. The string should not be
+ * deallocated. */
+const char *reftable_error_str(int err);
+
+#endif
-- 
gitgitgadget

