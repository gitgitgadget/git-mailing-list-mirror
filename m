Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04E11F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeAWWOX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:14:23 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38114 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeAWWNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id 141so4825061wme.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=lob18MycgmrfP7WYjA6R7KKgD4V82AOfdZ613R5qa0qhYj0JPxyGiSdFYdUP0zFLnU
         wRN5s4bMncei1zsDQCFy71JVk3ms+Ra/OaIn7A2l65QvoSKJdp3vF1wrjvKtl1S+yEU5
         HgBN5QQPOdlaFOgrdhquGOoDeugOhjd4SWlSzGQHp0T7Hdn/EXquInmpMxIPC+EnOLqZ
         BE1psLaJt8ImQ9bEJ50lI4AiCME0WjEsql1NcjcDwcfvPHXqztmMSshQnye2Lpjf4AUY
         6DwRS6E2XeD5XRnWDIkaUscCrReFHQKZUyB0IRxDjYqmx7LCvGvEzFechda5ObAj2QFu
         uIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=AmRjD81CmQ2rpU+S+a27OMfo9D/2GnLzTWChep6uStomPiXfd65MeYemy2Dd442s7V
         yQc0cqErjsqQzwVEjWN7X0PLuTpcDf3ZkG5jllVzelrvrH3Rv7F3XqlNXmyBgNn+onDd
         AYeB58ZfKeQmpauaQY/COiVpqzzyna53Fgdnz9ilMGtzt9yb8onxMsiCtO160cAKRzAo
         gX1r4KGuBrPanZkfhtsJokvxKsxcTLnitVKbDKJAOVz5feTjB2IIO67BoI2QeAQiIqXf
         p3+b9dOw/n8aVwPDm6dq/NoMwiSDohRGCb6rUpcsLs06U1igWrAIX0u8n/rDb3EbnRDu
         MLog==
X-Gm-Message-State: AKwxytf2XD2UUPZbuTr1ozYY/v13/4xVfSkiYZG6qTyTDku9trRtAGR7
        tsGLBzWYxm5C72tXzGx5GP2OcdeO
X-Google-Smtp-Source: AH8x224LOVPlmYDlTQNSCmiiJ/FVmcosb1OnQpqqO1lia5vSTi474HMjZt0ulIdmXM9ofxL8PCQcPg==
X-Received: by 10.80.177.13 with SMTP id k13mr20896209edd.154.1516745634191;
        Tue, 23 Jan 2018 14:13:54 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:53 -0800 (PST)
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
Subject: [PATCH v3 04/11] fetch tests: re-arrange arguments for future readability
Date:   Tue, 23 Jan 2018 22:13:19 +0000
Message-Id: <20180123221326.28495-5-avarab@gmail.com>
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

