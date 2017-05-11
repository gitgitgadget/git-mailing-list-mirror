Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6F02018D
	for <e@80x24.org>; Thu, 11 May 2017 17:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933293AbdEKRvk (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:51:40 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34897 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933212AbdEKRvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:51:38 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so3787050qtb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tlER4nXdjzplO7OfUuK6iS+qcIrfODYGzLatBoDXDI=;
        b=szRW9wnGI6HDsGJ7s7IHucvXUGqlSGnWptoJI6TNGfC90BrkBTz1L36waEutdu3SVN
         P5dCHOdA3HBkTNy4pEYOehl81cI2W5Mm/ImTxnQGSrtqxDyRjKY5SILYzXhIoZkWAWKy
         qjXfZnqrCHnhKGS8mTiBRbk1dojfJIdVSMnu3Ku52tchuUVstt08FOnhdG/5NeSSThWh
         LyvkpTBOUTDF2IR7OJN9MyjKjpjWv53q4AUm6+zi+/M4hFUPhYzbZuOIZfOUSyHrm4ad
         LpBvSKdBK4u0yNnnf5mzA0NSjcZJzgB6zKrblFbVrFNE45p8wy0QGqIW8AermYdFqPdk
         FM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tlER4nXdjzplO7OfUuK6iS+qcIrfODYGzLatBoDXDI=;
        b=DnvgCnr+9Bf3PG84mmFL30AMvUaxnGn8GMgAPcGBssCQIVFDD6xKPwe/sU0CQHCtd1
         +WYt4gmgWbkPwXEH3dYst1RZxMhHJ2y6rh/QiPxv6oHKmIFRMCZ4pHfgdOyt/AsOX1+z
         V5lUALsMe6zDKufWv04Mdx0JEjgqHTeZcxUiHntxWmM3xsnjlRw8pKAMUU13zRbuZUVG
         u2YQ6tcstUYXtV8/lpKV2C1CBKUSd5JjrNxLEHco4Iw8oaqtw6EFlfW1BuV4+bKRk0u1
         2G04RNnn0n7oxIAZlX4DBCfyItaY52+rLH6fOgjw6Q7FaCG7wAolooh+M8avHv/Ppc5e
         nPxw==
X-Gm-Message-State: AODbwcASmPFsHHGwQAB1+aZnB0ZXH9V7aGYzUM2gu6MUR0x4lfmShInQ
        HRRHYoc8KC51/A==
X-Received: by 10.237.39.195 with SMTP id m3mr52290qtg.164.1494525097727;
        Thu, 11 May 2017 10:51:37 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g3sm561483qte.66.2017.05.11.10.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:51:36 -0700 (PDT)
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
Subject: [PATCH/RFC 2/6] Makefile & compat/pcre2: add dependency on pcre2_convert.c
Date:   Thu, 11 May 2017 17:51:11 +0000
Message-Id: <20170511175115.648-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511175115.648-1-avarab@gmail.com>
References: <20170511175115.648-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a dependency on the experimental pcre2_convert.c. This only exists
in svn trunk of pcre2 currently, and allows for converting POSIX
basic/extended & glob patterns to patterns accepted by PCRE[1][2].

1. https://bugs.exim.org/show_bug.cgi?id=2106
2. https://bugs.exim.org/show_bug.cgi?id=2107

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                  | 1 +
 compat/pcre2/get-pcre2.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index b18867196e..e437fa011c 100644
--- a/Makefile
+++ b/Makefile
@@ -1541,6 +1541,7 @@ endif
 		compat/pcre2/src/pcre2_compile.o \
 		compat/pcre2/src/pcre2_config.o \
 		compat/pcre2/src/pcre2_context.o \
+		compat/pcre2/src/pcre2_convert.o \
 		compat/pcre2/src/pcre2_error.o \
 		compat/pcre2/src/pcre2_find_bracket.o \
 		compat/pcre2/src/pcre2_jit_compile.o \
diff --git a/compat/pcre2/get-pcre2.sh b/compat/pcre2/get-pcre2.sh
index f1796cb518..7679fba8e4 100755
--- a/compat/pcre2/get-pcre2.sh
+++ b/compat/pcre2/get-pcre2.sh
@@ -26,6 +26,7 @@ for srcfile in \
 	pcre2_compile.c \
 	pcre2_config.c \
 	pcre2_context.c \
+	pcre2_convert.c \
 	pcre2_error.c \
 	pcre2_find_bracket.c \
 	pcre2_jit_compile.c \
-- 
2.11.0

