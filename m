Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391991F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBHQUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:18 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35880 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbeBHQUP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id f3so11060261wmc.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=uYOZnXbPFa2ZvrWLNrjOHHZR2ym1bv2PZ0a4yqkcLJemPMF+ZWbPuMJdOCd/OTzvGk
         LU6XKFTabELbQlNWcfVMYidjwmFEyhBK6VBrsJPC0Gylsr76LDeOZf6w5Sg+u73Ts1xc
         et1ZeqAXmo+I2yP873ihBFzPnbUOzd4BXCgXeiqg7ehvdGIM3cqaS2/jRkXA1zKHW7AQ
         hpW3kp7Ydv4yCEbAEo8QX5DiZLEs3jb5LUa5VoBwTkIxqHBGX7VbbBz5gy6x3/qoxDPE
         90zR2yc5lNwz9rKq6dCPOR6vDuqFVpttKjROKO+LIG7Dbzj86DXSDYtXNjTXU4iN6FlL
         CvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=R1nnu4kX21AmQ5PtfFe79VwRhVzZCBrWnyC2Yfrocijuj89ScH3kg9ylyRm3QrTG8F
         vAYHu/j7V3lElVuSaNsvFs7+YKG6zllg2Craz/AmcnlxzB+rXVvD4RXlxLjS4PyyeDC9
         hlyMk0ux/hjG/139E+WKjx3fl5Vxz3BZJHQSzZwLjVMTsKESkcsTsYD/nKn3zo5phyTP
         BMYeBKKW18EQmLtKldpXKtNVqCkYMHmlTU58OF510gU9ft5mHEdXLhZvCU0HaICSfqoE
         YFlfb2miEcWVzSqsezxUfVuQfaE/WS447fJVe04IsUae+Zvpy/BWbTHdRI1z/hk4oyk8
         rXNA==
X-Gm-Message-State: APf1xPD05P+Wqp6qbGrLIF0FkLl7+AqeftEPhziWa9K+UwHQd1evPnJ2
        PRUE6bxLTcHvr8tSR7gtwvrWjMza
X-Google-Smtp-Source: AH8x225I46xgOrQKrOZFiLsrUbEoCBHr7bCYURHr9TdJJbWbIT7DM4TH7jhlKiYovTQaDvb/6Twm/w==
X-Received: by 10.28.120.19 with SMTP id t19mr1551997wmc.53.1518106814062;
        Thu, 08 Feb 2018 08:20:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/17] fetch tests: add a tag to be deleted to the pruning tests
Date:   Thu,  8 Feb 2018 16:19:26 +0000
Message-Id: <20180208161936.8196-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180208161936.8196-1-avarab@gmail.com>
References: <20180208161936.8196-1-avarab@gmail.com>
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a tag to be deleted to the fetch --prune tests. The tag is always
kept for now, which is the expected behavior, but now I can add a test
for tag pruning in a later commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 93 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 40 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ab8b25344d..fad65bd885 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -552,21 +552,25 @@ test_configured_prune () {
 	fetch_prune=$1
 	remote_origin_prune=$2
 	expected_branch=$3
-	cmdline=$4
+	expected_tag=$4
+	cmdline=$5
 
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${4:+ $4}; branch:$3" '
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
+		git tag -f newtag &&
 		(
 			cd one &&
 			test_unconfig fetch.prune &&
 			test_unconfig remote.origin.prune &&
 			git fetch &&
-			git rev-parse --verify refs/remotes/origin/newbranch
+			git rev-parse --verify refs/remotes/origin/newbranch &&
+			git rev-parse --verify refs/tags/newtag
 		) &&
 
 		# now remove it
 		git branch -d newbranch &&
+		git tag -d newtag &&
 
 		# then test
 		(
@@ -582,6 +586,14 @@ test_configured_prune () {
 			kept)
 				git rev-parse --verify refs/remotes/origin/newbranch
 				;;
+			esac &&
+			case "$expected_tag" in
+			pruned)
+				test_must_fail git rev-parse --verify refs/tags/newtag
+				;;
+			kept)
+				git rev-parse --verify refs/tags/newtag
+				;;
 			esac
 		)
 	'
@@ -590,44 +602,45 @@ test_configured_prune () {
 # $1 config: fetch.prune
 # $2 config: remote.<name>.prune
 # $3 expect: branch to be pruned?
-# $4 git-fetch $cmdline:
+# $4 expect: tag to be pruned?
+# $5 git-fetch $cmdline:
 #
-#                     $1    $2    $3     $4
-test_configured_prune unset unset kept   ""
-test_configured_prune unset unset kept   "--no-prune"
-test_configured_prune unset unset pruned "--prune"
-
-test_configured_prune false unset kept   ""
-test_configured_prune false unset kept   "--no-prune"
-test_configured_prune false unset pruned "--prune"
-
-test_configured_prune true  unset pruned ""
-test_configured_prune true  unset pruned "--prune"
-test_configured_prune true  unset kept   "--no-prune"
-
-test_configured_prune unset false kept   ""
-test_configured_prune unset false kept   "--no-prune"
-test_configured_prune unset false pruned "--prune"
-
-test_configured_prune false false kept   ""
-test_configured_prune false false kept   "--no-prune"
-test_configured_prune false false pruned "--prune"
-
-test_configured_prune true  false kept   ""
-test_configured_prune true  false pruned "--prune"
-test_configured_prune true  false kept   "--no-prune"
-
-test_configured_prune unset true  pruned ""
-test_configured_prune unset true  kept   "--no-prune"
-test_configured_prune unset true  pruned "--prune"
-
-test_configured_prune false true  pruned ""
-test_configured_prune false true  kept   "--no-prune"
-test_configured_prune false true  pruned "--prune"
-
-test_configured_prune true  true  pruned ""
-test_configured_prune true  true  pruned "--prune"
-test_configured_prune true  true  kept   "--no-prune"
+#                     $1    $2    $3     $4     $5
+test_configured_prune unset unset kept   kept   ""
+test_configured_prune unset unset kept   kept   "--no-prune"
+test_configured_prune unset unset pruned kept   "--prune"
+
+test_configured_prune false unset kept   kept   ""
+test_configured_prune false unset kept   kept   "--no-prune"
+test_configured_prune false unset pruned kept   "--prune"
+
+test_configured_prune true  unset pruned kept   ""
+test_configured_prune true  unset pruned kept   "--prune"
+test_configured_prune true  unset kept   kept   "--no-prune"
+
+test_configured_prune unset false kept   kept   ""
+test_configured_prune unset false kept   kept   "--no-prune"
+test_configured_prune unset false pruned kept   "--prune"
+
+test_configured_prune false false kept   kept   ""
+test_configured_prune false false kept   kept   "--no-prune"
+test_configured_prune false false pruned kept   "--prune"
+
+test_configured_prune true  false kept   kept   ""
+test_configured_prune true  false pruned kept   "--prune"
+test_configured_prune true  false kept   kept   "--no-prune"
+
+test_configured_prune unset true  pruned kept   ""
+test_configured_prune unset true  kept   kept   "--no-prune"
+test_configured_prune unset true  pruned kept   "--prune"
+
+test_configured_prune false true  pruned kept   ""
+test_configured_prune false true  kept   kept   "--no-prune"
+test_configured_prune false true  pruned kept   "--prune"
+
+test_configured_prune true  true  pruned kept   ""
+test_configured_prune true  true  pruned kept   "--prune"
+test_configured_prune true  true  kept   kept   "--no-prune"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

