Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0251FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932719AbeASAA4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:00:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38305 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932657AbeASAAx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:00:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id 141so226769wme.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=i5l72w25cqX4QVD4tesUsEV5mu4ztvP0qrT7uJbYbhslukbixB546LE1W23T33d2GQ
         oD5VYSTC+TQPzKNCOOp3yeVnDvwrMQHOemWvgaidFOXeKLtpamka2Ajjz7a3u38KApYF
         OSY4ekfkTrBCOmtSAruCov93+oWV6FW1LiYPUqEVmd5QbylsQztKgIk7hC56pGxp6a8S
         xco8+CgvasFvoN+eTxS6E1aW8JxBUPs/CJvT4O1Gs3cz0VQXeF2jw5s3pWrOITI/T5Po
         HY1x7WnIL+vQHbWrgu1XjLtZR4Z3SibeLG2kGkuQZgKqBP+GE0gf9VuJ/6lBTwlrQw0F
         oaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0ykLi6Ykto9nanussP1XeJEgg6neh4v8kPetyxp3Ij4=;
        b=CSr3SCnl5MLVsI4FYprtwseGRj2qXWQn4RKcpDFYZ78gLV/n2zfIuFxjr30mRlHp9m
         YlDNtdKzGj7M/N9ZhQeDUc64aJVC6YFSaWMm5pJilDo0Sbc7GLnw0TmfFionqeHKx9SK
         594Fi+xTjKpE2BF34ZxtBjVh4H1PU/i+H5j8L1b62NQa/iV9xFYXxW980Nhg13OiFvBP
         tTl+GOoEuou5o14ToVd8b+986NiA0m3/J/RWmKvh74fNpFVPkeI75H0ayPX0VaHEy+35
         d9+WtPKMMcf2/I2PWTRn5xp5jluVEQRBUkPqAIuc6cokvGUEvLGNW4c2lxRjskBpuNsu
         b+VQ==
X-Gm-Message-State: AKwxytcrzi37fwDluTLjMCikqpMYX2yjA+rKjaoHqZfliweu28qZKtdV
        bqtbpBn22v91A0FU1jz1tHkhzNjb
X-Google-Smtp-Source: ACJfBot3F1hcgJ2YrZoRj3LDtIIVL9aI559HQpvS/7HCZpahK7HbU44ul6krl9EZ7pj9avBEXIKNZQ==
X-Received: by 10.28.140.9 with SMTP id o9mr3109644wmd.28.1516320051832;
        Thu, 18 Jan 2018 16:00:51 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b48sm17706481wrd.69.2018.01.18.16.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:00:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/11] fetch tests: refactor in preparation for testing tag pruning
Date:   Fri, 19 Jan 2018 00:00:17 +0000
Message-Id: <20180119000027.28898-2-avarab@gmail.com>
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

