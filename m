Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DE5207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947812AbdDTVYm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36125 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946958AbdDTVYi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:38 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so687375wrc.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcF+lIKQCtzvs7MCT4uTunjtqrB/89ek8oh+DQDm5n0=;
        b=Mtap5R9sQPy5sbLkv2qv+awlf7bkbcdKwA5/hldgZbkbguzqRLOpH75QgSzeI2kgBr
         BlDSZyNblo9wNI/ye5Tg4qR98yazwIcF7wphLUwBQx0TKnzG85aM6EwE1B6LCwptjfyr
         tV/KIuBp6wDOSK/4xas0Mevz8mNO/lRgQx65Fj85ADJzhyVCs+8b8XOsxg158IacIs7H
         WY12EB/QzOne3/gq8/0c5sOMFl0gCV7KPpM7gtopBj8JMNsAPEC6nZ1GUk8e0RQ0jj/m
         ztIuZg0d4eTouIak8eN2yE7Au2Jee4FVIhWDLF5kO+AAM5E6Wghshaq8Dx3iVw23aPGi
         5k1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcF+lIKQCtzvs7MCT4uTunjtqrB/89ek8oh+DQDm5n0=;
        b=KGCP8QzWhAAX2EpcXf2GDUKs6UZf7CFErzwNaFcnYjVNLVtavjRPF4iHFJ+18E+NVi
         M3vR8wFn5eobuVrUtpJT9kKStmj6LDpAU9D7C37WhTQd0LW+WsNbEs3JZVxKirem9gG1
         9a3fdhVPob0ZxPcY4CqbO/GmuUVQrnWvr9VNTHr7pHtEZx7khTNpD8Sy418zCnR8HJt6
         fKMb81R3BsmLlsAummNzicuOKzrMxpuzp3w/81bnnbfh5heANB6ekEMvEqrzrlKy4KYI
         UhKDyBFQEXDEblnFbqfFudR/YEpCSxyvWiTbZV64JoBRwvzJApW/gh9ciZGiRo0n9Zg+
         lVug==
X-Gm-Message-State: AN3rC/6LMfJyJ2OLlHo8zxxV4ICPxczBsCSzhO+ugYzoj9DB0rChk5/Y
        J40lh+V0GZIZCg==
X-Received: by 10.223.139.215 with SMTP id w23mr9813616wra.169.1492723474943;
        Thu, 20 Apr 2017 14:24:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:34 -0700 (PDT)
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
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/18] grep: add a test for backreferences in PCRE patterns
Date:   Thu, 20 Apr 2017 21:23:33 +0000
Message-Id: <20170420212345.7408-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
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
index cee42097b0..ec8fe585a7 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1102,6 +1102,13 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE 'grep -P backreferences work (the PCRE NO_AUTO_CAPTURE flag is not set)' '
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

