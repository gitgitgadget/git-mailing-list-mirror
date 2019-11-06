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
	by dcvr.yhbt.net (Postfix) with ESMTP id E75331F454
	for <e@80x24.org>; Wed,  6 Nov 2019 09:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfKFJUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 04:20:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40022 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJUa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 04:20:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so16721054pgt.7
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRHDuccZCG/DYKeYuVPlOKCK/9YX5IQFkGA+S3eeJuc=;
        b=F8tUYoJSMRM3bnfpv9w/dqvt2GYOZ+5W8HQSz15svJhii/CxdLutLFpcyK6IX3UE8P
         mKMmX9wGm6iaroAgut07UYhUc+/BpGcb7Z2qPtCntt03JBVYNBK1g4q9WTwaZzJ0t/cw
         4lExF0byyvrau5Mhn3EgVfvQ62FOZ/l7XbnrG/P77pdiR+AyGEPICKtaasKJbrH0kiJ0
         hUUt/7gyr/DBadOhLjPT848v7zUxG4MGY8BZ0BnJEq0GkJUOCMyTFePbxjDjlREQ8IaS
         1nSYT/chkI/SoStbmJDQbMw3AHSlBcmcyrXN5cmeZg7XG3kg6J8lZzgnWOrL54t9NDHx
         50Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRHDuccZCG/DYKeYuVPlOKCK/9YX5IQFkGA+S3eeJuc=;
        b=Xf0ksHb3/bkuAJfokCplEJzzaSERXlbvZmVmg38ZmGqv5A80Bk102htb+cefVN1Dz7
         Bo+KGkW4+ETQ7ao0uNKPNwIy/bmmOBf/kkgCA8SMmvFXEolEf71GnfshL3UdjyVf5mQl
         v/sDtD+yKzG3c+hKRsaXMX9Ihs+eq3KU1TfvfgJLds5hQ48ldUtw3qe9ODfma/+0pyge
         vTPvyMejvooWS2WOibC+1GSgShf//36GwKFUUnuCsPKnBrzr36JuV5cLyrNCV0DsyDei
         fnkwLwo6WuzL/UkcR+60mcHYcydFANZYlLXntJVgGUmQdVV9ORth5RJRWdA+xpxM+02q
         fuVA==
X-Gm-Message-State: APjAAAU710HHy2AWXU4r4i10kXpItsQcC7SKaMWob5Kf1divtZ0LGJ+3
        OKE/fH/MnBjq2s9vB8U5bL4O8Ls+
X-Google-Smtp-Source: APXvYqyKJenCnX7zas8fbgSwgRLQYgEejyjqChsSxX3i8jtB+DSD+1j6u/Anpm3lJQq9alowuP272A==
X-Received: by 2002:a62:5404:: with SMTP id i4mr1950797pfb.211.1573032029728;
        Wed, 06 Nov 2019 01:20:29 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:4ba:cb41:a2ec:2198:454b])
        by smtp.gmail.com with ESMTPSA id c1sm4696984pjc.23.2019.11.06.01.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:20:29 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v3 1/8] t0028: eliminate non-standard usage of printf
Date:   Wed,  6 Nov 2019 16:19:59 +0700
Message-Id: <b3d6c4e72020072eb495741d125a08ec07f33ba4.1573031848.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.4.g6a51fdd29c
In-Reply-To: <cover.1573031848.git.congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573031848.git.congdanhqx@gmail.com>
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
2.24.0.4.g6a51fdd29c

