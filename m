Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32FEE211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 21:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeK3JGS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 04:06:18 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33722 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbeK3JGR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 04:06:17 -0500
Received: by mail-lf1-f68.google.com with SMTP id i26so2648547lfc.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/KITVrHJGsxyknSiFnTsvq2COS/+EAvSmz7fGusPevE=;
        b=mUNQsqZBsygFxL5MunnyRXOJhBWLsNzKWrb5DMHGlNrRPVYQ++OPWZiWzElygwFcSw
         x53vsdgfJC7aULXH7bAefI8Z+YRngg8OJZ6AtmJclBlb9QKwLwHUXmpntyMQFbNYICJB
         mOLiEwTVc0rOVDbAAOk9ypc7V5J/kOz3c8foBXOd8f3rIxx4DcRJwZPz/YllVDXELTeF
         GgLye3bSTVZSLyaqpktN2iUWIcGKdjLfwFUytajiHwqVDg2nsCiOsH2pELgp0+2kpnxW
         iS1MweR0Kz3sWC8BdIo18X3YdY52uXgxRQwO1rxc7tNj9Ng+YIgGSmBcjMQvV/hHN6LL
         qDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/KITVrHJGsxyknSiFnTsvq2COS/+EAvSmz7fGusPevE=;
        b=o7F1cIw6O0nj78QimDrhWzL11uW927KJqQSROWLfCgj6P4QQLLh4jsO5iRCjOXn0AC
         /drDXA8s+kuSeyVX7MCzedNqzsDGDcbNQPemsxJS0Ieeyv68DrrzOJlkyMFx02Y/fKGu
         W45lXm4PEE6RWIhuTebjkBJg5S+/iDUxwiGtPwkaFUM0ojmd5wxqmTToGWfJELd0GwDH
         IW1TZyI2tMIUY5mwjyl8kkCblKa+iu+UXI917B9MFLQ002CjeVhg0NrdIB/p6QrUaFxl
         OsEs5DgrrfdgXMuqPBh2r1WWAzPrjgGtxHMn6hlnRk9igLIKemiqRdhHzaCCin9kwef/
         y9MQ==
X-Gm-Message-State: AA+aEWb6Qgkl50w6jNPHx6uImUi3p83AsLCbeH76V0/TJY86OlWBvqH7
        VrUhIfwvBXBdgF1BozWPAHY=
X-Google-Smtp-Source: AFSGD/VTUMisgDaX2RiIIlFbQlNzDeFo23CU7G2fJjBFJVyUXCcVt5kCjHRJym7gwCK/3USJ4ag/fg==
X-Received: by 2002:a19:f813:: with SMTP id a19mr2046677lff.67.1543528761770;
        Thu, 29 Nov 2018 13:59:21 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id o17sm489703lff.77.2018.11.29.13.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:59:20 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        sbeller@google.com, t.gummerer@gmail.com, sxenos@google.com
Subject: [PATCH v3 08/14] switch-branch: better names for -b and -B
Date:   Thu, 29 Nov 2018 22:58:43 +0100
Message-Id: <20181129215850.7278-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.380.g3eb999425c.dirty
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
References: <20181127165211.24763-1-pclouds@gmail.com>
 <20181129215850.7278-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The shortcut of these options do not make much sense when used with
switch-branch. And their descriptions are also tied to checkout
out. Move -b/-B to cmd_checkout() and new -c/-C with the same
functionality in cmd_switch_branch()

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7dc0f4d3f3..ceb635de36 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1268,14 +1268,10 @@ static struct option *add_common_options(struct checkout_opts *opts,
 	return newopts;
 }
 
-static struct option *add_switch_branch_options(struct checkout_opts *opts,
-						struct option *prevopts)
+static struct option *add_common_switch_branch_options(
+	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
-			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
-			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
@@ -1461,15 +1457,21 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
-	struct option *options = NULL;
+	struct option *options;
+	struct option checkout_options[] = {
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+			   N_("create and checkout a new branch")),
+		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and checkout a branch")),
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
@@ -1482,14 +1484,20 @@ int cmd_switch_branch(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
 	struct option *options = NULL;
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a new branch")),
+	};
 	int ret;
 
 	memset(&opts, 0, sizeof(opts));
 	opts.dwim_new_local_branch = 1;
 
-	options = parse_options_dup(options);
+	options = parse_options_dup(switch_options);
 	options = add_common_options(&opts, options);
-	options = add_switch_branch_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
 
 	ret = checkout_main(argc, argv, prefix, &opts,
 			    options, switch_branch_usage);
-- 
2.20.0.rc1.380.g3eb999425c.dirty

