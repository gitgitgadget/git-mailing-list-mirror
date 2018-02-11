Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334181F404
	for <e@80x24.org>; Sun, 11 Feb 2018 16:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbeBKQkq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 11:40:46 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35611 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753549AbeBKQkp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 11:40:45 -0500
Received: by mail-wr0-f196.google.com with SMTP id w50so12896334wrc.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 08:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Bix8FHQyeCznCdzkuSQydpyHbiB5FhKk/eLaNBvjxlU=;
        b=sMeL+BYoiRXdN/SXK7xtKspQsg+718v35EDuihiJtgya7XfJyztOopkH+5E36FmuF5
         esUgvGQCSwYnBnwTcn8CZhaJCCqObeQ8IADP1rnQ/F/Op5F8ZAc75L4phlu0bGt8/83h
         MDdIo3DZy/vuQE8NBElcDtdR3Nbs3roAGiJMKMKp93fcWwS9MQkZ/1/IQaDjePj3782Z
         ioJZYgUau1kqNaUI/WHK3OmLAQbBk1sT4AyLk9hB7PDK1iwjoEg99sTXvQQ2YzQskzye
         W2KJiHld673gHyE2xeikewOle6iL2GFNQNBbwHygBgEkea4Tv0dGT2/Lbd1Pu+3+nxsy
         72ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bix8FHQyeCznCdzkuSQydpyHbiB5FhKk/eLaNBvjxlU=;
        b=IQohC6zQK/MtA7zaQMWcA0e5FthAEI/AF/C45ZWr0CQRLwAGYjXvG4pAzQ2Q27ra6Z
         KSMGtQKJj4ExySb4PGsoqvqdHa9fNnxZEYCX4okHQhBKsj3tzfhR45bIdoDjSS+/Kko8
         UVTGxp7TSK0YiTcIzC4R0Ko8WB3o1mwp5DkOevf3i0ntaZTODDuN/CRvpUqdCedlSZqG
         1njSBF0ZQHx1wsg95jk9H7BgtHIhbK7cRTl9HFTYFUivvgSM6z833CJ9ZwyDnGgsd09+
         gGR7EdjpjkWbTfTlJbps74vvxYQjkwbhGeH+jLG3DJeeK46fjFFGGtSSxCqCOTz4exAH
         HFdw==
X-Gm-Message-State: APf1xPAjSL7KhfX338pwWBaQJje6HLT4zOXVyX4v2OJbrKqLgsSAivnt
        jBtde+ORq8tpd5xxs/NL3su9G/Ba
X-Google-Smtp-Source: AH8x226V4Qy96uNH7IEtl/FxOlEpMh+BOncD7GwnhGI3UBqMJdRQwUIe7jVgOnHEPJBq3mYjf0Ostw==
X-Received: by 10.223.163.140 with SMTP id l12mr2936878wrb.270.1518367243608;
        Sun, 11 Feb 2018 08:40:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id z73sm10012551wrb.50.2018.02.11.08.40.42
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Feb 2018 08:40:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] config: change default of `pager.config` to "on"
Date:   Sun, 11 Feb 2018 17:40:25 +0100
Message-Id: <cb4440e4f910f7095f16144afcc5963445211482.1518365675.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a
In-Reply-To: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to ff1e72483 (tag: change default of `pager.tag` to
"on", 2017-08-02) and is safe now that we do not consider `pager.config`
at all when we are not listing or getting configuration. This change
will help with listing large configurations, but will not hurt users of
`git config --edit` as it would have before the previous commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt |  2 +-
 t/t7006-pager.sh             | 12 ++++++------
 builtin/config.c             |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index ccc8f0bcff..78074cf3b2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -236,7 +236,7 @@ See also <<FILES>>.
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
-`--list`, `--get` or any of `--get-*` is used.
+`--list`, `--get` or any of `--get-*` is used. The default is to use a pager.
 
 [[FILES]]
 FILES
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 869a0359a8..47f7830eb1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -261,22 +261,22 @@ test_expect_success TTY 'git config --edit ignores pager.config' '
 	test -e editor.used
 '
 
-test_expect_success TTY 'git config --get defaults to not paging' '
+test_expect_success TTY 'git config --get defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git config --get foo.bar &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 test_expect_success TTY 'git config --get respects pager.config' '
 	rm -f paginated.out &&
-	test_terminal git -c pager.config config --get foo.bar &&
-	test -e paginated.out
+	test_terminal git -c pager.config=false config --get foo.bar &&
+	! test -e paginated.out
 '
 
-test_expect_success TTY 'git config --list defaults to not paging' '
+test_expect_success TTY 'git config --list defaults to paging' '
 	rm -f paginated.out &&
 	test_terminal git config --list &&
-	! test -e paginated.out
+	test -e paginated.out
 '
 
 
diff --git a/builtin/config.c b/builtin/config.c
index 9a57a0caff..61808a93cb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -600,7 +600,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 
 	if (actions & ACTION_LIST_OR_GET)
-		setup_auto_pager("config", 0);
+		setup_auto_pager("config", 1);
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
-- 
2.16.1.72.g5be1f00a9a

