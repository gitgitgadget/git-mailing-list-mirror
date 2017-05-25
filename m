Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096AB20284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036689AbdEYTqV (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35981 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036667AbdEYTqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:46:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so54291984wmh.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxMkUKmQLQJI4OTgQm/kjMcmsxX55Iy4vWlpBm/WtlE=;
        b=s185skEJ852oV0Oz9RhaGfGlnipZP4uJMYVssS2MXN+MVNJ3yWDhyHIzEFqvNgGmV4
         cfd7rZORieg1tt/cLegKXh9AMi8uAMy++Zba6u5iJOjAHCia90KhN+x2M1LLrbJs4YQz
         59FzDha0mGCOFU4w0Fd/z5mvKNY0oee6K7ZiobYb3S1ch/X7OCf5IRD43V41jri71P6r
         PJwfRZrsznBd/Svk9BKVbbSARXd83YdVlRPuC/fy1XHw78rcVa4WGH8dDJu6YUY6yRqN
         VKGVZWnffP8ToDtoLgaD2x6oCNUvH+xg0At2keEn2g0Dk+5//lYG2TUU/siPOckLy041
         yKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxMkUKmQLQJI4OTgQm/kjMcmsxX55Iy4vWlpBm/WtlE=;
        b=AqXT4T7gjct4fmKicjFNuIXGDdKqiwvSgQSKP/0oWuxu1EmhfIbXEynuJ+mJbLEjr+
         rWsm9ImzHQHbYocXYQR/JWF97RWqqaURqk+gSBBtfxNcUOLC/vgBml6BsEyIasM6Pwky
         CnvDK8ZPbcQoZCIXLDTRkTyWOoZdUqFM7zjbcRPrP3jGrvfoVRRg0Cx0Rmnn4h4U9kiG
         OWaBHRoXcCXtSBN/EQYHtzJGjv9dZKJtPPLrjHaVR73PFRWB4iptP1MAm9ZP/MO4YOU0
         sB/N5/4msxsm7R8XLQFcibJWAQpjPT5zftNKE7xZQUjyGkYcBHTiHInfqlzzv/WxP9q3
         dgIQ==
X-Gm-Message-State: AODbwcARDMpYv9lYdhKTme+mKBf8oUZPB71Ptsqt/fmS991TnIjACwIL
        ag26GMx3CgEy+A==
X-Received: by 10.28.208.130 with SMTP id h124mr11625314wmg.21.1495741573725;
        Thu, 25 May 2017 12:46:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:46:12 -0700 (PDT)
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
Subject: [PATCH v4 07/31] grep: add a test for backreferences in PCRE patterns
Date:   Thu, 25 May 2017 19:45:11 +0000
Message-Id: <20170525194535.9324-8-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
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

