Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF232209FD
	for <e@80x24.org>; Thu, 25 May 2017 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161878AbdEYUFp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 16:05:45 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37478 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161618AbdEYUFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 16:05:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id d127so111550401wmf.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrkVJ4Dusq83LmfdHhRBKJZe0YirFLI7Lwa5Gtps5Qg=;
        b=ij6V8tshB0MJQ762ojAgHrp1BKsbVrCsgqqA2tW7ObdoInk7gjIRWzuZprKao8eQYy
         IGxqHtD8kwcGlRXYsWeGB+WhHqJ2FulUfo2YOKVVQn/kFl8e9+I7mZeKZQVNQ5EcJ7tb
         /T4//9HiNjpbJkkM6RebaZdr6LxGS0NDfWXGwbiHVMvyYlTlGj+kXLSO3RMC9hl6kMMn
         lRy4baugsBGo32NJH6A2NObaON/YryJObZNFnesmWyg06KWIdYdwla0MYfzelpbeno80
         12ailCspV8f+NMDfPDCRXGwg9pmTyQ+RzCO5Hew4Qhptj9SHDGSqmAMw4BpZd48Ut1DD
         oDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrkVJ4Dusq83LmfdHhRBKJZe0YirFLI7Lwa5Gtps5Qg=;
        b=kj89A8v1vGADYsTeQOXG+BYZA9b6Ic6uQu/Y+XGlDOn0Y2eU4LkRwQoRCXi2LpIxqe
         qIgb2kPDIE0chkff5zaX4HC7bPI3ZZ7hMBn9iuD8rgi1CF9I2c0Rl6TJazQLzGbvJQhx
         zpfSpnrbLh1kDrilqXazmeknfED3jjcYovJFvnM53pq8maJmd+kKXSvm1FdqqhaqeJds
         tvPfwP2QGGGZOZNSUOMpNSIRkZyLf2GtQa8ndGNAP03w7KYnK6FQ8IiIV/1ZtuIfyWPq
         6cVbVXmIvzXgw29E6Q+lQQ+FXqF4TiTRupERZLJfajEPef95ccNseIF92iMPIOzTLpTZ
         0DCw==
X-Gm-Message-State: AODbwcAqMWghMd9RqpxwQUvDUseTC392vCUcFr26RP1uE62I8VnOQt6j
        e+3he8tRRwMHkw==
X-Received: by 10.223.142.50 with SMTP id n47mr24399683wrb.188.1495742742205;
        Thu, 25 May 2017 13:05:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id r60sm10574313wrb.37.2017.05.25.13.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 13:05:41 -0700 (PDT)
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
Subject: [PATCH v3 1/7] grep: don't redundantly compile throwaway patterns under threading
Date:   Thu, 25 May 2017 20:05:22 +0000
Message-Id: <20170525200528.22037-2-avarab@gmail.com>
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
index b1095362fb..12e62fcbf3 100644
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

