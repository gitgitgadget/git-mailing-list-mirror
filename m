Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540441F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBGKqJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:46:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42611 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGKqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:46:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so10947552wrx.9
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hNHnSSFn/whvCsWLxhuLJrT/GLG5SDi31v/hFLQIgrM=;
        b=WRexIELcv56+bi9M9ZbrkXkZiOywZk9sxMY9eKFp+AfnkxXAVZTSYfOl80kf+hs+6K
         4gRigk41guHPp2AXvxq1XVX+onWDVVhtr3AoLaMiLOc3UGltaIbE0QtZtGDDTIRAadlG
         g/0365OMGPxNHIeuqszDWjSTQ0/IieLJTQfpmAMkTSpsEAQImCtuM4bfxlVs1k3rQCXQ
         vQV9p0xUk/8g7sXSUTeLnrds7BfSwsW+VItGZe5PfLHK5PUGf010WrSTMtmp+hthfpNt
         +klOVzeWi4JYK2Ca5svdze6rH2BddAMwFVHnCMBKXU1GSLne1YHYZt+/DV9IpZZVNKmR
         7j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hNHnSSFn/whvCsWLxhuLJrT/GLG5SDi31v/hFLQIgrM=;
        b=mZpz2yba5F2jx1m+0pkYvPdL3Q/sjCP8CnXemQlcbdavyNhDBJnKVD4CmBRT52PhWz
         1oCu5lbs5GIZVJmlGnuhf0x8Tpu/XjSQ/Z4F2tKxyHjdEsQRI0RrGfTYAibnJ7JHjK8k
         b9aMfKNQycF1WfAvKk/HP19094YfAj/UfAloH2aEjf0ip9TRhPlUWhfWBMpVYdidh5AJ
         1PrBAwGqsK8s8SPq+9etqt3slxKyzuBJeYdxK8ASNP2cIB1EfR5c1oLuhXv1TNMboqyj
         nPf8D8nXfGkDDmgMOEGdQmMYQSYmxhgI5hqfVSok+LhE08hI6ITgPvyuyPP2SFetGkNC
         bhBw==
X-Gm-Message-State: AHQUAuam6OxSSVN2lXjxTU6p+nbZnIj9B6r018nZ83ruok6NW2SPppSM
        qHyHnVY8VTO7ne7Wnpbo4CZT+9WY
X-Google-Smtp-Source: AHgI3IY/Um7ZSTkptNUeaMyvBoY64bsDMubGJaiKhuBXYQd3TCbKzDsYM1E8B3caAhvJyfKPJ8FbUg==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr11086379wrj.91.1549536367064;
        Thu, 07 Feb 2019 02:46:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm15937936wrt.10.2019.02.07.02.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:46:06 -0800 (PST)
Date:   Thu, 07 Feb 2019 02:46:06 -0800 (PST)
X-Google-Original-Date: Thu, 07 Feb 2019 10:46:04 GMT
Message-Id: <cca9a543d52f3d7d9015709800e10ea57be1fea3.1549536364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.121.git.gitgitgadget@gmail.com>
References: <pull.121.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: fix CPU reporting in `git version --build-options`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We cannot rely on `uname -m` in Git for Windows' SDK to tell us what
architecture we are compiling for, as we can compile both 32-bit and
64-bit `git.exe` from a 64-bit SDK, but the `uname -m` in that SDK will
always report `x86_64`.

So let's go back to our original design. And make it explicitly
Windows-specific.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 30d9fb3e36..98407744f2 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -6,6 +6,25 @@ typedef _sigset_t sigset_t;
 #include <winsock2.h>
 #include <ws2tcpip.h>
 
+#ifdef __MINGW64_VERSION_MAJOR
+/*
+ * In Git for Windows, we cannot rely on `uname -m` to report the correct
+ * architecture: /usr/bin/uname.exe will report the architecture with which the
+ * current MSYS2 runtime was built, not the architecture for which we are
+ * currently compiling (both 32-bit and 64-bit `git.exe` is built in the 64-bit
+ * Git for Windows SDK).
+ */
+#undef GIT_HOST_CPU
+/* This was figured out by looking at `cpp -dM </dev/null`'s output */
+#if defined(__x86_64__)
+#define GIT_HOST_CPU "x86_64"
+#elif defined(__i686__)
+#define GIT_HOST_CPU "i686"
+#else
+#error "Unknown architecture"
+#endif
+#endif
+
 /* MinGW-w64 reports to have flockfile, but it does not actually have it. */
 #ifdef __MINGW64_VERSION_MAJOR
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
-- 
gitgitgadget
