Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37041FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbeASABA (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:00 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34657 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeASAA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:00:56 -0500
Received: by mail-wr0-f193.google.com with SMTP id 36so24371970wrh.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=tpWqVHgIEgN1x8h+ocpQ0MDy6bu75/Rir9OfZBMYbR6CDlV9CF+MWnm75idA9fvJK7
         yYfKtzZ2zGXub+H54SvowFlW8C/HpMSe69nDYj68EjbmJrr+l15+i/eJEU8UfSJp2QS+
         Y9uHHsulu7Zy4YpMlsuUNgg3L0yI+9+/GtrRo32mXUMFIa1IV/xnYd7kZJwcI1RvGm9h
         sqW0rSHfGdlDvhcfMqI5PESPAe7/bL61GrfocJOnFkE8RC0sCfBPJmsEcXohM/bJl6N4
         fFlui7Pdm3QMN4N2tphLoLM4czZ8S2Z0iM5lrNf5Qi8MDtEgACoz2spMn2b/s4A8hcTI
         c3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=jZehIkL55AcxdHQ/rZYsJi5pYqqz09GSOsG50piEPvc7PIN34+MirAhYGRMvwroEoo
         zkrPWDeb5hvWijtu9OQreYrQiNavdHmzBcesd1YUiIvNSUqRUZdrorxX6gsGZ2IZuJOg
         PKIBG9H3/9ZKGUhvg6AoSoQ10EJSt4dihtF5uHy2t9qexLd3nYVDJ8fmNNSuXq5Ybc9c
         FEa4xKw1R9DqJhSSp5gd6ol8OUvKn+acwglF7bDg3YwQFm2FELAZCLEcHg6CcMzDY1tm
         ihsd+8FEEbktGKSV3MhBKNtnFJoJ+A8QKuolmEbiuCrM8nzuuN2d3vaZO82EwxYOTFad
         UAyQ==
X-Gm-Message-State: AKwxytcMZGr99Ooy9N5ZMglqAgClfj1PeYuFeKN9dzO7B/lvVjYinrg6
        YHhQQBAGXx9z7Vs8R2/Qc1JE0Mkd
X-Google-Smtp-Source: ACJfBot17C/9+lS9Z0j6CdQC7sBkxZcB8X20ru5Z2sbV5HE5ueImNNZ268V4uP4EglgmZplF133lRw==
X-Received: by 10.223.185.92 with SMTP id b28mr7458330wrg.196.1516320053921;
        Thu, 18 Jan 2018 16:00:53 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/11] fetch tests: arrange arguments for future readability
Date:   Fri, 19 Jan 2018 00:00:18 +0000
Message-Id: <20180119000027.28898-3-avarab@gmail.com>
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

