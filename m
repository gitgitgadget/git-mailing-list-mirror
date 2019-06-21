Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36451F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfFUWb0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:26 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40497 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfFUWbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:25 -0400
Received: by mail-ot1-f54.google.com with SMTP id e8so7785314otl.7
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKalh0R30bhY5rv8TQWRYTrESz8oPgX0L/SF7NjDi18=;
        b=ZSalskKZBT5RKfFFnAXBGo0BsyKvkI/m11aXbweR5NIz6LHMcia4qKMikF03Joyi53
         NCxwPG93D6Rf/5zmQXpU4mS0WzpX5DlDwgf7OLTg8yW6Nziq6edZI0hbnVFapLfsFoEZ
         IGcTcyTkHvXCxPBbQhW6ug13AexqwsPmIClHlvhTy6c8gbUawCYVGUwJX2LLrRlWrlSv
         a9e2aQbGNnrwCzQPfh7FGhU+j2a+yBu37wdTP13q4sjetvsRw+CtbW+87HTS+99meyJx
         rXVBjXzRNpIhd4xmC4DZKuuhnvr5oMXqNnfjZk10gI6ZyOA8tbCm29YDso9Ht0hysArU
         3ulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKalh0R30bhY5rv8TQWRYTrESz8oPgX0L/SF7NjDi18=;
        b=OanjYypsQZ4j5aRQreKD4h+ZzEoHqe3sKKprAizVZpFWqYLTNDV7Eh7MGMC9MlbGU0
         aAFoqH4ECLFfQYXVcIhNBNj5iC6Pf7uCc8I9qyGEjPtFDwT6DA1gsYgZt8q2lgxV0tGK
         AP9KgFRDu16e5ZWY7s0GAKS8n7F0i+K8vJtgkRt0ixi5d7chhsgvwMQa5wAr8HOuJ6y1
         l+Bv2DRjmifyHWYnhG3REzdWCyTBF8pDLPbgR/cF2qKwdzN6tDgoF1nwEzvSpWnnvvsi
         lQ4JQfjrgkDBCFgR81ac5yQRq5eO31FDgMSma45rsgZSVQymobJvwHwYcPiAxQ4S/x7H
         TqMA==
X-Gm-Message-State: APjAAAVvwE331xuOQE1OABpUv3LPXva/pZrOcgIMmmF3QJesy592lGTD
        iOpppdgBKVgB2oPaYcA9X/KK4qsuujE=
X-Google-Smtp-Source: APXvYqyqFX2kfcYDq2RuKdEj/SQgg/qrCXSF/UleJy695PvFPL+zBhxBEaDvRb/yLgy0dayGX08D9A==
X-Received: by 2002:a9d:4599:: with SMTP id x25mr38219553ote.219.1561156283774;
        Fri, 21 Jun 2019 15:31:23 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id n32sm1443248ota.7.2019.06.21.15.31.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/14] test: completion: tests for __gitcomp regression
Date:   Fri, 21 Jun 2019 17:31:04 -0500
Message-Id: <20190621223107.8022-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a regression in the completion since the introduction of
__gitcomp.

Go to any directory that doesn't contain a git repository, like /tmp.
Then type the following:

  git checkout --<tab>

You will see nothing. That's because
`git checkout --git-completion-helper` fails when you run it outside a
git repository.

You might change to a directory that has a git repository, but it's too
late, because the empty options have been cached.

It's unclear how many commands are affected, but this patch attempts to
at least detect some already in the testing framework.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43cf313a1c..7bef41eaf5 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -122,6 +122,15 @@ test_gitcomp_nl ()
 	test_cmp expected out
 }
 
+offgit ()
+{
+	GIT_CEILING_DIRECTORIES="$ROOT" &&
+	export GIT_CEILING_DIRECTORIES &&
+	test_when_finished "ROOT='$ROOT'; cd '$TRASH_DIRECTORY'; unset GIT_CEILING_DIRECTORIES" &&
+	ROOT="$ROOT"/non-repo &&
+	cd "$ROOT"
+}
+
 invalid_variable_name='${foo.bar}'
 
 actual="$TRASH_DIRECTORY/actual"
@@ -358,10 +367,8 @@ test_expect_success SYMLINKS '__git_find_repo_path - resulting path avoids symli
 '
 
 test_expect_success '__git_find_repo_path - not a git repository' '
+	offgit &&
 	(
-		cd non-repo &&
-		GIT_CEILING_DIRECTORIES="$ROOT" &&
-		export GIT_CEILING_DIRECTORIES &&
 		test_must_fail __git_find_repo_path &&
 		printf "$__git_repo_path" >"$actual"
 	) &&
@@ -1388,6 +1395,7 @@ test_expect_success '__git_pretty_aliases' '
 '
 
 test_expect_success 'basic' '
+	offgit &&
 	run_completion "git " &&
 	# built-in
 	grep -q "^add \$" out &&
@@ -1401,6 +1409,7 @@ test_expect_success 'basic' '
 '
 
 test_expect_success 'double dash "git" itself' '
+	offgit &&
 	test_completion "git --" <<-\EOF
 	--paginate Z
 	--no-pager Z
@@ -1419,7 +1428,8 @@ test_expect_success 'double dash "git" itself' '
 	EOF
 '
 
-test_expect_success 'double dash "git checkout"' '
+test_expect_failure 'double dash "git checkout"' '
+	offgit &&
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
 	--detach Z
@@ -1442,6 +1452,7 @@ test_expect_success 'double dash "git checkout"' '
 '
 
 test_expect_success 'general options' '
+	offgit &&
 	test_completion "git --ver" "--version " &&
 	test_completion "git --hel" "--help " &&
 	test_completion "git --exe" <<-\EOF &&
@@ -1460,6 +1471,7 @@ test_expect_success 'general options' '
 '
 
 test_expect_success 'general options plus command' '
+	offgit &&
 	test_completion "git --version check" "checkout " &&
 	test_completion "git --paginate check" "checkout " &&
 	test_completion "git --git-dir=foo check" "checkout " &&
@@ -1480,11 +1492,13 @@ test_expect_success 'general options plus command' '
 '
 
 test_expect_success 'git --help completion' '
+	offgit &&
 	test_completion "git --help ad" "add " &&
 	test_completion "git --help core" "core-tutorial "
 '
 
-test_expect_success 'completion.commands removes multiple commands' '
+test_expect_failure 'completion.commands removes multiple commands' '
+	offgit &&
 	test_config completion.commands "-cherry -mergetool" &&
 	git --list-cmds=list-mainporcelain,list-complete,config >out &&
 	! grep -E "^(cherry|mergetool)$" out
@@ -1547,9 +1561,10 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
-test_expect_success PERL 'send-email' '
-	test_completion "git send-email --cov" "--cover-letter " &&
-	test_completion "git send-email ma" "master "
+test_expect_failure PERL 'send-email' '
+	test_completion "git send-email ma" "master " &&
+	offgit &&
+	test_completion "git send-email --cov" "--cover-letter "
 '
 
 test_expect_success 'complete files' '
@@ -1649,6 +1664,7 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 '
 
 test_expect_success 'completion without explicit _git_xxx function' '
+	offgit &&
 	test_completion "git version --" <<-\EOF
 	--build-options Z
 	--no-build-options Z
@@ -1699,13 +1715,15 @@ do
 done
 
 test_expect_success 'sourcing the completion script clears cached commands' '
+	offgit &&
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
 	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
 	verbose test -z "$__git_all_commands"
 '
 
-test_expect_success 'sourcing the completion script clears cached merge strategies' '
+test_expect_failure 'sourcing the completion script clears cached merge strategies' '
+	offgit &&
 	GIT_TEST_GETTEXT_POISON= &&
 	__git_compute_merge_strategies &&
 	verbose test -n "$__git_merge_strategies" &&
@@ -1714,6 +1732,7 @@ test_expect_success 'sourcing the completion script clears cached merge strategi
 '
 
 test_expect_success 'sourcing the completion script clears cached --options' '
+	offgit &&
 	__gitcomp_builtin checkout &&
 	verbose test -n "$__gitcomp_builtin_checkout" &&
 	__gitcomp_builtin notes_edit &&
-- 
2.22.0

