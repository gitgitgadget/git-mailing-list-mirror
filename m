Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F8C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiBVQbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiBVQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:31:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BEB167F85
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d28so6665252wra.4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2K0LnlFGfZitZBAVYFpb/JmqnEkv2TKRGX5K7BxiKu4=;
        b=XLHdQ+lyFb4oCWHJwHOxSpUdG8t8pr2PJ5JXmYsdj4aT835iwTlFnkuXINzO0uHUoc
         fkWUxCnpEV0yHHAr6FhMkaCY8H6tx4QLjWAg98+CI1prvUhAiA7AhxKHJvnXmLyWOFgg
         SEuQkG5Esfj0V59a7zcUBedgJNcjNhr9J7Og1HXUzgytkmJgfGfa5D/yxN5ExvnfDmAw
         faOQ/tR4TFVrvm4bXZKoYwpGP8OnKKSe9oobjX4hdWFDR+0VMKB2bq66OZ7V69/aHbdu
         H4wsM4C8tPPmgopy0kO7LF6nZRaiGbsVZUkVe5HJ50wa2muutEPnb0+qFeOQnq0RDQgg
         YX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2K0LnlFGfZitZBAVYFpb/JmqnEkv2TKRGX5K7BxiKu4=;
        b=JvuHK2dxOySCmHI1aKh3WgMx55fENCVy/+NiBQEChGrd6CojbA0s9lvlE9KJsls4Gu
         r1nnxRC0uTFiALywHEvOXeD0FExKKu3cshO3Vs3e2Azyc+SFA/l4gXqfl8CtzRVnmVxT
         Gs369yFZ/RN+FUhvzLa8QLHRII8ON2UB4J7DiV4evDMXmd0fXxqNmia/2lUeLfVRAu9A
         vx6aw1zqyKhe+1qHSUn5BqY3JFrxhGs8Vv9XkPV7U0MFk+SWrLUhLY/ms7Y/W9Z2dEGS
         aaCRkv64vUqoNwk8N4QTFrgexhyxVSZj5Yq8MYs4LGv2zNvB+xnGxqDUIUYDAwoJWE2u
         5nIg==
X-Gm-Message-State: AOAM532Sdrce4Sa6++Em4/tnN7XXPhujFE7paNvCtn3lueaetiCePPHz
        skDXdVxUeTLI/NAk9gAUQn1gqLVLIb4=
X-Google-Smtp-Source: ABdhPJzzInjHra0+7YdMND5Xh8ie42+SG52R/6Wym1cEtohtiVPqlcUvV+hr/gWmJswXuyogbXQ89Q==
X-Received: by 2002:adf:e685:0:b0:1ea:8b11:d7a3 with SMTP id r5-20020adfe685000000b001ea8b11d7a3mr3332035wrm.545.1645547432074;
        Tue, 22 Feb 2022 08:30:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm25967477wri.33.2022.02.22.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:31 -0800 (PST)
Message-Id: <e8904db81c56e33f3f77b5040fff6b3ab7f2ec27.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:18 +0000
Subject: [PATCH v2 09/14] bisect--helper: move the `BISECT_STATE` case to the
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
index 39b3cd606f2..ba047ee0fc8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1215,16 +1215,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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
@@ -1267,6 +1257,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
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

