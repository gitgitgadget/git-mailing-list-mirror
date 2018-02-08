Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA08D1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBHQUN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:20:13 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35400 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeBHQUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:20:11 -0500
Received: by mail-wr0-f193.google.com with SMTP id w50so5317087wrc.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=MjQKUq1RQSuRmdLhKVWidYKjltN9v+8zy2h30xgu66dB10FYnVcRS/GQMC18M/VeZG
         SxcSp9xuTuEIlC2xpneMlj1T8so1KQNVndCI45lW94GWX/EANAw+QCfKgA9PmTjsLbvW
         ijRk8ASe/Ah3qHmNbYdByXBNxRuCR0eI9KY8T9ePKAcr37GgA3IRjzrdQZl6I7kA1EvJ
         vUL6Hh44eHNe+fksSCWV8j8pXjKQvYbPxUNVqGWVqKGLU98i+CEMsbmdzBSVyfJ9SBJX
         FwBc01BCMOUnlpayhP5k0V8TBxtGpePyWLWg5CuGRBv702/n+lgZsvOVPMNqlqsMaurG
         Expw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=oumBBaNj38QzP/w5mD80YvWHrXpL2HoqjwbJ1Ie9sTCvrhn5rHjP0dXYiM3bGnYBvq
         gQWE9AB/YMlNZxXiIiVqRSVg4lGquByTUgxQs+JMlt6atDlttU8au5R3G20i45p+6aYZ
         kfYi5H18Qlej7JEgWW47Jp9cEErzabHdjJPV09wMJjumf7SZ8lhXa2ftWjoXfBHVhsGm
         8RAnQAMrUP0I3UmQSouynmoLAma3cNXTLjZR9Ka+HIXyHwcESwo84WTE91g21EtRzD+2
         yH65N7Mf3z3xd68ndaJ4jI4CRtWfORlDHXnOrjra0Py4pKiNFXLdUKOYr3QC6YCOnxSh
         yTww==
X-Gm-Message-State: APf1xPBUxUEwyeGbZEQEdpCyopgXvmJSwkgzqy5JULXDBx6vhxrxAZUk
        Rz57wEVsfBY8hWdZZRdTLrOcubCD
X-Google-Smtp-Source: AH8x224c2wxa0hJOVT5Y9n77fKOSp8XZQI+CTOQxrXukbpCaW1cRujAumL8frAzxOGD10EJIfZIpZw==
X-Received: by 10.223.134.68 with SMTP id 4mr1297365wrw.218.1518106810419;
        Thu, 08 Feb 2018 08:20:10 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m1sm332532wrb.78.2018.02.08.08.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 08:20:09 -0800 (PST)
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
Subject: [PATCH v2 05/17] fetch tests: refactor in preparation for testing tag pruning
Date:   Thu,  8 Feb 2018 16:19:24 +0000
Message-Id: <20180208161936.8196-6-avarab@gmail.com>
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

In a subsequent commit this function will learn to test for tag
pruning, prepare for that by making space for more variables, and
making it clear that "expected" here refers to branches.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5510-fetch.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 668c54be41..11da97f9b7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -549,9 +549,12 @@ set_config_tristate () {
 }
 
 test_configured_prune () {
-	fetch_prune=$1 remote_origin_prune=$2 cmdline=$3 expected=$4
+	fetch_prune=$1
+	remote_origin_prune=$2
+	cmdline=$3
+	expected_branch=$4
 
-	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${3:+ $3}; $4" '
+	test_expect_success "prune fetch.prune=$1 remote.origin.prune=$2${3:+ $3}; branch:$4" '
 		# make sure a newbranch is there in . and also in one
 		git branch -f newbranch &&
 		(
@@ -572,7 +575,7 @@ test_configured_prune () {
 			set_config_tristate remote.origin.prune $remote_origin_prune &&
 
 			git fetch $cmdline &&
-			case "$expected" in
+			case "$expected_branch" in
 			pruned)
 				test_must_fail git rev-parse --verify refs/remotes/origin/newbranch
 				;;
-- 
2.15.1.424.g9478a66081

