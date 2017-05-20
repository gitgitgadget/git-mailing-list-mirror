Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2FB201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756376AbdETVnE (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:43:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36537 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756349AbdETVnC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:43:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so5740798wrc.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxMkUKmQLQJI4OTgQm/kjMcmsxX55Iy4vWlpBm/WtlE=;
        b=nl2bx0SMcBftq3UIW7ZL7n5ukavYdbzT5UdTBL+a87iTaud6Mq6HMAopP9PE7Ggf43
         Ydfs1x9DWoXwuXtnvzS5Xfaxpoz008C50jB6NM7GXuRYsJ/BMPZZ5EtlIF6wgmt6HaEf
         YtlGk/OXsKyHiLJGAFZar2+nK0tWIxvziamBo0DMrBQ3Urn5K+L7f8jAfGQ4KULZrxDs
         RHJKjx2TqyiwSETblC1bYWMvAXT48JlHbbbCi7cDtjUPbfJVQJ7UT9JWR+axTGymwedN
         te996PE1YzmMFrNz3JgROUtGg2kKM3SsPsmxwxwJV/q9ReeYR7F+85M4zEUwM+kf/bfO
         +1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxMkUKmQLQJI4OTgQm/kjMcmsxX55Iy4vWlpBm/WtlE=;
        b=sej9FJnUQamPX4q51wm8hitW0BxN9j7nfXUDRalpnmitfCcow0s7KklrdRuvm5qsQE
         7Z2y6nF0esovEdkmTAksfeTqAsXXsx2pWUlsnC7P0kXGakWZ5T+5fG1Otsiwcl70asED
         Nwkwh+KfASC4CGWh3C6jEVEnR6iqzYnHUzjEOAs5zKN10xyoVSy8G80P+Zo0siFz/qf6
         MPUf9AAygdYo/DL/eMGNtfM8LncGfuYXzGvG3ik9qSVkjRK0yYch+1PGq4YDV3EmSJIk
         uyufpYFdGH7DbYk6j/UzyyKrOCopu7Ztrbh2one0n4CcfTwrn0XGDgkcrRnRcz38z5LI
         f3oQ==
X-Gm-Message-State: AODbwcD6X7qdPfYc4PWElDia+YQwLWMv/0hoQwjoGI0lFTIJdPNDKsa5
        SMaeNThvqhWe3g==
X-Received: by 10.223.173.23 with SMTP id p23mr7678112wrc.117.1495316581360;
        Sat, 20 May 2017 14:43:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/30] grep: add a test for backreferences in PCRE patterns
Date:   Sat, 20 May 2017 21:42:10 +0000
Message-Id: <20170520214233.7183-8-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
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
index 8d69113695..daa906b9b0 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1114,6 +1114,13 @@ test_expect_success PCRE 'grep -P -w pattern' '
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
2.13.0.303.g4ebf302169

