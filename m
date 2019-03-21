Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAED20248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCUGxw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfCUGxw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so3698791pfr.4
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pZ5ie1Vyj6gsKDYqQSrhAjKAYhZ8TNUnN1cZxLKcwI=;
        b=SD6iONwUUXCUA4U76ozYOkhC/zBl9cyuxUw7iUuphUGMyQFdvuXqLbJ2IicI6CLiGz
         WxO1lGu3BjpW02kBP54JFppF1digVxY88I1QFRtHx+QkfKVBccmg8Pb2c34o8oeruG/c
         fRI/Cn+kSTo+a0f6WTRhJbd31pQPJ3xNTIJSJ5YIlMmRGTnKtvW/ylVIi/orgVlgwmkj
         PurVt4v87MO7uYYYSqrcAsdZ3tmVtWWmOP7yt3VWlTmBFqVKIKQDdszK999w2etVtzmT
         SiBVkOq+QjPISmRYnDiBL4Alo2hRjw6Z+b7uX6ymZYT3t2VrETUyGKONeHL5aKkSU6js
         4F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pZ5ie1Vyj6gsKDYqQSrhAjKAYhZ8TNUnN1cZxLKcwI=;
        b=ZfX6TidOhbLWbCoAeTJ1W6vp3+p7OUmpKWOlNyDyCdDjj2z/QsdTqTxaP5kLiuE/12
         V0wr1/7fuwnfHq7462iXBjtXlXr/4pNGNDna1HuDBSdyf3rSV5iCOkiiYdfiKELu3pql
         3E2GdvCXg4sbeUMyHLWyMoee+2Cqd80gfxPCzdCr0zgRmQG0HPp2Du/W3EKMkRDEHD6l
         3dDvwONtiasm7QfEVWHBpFB83IMuaNFj6rYW/5++fGQdRaPrTsrYdTrcxKbhWhdwnumt
         m+i5n7LLfv+33CdUiBmbLCl3fn2k3C98RSju9Uv52meIh22VxDKgLXowTCTB3MQdUYtE
         8aDg==
X-Gm-Message-State: APjAAAWGcNzM0y5Z05gSh/Wclfj0iJdqbo32PlQ2Cp9Q/O0FQdLDYoe2
        htXXGUw35Ot/7S1L51mC8Img0zxLOe4=
X-Google-Smtp-Source: APXvYqwtlrmfOtDqimLLjEj1RW4YEmFRvo5KTLQbbIaTlCsKCa81x7xQBEFRSIFWvp7DIWE9USbytw==
X-Received: by 2002:a17:902:848b:: with SMTP id c11mr1879990plo.279.1553151231289;
        Wed, 20 Mar 2019 23:53:51 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id j20sm5027855pfa.158.2019.03.20.23.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:50 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:48 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 05/11] commit: extract cleanup_mode functions to sequencer
Message-ID: <6f20c20939fb946af18f5e0af794305242ca0ef2.1553150827.git.liu.denton@gmail.com>
References: <cover.1552817044.git.liu.denton@gmail.com>
 <cover.1553150827.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1553150827.git.liu.denton@gmail.com>
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

