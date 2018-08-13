Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E3C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeHMWGu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:06:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53440 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbeHMWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:06:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so9975668wmh.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLPnKzQwSLgXDrL+ndhssNFnw/JzzHbRdi2vzl7ZZqE=;
        b=GjXydCi+XQE5bgNvo0IxAJfad+A+dPM3xtGsSGgMO3oMqc0WKYwcL8s01HrK83lSAA
         /HQj/vVy3emjzRDrp8LX/cF8LgH4W+m5Om+8HSp0YjXBINVw5yBKbuKNR4znLMnw+8tS
         tFqp2Ysy09dvh9oJE/DrCbyc5Dla7fWAJsR4CM5fsQZFa3hDebCwnxbjPLzRtgnPS5rj
         jf+sPKpZ/YHt0/AUxgheOew/ZFKmNLgP8YGVjC8F8clgnV26yRfRmsYiHiJDDzYW+yCw
         osUyLmsTliKZfoN7iXQHl7NyZJYe3XwCGMhGndo40lCEMajmRxvKWlHNk/7vfdRva11A
         A/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLPnKzQwSLgXDrL+ndhssNFnw/JzzHbRdi2vzl7ZZqE=;
        b=B1tRTIdR72OidTpJC8adSCVvNe4ozcF74JVQBmxOSvTI2RxTGU7rKD8MRykfGCP82X
         JA7KPyW+ItTCJhxe6vP3XYaDelp/8Bjjk3IsIQAsaPnMHR6kBQafb5nRH3hl0ZGBtaEW
         YUwOZI9ddUlrjNUpxz+jtTEegz34zzoiF6k1NZub5ZWsO6S+F+t5U4nsPvwkfgOeg+B7
         a0uIxITbWJH3RN6v1OaUkgRi6H4qDrXlW68SEjqn3Aj2EiZBPs8d1mWop0TivHjnOFXj
         1HT/7J5mZij0HCnLRcL4UGX0q+uTFkFgnoz9LeBjFHVm0oWkcdAVF1CG1/Gl8WvfDUAx
         Mj+Q==
X-Gm-Message-State: AOUpUlGKYpVssdUU/J7kJ194+XiYu6Qk8dZsqiU3D0B1OEkgVab0snTZ
        qioc8b2qYk7SB6h4XKq27KY6InlW
X-Google-Smtp-Source: AA+uWPz9daOJiwtS5nAmTk3EwKjjswG3ZGKMP9b+11JnZMMdzgWLrsWqfbsRVaZMPBqoerbJ0Ux3sQ==
X-Received: by 2002:a1c:c147:: with SMTP id r68-v6mr9124788wmf.161.1534188192569;
        Mon, 13 Aug 2018 12:23:12 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34929545wma.17.2018.08.13.12.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 12:23:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/7] push tests: assert re-pushing annotated tags
Date:   Mon, 13 Aug 2018 19:22:47 +0000
Message-Id: <20180813192249.27585-6-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180731130718.25222-1-avarab@gmail.com>
References: <20180731130718.25222-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test that asserts that lightweight tags can only be
clobbered by a force-push to check do the same tests for annotated
tags.

There used to be less exhaustive tests for this with the code added in
40eff17999 ("push: require force for annotated tags", 2012-11-29), but
Junio removed them in 256b9d70a4 ("push: fix "refs/tags/ hierarchy
cannot be updated without --force"", 2013-01-16) while fixing some of
the behavior around tag pushing.

That change left us without any coverage asserting that pushing and
clobbering annotated tags worked as intended.  There was no reason to
suspect that the receive machinery wouldn't behave the same way with
annotated tags, but now we know for sure.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 82 ++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c7b0d2ba00..539c25aada 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -965,43 +965,51 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_expect_success 'force pushing required to update lightweight tag' '
-	mk_test testrepo heads/master &&
-	mk_child testrepo child1 &&
-	mk_child testrepo child2 &&
-	(
-		cd child1 &&
-		git tag testTag &&
-		git push ../child2 testTag &&
-		>file1 &&
-		git add file1 &&
-		git commit -m "file1" &&
-		git tag -f testTag &&
-		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag &&
-		git tag -f testTag HEAD~ &&
-		test_must_fail git push ../child2 testTag &&
-		git push --force ../child2 testTag &&
-
-		# Clobbering without + in refspec needs --force
-		git tag -f testTag &&
-		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
-		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with + in refspec does not need --force
-		git tag -f testTag HEAD~ &&
-		git push ../child2 "+refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with --no-force still obeys + in refspec
-		git tag -f testTag &&
-		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
-
-		# Clobbering with/without --force and "tag <name>" format
-		git tag -f testTag HEAD~ &&
-		test_must_fail git push ../child2 tag testTag &&
-		git push --force ../child2 tag testTag
-	)
-'
+test_force_push_tag () {
+	tag_type_description=$1
+	tag_args=$2
+
+	test_expect_success 'force pushing required to update lightweight tag' "
+		mk_test testrepo heads/master &&
+		mk_child testrepo child1 &&
+		mk_child testrepo child2 &&
+		(
+			cd child1 &&
+			git tag testTag &&
+			git push ../child2 testTag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args testTag &&
+			test_must_fail git push ../child2 testTag &&
+			git push --force ../child2 testTag &&
+			git tag $tag_args testTag HEAD~ &&
+			test_must_fail git push ../child2 testTag &&
+			git push --force ../child2 testTag &&
+
+			# Clobbering without + in refspec needs --force
+			git tag -f testTag &&
+			test_must_fail git push ../child2 'refs/tags/*:refs/tags/*' &&
+			git push --force ../child2 'refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with + in refspec does not need --force
+			git tag -f testTag HEAD~ &&
+			git push ../child2 '+refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with --no-force still obeys + in refspec
+			git tag -f testTag &&
+			git push --no-force ../child2 '+refs/tags/*:refs/tags/*' &&
+
+			# Clobbering with/without --force and 'tag <name>' format
+			git tag -f testTag HEAD~ &&
+			test_must_fail git push ../child2 tag testTag &&
+			git push --force ../child2 tag testTag
+		)
+	"
+}
+
+test_force_push_tag "lightweight tag" "-f"
+test_force_push_tag "annotated tag" "-f -a -m'msg'"
 
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
-- 
2.18.0.345.g5c9ce644c3

