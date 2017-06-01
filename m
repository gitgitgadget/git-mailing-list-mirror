Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13AA20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdFASVh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32948 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751279AbdFASVd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so13362683wmh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIOKZOzNAA56n09jOHSKeNnt46oKJFwUv1cRbxoPato=;
        b=H1X+UkHjVcTgn8/sATDq+HrqjO/uGDRY6qv8MjuKBipTUpSB9Tad1vWtuvcJvLMJYw
         HyDOIHOVguDtPHivTm8+NbRQKzyoj7hpFlnazSC2fHNbb0J80A5usllLB59RklWVUF+m
         4WnKtj6GkwdLJ0re/cngNEM6ltlCcORJCNDo6oeamEQQdPJ6p2gm90zwgVxuKoOx8XvT
         PbbcT1RhMorITAHahfAxqv3dmwZ7uA/SZFc1tqI+0o2cmG4WMoZ61pRBYUuRoG5XhvjR
         ehkaWC7dnHa7YXdp8zB61la1q6bHm0bGzGhncO+57qEG0gyfVhH66iKb2vuvG0NgMZfJ
         X1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIOKZOzNAA56n09jOHSKeNnt46oKJFwUv1cRbxoPato=;
        b=bJs6BSChdcEgBEZ/PJ2hVDAqPUjc0fWDE0L+Jl6Oo7VXQ6j67c4J0Gris0gaz1f+lv
         iYgDeKfqynZYoQof/ognztTKuvn665wg0dDF4WLp7L17RVpaSuvLOX7OysBcQcIC956U
         4iyUM+pZaCSWNksfxUrhyvpTWLjyDNuJEM5pc8tInnMG+2Vvr3KL5cWPNNdqICzVJ/eQ
         g+PEojSEOF9VtIb3j1SatloD96FUuK3sB/5CGp5foR3fH6X5HBJ4Cv3sYFP3YLwk+GQX
         IaKI/ceWYBnPvWxA2/ACIwY5vWrmYtmqnCc01NglPEKX2ARxZ2SpY61Q8z9YYTKKPvjk
         5oBA==
X-Gm-Message-State: AODbwcAKeVqUyVU477uXow8GPrPcIFcnA09E3vxNKXAsSHr4eBTLszva
        dQ1Rfnc+QQEKd4P/8QzQaA==
X-Received: by 10.28.212.14 with SMTP id l14mr404421wmg.20.1496341280902;
        Thu, 01 Jun 2017 11:21:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:19 -0700 (PDT)
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
Subject: [PATCH v4 5/8] grep: un-break building with PCRE < 8.32
Date:   Thu,  1 Jun 2017 18:20:53 +0000
Message-Id: <20170601182056.31142-6-avarab@gmail.com>
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
versions earlier than 8.32.

The JIT support was added in version 8.20 released on 2011-10-21, but
it wasn't until 8.32 released on 2012-11-30 that the fast code path to
use the JIT via pcre_jit_exec() was added[1] (see also [2]).

This means that versions 8.20 through 8.31 could still use the JIT,
but supporting it on those versions would add to the already verbose
macro soup around JIT support it, and I don't expect that the use-case
of compiling a brand new git against a 5 year old PCRE is particularly
common, and if someone does that they can just get the existing
pre-JIT slow codepath.

So just take the easy way out and disable the JIT on any version older
than 8.32.

The reason this change isn't part of the initial change PCRE JIT
support is to have a cleaner history showing which parts of the
implementation are only used for ancient PCRE versions. This also
makes it easier to revert this change if we ever decide to stop
supporting those old versions.

1. http://www.pcre.org/original/changelog.txt ("28. Introducing a
   native interface for JIT. Through this interface, the
   compiled[...]")
2. https://bugs.exim.org/show_bug.cgi?id=2121

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 6 +++---
 grep.h | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index ffe95995ee..19fa67c34c 100644
--- a/grep.c
+++ b/grep.c
@@ -369,7 +369,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_USE_JIT
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
 	if (p->pcre1_jit_on == 1) {
 		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
@@ -391,7 +391,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_USE_JIT
 	if (p->pcre1_jit_on) {
 		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
 				    eol - line, 0, flags, ovector,
@@ -418,7 +418,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_USE_JIT
 	if (p->pcre1_jit_on) {
 		pcre_free_study(p->pcre1_extra_info);
 		pcre_jit_stack_free(p->pcre1_jit_stack);
diff --git a/grep.h b/grep.h
index 14f47189f9..3b948d9155 100644
--- a/grep.h
+++ b/grep.h
@@ -3,6 +3,11 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
+#ifdef PCRE_CONFIG_JIT
+#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
+#define GIT_PCRE1_USE_JIT
+#endif
+#endif
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.13.0.303.g4ebf302169

