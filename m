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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4010C1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 09:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfJaJ0n (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 05:26:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33832 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfJaJ0n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 05:26:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id e4so3683351pgs.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4v/XoFPHbrG1euWwc5jqbu7fwyrBikCvEY0B3kMnpw=;
        b=rUtZpeTSU1TP4+xuTxHWyZGbGYLLP3I3AC5Fp6p28STvfIQDQuRsIncNXjkZeApOlg
         cpa1bLP548ctvXIG7eWEcz8rMwiFHv2+WOfxEixJ9eYAThIOLIpJ1Fn5Mp5TbzHxsYXT
         Lfb7Lc7UsPSHR36xExHRmj222qsrMDrhz0u2/pbuNmcXQl9PMDJf8ixcK8K/f5gBlWRh
         y9pDIegW0z/cp/bgTAH7zbf6mrnH2Bx/k4peyyWNKorOnUc+NwJU+BneYsTxyz31MaHC
         4N9tZ6zPWbGIn0xG8WWIMyHoc2RpHKfpS/3UZIUBva5IwLuuePJ7r20K/KNHimaKEDQb
         e/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4v/XoFPHbrG1euWwc5jqbu7fwyrBikCvEY0B3kMnpw=;
        b=nmx3MN4S9+2n53QC5Jr2SI2g8bCAYn/1q2LpcfQGzg/5DJcW/Od/CDYQ3Y85rlX6MZ
         ZD3P5CPhhPREEyA6QGH3UyrADXYmNFopgjPk3EIff1xLSMlXpcjVXyefCRyLFD0064iS
         2WWZfx2SDoSttpUDJ6idCxZcF0tL+j04w6z2OBplUWurAFji/XOev9cUeOhYm6WCR2bw
         0Pq3rYVpeACTvGuCbQa46K713ruXYiUjr1ySYmPGvM6mGQEinPZ9rNGzNpmKjUvLJ04I
         2Cp7EfxHNm6Wq+N6BvOwIJt2Jnw5J4p7dhlVr0JjDgVlXL/iPmIKYvNERuTk5/74907f
         8wFQ==
X-Gm-Message-State: APjAAAW40UBEHBBhzsmuFjWzdVaDDmhNRRcU+70ERzJOCHaH6XkZhOu4
        8zMqWJS6vweYAokiBG1/3P7eS+d1
X-Google-Smtp-Source: APXvYqxWYHdmEr5g2w6DXVuSF8UwlXKwgWHWcRI53lL2V/Md9S5KZUqa1PV1fb2LZMOV5t4TD3fi2Q==
X-Received: by 2002:aa7:9a94:: with SMTP id w20mr5209396pfi.256.1572514001699;
        Thu, 31 Oct 2019 02:26:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id y24sm3570558pfr.116.2019.10.31.02.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 02:26:41 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 1/3] t0028: eliminate non-standard usage of printf
Date:   Thu, 31 Oct 2019 16:26:16 +0700
Message-Id: <20191031092618.29073-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.rc1.3.gc8da3990e5
In-Reply-To: <20191031092618.29073-1-congdanhqx@gmail.com>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
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

printf '\xfe\xff' in an extension of some libc.

With dash:
$ printf '\xfe\xff' | xxd
00000000: 5c78 6665 5c78 6666                      \xfe\xff

Correct its usage.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---

Notes:
    Despite that dash's printf doesn't accept \x escape sequence.
    
    My glibc box (with sh linked to dash) can run the test just fine.
    But my musl box couldn't run the test, (because the header).

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
2.24.0.rc1.3.g89530838a3.dirty

