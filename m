Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BCBB20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfCEMbc (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45872 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMbc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id v21so5584913pfm.12
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqiQKMgXv9L2XGnc4RsCahJ40oubD87/i8UJ7VmTmo4=;
        b=gJm5sZ+rE5NaMOgvV/9SOtXVfM4IeOK/RLq6Oe6AuoaDCVSPWx5I8+QJQHlEWcw5QQ
         kMrkEFBu3pBk7xlQ1OoRDDNmEjHuaH3C/q+wBIYi8hZQGBppJO8/CZoUSkwp1fno61NQ
         i8M0HluTs793Xgearkp5QVGIkGwQN5gHt1DwcbVQBxdA5LO0BtQHjRm9LBuYjr8N8VvJ
         nchJPaTVPz5phqctLYNm5nY+4SzzdNqTtQWCNwRtuQlBCQxd2IfH3JQdGEl/KwRERvlv
         J6rPknpr184PAMy29syizxrxuVMJyfkAQtWNorLf313nAg6TLmCABzac8MeB8Ptt1W5G
         6Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqiQKMgXv9L2XGnc4RsCahJ40oubD87/i8UJ7VmTmo4=;
        b=Xo3yoZxVWo8FN3NzasY/dj7alki7xKVuASku8xYco/YGeLpOTUZCLRgTbPLsiwralW
         gfyARPDJovA2GhWEhjJdj0AtiURLbX9pPbPJa+PD7RiyU2gZaY618K3wzLSR/erwQ0LV
         0HF83lOJfVQRxI5fqjk8SQBptLW0G1niFoyaNeKYfsbhowudhlxZr5z+2STxP27yq3ql
         FyasRCt9n4KvxhWZqIc/C/RoZlCIKZgUoFgT4kPTrHqZ2Swyg2IE9J1msfzpN9q/n7Gc
         0INSsMSLsk7PJyVqou6mn6agk3/IAQBzB6DPyMXv2ml1dmHt8oCvUIYDDTl2FTfuY0zy
         BNvQ==
X-Gm-Message-State: APjAAAULWpWIlfYNaG2oAQqKFC8o4ZRHBsDjkd1Hhkdd0FhsboUfpXxk
        /fHBYKiPrI56WI2AkbjBS7UUY7qV
X-Google-Smtp-Source: APXvYqxJe/wFm1FqUv+NkUm5WHTtpJ1GPj1Nghcfn5Fm5l6ucMGLlQAKYkxBK8oVUBk+I3fchg+FmA==
X-Received: by 2002:a17:902:aa87:: with SMTP id d7mr969185plr.146.1551789091061;
        Tue, 05 Mar 2019 04:31:31 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id k8sm10812291pgq.37.2019.03.05.04.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/20] diff-parseopt: convert --[no-]follow
Date:   Tue,  5 Mar 2019 19:30:16 +0700
Message-Id: <20190305123026.7266-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 689dc11684..ad813ea418 100644
--- a/diff.c
+++ b/diff.c
@@ -4986,6 +4986,21 @@ static int diff_opt_find_renames(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_follow(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.follow_renames = 0;
+		options->flags.default_follow_renames = 0;
+	} else {
+		options->flags.follow_renames = 1;
+	}
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5172,6 +5187,9 @@ static void prep_parse_options(struct diff_options *options)
 			      0, PARSE_OPT_NONEG),
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
+		OPT_CALLBACK_F(0, "follow", options, NULL,
+			       N_("continue listing the history of a file beyond renames"),
+			       PARSE_OPT_NOARG, diff_opt_follow),
 
 		OPT_GROUP(N_("Diff algorithm options")),
 		OPT_BIT(0, "minimal", &options->xdl_opts,
@@ -5250,12 +5268,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--follow"))
-		options->flags.follow_renames = 1;
-	else if (!strcmp(arg, "--no-follow")) {
-		options->flags.follow_renames = 0;
-		options->flags.default_follow_renames = 0;
-	} else if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
+	if (skip_to_optional_arg_default(arg, "--color", &arg, "always")) {
 		int value = git_config_colorbool(NULL, arg);
 		if (value < 0)
 			return error("option `color' expects \"always\", \"auto\", or \"never\"");
-- 
2.21.0.rc1.337.gdf7f8d0522

