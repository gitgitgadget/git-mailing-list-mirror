Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA2320281
	for <e@80x24.org>; Tue, 23 May 2017 19:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764395AbdEWTZW (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:25:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36469 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758009AbdEWTZU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:25:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id k15so40570351wmh.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HrkVJ4Dusq83LmfdHhRBKJZe0YirFLI7Lwa5Gtps5Qg=;
        b=RH2ZN+O3baSIqAEfe3HavEmcXJdSx8UTa3Y+4RUUSs32UPLXFgSCWuQq/VqN4Ufulf
         S8Z6JhX9YUaIq8HIRcpe6kw+mN5YSqLve2CryhqH1KqtHwXeG3jxufCK3EWTolV1m1j8
         DRlFgHgFUZ8Yv+3A3IvEYLqFeHmXn2PB85Pr3HxAq/z2l3nD6h0ttYeugtftN103fjaX
         Xx9GZxdNbUAus5cZqSogDY3SThaQ/cRMDL9fqtIG2t6xwU/5qN97UqnoKHr1tIxeRWty
         2SlsRGTGqFnf3IAaljQzWMODAlGgICcXj3hr62OcOzgobKzg0i2eLhAlbP761PuAc2ia
         /OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HrkVJ4Dusq83LmfdHhRBKJZe0YirFLI7Lwa5Gtps5Qg=;
        b=uYMx9/bGBwAMyH6ef/lF5RIOC03lwjrjXcKtmky3JxRHYvOaVtEPCqAEBcDQQozj3d
         g6CEdwwXdrDX3dLgaJ4yiWdLhk+lCiaaR3qtANv6wc4TYUFoooGVc1lkuyYLjeyg6JxZ
         6MN9CI+W4FjlB4/61IOgY5rFDwJV7ymWIr/Hk0ke/HC0ifdP0bto34LdHsf353GFBVfm
         sfF/aj2xn/8Fze5bcXh61h03p3fZiwRpY+7K5Ndp6piG/IJuxVkhCJLtx/3A5h0lEkFC
         X+etOArfHGbOBZszjudQfe+X4IDXqOyf0FQKBDTD+yED08dKq1sLnXPqIqmgd765i3aS
         maCg==
X-Gm-Message-State: AODbwcD9xZh+kt1+N2WWrC07Qo+zY2mnDbB9Y52LJMC9rvEiz9atIpvD
        p3YjD/F+zLVIAQ==
X-Received: by 10.28.167.72 with SMTP id q69mr3317058wme.73.1495567518504;
        Tue, 23 May 2017 12:25:18 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a24sm2203480wra.17.2017.05.23.12.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:25:17 -0700 (PDT)
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
Subject: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns under threading
Date:   Tue, 23 May 2017 19:24:47 +0000
Message-Id: <20170523192453.14172-2-avarab@gmail.com>
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

