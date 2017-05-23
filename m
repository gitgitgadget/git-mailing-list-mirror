Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FD5A20281
	for <e@80x24.org>; Tue, 23 May 2017 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764504AbdEWTZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35259 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764461AbdEWTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id g15so22163441wmc.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GLcLWxeVUaca1BP9j05r0usN52RTyOjQTrOVnzO0x2U=;
        b=BtSUN0/JWMGW7TmxM8pV981NPDgZeCds0GQYgAR/KSkLJqd8xgky/HfH3Ci+CmHjb7
         NwpAmEGAwz7x3JyPBIrXowDn8J1+NgIY40pCTu+4P03KXJSj+jRDDQSZqZNDhdli0dDX
         lNMlDvhSxKVqABgMDDIJGX9W0EsB8iGbLX7jXna0rFcE2LuTyUBiguqrXLCe8GpM2Pz8
         QeEjHtnzVnH0+wrd178orhDZMs89Oys+kV7TJrZWSLqFANehmjYjp2HREgDuAqFVu2xW
         4ZgdfkpIgRs7voyfOoml18vp17m9zVLyNu+FbpmCKZkg9FNPmbT4A/yjzNd0919aucjb
         WAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GLcLWxeVUaca1BP9j05r0usN52RTyOjQTrOVnzO0x2U=;
        b=i80inFynflrk8eX5pzSBcbciVSV2Y8yiUNv5CUuzOvANBBhRS1YtuV3+yagwkgjLLQ
         5lzzeMWDlCIZ6AZC/1txIE2BDHZmYAcMGy0WDhqPZb+mlaXL0PLv3RkLNB21InQH8tkL
         y/pMBiPbsLmjAfPn7lFSXDhdYRUDs3yMqXzf04cWaLENsrMmbhG5g55nz9wqEAFPXLIJ
         HTakB0gbFXPxJfTjc2gAk8C1Hc4uSoCyxcGYiW1vXtG8xTDOjffmquNYz5IF62uPLFCT
         BCDNt10teK/f+Q/97UeayakNQFvzYswsZdIUpQjjcBnUNCsSjIsGJGao6jUNB7hePdUx
         pq7Q==
X-Gm-Message-State: AODbwcD/neoJ1HCfWgXirKn+s3L+w/VyfwsOMX5a5Zz6VZNdvcVSS+ZQ
        NKEwZz5ouHwcJiahya17Gg==
X-Received: by 10.28.37.71 with SMTP id l68mr3304303wml.108.1495567527736;
        Tue, 23 May 2017 12:25:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:26 -0700 (PDT)
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
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/7] grep: un-break building with PCRE < 8.32
Date:   Tue, 23 May 2017 19:24:51 +0000
Message-Id: <20170523192453.14172-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170523192453.14172-1-avarab@gmail.com>
References: <20170523192453.14172-1-avarab@gmail.com>
In-Reply-To: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
References: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
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
support is because possibly slightly annoying someone who's bisecting
with an ancient PCRE is worth it to have a cleaner history showing
which parts of the implementation are only used for ancient PCRE
versions. This also makes it easier to revert this change if we ever
decide to stop supporting those old versions.

1. http://www.pcre.org/original/changelog.txt ("28. Introducing a
   native interface for JIT. Through this interface, the
   compiled[...]")
2. https://bugs.exim.org/show_bug.cgi?id=2121

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 8 ++++----
 grep.h | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 49e9aed457..3c0c30f033 100644
--- a/grep.c
+++ b/grep.c
@@ -351,7 +351,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	const char *error;
 	int erroffset;
 	int options = PCRE_MULTILINE;
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	int canjit;
 #endif
 
@@ -372,7 +372,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 	if (!p->pcre1_extra_info && error)
 		die("%s", error);
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	pcre_config(PCRE_CONFIG_JIT, &canjit);
 	if (canjit == 1) {
 		p->pcre1_jit_stack = pcre_jit_stack_alloc(1, 1024 * 1024);
@@ -392,7 +392,7 @@ static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	if (p->pcre1_jit_on)
 		ret = pcre_jit_exec(p->pcre1_regexp, p->pcre1_extra_info, line,
 				    eol - line, 0, flags, ovector,
@@ -418,7 +418,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
 {
 	pcre_free(p->pcre1_regexp);
 
-#ifdef PCRE_CONFIG_JIT
+#ifdef GIT_PCRE1_CAN_DO_MODERN_JIT
 	if (p->pcre1_jit_on) {
 		pcre_free_study(p->pcre1_extra_info);
 		pcre_jit_stack_free(p->pcre1_jit_stack);
diff --git a/grep.h b/grep.h
index 14f47189f9..73ef0ef8ec 100644
--- a/grep.h
+++ b/grep.h
@@ -3,6 +3,11 @@
 #include "color.h"
 #ifdef USE_LIBPCRE1
 #include <pcre.h>
+#ifdef PCRE_CONFIG_JIT
+#if PCRE_MAJOR >= 8 && PCRE_MINOR >= 32
+#define GIT_PCRE1_CAN_DO_MODERN_JIT
+#endif
+#endif
 #ifndef PCRE_STUDY_JIT_COMPILE
 #define PCRE_STUDY_JIT_COMPILE 0
 #endif
-- 
2.13.0.303.g4ebf302169

