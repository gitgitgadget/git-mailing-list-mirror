Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1804C1F42D
	for <e@80x24.org>; Sat, 26 May 2018 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeEZN4I (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 09:56:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34994 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754492AbeEZNzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 09:55:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id o78-v6so21466330wmg.0
        for <git@vger.kernel.org>; Sat, 26 May 2018 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMk6+sQjDquX4/QALX5qSbipHn7FMnyjjGNmdqky4Ro=;
        b=ejDRe+I7Je81GdqTCbioeu/N+YpXTraAvXdvS3BOhWEtFcN21qBCkbhMvO2G1SRdnr
         EBE4mlx/e5uNrPO+gj63VkuNCZI2c9Wl7BDymnVACzoy/hVH0I4FNyQrCZn6ykn/cZOm
         Be4MYytomVjWD70msVxNi+NzyehAJ7ijQ5F4XPWJ0Y+OH2InsKxxJV2a04lCnbGukuM0
         8DCWhz9gEfrwmdsRV1k1ckS9ITKwYe7WvmCCWiTn+XUf7ktDuOqi/3+vRa42mPYiTgmP
         IK+gWCteGEXazlbys1cJYYagMjmYZiAJzl3Ii9SixZvo/Ptazrldw/B/e32cVFA2oNOY
         nBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMk6+sQjDquX4/QALX5qSbipHn7FMnyjjGNmdqky4Ro=;
        b=E3ytr7isvQcU+IN6V0Y1heosf0himCgZQJ5G5kUaLPRfV+FE8r1QDwgp9Qn1zRw5oA
         WMen3oaxL1bpIRY2TjQDed/woYkJl0NvHkXSvKixwPq86CfTrqbrGCpMvST3O5JvYjOe
         j4/KrvLP7iS+xbGS/mM9wg/pK5Vt5hP+ZAVAquz0KNMTPdP4aH2sj+498sZ/DRc/xmnu
         svXP5x8g550k0PBj0c/2YM98WI8Yf95xFMvhag4kUr3spEEWJFe0q7rQFtwy6r/ezed7
         euCE14EnqYDSpgKmjAeM7oYrhZzR5awqmZsyfZJ5/K4EtJQBEcZlLxMV4sMtwvbSmKGL
         gTdg==
X-Gm-Message-State: ALKqPwenrI+uS3rK+HdGWdyqJlGqcpqm18tmcyKepthv3pmubB8Xg1Ua
        HDP5VKwnzBTriWGFsagGzFI=
X-Google-Smtp-Source: ADUXVKJ9O42wvvi70JjSvpn9tExzcZzwvfkwTD2JFRT3l0/AMJAK3TkTsthfYbtfgcB9yVsZOOQlRQ==
X-Received: by 2002:a2e:934f:: with SMTP id m15-v6mr4197777ljh.39.1527342945360;
        Sat, 26 May 2018 06:55:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z4-v6sm4941431lji.14.2018.05.26.06.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 06:55:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 06/11] advice: keep config name in camelCase in advice_config[]
Date:   Sat, 26 May 2018 15:55:26 +0200
Message-Id: <20180526135531.4516-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180526135531.4516-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
 <20180526135531.4516-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For parsing, we don't really need this because the main config parser
will lowercase everything so we can do exact matching. But this array
now is also used for printing in `git help --config`. Keep camelCase
so we have a nice printout.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 advice.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/advice.c b/advice.c
index cf6c673ed7..2aca11f45e 100644
--- a/advice.c
+++ b/advice.c
@@ -54,28 +54,28 @@ static struct {
 	const char *name;
 	int *preference;
 } advice_config[] = {
-	{ "pushupdaterejected", &advice_push_update_rejected },
-	{ "pushnonffcurrent", &advice_push_non_ff_current },
-	{ "pushnonffmatching", &advice_push_non_ff_matching },
-	{ "pushalreadyexists", &advice_push_already_exists },
-	{ "pushfetchfirst", &advice_push_fetch_first },
-	{ "pushneedsforce", &advice_push_needs_force },
-	{ "statushints", &advice_status_hints },
-	{ "statusuoption", &advice_status_u_option },
-	{ "commitbeforemerge", &advice_commit_before_merge },
-	{ "resolveconflict", &advice_resolve_conflict },
-	{ "implicitidentity", &advice_implicit_identity },
-	{ "detachedhead", &advice_detached_head },
-	{ "setupstreamfailure", &advice_set_upstream_failure },
-	{ "objectnamewarning", &advice_object_name_warning },
-	{ "rmhints", &advice_rm_hints },
-	{ "addembeddedrepo", &advice_add_embedded_repo },
-	{ "ignoredhook", &advice_ignored_hook },
-	{ "waitingforeditor", &advice_waiting_for_editor },
-	{ "graftfiledeprecated", &advice_graft_file_deprecated },
+	{ "pushUpdateRejected", &advice_push_update_rejected },
+	{ "pushNonFFCurrent", &advice_push_non_ff_current },
+	{ "pushNonFFMatching", &advice_push_non_ff_matching },
+	{ "pushAlreadyExists", &advice_push_already_exists },
+	{ "pushFetchFirst", &advice_push_fetch_first },
+	{ "pushNeedsForce", &advice_push_needs_force },
+	{ "statusHints", &advice_status_hints },
+	{ "statusUoption", &advice_status_u_option },
+	{ "commitBeforeMerge", &advice_commit_before_merge },
+	{ "resolveConflict", &advice_resolve_conflict },
+	{ "implicitIdentity", &advice_implicit_identity },
+	{ "detachedHead", &advice_detached_head },
+	{ "setupStreamFailure", &advice_set_upstream_failure },
+	{ "objectNameWarning", &advice_object_name_warning },
+	{ "rmHints", &advice_rm_hints },
+	{ "addEmbeddedRepo", &advice_add_embedded_repo },
+	{ "ignoredHook", &advice_ignored_hook },
+	{ "waitingForEditor", &advice_waiting_for_editor },
+	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 
 	/* make this an alias for backward compatibility */
-	{ "pushnonfastforward", &advice_push_update_rejected }
+	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
 void advise(const char *advice, ...)
@@ -123,7 +123,7 @@ int git_default_advice_config(const char *var, const char *value)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcmp(k, advice_config[i].name))
+		if (strcasecmp(k, advice_config[i].name))
 			continue;
 		*advice_config[i].preference = git_config_bool(var, value);
 		return 0;
-- 
2.17.0.705.g3525833791

