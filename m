Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30DB20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbdLERxP (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:15 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:32964 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbdLERw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:58 -0500
Received: by mail-it0-f66.google.com with SMTP id o130so17766407itg.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yP1aIXvwDLUhIcuz2iKmW6Vwo55W7Gn7/vH3srC3mb0=;
        b=o7qTIZd9sMpJbVfn9oxRuog/T5xSfnMuUpbv8YnyrPjg90HHfjMMdCp3h/99vjKayH
         rEAEkaf0ZdPQCpSqQlx5S05mca7GZyiCWin3Dn5KcXHyG+c2P3E4TNk6wiLbESLCf5u+
         HHOjXf6VGHY5sWomjSsfLLJSRtzUpOBdpHFwxmrIdHRuUGW2P7nD64C/Xk5fjb3uHmYs
         zePoUUY/Dh+ZULO9ScGjVKR2XxAJ1pEcPL5yWVnP2MsyJQfKxulXCrJCebNsSN2Kg38x
         T8toVcgyYZg9qjlLGsjbqEZHAX2xVbtYJw8Xw+6frMOBtf/LyBwpiPFhnHdn1odw71ge
         +fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yP1aIXvwDLUhIcuz2iKmW6Vwo55W7Gn7/vH3srC3mb0=;
        b=ib1DTg7LNrBOr5jwVYzmr0yqFhRM0GZFOU8m4BDCt3+pO5qOBQ+mQiMXzeUrpjwbpl
         K7sGPfq8c9kkH3mrMEZJcfCXsfvpFDJubQYMuikQBmUqPhUYWBgvTCHO4Oy3FlvXDX3T
         DyKU3/WYfJn+WBO/w/A9ympJgmbeZCtVcIWN2b2CdWP1bCrgWbTmU1ziN0/ILofjz2Le
         6bpMXL7dF0p5tcY9dwA8OtJTs/PJVj5DH3Mh26DYhoblIa23u66OhnUQ81ViAn7x087K
         kWVuW/hveaKQbNC2HNwDdAt5AYOlzZAzJm+tEL/B183KVWVOdrgEZhLWC96IjuPQxQTL
         MrIA==
X-Gm-Message-State: AKGB3mIMKUcnLbb4xkaohQA9syJgu+g1G3LPq+9ltb0k6CIbIBG2Um+Y
        fyc+uUyvZyoZBYRu6hRN+ks3Zyo2BD8=
X-Google-Smtp-Source: AGs4zMaax38pwlYUQZVD0VaTONpTsNZJ9/j0GtQd3H+uYFhaqx1qt5ZFet2lBN9+aM3PertgbCJarA==
X-Received: by 10.107.53.130 with SMTP id k2mr8896112ioo.293.1512496378096;
        Tue, 05 Dec 2017 09:52:58 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:57 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 9/9] t3404: add test case for abbreviated commands
Date:   Tue,  5 Dec 2017 12:52:35 -0500
Message-Id: <20171205175235.32319-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
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

