Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04FA20958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbdCWNGf (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35305 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934500AbdCWNGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so16562697wmb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=iaQWsA1i+uzi0I+fXgc+sCRNq184VqowbTpwnsinEM8BJP8DQRCzqorT4+tPoFmqnP
         rPOKF88DymW7csmhUihYZQkYJGbXuhF2EGAdpVIel77Kgd+bixKTDoIY7I8H3Z2dpr8s
         KcC/bS4OZSWGNcOGpdM/ZCdHdK/kRBPlTyCiKpFEn8KGb+1tyDjhJdG4ZTTNulHN7fH7
         3r84KbyyDez+1G/NoDPfmoVI4sJZlR47D/OLiHtgAaKE+3+15ouiSIwgl8kc3bPwLkIV
         OaVrodbQKPHp10M4PmdHomyVEGy9QOtKsxeT3CoBj8hXOYndWN9VgjNQ9DBhkHO0bgkP
         IMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZQ9EnPrJxLVxOIZln/9aaWXxOpw4zBUMsN8qH8TARk=;
        b=A6yRvbCKMKWMCG4U50OZA55SrIh/g+MnrlXjo3kASNmyy+FIFRFEQJfb4XdMqcKAUD
         TyXCWdoHsdz8bWf/SYfegOy4drvv3P16yKG/OYEuTsfmK5YOTiJsNPO8W6KnBXaRa3Rg
         KEcQYKVhSLvnC9bEQXqYKc8yr11aXtq/F8QTDnSuWhRk/tky1WKI5WwsRZ1dbJIgbdLV
         /DX79qYVlMkImUiRTRu4dCdgMkTxeJTVsUkRb4H7kVT1F2yRIHptqRcbQ7reTv7anTjE
         C/MJ65+jw1C7HPgJbPnCp9bgI2jtR5pxANysRoG9ysWPDI6Xjab1yTy6fO4yoe0Kx85e
         WvUg==
X-Gm-Message-State: AFeK/H2FAZH84AE/4Mn8uI+XYwetHJFRrE0FR3P0RDB/uSaSu1oW1FPl8RHk729DPpQa9w==
X-Received: by 10.28.141.201 with SMTP id p192mr13663927wmd.66.1490274390465;
        Thu, 23 Mar 2017 06:06:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 06/16] tag: remove a TODO item from the test suite
Date:   Thu, 23 Mar 2017 13:05:19 +0000
Message-Id: <20170323130529.11361-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test for "git tag -l" to not have an associated TODO
comment saying that it should return non-zero if there's no tags.

This was added in commit ef5a6fb597 ("Add test-script for git-tag",
2007-06-28) when the tests for "tag" were initially added, but at this
point changing this would be inconsistent with how "git tag" is a
synonym for "git tag -l", and would needlessly break external code
that relies on this porcelain command.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3439913488..830eff948e 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -16,7 +16,6 @@ tag_exists () {
 	git show-ref --quiet --verify refs/tags/"$1"
 }
 
-# todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success 'listing all tags in an empty tree should succeed' '
 	git tag -l &&
 	git tag
@@ -136,7 +135,6 @@ test_expect_success \
 	'listing a tag using a matching pattern should output that tag' \
 	'test $(git tag -l mytag) = mytag'
 
-# todo: git tag -l now returns always zero, when fixed, change this test
 test_expect_success \
 	'listing tags using a non-matching pattern should suceed' \
 	'git tag -l xxx'
-- 
2.11.0

