Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DA31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 01:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeKNLOF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 06:14:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNLOF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 06:14:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id n4-v6so6915034plp.2
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 17:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTI+fp8y7yFAMJ0KmAAm8/WZQJfVXgVLCft0px9x7uU=;
        b=BSsOaKPAKZvzNHYneuYNFVHNliexGO+zSbIsxc2fIzw2TearRObW8BJn4u9cCXgt2z
         J7U6XosgIz7RqlOXcESy3bbMOAFgd270pC05CNg9fl9oaV6WsL8jVfZ6xSbDV9TjL/WC
         ehXw1NWK+WBzi4BpNJ14hGIS/GxdYVL6PhlDp1Z57S9CM9cNddKs8OfWvb9T6TFaXfBa
         0keQJL2QadKI9MUdbxs33z+xehHI7qd31zQ+ck2wilj4/MhJ36U/DBQfMgA3J66eQGuu
         C2m3bfMoqXYJdy4AQdkPAQWNr+vlGnVH7kvWbdlxGYKljNN4j8hG29LxVCH65Zjat92F
         oIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FTI+fp8y7yFAMJ0KmAAm8/WZQJfVXgVLCft0px9x7uU=;
        b=dwRyEQwuczlCQEqslyAYxP53KACrSN4sSV8Wh1UmUmlAp3Tv3aZLFwtG7BURVxM50u
         2Bk2fkiGqqBqyRq1apewKB6iJRrt7316WREjkUb37P41CLLf+Q/Cw+iDwSqn/HUKlVfk
         tokKQppCJVZOVArVAq4AzndIWTbka7lnxmERPeMGtW4dgn9xu8MRUAMj9h7YHiJb3nsf
         Joa1Xs6ou2aarfNFyMcV8+j4OvouEqq3qia2ioWbHizBgYmZMoiK1jBpxvVuJ2aLvjNG
         +c25Z5Tb1Cli6KudH0OMVhU5VP9Lys69l3m78feZiBjx5GL5c8eLDpPf0egPHFiNhqza
         BOaQ==
X-Gm-Message-State: AGRZ1gKnkIU7elmCf8LHWI8kEDQhlJAlm0onWCIhbKM7qLZXl2O8qOZl
        kh82VA4qhiEvxUjgt39h5n3RusACEAI=
X-Google-Smtp-Source: AJdET5fK1yrhZ3akTRjsBbjJka2oLE/sivBlkddjd8j4sx6Kp4Ctbra1urI/Kqrfcugoq/lLYTY42Q==
X-Received: by 2002:a17:902:8a88:: with SMTP id p8-v6mr7250851plo.94.1542157991746;
        Tue, 13 Nov 2018 17:13:11 -0800 (PST)
Received: from void1221171.net.fpt ([42.112.87.31])
        by smtp.gmail.com with ESMTPSA id u5-v6sm25642069pgk.46.2018.11.13.17.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 17:13:10 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     mduft@gentoo.org, stefano.lattarini@gmail.com, kusmabite@gmail.com,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] git-compat-util: prefer poll.h to sys/poll.h
Date:   Wed, 14 Nov 2018 08:10:43 +0700
Message-Id: <20181114011043.27419-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX specifies that <poll.h> is the correct header for poll(2)
whereas <sys/poll.h> is only needed for some old libc.

Let's follow the POSIX way by default.

This effectively eliminates musl's warning:

    warning redirecting incorrect #include <sys/poll.h> to <poll.h>

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
t0028, t1308.23, t3900.34 is failing under musl,
Those test cases in question also fails without this patch.

- t0028 is failing because musl `iconv` output UTF-16 without BOM.
I'm not sure if my installation is broken, or it's musl's default behavior.
But, I think RFC2781, section 4.3 allows the missing BOM

- t1308.23 is failing because musl `fopen` is success when open directory
in readonly mode. POSIX allows this behavior:
http://pubs.opengroup.org/onlinepubs/7908799/xsh/fopen.html
[EISDIR]
The named file is a directory and mode requires write access.

- t3900.34: from what I understand, musl haven't supported ISO-2022-JP, yet.
https://wiki.musl-libc.org/functional-differences-from-glibc.html#iconv

 Makefile          | 8 +++++++-
 configure.ac      | 6 ++++++
 git-compat-util.h | 5 ++++-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index bbfbb4292..5734efe74 100644
--- a/Makefile
+++ b/Makefile
@@ -207,10 +207,12 @@ all::
 # Define MMAP_PREVENTS_DELETE if a file that is currently mmapped cannot be
 # deleted or cannot be replaced using rename().
 #
+# Define NO_POLL_H if you don't have poll.h.
+#
 # Define NO_SYS_POLL_H if you don't have sys/poll.h.
 #
 # Define NO_POLL if you do not have or don't want to use poll().
-# This also implies NO_SYS_POLL_H.
+# This also implies NO_POLL_H and NO_SYS_POLL_H.
 #
 # Define NEEDS_SYS_PARAM_H if you need to include sys/param.h to compile,
 # *PLEASE* REPORT to git@vger.kernel.org if your platform needs this;
@@ -1459,6 +1461,7 @@ ifdef NO_GETTEXT
 	USE_GETTEXT_SCHEME ?= fallthrough
 endif
 ifdef NO_POLL
+	NO_POLL_H = YesPlease
 	NO_SYS_POLL_H = YesPlease
 	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
 	COMPAT_OBJS += compat/poll/poll.o
@@ -1497,6 +1500,9 @@ endif
 ifdef NO_SYS_SELECT_H
 	BASIC_CFLAGS += -DNO_SYS_SELECT_H
 endif
+ifdef NO_POLL_H
+	BASIC_CFLAGS += -DNO_POLL_H
+endif
 ifdef NO_SYS_POLL_H
 	BASIC_CFLAGS += -DNO_SYS_POLL_H
 endif
diff --git a/configure.ac b/configure.ac
index e11b7976a..908e66a97 100644
--- a/configure.ac
+++ b/configure.ac
@@ -792,6 +792,12 @@ AC_CHECK_HEADER([sys/select.h],
 [NO_SYS_SELECT_H=UnfortunatelyYes])
 GIT_CONF_SUBST([NO_SYS_SELECT_H])
 #
+# Define NO_POLL_H if you don't have poll.h
+AC_CHECK_HEADER([poll.h],
+[NO_POLL_H=],
+[NO_POLL_H=UnfortunatelyYes])
+GIT_CONF_SUBST([NO_POLL_H])
+#
 # Define NO_SYS_POLL_H if you don't have sys/poll.h
 AC_CHECK_HEADER([sys/poll.h],
 [NO_SYS_POLL_H=],
diff --git a/git-compat-util.h b/git-compat-util.h
index 96a3f86d8..65f229f10 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -180,9 +180,12 @@
 #include <regex.h>
 #include <utime.h>
 #include <syslog.h>
-#ifndef NO_SYS_POLL_H
+#if !defined(NO_POLL_H)
+#include <poll.h>
+#elif !defined(NO_SYS_POLL_H)
 #include <sys/poll.h>
 #else
+/* Pull the compat stuff */
 #include <poll.h>
 #endif
 #ifdef HAVE_BSD_SYSCTL
-- 
2.19.1.856.g8858448bb.dirty

