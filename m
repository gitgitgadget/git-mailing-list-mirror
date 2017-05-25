Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26114209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165468AbdEYUGS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:06:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33549 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165448AbdEYUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:06:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id b84so39781655wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTzczVrKyU/TekWAHLBE5UzHiV4zkTFIDHa0S8x82Vs=;
        b=o23fvbPFsNVC0FnnKBCdkGIgdVM8Zje9Ycw+IkYviqSTAiygYuqo006VKJG/c9D+Ct
         jlUKLGe7SVaPARc7vl4xSolVh+qi+IzRBHYSv4smTPLH73sp67Rdv3BhcdO3N5Sm87Ix
         KlpMTL0m1ekpF5P8xVF03266ummrlM5WaAGlsgaZoUqLaTQ6/5PyyzCqnqWeek8VvVQk
         HtpIZvk+KHKAEbFgd3qv0WJF7gvJ4X27vwSGdcAMCimI6KY6XyQoudl0QJjC3RG1wog8
         ee5c7refccuOt3Y2fTM2DdlS7QrYBlVhzJsVSlb8StidRwA/x0ezb6w/0PuNmvPdPFgt
         muBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTzczVrKyU/TekWAHLBE5UzHiV4zkTFIDHa0S8x82Vs=;
        b=gVUyMTOVQ4I+Cmd7IBVO3Q8sly0whxe7REJwTCrpqOOQdIjV8+IslQFtvwRQRvWMqr
         CBvIjglKeXPAgiG2EvIags/x8/urOaEIzZxOQHOnON1dz05vZPuG+Ad4PQzXCTttyWyb
         eG63Dt1Ciot88b2Ah3zd89FeOd7HAStSvZAHRJNuncpG67OEb30cAQJJrQnt/IgFw8/5
         hEcxt7Qu6qDIYaoNjFQBFLRzTDBZBP6RMhy3wKDUkE2fFmWHB1rHJpD+N3NSciD3rfzU
         AaXURcEJ2DV8z1aeeqekhIQvzLKFoCt5xWGkKDksBV4vDlI5jkWIcWvSLfOjsLph/LaA
         yesQ==
X-Gm-Message-State: AODbwcAgWh7nvgBXm4ggvC1Cu4ZCnCvH85T5yx2QI0PDSruMSopPUoIS
        3wEmxIaLXpBNBQ==
X-Received: by 10.223.165.14 with SMTP id i14mr29922476wrb.127.1495742759620;
        Thu, 25 May 2017 13:05:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:58 -0700 (PDT)
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
Subject: [PATCH v3 6/7] grep: un-break building with PCRE < 8.20
Date:   Thu, 25 May 2017 20:05:27 +0000
Message-Id: <20170525200528.22037-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525200528.22037-1-avarab@gmail.com>
References: <20170525200528.22037-1-avarab@gmail.com>
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

