Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE92D1F404
	for <e@80x24.org>; Tue, 23 Jan 2018 22:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932260AbeAWWN5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 17:13:57 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45859 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932239AbeAWWNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 17:13:54 -0500
Received: by mail-wm0-f65.google.com with SMTP id i186so4736671wmi.4
        for <git@vger.kernel.org>; Tue, 23 Jan 2018 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=ZquU+AygzAlZhS09q+Bk7yfLuxGfBuoNH6+4nO5cqmbgyCtU7/QSYM6iwDuIyDjrLS
         wOHU/vkfNZ2uoSI7NC08DBgWZz0GnjsuMPOZTxsAKh96mMVN2KhQ/K+vHmi9GLXvoulo
         KwPxKUnAjGyXE+PI2JlHECD3VIJTdEHdUQJ/scN+5S9UQE6gwVY73d4h8XQpCvOFwcGS
         j2OH2TDiQipmtVC6aW+vs6hXipg2RJlYHaSvuKBYmeMUHCWA0Sh9wZSd1j1/jmQLOVjP
         iKarQWAwHH2DOIgMUcDqkl1cRWZQsTCJneoqFdJS1zMMaItScksQC+eYfiagu8AKFgWE
         +6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=qRIHqFfvNRSRBSbS53lv2p1C/Go2wOmrnBvM7bZphDnoWRnVksKTFH4fZlOsFZZ4xm
         LjBGenTPDXgUg5fLXHphaF0qCS4UfAa+9mHf2JlK2EQPQv/IAhhL+yxJiXTdvML2vPE2
         SAjW59elV7EwT3SD/wVYmyp0n7aV8DDux8Q8Sr7/djEVwZs2NHjiy5H3/sCMNIE1Y0Nc
         pdQO5H8uyzzRt/F70Uy/rZQG+r61nA/VtS3hBi3zNDLKxHL0L+HNtjOTzIb2ybMnublu
         R0j4Y780fZGhv6uy84ZxXpO0YBHg2BCz+RjktEdtsn5ceJrWWi+jq+oWkI/5sbeAkLJo
         6S+Q==
X-Gm-Message-State: AKwxytdO2RVE45e29kEf2F0/DmMCi/MQV6cbDusHOK4Bp8khXSZb7ONy
        bYeHbb4OLHkKGfkBrF6JyMmyYMCR
X-Google-Smtp-Source: AH8x224jW9qU71FJFVpqCol9P2x6PduoL1W+Rvs6ZNTzHlermcS0H0WJhjzcMuOigV11z5Mp/A58NQ==
X-Received: by 10.80.173.45 with SMTP id y42mr21416524edc.247.1516745632488;
        Tue, 23 Jan 2018 14:13:52 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id s5sm14321282eda.60.2018.01.23.14.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 14:13:51 -0800 (PST)
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
Subject: [PATCH v3 03/11] fetch tests: refactor in preparation for testing tag pruning
Date:   Tue, 23 Jan 2018 22:13:18 +0000
Message-Id: <20180123221326.28495-4-avarab@gmail.com>
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

