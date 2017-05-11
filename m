Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15BDE2018D
	for <e@80x24.org>; Thu, 11 May 2017 17:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932344AbdEKRCP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 13:02:15 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35923 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757178AbdEKRCO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 13:02:14 -0400
Received: by mail-qt0-f194.google.com with SMTP id j13so3611455qta.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQkJnawxTy+2BwL5KEfEeEyiLHf/BYl41znHAsUWCwk=;
        b=Bdc3nrxALYanHuSclw7K040bcJQCOR8XYbZFaYRLwTFA561fQ17bbJuFRBRVdIAHNS
         fkZ/u8F6iN6yFCoV3SPuxSLhimvIY37jO4vPdVsVaZYSdIKwnR3XcUxn4I8B8vbpvBHC
         OHKWVg6j2MQHXpJpT1OldmDjZNCIas+Zi6mZXgyBH6RTZoEgONwUCK1oIAjsbjlGc3sC
         VvBd8CfOrIutNV5Qrq5lwrFHs2AxilQVbqXo4y6Zy5LaalybqWLI0NzNr2pGBnMISafR
         oCdfvZFCQNkQheAuowWr8khMGwbbS4p2d/ec8I1W5T1FOvj9Wo6n3sZIKBR6Je1q9Zn6
         8e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQkJnawxTy+2BwL5KEfEeEyiLHf/BYl41znHAsUWCwk=;
        b=TUHdJKDdcg8qEbTY3gLka/Dl6ZL2wjTlHhoDmLSo0D7fG5WRrOflca2VVIySQVD6a/
         1gwbU3DPdw0CL8qZ6GQX7fQPHLsQ1XqwAlYqvQZVTWGrsf85NMRswAZ28OFC72iYuoXT
         gBE2b7g7WzBnVeb+34fKlzSHG0CUAg6tiFaqre0n8u8DsZiGC6QUKcCO9/7z6a3WmUCo
         hWByN3EQqRkeYd3jhZo7QNk+wwsaGZJgZnpiLH/yW7d/67swndxZXLAwes2CgkVZd8+i
         DQLAZOUSf8Lb7yvRVI1D3MSp6/JwF3QC8JsSGaQ9qiF8dnz0HKSGWj6pueBHHf1322YF
         Cysw==
X-Gm-Message-State: AODbwcA6RobL6stPous7OSPhsOWiDlGhUzYN/b0pgHhjkRSsZl5yo0C6
        ihi5NBhV5pwlmQ6om8mwHg==
X-Received: by 10.200.48.149 with SMTP id v21mr164804qta.84.1494522132857;
        Thu, 11 May 2017 10:02:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10sm480407qte.15.2017.05.11.10.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 10:02:11 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] grep: don't redundantly compile throwaway patterns under threading
Date:   Thu, 11 May 2017 17:01:36 +0000
Message-Id: <20170511170142.15934-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511170142.15934-1-avarab@gmail.com>
References: <20170511170142.15934-1-avarab@gmail.com>
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

The undocumented --debug mode added in commit 17bf35a3c7 ("grep: teach
--debug option to dump the parse tree", 2012-09-13) still works
properly with this change. It only emits debugging info during pattern
compilation, which is now dumped by the pattern compiled just before
the first thread is started.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 50e4bd2cd2..7baa4778b7 100644
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
 
@@ -1169,8 +1170,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!opt.fixed && opt.ignore_case)
 		opt.regflags |= REG_ICASE;
 
-	compile_grep_patterns(&opt);
-
 	/*
 	 * We have to find "--" in a separate pass, because its presence
 	 * influences how we will parse arguments that come before it.
@@ -1247,6 +1246,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
2.11.0

