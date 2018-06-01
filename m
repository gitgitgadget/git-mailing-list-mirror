Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E881F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeFAVKy (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 17:10:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39421 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFAVKp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 17:10:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so4190763wmc.4
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OdWZS9NGMluAmwkYpFpJxA5V05m6iTzwWrNioYIn8gA=;
        b=JqPaHGkK7mxCsYXlL+mUQFJBULSv3Mex0/dUyaANiCjr3LNtPRO8k8pAmRMqH6wMoY
         DnDLgtGSFPSBMlPGIdgZqGrnTfO+xAveoUrLbyybfDcl4zbaVKyrDfOvuXAD0+Cn+bEW
         oVJGnhjmW3hzUBJk7Ggi2QjXOdhNW7+vUo70mRSmEItLSe6145gvjS04NNTiDXHZ+2ne
         AXAr7UZHL9+nVqNaZ0srVALI/i2JFhDF4FFQU9Yj1StjgTElOxLPyqfbOyV+1tSV7+MC
         rpAjPzs94xeHzlq7emZ/vfbES63Ao21XbXbN/46y3+aTi2cxXtT1ZEM0jRX2pjyMQyIu
         7wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OdWZS9NGMluAmwkYpFpJxA5V05m6iTzwWrNioYIn8gA=;
        b=mkXZ7dzNmB6JWRFzWIaP6wEGO8yngXGQizLaSc4B9ba7FNOwqgRq4znj5ojd8Yehcd
         dbW6IQJo5xQ1UE9QJabNc+CxoatJmqWN3JI0ixkHcjPerzsJ0jcliM6//SL7BXVrbORK
         aKW6mWlXzNfcw4SuMyzQP0d51ONISUiVPT2oGbQOrUo/FfH0E72n6W5IVp4lfVeauYP6
         Bpo4uo4uLhm4kBh3YEeq4oRGObf2FJhFs6VAnOQ/WOVV39pQfxIejD36PnoB8wFzJh7I
         lB+UC/iQZEjBK/YUqSJyu7xZQhFnJSr0y1lFxuQLoPYXq7kZCJvTHU4rhYEp1/kkpX+d
         CVrg==
X-Gm-Message-State: APt69E2NM6B+e2+5KyFpIY2xRatubtazrLLd3Nyzg1EKYO5sg3xrmc4k
        ssNHteMAXWe/WLohVmd9719cTJ5U
X-Google-Smtp-Source: ADUXVKLFliFMWUu+rvoL012YQUwVLhvlIiNDkGsfgQ5aL1HZL4U08YUZLkkAn40RAtsjflvFIalybQ==
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr3419811wmi.135.1527887443889;
        Fri, 01 Jun 2018 14:10:43 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k126-v6sm3516235wmd.45.2018.06.01.14.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 14:10:43 -0700 (PDT)
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
Subject: [PATCH v5 7/8] checkout: add advice for ambiguous "checkout <branch>"
Date:   Fri,  1 Jun 2018 21:10:14 +0000
Message-Id: <20180601211015.11919-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
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

This is a really useful feature. The problem is that when you and
another remote (e.g. a fork) git won't find a unique branch name
anymore, and will instead print this nondescript message:

    $ git checkout master
    error: pathspec 'master' did not match any file(s) known to git

Now it will, on my git.git checkout, print:

    $ ./git --exec-path=$PWD checkout master
    error: pathspec 'master' did not match any file(s) known to git.
    hint: The argument 'master' matched more than one remote tracking branch.
    hint: We found 26 remotes with a reference that matched. So we fell back
    hint: on trying to resolve the argument as a path, but failed there too!
    hint:
    hint: If you meant to check out a remote tracking branch on e.g. 'origin'
    hint: you can do so by fully-qualifying the name with the --track option:
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
index 8c93c55cbc..4dfb8f1535 100644
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
+			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
+				 "We found %d remotes with a reference that matched. So we fell back\n"
+				 "on trying to resolve the argument as a path, but failed there too!\n"
+				 "\n"
+				 "If you meant to check out a remote tracking branch on e.g. 'origin'\n"
+				 "you can do so by fully-qualifying the name with the --track option:\n"
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

