Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1216620248
	for <e@80x24.org>; Sun, 17 Mar 2019 10:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfCQKQJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 06:16:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQKQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 06:16:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id i7so6170856pgq.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 03:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pZ5ie1Vyj6gsKDYqQSrhAjKAYhZ8TNUnN1cZxLKcwI=;
        b=rCJcdkM2F38TPP51OfsPQBRwa89c1J9TgB+rjZjXYE+ogzzxnoiCVbmFpOSkB1u8PR
         r+GX740ek/D5OtvMk8BUnrjSsFRnLpLyRFRx4vRP4472Fsktu0spQXn/VgIeSQZAz4I+
         K6V9sNwFv3rhZ+kzkRjQ7latoBS9Yptob2Sh7q9a0XW1+6sYRtTUZZE6eAd3H1Druzlf
         y1rF/WKKGrZaHtmNUdHc3YGCdOeO4eiibYw9kgr2v7+REye1iQoTHMm9qT+8EgUCeF6K
         9MKXE9z8wMFdDIDMYTXa6Ffz6KsBfBxTj64SS6hgxMY+lo5Rcu8proEKQYxFtQM0xSMk
         sYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pZ5ie1Vyj6gsKDYqQSrhAjKAYhZ8TNUnN1cZxLKcwI=;
        b=JJNcK7jZ88HNaJbuYTmlbTCQd7MbN+igGJ6bnNmBqxnAOwqfWF8zvpkWGri8cW6Hdo
         SF3C13QVONaq6etniVo6FUNA+ME4O40GS2Jxsx5HhgeaTWJ93f68TMWskD5dt+UCAFwQ
         LI60LHJksZg7pkmpn3ycjqFB20hoh6CuTkxVTuzMSqkoy1DPO8dxje3b+KMYr8gEd7tY
         O2hNi1E5+B6ib+iXOuXBMebKg9BlkAGMY7pm4iwbtpFvpHJhR7J0apHq5ldvfyIhSRYF
         E45SuHzVF5Ybm1Y3ooAtLLbyVKnt/qVt0yr3uuzsdVSKx0OR2fATqZEgrYMMhcJgliqG
         t/ow==
X-Gm-Message-State: APjAAAWcjXcbDGmrrCKirKZ2JS5mKPMRC3cz2ZDcsRvylfNVCsLqDThL
        gPQgrS30JyYENVmGE8b1o6N23VwV
X-Google-Smtp-Source: APXvYqy0w/B74LnvBXwrn4KFNNzB0j7I1MTdYBfZkyBOI28o0Ew/FXx5EUrPzKUH8i3WlygFA0W3Zg==
X-Received: by 2002:a63:7c07:: with SMTP id x7mr12516431pgc.284.1552817767603;
        Sun, 17 Mar 2019 03:16:07 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id m24sm8399933pgv.1.2019.03.17.03.16.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 03:16:06 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:16:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v8 05/11] commit: extract cleanup_mode functions to sequencer
Message-ID: <d2e4db44426dbe3980dbe2cbc9afa0b724818e2b.1552817044.git.liu.denton@gmail.com>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 25 ++-----------------------
 sequencer.c      | 29 +++++++++++++++++++++++++++++
 sequencer.h      |  6 ++++++
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index f17537474a..0df15e4851 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1172,24 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_ALL :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	/*
-	 * Please update _git_commit() in git-completion.bash when you
-	 * add new options.
-	 */
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
 
@@ -1626,11 +1609,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
 
-	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	cleanup_message(&sb, cleanup_mode, verbose);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/sequencer.c b/sequencer.c
index 95dda23eee..224c823b43 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -511,6 +511,25 @@ static int fast_forward_to(struct repository *r,
 	return 0;
 }
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor)
+{
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		return COMMIT_MSG_CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		return COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		return COMMIT_MSG_CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "scissors"))
+		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+}
+
 void append_conflicts_hint(struct index_state *istate,
 			   struct strbuf *msgbuf)
 {
@@ -1013,6 +1032,16 @@ static int rest_is_empty(const struct strbuf *sb, int start)
 	return 1;
 }
 
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose)
+{
+	if (verbose || /* Truncate the message just before the diff, if any. */
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+}
+
 /*
  * Find out if the message in the strbuf contains only whitespace and
  * Signed-off-by lines.
diff --git a/sequencer.h b/sequencer.h
index 4d505b3590..eb9bd97ef3 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -116,6 +116,12 @@ int rearrange_squash(struct repository *r);
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor);
+
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
+
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
-- 
2.21.0.512.g57bf1b23e1

