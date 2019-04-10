Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A71D020248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfDJRhz (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43213 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfDJRhy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id w3so2770633edu.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NmPrKBH95W/J/xZgv+G4CsKw6zBPtFdY24F+BBhsbJU=;
        b=iXroslVWMzwofEKZbLv73F4uwCKcp07ER4xfD9B4FLdOs4PJuHlnZ7u6PppvRFbRQI
         2Hu+HOooUfMTa57QpLCyVWG2CX5Rqf3I3OPwe0Gh7l3NCEbaTh6nhG84/NI+kHPhbSfm
         P8j4QW22xTY3DQmwSF7cZmqVOY0MBJT+tQh1COCIaXOFpkcs76QS4dJR61VzVZokfvhZ
         HvAgAfVIR5FTGTsnmth2AS0i4FLPtBCyM+vCzBC6Xk8Sn9gmphD2rcV5bC0t4hjSdvPZ
         IATKS88tr9WPpaAX/3u9QUqWXoflvTRqK03uK4asjD8VC00rFsi+L++Rb7vCx/6QSrY5
         Vzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NmPrKBH95W/J/xZgv+G4CsKw6zBPtFdY24F+BBhsbJU=;
        b=i1TS+ESgsC+EvKB3ikwVNKCwpcUEUJrk0Cy+Ty0lVBjg6b8l1d1U8ttmK+brRqPLFN
         jMv/sdx2bZyMCE9m3ks8K5+5u5wumRl6l5aPP1eR/wmEewKoyoRB0IqHHPlBFYzexyOU
         1ps9ejOghS/N5Mkr/X2jil0EAi1cJWZbY2Gh9XFM2GEjaCEgdWzKCsuVygtzG22yZU9N
         cTj3/Xokdbs6iQBwuOyLlBC/5Mj2H+QY48SZdmi3Boyeg/YBDuk+TgOO3xRuerqYd++/
         XaH6NkQn5rvTNX4wBsw4j07UkUcMwW0EPHKZnbEucODJGczavA+3r/pTMc63vEjXCv4H
         LsqQ==
X-Gm-Message-State: APjAAAX0yA3CaeaTsqK3+2kqr45KVqIZNd1tahRD0CJIvDJdwUxdN2gy
        JScOoSFL7M2s6E6UDlleILgUASHt
X-Google-Smtp-Source: APXvYqx+8c8wRKleUMkWljstFWSJaGSVDO1431apSE3dt5Rgqqkm0rtsYcnTuLDieCy4ld29mJa99g==
X-Received: by 2002:a05:6402:501:: with SMTP id m1mr15279161edv.216.1554917872080;
        Wed, 10 Apr 2019 10:37:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20sm6673867ejb.65.2019.04.10.10.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:51 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:51 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:39 GMT
Message-Id: <06ba1ae34462c201b19b617ee23e76886928b387.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/11] diff: export diffstat interface
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Make the diffstat interface (namely, the diffstat_t struct and
compute_diffstat) no longer be internal to diff.c and allow it to be used
by other parts of git.

This is helpful for code that may want to easily extract information
from files using the diff machinery, while flushing it differently from
how the show_* functions used by diff_flush() do it. One example is the
builtin implementation of git-add--interactive's status.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 37 +++++++++++++++----------------------
 diff.h | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 5306c48652..daa5f3a736 100644
--- a/diff.c
+++ b/diff.c
@@ -2489,22 +2489,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 	}
 }
 
-struct diffstat_t {
-	int nr;
-	int alloc;
-	struct diffstat_file {
-		char *from_name;
-		char *name;
-		char *print_name;
-		const char *comments;
-		unsigned is_unmerged:1;
-		unsigned is_binary:1;
-		unsigned is_renamed:1;
-		unsigned is_interesting:1;
-		uintmax_t added, deleted;
-	} **files;
-};
-
 static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 					  const char *name_a,
 					  const char *name_b)
@@ -6001,12 +5985,7 @@ void diff_flush(struct diff_options *options)
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
+		compute_diffstat(options, &diffstat, q);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -6306,6 +6285,20 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 	return ignored;
 }
 
+void compute_diffstat(struct diff_options *options,
+		      struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q)
+{
+	int i;
+
+	memset(diffstat, 0, sizeof(struct diffstat_t));
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (check_pair_status(p))
+			diff_flush_stat(p, options, diffstat);
+	}
+}
+
 void diff_addremove(struct diff_options *options,
 		    int addremove, unsigned mode,
 		    const struct object_id *oid,
diff --git a/diff.h b/diff.h
index b512d0477a..ae9bedfab8 100644
--- a/diff.h
+++ b/diff.h
@@ -240,6 +240,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
 void diff_emit_submodule_pipethrough(struct diff_options *o,
 				     const char *line, int len);
 
+struct diffstat_t {
+	int nr;
+	int alloc;
+	struct diffstat_file {
+		char *from_name;
+		char *name;
+		char *print_name;
+		const char *comments;
+		unsigned is_unmerged:1;
+		unsigned is_binary:1;
+		unsigned is_renamed:1;
+		unsigned is_interesting:1;
+		uintmax_t added, deleted;
+	} **files;
+};
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
@@ -328,6 +344,9 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat,
+		      struct diff_queue_struct *q);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

