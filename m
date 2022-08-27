Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC19CECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiH0Mot (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiH0Moi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2CA31DFE
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso5728074wmh.5
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=QDn+yI7bY8uprlyldCcjwOx6A/q3dhJY0o3eVQm211g=;
        b=oL6SGJgMzyyg0zWVVEKqXgwxaEh50A6qOwTHDfsuxBRo9K3WK4fLmswZhHqV5nxjMN
         9gEMe3LHYUjFf26IPFKtkSQS5x5EuH/g1qHez0+TO4/HnoqjWZ55HjKjLxMemtXOncQ7
         eQUORJHCg2Fhnhzz2hlBAdVqkZUOALgOTVUuvyXBGX+PjJpgI0bZ2qQawgME1+c5T9vD
         VnMhbqD14x1F5sP+wg8g0b7hVpxgDEPCNO07w5o471OZdtI30EmZhJzeUG1ERcPAKn6N
         74dF6g7EKUxsmGVh/mXNk2kOlxL5WFjCSGYoutky4oP3wJjICb3OdWQFm7cKd6bBsCWV
         GUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=QDn+yI7bY8uprlyldCcjwOx6A/q3dhJY0o3eVQm211g=;
        b=C9hHqIPpDJqMC88hZ6DpL14UkTQ6EHPbhwTbUfD44oS1PM6cs07FLCbPUPwOD9DtlN
         ePV3uabfcg9NY5i/kNLsHCDDVEkV7keNZ/Mb69oDXcpOtIACS/BS3W0TfBMtq/ydig8p
         DB6B0l+JSFpxcJGImbDAZVh9We1c8e4gpiRg/sMeerrFntaNEeo0kz3mBeGXD0v3kfT7
         muI2S/dzutq2LP6rrlbx72EhgjZmCh7oOvAQ+fQ9g6iHsnA/vLNc/Fhn1VMbgrS424fJ
         KAG4Y6PXSRyf63O4MsX8Uw4PFD1ZplfiZr+sPF1Xf7uKSjFFmfDsWs+vsxJz/mNV06qt
         +C9Q==
X-Gm-Message-State: ACgBeo0LTDkhtK5zYEleJmdTC4lVUnwxZEqcouyhW9xbqYu05YKDtWFk
        bvAGqyDFsmiqOslUTnOhW6jCvbzeZDk=
X-Google-Smtp-Source: AA6agR5R/o2KsvgFxqGssv1DE6gQdrYo1w+pQVT35/WivOByYZaLfLkXWaUEmpd/6aHgustBKUPLMA==
X-Received: by 2002:a7b:c318:0:b0:3a6:9c49:2b8c with SMTP id k24-20020a7bc318000000b003a69c492b8cmr2190166wmj.34.1661604274960;
        Sat, 27 Aug 2022 05:44:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05600c3d0700b003a4f1385f0asm2766093wmb.24.2022.08.27.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:34 -0700 (PDT)
Message-Id: <c9dc0281e38bf9bc0bce72de172b5dbadbcbb1f5.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:14 +0000
Subject: [PATCH v5 06/16] bisect--helper: make the order consistently `argc,
 argv`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In C, the natural order is for `argc` to come before `argv` by virtue of
the `main()` function declaring the parameters in precisely that order.

It is confusing & distracting, then, when readers familiar with the C
language read code where that order is switched around.

Let's just change the order and avoid that type of developer friction.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7f4e8e707c1..0d7cc20f9c9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -652,7 +652,7 @@ static enum bisect_error bisect_auto_next(const char *prefix)
 	return bisect_next(prefix);
 }
 
-static enum bisect_error bisect_start(const char **argv, int argc)
+static enum bisect_error bisect_start(int argc, const char **argv)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
@@ -881,13 +881,12 @@ static int bisect_autostart(void)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(empty_strvec, 0);
+		-1 : bisect_start(0, empty_strvec);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(const char **argv,
-				      int argc)
+static enum bisect_error bisect_state(int argc, const char **argv)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -1006,7 +1005,7 @@ static int process_replay_line(struct strbuf *line)
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(argv.v, argv.nr);
+		res = bisect_start(argv.nr, argv.v);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1056,7 +1055,7 @@ static enum bisect_error bisect_replay(const char *filename)
 	return bisect_auto_next(NULL);
 }
 
-static enum bisect_error bisect_skip(const char **argv, int argc)
+static enum bisect_error bisect_skip(int argc, const char **argv)
 {
 	int i;
 	enum bisect_error res;
@@ -1086,13 +1085,13 @@ static enum bisect_error bisect_skip(const char **argv, int argc)
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(argv_state.v, argv_state.nr);
+	res = bisect_state(argv_state.nr, argv_state.v);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(const char **argv, int argc)
+static int bisect_visualize(int argc, const char **argv)
 {
 	struct strvec args = STRVEC_INIT;
 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
@@ -1167,7 +1166,7 @@ static int verify_good(const char **quoted_argv)
 	return rc;
 }
 
-static int bisect_run(const char **argv, int argc)
+static int bisect_run(int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
@@ -1240,7 +1239,7 @@ static int bisect_run(const char **argv, int argc)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(&new_state, 1);
+		res = bisect_state(1, &new_state);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1330,7 +1329,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_START:
 		set_terms("bad", "good");
-		res = bisect_start(argv, argc);
+		res = bisect_start(argc, argv);
 		break;
 	case BISECT_NEXT:
 		if (argc)
@@ -1341,7 +1340,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_STATE:
 		set_terms("bad", "good");
 		get_terms();
-		res = bisect_state(argv, argc);
+		res = bisect_state(argc, argv);
 		break;
 	case BISECT_LOG:
 		if (argc)
@@ -1357,17 +1356,17 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_SKIP:
 		set_terms("bad", "good");
 		get_terms();
-		res = bisect_skip(argv, argc);
+		res = bisect_skip(argc, argv);
 		break;
 	case BISECT_VISUALIZE:
 		get_terms();
-		res = bisect_visualize(argv, argc);
+		res = bisect_visualize(argc, argv);
 		break;
 	case BISECT_RUN:
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
 		get_terms();
-		res = bisect_run(argv, argc);
+		res = bisect_run(argc, argv);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
-- 
gitgitgadget

