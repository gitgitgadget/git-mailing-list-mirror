Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B421FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeASABY (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:24 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45774 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932855AbeASABM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so210775wmi.4
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cxvuYMF0bBNKdAm9by3DgNYlL9RhE9dXI33ZRSmlVj8=;
        b=bNKIEvmV2MeTWZxYw+aiLrGEVir/KeCIxP2QPORILvRE5Fj7XH2rhef9NyCXbL0pTy
         gN7CylcXV6ioSUj6YcLAnRLdZ3ixRcU33NZ8PulCk1pdvL41lFaZzZFtrLGY8lTjHr4d
         UfzI3g1zrfIZmvyOvYYh1lPj2T/eFlDPGueNO5cMNHeaKO0Nm9T8Qi+vzr+/muLCAlAm
         WeYi6pVE6tmUuzN6dEFJjsBSksNOGT0Zzt6FJY5xvhL585v0ULS/G7tiZsTAFm8evJQf
         pxJGEa9ga5r5uOIzDfDPAhAWJ02CDJn5GQaEcXFWiIRAOgI7wt78JMc+4fG8lUXSJa5z
         VfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cxvuYMF0bBNKdAm9by3DgNYlL9RhE9dXI33ZRSmlVj8=;
        b=OL/Xbm7i2La3xObXvlI1L3wZbjSrt38PvOWh84UQCAvWyJHFMZWkUGsXWvHQkwA6pF
         htSv/lHua2mjQsNXLnGCajC4PYYTwgmeg/Zk+NM1b8Sw9Mb7e2v0Bvm2Y5kcwAihQK8/
         4KJEXc0qOIu/2q5xrix8KjmPeHakd3nHUFiUmuydTORp8/DspEMsV8rb6nLBClPNmbrN
         SIzwrk6PvWln1eFykDgxCegAj9c5YPUwMyuLelbjWfuSkywhETZnK2aaxE6k2IZ6A9Wv
         3wDlf0bfkpadLQqz8pLiOI+HFNfuepYO+32ETe5alV+g2k/pq7aiLfAyXYEumFUiAlbC
         annQ==
X-Gm-Message-State: AKwxytcDc8+8jMGk688ar+5t4zRzEqE6pIlVz6cr5KIYaIVnwT98cb8F
        BeoesHYgNplyE69b8AH30/L3jIvW
X-Google-Smtp-Source: ACJfBou6EsWAAiQ74f8ldfsvsyasLrqXImvKz7tldeeAuFQQlG2JE8T0U8wENRRGqzopDbQfZOzDog==
X-Received: by 10.28.173.19 with SMTP id w19mr6915919wme.114.1516320070176;
        Thu, 18 Jan 2018 16:01:10 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:01:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 10/11] fetch tests: add scaffolding for the new fetch.pruneTags
Date:   Fri, 19 Jan 2018 00:00:26 +0000
Message-Id: <20180119000027.28898-11-avarab@gmail.com>
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

The fetch.pruneTags configuration doesn't exist yet, but will be added
in a subsequent commit. Since testing for it requires adding new
parameters to the test_configured_prune function it's easier to review
this patch first to assert that no functional changes are introduced
yet.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 90 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 49 insertions(+), 41 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 576c2598c9..18280df4fc 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -551,18 +551,22 @@ set_config_tristate () {
 test_configured_prune () {
 	fetch_prune=$1
 	remote_origin_prune=$2
-	expected_branch=$3
-	expected_tag=$4
-	cmdline=$5
+	fetch_prune_tags=$3
+	remote_origin_prune_tags=$4
+	expected_branch=$5
+	expected_tag=$6
+	cmdline=$7
 
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
+	test_expect_success "prune fetch.prune=$1 fetch.pruneTags=$2 remote.origin.prune=$3 remote.origin.prune=$4${7:+ $7}; branch:$5 tag:$6" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		git tag -f newtag &&
 		(
 			cd one &&
 			test_unconfig fetch.prune &&
+			test_unconfig fetch.pruneTags &&
 			test_unconfig remote.origin.prune &&
+			test_unconfig remote.origin.pruneTags &&
 			git fetch &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
@@ -576,7 +580,9 @@ test_configured_prune () {
 		(
 			cd one &&
 			set_config_tristate fetch.prune $fetch_prune &&
+			set_config_tristate fetch.pruneTags $fetch_prune_tags &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
+			set_config_tristate remote.origin.pruneTags $remote_origin_prune_tags &&
 
 			git fetch '"$cmdline"' &&
 			case "$expected_branch" in
@@ -601,57 +607,59 @@ test_configured_prune () {
 
 # $1 config: fetch.prune
 # $2 config: remote.<name>.prune
-# $3 expect: branch to be pruned?
-# $4 expect: tag to be pruned?
-# $5 git-fetch $cmdline:
+# $3 config: fetch.pruneTags
+# $4 config: remote.<name>.pruneTags
+# $5 expect: branch to be pruned?
+# $6 expect: tag to be pruned?
+# $7 git-fetch $cmdline:
 #
-#                     $1    $2    $3     $4     $5
-test_configured_prune unset unset kept   kept   ""
-test_configured_prune unset unset kept   kept   "--no-prune"
-test_configured_prune unset unset pruned kept   "--prune"
-test_configured_prune unset unset kept   pruned \
+#                     $1    $2    $3    $4    $5     $6     $7
+test_configured_prune unset unset unset unset kept   kept   ""
+test_configured_prune unset unset unset unset kept   kept   "--no-prune"
+test_configured_prune unset unset unset unset pruned kept   "--prune"
+test_configured_prune unset unset unset unset kept   pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*'"
-test_configured_prune unset unset pruned pruned \
+test_configured_prune unset unset unset unset pruned pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
-test_configured_prune false unset kept   kept   ""
-test_configured_prune false unset kept   kept   "--no-prune"
-test_configured_prune false unset pruned kept   "--prune"
+test_configured_prune false unset unset unset kept   kept   ""
+test_configured_prune false unset unset unset kept   kept   "--no-prune"
+test_configured_prune false unset unset unset pruned kept   "--prune"
 
-test_configured_prune true  unset pruned kept   ""
-test_configured_prune true  unset pruned kept   "--prune"
-test_configured_prune true  unset kept   kept   "--no-prune"
+test_configured_prune true  unset unset unset pruned kept   ""
+test_configured_prune true  unset unset unset pruned kept   "--prune"
+test_configured_prune true  unset unset unset kept   kept   "--no-prune"
 
-test_configured_prune unset false kept   kept   ""
-test_configured_prune unset false kept   kept   "--no-prune"
-test_configured_prune unset false pruned kept   "--prune"
+test_configured_prune unset false unset unset kept   kept   ""
+test_configured_prune unset false unset unset kept   kept   "--no-prune"
+test_configured_prune unset false unset unset pruned kept   "--prune"
 
-test_configured_prune false false kept   kept   ""
-test_configured_prune false false kept   kept   "--no-prune"
-test_configured_prune false false pruned kept   "--prune"
-test_configured_prune false false kept   pruned \
+test_configured_prune false false unset unset kept   kept   ""
+test_configured_prune false false unset unset kept   kept   "--no-prune"
+test_configured_prune false false unset unset pruned kept   "--prune"
+test_configured_prune false false unset unset kept   pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*'"
-test_configured_prune false false pruned pruned \
+test_configured_prune false false unset unset pruned pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
-test_configured_prune true  false kept   kept   ""
-test_configured_prune true  false pruned kept   "--prune"
-test_configured_prune true  false kept   kept   "--no-prune"
+test_configured_prune true  false unset unset kept   kept   ""
+test_configured_prune true  false unset unset pruned kept   "--prune"
+test_configured_prune true  false unset unset kept   kept   "--no-prune"
 
-test_configured_prune unset true  pruned kept   ""
-test_configured_prune unset true  kept   kept   "--no-prune"
-test_configured_prune unset true  pruned kept   "--prune"
+test_configured_prune unset true  unset unset pruned kept   ""
+test_configured_prune unset true  unset unset kept   kept   "--no-prune"
+test_configured_prune unset true  unset unset pruned kept   "--prune"
 
-test_configured_prune false true  pruned kept   ""
-test_configured_prune false true  kept   kept   "--no-prune"
-test_configured_prune false true  pruned kept   "--prune"
+test_configured_prune false true  unset unset pruned kept   ""
+test_configured_prune false true  unset unset kept   kept   "--no-prune"
+test_configured_prune false true  unset unset pruned kept   "--prune"
 
-test_configured_prune true  true  pruned kept   ""
-test_configured_prune true  true  pruned kept   "--prune"
-test_configured_prune true  true  kept   kept   "--no-prune"
-test_configured_prune true  true  kept   pruned \
+test_configured_prune true  true  unset unset pruned kept   ""
+test_configured_prune true  true  unset unset pruned kept   "--prune"
+test_configured_prune true  true  unset unset kept   kept   "--no-prune"
+test_configured_prune true  true  unset unset kept   pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*'"
-test_configured_prune true  true  pruned pruned \
+test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin 'refs/tags/*:refs/tags/*' '+refs/heads/*:refs/remotes/origin/*'"
 
 test_expect_success 'all boundary commits are excluded' '
-- 
2.15.1.424.g9478a66081

