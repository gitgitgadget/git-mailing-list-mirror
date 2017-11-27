Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BD120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdK0Ezn (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:55:43 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:37047 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdK0Ezl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 23:55:41 -0500
Received: by mail-io0-f195.google.com with SMTP id v21so34985615ioi.4
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 20:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qw8a9CaIEN3ZchFDtxmZgNp0ghtcSLOLIRYEaDnYYdQ=;
        b=KyQtTI/ftoRMlhWA8oOmgDPEZUGyueKCHK6wzA8v3ci6Y5tAxz26iLEdZ9Z3UP6ful
         mbUtGDCM7Ipdem9VgJP75GXN/KKCkIX59FEkZBs/oU0oV7WE5jGgQT3qSG16KHRID9kF
         SsqaDFd6PX5OBkzwprJ2Ul4q/Fe3Pey2zev3q7tovN3TSjEUt9DrENIw3df6ZM9Xwwnv
         +u0PvmPaNOIWJc1vB24kr/x6OHxhD+1XjZZXEm/wFJU6hVOKo685a1nB/YyTC3haG3vW
         PdjbmMstO9BaOGVx2Ro1QpoV1rYKEXG6WE1aXESn2QoVTJBzbMBhkz2U+NL1EqCs2ueO
         FgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qw8a9CaIEN3ZchFDtxmZgNp0ghtcSLOLIRYEaDnYYdQ=;
        b=JDCvtCqK/qwzOacYF3yypZlVVD1rzfBNlHT/C7TjouG3v11gx9KlDZ1tBEYv+CpbOm
         brWw9f/+UyD5Bbh9liALrTnfWk7PLaojQ4e/D8RvkRUYhI31qI2YDjfjylk/2lruFhhr
         Xi/yQf2ziTNjD0F+6hQ8st7Fs/ZVqa53UCG2vzKnUH1EQQPhn2o6fLIHKn3cdnvq2NBe
         dyzgKmM7kZFeVfCLZPf23PMmdptZzMk5MXUZlY7GsQzNdUwozomW6IPrwgMq7cUskdfr
         kJBLH5BBFKIMynL3AzJzLxzP6tSRhC4DUvqmCnZ519XuRJD/mf6RIwptsHublW5zmvh4
         tCsQ==
X-Gm-Message-State: AJaThX4QClhOP9KtSJ3XdhAyJ8Tck6E9+kbqDqGO0SwJAV+qfscYIogW
        nj4mC5DcG1lqNKrT18crNv/OsxoG
X-Google-Smtp-Source: AGs4zMaxg0YqgZNjH5kh2rC+g6rnhuTz5VCx/u3Y26M/cDwKNAhlu4W+JWbK3thTSdklWplyIdfFkQ==
X-Received: by 10.107.183.20 with SMTP id h20mr42885579iof.23.1511758540344;
        Sun, 26 Nov 2017 20:55:40 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm4606305ioe.13.2017.11.26.20.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 20:55:40 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, avarab@gmail.com,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 5/5] t3404: add test case for abbreviated commands
Date:   Sun, 26 Nov 2017 23:55:14 -0500
Message-Id: <20171127045514.25647-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.0.321.g19bf2bb99cee.dirty
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make sure the todo list ends up using single-letter command
abbreviations when the rebase.abbreviateCommands is enabled.
This configuration options should not change anything else.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 t/t3404-rebase-interactive.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 6a82d1ed876d..e460ebde3393 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1260,6 +1260,38 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
+test_expect_success 'prepare rebase.abbreviateCommands' '
+	reset_rebase &&
+	git checkout -b abbrevcmd master &&
+	test_commit "first" file1.txt "first line" first &&
+	test_commit "second" file1.txt "another line" second &&
+	test_commit "fixup! first" file2.txt "first line again" first_fixup &&
+	test_commit "squash! second" file1.txt "another line here" second_squash
+'
+
+cat >expected <<EOF &&
+p $(git rev-list --abbrev-commit -1 first) first
+f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
+x git show HEAD
+p $(git rev-list --abbrev-commit -1 second) second
+s $(git rev-list --abbrev-commit -1 second_squash) squash! second
+x git show HEAD
+EOF
+
+test_expect_success 'respects rebase.abbreviateCommands with fixup, squash and exec' '
+	test_when_finished "
+		git checkout master &&
+		test_might_fail git branch -D abbrevcmd &&
+		test_might_fail git rebase --abort
+	" &&
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
2.15.0.321.g19bf2bb99cee.dirty

