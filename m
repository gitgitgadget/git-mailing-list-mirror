Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93BE1FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeASABD (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42771 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeASAA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:00:57 -0500
Received: by mail-wm0-f68.google.com with SMTP id b141so234450wme.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=TYHQlHuW19/FlKvKzOSLSJJeIEENeuBMu6KHx7HsTbstcmsQn4zXUrZcDeplvbyJ49
         0+ap40vOsFw+c2orX4sVl5qFVu8cHyGZoeGtIJbu8n/3UlNbc4Gm1cPOwBzqOjgjIhKZ
         E1Ft4iFMUCMWj9njM28SKCtZaHaTCHGs07DjksPCe5QJKpnO1h+UKy3TdTtMbFnOssVV
         oMQXgIIUY8/iG3cfhU3rI6DYcAPbAE642Mrsc2rrxGScMfD4KveOPyybIFWph2xxFIft
         +Y7bG+Wo6WuYJHkkrb46CDqU+JnnHef742Yg8SCBTwgGOXS7x1IF7LaOSknititAghcZ
         BGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=nof1iyJiXIwGUTY79CTGRhfwKaSDdCHLQTnbxl17Edm7IyWcaOccGhXIVbUU4z7x0e
         vx9LzQUF6V/9srvXkjBTJq+3HOyU2HL2SL3VRORN6TwVzJaVhJ7eBs5vzDoZ5oYdGUsg
         s/thxblYBK+myeaghkruUuDp36GsMCP8Y4GjDp8HftxA1YUaynQZdYy8iZlPm9jxD1C/
         nuhEymT4BRtIrT/1fREdL9alNLVdeXPC49XBbbbmLEuyCpOM6Msy51I/Jnt13RvFipvh
         KIOGlFJ7dvsxXXi+Yvo3lGplUg4RBF6cRZ7YNTuxfU4jy2cQvMXe4UjNe6blGb4N5jm1
         mlWA==
X-Gm-Message-State: AKwxytexPoXccu5gEq8A1GIbgDGvNMTCWfsM++4IDi6bGsXwo6DiDscM
        JXk0hpxjcHy7ForPOH5+Ydfd6OAy
X-Google-Smtp-Source: ACJfBos8QtN+EW7SBSQmZu+tB6GrR2CQbEGszIEPp76xaUeZMVzvHP8dqmodfncJCEtL7m1NY8Ki2g==
X-Received: by 10.28.202.6 with SMTP id a6mr6554688wmg.95.1516320055950;
        Thu, 18 Jan 2018 16:00:55 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/11] fetch tests: add a tag to be deleted to the pruning tests
Date:   Fri, 19 Jan 2018 00:00:19 +0000
Message-Id: <20180119000027.28898-4-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
In-Reply-To: <87po6ahx87.fsf@evledraar.gmail.com>
References: <87po6ahx87.fsf@evledraar.gmail.com>
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

