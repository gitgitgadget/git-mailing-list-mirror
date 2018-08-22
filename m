Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 971461F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeHVTbs (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44581 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeHVTbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so1834603ljq.11
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b94vg341+6vSYveM0HBioJu76B9v9pOJf+1WIycyeFE=;
        b=ZWfB3Z9c909STzFah/3s909ESesoUkN3c4h+r4DHpptufCT0K21pMWu4pX73KNDeEK
         eFbUZkfiGgfvyjXASjcr+z+WmKQLBaIMS2wO0TSgMHDLVGeXgnWyAOyx7pXUYmr1wt++
         GJ5ru9h/FbSMNta5OSwAI6USeGYe5nbz0LQAKO9FeCduweXMYQbSGBByE0LGU/eFKQ6Z
         xWMa23Z8H+7mc4hBMPpAm/4/XzjGsXqcYqDqK6W2OtjXVM4gOsuzp8KDPGXlDRKBpURS
         Siv8kSsNfC0tvyGWpqOobevMOFPrxy+qwkGWrkzvFX7d3KaGCYjZWM48JgyCsNrXyTmd
         18Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b94vg341+6vSYveM0HBioJu76B9v9pOJf+1WIycyeFE=;
        b=KI/5JhKBpxQ9ao8nU4Bn0MEDgJpIkwsmX3J5llQEK7vC5nLJllE20qn7RrB1kKf5ol
         LmzH9Fzlmrsz+9up9SktY9r/ujwgr3ZoTEIyMubYCb0r0yQPXqZUSLR1cjSgtRmclslR
         48VebxHnhgBw+0LwEJAbYnSRCOl8SOwWztm1KKGq/ImIiylxgQ9BUN46gMSt05HKsHsc
         yQO04SsGh/lyOX6zhjK+iRBA7IzKYZZ0dwEnCLkGx+nm8c6GVutsTVb9UM3QC5wCgjUw
         9tyArOqqEQoJHPChJtBpfeOU9JTS7BSY6DaTVutHgqjX55KwJMwannxnNR9xsokyukt1
         rsTg==
X-Gm-Message-State: APzg51DSYfFmgDqCUpU0zMzJaLF2QWNuqOQbNkH57at8NofJin8K0JNV
        a43MRqPM94AkTDLl6QcH9rNV6ejS
X-Google-Smtp-Source: ANB0Vda1juASs/h5/cfIAPSKCH8VW0KvohXLiyHg30pgDOpvyIVF0nc90Uf9IbN8BoURKVS2bMTZHw==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr718928ljh.111.1534953975364;
        Wed, 22 Aug 2018 09:06:15 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:14 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] config.txt: move pull part out to a separate file
Date:   Wed, 22 Aug 2018 18:06:00 +0200
Message-Id: <20180822160605.21864-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 37 +----------------------------------
 Documentation/pull-config.txt | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/pull-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4b1e9e830d..609b407afc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2549,42 +2549,7 @@ protocol.version::
 
 --
 
-pull.ff::
-	By default, Git does not create an extra merge commit when merging
-	a commit that is a descendant of the current commit. Instead, the
-	tip of the current branch is fast-forwarded. When set to `false`,
-	this variable tells Git to create an extra merge commit in such
-	a case (equivalent to giving the `--no-ff` option from the command
-	line). When set to `only`, only such fast-forward merges are
-	allowed (equivalent to giving the `--ff-only` option from the
-	command line). This setting overrides `merge.ff` when pulling.
-
-pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
-	of merging the default branch from the default remote when "git
-	pull" is run. See "branch.<name>.rebase" for setting this on a
-	per-branch basis.
-+
-When `merges`, pass the `--rebase-merges` option to 'git rebase'
-so that the local merge commits are included in the rebase (see
-linkgit:git-rebase[1] for details).
-+
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
-+
-When the value is `interactive`, the rebase is run in interactive mode.
-+
-*NOTE*: this is a possibly dangerous operation; do *not* use
-it unless you understand the implications (see linkgit:git-rebase[1]
-for details).
-
-pull.octopus::
-	The default merge strategy to use when pulling multiple branches
-	at once.
-
-pull.twohead::
-	The default merge strategy to use when pulling a single branch.
+include::pull-config.txt[]
 
 push.default::
 	Defines the action `git push` should take if no refspec is
diff --git a/Documentation/pull-config.txt b/Documentation/pull-config.txt
new file mode 100644
index 0000000000..bb23a9947d
--- /dev/null
+++ b/Documentation/pull-config.txt
@@ -0,0 +1,36 @@
+pull.ff::
+	By default, Git does not create an extra merge commit when merging
+	a commit that is a descendant of the current commit. Instead, the
+	tip of the current branch is fast-forwarded. When set to `false`,
+	this variable tells Git to create an extra merge commit in such
+	a case (equivalent to giving the `--no-ff` option from the command
+	line). When set to `only`, only such fast-forward merges are
+	allowed (equivalent to giving the `--ff-only` option from the
+	command line). This setting overrides `merge.ff` when pulling.
+
+pull.rebase::
+	When true, rebase branches on top of the fetched branch, instead
+	of merging the default branch from the default remote when "git
+	pull" is run. See "branch.<name>.rebase" for setting this on a
+	per-branch basis.
++
+When `merges`, pass the `--rebase-merges` option to 'git rebase'
+so that the local merge commits are included in the rebase (see
+linkgit:git-rebase[1] for details).
++
+When preserve, also pass `--preserve-merges` along to 'git rebase'
+so that locally committed merge commits will not be flattened
+by running 'git pull'.
++
+When the value is `interactive`, the rebase is run in interactive mode.
++
+*NOTE*: this is a possibly dangerous operation; do *not* use
+it unless you understand the implications (see linkgit:git-rebase[1]
+for details).
+
+pull.octopus::
+	The default merge strategy to use when pulling multiple branches
+	at once.
+
+pull.twohead::
+	The default merge strategy to use when pulling a single branch.
-- 
2.19.0.rc0.335.ga73d156e9c

