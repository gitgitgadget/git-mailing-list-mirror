Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1451F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932300AbeAWWOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:08 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:41825 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbeAWWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:14:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id f71so4765238wmf.0
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7sxCV7ImYrd0tZqEwP0g0lBP/8GdLt6ZVZcI5HPFsMg=;
        b=nJHSJJ7D71zngIp1huZsz7FEPMfP3d9woukAgut6F8UjHvZ18Dfg1Wby/H4oNhK1WU
         2MeLc68kh2vnWSyp4PJLj3MtnScz97FFwFwkFkftDFPND72e+AHPeqO7tSE0c/nw3EVw
         nYJG8144fI7v04VU28SrJekT7FVaO8moueAwavUHrcET0ZiT4QTvXj0X2w3z/mOB9bCi
         6rJpwXn/X9juckw0GF5kld8GJwjKsWDEljzgeJsvcRE7Qu4iiNFuVYrhlXGL2byqrTXo
         exeI6tx4N/CwuLOM3ayemxRY5OvRm6jzRfm12HGgezw9hR+cNykq8tjin0ISJmRs6JqF
         a5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7sxCV7ImYrd0tZqEwP0g0lBP/8GdLt6ZVZcI5HPFsMg=;
        b=kXsvrzeNU1FlVPxRrxnXx4g3+mQnX0597fh3wBOiAd0SkhSSS+mCFXQtrVtLvIX7ZW
         l5xhBRk5GWrPhLEDI93MnUjPCb3uayFuyUVJ3C/x/yMxreZc6Qby+wJFL/cFOHBfqChi
         VL1KOaWoufVqy5j0zFwVOJksBEKRv/AbERa+qF6Oz9nrkQL2jccQPH9Nb8rySdsGCmC0
         AktDTQBbhlFn8J0UZIGRmkxjZ3m5I/aZbseGW2OOvLM4YTeLqfVdXcUqAvxJHOcDM7ow
         FUPxco5XPig++NVrjUNfF4rqXQMF918HkJ4VfYfFF/R36yeblS493JUqDvy7wCnLxa8Z
         rvLQ==
X-Gm-Message-State: AKwxytfWlQtaOVC6xEah8SjCSsvduXkTRs8Z4ucnbUCEjgs+JwFlgoLa
        lfTTQCiaSshiqVNaKymfQvmEQCxH
X-Google-Smtp-Source: AH8x226przN6IA0YQNnK8RspUGUQCo5SuRcPj5Jr+/xUJlaDljZ8mG8qrRGDoMyJW8w4qd8B1O9Pog==
X-Received: by 10.80.173.163 with SMTP id a32mr1126674edd.114.1516745644782;
        Tue, 23 Jan 2018 14:14:04 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:14:03 -0800 (PST)
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
Subject: [PATCH v3 10/11] fetch tests: add scaffolding for the new fetch.pruneTags
Date:   Tue, 23 Jan 2018 22:13:25 +0000
Message-Id: <20180123221326.28495-11-avarab@gmail.com>
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
index e5e88ee474..840fd5ef02 100755
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
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2 fetch.pruneTags=$3 remote.origin.pruneTags=$4${7:+ $7}; branch:$5 tag:$6" '
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
 
 			git fetch $cmdline &&
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
 	"--prune origin +refs/tags/*:refs/tags/*"
-test_configured_prune unset unset pruned pruned \
+test_configured_prune unset unset unset unset pruned pruned \
 	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
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
 	"--prune origin +refs/tags/*:refs/tags/*"
-test_configured_prune false false pruned pruned \
+test_configured_prune false false unset unset pruned pruned \
 	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
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
 	"--prune origin +refs/tags/*:refs/tags/*"
-test_configured_prune true  true  pruned pruned \
+test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin +refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_expect_success 'all boundary commits are excluded' '
-- 
2.15.1.424.g9478a66081

