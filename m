Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59921F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHaBpy (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:54 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41980 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBpx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:53 -0400
Received: by mail-wr1-f44.google.com with SMTP id z96-v6so9359631wrb.8
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+dnvFpwX9cZ5Fbh6N8u9y6Bx8r2tDvYMsJ7CGepWVq8=;
        b=XNZxV+3WitlcjoHXcXYItIBR5L3d109YM5giH9T0GAPzd+RXM+ColXLhYZcAjPanpO
         xZ45qlBDs/SJauHzMq18/M3JQuh4ozsFlPbAng7/QgjqYd3cqGLohlgVB0cEH7qMZ6vh
         ZT0WJIcRe4vcs3GD3nZZDxUK0olXWOkTKAK8BnTBnG5emfDtx+Gg3x6ajpQ+VN6dsShr
         fgkquPSBZt3rjVW8aRbol/uW3/vdAdUKEBtBkn0bcYY6NLqpHy5KGQ4bQkPOOW9wJu3m
         3TmD/8zXBoLhGIoyN5mQ6KVl4gwgp1MOr4WWycrYBf4lmdL8ApHsxsqlN9pnl6e++Dmi
         KZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+dnvFpwX9cZ5Fbh6N8u9y6Bx8r2tDvYMsJ7CGepWVq8=;
        b=Yq0mZfMyDBSJawTk/50n2Y9SkRgWsR+V0bW2v0DEhTwUjqXnjOUieYdbk8qYD01ERP
         mAorFW/ElMYvvy8MsHKK7n0Spc5+MZNj6XCOMt910Rqhc9vbHGavZKqHge09ZROv/d94
         1OF5MS+leJw0X76B6MULTXsherzvmEYsK79JruoxeBLvwPna9K/epWwMgN35yIwV+qnG
         MJ1NHWJfDKSqgIHKQrtn973OrVWCrhsO8uSP8n02OueKEonFIwbmwh0Fhtq/MKksZH5X
         r2kjwgdrhoalXk64EbEOtEVdCTvX8T5U1ehjIlmGYL6gWkHis4tMvXHWxzt1mKI6lqgL
         4bbQ==
X-Gm-Message-State: APzg51CUN+XEQ4B4LoUN98y8pfWSp5muW+JJ1LTyOlKo5K/CaJfwKuiY
        ykDms4Jsbtry60JyusBpj9K0JOvz
X-Google-Smtp-Source: ANB0VdYyTSu6Sb8+vMvMus/nWSaSe+06Zvc9Bggi+ikAJAXSrwZOBuRgOcLecIxqwaU89THenRAx1g==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr9166264wrr.280.1535665299946;
        Thu, 30 Aug 2018 14:41:39 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:39 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 02/20] stash: improve option parsing test coverage
Date:   Fri, 31 Aug 2018 00:40:32 +0300
Message-Id: <42423f6af38dd9029c7f7fe870593efbeabe3f1c.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.22.gc26283d74e

