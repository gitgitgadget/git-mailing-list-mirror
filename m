Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 030EF1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 06:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfKKGEM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 01:04:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36398 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfKKGEM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 01:04:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so8778739pgh.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2019 22:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrnC/l8JqfirPjhzPW8k5EqXK/pQ85RigBt1iiHmpcg=;
        b=ZFDqX7sw7yIHTj2wvIRir2LtOEJkk93ALU1piLmabe2dER0hThHOUesiaNykC1L0GD
         FsnMcP9eN6HpT0JqGKhpyCYnpp63NPU8J15/8ESDGeXdgjnCvWOM2nIQZDlHXZQY1FbK
         i8g70f0YRqeYDv+VUzZ08hLcnDASeicGmQU6VNWAqPsS2TRaCHfgbGaxZ9yCHCKwKxk4
         AFOK+2v/Il2pcxZpSWNJT+43MykxwOToOjdYoHCg3CDi7lyirXRR6FuxuZHCw/QjhAmf
         uCmTAcKqrof0axrA4Lw/tWnnAAE7yBOLK1VtfiyNc+Ri4DCrvootwQL2W4sjcNar6m8p
         iJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrnC/l8JqfirPjhzPW8k5EqXK/pQ85RigBt1iiHmpcg=;
        b=QgyMOS03XGAubnlJ23MkItc4DwmwBkss0VSzV5bqvSvrmYGLNh3Qcnaxsp/SFaI66H
         O6fyEVJDmfJiiV+l/SILXrDsx3fFNKwlD1jedwWvNFqFcm7Geyu9Hj+4t40srARRlVLd
         6EoKCxITeIEMPmg/AAU4KDjFVFIN6EyXyxKKFSWgOrw9NCPcAU2cZ9GfcCY+nL4aE+DH
         20IIvpIUP+EJjKPlyKmARFDlhZ3stRwCQb38cEH/iri5zSZRzRDXe70fhUQrXpYgY5T+
         A6NLoR55LffKGFYedvmWZ5KSlS3NCsAeyxZfsvXN082MdUa/X/Ml9mqPZNIGwIucKhYU
         tx6A==
X-Gm-Message-State: APjAAAUH9G4GM3v9OVDKOZ+ovMYkB9pPeeLIQkStDJon0DudXRv8L6j9
        hj9tXhq/qPmusgzzDLZZdI606t45
X-Google-Smtp-Source: APXvYqy8dyAWBsmrWQpMamONVBCsW4NGmz7jsMZWA2t4Z8LXxqDrQVxT7oHp8ujZsGWYaUnDLRT12g==
X-Received: by 2002:a63:c48:: with SMTP id 8mr12997473pgm.184.1573452251742;
        Sun, 10 Nov 2019 22:04:11 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id v16sm15112315pje.1.2019.11.10.22.04.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 22:04:11 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v6 1/9] t0028: eliminate non-standard usage of printf
Date:   Mon, 11 Nov 2019 13:03:34 +0700
Message-Id: <9f83d4533b574f66dd9a4f6a6d01f87f1373a0f4.1573452046.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.164.g78daf050de.dirty
In-Reply-To: <cover.1573452046.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com>
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
2.24.0.164.g78daf050de.dirty

