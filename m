Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5992E20248
	for <e@80x24.org>; Thu, 21 Mar 2019 06:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfCUGx6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 02:53:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfCUGx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 02:53:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so3596492pgq.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R0f6isHrpFXom1zlVM9c1JtgkdivNl3Iqxc6mzDKoHc=;
        b=hYGccKd0Ltgpd0Cyv1eUskCzthskDOnWyGdROFrcBt5prByxTh9z2sc8gNV6Dr2tO4
         V12LVEy9B0KSnGG6PevbjievrtclB+eHcQU5xns8LL0l5x2AjAHwye9wtC/2vhcP1fzu
         +PGV5BFlsg/GNjt2LZCTpXEnwNP4XIVLs3yTRkhLlyrcKby52/yw0KN6mml17UGRkCxC
         BKB5xsG5LzMWRfyT2FcsJn+3Xia4EBBszzlP8IEjRxNEbLcdKzMc2Hmq58KpxADk4AhS
         3T8e2Li6+uU0hjHxW9DxXgdTa8LPRJLBPTZQ5XfxxHcX3h6RerEtlzUAQjSnm+59KP1m
         8OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R0f6isHrpFXom1zlVM9c1JtgkdivNl3Iqxc6mzDKoHc=;
        b=cFMsdnI6NDZxk42uZBXQANpSZipUgmEcpL+oVhh3fyMqRhumtCAXDpEUNKAWCCJLmG
         AlwozRFwPfTP9qqX6rdenzG1c/jd9mSbomXEStAB+3AMJAI/rbIhwvPL+8NCQX6cnEtk
         cayaz176xm2p/2Y4JLRlZMoPgS0u4BekM/O1+7Bur9rKQB+ypECJsd15UadFh5mViVcX
         YmuxcwCniLw/MyWGg2pvB/spYo/ZXcD2H4dxmeCfnWEQxyXA6tnSIpFvu4HjGWthcAt7
         wf673MfT0VTlAK4N3kSOK5GcGiteg2gFhqp7tcnY0DyJ9stuol1xMWW6+oVKn0BGdlRe
         3vfw==
X-Gm-Message-State: APjAAAVocxXevO9EpnHMgl20zfXv6/tj+fTS+Nfp3ybEbF/7l3ikx2Dw
        sekmx5WAdTHFQKEbf6ycGLvACk84c1I=
X-Google-Smtp-Source: APXvYqxsbIoguTvTPwYbs7F+jq5p5Z9toLc2AHhYBe2sP5R9wkiCpySa4tBXuMAP70+N4CzEVgZD4w==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr2020393plk.282.1553151236833;
        Wed, 20 Mar 2019 23:53:56 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id h11sm4351069pgq.57.2019.03.20.23.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 23:53:56 -0700 (PDT)
Date:   Wed, 20 Mar 2019 23:53:54 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v9 07/11] sequencer.c: remove duplicate code
Message-ID: <492ba73797ac66cc48da2b44cdae2152b41aa481.1553150827.git.liu.denton@gmail.com>
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

Since we implemented get_cleanup_mode, we had some duplicate code in
git_sequencer_config which essentially performed the same operations.
Refactor git_sequencer_config to take advantage of the logic already in
get_cleanup_mode.

Note that we had to introduce a separate argument to get_cleanup_mode
indicating whether to die or not on an invalid value. This is because if
we are parsing a config, we do not want to die but instead, we only want
to warn the user, whereas if we are parsing a command-line option, we
would like to actually die.

Finally, this is almost a no-op refactor but not quite. Previously, in
the case that an invalid value is presented, default_msg_cleanup would
not be set. We change the behaviour so that default_msg_cleanup will now
take on the value as if "default" were provided as the cleanup_arg.
Also, we lowercase some user-facing strings.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c |  2 +-
 sequencer.c      | 22 ++++++++--------------
 sequencer.h      |  2 +-
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8277da8474..ba1e6027ba 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1172,7 +1172,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor, 1);
 
 	handle_untracked_files_arg(s);
 
diff --git a/sequencer.c b/sequencer.c
index 224c823b43..2cbfb848dd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -172,17 +172,7 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		if (status)
 			return status;
 
-		if (!strcmp(s, "verbatim"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_NONE;
-		else if (!strcmp(s, "whitespace"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else if (!strcmp(s, "strip"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_ALL;
-		else if (!strcmp(s, "scissors"))
-			opts->default_msg_cleanup = COMMIT_MSG_CLEANUP_SPACE;
-		else
-			warning(_("invalid commit message cleanup mode '%s'"),
-				  s);
+		opts->default_msg_cleanup = get_cleanup_mode(s, 0, 0);
 
 		free((char *)s);
 		return status;
@@ -512,7 +502,7 @@ static int fast_forward_to(struct repository *r,
 }
 
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor)
+	int use_editor, int die_on_error)
 {
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
@@ -526,8 +516,12 @@ enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
 	else if (!strcmp(cleanup_arg, "scissors"))
 		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
 				    COMMIT_MSG_CLEANUP_SPACE;
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	else if (!die_on_error) {
+		warning(_("invalid cleanup mode %s, falling back to default"), cleanup_arg);
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	} else
+		die(_("invalid cleanup mode %s"), cleanup_arg);
 }
 
 void append_conflicts_hint(struct index_state *istate,
diff --git a/sequencer.h b/sequencer.h
index eb9bd97ef3..e7908f558e 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -117,7 +117,7 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
 void append_conflicts_hint(struct index_state *istate, struct strbuf *msgbuf);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
-	int use_editor);
+	int use_editor, int die_on_error);
 
 void cleanup_message(struct strbuf *msgbuf,
 	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
-- 
2.21.0.512.g57bf1b23e1

