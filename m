Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE2720970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdDHN0D (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35032 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbdDHN0B (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id d79so2447985wmi.2
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SbCEOA3f8RplIjyyQUgj+cEf4zp1jdT2TjJ7c+2ZXNc=;
        b=FPLJHVdlUiZsk4lYzoLjXbA+q4k0DZ8BpyDBQ+7QxPvcLnLPcKh4cGeyylIVKvJYys
         8OLyeYVOXVyZU9QgrWezD/s9SMZ3LI0cwIC0cYPFrHJXzTgamFLhyUOmNiY27VpBkPHs
         /NtQJMpqJvCPlwXFzzIe10Z2xaLj8PmqfeX16ulHoATVaaDQU2rev0epxieZw/BbSXS4
         yV8YB6KUcN+zAL3pQozaX87h7aJdS1ZbDfpE0usS99JEZ5LgzNm+5YHNQwMKv6T2KjD6
         i+Kh92x7oMp2RiVDfYMhKjOJS53yl4WeX15XEOVj2pYIGIHcOTUwkfcK8+JFDs5NeXNl
         ZoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SbCEOA3f8RplIjyyQUgj+cEf4zp1jdT2TjJ7c+2ZXNc=;
        b=NFJcYfGzmwSdLj+A6fvCuCcQYjvCbOhzlWcgm46OiJ2i39Ew2z64+UTjBRy0+oV1/T
         8Nq8becIa+vp2PX+hNlO13JGh4LMkHBFl6JHoYD44j6iO7/ZjNe9Xx9uVeBBZfOzqDOF
         U7K9CYc6h2+U+JjKPw8i2tPSYvgywhq7j6rDdX8+8giOS6FFFjNIhKX68KUq5YYKdK4r
         UFj1B1HyWEg2oG6BGgmGTG49rMARCgwjdULc/dA9w2PW1OLcIwzRpK+Ofkqx6zn+Ukju
         uX7q1yh6OBKA1hD3uO/7iXvH6dAydcnVJquoexXtT4ZlCheZ/ZxryMdYCdCyzatRrAB/
         F9YQ==
X-Gm-Message-State: AN3rC/4d21CYcr1ZlQtvV5X7BwNgS8rNdrxPaSxVyULtKxAn3yzqnM3bHSmu83Nhx5QiuA==
X-Received: by 10.28.212.134 with SMTP id l128mr3243396wmg.34.1491657959937;
        Sat, 08 Apr 2017 06:25:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:25:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/12] grep: add a test for backreferences in PCRE patterns
Date:   Sat,  8 Apr 2017 13:24:58 +0000
Message-Id: <20170408132506.5415-5-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for backreferences such as (.)\1 in PCRE patterns. This
test ensures that the PCRE_NO_AUTO_CAPTURE option isn't turned
on. Before this change turning it on would break these sort of
patterns, but wouldn't break any tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 53c2ca05c4..83b0ee53be 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1102,6 +1102,13 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success PCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE flag is not set)' '
+	git grep -P -h "(?P<one>.)(?P=one)" hello_world >actual &&
+	test_cmp hello_world actual &&
+	git grep -P -h "(.)\1" hello_world >actual &&
+	test_cmp hello_world actual
+'
+
 test_expect_success 'grep -G invalidpattern properly dies ' '
 	test_must_fail git grep -G "a["
 '
-- 
2.11.0

