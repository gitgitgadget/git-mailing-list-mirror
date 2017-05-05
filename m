Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8032207B3
	for <e@80x24.org>; Fri,  5 May 2017 20:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755493AbdEEUQe (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 16:16:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33371 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754527AbdEEUQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 16:16:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so3411326wmh.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIRc1jKAdK2WOhSEdxd+XA3wQkNb7RhFTxQuObxBRME=;
        b=n3TPK2373ree5jNJC10PjlFHsli7iZsfX+iFXybQdPjMgoIraJSEUy/2mWKVtnGySz
         ARaMdUI7zPWNCnZAm2hBpOb5717zvdnA1WDxfyD4glJ/kH8mwYQAqf8tkuTKuymqqSQl
         SejVAF8fWYgXkuBLcZ4WlJ0bbmO5EwmOJVh+aMxBIhvBpAybuY8M74LPuwUgg2XqsD4F
         RAX+rDXe6GEEYuX3zEv5leQ49R8wdjMksCG15fwx4sds2/7W99SLT5J4cpTI/V+Pg5Q1
         sVntfm1LnaaozNX9AlXd6L6EH4D+AQEFSbKF9o0NkiOb/BzSL5QB/QJZkJA51vVwG+Ta
         7T/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIRc1jKAdK2WOhSEdxd+XA3wQkNb7RhFTxQuObxBRME=;
        b=eBKHDNInHqu4sA3JN97QoICpXr1U0D4l4WWiVUtCjPyimDFnQl2JXTCn0VHK07fwN/
         /GAUQ4Ts9ZXuGg7MzbnLzcCRzh9KuinUlhe3OLK2NFctwHIVRWKW19bCHIG82TIbb4eh
         4vye/JbpILY12XFiXKypd2O9rAmFoOCv4WQgo6/JBm8vl8tJCvmxYAwYSgPtCQWnRQ1J
         hK2N/FGyziwUH+yL19dM7kuq4JOGDLpDClg/xcPJCU6xEPatp4c/2JdR22zCw4FjS2ha
         HZOH2+X1om3wXHqqnLc2fViZ7BmnaddTQhw3Zmvd6L7hHnnpLH8TOIR0xpobzopfdpV4
         tQUA==
X-Gm-Message-State: AN3rC/5j8yzgP58Wa9TBZAkmj/Qi6a419ubzDpEDHhVTvC9v3mYe46Ki
        UD94nISfZm0dhw==
X-Received: by 10.28.30.135 with SMTP id e129mr5926228wme.127.1494015391740;
        Fri, 05 May 2017 13:16:31 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h80sm2952796wmd.7.2017.05.05.13.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 13:16:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive add
Date:   Fri,  5 May 2017 20:16:21 +0000
Message-Id: <20170505201621.25560-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
References: <1494009820-2090-3-git-send-email-bnmvco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 8:43 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Create a builtin helper for git-add--interactive, which right now is
> only able to reproduce git-add--interactive.perl's status_cmd()
> function, providing a summarized diff numstat to the user.

I'm not a user of add -i and didn't review the main logic in detail,
but I ran this, and aside from two issues this LGTM:

 * You missed a trailing \n in the output, so your formatting is
   different from the current behavior.

 * You should be using the getopt API instead of rolling your own.

Fixes for both below, thanks a lot for hacking on this. As you pointed
out this doesn't help with removing any of the perl code for now, but
after replacing a few more command modes we can start chopping away at
the perl code.

diff --git a/builtin/add-interactive--helper.c b/builtin/add-interactive--helper.c
index 97ca1b38dc..ea0f790bd3 100644
--- a/builtin/add-interactive--helper.c
+++ b/builtin/add-interactive--helper.c
@@ -226,6 +226,7 @@ static void print_modified(void)
 		printf(modified_fmt, index_changes, worktree_changes, f.path);
 		printf("\n");
 	}
+	printf("\n");
 }
 
 static void status_cmd(void)
@@ -233,26 +234,31 @@ static void status_cmd(void)
 	print_modified();
 }
 
-static const char add_interactive_helper_usage[] =
-"git add-interactive--helper <command>";
+static const char * const builtin_add_interactive_helper_usage[] = {
+	N_("git add-interactive--helper <command>"),
+	NULL
+};
 
 int cmd_add_interactive__helper(int argc, const char **argv, const char *prefix)
 {
-	int i, found_opt = 0;
-
-	git_config(git_add_interactive_config, NULL);
+	int opt_status = 0;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	struct option options[] = {
+		OPT_BOOL(0, "status", &opt_status,
+			 N_("print status information with diffstat")),
+		OPT_END()
+	};
 
-		if (!strcmp(arg, "--status")) {
-			status_cmd();
-			found_opt = 1;
-		}
-	}
-
-	if (!found_opt)
-		usage(add_interactive_helper_usage);
+	git_config(git_add_interactive_config, NULL);
+	argc = parse_options(argc, argv, NULL, options,
+			     builtin_add_interactive_helper_usage,
+			     PARSE_OPT_KEEP_ARGV0);
+
+	if (opt_status)
+		status_cmd();
+	else
+		usage_with_options(builtin_add_interactive_helper_usage,
+				   options);
 
 	return 0;
 }
-- 
2.11.0

