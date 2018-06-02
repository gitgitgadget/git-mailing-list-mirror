Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDDF81F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbeFBLvS (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:18 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35576 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeFBLvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:51:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10-v6so3796249wrn.2
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rrJ5Iao327/xnj7ypj70VJ6N+33fK85lLcDHyHPo0AE=;
        b=l1K2t2dAooEkdtSvj7xwmdbKfUffkuR842tAOLDtH/wWUnvyewcXAdmX8jin8s1rVW
         Bx9+fbjG5nnFfs5SIIzJFBoWFAIxDahQTYrBlI5H8MtZXZMHNmuK/4tUx7By784u6iqt
         ZSNXLe6m/ncCpb4aSf2DgxsPn8WF9jruPsyZg9odRXEinEOwYZRlfV5xKwAoIxOqP19D
         YvVR8vXt6L7jY+ihc9ojv+IxBjXRBWgM9TWGT+8TVX4ANp074+I29r18eNzeemuKb+Y+
         u0B46G1HCl5AUZMfkSDDiiw7DZrLDZCglQ5q9Rpm+QoibafShv/SkLrLnNgECPdDXjsl
         cWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rrJ5Iao327/xnj7ypj70VJ6N+33fK85lLcDHyHPo0AE=;
        b=bjiQLol8am6BbC/h05hayyBEwDG2Ppod6JLYrXFFeXJqZT1zyOoMtqz9QIDLP9Dq4r
         ab0gXtVuDeGdZ4+TTKtn8fSeZmc/0vdIdVSf8hQxqgIBC6R3J/WqI1/afXH1qN85CCjZ
         TyiTwO+3eHrYAaq4++tSYjDyFtgZCm18TopkpJ+6sOPssLd0lIjo07g+kCc5b6odfAYU
         +z7/jlDZ+HOZDv5hZcnRLUHWNFxwlbzZ2fxNFlC+T85EkEkOxvEbtmadjrWJqEB/f5pU
         02Uc0TofyWvHZ/ds2gXSRvWRyzr2i1nWE3IUKNl80oRNr/d69CvoU6voe6rxYY8mKmqF
         TTWQ==
X-Gm-Message-State: ALKqPwc6i8KHyS1oj5/NTZ2ShUxrDhs9fv4FH1rxmRaMWXt4O31efLpN
        7DxPKuTU6eWaFwMoP5lFXhMSkruJ
X-Google-Smtp-Source: ADUXVKLJJIQsKqophQP400x4nZJ4VSl3tkJ6platGmGozlH/WIxkybie+s2yRIuifiQUIhyafxpYnw==
X-Received: by 2002:adf:a58a:: with SMTP id g10-v6mr11821566wrc.233.1527940263195;
        Sat, 02 Jun 2018 04:51:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:51:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 7/8] checkout: add advice for ambiguous "checkout <branch>"
Date:   Sat,  2 Jun 2018 11:50:41 +0000
Message-Id: <20180602115042.18167-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the "checkout" documentation describes:

    If <branch> is not found but there does exist a tracking branch in
    exactly one remote (call it <remote>) with a matching name, treat
    as equivalent to [...] <remote>/<branch.

This is a really useful feature. The problem is that when you add
another remote (e.g. a fork), git won't find a unique branch name
anymore, and will instead print this unhelpful message:

    $ git checkout master
    error: pathspec 'master' did not match any file(s) known to git

Now it will, on my git.git checkout, print:

    $ ./git --exec-path=$PWD checkout master
    error: pathspec 'master' did not match any file(s) known to git.
    hint: 'master' matched more than one remote tracking branch.
    hint: We found 26 remotes with a reference that matched. So we fell back
    hint: on trying to resolve the argument as a path, but failed there too!
    hint:
    hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
    hint: you can do so by fully qualifying the name with the --track option:
    hint:
    hint:     git checkout --track origin/<name>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt |  7 +++++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/checkout.c       | 13 +++++++++++++
 t/t2024-checkout-dwim.sh | 14 ++++++++++++++
 5 files changed, 37 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..dfc0413a84 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -344,6 +344,13 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	checkoutAmbiguousRemoteBranchName::
+		Advice shown when the argument to
+		linkgit:git-checkout[1] ambiguously resolves to a
+		remote tracking branch on more than one remote in
+		situations where an unambiguous argument would have
+		otherwise caused a remote-tracking branch to be
+		checked out.
 	amWorkDir::
 		Advice that shows the location of the patch file when
 		linkgit:git-am[1] fails to apply it.
diff --git a/advice.c b/advice.c
index 370a56d054..75e7dede90 100644
--- a/advice.c
+++ b/advice.c
@@ -21,6 +21,7 @@ int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
+int advice_checkout_ambiguous_remote_branch_name = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -72,6 +73,7 @@ static struct {
 	{ "ignoredhook", &advice_ignored_hook },
 	{ "waitingforeditor", &advice_waiting_for_editor },
 	{ "graftfiledeprecated", &advice_graft_file_deprecated },
+	{ "checkoutambiguousremotebranchname", &advice_checkout_ambiguous_remote_branch_name },
 
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
diff --git a/advice.h b/advice.h
index 9f5064e82a..4d11d51d43 100644
--- a/advice.h
+++ b/advice.h
@@ -22,6 +22,7 @@ extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
+extern int advice_checkout_ambiguous_remote_branch_name;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8c93c55cbc..baa027455a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -22,6 +22,7 @@
 #include "resolve-undo.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "advice.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -1267,6 +1268,18 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	UNLEAK(opts);
 	if (opts.patch_mode || opts.pathspec.nr) {
 		int ret = checkout_paths(&opts, new_branch_info.name);
+		if (ret && dwim_remotes_matched > 1 &&
+		    advice_checkout_ambiguous_remote_branch_name)
+			advise(_("'%s' matched more than one remote tracking branch.\n"
+				 "We found %d remotes with a reference that matched. So we fell back\n"
+				 "on trying to resolve the argument as a path, but failed there too!\n"
+				 "\n"
+				 "If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+				 "you can do so by fully qualifying the name with the --track option:\n"
+				 "\n"
+				 "    git checkout --track origin/<name>"),
+			       argv[0],
+			       dwim_remotes_matched);
 		return ret;
 	} else {
 		return checkout_branch(&opts, &new_branch_info);
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index ed32828105..fef263a858 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -76,6 +76,20 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	test_branch master
 '
 
+test_expect_success 'checkout of branch from multiple remotes fails with advice' '
+	git checkout -B master &&
+	test_might_fail git branch -D foo &&
+	test_must_fail git checkout foo 2>stderr &&
+	test_branch master &&
+	status_uno_is_clean &&
+	test_i18ngrep "^hint: " stderr &&
+	test_must_fail git -c advice.checkoutAmbiguousRemoteBranchName=false \
+		checkout foo 2>stderr &&
+	test_branch master &&
+	status_uno_is_clean &&
+	test_i18ngrep ! "^hint: " stderr
+'
+
 test_expect_success 'checkout of branch from a single remote succeeds #1' '
 	git checkout -B master &&
 	test_might_fail git branch -D bar &&
-- 
2.17.0.290.gded63e768a

