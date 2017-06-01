Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCDEA20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdFASV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35362 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdFASVY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so13325344wmc.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTzczVrKyU/TekWAHLBE5UzHiV4zkTFIDHa0S8x82Vs=;
        b=u3p/dGxZPaKx2C49HQsuP/eMRBverKM9a31AtB6oQBsWy41Hf7XC7P60lKAhAr5Rgr
         SbD/d6Zwy4QLfHL8IBmP1Yh5LDcs3FAUb1PgWSkrKo/4aBJmlERNvWljfGdtEB4FwsIb
         vG4YHiKP++93ufQWbSIiBBYIr79SOe65rvim6MmzLTgctpOatTeTR1UjZN1vmW5GA5a7
         Gtk1Omr3pZzOJXX8KD8pov8teI+AEgaFzr4AFM6pd8wJn+iGHUo6C4A4KBAQ7+471vyS
         9WdZroSb/FG/CgnPMm3LlzZDkiZcAlHUHyo1g3rLeeaoLUltsgPx1bTvfRhsPLEl1uIo
         3k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTzczVrKyU/TekWAHLBE5UzHiV4zkTFIDHa0S8x82Vs=;
        b=UZhgSQrTvjlt2X7thGbZa+LPs+H6yCkZs0/tN52r65Hi3ulvFL7nPAboe46CJ086X6
         4771fCeMFkdS0NWZ1a5qUloq+V4tmwCf7Au7gUykYByyhATXfs5QDezaUOY5caI6NJ57
         BFewWsa4K532J3p8KK0q5dOQZJ4eiLAKKfdQbGRYvCeRxVVKWuu3XD+FqqwkSl9MmZ+z
         CQjFgBJ7Gyet1HnqO7l64W+YEHsb/JjVk40rSg9TcNEBeIBLRtkMOwmXULAAIW9Z8L+p
         +PC6JcRh1u9DcXtuRCrxS31hFPxn9NRg5ecVwNvKISxJuvy2c5d9Gb44Ptl+xLsDRE1o
         /JtQ==
X-Gm-Message-State: AODbwcBsw+dEQAx5Rz8QzqXjvOabFvWoRpkGkb+n3zTvJ9gCWHtXzNkY
        m8T2IQJbEErmzGxRLbYViA==
X-Received: by 10.223.129.4 with SMTP id 4mr2267666wrm.153.1496341282960;
        Thu, 01 Jun 2017 11:21:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:21 -0700 (PDT)
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
Subject: [PATCH v4 6/8] grep: un-break building with PCRE < 8.20
Date:   Thu,  1 Jun 2017 18:20:54 +0000
Message-Id: <20170601182056.31142-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170601182056.31142-1-avarab@gmail.com>
References: <20170601182056.31142-1-avarab@gmail.com>
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
index 3b948d9155..ce90969736 100644
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
2.13.0.303.g4ebf302169

