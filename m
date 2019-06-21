Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C0A1F4B6
	for <e@80x24.org>; Fri, 21 Jun 2019 22:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFUWbY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:31:24 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40424 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfFUWbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:31:23 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so5745793oie.7
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4/tnaqoDtrhT+IOwNd2ugdEAgGC3Jd7BSLiABXR2Jo=;
        b=F0n7WVXE+Lj9+NGYEHXDwEhzieiuygLHObBqmmH9nHj+xG1ZzWt1nv9K283A5SVVPH
         AFMoeewzBhuB7haXvbn07qOABLWz3o3EAEW1obffjaFNRCrdPB6Yhs0jgO/lQ17qo2em
         6XbJDiJzX9qo7wcNtBLxCcsksAwBgaNz1HIpGcYMV08JMR/Gm9h1esdXdIToCOgQC0id
         bDDjmjf0qjdMHWxdU0b7vUSeZZ6aUATOH2XlhlHhCv5hINQPkSn0vNg4jKjUBTvn+cm4
         egTmYlD3oumFbYkmrPDfjVv/7mCXAOWH0XKTijqbwn7pMBlArCAVOw5tv07JOhh5nVSX
         RAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4/tnaqoDtrhT+IOwNd2ugdEAgGC3Jd7BSLiABXR2Jo=;
        b=eTrSzu3WnQLF9KZFdE4gW36Fqwxd+F/p9FsJ7p2FhJqC2PM+RVUKQvB03Fjr2ZR7Em
         83fl15VSb1gp3PKlk4s51k0nq6YNkXkkz+6iOzq8dGNUKxP4M1dFLWMKitiwVi/JI018
         gCiBs/k5CLgidLtWo3KAvzLDgbuaHRzJZWFTa4R0uRWSJCNb8f+/cQiKK9F/yD2zezh2
         ZfB58q7LgdMakFv+bHnkO58XPfKIf0FFF2OYSQfq22lTxOb+ta2LxNO8pOF0JYeAU7hk
         xx5Qh3jJdTiELm8RYEe4NctluscOnSC2iTmwWjO2s4e909X9r/p61BD1xPwd93fZ0gle
         FUMQ==
X-Gm-Message-State: APjAAAVnVvGCjog108/JLevLhaId9UAbS/Lz4bB6KnUm84eNYcU1hW2P
        fKyqn9uEK0/s/ZyYkesm5Q4EloRcM94=
X-Google-Smtp-Source: APXvYqxxaNxWLauX0wtTx37ZEa3yFqZJo6fLvqRX8t3kwVyS7xTvxLy7zTHX+649AynSzwHNR7e+aA==
X-Received: by 2002:aca:ad54:: with SMTP id w81mr4520045oie.86.1561156282594;
        Fri, 21 Jun 2019 15:31:22 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id 40sm321453oty.81.2019.06.21.15.31.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 15:31:22 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/14] completion: zsh: trivial cleanups
Date:   Fri, 21 Jun 2019 17:31:03 -0500
Message-Id: <20190621223107.8022-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621223107.8022-1-felipe.contreras@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to override IFS, zsh has a native way of splitting by new
lines: the expansion flag (f).

Also, we don't need to split files by ':' or '='; that's only for words.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 7f614d5854..317f5bd80a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -68,44 +68,38 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${${=1}% } && _ret=0
+	compadd -Q -- ${${(f)1}% } && _ret=0
 }
 
 __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_nl_append ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	compset -P '*[=:]'
+	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file_direct ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compset -P '*[=:]'
-	compadd -f -- ${=1} && _ret=0
+	compadd -f -- ${(f)1} && _ret=0
 }
 
 __gitcomp_file ()
 {
 	emulate -L zsh
 
-	local IFS=$'\n'
-	compset -P '*[=:]'
-	compadd -p "${2-}" -f -- ${=1} && _ret=0
+	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.22.0

