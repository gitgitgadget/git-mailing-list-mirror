Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788111F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756761AbeAUAD3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35127 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUAD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id g38so4828860wrd.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=Ycn1qXj7hOhyOkGc63aVvaJ5QjqCMLpP1TZDGNp/cv6vTteaNvwJ8/32xD4/iDSzMo
         USFWIAoV3KlrqfRuV4kwhzd5jEbaIa6JYAJ1FrRAKWVXUyrSt+vNo6MRh1qFBRRcDjLE
         H49V6XwpYH8qkTqy2HT1fJ38xsgfNaagchZZLlZ3RpiUuPs+WWgnqdEjrhSUOMeEoKaE
         vfCNZE+IDWoFD3w4bdpjcv5LQZDNxgmRB5VchE6Ij9hUSpRE9aro+BqUxrZCUz/XnD61
         6xrwpvUW38B699TO5jlMtL/jXiUfbyjQfUvRJaAhEO8WCWLzMXFli1kzCpa6dLDAsF9Y
         JJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=Uh2LMZOK0mdCpn63AWyCFVrX2TJtgUblB6bkqGgfS81t2TrhzlgMeAuZR+16Ed2Xs4
         NChLDUTzRMGJ7UR1HIbtwayxj7Vpf/9Fx9CPhuqjcYucLbiKFCpZS7KqLHn+ycXQANKQ
         q3cRwGkxS0MDUKHUFenDSBvOus8nFQQR7FusqN4do7L5+Mtw6eSbcfFtMhV/XL0/hTgw
         gNhBkoKpkZec8NVdqbrN7MyYMiDiOU+r30Z79rC6lXYiDlcckZGlRkWKnHApT4HjVeOD
         7CdOS5ScTUbAv1UcOYCQeQIKmWTeROl6bSbKltQtv3MHuEoV8z4UQZmxljHeWtN5Cazf
         nzXg==
X-Gm-Message-State: AKwxytecG5gU8HFQbsjI3WRthsuFcb4R+VWiEED71GVo1CpkD1EvEqQW
        dfkydRh7hbuP1zPjsNgUrTlXAZnz
X-Google-Smtp-Source: AH8x224un6MXNJSiEgsmjX+AE/d9pj66a8U8RLEEz1wTbpmB1ZVVHqdu5p9f2jCZ0ahlSdBbV/+G7A==
X-Received: by 10.223.136.150 with SMTP id f22mr2433760wrf.246.1516493005510;
        Sat, 20 Jan 2018 16:03:25 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:23 -0800 (PST)
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
Subject: [PATCH v2 02/12] fetch tests: arrange arguments for future readability
Date:   Sun, 21 Jan 2018 00:02:54 +0000
Message-Id: <20180121000304.32323-3-avarab@gmail.com>
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

Re-arrange the arguments to the test_configured_prune() function used
in this test to pass the arguments to --fetch last. A subsequent
change will test for more elaborate fetch arguments, including long
refspecs. It'll be more readable to be able to wrap those on a new
line of their own.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 82 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 11da97f9b7..ab8b25344d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -551,10 +551,10 @@ set_config_tristate () {
 test_configured_prune () {
 	fetch_prune=$1
 	remote_origin_prune=$2
-	cmdline=$3
-	expected_branch=$4
+	expected_branch=$3
+	cmdline=$4
 
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${3:+ $3}; branch:$4" '
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${4:+ $4}; branch:$3" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		(
@@ -587,41 +587,47 @@ test_configured_prune () {
 	'
 }
 
-test_configured_prune unset unset ""		kept
-test_configured_prune unset unset "--no-prune"	kept
-test_configured_prune unset unset "--prune"	pruned
-
-test_configured_prune false unset ""		kept
-test_configured_prune false unset "--no-prune"	kept
-test_configured_prune false unset "--prune"	pruned
-
-test_configured_prune true  unset ""		pruned
-test_configured_prune true  unset "--prune"	pruned
-test_configured_prune true  unset "--no-prune"	kept
-
-test_configured_prune unset false ""		kept
-test_configured_prune unset false "--no-prune"	kept
-test_configured_prune unset false "--prune"	pruned
-
-test_configured_prune false false ""		kept
-test_configured_prune false false "--no-prune"	kept
-test_configured_prune false false "--prune"	pruned
-
-test_configured_prune true  false ""		kept
-test_configured_prune true  false "--prune"	pruned
-test_configured_prune true  false "--no-prune"	kept
-
-test_configured_prune unset true  ""		pruned
-test_configured_prune unset true  "--no-prune"	kept
-test_configured_prune unset true  "--prune"	pruned
-
-test_configured_prune false true  ""		pruned
-test_configured_prune false true  "--no-prune"	kept
-test_configured_prune false true  "--prune"	pruned
-
-test_configured_prune true  true  ""		pruned
-test_configured_prune true  true  "--prune"	pruned
-test_configured_prune true  true  "--no-prune"	kept
+# $1 config: fetch.prune
+# $2 config: remote.<name>.prune
+# $3 expect: branch to be pruned?
+# $4 git-fetch $cmdline:
+#
+#                     $1    $2    $3     $4
+test_configured_prune unset unset kept   ""
+test_configured_prune unset unset kept   "--no-prune"
+test_configured_prune unset unset pruned "--prune"
+
+test_configured_prune false unset kept   ""
+test_configured_prune false unset kept   "--no-prune"
+test_configured_prune false unset pruned "--prune"
+
+test_configured_prune true  unset pruned ""
+test_configured_prune true  unset pruned "--prune"
+test_configured_prune true  unset kept   "--no-prune"
+
+test_configured_prune unset false kept   ""
+test_configured_prune unset false kept   "--no-prune"
+test_configured_prune unset false pruned "--prune"
+
+test_configured_prune false false kept   ""
+test_configured_prune false false kept   "--no-prune"
+test_configured_prune false false pruned "--prune"
+
+test_configured_prune true  false kept   ""
+test_configured_prune true  false pruned "--prune"
+test_configured_prune true  false kept   "--no-prune"
+
+test_configured_prune unset true  pruned ""
+test_configured_prune unset true  kept   "--no-prune"
+test_configured_prune unset true  pruned "--prune"
+
+test_configured_prune false true  pruned ""
+test_configured_prune false true  kept   "--no-prune"
+test_configured_prune false true  pruned "--prune"
+
+test_configured_prune true  true  pruned ""
+test_configured_prune true  true  pruned "--prune"
+test_configured_prune true  true  kept   "--no-prune"
 
 test_expect_success 'all boundary commits are excluded' '
 	test_commit base &&
-- 
2.15.1.424.g9478a66081

