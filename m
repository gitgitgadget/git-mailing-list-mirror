Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EDB1F4C0
	for <e@80x24.org>; Fri,  8 Nov 2019 09:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbfKHJoD (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:44:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44252 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfKHJoC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:44:02 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so2938186plb.11
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3TdOumY/m4q9FNT+e55xkfcHPvyByZumqEpjtNQCZQ=;
        b=qZW5slswV3cF8WfygliauXLxufrBPdlgSTPIpmX29/cWxfQ6lk5PR5jdxggY6dbnfG
         kqRxAMKsiMGu2tBHnN1UJ4ZqTMwy/kaiH9MGBv8fOk6sxHc+EAtyOHWHhpasb8fbcv+9
         ilRrhgiBIyVHed+hOC2UvwktOAShuY2tjyMG+WpEPp1xBlBkdfeC5lIFy1NoVCEeUYak
         CHqg8GlR0YzJYrHAvSjyBepBJq1HkZx6K3UhVLEb5sDuF3hwvpva95jbJSfWMdreCGy0
         cgednxEdD3TphaaNpS9BRLIadrTwyWeDu6ZqQ2HDMg+p/gSsEE8NX7IYN1iu2mZrgUAn
         ov7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3TdOumY/m4q9FNT+e55xkfcHPvyByZumqEpjtNQCZQ=;
        b=AESYGbuDizTZY7a+8/UqWQYnfKZTg2iCsiyiIkNGot7mDDuk9Xb8FI42xKIm82HaGE
         88NmXNOEmPRRCziKxIFjRyodhm/a+0sLVeWrHgzNMvHnRWPMTAKSgIibGvvy25YEc4zA
         R63kYenE4tN0TYieQp8KXcORBXkhdPnfCL+ow3K0OsMaWYQHpLd//0rcBstAcZnUrQf7
         JAc3WwiQoM+sv2uDWvHwjagqpS+3lcR1mLQge8arerTECt4dibl+fog+4bTZk9SKS7lo
         Ux6Bu+/CbNPn4WgmWFHMvyyhgQyzAqdfrjbUGu22vmy8BR63nDF6lV/K8dLthxI2p88/
         piuQ==
X-Gm-Message-State: APjAAAUry4GWdUxAkx/rcylM7Ig2Dx09A5ghJpb7m7+4J0tEHtzLMSM5
        wMWKQduHRTLBBtvwqbEFJAZQUx6U
X-Google-Smtp-Source: APXvYqwzBeF9eDA8+E1ptTqiO9dm8GHdSSBF/NVTlV76UfVNEyBijrRUGvhftrHPklAXq2Gru03ijw==
X-Received: by 2002:a17:90a:eb18:: with SMTP id j24mr12492370pjz.85.1573206241854;
        Fri, 08 Nov 2019 01:44:01 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id e198sm6995821pfh.83.2019.11.08.01.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 01:44:01 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v5 1/9] t0028: eliminate non-standard usage of printf
Date:   Fri,  8 Nov 2019 16:43:43 +0700
Message-Id: <b3d6c4e72020072eb495741d125a08ec07f33ba4.1573205699.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g2e95ca57d2.dirty
In-Reply-To: <cover.1573205699.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573205699.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

man 1p printf:
   In addition to the escape sequences shown in the Base Definitions
   volume of POSIX.1‐2008, Chapter 5, File Format Notation ('\\',
   '\a', '\b', '\f', '\n', '\r', '\t', '\v'), "\ddd", where ddd is a
   one, two, or three-digit octal number, shall be written as a byte
   with the numeric value specified by the octal number.

printf '\xfe\xff' is an extension of some shell.
Dash, a popular yet simple shell, do not implement this extension.

This wasn't caught by most people running the tests, even though
common shells like dash don't handle hex escapes, because their
systems don't trigger the NO_UTF16_BOM prereq. But systems with musl
libc do; when combined with dash, the test fails.

Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 t/t0028-working-tree-encoding.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-encoding.sh
index 7aa0945d8d..bfc4fb9af5 100755
--- a/t/t0028-working-tree-encoding.sh
+++ b/t/t0028-working-tree-encoding.sh
@@ -17,7 +17,7 @@ test_lazy_prereq NO_UTF32_BOM '
 write_utf16 () {
 	if test_have_prereq NO_UTF16_BOM
 	then
-		printf '\xfe\xff'
+		printf '\376\377'
 	fi &&
 	iconv -f UTF-8 -t UTF-16
 }
@@ -25,7 +25,7 @@ write_utf16 () {
 write_utf32 () {
 	if test_have_prereq NO_UTF32_BOM
 	then
-		printf '\x00\x00\xfe\xff'
+		printf '\0\0\376\377'
 	fi &&
 	iconv -f UTF-8 -t UTF-32
 }
-- 
2.24.0.8.g2e95ca57d2.dirty

