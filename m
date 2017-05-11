Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129131FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755036AbdEKJTK (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:19:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36241 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdEKJTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:19:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so5447717wmu.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/RLGTEvPHORl/qsXNy634QkE6uJUCjjPEmAZpYYLVk=;
        b=AnyemNWsLdVq4smBoz+y1xJz1CvC6gxN7jhR899a5rUcniQpZ8YTyuVL8f/c/6dlEi
         agOSyYtEo0kRWdS80uawE4Pt0blWGestZLzEhn1M9ydu8L7RKJCR3BEx0dReNfQieWsX
         6egU6WTiuMg9cID+9udrTxt4img4ngo5QK1nCrPScZlqSWHqdEFjFol5LYgfJd1CwP/z
         qRsWjdlTfWtdw/vlt2pnXLjkRBwPBGQ8KtuX0s/p15ebdvyxxg/tbmBTpXx1JaQEcs7m
         3nbTvkdzgH6NQLDxGCFXL0B8/YOIaKb89qnl41ore16/ybGRNMkgEwvalJfPLfO/PU+V
         PvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/RLGTEvPHORl/qsXNy634QkE6uJUCjjPEmAZpYYLVk=;
        b=X0E+YtVwQz476lmV7c+H2brTscg1ccA7EJIblO5qhHiESb0tr4AXx0ZwZF2oAG4XhV
         Lf24XqHBXl650p8zGRKKKL0jTfF/BOdi123Ac7NY2dm65+G6BsruMUBF8TXcZF7+jzLk
         gi3GXRsoRTfzrCqhGDaVN5kSMQIt5k9kUd5uY9wt0L0r946HnPfk0nuhhpWYpG3GMCDW
         qaAcQZV/+MT00Xkik9xTtC9rDRErYPsIyMsAY00PAkNCz5KbJVX4f+7mC6ZVK/epOg7A
         GOTHabsWJoKzcHnFZ4nfoRrXxRNXAIQjAAdgS5Hbpv+gvNOlQBD/MM7DkLJeFyov/9D3
         uJhg==
X-Gm-Message-State: AODbwcDMb++YK2JM1qxF2ibKI+WL+w1h1K72AQqemwruZTUg+xsX5Tk+
        Suo0prdn7OI6lA==
X-Received: by 10.80.164.27 with SMTP id u27mr8182edb.49.1494494347635;
        Thu, 11 May 2017 02:19:07 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:19:06 -0700 (PDT)
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
Subject: [PATCH 06/29] grep: add a test for backreferences in PCRE patterns
Date:   Thu, 11 May 2017 09:18:06 +0000
Message-Id: <20170511091829.5634-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
2.11.0

