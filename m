Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5C01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 07:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeH2LBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 07:01:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45090 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 07:01:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id p206-v6so1606156ywg.12
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2vpieNiJIFNLAFI7wqfbJlFJqY68REejyTTH2Bw4ukM=;
        b=X0QLRvmlC4gSaaLDYgwwKRDaFdaGiqVE6qyVdokXpcMrAiKFTHGoOY55LBnzkqPWFZ
         4KOon2pwciWRPKIfB1TUtdKnTcUCQKDVyZl/l7Ol0nFoVYT1BSqZXXT1oK8CspUCc7ud
         QwduLltE1dkbn6x12yiGIIkJlMnI0dz7Dxj6vXo+wOwdfKetj9j6iP6vMCSPvThsjvVl
         8z9g97xxqUKY5e9dTMbiHkdKFcO4gWVgeQdC+LqNDZ3x+LsvmjNIf6AfkqmA7BirPNl8
         kEJyXVOuvi+muMMZzdWhwm0lqVqKX0ChveLjHRJ8QHsRejCxkJEgEVFmgBhnNWIOe/xn
         4/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2vpieNiJIFNLAFI7wqfbJlFJqY68REejyTTH2Bw4ukM=;
        b=hUd3sfu09i4B8TRnDL1nmSv2mw2swjEj97fQUchabuYQop8CTcwZ0H9Y83voJ4NgdL
         R+5BPU8otBAg68t1gIWxlJVhqnYdjcU37odJjkN683eDS09Fx1uh8XVB+YBzyAkKoEuh
         SkrM5xLZCCGhTVfYGDqqG5Cc85T9aDUK0XUiB2NZR0mWo48diLhEuZuOXwYO9l5GyO8l
         cIKD4KsOYhty7bC2BIOJTuntH9tyApra2jiFfZVe1DHhMiLiLJ4n1OIKA7ui/YbAd45v
         orW4RUTnu9qEwTQIno6bQghinqypfAwB0TvC75y4XOMqmjLgCT9bEQfULPchd8dUE1Uz
         QsKg==
X-Gm-Message-State: APzg51DdjQqiZjQcfCrpaFseYbQE0OaLcp1T8v/8D4GbfFtd/JaQ8z48
        6ciWNcK+DSjsmO50+Qw5daKCFanR
X-Google-Smtp-Source: ANB0VdYmDmwnjIU3S8KktKRwjapjVKYWcG5RTmltTh5Z2+8Je4bxr1mrAl1W5OvDa87YlzcsngXoNA==
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr2697425ywg.288.1535526381789;
        Wed, 29 Aug 2018 00:06:21 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id n6-v6sm1269794ywe.89.2018.08.29.00.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:06:21 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, corrmage@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] t3401: add another directory rename testcase for rebase and am
Date:   Wed, 29 Aug 2018 00:06:11 -0700
Message-Id: <20180829070613.11793-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.12.g97a29da30a
In-Reply-To: <20180829070613.11793-1-newren@gmail.com>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
 <20180829070613.11793-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to commit 16346883ab ("t3401: add directory rename testcases for
rebase and am", 2018-06-27), add another testcase for directory rename
detection.  This new testcase differs in that it showcases a situation
where no directory rename was performed, but which some backends
incorrectly detect.

As with the other testcase, run this in conjunction with each of the
types of rebases:
  git-rebase--interactive
  git-rebase--am
  git-rebase--merge
and also use the same testcase for
  git am --3way

Reported-by: Nikolay Kasyanov <corrmage@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3401-rebase-and-am-rename.sh | 110 +++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 8f832957fc..a87df9e675 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -5,7 +5,7 @@ test_description='git rebase + directory rename tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-test_expect_success 'setup testcase' '
+test_expect_success 'setup testcase where directory rename should be detected' '
 	test_create_repo dir-rename &&
 	(
 		cd dir-rename &&
@@ -102,4 +102,112 @@ test_expect_failure 'am: directory rename detected' '
 	)
 '
 
+test_expect_success 'setup testcase where directory rename should NOT be detected' '
+	test_create_repo no-dir-rename &&
+	(
+		cd no-dir-rename &&
+
+		mkdir x &&
+		test_seq  1 10 >x/a &&
+		test_seq 11 20 >x/b &&
+		test_seq 21 30 >x/c &&
+		echo original >project_info &&
+		git add x project_info &&
+		git commit -m "Initial" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git checkout A &&
+		echo v2 >project_info &&
+		git add project_info &&
+		git commit -m "Modify project_info" &&
+
+		git checkout B &&
+		mkdir y &&
+		git mv x/c y/c &&
+		echo v1 >project_info &&
+		git add project_info &&
+		git commit -m "Rename x/c to y/c, modify project_info"
+	)
+'
+
+test_expect_success 'rebase --interactive: NO directory rename' '
+	test_when_finished "git -C no-dir-rename rebase --abort" &&
+	(
+		cd no-dir-rename &&
+
+		git checkout B^0 &&
+
+		set_fake_editor &&
+		FAKE_LINES="1" test_must_fail git rebase --interactive A &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+
+		test_path_is_file x/a &&
+		test_path_is_file x/b &&
+		test_path_is_missing x/c
+	)
+'
+
+test_expect_failure 'rebase (am): NO directory rename' '
+	test_when_finished "git -C no-dir-rename rebase --abort" &&
+	(
+		cd no-dir-rename &&
+
+		git checkout B^0 &&
+
+		set_fake_editor &&
+		FAKE_LINES="1" test_must_fail git rebase A &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+
+		test_path_is_file x/a &&
+		test_path_is_file x/b &&
+		test_path_is_missing x/c
+	)
+'
+
+test_expect_success 'rebase --merge: NO directory rename' '
+	test_when_finished "git -C no-dir-rename rebase --abort" &&
+	(
+		cd no-dir-rename &&
+
+		git checkout B^0 &&
+
+		set_fake_editor &&
+		FAKE_LINES="1" test_must_fail git rebase --merge A &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+
+		test_path_is_file x/a &&
+		test_path_is_file x/b &&
+		test_path_is_missing x/c
+	)
+'
+
+test_expect_failure 'am: NO directory rename' '
+	test_when_finished "git -C no-dir-rename am --abort" &&
+	(
+		cd no-dir-rename &&
+
+		git checkout A^0 &&
+
+		git format-patch -1 B &&
+
+		test_must_fail git am --3way 0001*.patch &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+
+		test_path_is_file x/a &&
+		test_path_is_file x/b &&
+		test_path_is_missing x/c
+	)
+'
+
 test_done
-- 
2.18.0.12.g97a29da30a

