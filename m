Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923991F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeJOFzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42633 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:39 -0400
Received: by mail-ed1-f52.google.com with SMTP id b7-v6so16054766edd.9
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jvPoDQxoK1mJ5fFRRqwOqb4z13v0Q2UeFpVXQRhLpA=;
        b=nj20KKn/FKIcIxJPrX5zdDUJCYpvgItIH1UtUSaXRw3jTm9OL2stgJASdQiRN79q1G
         l/hxkqrIH/8IYR3ccrXhXgDu4mcnNSUwVA+hde6r1xzVkcb9sPa5YWT3XIZ1zfVXthwe
         eFwBXsUTZ+cJmLjuBd0HMKPsbjOyD9bYQSwfVrAxyFnblUaLp12eASkDTC19uqxZqYeg
         eYabw0KA3ZQR6wcYh0mAOlsif0cqOAGBCyi0f0eQJNdBhRcGGVVTvK/XX6tIoShzY3es
         dj3nM7qdPAjf60yMv8AoG5A720hnCtUUbGavXdyrWdQUIadb27WM68VQx1b7VbDu4n7O
         VM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jvPoDQxoK1mJ5fFRRqwOqb4z13v0Q2UeFpVXQRhLpA=;
        b=hqVYOxtcK9y8rcTDD78+YrxRBGlWsQVtBUL4U5TgTEgUexrekuBZohYzgM2Eu19YwU
         uUj+ab+1IORIDQqzT+ANLSnZB4+mGTXIjgrE+m6A6fsLfCAa7fXBfr5aNSEdj6PjflwP
         NBpjuX2VSWavIk99dTd7v0pEj5HEXx7F12QL+UePQQLKDx9dFgWJkxFSW7k8VCNMHpdC
         6HIgQT5ov7qhn4n5jwUDDr4PxXpZooCkNYMNH6tpKQY3wRGpHemKdT4BBpmjwACfRXwR
         0wGNtiaa5aqmjlTwdYQyGEW4bF74Vt/ViSzkvYRI4C4j7yBxDXpK3VuovzZIQtjdRYe8
         JLzw==
X-Gm-Message-State: ABuFfog9j7FZLWIRqWMIYSWOZNWZBN8FFgFaARQuVUWKcX6v7+i6qHK+
        ps9FMvrLK6y8PtobFOPB290GglJY
X-Google-Smtp-Source: ACcGV636pbCYldCANaRYy615fORFMpIuQhptFQJFk1ubTZ4gXu2CCJ1Dtw+m4bMQvPv/AxqLe+K7xQ==
X-Received: by 2002:a50:a4c4:: with SMTP id x4-v6mr21343831edb.210.1539555192265;
        Sun, 14 Oct 2018 15:13:12 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:11 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 03/21] stash: improve option parsing test coverage
Date:   Mon, 15 Oct 2018 01:11:09 +0300
Message-Id: <d48b36de7adca9f4e498a88a9909ab1dc2a3e7c5.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
index 1f871d3cca..af7586d43d 100755
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
2.19.0.rc0.23.g10a62394e7

