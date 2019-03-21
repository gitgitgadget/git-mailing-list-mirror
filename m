Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8284920248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfCUNTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:19:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39518 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbfCUNTD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:19:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so4278424pfo.6
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MqKYrmfJKIBg7dTlN4kzRtnrpQ1nhlPmIYXENcjD1KM=;
        b=nToKipi4XkacWm0yjPMeM0nY2CX8cqDXQ1GP5GsDKBMSHjBSK+CMDnEGPFk+8dbHPB
         6qJkm4nc7NoUpdiigxhq5bn1OX8KwPzwpvVtpNIR4ZytyfaqcIbrxUKSVxTeF1VulKsB
         88JFoD9CG5FLq26QlPMKF0Q6WIxEPFeo9gZFHWQ7qq/9jOsYlZlf4eaS6+k986wUTdw2
         GxVyqKIOl6ts8Sy4erZ4U++WqYvWauL72xQ2/F9uTG2aR6CFTI6Hy+xnVes52udDjk1m
         w227p+IbSHWUYAa5arMAYaH4UXivHMqWGPD3C5xjLeJewTEtnUTzJWbQ1fq7g8q+UPN3
         73Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqKYrmfJKIBg7dTlN4kzRtnrpQ1nhlPmIYXENcjD1KM=;
        b=WOxNcLJxT1WGcXFpZoj0/S/kQ+Hvdiri0HyffT5u7k4wNxXppGmH+zlOhJanZ+82dl
         JjiiJZFwjG3SRT6lavTXGjG5emgP1G09fUVun9M2lQBLRoilqdmOK4EMIk024b5o8zqt
         p4AGhI4ps91PSjuskXvr5WB5fsOnlcIg3FLWBdV0FTK0vifhuuzNpnqtz591oTqZjZKx
         5wLXFYcnin3BlAQGpH6UV3K/Wc/UngOj07M3mgQbPYOWIbHJd9983+8rMjX0HLLg8LMk
         bGni5iN/70/VB4fIzuZ0W3vXzhmFeQ9yk2N6Yo5IkQAC58fNJR9kNZOYI0GogWtz5B40
         yLXw==
X-Gm-Message-State: APjAAAWiymSzqF38ptH3d5G8AMsrFINDuQqtBis7MCtlYVmIxHh6rY9h
        lG5RzphZxdaihpbzey2lXZo=
X-Google-Smtp-Source: APXvYqzvHyVNkX59EfIuCkH6f5OWcMEbAfkqSa9NxSCoNM70lZL0fUFOHe4yO071zSF1pyvd5OvjaQ==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr3592058plt.288.1553174342541;
        Thu, 21 Mar 2019 06:19:02 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id z189sm6941640pfb.146.2019.03.21.06.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:19:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:18:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 16/26] switch: stop accepting pathspec
Date:   Thu, 21 Mar 2019 20:16:45 +0700
Message-Id: <20190321131655.15249-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This command is about switching branch (or creating a new one) and
should not accept pathspec. This helps simplify ambiguation
handling. The other two ("git checkout" and "git restore") of
course do accept pathspec as before.
---
 builtin/checkout.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 85fc60f5f2..2c4cab6406 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -54,6 +54,7 @@ struct checkout_opts {
 	int overlay_mode;
 	int no_dwim_new_local_branch;
 	int discard_changes;
+	int accept_pathspec;
 
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
@@ -1176,10 +1177,16 @@ static int parse_branchname_arg(int argc, const char **argv,
 	if (!argc)
 		return 0;
 
+	if (!opts->accept_pathspec) {
+		if (argc > 1)
+			die(_("only one reference expected"));
+		has_dash_dash = 1; /* helps disambiguate */
+	}
+
 	arg = argv[0];
 	dash_dash_pos = -1;
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		if (opts->accept_pathspec && !strcmp(argv[i], "--")) {
 			dash_dash_pos = i;
 			break;
 		}
@@ -1213,11 +1220,12 @@ static int parse_branchname_arg(int argc, const char **argv,
 			recover_with_dwim = 0;
 
 		/*
-		 * Accept "git checkout foo" and "git checkout foo --"
-		 * as candidates for dwim.
+		 * Accept "git checkout foo", "git checkout foo --"
+		 * and "git switch foo" as candidates for dwim.
 		 */
 		if (!(argc == 1 && !has_dash_dash) &&
-		    !(argc == 2 && has_dash_dash))
+		    !(argc == 2 && has_dash_dash) &&
+		    opts->accept_pathspec)
 			recover_with_dwim = 0;
 
 		if (recover_with_dwim) {
@@ -1262,7 +1270,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 */
 		if (argc)
 			verify_non_filename(opts->prefix, arg);
-	} else {
+	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
 		argc--;
@@ -1585,6 +1593,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 1;
 
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
@@ -1614,6 +1623,7 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.no_dwim_new_local_branch = 0;
+	opts.accept_pathspec = 0;
 
 	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-- 
2.21.0.548.gd3c7d92dc2

