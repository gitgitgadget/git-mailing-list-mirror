Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D151F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439018AbeKWJr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438981AbeKWJr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so10252590wmc.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pilT/NU1GdURabZb9gUW0Wr4+xXmntPeWH+1+87L8Y=;
        b=rdYRRr9ymbryOgM5teZoGloQpqUgAzobCUMN9ZTAIDDqUFUZNtz+t1LOufVrFusEUN
         0FnfWaU9fcism0fXOEb9P0R+CeizF8RzjInTC3XYalu5wLK1iz+S6ee0lJxGtCb/rcMr
         2qVATbx04dKrMTzNgL3xlqwsaWcevtxD3lGAiw2kj7AYFZK4a8te8PSuixSdixoespVj
         kQ/ae06oicuzF//rcavs4mzsgZvcXUOBwkljHLvEJuIrODQ2Hq8JNMYgQTm7fJPOjJfz
         UmqzkcmHlkyE0tn8D2bmtHX56JlzDH5miF8x/Y/OXwjCP0rt+ZgVlKHBAXc6JW/lKMxb
         XqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pilT/NU1GdURabZb9gUW0Wr4+xXmntPeWH+1+87L8Y=;
        b=iLHu2U08PsFkQpbbhvwge493jQAbiHJb52cqDnOz4olI0Amqb2ZPjBXs521V/h35lc
         b1BqcBzDAzTeWeUs0NN3fZw8xfvk3YouIE1NrogPqaZCkT0lAm3DBN8CKRNzdFG49ElI
         Q5bTH0ezm5xSrNNO6netkBhJtLWoEkSheuszlDuKhJiuuv/WMo0DfJtHTR+PrxSd+Mgp
         RhF7p1Kl0W4YVrZCnUjH2Sri4EKacz1dOzIHszruZsjG80/i2aFH7XQUhbvdP5QLrql+
         6G+wXYh/8UMC4wMlE/c541O6RJtx012J+VONajuytS1HWQcmiSUffekF6aYGzrozlB2l
         3eLg==
X-Gm-Message-State: AGRZ1gJ+a2gUDBXYElEd1nxxwvDPcodhgAQqy4dOTMIHYqqq7/Qkx59U
        67TlBhysyRkkytFY41yGx9FZXA/6
X-Google-Smtp-Source: AJdET5e9cii04jkW+tsVXBCLOxobrP5enhKAuUjcNk/Zavc/5WPJkLtLpl27spqsXSt/mmrC7mWcUQ==
X-Received: by 2002:a1c:45:: with SMTP id 66-v6mr10901013wma.89.1542927975446;
        Thu, 22 Nov 2018 15:06:15 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:14 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 04/22] stash: improve option parsing test coverage
Date:   Fri, 23 Nov 2018 01:05:24 +0200
Message-Id: <b150a3abbfff1bcfebc272d2bea2f9ab947f68ed.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index cd216655b9..4f8aa56021 100755
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
2.19.1.878.g0482332a22

