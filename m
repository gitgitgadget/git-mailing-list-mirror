Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F46F1F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfEHAN3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:29 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43641 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHAN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:27 -0400
Received: by mail-wr1-f48.google.com with SMTP id r4so9361395wro.10
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATjesDCqNXRXQO91KyuQlWriuIIiLHrV0/Z8/14T2pE=;
        b=KMUKHLDI5uE/tsCDZEi15jaUla5g5k0tyUyVfOSO3c78C3VD1nXDhRaD7QwVmgwj37
         QFkvotO4s1NB7fpErplprkx7kHQWVvIUhYQQl7q/8Zv1XOCMA26WxgQ+fAUY4yVYer5A
         9zhgrJPLbhvErfOEW+BWOnaZ8b7QGej+OiS72AP63msJ8NNlvAcCzkr4MgCV/TYBZ2ON
         cllLCPO1ahe1kF/jNxbHA/BpvyyxWvU0MG7c9N9RzmHy60vcNrL2/8P3G4C7Dnwiu6aR
         Zypx/70IAzX3NTgEsQNTsj9SwBdfL19KYNhVtEr+28FgiSpUGIkFgWzSOBnIsF3SjH7X
         OzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATjesDCqNXRXQO91KyuQlWriuIIiLHrV0/Z8/14T2pE=;
        b=W4etiCrxHvJEEvwBBsJn4FTrxe3UJ2gf+xLYCkQimurwehf9vGOJevpO0Km/E8fF9W
         BmYbN+Gpc9+7VyV5xXtq652DLuetqCALF3e4Sp7WFtx9mki+IIh/aHh2tCnwFms4aILm
         TforT0GC+P940KUViHLe4u9U4VQ435rES9tLLOeeh+KUyUlTPJ5Z9cPXTGsiJOCnpLE3
         11XnExN8HEgBQjVBkV150Z3eQXMFhZ8UzSBNTJYsLVZSY/AGwimD8ryhTqnS0z4RvdJC
         AjzxezZIDP0WArpeIDYAP53XdGaj3Sr2noZIyBke8o0eyjz0jHPZemurfhFE9rIaMBww
         AzlA==
X-Gm-Message-State: APjAAAWfXfxlXMdupxiNl0UpEqbBp+HcvUzlWsgaf0ZYNqA1vtIb+stN
        sO/5cm9rGG/wunS2Z8MS+t91SLmiYnw=
X-Google-Smtp-Source: APXvYqx3RV15fIEMx8V0V9KFFNkZAgTsTEN3AyKSDzRjiFE+9DFgmS5sc90N9mDHQvSPi02oJgd45Q==
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr5181712wrt.291.1557274405141;
        Tue, 07 May 2019 17:13:25 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 13/13] WIP: can_fast_forward() support for --preserve-merges and --rebase-merges
Date:   Wed,  8 May 2019 02:12:52 +0200
Message-Id: <20190508001252.15752-14-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This seems to work, needs more tests etc...

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/rebase.c               | 6 ++++++
 t/t3432-rebase-fast-forward.sh | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 167d4fcf67..de1c5cacb8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -892,6 +892,12 @@ static void populate_merge_bases(struct commit *head, struct commit *onto,
 
 static int should_fast_forward(struct rebase_options *opts)
 {
+	if (!(opts->flags & REBASE_INTERACTIVE_EXPLICIT)) {
+		if (opts->rebase_merges)
+			return 1;
+		if (opts->type == REBASE_PRESERVE_MERGES)
+			return 1;
+	}
 	return !is_interactive(opts);
 }
 
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index e8a9bf42b6..d3e1815057 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -44,12 +44,13 @@ test_rebase_same_head_ () {
 	test_expect_$status "git rebase$flag $* with $changes is $what with $cmp HEAD" "
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		git rebase$flag $* >stdout &&
+		git rebase$flag $* >stdout 2>stderr &&
 		if test $what = work
 		then
 			# Must check this case first, for 'is up to
 			# date, rebase forced[...]rewinding head' cases
-			test_i18ngrep 'rewinding head' stdout
+			test_i18ngrep 'rewinding head' stdout ||
+			test_i18ngrep 'is up to date, rebase forced' stdout
 		elif test $what = noop
 		then
 			test_i18ngrep 'is up to date' stdout &&
@@ -79,6 +80,8 @@ test_rebase_same_head success noop same success noop-force same --keep-base mast
 test_rebase_same_head success noop same success noop-force same --keep-base
 test_rebase_same_head success noop same success noop-force same --no-fork-point
 test_rebase_same_head success noop same success noop-force same --keep-base --no-fork-point
+test_rebase_same_head success noop same success noop-force same --preserve-merges
+test_rebase_same_head success noop same success noop-force same --rebase-merges
 test_rebase_same_head success noop same success work same --fork-point master
 test_rebase_same_head success noop same success work diff --fork-point --onto B B
 test_rebase_same_head success noop same success work diff --fork-point --onto B... B
-- 
2.21.0.1020.gf2820cf01a

