Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74691F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBIUcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBIUcq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id r71so17611787wmd.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=MPznSrC/bF0BfsCnduZgqg8/5LBzji5daIJ39KcaZ2t2kQLAv9Rks0iFsoi/H0uasC
         Eur+CkmYHlt4KgQqimfKcYkzRMABVz7tmoRJP3lCN1kNsx6MiksnGJhcQekqNUiQwzxz
         ar+hDBErNlMYXNbMSCJOd6GwpWFu7Co7+ncd4iO/uxxxG121HaMEBBOgbk23YorqBSB3
         I+IJaaeSrXU4XI+XPjBjw7Tco7klfxhsR5MuoUAfzUnbGNrXdC+iS75L3Lw2sBnd9UlV
         uOT3Qj76/6zD0tO2V3o30UFrUgQjQSx6bPtX63E2EyuHdpP7g7gdCJnb3q27Nn2iRg5O
         0eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KrjRaUiI1hv7or3sWjtzYGNa1x09mBLA+Ct7/dtEyp8=;
        b=oJ36e9KbwsW8OMK/4KAFmbp24PGCIgUUUMP2MZM1YO7fHdz2RQwGue1jtkzK7jnGgt
         xlT3jcHYpJjzUq0+LqxB59DHTBR51UyXs6ZbUXGtQl2/v1sbTzEG2izYl9zT30UDbuIS
         OiLrS8UI6NvosUI8YABjvmJAGrhyGXYc0p37lpy8I0WuJ+Sr7nNAEM+ZLaki6yOIAOpw
         LOA28vPTmXREPYRBkC0VbOXcDnduNY/jPMYGBcunQvQLZxIBq//eD6pI0hJKsg3FakGI
         CU5/X8HxDBIksFdhalopn9WgfjYXWZBjA58ZQg0qGDioEf2XkfkfmBNtu6kYM0GGizVr
         3sVQ==
X-Gm-Message-State: APf1xPAN+GNB4VQBXRJtKHVHC/E7vTgRdkQXQDpApvg/8bymo+b9jjjz
        LH+piXy8YpsZakjFgC4l4W55iYyn
X-Google-Smtp-Source: AH8x2263S4bAXzw22JeP0q1pKUIQuOMylXZFN/5NOWDxy5WccaTtdfQ7VspSlPYO2Wh93oWQhUlApA==
X-Received: by 10.28.31.212 with SMTP id f203mr2766827wmf.122.1518208364846;
        Fri, 09 Feb 2018 12:32:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:43 -0800 (PST)
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
Subject: [PATCH v5 06/17] fetch tests: re-arrange arguments for future readability
Date:   Fri,  9 Feb 2018 20:32:05 +0000
Message-Id: <20180209203216.11560-7-avarab@gmail.com>
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

