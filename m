Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1CD1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 21:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbeHTBKn (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 21:10:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39574 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHTBKm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 21:10:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id o37-v6so2501813wrf.6
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 14:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfI4bgcC1vdq/B59gt1dj0wPhimMdBhz6GFD4SdwUkc=;
        b=sAZxXcWsB5732qgvi+goEN1KN6R26+2kaG2eRyRWJY6N4DdzMXzeVSjWV1zyr3EgU/
         n61cSZef9hqCjPmecbwsCrEj+kjRfTkPqabfWE3YRqtCahdKUFHa2Jd5MwUbcETCo3xv
         nanRYdUCbx0djPF8CaAokcYYRZE7BaRsqYecaaK2UHDvFhaZee5PUMSDofdxEbH43Wl6
         gOmjM6K4lIxADMfgOnFJIlBCTZ3dizc85/E66ihwwljM+35w6IVFaRp4YCus2ZHXvb8l
         SoQwYaT1XmqyOWSbPL5IIUQ9Ci4rier1woOgrEhbNTbztDgfhicwpGdzdqc3XUAP/F77
         80Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfI4bgcC1vdq/B59gt1dj0wPhimMdBhz6GFD4SdwUkc=;
        b=qwnGSB33L0e+Nzrt1MfmZVmM7vXCL/TQx4cbtrHTG37W6XN1T1Wart/Hh4gh602cOB
         7l24fv1UARDOhJ5JRQGgSk/pYSS6+tXFnlu4riVTZ36MRidECnOF6utmDo95+/EPHlv4
         Y+OixMQMJMOSCSKOZJDF0LxA2ZVCgj2P4pTZwbNPI9KJbfhVOiAa+VCIV9CIjfmRenx2
         BNEwDh6XEx+fXTAcjd+1bjUa+K6b2X4q8H2LQoSEGm7OPxjCMASDEdVDj5ILGvU9qPP3
         jLDzPKsSwYGEFdDIVO3xmL6ggLQOM+YlqH8G0Z7ZwPDu5cmw+VGToi7+6JCZXNKc/1l8
         yp0A==
X-Gm-Message-State: AOUpUlEnBrePrT/fGv5Y40zWT9Nf0E5MN3lvbS7WW7l0xBFYHrEAQJ4G
        FaDiIrjYrRDZHqCGVaJCYTs=
X-Google-Smtp-Source: AA+uWPxK442Yr7guWbedIuiMI/5rGQxlwjUpz/s9TonjfxRgR5bKuYlFBLVgm+YHGB7nQmHNrkYptQ==
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr29279910wrv.4.1534715863465;
        Sun, 19 Aug 2018 14:57:43 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id x82-v6sm30485975wmd.11.2018.08.19.14.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Aug 2018 14:57:42 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] tests: use 'test_must_be_empty' instead of 'test ! -s'
Date:   Sun, 19 Aug 2018 23:57:23 +0200
Message-Id: <20180819215725.29001-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.903.gab616d7dc6
In-Reply-To: <20180819215725.29001-1-szeder.dev@gmail.com>
References: <20180819215725.29001-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using 'test_must_be_empty' is preferable to 'test ! -s', because it
gives a helpful error message if the given file is unexpectedly no
empty, while the latter remains completely silent.  Furthermore, it
also catches cases when the given file unexpectedly does not exist at
all.

This patch was created by:

  sed -i -e 's/test ! -s/test_must_be_empty/' t[0-9]*.sh

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4201-shortlog.sh         | 2 +-
 t/t4211-line-log.sh         | 2 +-
 t/t8010-cat-file-filters.sh | 2 +-
 t/t9802-git-p4-filetype.sh  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 58c2773676..d3a7ce6bbb 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -192,7 +192,7 @@ test_expect_success 'shortlog with revision pseudo options' '
 
 test_expect_success 'shortlog with --output=<file>' '
 	git shortlog --output=shortlog -1 master >output &&
-	test ! -s output &&
+	test_must_be_empty output &&
 	test_line_count = 3 shortlog
 '
 
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0377fae5c..6e378b23c7 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -102,7 +102,7 @@ test_expect_success '-L with --first-parent and a merge' '
 test_expect_success '-L with --output' '
 	git checkout parallel-change &&
 	git log --output=log -L :main:b.c >output &&
-	test ! -s output &&
+	test_must_be_empty output &&
 	test_line_count = 70 log
 '
 
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index 0f86c19174..31de4b64dc 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -47,7 +47,7 @@ test_expect_success 'cat-file --textconv --path=<path> works' '
 test_expect_success '--path=<path> complains without --textconv/--filters' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_must_fail git cat-file --path=hello.txt blob $sha1 >actual 2>err &&
-	test ! -s actual &&
+	test_must_be_empty actual &&
 	grep "path.*needs.*filters" err
 '
 
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index 1fc9b33aeb..9978352d78 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -310,7 +310,7 @@ test_expect_success SYMLINKS 'empty symlink target' '
 		# p4 to sync here will make it generate errors.
 		cd "$cli" &&
 		p4 print -q //depot/empty-symlink#2 >out &&
-		test ! -s out
+		test_must_be_empty out
 	) &&
 	test_when_finished cleanup_git &&
 
-- 
2.18.0.903.gab616d7dc6

