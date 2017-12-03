Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3546520C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbdLCWSW (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:22 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:43209 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbdLCWSG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:06 -0500
Received: by mail-it0-f68.google.com with SMTP id u62so8423741ita.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yP1aIXvwDLUhIcuz2iKmW6Vwo55W7Gn7/vH3srC3mb0=;
        b=ihOARu0LMOV5UL8iqR2oZsDQT4p9COghjcLvhcOcu5g10NLRmMsDBEsiMeUOOzwHFQ
         lvWZ2Nso0AHbxaotfEPgAKjPkiMFEDEDJBm1jmLuNkp9xHzHcgxwdE8UqBTgSHzjhjMz
         vWyPADT6LeOfngjG+BVjGX6FED+6/TcEEv0t99y7wcgaZKtXAYpImRlOmhDCr92WIXZl
         /PeY/U7mwE4hl0XuvKhhwQHzJ8lPzjJEFu+vF/sqhGmdSNUlptx4y97O5A1N9CLVU8mK
         FHHeTfJuXDB/RF2qnvuWdH3WeBm8JWSD2n8RSF5tlISNucjL3Fl+G8kw/cGzNmELC4cj
         cytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yP1aIXvwDLUhIcuz2iKmW6Vwo55W7Gn7/vH3srC3mb0=;
        b=VJVT8//S4E6hoKoQ4Diqu0yQSDZcNGX1Xj3gu7EqgBpCI2C8TnZaLBk88ceyruVCex
         WzYASr6W6qQZQQzzNE540PHXHLgsrbXy8CewhoXf3oqLMPMXP90D59QRXwChi2vDVuWA
         rimnx2UKoHcIS4nRTNvjBli5SadlDZS6hmO7ZtoZ/aeffxyQ08e7XlFuvO0kIGvOMUqI
         b0t9YdE1+64gcf07rQH6V2tSGMJZhkh4lTnpzeuckKO9LwL/1w81DIQYTTYOuSYrn0cj
         6XIn3HM3k+nmMIVFDbszfxMby3vYCJlWggrdKKWpjosGaWv28xGq4A6rTcByUss9lQYa
         RANA==
X-Gm-Message-State: AJaThX5JVxkYGJcTWZx7NNhkHO1zh9GyGupOBMWZePEbtj3nJsCjuMUc
        MsciSkJAe2KzBVs7BTH/9JTTQ3Iy
X-Google-Smtp-Source: AGs4zMaA+kRfpg76ugMM1+TZO7h7bpIjlcp7srx4H1iDp7ASRYp7EuwUEBCQ/VsZChFBY7g533u7TA==
X-Received: by 10.107.173.93 with SMTP id w90mr20892003ioe.304.1512339485801;
        Sun, 03 Dec 2017 14:18:05 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:18:05 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 9/9] t3404: add test case for abbreviated commands
Date:   Sun,  3 Dec 2017 17:17:21 -0500
Message-Id: <20171203221721.16462-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure the todo list ends up using single-letter command
abbreviations when the rebase.abbreviateCommands is enabled.
This configuration option should not change anything else.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 t/t3404-rebase-interactive.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6a82d1ed876d..481a3500900d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1260,6 +1260,28 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
+	rebase_setup_and_clean abbrevcmd &&
+	test_commit "first" file1.txt "first line" first &&
+	test_commit "second" file1.txt "another line" second &&
+	test_commit "fixup! first" file2.txt "first line again" first_fixup &&
+	test_commit "squash! second" file1.txt "another line here" second_squash &&
+	cat >expected <<-EOF &&
+	p $(git rev-list --abbrev-commit -1 first) first
+	f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
+	x git show HEAD
+	p $(git rev-list --abbrev-commit -1 second) second
+	s $(git rev-list --abbrev-commit -1 second_squash) squash! second
+	x git show HEAD
+	EOF
+	git checkout abbrevcmd &&
+	set_cat_todo_editor &&
+	test_config rebase.abbreviateCommands true &&
+	test_must_fail git rebase -i --exec "git show HEAD" \
+		--autosquash master >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'static check of bad command' '
 	rebase_setup_and_clean bad-cmd &&
 	set_fake_editor &&
-- 
2.15.1.280.g10402c1f5b5c

