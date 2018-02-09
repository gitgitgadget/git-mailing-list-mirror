Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 910A21F404
	for <e@80x24.org>; Fri,  9 Feb 2018 20:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752780AbeBIUcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 15:32:48 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52811 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbeBIUco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 15:32:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id g1so17505199wmg.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=DoHE9N0wHBbURUZkqpzlI6V/i4dE/XBxI7MmL8DvLshedW5qCvk3CquuoPMW4NE4Ka
         2xcu7xRd3fHN9zaiD3L7+JNoDBu9hsyezGZELQI+LmhdgtOFdSopXlEaUlhw59azeepm
         K5RumvanLAnzCLAOT5Bi47VmSnK4fwjnrD3Z/vgf08reFEYM94GdGmsSx4APZDDq2/MI
         +v2idylVCmxMtX9tNq6T5aGyrCxyKhVYtIQZvFEnXVITyq0YeFSu2ESNwHxMusGKn1T/
         PZJSuXuMxxraQk/vFeJgKcZLfCdW8yNeDSnq1YXyft+SLGjpbeQpO3lfc2gz4R2FCiRe
         xDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=i16mcsWnkQoGkLQksEvo3iM8iTF6KzeZzRinTZNmgFaZ8pKGXwU/FGx46jlksN30vF
         ylnMt4RLLYB6NAINsqGIvX8foQHrOgHTQlTEjG4LWjKwMRbOoH/DDNKjdfEsfSM/LSk6
         0Y0poYbShHszzDgEN938O7Oa9WkjLnWKsUCfeNCOo4+y1C8iAKXJ9XZp3nyPHKQOdyyY
         +68FPGaaPm5jmWVZmN5AQU0qADyej716/LUBSlKtvFHf1bsu7+bdftW5GpDkJYvTeYix
         Snl7wF2ndDa68JZLL5rKS0IZb8p0BPR2Un1GIw47SS4ELsWaODU3PRnTJD3ojKgBsJqW
         jFZA==
X-Gm-Message-State: APf1xPCj1NNsoq/PTvr8a15VXosY9xUWxshpZ5uf1wJ93lNcMLcoSyGm
        OPbhOJvZrhVBK+iXDpN+lpBb50q0
X-Google-Smtp-Source: AH8x224CMcxRn8OQXnK9g3lVfA9QKdZKA1MMYCjTzBFfWTpCRqTcmu2HvvS9qAa57GT9VSIudunLKw==
X-Received: by 10.28.145.21 with SMTP id t21mr3491003wmd.136.1518208362948;
        Fri, 09 Feb 2018 12:32:42 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y90sm5750233wrc.24.2018.02.09.12.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 12:32:42 -0800 (PST)
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
Subject: [PATCH v5 05/17] fetch tests: refactor in preparation for testing tag pruning
Date:   Fri,  9 Feb 2018 20:32:04 +0000
Message-Id: <20180209203216.11560-6-avarab@gmail.com>
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

