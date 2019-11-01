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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7E01F454
	for <e@80x24.org>; Fri,  1 Nov 2019 08:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfKAIZ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 04:25:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36857 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbfKAIZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 04:25:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so4045725plp.3
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0s4BZFZb4zptErNWfiFv3Nfp3C9dNgWC2dTeNJEvFQQ=;
        b=NSdTYY03ApRH+8VeKN0Ki+dndsOKz1aHut3/3zYPX2+x6Y7svOiAldM6P1UoYmJGWj
         KuK+DcOnQz+n7Bnp5owNGepMGyjKb5ZGaWOCPNC68KHBoC9YofVvBQa8tX4pao/83lRP
         u7U0QgbCzA/EnX+a8TlfcNBnphnnJ5+t4rkQpSJnFZss035nPxURpwlBsDRk4O5pWXqi
         jSo+iZWpyjNQYKdmj6bZ/eZZTqqnGtlGMPM8MTray1rW4gYpiBZ13W9Yoz4qX8p6yOdt
         grsGgrQx0QDMHvb0O2JVtcm4j6XO93TJYNKbzOhbAwmDBEEXUgIs4QLa+UwhOILyUb7w
         VryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0s4BZFZb4zptErNWfiFv3Nfp3C9dNgWC2dTeNJEvFQQ=;
        b=jX9gQa0QteQWrO4keYTNxfNeUMBcR5tgqGW9VBkH8ZoaPHcFc5sWGAH8RO4mUvSDNL
         CLjZsL6xDftBXyAcawmEg4nsaUSuhxufpKG9a2j9QjiOB0NqOOX/711VWBbtH7Swh52u
         hY4itbRo9VATVHC7olTxoCrnoHtwFF+EgnlRfHg5lRCrJH1fJBefh5LCUJqaHPuBcgTa
         n9nymqZ0eGswXAcypp03hbkBTwPkU/I/MGA/Ekitcfcl88ix2OJ58bK+8oRC5G1uNBFX
         q1Cv5cjVzJ01SPKmXG19RB8vq8Q9VFVBbwDAyXWUgs7T4WLneLT7pEBwANs55A2lVK1/
         s+/w==
X-Gm-Message-State: APjAAAX+WFUfS9jBTqZ7tXTkaHy6ji2wzrwNAo7I9UjyDSyZAp2sJJcw
        C+ms9xkVDUC8w0PU4HADL7Hr6Kva
X-Google-Smtp-Source: APXvYqxp6zjgKYF+g5haw2452WU9Q21UtaRbFZDuLvI8dXCxL0nO7WGwAAY0LOTnX+3nwEDCikehlQ==
X-Received: by 2002:a17:902:b703:: with SMTP id d3mr11745323pls.194.1572596726030;
        Fri, 01 Nov 2019 01:25:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:e1c2:8c5a:c959:6fca:fa1a])
        by smtp.gmail.com with ESMTPSA id q13sm17158395pjq.0.2019.11.01.01.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 01:25:25 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 1/3] t0028: eliminate non-standard usage of printf
Date:   Fri,  1 Nov 2019 15:25:09 +0700
Message-Id: <8b3002842537355c2387cb55f52c10ad8a7dd530.1572596278.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc2.296.geaf699fcc3
In-Reply-To: <cover.1572596278.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1572596278.git.congdanhqx@gmail.com>
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

printf '\xfe\xff' in an extension of some shell.
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
2.24.0.rc2.296.geaf699fcc3

