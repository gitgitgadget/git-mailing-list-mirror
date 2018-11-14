Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD7E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 22:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbeKOIbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 03:31:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52869 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbeKOIbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 03:31:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so16921339wmb.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAkrMo5JzHTHTm9SJYGgKEBZ1cfJhFwkiV2Kx1Z8Hhk=;
        b=iR9L+TlHf506RJj/iJpab2oFJevWikqdC9TSQVgV2hhZwkLRF913a+7guVJED9WvCG
         3QH/2txVjViH4yntXm5mQqNT9ZNCp+ESM4PTbswIMvX0HAhArXwYmdXVyonBKgTnmpVS
         FbM9r9kZFyDE66yLf1KaJFs/qsGkKR2kX0DpYkJx2e2Ja4fWMwwj2SD/bi/jEkHSL00v
         73UWGF/WmT2w6NCnR1HxO/gN9HiDW3meyM67hBffXJzPY4kAdqOjjWSNVAKOh3aNgmFy
         pvSAn50Y+rzjtjLods9ZITZR9hJ/elnfLHH+j4uJdOgC/3iug7NNGdqj5ts4Z4BaAP1Z
         EhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAkrMo5JzHTHTm9SJYGgKEBZ1cfJhFwkiV2Kx1Z8Hhk=;
        b=bkyj4Br7VCfJyDZzLn/JC+8Q2pUI1uyMYl6qz6HQapNqIWHy73TxRGu9qBSUuDGLRN
         HJmT4OJ8dmIbPhYe4Yz/9FctyeJ4jKo4sT/1p7guenUYGgG1qftEC4n4Xyxc0tVuc8dg
         os51sn5IG2S00pDLlp/TA2JRMN8N7s7DUcOB3YktBi1TLLiSd0N7I36vvDremjuFVEyi
         yOwreKseJsiuSz6XNSOvs2+8gWrf7XFZsTJN68AF6YVOFoXruHJjVZeRx151/xwEPxDA
         Snm05o+PkcZf4sPnqfq3fLg0xXG8OK2SmF2AOPvsdc/ofvrrwyGlVVdWl7C4shusVRCS
         /k+A==
X-Gm-Message-State: AGRZ1gLnfrXG7GEqGUF/o/s2Obs2nhYHK1MYZ76onVXRCS/6Ebc+A1PT
        /t/jPfEK24F8GDf6iPkbesUqRJQ6
X-Google-Smtp-Source: AJdET5fNmX5jnLPEGnviLJDGaLqczLGFvoK0VSuRpIAahQjPu1ELdk4mLViTrkrqn2izz1vwr1GK3A==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr3392636wmf.143.1542234375281;
        Wed, 14 Nov 2018 14:26:15 -0800 (PST)
Received: from localhost.localdomain ([31.223.156.217])
        by smtp.gmail.com with ESMTPSA id r1-v6sm22503441wrt.59.2018.11.14.14.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:26:14 -0800 (PST)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured user.name and user.email
Date:   Wed, 14 Nov 2018 23:25:24 +0100
Message-Id: <20181114222524.2624-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe
In-Reply-To: <20181114221218.3112-1-slawica92@hotmail.com>
References: <20181114221218.3112-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test to document that stash fails if user.name and user.email
are not configured.
In the later commit, test will be updated to expect success.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3903-stash.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index cd216655b..bab8bec67 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,4 +1096,27 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_failure 'stash works when user.name and user.email are not set' '
+	git reset &&
+	git var GIT_COMMITTER_IDENT >expected &&
+	>1 &&
+	git add 1 &&
+	git stash &&
+	git var GIT_COMMITTER_IDENT >actual &&
+	test_cmp expected actual &&
+	>2 &&
+	git add 2 &&
+	test_config user.useconfigonly true &&
+	test_config stash.usebuiltin true &&
+	(
+		sane_unset GIT_AUTHOR_NAME &&
+		sane_unset GIT_AUTHOR_EMAIL &&
+		sane_unset GIT_COMMITTER_NAME &&
+		sane_unset GIT_COMMITTER_EMAIL &&
+		test_unconfig user.email &&
+		test_unconfig user.name &&
+		git stash
+	)
+'
+
 test_done
-- 
2.19.1.1052.gd166e6afe

