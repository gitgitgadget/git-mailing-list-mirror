Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93A0C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 15:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGRPpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiGRPpu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 11:45:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FB310FEE
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:45:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o7so20020274lfq.9
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWSxoM3bUNBMsIKJaHnK9kyFe0QqA/cXo7zmvc4tWGM=;
        b=Z+a8Pcvf22kD7Ifg/8lUD9X+hG+aixtSOZQuH9j+/4HDVdFgcRPUkcf5qw7IC8K3b9
         pLsznR3xzbxKe16wMRZiMxJMtvz5G/GeLQ5lWnww53NAatm4+shdYzOWM5PAZ71c5VDx
         u0kdAzil5av15PkusXjZPLahgzY4ektd41w8E4J/58VBHeWZ165SsFVeG1aAOozFuGz5
         LsBOybcOhOZUGAC/+cZroTyOknkc+aXXC+pEYlXfbL8WCleN4ihtPSFkaTQKab+zLLay
         Ac6ObuoY5Zud7DPlxM1+F7aBp60P0AgfVBYrAevWCDWWyNnsU2+HTNo/3X1Ln22FskRC
         y1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qWSxoM3bUNBMsIKJaHnK9kyFe0QqA/cXo7zmvc4tWGM=;
        b=0CERf18ldM3Sc2cX+SdtHdAGlGL/yB79VM3e/q/azKiqwmQnMUBVLjFpjKPE2Ke+Ma
         WTlDoQ7694A2u89aaJOO+D+4OOxhyGpRP+JSDGm6VhI0+GlP8w0cX/q05fBOZlUtwgo2
         w5ZlViryjlr1HfqZ5drRlUTSaD44oKhJxn28HWNo+Va7nW9/eb7/hgwMin75KM+80K6I
         CAZpZruoGVm3EjYvkZznj85r210LQFpOdoeDf4faQuWkg0r9VkYk0kHvnXuanbfh+koV
         MTQq+LrZ8dXG6Qu7+ZsJ9CjX7zYTRm9Q0H5gbwj2BvYeS/dLjf8S8HUf7q06PiEl360K
         9Weg==
X-Gm-Message-State: AJIora/nbs52YhuShcFdLFVoPds3Jo3gdPznCgWGRG0bFnfLl1mdUx/k
        SOoNBabJh4dg/C9sektVjn1XKWQB7zY=
X-Google-Smtp-Source: AGRyM1v1sUWArXFPL8Be2LriTWeWp+fDp0rv9iVejzx+Da3zvYd38ImPT4Yl86b7jdcuxr5u+RagTg==
X-Received: by 2002:a05:6512:2315:b0:489:cbc1:886a with SMTP id o21-20020a056512231500b00489cbc1886amr14123853lfu.428.1658159147146;
        Mon, 18 Jul 2022 08:45:47 -0700 (PDT)
Received: from localhost.localdomain (81-231-137-145-no600.tbcn.telia.com. [81.231.137.145])
        by smtp.gmail.com with ESMTPSA id a2-20020a19e302000000b00489e50cf274sm2652686lfh.229.2022.07.18.08.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:45:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t4200: drop irrelevant code
Date:   Mon, 18 Jul 2022 17:43:22 +0200
Message-Id: <20220718154322.2177166-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.37.1.373.g4dd4a117ec
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While setting up an unresolved merge for `git rerere`, we run `git
rev-parse` and `git fmt-merge-msg` to create a variable `$fifth` and a
commit-message file `msg`, which we then never actually use. This has
been like that since these tests were added in 672d1b789b ("rerere:
migrate to parse-options API", 2010-08-05). This does exercise `git
rev-parse` and `git fmt-merge-msg`, but doesn't contribute to testing
`git rerere`. Drop these lines.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 This is quite late fallout from Eric's review [1] of some commits that
 have already gone in.

 [1] https://lore.kernel.org/git/CAPig+cSjHg2-WYqdkZAS0ye1goj_=5RN3mdjt0-4kSBqNm6WLg@mail.gmail.com/

 t/t4200-rerere.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 9f8c76dffb..7025cfdae5 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -358,23 +358,20 @@ test_expect_success 'set up an unresolved merge' '
 	headblob=$(git rev-parse version2:file3) &&
 	mergeblob=$(git rev-parse fifth:file3) &&
 	cat >expected.unresolved <<-EOF &&
 	100644 $headblob 2	file3
 	100644 $mergeblob 3	file3
 	EOF
 
 	test_might_fail git config --unset rerere.autoupdate &&
 	git reset --hard &&
 	git checkout version2 &&
-	fifth=$(git rev-parse fifth) &&
-	echo "$fifth		branch fifth of ." |
-	git fmt-merge-msg >msg &&
 	ancestor=$(git merge-base version2 fifth) &&
 	test_must_fail git merge-recursive "$ancestor" -- HEAD fifth &&
 
 	git ls-files --stage >failedmerge &&
 	cp file3 file3.conflict &&
 
 	git ls-files -u >actual &&
 	test_cmp expected.unresolved actual
 '
 
-- 
2.37.1.373.g4dd4a117ec

