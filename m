Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E7E1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 02:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFGCYs (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 22:24:48 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:35920 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFGCYs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 22:24:48 -0400
Received: by mail-ot1-f52.google.com with SMTP id c3so506767otr.3
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 19:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2oUY6N2w3DGHKYvfWj4HaBzotjU6z6mdDxOrT2F4Fg=;
        b=Jx4LgMsc94NonAWemcOkHRuAMWwYLJl14E8a6cWKIDRGKVajSN9Wo0jcePpoHxk+mf
         BsIuJvQYb1F7/xt1Y7rTWeFYlq5xxI0yczmR5EyBKRwg7Y2GUxOjxfndZeODjKGBuOYK
         kqqjIF6IQUOXuW35f2jaaVYS7p3PXDRmk39BbgazaNa20a55h1rI9J7+Q8GQZkXH8LdM
         bT9nkTJHPXrz/BYpID5fV5EMKI6tTt4DbXaBZZtyw7C6uPNYzFu6cHq+OvgqonkaF9CJ
         VCmN8fy7etucHW98XO/8f1spIZqK1pMs0Z+8VR13C32i6R3uOa18mzoGLsQpCNXYT4Ku
         PqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2oUY6N2w3DGHKYvfWj4HaBzotjU6z6mdDxOrT2F4Fg=;
        b=UHs00qYDWSCg3ajNPwv3P1iYM5Lmqe+n2/e6OzIlZPbaBZJwfPsEleqWjKQ41NBBOR
         eSMXuVnQIcR75Zx5yHBhYusDyQFu9pIrBJ7hfxxu1yhwOG39cHbnBOr93ANm9pIpz2IP
         0BmVYCiHFllvt5ztavF8hlMzbdNwm4zfZgEawc+l2IOCye8jPCRXRi3yr9BnzktSQLI3
         77QpMd54Bl5mv+XQlkYyH+sBnpNTazjbysWxiE00bfpKoae91zey58r+btciY2JC1hBw
         3Qk6SLWQ2mkUzzXKhNAWZUi4TFKGIlkaj/1A61zu3w4lTzUDEje0SiyKuYvTnpCxev60
         ZUfQ==
X-Gm-Message-State: APjAAAXZjU77TP2aRBU8Zjo0uyr4Z57yojADyBeYci1IoEZgWdSuuS+c
        Iohz2X1DWCwFO4s2BvPwwwm2VJhxXBQ=
X-Google-Smtp-Source: APXvYqxWlkQV3d7r2bE/zZxyz+lQelatki67Kjbu04Y8bKCWHceq4keP0Tq+Fr21rUJ0dCSD0PiJSg==
X-Received: by 2002:a9d:704f:: with SMTP id x15mr17642397otj.297.1559874286837;
        Thu, 06 Jun 2019 19:24:46 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id i13sm322324otl.27.2019.06.06.19.24.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 19:24:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: completion: tests for  __gitcomp regression
Date:   Thu,  6 Jun 2019 21:24:43 -0500
Message-Id: <20190607022443.5706-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.21.0
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
 t/t9902-completion.sh | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43cf313a1c..1319c542e1 100755
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
@@ -1547,7 +1561,8 @@ test_expect_success 'complete tree filename with metacharacters' '
 	EOF
 '
 
-test_expect_success PERL 'send-email' '
+test_expect_failure PERL 'send-email' '
+	offgit &&
 	test_completion "git send-email --cov" "--cover-letter " &&
 	test_completion "git send-email ma" "master "
 '
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
2.21.0

