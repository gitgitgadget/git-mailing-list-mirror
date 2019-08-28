Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236C11F461
	for <e@80x24.org>; Wed, 28 Aug 2019 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfH1Oyt (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 10:54:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46513 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1Oyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 10:54:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so1867845pfc.13
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/TlOYDqkKXxir1NoGd6QxzEvMrKj9B8vGyZ4EFHBHM=;
        b=SZYC+kdHYq+ZYJElcmHUJuxkT4nXezeX+LxY+AolAJbkh88/ZpQC8kM6XzHVO+nHVg
         9vmiv638hRDdFb8+eCwXgM6DQMtdTWsUGWPZtLzDi4JZ1PDA3KMIqVfXR2yzUaMI9CJa
         RxxFIuXaqwYErxZ0/j+bBvCY9AgCD3aieCL0b43pwzsALjtPXx6ZnpLUjDPttBVom0hg
         i64rn7HvVVJag4xD/JwU+V4t0PsF7h/kyD9G4jkXgiOaa55Q7l0+rRLW2ejtDmj+dYBo
         lBxqDrtvkEmFvPU0qqo332xMO7/RDCmeIkqaQmfV0imoS3R8GjsvHJSPdmHrX69MEr3t
         DMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/TlOYDqkKXxir1NoGd6QxzEvMrKj9B8vGyZ4EFHBHM=;
        b=I6MyECxSwMu1GgRaNd5tp/f/RVerTshotZ5bgf8chgqKnCwZLmRb3nMXOwJkcX7PtS
         go0ZScvDXbNSUNJyUDAm9sDYQCv1mgisoNTnMIGNNRF2isOxB6XJ287q3NTP0f3KtkOy
         vG6MhjJUhbY5qSfVTx6EffzYNXO7V49cFAnZrMpik9O1i1l8vYYLK9NTOSYB7MiGB7b2
         oVrS8EGI0j1AnEs1Vo/aBFcoF7Mjnlw/i3/F08eWoxcCBVxk1J8KlGLPDmH5dCPpgGVr
         fMER9YiNhrq87J6FsPOLyCxNjK+PODkKAsjschmdOrJsHsYQE7OqKt+6YtAgPewu4nVH
         GHoA==
X-Gm-Message-State: APjAAAVB5fcLnOMtELyTuuIanq/EnjHgVpv73mGp5+6UuWREdDowCElr
        th+HYQo2FZh1UF8Aa+2HPaaIPfOu
X-Google-Smtp-Source: APXvYqyngTp0VY3g/UQ7diEAvEKTLSBag4xJ4ednNfC42oErfqLuzXnGpjTOiwuMGlnv0OCOKtRtnw==
X-Received: by 2002:a17:90a:ba06:: with SMTP id s6mr4462522pjr.69.1567004087878;
        Wed, 28 Aug 2019 07:54:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id 4sm4336013pfe.76.2019.08.28.07.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Aug 2019 07:54:47 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] grep: skip UTF8 checks explicitly
Date:   Wed, 28 Aug 2019 07:54:44 -0700
Message-Id: <20190828145444.31588-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com>
References: <xmqq5znrs9d0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

18547aacf5 ("grep/pcre: support utf-8", 2016-06-25) that was released
with git 2.10 added the PCRE_UTF8 flag to PCRE1 matching including a
call to has_non_ascii() to try to avoid breakage if there was non-utf8
encoded content in the haystack.

Usually PCRE is compiled with JIT support (even if is not the default),
and therefore the codepath used includes calling pcre_jit_exec, which
skips UTF-8 validation by design (which might result in crashes or hangs)
but when JIT support wasn't compiled we use pcre_exec instead with the
posibility that grep might be aborted if invalid UTF-8 is found in the
haystack.

PCRE1 provides a flag since Mar 5, 2007 that could be used to skip the
checks explicitly so use that to make both codepaths equivalent (the
flag is ignored by pcre1_jit_exec)

this fix is only implemented for PCRE1 because PCRE2 is likely to have
a better solution (without the risks) instead in the future

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V2:
* drop PCRE2 support
* add backward compatibility define

 grep.c | 4 ++--
 grep.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..69ef69516e 100644
--- a/grep.c
+++ b/grep.c
@@ -421,7 +421,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
-	int ovector[30], ret, flags = 0;
+	int ovector[30], ret, flags = PCRE_NO_UTF8_CHECK;
 
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
diff --git a/grep.h b/grep.h
index 1875880f37..9c8797a017 100644
--- a/grep.h
+++ b/grep.h
@@ -3,6 +3,9 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
+#ifndef PCRE_NO_UTF8_CHECK
+#define PCRE_NO_UTF8_CHECK 0
+#endif
 #ifdef PCRE_CONFIG_JIT
 #if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
 #ifndef NO_LIBPCRE1_JIT
-- 
2.23.0
