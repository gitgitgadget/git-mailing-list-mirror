Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F361F42D
	for <e@80x24.org>; Thu, 31 May 2018 19:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeEaTxv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 15:53:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33593 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbeEaTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 15:53:37 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so2885661wma.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eVFLK2wsNnG8rw8VETAf63uGl6C/0GLspJfglvD4bgg=;
        b=fu6ls2x+s0MsAMh4adJdGDtOLif5pOi3RRgs2sADgdU2Wrp37gNsXATKxCc1NNR77B
         ZJuAhJMBjksphKGagXtNicDVF9lyn/xDNt9/CrajKeb7IVBiT0C3oDWKn16ckEpKNbRx
         h0bcw9yciAe/IV9ThprQxR3C+HP5WZg6CQgp4kFjQIIoyuB6O8ZqVXwqorMZZo90vtL3
         Sq4pNy4ado6xfr3cI9v8ZURZ692UVLzE1UiHhn0/YM78siMOf/XX/1yaQY455UHnadJY
         wbEDVUMMl+siPR9PLNy8veDeqJ6krREAAqx8bLh8BnWl6gko3+eSFrmhywL2bHGEQghz
         Skwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eVFLK2wsNnG8rw8VETAf63uGl6C/0GLspJfglvD4bgg=;
        b=WPPqItQZmu61JLqpJMybyEBWn33ewEoxHO18ogCSGVp2TW9GRwLypazQB8x/4fBCBx
         +H+PpMaZizpGBzIYDyxomJjnVXNsdq/Ta9GzUWG9f88X9P9XwLmzewK9m+6XNNe+mT1A
         IMIeDUCDtj2JXot3i8QoeXQYzvz5nCygXF1weUJw8ldeca2rnHKINkWoXoJz0naBJhkF
         BkEJrhNBkXkAOy0oYfO9pCvdxzINdKHNp8Bx731Amucspq5+pRQpRm+7OHeuCb6CptqM
         U4JZQtriugZ86DyXOTksmCEZpatMP+TRztsuJdLTAJRC73HqY5yxE32HnpAX/yGZlgcE
         vEPQ==
X-Gm-Message-State: APt69E3ExmwNx1T2FMB9d/DrCWAZZynYPHhTLAX57ePExkR064XyJPQ4
        8hT/ZHm3KJX8nkB2D0NYmu90LBxj
X-Google-Smtp-Source: ADUXVKJ73KHsihg8oZkxUiVdyXmVM1SHNO7gVdXyIDVGX/D0MY8ap/IIppuDNepgytj5xQc9jJI6Ng==
X-Received: by 2002:a1c:8f8f:: with SMTP id r137-v6mr729430wmd.103.1527796416069;
        Thu, 31 May 2018 12:53:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l10-v6sm19809118wrm.29.2018.05.31.12.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:53:35 -0700 (PDT)
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
Subject: [PATCH v4 8/9] checkout: add advice for ambiguous "checkout <branch>"
Date:   Thu, 31 May 2018 19:52:51 +0000
Message-Id: <20180531195252.29173-9-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180531195252.29173-1-avarab@gmail.com>
References: <20180531195252.29173-1-avarab@gmail.com>
In-Reply-To: <87a7sg9sjz.fsf@evledraar.gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com>
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

This is a really useful feature, the problem is that when you another
remote (e.g. a fork) git won't find a unique branch name anymore, and
will instead print this nondescript message:

    $ git checkout master
    error: pathspec 'master' did not match any file(s) known to git

Now it will, on my git.git checkout, print:

    $ ./git --exec-path=$PWD checkout master
    error: pathspec 'master' did not match any file(s) known to git.
    hint: The argument 'master' matched more than one remote tracking branch.
    hint: We found 26 remotes with a reference that matched. So we fell back
    hint: on trying to resolve the argument as a path, but failed there too!
    hint:
    hint: Perhaps you meant fully qualify the branch name? E.g. origin/<name>
    hint: instead of <name>?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt |  7 +++++++
 advice.c                 |  2 ++
 advice.h                 |  1 +
 builtin/checkout.c       | 11 +++++++++++
 t/t2024-checkout-dwim.sh | 14 ++++++++++++++
 5 files changed, 35 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7d8383433c..08d3e70989 100644
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
index 423e056acd..710369a60a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -22,6 +22,7 @@
 #include "resolve-undo.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "advice.h"
 
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
@@ -1269,6 +1270,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.patch_mode || opts.pathspec.nr) {
 		int ret = checkout_paths(&opts, new_branch_info.name,
 					 &dwim_remotes_matched);
+		if (ret && dwim_remotes_matched > 1 &&
+		    advice_checkout_ambiguous_remote_branch_name)
+			advise(_("The argument '%s' matched more than one remote tracking branch.\n"
+				 "We found %d remotes with a reference that matched. So we fell back\n"
+				 "on trying to resolve the argument as a path, but failed there too!\n"
+				 "\n"
+				 "Perhaps you meant fully qualify the branch name? E.g. origin/<name>\n"
+				 "instead of <name>?"),
+			       argv[0],
+			       dwim_remotes_matched);
 		return ret;
 	} else {
 		return checkout_branch(&opts, &new_branch_info);
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index 29c1eada17..14735f5bb8 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -77,6 +77,20 @@ test_expect_success 'checkout of branch from multiple remotes fails #1' '
 	status_uno_is_clean
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

