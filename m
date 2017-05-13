Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2B420188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758878AbdEMXRF (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:05 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34041 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbdEMXRA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:00 -0400
Received: by mail-qt0-f194.google.com with SMTP id l39so11212329qtb.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w56Kb0evArd9U63bzFWr5rYCPkWgohu1NhtLyeSqMak=;
        b=hlDL6S34PjVSCLMmkVP+u2i1VY2L4hth+bc7WlBXfSsUK+b4sSt+mv6eVWrVlvHjUX
         Yvl85oVibccm+SLxosYIoSygk98WUsq+MBT4NgmXWf1yPbYkqCjvlhzqnKYYFKxJokrM
         5NN3cLy88CS4kQ2CaJchvO//DBICMtgGtbdvaKNByachXAuE7aAmqqBNY2a4GtsRNdZk
         dtwREJl3IE5t5rycw/unzmYWp1bVr85ZceeaxX/K32KivVDlhyo7469FPYPtdo/2QDWR
         gVEgGYyxZ+oK1w6ses3MxsBKrLVED/gfFDjvB1jpMaXcYaLYztPB59dhpn6g5YSQKJ62
         QilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w56Kb0evArd9U63bzFWr5rYCPkWgohu1NhtLyeSqMak=;
        b=skpKVYDzSuPVVV9YGhm/yrYXtbNZZ/7H7ZLVwh/djpOYKjr0A1MMWEG5Ftw+PzMsKA
         kWLdwT28L7opRizHcTDImo0D462wlbbKdqot/k/F54og4g3pM+2ls1z+Ovk75JJrLMkF
         0Ve8w/mWNtkxxJsytPSlVoHjwqnIAFASk+B4t4R7tJM+YhfLMRIgRbDK+bQtwpC5uvBL
         4MSVWBhP1bps6tO3Y/Ab7Dsrr81Tg6DEc6FnuTYlfBmQ4pBx/pfU8fjz9Ep0m7YrhgVU
         Hr/owfwiHqkdg09DRv1LYs7f10PQ/hvk7EAUCFbI9m0wlfBByFGM2p1Hrdp86CE5P5HW
         KqIQ==
X-Gm-Message-State: AODbwcCXInQkNd4j9Gn7kUw8Cwqa8GOPYCH8gaRwmM79RXiIpzXWwePG
        5M2kr5GhMu9edw==
X-Received: by 10.200.54.188 with SMTP id a57mr9562035qtc.66.1494717418980;
        Sat, 13 May 2017 16:16:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:16:58 -0700 (PDT)
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
Subject: [PATCH v2 21/29] grep: factor test for \0 in grep patterns into a function
Date:   Sat, 13 May 2017 23:15:01 +0000
Message-Id: <20170513231509.7834-22-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor the test for \0 in grep patterns into a function. Since commit
9eceddeec6 ("Use kwset in grep", 2011-08-21) any pattern containing a
\0 is considered fixed as regcomp() can't handle it.

This limitation was never documented, and other some regular
expression engines are capable of compiling a pattern containing a
\0. Factoring this out makes a subsequent change which does that
smaller.

See a previous commit in this series ("grep: add tests to fix blind
spots with \0 patterns", 2017-04-21) for further details & rationale.

While I'm at it make the comment conform to the style guide, i.e. add
an opening "/*\n".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/grep.c b/grep.c
index bf6c2494fd..79eb681c6e 100644
--- a/grep.c
+++ b/grep.c
@@ -321,6 +321,18 @@ static NORETURN void compile_regexp_failed(const struct grep_pat *p,
 	die("%s'%s': %s", where, p->pattern, error);
 }
 
+static int has_null(const char *s, size_t len)
+{
+	/*
+	 * regcomp cannot accept patterns with NULs so when using it
+	 * we consider any pattern containing a NUL fixed.
+	 */
+	if (memchr(s, 0, len))
+		return 1;
+
+	return 0;
+}
+
 #ifdef USE_LIBPCRE
 static void compile_pcre_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -394,12 +406,6 @@ static int is_fixed(const char *s, size_t len)
 {
 	size_t i;
 
-	/* regcomp cannot accept patterns with NULs so we
-	 * consider any pattern containing a NUL fixed.
-	 */
-	if (memchr(s, 0, len))
-		return 1;
-
 	for (i = 0; i < len; i++) {
 		if (is_regex_special(s[i]))
 			return 0;
@@ -451,7 +457,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	 * simple string match using kws.  p->fixed tells us if we
 	 * want to use kws.
 	 */
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed || has_null(p->pattern, p->patternlen) || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !icase || ascii_only;
 	else
 		p->fixed = 0;
-- 
2.11.0

