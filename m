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
	by dcvr.yhbt.net (Postfix) with ESMTP id B762F1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 02:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfKGC4b (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 21:56:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34662 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfKGC4b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 21:56:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id e4so867050pgs.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 18:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkotJqYR92JwTZfcDH0yh6u4G57Nxxu+qBXOPDSRjQQ=;
        b=cwhcCTvdlqqRvreASZmKU8S+IKCNKxwqSausoJ8NvweAokScObMzfAfOTLllJ3mOVj
         3K5F5mbppHVmKLjhAwZTc5EGLOZBp0R2VwL6HKfqL8R84ZSPtcZFmDox7XiE4q1OGtYN
         RuP9Fy+0b0PHWbmkQHIXOZLEHPtgNHZqZsCQz5czyZ4Cb4bdLCkRDpD13os9XIOkTAkI
         81zGBIcbzBmLA++vPIJzE+rxl9oRpyWic5CRDmE7YIS0OO35kxajXYPeOSBkBJmvquJb
         qvVScMt2RJccovlDwE+MpGQULVd05WaqS0ImFx9p8nCCLzABmJVlQXJWqmsYSI50U1/O
         yGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkotJqYR92JwTZfcDH0yh6u4G57Nxxu+qBXOPDSRjQQ=;
        b=cLW8ZHO27QiqSoBXQoCmDq3W647y3G/dEzYRLYMC5NrHh3n2go27dx2p3tfB+DWU2N
         yDv4dKzMOmzBbU0UVq0v10rBJTawrU5tI81Wx2HlUo8tRoxQ25h1yD86gAGcVfGYMQtF
         e5m0ir3F7s2XFjMH7GNTK0pSD4wSx8RMofAjmQTBYevciHouCzgMhBC/VQRmcS06mF4d
         vEIsvDoFJ2OQFns3YA+mM+a5XUAUHliwM1TlPL+NXC96Bcp6z2O14aHm3Zb5m8Uqjm7X
         jVlCmW31IexztglmbC1mnI1d0BQ7Yc7zuum61p+CrOF5VPjXH5rM1/9Vctb44UBeNvf2
         vhqg==
X-Gm-Message-State: APjAAAUt17dRGiIKlgj86movzJG33ZkV5mFIid1Uf1cErQx5mPG//SZo
        GkKXPlAwVlpK2uw5lKl1ynEJhBKX4o4=
X-Google-Smtp-Source: APXvYqx55P2kuVAAAEScy653q9PnJrVEWR2EF6zt2rjTVF7NOsu3cSefGp/sJ974NjKg8bttwykJsA==
X-Received: by 2002:a63:eb47:: with SMTP id b7mr1477946pgk.179.1573095390150;
        Wed, 06 Nov 2019 18:56:30 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id n15sm393767pfq.146.2019.11.06.18.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:56:29 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v4 1/8] t0028: eliminate non-standard usage of printf
Date:   Thu,  7 Nov 2019 09:56:12 +0700
Message-Id: <b3d6c4e72020072eb495741d125a08ec07f33ba4.1573094789.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.8.g36796e2b67
In-Reply-To: <cover.1573094789.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573094789.git.congdanhqx@gmail.com>
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
2.24.0.8.g36796e2b67

