Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE83C1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765091AbdDSWlb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:41:31 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35026 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765051AbdDSWl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:41:28 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so5114559wrc.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeHzrRmQLWQyFAhcsLbcikpY5MCcrJwGkFz81ap+R3A=;
        b=FU4J6HLc4dBFcwGOdjPZGyWU1bzci7MQ5aXaq6RTiYYllzcKtg3nRwo2bSH/aeOyk+
         vfKHvQsRNMhdbtWBCePanLFMN14GrGBBCR49vrlGgwO4GoW35HxDqaFBFzkh4yE3BuDP
         NoNq3YfzcCg+X6lBIFUNj4vv2ZM0iS18Lz6MheOATPUSgM7dF9j7uKPsrsgwoKZQ68Mz
         dzEwoDfkKUwrrcPFeCm3uLfjqFDL+QVK5BDGCYmIeGRzLg8pW4VF3J+YIFB4phom7Rf2
         NKDFDGQh7vcJd5eQ31O1LBbD9p09zirSs+IwgzpSA/2GMa3hN/1kciM40aAmIL/yZiTQ
         6qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeHzrRmQLWQyFAhcsLbcikpY5MCcrJwGkFz81ap+R3A=;
        b=MCeolqE1Rl1tGC0bAz+tZoNVd5N+DjERH4zn3exZJ7StG19GElbNKaYSYJVOg044N9
         0ej8eOGOAS1qUdaLFUPIs5+yTvZDdbF2HO/1SrtZq6Gwlgl8jn0YVarkaY3rXPIbAizW
         /4pOb81BgmEyz8QEayDl12UCFjKOSH3EBZ4TiAt/Mbards7M5DfWZhBWd7mN+SDBtmpW
         8zkMXALzfbCO/7dFTWaDEU05PDscw3+cYWReA7Xxns+xOKRpeVhAUkcGLJkYHnQPQxYg
         jUNIeBO1gn1ZZ3L6DI3NgSVk6WH7i1DXIjr/157V56EtJJMh+xO0pyfd5n7fwAl5RXnX
         F/fQ==
X-Gm-Message-State: AN3rC/5Fjor6gp8rENvwbP45yV0g7vWy4cV0d3jrvLDy0//JRaCwaTxQ
        KRQr53ZG48D+6w==
X-Received: by 10.223.165.5 with SMTP id i5mr4710451wrb.13.1492641686441;
        Wed, 19 Apr 2017 15:41:26 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:25 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/13] grep: add a test for backreferences in PCRE patterns
Date:   Wed, 19 Apr 2017 22:40:43 +0000
Message-Id: <20170419224053.8920-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170419224053.8920-1-avarab@gmail.com>
References: <20170419224053.8920-1-avarab@gmail.com>
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
index cee42097b0..8baed0f37d 100755
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

