Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF78D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeAWWOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45868 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932256AbeAWWN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so4736896wmi.4
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=ExnP62cz+DnldhMoWKi/bwHRDnU4JVQMV8RdTYZtymsbKlib7SJJFgLRvs+y+hYNk0
         XHUXBzCz0FbS/yhRZuOot0csIcToquyCsIdrC3y1UPa53lBjbREgDNlltrSUbtpnJ0XF
         1pW7RLNOY2OuvuixlXnw6C6AeKzYCN19dB6i0wbGQELKhshJ5ZFrK4ejiEtfWB1jdALx
         e16nY01KblKrMnph1ic3KHAP4keRmjDUuUEiNPGJ+tvV0J+zLGplcilB5niHS5cOLxsT
         AnfmB33sB1P6UAx4WYGgMlIZlqv0k8vkYaO+pg34Rj2bsLCt6FET26nYaFXJi1s05oHJ
         DRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=r1C5TGqBfiayvH0bUj0/d9BC2hG6+U0ylkzSOzwPApO04P/bqJsPlfe4plpUl3pGlw
         FjnV/V6Pwc4VSubiVJUMctQu57wGP5xPor0GPppJupt03aRpwEpm43TcZ5d4T660G0Bo
         kAEA+J5oo3OhMvi7+m+t4WE94OS0Jm5fGPbUAKgKGo+gSEMJphNHgO3Pp+THNFtI3Hb9
         kfQUAGgbrmWI4tKw1gJodXPiC7zV/Am30DgtRP5CZc/+56mVz7Kpyss9R6DGkdqAJNiZ
         78eq25rIUKpTZbicIQhwPyiqY5kBLZyKqFJeJnILCCK7Q5IacIditMt1kbUPKQ75tvDE
         cD7g==
X-Gm-Message-State: AKwxytcYyde3ggsNuTwFurJ2GgGZIXioAI9PO/VP9vKRDy4O0jVVZqNq
        oD6d6ZyBBRliSOHDVc+7l7k5FO0A
X-Google-Smtp-Source: AH8x224mLEPs4CK3aVwtA0UYoC+TPOQEc3ZAhjDU63xv8A4a5helARAWi/0YYgTdN2T4/fQl4iS5Xw==
X-Received: by 10.80.155.90 with SMTP id a26mr21244264edj.290.1516745635915;
        Tue, 23 Jan 2018 14:13:55 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/11] fetch tests: add a tag to be deleted to the pruning tests
Date:   Tue, 23 Jan 2018 22:13:20 +0000
Message-Id: <20180123221326.28495-6-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180123221326.28495-1-avarab@gmail.com>
References: <20180123221326.28495-1-avarab@gmail.com>
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
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

