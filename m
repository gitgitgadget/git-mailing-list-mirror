Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631BD1F424
	for <e@80x24.org>; Sun, 21 Jan 2018 00:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756752AbeAUADW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 19:03:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43290 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756726AbeAUADV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 19:03:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id g1so9874919wmg.2
        for <git@vger.kernel.org>; Sat, 20 Jan 2018 16:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=DCbnCvcZS3iSR0Gn5essGlnALUbAREguK1KzC4gohD97J55GKQnWzSUQoYxNc65x+W
         gL4xn6pKbJ3uQu+gUlAZcWSK/dNBdQ5mAJiI6kYNg2ojG9eca5iDjSMtjPbbrQH5siSy
         kiMwgoyud8n71/Kb8klZo9/Mz0ceFzO7G7ud+8tzLpYxSUKJ/WbniI2lzrgl0Oqe6iVP
         2AocdkaLKhPlAFoJ/hKyD8eOzwetAPY5eBmrK3qC4a68Ihvjf7m2DO1TCIbrJ9To6v8w
         9JjHhWa6DkWgHxAZPtRxhwuRPFbEZpjm8AidIDyxfFkzZTow/cVc2X58fYZUkvPQQ0J1
         NbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=YpBmQkl961j5Vc52+0A63RTuJGDGy4NE5wA6VxeMtTpjk417qCqj6QLADfqMH+DxOr
         baz3QFJ3fmPTgyAk3dsWKGoDSBT4sCwyQFy4cVXWDmPvRSYsZJJwxx/g9cuYcJx+wrsf
         i9mSEajXzsbLrDoWmuSMpMdESpsZ2WIyX43OXxYvRV68BnlZwdS6b/vB2DGcOt0QTw7v
         T3g3+DhPO43HT9MnRrHLY+qcdURDflKfmraYNEq9RZPyhp4ZnElh+RcFZRQ1snT7o1tH
         WTWPQpRugRfbDcuWDA7dtC02vg3Rfclo8iuudoeq9s9ciOYQP8zAgcnJL7CKqD7u9Sol
         4IHw==
X-Gm-Message-State: AKwxytdUWZKPjtcG2dr+p5C4PpGib5M4VEPGM01nljvOwR9QOG0oa+Wo
        RMJhHY5GFWMuhNpF2XZRO52gmrM4
X-Google-Smtp-Source: AH8x226edzThg/jiDkm6pxny60WDuXBuOHOqN3+OnPEAsThYDFtmyCaZ2TwsXm5szPHP6dELz4/gXQ==
X-Received: by 10.28.51.12 with SMTP id z12mr1753877wmz.16.1516492999188;
        Sat, 20 Jan 2018 16:03:19 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v75sm18677641wrc.45.2018.01.20.16.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2018 16:03:17 -0800 (PST)
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
Subject: [PATCH v2 01/12] fetch tests: refactor in preparation for testing tag pruning
Date:   Sun, 21 Jan 2018 00:02:53 +0000
Message-Id: <20180121000304.32323-2-avarab@gmail.com>
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

