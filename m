Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9384A1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 14:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbeFEOlP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 10:41:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37576 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752520AbeFEOlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 10:41:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so2728273wro.4
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 07:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RFnoiwnDv3sB9s+k6kINzJvkuaP9BKzYQ3M1M0zOWD0=;
        b=fnvissCx9588xdkfgvKGXUf3o3743tKzYenD6Ey4sO6PSrUj3wtEmOI6fapAKbz9eZ
         r84kuMbZqu8dpLEmn0NgVdcQ1YUtRMVN8aFz3Rywze0FF+bE1F/tudF92Fz9wz8ZJgUU
         ElbHhdGllGb8ITiMXD8Abq4Oct1NV6Xph3hEgLkFfEkdIuyBsUSFLmBxrN6ybm7n4jbc
         Y+oIOG008g6eoWPDH2QA7co9qZBVnylKyIMgFa+xN76+6DTDXG9RBI0FUXsZJPD4vfdt
         //CjYIUCreounmf7Uh5m3yLdS1ja6dhpmBpz51KHj1l6IDUNwWCZ3KHbsPAbV6GdPAPF
         dnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RFnoiwnDv3sB9s+k6kINzJvkuaP9BKzYQ3M1M0zOWD0=;
        b=LOIaOHHnt1d4meuhYxQgN1TyzT6923nIOAXx3mW8lbtzOVlnMCv+JwjMgOZyfftF+K
         nD5uQGdd4y2xxJYMqfp9XpzSL8Z2MUPvz/YQDAn8ybIDk2iLXplhP6ogCG0UjEJsBqds
         UFbEcuEgj9nRhtpPliZvW0h/rM0cNBEsrkoQDZlYtmWRBncs6qlfaf7n8n3E+psdnUZm
         cpVvQJ8UXk0utD9iD925f7R3Neg7NxsGDk874k+OcT+Hm54NdAiN9oN4trTqxXCkm51P
         OtNQ1H5JwmXv/BZY280WauR28zEXuEaWx+AE5oWyRvgmz2Zoc/K+jaBDm08e+aA3cxoI
         0W3A==
X-Gm-Message-State: ALKqPwcc8ZoNN593tg6fsreFZOO82G99nkVGStv33TERMz01/V5ThT+Y
        KCdGT4uVBwgKCGNQU7lq0/4UpkVw
X-Google-Smtp-Source: ADUXVKIFRq39IEQ/6X4tPjo+94MrsahEME9YrYSp3g0Icxt2o/Mkcbi3XL/hPb8FIghube4vN02OUw==
X-Received: by 2002:adf:a419:: with SMTP id d25-v6mr19471935wra.121.1528209669169;
        Tue, 05 Jun 2018 07:41:09 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id i76-v6sm2458910wmd.20.2018.06.05.07.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 07:41:08 -0700 (PDT)
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
Subject: [PATCH v7 7/8] checkout: add advice for ambiguous "checkout <branch>"
Date:   Tue,  5 Jun 2018 14:40:48 +0000
Message-Id: <20180605144049.26488-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180605144049.26488-1-avarab@gmail.com>
References: <20180605144049.26488-1-avarab@gmail.com>
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
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

Note that the "error: pathspec[...]" message is still printed. This is
because whatever else checkout may have tried earlier, its final
fallback is to try to resolve the argument as a path. E.g. in this
case:

    $ ./git --exec-path=$PWD checkout master pu
    error: pathspec 'master' did not match any file(s) known to git.
    error: pathspec 'pu' did not match any file(s) known to git.

There we don't print the "hint:" implicitly due to earlier logic
around the DWIM fallback. That fallback is only used if it looks like
we have one argument that might be a branch.

I can't think of an intrinsic reason for why we couldn't in some
future change skip printing the "error: pathspec[...]" error. However,
to do so we'd need to pass something down to checkout_paths() to make
it suppress printing an error on its own, and for us to be confident
that we're not silencing cases where those errors are meaningful.

I don't think that's worth it since determining whether that's the
case could easily change due to future changes in the checkout logic.

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

