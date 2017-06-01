Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA1120D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 18:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdFASVR (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 14:21:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFASVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 14:21:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id b84so13361758wmh.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 11:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n5tihWwIqT0JTlSmZsNAFg35uuJthKThTjpI5SKqAkk=;
        b=c4JtGt5eoq/WIN5WtwDJMrgsdCPLxlhMgE9+pVED2HPmXkJQZ2cFBqIk4dUt++hqaI
         kbiFWNLjzFriGKc4bxWLnasvCR5Vt+/UZCzcqtOkQ6NIU+3iKttFHwQaT7oazqB+cus4
         EY15PNQcPctoj6ioB1rGTOjsqFxROhFLVw1eymAvu6BICaE1SbxNjrf4BsJAHkdOdtXJ
         DeOyA4hDZTBtNx8HKEFOu6DEbqXoChqezSjgVwdcwr5JFqTqXaJ7T3fLzcA0b2wU3+Ts
         VtsYz/kayaIxPRmb3On+WrKYaSTufwsFZJGuuJ25HYXnRfUMReKmr6J51htii+iCTWc/
         kq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n5tihWwIqT0JTlSmZsNAFg35uuJthKThTjpI5SKqAkk=;
        b=CuFxWL9ZTqyGGK0IYcVUFRQe6qdOgd74eWi8aTMjsfvcojq1f+AdvBNXXnhUJSUHti
         mERSOJjLk8TL2V3InML2hSJQ6YPVoUgbQ/kfnV4g4YO1dEr+Pd7Fgr0OyoxiGhKAetun
         HQN34hchfuSb6brn+JQ0Bjby8sGBQA4uWvgOLEE5neWkU3mldB6KqPt0DXOhhxrt0rQB
         h1t9VdjWqDaZcts81w3Sj2nBHOGwjs64qkmwnu6hCED/OuAehIH5H7c7XQ3dYMtl40hR
         0nA+47GdR3ITJW0XH9/1EntGZlW0N3yTkfRUjVuVRGsYQedeFkCUQOGhCfkdS30zFhNI
         Jvuw==
X-Gm-Message-State: AODbwcCO2CxyeMZoTLQOk8Dl1RkVxXFn0KES4obMFUJGxQ8KA6fY3nK6
        OIGJWdkktgWoX7gLEk+nAQ==
X-Received: by 10.28.18.141 with SMTP id 135mr360526wms.106.1496341271735;
        Thu, 01 Jun 2017 11:21:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 140sm151065wmu.23.2017.06.01.11.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 11:21:10 -0700 (PDT)
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
Subject: [PATCH v4 1/8] grep: don't redundantly compile throwaway patterns under threading
Date:   Thu,  1 Jun 2017 18:20:49 +0000
Message-Id: <20170601182056.31142-2-avarab@gmail.com>
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

Change the pattern compilation logic under threading so that grep
doesn't compile a pattern it never ends up using on the non-threaded
code path, only to compile it again N times for N threads which will
each use their own copy, ignoring the initially compiled pattern.

This redundant compilation dates back to the initial introduction of
the threaded grep in commit 5b594f457a ("Threaded grep",
2010-01-25).

There was never any reason for doing this redundant work other than an
oversight in the initial commit. Jeff King suggested on-list in
<20170414212325.fefrl3qdjigwyitd@sigill.intra.peff.net> that this
might be needed to check the pattern for sanity before threaded
execution commences.

That's not the case. The pattern is compiled under threading in
start_threads() before any concurrent execution has started by calling
pthread_create(), so if the pattern contains an error we still do the
right thing. I.e. die with one error before any threaded execution has
commenced, instead of e.g. spewing out an error for each N threads,
which could be a regression a change like this might inadvertently
introduce.

This change is not meant as an optimization, any performance gains
from this are in the hundreds to thousands of nanoseconds at most. If
we wanted more performance here we could just re-use the compiled
patterns in multiple threads (regcomp(3) is thread-safe), or partially
re-use them and the associated structures in the case of later PCRE
JIT changes.

Rather, it's just to make the code easier to reason about. It's
confusing to debug this under threading & non-threading when the
threading codepaths redundantly compile a pattern which is never used.

The reason the patterns are recompiled is as a side-effect of
duplicating the whole grep_opt structure, which is not thread safe,
writable, and munged during execution. The grep_opt structure then
points to the grep_pat structure where pattern or patterns are stored.

I looked into e.g. splitting the API into some "do & alloc threadsafe
stuff", "spawn thread", "do and alloc non-threadsafe stuff", but the
execution time of grep_opt_dup() & pattern compilation is trivial
compared to actually executing the grep, so there was no point. Even
with the more expensive JIT changes to follow the most expensive PCRE
patterns take something like 0.0X milliseconds to compile at most[1].

The undocumented --debug mode added in commit 17bf35a3c7 ("grep: teach
--debug option to dump the parse tree", 2012-09-13) still works
properly with this change. It only emits debugging info during pattern
compilation, which is now dumped by the pattern compiled just before
the first thread is started.

1. http://sljit.sourceforge.net/pcre.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 972ad91f0c..6e1744550c 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -224,7 +224,8 @@ static void start_threads(struct grep_opt *opt)
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
-		o->debug = 0;
+		if (i)
+			o->debug = 0;
 		compile_grep_patterns(o);
 		err = pthread_create(&threads[i], NULL, run, o);
 
@@ -1167,8 +1168,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
-	compile_grep_patterns(&opt);
-
 	/*
 	 * We have to find "--" in a separate pass, because its presence
 	 * influences how we will parse arguments that come before it.
@@ -1245,6 +1244,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	num_threads = 0;
 #endif
 
+	if (!num_threads)
+		/*
+		 * The compiled patterns on the main path are only
+		 * used when not using threading. Otherwise
+		 * start_threads() below calls compile_grep_patterns()
+		 * for each thread.
+		 */
+		compile_grep_patterns(&opt);
+
 #ifndef NO_PTHREADS
 	if (num_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
-- 
2.13.0.303.g4ebf302169

