Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2B51F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933471AbeFYQms (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:42:48 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51312 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754423AbeFYQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:42:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id w137-v6so4711118wmw.1
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Skoa8iJZjfyRMLkSDXPJMa0PEPnT03CT1cO4QXJXV6g=;
        b=YgHx5aGv6b3xA4VjewQGB07Umu0mHBovAmlxvZrPwOdXgo/5Zc+1nZ9ho4m1ksvQpY
         gdz5vlyUdCPc0qLmNQj850yob27Wl0xbehOzaX+wbzTS2fH88GKXaxV7jzSH8ed8G46e
         FbcEmmpe8E1D1EsOcBLyv9tm+80qetjOeZvRBjkzfyFFnrrhAJDFTg9nKqfBnaZPJQA3
         idYNKhHfnXsFd6EhUckhrSCsY7NUXntYVVhF10K4wXzBAXWs9zr0HYs8M4C4DPiLsBLm
         0JB3Phq1lCAUyvlT+t6BOeIxBSHgtwhQ4LFkGOOsJ1qLR6Z+Fhf5guEDKGsoeYKUE5nq
         P8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Skoa8iJZjfyRMLkSDXPJMa0PEPnT03CT1cO4QXJXV6g=;
        b=o7mc0FG35fqVNekvNYju44dSULmIx2jdsFPOrfW0eaRMsUeRJT6DgAHMQoOLstpcUw
         TNtyQbVk7cvX+SqnqJbXzhenfyr0fjY6/pRLLph+x0IuQyGjkYyUSp7QanEqOBiytSWa
         5wEI66H2ygtCOP4U4Uzdxf279vswyYnPhqz8lY83QGnwXlO1pz+O/chJ1DaLm627lgPM
         yi3QDyKipFpBD8ybLf4+jHkRmFTJA10L3UhbDUjlCaiQBsEc5c6Gkf0wJzdrRqaDswF/
         bKPEYYb4x5ea/DwEQ5NPlywvG7twhhkIYZj/mCS0KEVhAVKmGHsU0veEFSxdqHzu94Tg
         FGIg==
X-Gm-Message-State: APt69E359nLHt9LeWyv+K7jEIUFamuXjcHpR2mL939vjG1e/+VUlqTa7
        24q+ZetZbkfqQyGSZuaHr1NL9yeZ
X-Google-Smtp-Source: AAOMgpc9m+YOUlFj6mFCLnW5f1OG8Oq5WYrCyldiUgJcm6ivLPGlLnzHGqhWaDv2w3gd5IrJUbxnkg==
X-Received: by 2002:a1c:150d:: with SMTP id 13-v6mr1700573wmv.100.1529944964822;
        Mon, 25 Jun 2018 09:42:44 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-160-71.residential.rdsnet.ro. [5.13.160.71])
        by smtp.gmail.com with ESMTPSA id d14-v6sm2912904wro.24.2018.06.25.09.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 09:42:43 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, joel@teichroeb.net, gitster@pobox.com
Subject: [PATCH v6 2/4] stash: improve option parsing test coverage
Date:   Mon, 25 Jun 2018 19:42:25 +0300
Message-Id: <16a4ed177d885ab0db270201ba52f07ed2234ea1.1529943789.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.13.g506fc12fb
In-Reply-To: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many parameters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 1f871d3cc..af7586d43 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'giving too many ref arguments does not modify files' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	echo foo >file2 &&
+	git stash &&
+	echo bar >file2 &&
+	git stash &&
+	test-tool chmtime =123456789 file2 &&
+	for type in apply pop "branch stash-branch"
+	do
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many revisions" err &&
+		test 123456789 = $(test-tool chmtime -g file2) || return 1
+	done
+'
+
+test_expect_success 'drop: too many arguments errors out (does nothing)' '
+	git stash list >expect &&
+	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
+	test_i18ngrep "Too many revisions" err &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show: too many arguments errors out (does nothing)' '
+	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out &&
+	test_i18ngrep "Too many revisions" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'stash create - no changes' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -479,6 +509,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.18.0.rc2.13.g506fc12fb

