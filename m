Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDFAB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJDCda (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:33:30 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:43601 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbeJDCda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:33:30 -0400
Received: by mail-pl1-f179.google.com with SMTP id 30-v6so3963774plb.10
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eaCap+4eG7xnx8/kcNiGRQmECQLgnN8QRuovxIBGM1I=;
        b=IFTHDuUphSOmIxgrznYilkp4VQ4++2MceQ8k6Or8W3Qc8pxHdjpv7f+QqB0EGbX/SZ
         pMahDoHNg2QBkqKsVhzN9VWRzYn8GjqfmjVfHKMmCC+LU4ONsoLXi7EMuBBvny+dV4+6
         ZCNw228lcojk1vyte/GvGR9c6eAGST/LoebdC0Ukk0i9YDEPqfQQKKFp91Yj7oxjzmel
         UmSSz7UIojG8Phf181Oy73CgBe58ru4358v4JPH34JZGGZCjbpQAvMqNdxakasH6clKP
         p0zWX2qyDRGw6mjS7weiqWeVwQZbFuf7a6K7qS0HNzJc+2strFk6BJLM76rY7uGRvP0M
         K8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eaCap+4eG7xnx8/kcNiGRQmECQLgnN8QRuovxIBGM1I=;
        b=WvE7y7edhT/sEbfAF517FWMY/7uPpRglxPkPgHeYmtbw/J+Z+INfeIzDDUOv4ERBUL
         q/cLURp64ZaeewjCQ+oYwpOM/8nINmZNJ2XuD4om+GkMMnauWi2bDo/Vb2d7+EFRgqkR
         7jr429dzzXGAc5X1cpm4Iwb5y5+nf7whI/nFDwyvPfqS64Bc2b0rHRsdjvKQapdeGQJg
         iTzemgq3OXEXsCvNa+W8tYq6cSbrMNKiLuBio9Ym+9wNPk1Vj87RP2gFZh6U4721Mxam
         F07RSjz/hYce0GfvEdA8SsfZyHVjZ/vPxZDDS4L4b2tMRy4rwQSOf/zc8S1JzlWaK29/
         8epQ==
X-Gm-Message-State: ABuFfohIEK6nM6nvTvZsduEnlu8s1fUSKB1H5fzPb7FOljFFdCslyuLI
        pAoQI+mB4g7USgi/bif4LGggNblF
X-Google-Smtp-Source: ACcGV61zwC9csSNIY9QFfBbAZCLo7qw32LclIO51Uqw5dnbxjUocw3TwQcKUP56IE7+3v+YCBZeglQ==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9-v6mr3097018pln.149.1538595822281;
        Wed, 03 Oct 2018 12:43:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id o62-v6sm3521322pfb.0.2018.10.03.12.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:43:41 -0700 (PDT)
Date:   Wed, 03 Oct 2018 12:43:41 -0700 (PDT)
X-Google-Original-Date: Wed, 03 Oct 2018 19:43:35 GMT
Message-Id: <1c2dba41189e97c2dfa7d98da3b52589eb9091cc.1538595818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.44.git.gitgitgadget@gmail.com>
References: <pull.44.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/3] compat/poll: prepare for targeting Windows Vista
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

Windows Vista (and later) actually have a working poll(), but we still
cannot use it because it only works on sockets.

So let's detect when we are targeting Windows Vista and undefine those
constants, and define `pollfd` so that we can declare our own pollfd
struct.

We also need to make sure that we override those constants *after*
`winsock2.h` has been `#include`d (otherwise we would not really
override those constants).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/poll/poll.c |  6 +++---
 compat/poll/poll.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/compat/poll/poll.c b/compat/poll/poll.c
index 7ed3fbbea1..ad5dcde439 100644
--- a/compat/poll/poll.c
+++ b/compat/poll/poll.c
@@ -29,9 +29,6 @@
 
 #include <sys/types.h>
 
-/* Specification.  */
-#include <poll.h>
-
 #include <errno.h>
 #include <limits.h>
 #include <assert.h>
@@ -55,6 +52,9 @@
 # include <unistd.h>
 #endif
 
+/* Specification.  */
+#include "poll.h"
+
 #ifdef HAVE_SYS_IOCTL_H
 # include <sys/ioctl.h>
 #endif
diff --git a/compat/poll/poll.h b/compat/poll/poll.h
index cd1995292a..1e1597360f 100644
--- a/compat/poll/poll.h
+++ b/compat/poll/poll.h
@@ -21,6 +21,21 @@
 #ifndef _GL_POLL_H
 #define _GL_POLL_H
 
+#if defined(_WIN32_WINNT) && _WIN32_WINNT >= 0x600
+/* Vista has its own, socket-only poll() */
+#undef POLLIN
+#undef POLLPRI
+#undef POLLOUT
+#undef POLLERR
+#undef POLLHUP
+#undef POLLNVAL
+#undef POLLRDNORM
+#undef POLLRDBAND
+#undef POLLWRNORM
+#undef POLLWRBAND
+#define pollfd compat_pollfd
+#endif
+
 /* fake a poll(2) environment */
 #define POLLIN      0x0001      /* any readable data available   */
 #define POLLPRI     0x0002      /* OOB/Urgent readable data      */
-- 
gitgitgadget

