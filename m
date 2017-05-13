Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F5D20188
	for <e@80x24.org>; Sat, 13 May 2017 23:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758533AbdEMXP5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:15:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35262 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758132AbdEMXPy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:15:54 -0400
Received: by mail-qk0-f194.google.com with SMTP id k74so12530596qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/RLGTEvPHORl/qsXNy634QkE6uJUCjjPEmAZpYYLVk=;
        b=BwJNoCrFIjgKqyR6EspcEkusw57EWQzMWTPcTi/3qFRRVRb0PLjug9aa4rgGFGoG82
         Lg9Vz+Xujv5PuuoZzUmO4QYGXiY3ReIUHNBKtzROToEQFWC8acLFTul+GCOh65b+tyv6
         GKZIH8yvPNIlD46d9Qm1agoHXpp/la26QbnDVDCmtw/CCxuQo7GFeWObqP2fwZjeYI+3
         HhpciNex38L3e/FxcMqisp+hEt2nL80GMdSE9M/XJC3xLUQ4OjMFHfauuOqWCkr12B7F
         oTFQxlBb87CBwWZUlJwkIfy6BTx4Pejvb3FXvnZbGZZ6hZJCHcYtM+QaaGP7+TRyWdd5
         Hj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/RLGTEvPHORl/qsXNy634QkE6uJUCjjPEmAZpYYLVk=;
        b=aRGvULcIAqbEf6faYD4r6Fv2zGPx3Ql8KEU+YGjYa1MRUoGyvlGFFWxR8lX19zcOMW
         OKAKxKVJuHoOF7sb5VgNGrjLAdQiYD8KsfmN+SYidgGfXB22ZQF+VOqhqmKwBXApVU2y
         zpDgBFtLBp4i/OD9gpO30RcjqfrCS7btUhm8ik4hI3PSoF4tpvMmXiW+H1EQGWLlaReL
         0llPIl0g1CyidYPvAl/8OFxcp6Ccf+zBeqsp0KdwOthE0VQFO8aF/jJF7DTOp2MCNoRB
         YAhDL9tksM5AHlmVM7iJozSfuKr2h08DiUQQ6UsPdoZ9QHp9w9Vpe9tEmVEIWPQq3UhP
         8AJA==
X-Gm-Message-State: AODbwcDXjGagVu/oNFOJU02OdBnViV6h+8X8F2HtYEl44TJb6wZIOsfa
        +gRATzngJEflGQ==
X-Received: by 10.55.101.17 with SMTP id z17mr9503919qkb.168.1494717353783;
        Sat, 13 May 2017 16:15:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:15:52 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/29] grep: add a test for backreferences in PCRE patterns
Date:   Sat, 13 May 2017 23:14:46 +0000
Message-Id: <20170513231509.7834-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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

