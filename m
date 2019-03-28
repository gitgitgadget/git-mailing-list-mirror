Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C5520248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfC1QOw (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35360 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfC1QOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so2016826wmd.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ohqqasrY0qEc1g14CFfwP5dYF1kZqk/I1BjaGdbOjvw=;
        b=BG35f/jaHcR8UKoY137vTWmamo0GUgCrbnEO5gjILndEHGMFxNsVKmiLZcPA0VGjfH
         Sj9OQelu7JUrp+dD5xmPUji1afqWEs7xgj9Dq+QFjcvMYxX+X/pSGmItakFvx88BZ74+
         yyHLCAbUh9ed5z9XCgigwpeoK3E2dupqYHVpNKahEpq2HHErxRIXj2wkdSFxsYTvZfcI
         I2QDFTwmCJEGXY+TyaPiWmS/tv9rOIRDKkmEyt4TL6KQXlDCzU0EiN5/rMODhqKofIzl
         8o3dQY2jEfv3gAreyj91WwJeanIcLnIch34vIvt8Gg2/LVhTY5qnJXQwuWhFTTkgI7M7
         TCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ohqqasrY0qEc1g14CFfwP5dYF1kZqk/I1BjaGdbOjvw=;
        b=AFat+xtF7ebLqEWbOzBAk8JySzm688jD4K9TIgLs1ITnmqELpZHEJNyXnXC0FAGvSh
         unKTdPFWEEGOYWNWQyff/ikn+ZVCDmRDQs8vdpDJosai0dpAkUxlfnc1Ju/j3QTqKNEs
         ekjUY7/3/GC2eedJb2r/GLnotqMV217vOF8KZdeb7S63twwEMesAY3zRmhWj66AaeDCU
         1xZzBR/M/htocgQdVOtbcPTQFnbfRwO1Ez2lGao9pxue+nN/XYpSBIo22iDefvvst1YH
         xK1K2/oz3/XkdEX33qvOgFWOILdcwyI3V8KAgwe5sxc41JwuHIcqeFgpZevReumr0cU/
         THLA==
X-Gm-Message-State: APjAAAUA874YPPtfRSihMzWlkafDAZnyC3RfudNje+MTxh4XyJ0qYuAS
        J6j/UCMDEVZ95JCdv5v19rvqUaF4
X-Google-Smtp-Source: APXvYqym0c6R6mvnOYQkzYDXW3VOyuvwPE6Mu8MVvfMSZ7rSrx4R78svuwj9bYjcZrwABoALKmxulA==
X-Received: by 2002:a05:600c:cd:: with SMTP id u13mr503917wmm.49.1553789689552;
        Thu, 28 Mar 2019 09:14:49 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/7] gc: refactor a "call me once" pattern
Date:   Thu, 28 Mar 2019 17:14:30 +0100
Message-Id: <20190328161434.19200-4-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an idiom we're using to ensure that gc_before_repack() only
does work once (see 62aad1849f ("gc --auto: do not lock refs in the
background", 2014-05-25)) to be more obvious.

Nothing except this function cares about the "pack_refs" and
"prune_reflogs" variables, so let's not leave the reader wondering if
they're being zero'd out for later use somewhere else.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 733bd7bdf4..ae716a00d4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -489,14 +489,20 @@ static int report_last_gc_error(void)
 
 static void gc_before_repack(void)
 {
+	/*
+	 * We may be called twice, as both the pre- and
+	 * post-daemonized phases will call us, but running these
+	 * commands more than once is pointless and wasteful.
+	 */
+	static int done = 0;
+	if (done++)
+		return;
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, pack_refs_cmd.argv[0]);
 
 	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
 		die(FAILED_RUN, reflog.argv[0]);
-
-	pack_refs = 0;
-	prune_reflogs = 0;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
-- 
2.21.0.392.gf8f6787159e

