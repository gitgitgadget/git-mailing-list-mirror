Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AE5A1F406
	for <e@80x24.org>; Thu, 10 May 2018 14:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965626AbeEJOT6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:58 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45500 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965524AbeEJOTi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id q2-v6so3199643lfc.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xUPQ3R4VK7XnVerlJ7V+crOGP39HiiDAbXJYmbmH4w=;
        b=ofBbSIMUkJ8Kecm+i32VKT2vb6wfVIJCU6rI2TOOd1suEzq4pTXhzBnOWdWff1so+y
         RLW+3Ngy6q0yB+HMxjsy0iAf/AEXqDooBRp2qDJGruAsnYdkJIvWl6cBUSHK8mtygL29
         mlCAQ5Ll42U6ltJolx5jZzTxaobOA0tHC3QRaBINW6K1uuN6CIdcOY3z9lvfMmesXkCO
         +FaZrVlJ8j+xWxqv2p30Tisx49V2T96mJ9xtISYJ+6guDsd9xfkLCZIt3x0w3EhwGNp8
         8cxZQMK0l1GyRoFsz0CuejFij3um8yezOgle4aLgUeH4saDjEJfqeeeVpor7IHEAUFtq
         EmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xUPQ3R4VK7XnVerlJ7V+crOGP39HiiDAbXJYmbmH4w=;
        b=Jr3txJmPI3JEunFypQ6db/MTefLQhPoLSX9iRtkvjNJ/U8eNH5KVRFJ55LlBcR1bDq
         9dWX1tgCiXXjW8CSAOAhC11/q3pbqpZl59E5z68fSD5anppaNIQaHrW23cbfywW5DakJ
         37FydtcFZXEeqptkmmk1kzjGtPTRB3uvrML7XlIHhs5lbt7CD75JVzcXwnqOdmcCW1Iz
         JTnItbs+9AHgCmbqA83ibO3s4MBIQnJmPC38JEMlWrDTNbRbreo/Jh5DR5i8ZLATX0+l
         SEt2dgLf4pcPUJXdcmCUYFywII7eUlUnredoQsTYkdFfz6macHO4N5Ru3SSLZJkeNp9s
         Sn2A==
X-Gm-Message-State: ALKqPwePkqRy9kLO9pAwLyVQHPBJgZ+oyLGFZmcMi2BrPvJLIKEjG2WA
        nUP+TSrg9QEdTsuw8CHbdN3OyA==
X-Google-Smtp-Source: AB8JxZp4gm7DU+fITdsNw4UJx4aBmkZYIijxr+Z2hxR/aS4MrJ30Z+AF9xgCtlFMldGgpFqP4EphVQ==
X-Received: by 2002:a2e:6808:: with SMTP id c8-v6mr1297759lja.109.1525961976824;
        Thu, 10 May 2018 07:19:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 5/9] advice: keep config name in camelCase in advice_config[]
Date:   Thu, 10 May 2018 16:19:23 +0200
Message-Id: <20180510141927.23590-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
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
 advice.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/advice.c b/advice.c
index b211ebc588..d8ea93637a 100644
--- a/advice.c
+++ b/advice.c
@@ -25,27 +25,27 @@ static struct {
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
 
 	/* make this an alias for backward compatibility */
-	{ "pushnonfastforward", &advice_push_update_rejected }
+	{ "pushNonFastForward", &advice_push_update_rejected }
 };
 
 void advise(const char *advice, ...)
@@ -76,7 +76,7 @@ int git_default_advice_config(const char *var, const char *value)
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcmp(k, advice_config[i].name))
+		if (strcasecmp(k, advice_config[i].name))
 			continue;
 		*advice_config[i].preference = git_config_bool(var, value);
 		return 0;
-- 
2.17.0.705.g3525833791

