Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2962095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757479AbdCUNBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:32 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34679 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757469AbdCUNBP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:01:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so2778081wmg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sp8LW9q3z05OFAri/eSH/rNC0+hqTy1UfgSML4M8D7M=;
        b=BQXqFNb5QXdwA6ScwTOtNtuM8Pd0u7yGYmUo/cYVRU3Qg5+htdxqYF5O4js7yrwpp8
         jCtoPtCGnk4+EyKOtR8Szp8vMHxqFGRwOs9f4cXtRFFcaWyZdYWy5rBovGF42BHuvU70
         hfrG2tLhwFUOr+zzvJRpWV7Rt4FIP9gJGV7MTbbj+PZREBHn5VVh5TjVaehKj38Z1G5p
         XRG+vUXVKYfO/cOQpgjqJwpRxvv6g0TKtP06vJ8tw9v3G0m+s2ifvZgfR8ZTm7Upfb6D
         RgI1MgN6SbeeUD9QbnHaF3M2lYUHXtXPfk7NDs83JkZdhA1wsKkTRYt/S5dCZAVlWZhi
         j8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sp8LW9q3z05OFAri/eSH/rNC0+hqTy1UfgSML4M8D7M=;
        b=HGEb5Blv+eYGyWqdmSFNkEGq7f7tV6UW+2ua2OwTbI881bTTXY8E7+/ron3O2ac1mk
         2BEuLaD+D6vsHgY8tFQD9dw4/n0Ge9Qa82VZJsQZ+S3GQgBb4CLiWAgHzneuAsVh7JdI
         NOwCoijEZQGvSQ9390Wh/L6rHppztAQZLB1p9YcEN/c/45W/+8ggY9Lnx8+4rqeznbJ4
         /uKwp125xA4lOaDeHOXsb9fFwHjyk+e+AwR8ZwTYkyHDwXl7obst2+luxtmhv1pyIM+2
         YnHfbZKxiDDU+ymp16V3YfF01O2xM4TB1u79DVkAnS2S06SbrOSfIxPy6D7nUybGjgk/
         qX8w==
X-Gm-Message-State: AFeK/H2UP22fA/Tj51G4C6dFlZIhUgVZtFuY3VxakCqQMuy+XFTzS0+K6pRBmY2HGb2njA==
X-Received: by 10.28.69.72 with SMTP id s69mr2839907wma.85.1490101263302;
        Tue, 21 Mar 2017 06:01:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:01:02 -0700 (PDT)
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
Subject: [PATCH v2 16/16] tag: add tests for --with and --without
Date:   Tue, 21 Mar 2017 12:59:01 +0000
Message-Id: <20170321125901.10652-17-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test suite to test for these synonyms for --contains and
--no-contains, respectively.

Before this change there were no tests for them at all. This doesn't
exhaustively test for them as well as their --contains and
--no-contains synonyms, but at least it's something.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7004-tag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 60b5cd8751..8cd611344f 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1596,7 +1596,7 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag --contains --no-contains
 '
 
-for option in --contains --no-contains --merged --no-merged --points-at
+for option in --contains --with --no-contains --without --merged --no-merged --points-at
 do
 	test_expect_success "mixing incompatible modes with $option is forbidden" "
 		test_must_fail git tag -d $option HEAD &&
-- 
2.11.0

