Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B231F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeBHQUj (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:39 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38487 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeBHQU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:29 -0500
Received: by mail-wr0-f195.google.com with SMTP id t94so5305007wrc.5
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vL7Qn6QcNFCJQVJLbge3tpJXcYdxBCUpOp3myXqddjM=;
        b=dnfFdTFR/UcaCKW9jFHh0NvSsTNtR6JBO4fNtHRUxgSMh7SsXPTRua29QZwy7jMGhf
         BXpf2KRp3WsouKxHRgcAMvPDQDe9Dc1phZpnTpJJHOneYgm4426HQKEXCm0Bj6Q8Ewwf
         OoydLKVtoG3gRg7vq8F4uM6qNhbWMcTQz/zjNVhWX0gV6QzntnxMxhps8tMHODkzAzRG
         p4JfCQd0D/XzAjVPLXPP8VISTkKf1ca3H1Z5KUm+i11UrN2gMiS7cOpxcQyppaeTyfQY
         kThunfleHNFvNfVEfWYrpskjZ+iz8uqr01ypIbzeMAP166cLD1z2Jt7o6Ulz9/rU3BiW
         y16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vL7Qn6QcNFCJQVJLbge3tpJXcYdxBCUpOp3myXqddjM=;
        b=PojqYyo75qjVb7wlJ+/R7vgnS7AkDgFt5abPUU4KRiLFE3RTZPeW7zCw/ITxG+9x5M
         lYyx8ApyT7uSYF4vP095n29obuaKET7QZJdaGA+TKLVsq23M/Px+kN+4VeqwgThI/3/1
         DrKIg9QT9jEZHYYGAq1WbDHj9/ZGVQDpL0bt/fAtoG8/pajNg0uVIpDmOx8NWe73i8n1
         vdgx/vOLqDgq7tFww2zDjwdRgdVUaaiIparHjGNmIeZ5HK5NA1lQzdB8jMPQPk3vRc02
         FezTy1+HeY4fyChzqGgiY//Fj7gn0TCKAikMCSqXuEipEKrKkMB965WSQtJPWNHCsCCq
         GNWg==
X-Gm-Message-State: APf1xPCJuEci7Ny0gL3PjAQxciZ1YUmEbgdoUiGzcLC1FJos36eqlBiH
        g1yNNvD3SIvdyEg5fskGeN+oJ9AQ
X-Google-Smtp-Source: AH8x224sNOEcZ6a1uv71OqSZUOFl/54CpB86dyozA0DClD//uSS7S6aCRw0zjr3FQoYL8EP5gTxEvQ==
X-Received: by 10.223.195.92 with SMTP id e28mr1423694wrg.8.1518106827407;
        Thu, 08 Feb 2018 08:20:27 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:26 -0800 (PST)
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
Subject: [PATCH v2 15/17] fetch tests: add scaffolding for the new fetch.pruneTags
Date:   Thu,  8 Feb 2018 16:19:34 +0000
Message-Id: <20180208161936.8196-16-avarab@gmail.com>
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

The fetch.pruneTags configuration doesn't exist yet, but will be added
in a subsequent commit. Since testing for it requires adding new
parameters to the test_configured_prune function it's easier to review
this patch first to assert that no functional changes are introduced
yet.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 92 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 73ba83454f..501d15dd42 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -562,10 +562,12 @@ test_configured_prune () {
 test_configured_prune_type () {
 	fetch_prune=$1
 	remote_origin_prune=$2
-	expected_branch=$3
-	expected_tag=$4
-	cmdline=$5
-	mode=$6
+	fetch_prune_tags=$3
+	remote_origin_prune_tags=$4
+	expected_branch=$5
+	expected_tag=$6
+	cmdline=$7
+	mode=$8
 
 	if ! test -e prune-type-setup-done
 	then
@@ -593,14 +595,16 @@ test_configured_prune_type () {
 		cmdline="$new_cmdline"
 	fi
 
-	test_expect_success "$mode prune fetch.prune=$1 remote.origin.prune=$2${5:+ $5}; branch:$3 tag:$4" '
+	test_expect_success "$mode prune fetch.prune=$1 remote.origin.prune=$2 fetch.pruneTags=$3 remote.origin.pruneTags=$4${7:+ $7}; branch:$5 tag:$6" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		git tag -f newtag &&
 		(
 			cd one &&
 			test_unconfig fetch.prune &&
+			test_unconfig fetch.pruneTags &&
 			test_unconfig remote.origin.prune &&
+			test_unconfig remote.origin.pruneTags &&
 			git fetch '"$cmdline_setup"' &&
 			git rev-parse --verify refs/remotes/origin/newbranch &&
 			git rev-parse --verify refs/tags/newtag
@@ -615,7 +619,9 @@ test_configured_prune_type () {
 			cd one &&
 			git_fetch_c="" &&
 			set_config_tristate fetch.prune $fetch_prune &&
+			set_config_tristate fetch.pruneTags $fetch_prune_tags &&
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
+			set_config_tristate remote.origin.pruneTags $remote_origin_prune_tags &&
 
 			if test "$mode" != "link"
 			then
@@ -644,57 +650,59 @@ test_configured_prune_type () {
 
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
 	"--prune origin refs/tags/*:refs/tags/*"
-test_configured_prune unset unset pruned pruned \
+test_configured_prune unset unset unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
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
 	"--prune origin refs/tags/*:refs/tags/*"
-test_configured_prune false false pruned pruned \
+test_configured_prune false false unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
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
 	"--prune origin refs/tags/*:refs/tags/*"
-test_configured_prune true  true  pruned pruned \
+test_configured_prune true  true  unset unset pruned pruned \
 	"--prune origin refs/tags/*:refs/tags/* +refs/heads/*:refs/remotes/origin/*"
 
 test_expect_success 'all boundary commits are excluded' '
-- 
2.15.1.424.g9478a66081

