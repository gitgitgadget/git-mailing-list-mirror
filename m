Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5351F428
	for <e@80x24.org>; Sun, 29 Apr 2018 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754274AbeD2UVd (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 16:21:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39321 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753898AbeD2UV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 16:21:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id f8so599787wmc.4
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 13:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KHznQF7upkxhCc5UdhQ3dHHRTzNZ+z6mblakr+npLbs=;
        b=J8HO13k2BdrFVALDpBuCLSgc40+J3AUJcWpxjMOteNGvXfvDLMg1L/ieD+vjcLOeB0
         DGGWz7e3eY2tnUv6LJTGcTQxfVlhBiaQZCAx6x9YGz2M+fYQCQSA7cFh0vzvnFKjAVrP
         1WUQuq2nUpGqyGy+n8/+dJKBCnVsLVINDHzMgBYb52fRb6nwOClTv694ZQ5Jt4jGp74W
         8KfmAxielEe+soISUDeI1V3WCovCPAL4xvCM8Cbm4HwNdWE9SHxYRjjS6iKfutwpYcXg
         gyEuf8JMgQMEdbk/05BSxIWpkWVh2dH5uWmX+AOeIkPW5jYVue3TEj78Lgi8BRYow+uL
         0blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KHznQF7upkxhCc5UdhQ3dHHRTzNZ+z6mblakr+npLbs=;
        b=GXdYUQm1DK2qb6hv43GwZ14q1kPsAGHlVFXe3JRXP3r4BrcnC09PGYBwplXMPB0WT6
         DYrvkhEfI0MKASOZXJkb7Gsi86+jld0MAg+EbVdtaaQVHNrTCa+A2oEG54mgsVurQAF0
         WhgVphiU0VyJbiNCbI/gFq/CYYddOYkxaM1yUqzEqM9Ery9E3LCFjIhfHVESaYJ4tajz
         Wy187Rq79+858SHrm/Tlh63GKgW0opPQD+s1d3nNZ543CWP1czWsIYOEmnfIgY6LYrJj
         W1n4w+CJIj3iM1hruOPcaUS+rP8Rhf3eTmRN69GTEkbXkK2qHGZ26so0DUwUusZrq/o+
         nnug==
X-Gm-Message-State: ALQs6tD0Q87YoeB9VTP3wnB6KCP0bsaEBXnsU03rYHZnDB13jZtxXE8c
        UN0RGbH97VU+EQdG891x8WDuKJ8v
X-Google-Smtp-Source: AB8JxZr3MxW33Y4vGbRdOCQ5e4mlL7YC+HVZTebaD3wk2RJJu3xnPLLKbI9GdNCqAv18yxDWKFAAxg==
X-Received: by 10.28.21.73 with SMTP id 70mr5033625wmv.35.1525033284946;
        Sun, 29 Apr 2018 13:21:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y42-v6sm8134917wry.21.2018.04.29.13.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Apr 2018 13:21:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/8] push tests: assert re-pushing annotated tags
Date:   Sun, 29 Apr 2018 20:20:56 +0000
Message-Id: <20180429202100.32353-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180429202100.32353-1-avarab@gmail.com>
References: <20180429202100.32353-1-avarab@gmail.com>
In-Reply-To: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
References: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
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
 t/t5516-fetch-push.sh | 66 ++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c9a2011915..71fc902062 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -965,35 +965,43 @@ test_expect_success 'push into aliased refs (inconsistent)' '
 	)
 '
 
-test_expect_success 'push requires --force to update lightweight tag' '
-	mk_test testrepo heads/master &&
-	mk_child testrepo child1 &&
-	mk_child testrepo child2 &&
-	(
-		cd child1 &&
-		git tag Tag &&
-		git push ../child2 Tag &&
-		>file1 &&
-		git add file1 &&
-		git commit -m "file1" &&
-		git tag -f Tag &&
-		test_must_fail git push ../child2 Tag &&
-		git push --force ../child2 Tag &&
-		git tag -f Tag HEAD~ &&
-		test_must_fail git push ../child2 Tag &&
-		git push --force ../child2 Tag &&
-		git tag -f Tag &&
-		test_must_fail git push ../child2 "refs/tags/*:refs/tags/*" &&
-		git push --force ../child2 "refs/tags/*:refs/tags/*" &&
-		git tag -f Tag HEAD~ &&
-		git push ../child2 "+refs/tags/*:refs/tags/*" &&
-		git tag -f Tag &&
-		git push --no-force ../child2 "+refs/tags/*:refs/tags/*" &&
-		git tag -f Tag HEAD~ &&
-		test_must_fail git push ../child2 tag Tag &&
-		git push --force ../child2 tag Tag
-	)
-'
+test_force_push_tag () {
+	tag_type_description=$1
+	tag_args=$2
+
+	test_expect_success "push requires --force to update $tag_type_description" "
+		mk_test testrepo heads/master &&
+		mk_child testrepo child1 &&
+		mk_child testrepo child2 &&
+		(
+			cd child1 &&
+			git tag Tag &&
+			git push ../child2 Tag &&
+			>file1 &&
+			git add file1 &&
+			git commit -m 'file1' &&
+			git tag $tag_args Tag &&
+			test_must_fail git push ../child2 Tag &&
+			git push --force ../child2 Tag &&
+			git tag $tag_args Tag HEAD~ &&
+			test_must_fail git push ../child2 Tag &&
+			git push --force ../child2 Tag &&
+			git tag $tag_args Tag &&
+			test_must_fail git push ../child2 'refs/tags/*:refs/tags/*' &&
+			git push --force ../child2 'refs/tags/*:refs/tags/*' &&
+			git tag $tag_args Tag HEAD~ &&
+			git push ../child2 '+refs/tags/*:refs/tags/*' &&
+			git tag $tag_args Tag &&function
+			git push --no-force ../child2 '+refs/tags/*:refs/tags/*' &&
+			git tag $tag_args Tag HEAD~ &&
+			test_must_fail git push ../child2 tag Tag &&
+			git push --force ../child2 tag Tag
+		)
+	"
+}
+
+test_force_push_tag "lightweight tag" "-f"
+test_force_push_tag "annotated tag" "-f -a -m'msg'"
 
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
-- 
2.17.0.290.gded63e768a

