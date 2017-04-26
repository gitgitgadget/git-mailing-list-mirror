Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEB6207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032525AbdDZXMz (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:12:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34943 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032511AbdDZXMx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:12:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id d79so832314wmi.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HX6B4p3lG0AyC3+2Ld7CvQOn5PQ/svh77LDYkTwJ3Os=;
        b=GlwZ7Jhfgx8Whtqte5E9clh5DH+g/niMoVVY6iNc15vQYsZIpih/BAMLDYLZeaOkET
         FMIyXFMep4Yc1TM/tcAEmsIZMrgzk5QwVykFzKfGGzEwKVhjaOfrUUlNh8WKlKcZW9OO
         uIX+ZduEV+ilIyG0ahCkouyXn8gHv9mideJsDBOFsQXpsaH8dOwwYjred/Y3EgOz/Bvi
         zqyMLtl5/g3P1U9jcYEnBee5O2yHaoPCRF3y3LpPkjznarwYDP+6Lqrj5BtZs5bYxFsd
         QGcWu1wCBQl99ar9oz/LrF4U92b6O9EAWFmCujkosW0uCwD+sUYvHnrC6Fod5/ZS9zNa
         gPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HX6B4p3lG0AyC3+2Ld7CvQOn5PQ/svh77LDYkTwJ3Os=;
        b=nZvIcSxiBIMJ6xl7kgyV4r5Bq60X5ycdu2whSiHVkBlbMHLhm6wu+XRCtvRNuplt7O
         F5htN78OwoXsDUjoIwySuEdHC58yLHDw2J9eT7qlzpHX3p+EX/jnGxBoC+f/Zj24QPrL
         zQa+ZWAOlYqPfFTpxpeAqEbsdJBhZ+mz5IL3gCYeENnhDR2IImyAGkBq4NfBVG756wDb
         XNkueI1QE1Bd4ciUaf7j+RdS60CoFUbxcXrF/b02AwMMSpHtz7FwpzNRMf+d+I3JQ/KO
         un3BhAjNbaIaAevLbt1Fj5vTwFSStwjS638g1IcKAfe08Qc0/Dmos1BCEeymmVc2G6b1
         jOOw==
X-Gm-Message-State: AN3rC/5w6TJN+0WcjLb0x3RjmZBjO2h2OEOzMJncXpZa1v2h/Dxm6cc6
        tgSbEavYHSEIPg==
X-Received: by 10.28.46.143 with SMTP id u137mr132447wmu.56.1493248372150;
        Wed, 26 Apr 2017 16:12:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:12:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
Date:   Wed, 26 Apr 2017 23:12:32 +0000
Message-Id: <20170426231236.27219-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change occurrences "cd" followed by "fetch" on a single line to be on
two lines.

This is purely a stylistic change pointed out in code review for an
unrelated patch. Change the these tests use so new tests added later
using the more common style don't look out of place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5612-clone-refspec.sh | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 7ace2535c8..97c847fab6 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -59,7 +59,8 @@ test_expect_success 'setup' '
 
 test_expect_success 'by default all branches will be kept updated' '
 	(
-		cd dir_all && git fetch &&
+		cd dir_all &&
+		git fetch &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -71,7 +72,8 @@ test_expect_success 'by default all branches will be kept updated' '
 
 test_expect_success 'by default no tags will be kept updated' '
 	(
-		cd dir_all && git fetch &&
+		cd dir_all &&
+		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
@@ -80,7 +82,8 @@ test_expect_success 'by default no tags will be kept updated' '
 
 test_expect_success '--single-branch while HEAD pointing at master' '
 	(
-		cd dir_master && git fetch &&
+		cd dir_master &&
+		git fetch &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -92,7 +95,8 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 
 test_expect_success '--single-branch while HEAD pointing at side' '
 	(
-		cd dir_side && git fetch &&
+		cd dir_side &&
+		git fetch &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -104,7 +108,8 @@ test_expect_success '--single-branch while HEAD pointing at side' '
 
 test_expect_success '--single-branch with explicit --branch side' '
 	(
-		cd dir_side2 && git fetch &&
+		cd dir_side2 &&
+		git fetch &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
@@ -116,7 +121,8 @@ test_expect_success '--single-branch with explicit --branch side' '
 
 test_expect_success '--single-branch with explicit --branch with tag fetches updated tag' '
 	(
-		cd dir_tag && git fetch &&
+		cd dir_tag &&
+		git fetch &&
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
@@ -125,7 +131,8 @@ test_expect_success '--single-branch with explicit --branch with tag fetches upd
 
 test_expect_success '--single-branch with --mirror' '
 	(
-		cd dir_mirror && git fetch &&
+		cd dir_mirror &&
+		git fetch &&
 		git for-each-ref refs > ../actual
 	) &&
 	git for-each-ref refs >expect &&
@@ -134,7 +141,8 @@ test_expect_success '--single-branch with --mirror' '
 
 test_expect_success '--single-branch with explicit --branch and --mirror' '
 	(
-		cd dir_mirror_side && git fetch &&
+		cd dir_mirror_side &&
+		git fetch &&
 		git for-each-ref refs > ../actual
 	) &&
 	git for-each-ref refs >expect &&
@@ -143,7 +151,8 @@ test_expect_success '--single-branch with explicit --branch and --mirror' '
 
 test_expect_success '--single-branch with detached' '
 	(
-		cd dir_detached && git fetch &&
+		cd dir_detached &&
+		git fetch &&
 		git for-each-ref refs/remotes/origin |
 		sed -e "/HEAD$/d" \
 		    -e "s|/remotes/origin/|/heads/|" >../actual
-- 
2.11.0

