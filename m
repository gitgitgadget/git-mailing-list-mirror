Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 063861F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeAUAEB (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:04:01 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36178 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932382AbeAUAD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:58 -0500
Received: by mail-wr0-f193.google.com with SMTP id d9so4833510wre.3
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wPQpS5SDvhtvA/627jogjNl5srDHYqScQP4FDFdOIcs=;
        b=qAtHwQYjq2IDU27m+ECGnJTgyBOEXvXPcEQYAveMK16R5HvZLS6ByZAdvBla056R1b
         bKKgnC0lLJNOHhKgUvmw/YWKJnvKlRtzMaeh6QndBrcTjAYstam1fcLpqO2bMcmUEfTN
         AsPQTF79qHG0ZL5nvDz00EPgpEQ0DuJULgqfXn0+ntxa1rGXySpEwPEI/qJuxKY/J8hA
         yhqAiP7pzlvdYfLei6+pA8NxrB1inKySaQ0Bijw+g0MQZnGhMXQGFPHoFeSXL58rk1qc
         lLTNKD3/z3Dl8f0jpyBoys3QqyWQc0gA+g0025wPYFY27cVJs7DzkNT4pA0CKAzJ0+gV
         ZDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wPQpS5SDvhtvA/627jogjNl5srDHYqScQP4FDFdOIcs=;
        b=Bt9mvrEqq9i+HmYVe+TGnHKgvCLMyWEdmhG7jOwYTQNFGoH2D5AhbXql2G0kZKgSIE
         jQCeWypBO2RbNCC/3Elpk85FsRTvJ0gOrWLhkToX6h8ouNfp0ZbENNqg05Yb/yocRCzN
         XetTCQTgXFafn1tnrLiZqgQhxLNnLSMI9xe7DCWzlyCEEC2KkIv5npU5hiDpuvZ/BNjR
         D9GK9AO2EozNptSYxLGwgN6QBJYPf8wqLnPEMTiT14LUP6pa5Gl0wzmYY/ZjxovSV2UO
         IPHozwBS1cJFVK6tRYFiqVB4CqUXXX101WNmHFdOqlFlutH+L9lOD36iiVY5pK2nkFh9
         Ezqg==
X-Gm-Message-State: AKwxytfsfPnM4++9lHuSfa7ZHsYiPCzFlj1FbIeOtvyV7rOnLiH27s2K
        TOPHJ1AXJWJWV+2/7IRoE/bEaD94
X-Google-Smtp-Source: AH8x226faNeHJNXGc4yZCJewwQwT5Cj9R087/EYKsRD5dH7OyD5GuTLzi0SN5uMu3H5dSpjq5rDvPQ==
X-Received: by 10.223.161.12 with SMTP id o12mr2754826wro.243.1516493036301;
        Sat, 20 Jan 2018 16:03:56 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:54 -0800 (PST)
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
Subject: [PATCH v2 11/12] fetch tests: add scaffolding for the new fetch.pruneTags
Date:   Sun, 21 Jan 2018 00:03:03 +0000
Message-Id: <20180121000304.32323-12-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180121000304.32323-1-avarab@gmail.com>
References: <20180121000304.32323-1-avarab@gmail.com>
In-Reply-To: <20180119000027.28898-1-avarab@gmail.com>
References: <20180119000027.28898-1-avarab@gmail.com>
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
index 576c2598c9..a1abea7e3f 100755
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

