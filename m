Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968091F405
	for <e@80x24.org>; Thu, 20 Dec 2018 12:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbeLTMJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 07:09:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36966 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTMJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 07:09:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so808558pgb.4
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=O+pi07tJjbQLYIpxWL5HdyhYzNdhIyDiORWy96f75l7gQ2/mouwFL4va7aN4zP1nXm
         Jf6YIeDyXNuvrPrVoZqF4yi98ZUtN6a3pYKDJCQr0wymNN42zcd25eVxUgsxdgWdU5u4
         psMmBrPUMnS7239OMZEueihW3qIL/Nv4GF/pPDr4hyJlOdqSo5dsCtYazfyspp8+pUei
         JjLp0vptqmX5zB9KGhqpG8xvTF55PWbrrUod02YoCfDegJErYqdSsRtX4M92skU9Lu4o
         ssitpNVqnTnf3enb5ERSkYAFIuJQJxNs6IzomX7mpSG5lbobSUxXqVFeEqqKWJTRU1Ys
         Upbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jWQp+OnjGGR/qjsHpDv/5/slcc6yYLWT9gs2Yk2rhoo=;
        b=kBgN+oTpnnQVHAyJgRGbXCYE4GannjiyQtS7L0eogIj9urf/fqRqxkaIXZPVo/ptM4
         7ZTFAplAASI0rzu7x9HU7dgeqGy3yQCGaJVMIT8cnrtDhzdEnBNd2dHF2FXHXVv4tWJS
         UVwNn8KnUDvzk9GqOGugo98JqWP/YpZxcrFlFag54uqll+RVNkf8hec89vExO4D/j+NO
         cQ9q6AqrP4Y9qV/dT793bXGfoMMagSZogFba+c9HhzqfKY4CbmbcJoUerXInP5k+DC59
         x/ZJt/7+67RNl54dipk6JjccJPIxbmKejJshMpyTlkMaXD4ruaXFiNuom4flIZs4Tj9p
         FsNg==
X-Gm-Message-State: AA+aEWZKIHbHj6JJ4MFarfOV4IsKV2s6LVmssWorMDwuY/JdLQhsEJP1
        qYbEW+vkkzrwKDS9aF0hL6yb1RD/
X-Google-Smtp-Source: AFSGD/UMJBXL31/PtSufSKH/TKbYYBSOrCiagHFDjj+rmttavQB+DKEFvUwSZmep98MdIHmiblzhAQ==
X-Received: by 2002:a63:8742:: with SMTP id i63mr9878720pge.298.1545307760304;
        Thu, 20 Dec 2018 04:09:20 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id f67sm29903288pfc.141.2018.12.20.04.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 04:09:19 -0800 (PST)
Date:   Thu, 20 Dec 2018 04:09:19 -0800 (PST)
X-Google-Original-Date: Thu, 20 Dec 2018 12:09:08 GMT
Message-Id: <737767b6f4e0367a7797020bd07a6b4357a47413.1545307756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/7] diff: export diffstat interface
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
---
 diff.c | 36 ++++++++++++++----------------------
 diff.h | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index dc9965e836..46a7d8cf29 100644
--- a/diff.c
+++ b/diff.c
@@ -2421,22 +2421,6 @@ static void pprint_rename(struct strbuf *name, const char *a, const char *b)
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
@@ -5922,12 +5906,7 @@ void diff_flush(struct diff_options *options)
 	    dirstat_by_line) {
 		struct diffstat_t diffstat;
 
-		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				diff_flush_stat(p, options, &diffstat);
-		}
+		compute_diffstat(options, &diffstat);
 		if (output_format & DIFF_FORMAT_NUMSTAT)
 			show_numstat(&diffstat, options);
 		if (output_format & DIFF_FORMAT_DIFFSTAT)
@@ -6227,6 +6206,19 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 	return ignored;
 }
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat)
+{
+	int i;
+	struct diff_queue_struct *q = &diff_queued_diff;
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
index ce5e8a8183..7809db3039 100644
--- a/diff.h
+++ b/diff.h
@@ -239,6 +239,22 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
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
@@ -327,6 +343,8 @@ void diff_change(struct diff_options *,
 
 struct diff_filepair *diff_unmerge(struct diff_options *, const char *path);
 
+void compute_diffstat(struct diff_options *options, struct diffstat_t *diffstat);
+
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
-- 
gitgitgadget

