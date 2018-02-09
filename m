Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F341F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBIUdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:33:10 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56189 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752775AbeBIUcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:48 -0500
Received: by mail-wm0-f66.google.com with SMTP id 143so17480963wma.5
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=d9/64InZhDld6DTPTE1E9Clz6ymZ/ipvueDPkDSLCSJaBiyYmONUTfGkhEiLnRg/xx
         RORe3Q+y+rZEizjaQAM/3cRo69kr5uPmCElIoqsn28ARWuC/O7ti/DhrA+4me41brtiB
         MyBpwwNTa/LIHKQtkahBrQiW3iEjnBm65tTzf2n5eBi3WIrEwkPw7N4EE4dP5OfdxLzu
         taI7F8oCQu5K7nICNTbv7owHGqEEbPCU3/6Sp3RYFpCccViyUweC/kduQfap87LgwIY2
         hMcmI70qXsVISpEDU795v0BUQPl2KxOiR9BzrvCiyEZADwaSbYUy2kWmuTURkQ5gflCH
         RFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GnSeJiE6rtSKrAAjuFRoJn4LRzozN7VQmlIved8BCu0=;
        b=EME+uzElferrWAD8T/l6p0mx9NlGx4cQueDQ3pwOkZCUml0eYEGmT4QEueUz0liGTe
         moLUCY9kxf4ybx/Dq2AFfeFBU6v/JBT0BLvH9NRkbrFhUM15qjjm+uwOVRk4x6lF/i//
         3VCR2kqCGt80xwmEdiEtlz1ozjeGAw1E+e9hpD9wwRlTy2JL8AbFeTAbSUtxxYUAXUbH
         /Tb86glFEcy7OODYClPcAfbc9oo/8+Xu01GIyvzH96I5hlgdygWwquYR5k8fph+IzRai
         iBn9pJD0YJcvRWjX47+C6hL1Igm4+PaE65RYxQmac9PO3bJTizH04NpKp1efLbfqVcPM
         xDwQ==
X-Gm-Message-State: APf1xPDrWsd2oLOcXIgO3vq0vql0YaXJd6bkWpoXoSjyAW64U88ha/2Q
        InF/U7CBWgbPP698oqgBo3yvhl93
X-Google-Smtp-Source: AH8x226/7yGl4/eS9icya5HXG5yeYa7KH3dHG6HyQfXT+bjsksflXK+MiCS2PJiqUeCXhqezHUyvGw==
X-Received: by 10.28.113.150 with SMTP id d22mr2915954wmi.127.1518208366704;
        Fri, 09 Feb 2018 12:32:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:45 -0800 (PST)
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
Subject: [PATCH v5 07/17] fetch tests: add a tag to be deleted to the pruning tests
Date:   Fri,  9 Feb 2018 20:32:06 +0000
Message-Id: <20180209203216.11560-8-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180209203216.11560-1-avarab@gmail.com>
References: <20180209203216.11560-1-avarab@gmail.com>
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

