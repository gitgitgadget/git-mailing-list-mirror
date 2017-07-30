Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA3C2089D
	for <e@80x24.org>; Sun, 30 Jul 2017 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdG3LNN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 07:13:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36085 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdG3LNN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 07:13:13 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so27905224pgy.3
        for <git@vger.kernel.org>; Sun, 30 Jul 2017 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpgPhwGroWntewoWQgOp9uYmSGHgkFy0A+2TFcwmvw4=;
        b=PrvVzrpTDdBZznRl9U7ujcd6YXdDDsjykNvHrF/zHOLZa/YaBBeZb59FBwwzHlzUcA
         vL/SPA7JWMyfU+g2yS87UQAM6LkZZmQ9bBms9JDRuKD2MZ6AVlksz8NPztNprzngWWQj
         Jm+DzcPR+UpchTYJUiH0/RAix+cqdLt1eTs+aYmqiil5U81PPHks9IR9AtqJOyWRuYqs
         iWWfgrNd5uuu89u1pIsRtuOvPZMgFDQUtfnQXTVDsVldEaqpaDE3l479hH3O2qVpGd6j
         N0/A0Wv+Hg2mi2xm7L2C0dBea/r9q53z36p6ktIFlxt9/bIywgx9OzvGlh6Y041gZ1As
         OgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpgPhwGroWntewoWQgOp9uYmSGHgkFy0A+2TFcwmvw4=;
        b=I6B+D+a0sKDhuDcy8kzf3EyjL5NUH004VYU1hRglTNFHtVOFmaXrYlr3jJRyEmVlE9
         n+NnEFerTT6uX7A1VJgmHSMk/1EA4ri4/cbYAFakWWlenZMKlrKGbDSSkQcQjGpGC0cp
         IRG8l1AqVMf83f3MgYesDnS9n0h1YxiF0YuKMo9LTvCDBpTL7z4tTWQp7JIcOK/NJ2s4
         oq/5gRbfkMprGEAPu4MawtlW+mKP2B0rRTtPidMK9g2SfOdKN775c/72u82j1CUzE3Ay
         oOk28+U7ipOCgjcwxgxFQPIyPfpu8lqbmvBqoD6JfuX1Ctx4tZ7TobJVXmxko5LVzLsy
         Lsvg==
X-Gm-Message-State: AIVw110NLo2Kpt/ef5PN1oZx+vlCWKgBfjQ7JBZ+RS73kygwvPtZXqgy
        5CC1sCMvnt51Ww==
X-Received: by 10.84.230.134 with SMTP id e6mr14254518plk.2.1501413192582;
        Sun, 30 Jul 2017 04:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72c2:f76:6d01:c56f:1310:5568])
        by smtp.gmail.com with ESMTPSA id i133sm11479242pgc.0.2017.07.30.04.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jul 2017 04:13:12 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH] branch: change the error messages to be more meaningful
Date:   Sun, 30 Jul 2017 16:43:26 +0530
Message-Id: <20170730111326.12139-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
References: <0102015d7f0c9403-16bd1de5-3b6c-4d23-a3fb-75a26c378c62-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error messages shown when the branch command is misused
by supplying it wrong number of parameters wasn't meaningful.
That's because it used the the phrase "too many branches"
assuming all parameters to be "valid" branch names. It's not
always the case as exemplified below,

        $ git branch
          foo
        * master

        $ git branch -m foo foo old
        fatal: too many branches for a rename operation

Change the messages to be more general thus making no assumptions
about the "parameters".

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/branch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..59fedf085 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -707,12 +707,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else if (argc == 2)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
-			die(_("too many branches for a rename operation"));
+			die(_("too many parameters for a rename operation"));
 	} else if (new_upstream) {
 		struct branch *branch = branch_get(argv[0]);
 
 		if (argc > 1)
-			die(_("too many branches to set new upstream"));
+			die(_("too many parameters to set new upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
@@ -735,7 +735,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT;
 
 		if (argc > 1)
-			die(_("too many branches to unset upstream"));
+			die(_("too many parameters to unset upstream"));
 
 		if (!branch) {
 			if (!argc || !strcmp(argv[0], "HEAD"))
-- 
2.14.0.rc1.434.g6eded367a

