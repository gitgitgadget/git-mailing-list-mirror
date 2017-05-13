Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDA120188
	for <e@80x24.org>; Sat, 13 May 2017 23:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757648AbdEMXqY (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:46:24 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35741 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757293AbdEMXqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:46:22 -0400
Received: by mail-qk0-f195.google.com with SMTP id k74so12579268qke.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lq+2/Mo2yDorJ0O3vWFcbpiGK2EtMtlzZ6uviMlAqaY=;
        b=ea3fynAILJGWNv81GxyTKcMekD4/fgu2T6/23B317IaoRs4iIsRnJDSMy2NFRHMZl2
         e5cz3q4ArKLLWNi47qNwwhiX74wQy4L8nb4pljReGIRer/psSexC1momQPfmF7w/PgeQ
         7v6KuRe08OeG2TYFau+d1/ZXcNlrIskZrfLFeX3qaQal6hhcUzp3ueveUKs7cd2327rY
         kmYdGDVrHsVBe4Cg+BXvR3Jl3FLKZ6JwjBzxvmJATLa4eDzy2t2ZAQbmDu8AAf7pffSJ
         +YFlfEWL/XPe5Hpr7uawy7x7oOxyZU5qgB4DA52YjNBeJLM5drbRI4hVpkOXFVuId3+D
         PUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lq+2/Mo2yDorJ0O3vWFcbpiGK2EtMtlzZ6uviMlAqaY=;
        b=AdqEmx2flzGEP+zpZXDFaLfhCKnKUa423aWr7Njsn5to4J1y29XIcctekBNTT8JZx2
         kHsGTzOhO/cDOjQOOwgWvrebxwxHU5H+Sz6KI6Avfi1LwuKgip5dsIjXCIuy0uqC8Gi2
         pr8urfmk4E4xSMPLwkhl3q3DUoSc1sZ+ZvnGvD8NmkM2jxE54IPTUJWK8ybSyZcwKkPh
         MXk4W9GaoM8deNCsY4LIOjsb9L/nBWTm10Ib9q0ZAXq4+bjiH8fTXI+GdXxAp5zPKCLp
         7B9j0/kfoO+gBjekPalZahCJT3JgErpINfb+8n5wRDzmNn2AxsZPGpDqzXb87QzzahIK
         70HA==
X-Gm-Message-State: AODbwcBfNjAmKx4+AeHjiDALegmW57VCM5Fpm9r2L379D6mgo0/Zjn4J
        usS9K0WGJU3RQw==
X-Received: by 10.55.40.41 with SMTP id o41mr10821159qkh.3.1494719181419;
        Sat, 13 May 2017 16:46:21 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h14sm5319234qta.18.2017.05.13.16.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:46:20 -0700 (PDT)
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
Subject: [PATCH v2 6/7] grep: un-break building with PCRE < 8.20
Date:   Sat, 13 May 2017 23:45:34 +0000
Message-Id: <20170513234535.12749-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513234535.12749-1-avarab@gmail.com>
References: <20170513234535.12749-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend my change earlier in this series ("grep: add support for the
PCRE v1 JIT API", 2017-04-11) to un-break the build on PCRE v1
versions earlier than 8.20.

The 8.20 release was the first release to have JIT & pcre_jit_stack in
the headers, so a mock type needs to be provided for it on those
releases.

Now git should compile with all PCRE versions that it supported before
my JIT change.

I've tested it as far back as version 7.5 released on 2008-01-10, once
I got down to version 7.0 it wouldn't build anymore with GCC 7.1.1,
and I couldn't be bothered to anything older than 7.5 as I'm confident
that if the build breaks on those older versions it's not because of
my JIT change.

See the "un-break" change in this series ("grep: un-break building
with PCRE < 8.32", 2017-05-10) for why this isn't squashed into the
main PCRE JIT commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/grep.h b/grep.h
index 73ef0ef8ec..b7b9d487b0 100644
--- a/grep.h
+++ b/grep.h
@@ -11,6 +11,9 @@
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
+#if PCRE_MAJOR <= 8 && PCRE_MINOR < 20
+typedef int pcre_jit_stack;
+#endif
 #else
 typedef int pcre;
 typedef int pcre_extra;
-- 
2.11.0

