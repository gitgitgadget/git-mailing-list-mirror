Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA7DC433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355395AbiEUOtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355323AbiEUOt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:28 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A86CAB3
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:20 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n6so5927376wms.0
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PejT8pmtzgdvVrfZLRAxPp/aTwsIB4M0N2QYPwiWxtk=;
        b=Uy2H4SdtVvB6kNjDGif7yNJvT2oykABXOt3H1XbcB8Y2VSjQpb0dA55YOO2CayvILy
         1Cw47k9Y3dvTbLdfdyReYUZKiFk/9Qh9fhYtzFG+0bM73d2hN/nmpLWD6FC9ttr5jLxO
         gH4z85nkjTba4YbLO2F6fjWgvxT+8xUzSXNrpvocfcLVYMf6Cl+xsFJWA9ysIysPKDZY
         Yh41mPS8WpozblZuH0OpzKaDO2Vh0boVBV0mOLMR4kIaUDlKWZjYxz4Bb3I6Tjr6WUOq
         Rc0ZxoVi/4Rt3BgBcM3ENGa/SalID99Jx0B2kRE+61sq9sbJwXmE/anviLkwrdSkLm9r
         Zkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PejT8pmtzgdvVrfZLRAxPp/aTwsIB4M0N2QYPwiWxtk=;
        b=sUkR+VajZYZ+dqn5CCl5MbWYmNMNHAZIbgok4CFFnIHgK+d0gDP+8iR+tqwiNj7LUR
         wtfi96MRCWQu+KH0kmXPKzqJLOSg7c9HMsJG9zyGpoluGu4D0ZFAijVU6bJr+RcHPqz5
         fTVuX5yVtdt5IAlMvHlvmcTUm7kU6P3SK/O10nAukxdzGJPpLIZBiqngoHbZmROcZySJ
         pVEG+yECmpVw4spTxGgkbGzBQlx8p6F+dX5VdAjs71XH8Edw6vClPdjhrgKeRHP58std
         vW8C++m/I5bmzHVmxlCaGlP8G5WKbLv2KS24c3qL+CxizeQljs+xVxnrAFrxpN2Vuj6E
         9zxQ==
X-Gm-Message-State: AOAM531ZrIdJzUKIBXQTedqIGiyVnJ8Ew/l+IDuXNCpj4UVGZHnz2UBf
        xrJB4gKZsfo6Gfd1xwo6vyH0FPW2Ljo=
X-Google-Smtp-Source: ABdhPJyIh1rSAFyNvnWy8k8czJtja4lOiUtp2YAvYLZi/KcBTfLhJW/ulY4W7HzGgXBmSlkEIygwVg==
X-Received: by 2002:a05:600c:4f0f:b0:394:54c1:f5b3 with SMTP id l15-20020a05600c4f0f00b0039454c1f5b3mr13460920wmq.33.1653144558783;
        Sat, 21 May 2022 07:49:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020adfb359000000b0020d0a57af5esm5257529wrd.79.2022.05.21.07.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:18 -0700 (PDT)
Message-Id: <1919237a8197d8ef08abe03bc3cda113f3422761.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:00 +0000
Subject: [PATCH v3 09/15] bisect--helper: move the `BISECT_STATE` case to the
 end
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for replacing the command-mode parsing in
`bisect--helper` with an if/else if/else chain, let's move the one
command that will be implicit (i.e. what will become the final `else`
without any `if`) to the end.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 94293318619..21a3b913ed3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1323,16 +1323,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, argv, argc);
 		break;
-	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		if (!cmdmode &&
-		    (!argc || check_and_set_terms(&terms, argv[0]))) {
-			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
-			usage_msg_opt(msg, git_bisect_helper_usage, options);
-		}
-		res = bisect_state(&terms, argv, argc);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
@@ -1375,6 +1365,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		get_terms(&terms);
 		res = bisect_run(&terms, argv, argc);
 		break;
+	case BISECT_STATE:
+		set_terms(&terms, "bad", "good");
+		get_terms(&terms);
+		if (!cmdmode &&
+		    (!argc || check_and_set_terms(&terms, argv[0]))) {
+			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
+			usage_msg_opt(msg, git_bisect_helper_usage, options);
+		}
+		res = bisect_state(&terms, argv, argc);
+		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
-- 
gitgitgadget

