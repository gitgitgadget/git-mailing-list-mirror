Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A4420D11
	for <e@80x24.org>; Thu, 25 May 2017 20:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165463AbdEYUGC (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:06:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33428 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1165441AbdEYUF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:05:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so39781479wmh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PIOKZOzNAA56n09jOHSKeNnt46oKJFwUv1cRbxoPato=;
        b=PKNfw5M3SgIy/iGkdO9aMTCVBQji17hQ1qAYH25b81V2zY4Wd4RbgH5Vym8U2jKfnG
         heLUMzvQUAgZlW7d/u1kvfzUqjfGHKiknwT9ZfLm3C/KvABlQgnTbqi5kPC9axme6sD7
         SXjtS3TQK1Za9w5PK0TMYyMGqwFuZRR/1fK5kFO5GYKouyjDVLoygiInu2DwY+hyB3bx
         LEskzQFwlcMNJ6wZDBM/iRTfTAniOfAboYUlBTUqKjiT1R3fhnyFGbwT7GblLIOcbNWK
         /jg1c57msMsAw4FrGxXCdPzFNMy2QlmIn3WsBf9vXvs6vMyJEQ4+vBxd5ogDP0CGNZlF
         Gk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIOKZOzNAA56n09jOHSKeNnt46oKJFwUv1cRbxoPato=;
        b=eyK+vyASQ3bZHV9hGZzcavOLy3tTe2HpETtIYdOu5pFKW3txm4a1Qqk/RbBbXONy+A
         0yhZFy3J44we7IfxeEBHxXutLNiqQIjKN34do9ABVXPsHNkS77lMUdrbUCwCuAlrNVky
         nwlBepa7LeMiBvtR05GsLWIfnclP5WfhAlDqtaMrsJnsRpIvf2V4z9UUK+M2vtiZM3Cy
         /8PWY4ruxvjHLiTfNpjsBipBGIB+0qyPzevpGjR6RwGH4uaI+/wyuUylP6Ml7arPJ7qL
         H5WJuRSz5u5aoOry/bmGU2gF7u3hfCGJguvEzvuAhtKYcWqDVT/OVha7wFmlryPl48+v
         wfCg==
X-Gm-Message-State: AODbwcDBgrboOH9Anpg7bQPjqTYZN2pkvBx3hHJQVZ3IJa64xw9UQ+Pk
        kRAdQu/S1Zn7qg==
X-Received: by 10.223.151.146 with SMTP id s18mr24866243wrb.40.1495742757765;
        Thu, 25 May 2017 13:05:57 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:56 -0700 (PDT)
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
Subject: [PATCH v3 5/7] grep: un-break building with PCRE < 8.32
Date:   Thu, 25 May 2017 20:05:26 +0000
Message-Id: <20170525200528.22037-6-avarab@gmail.com>
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

