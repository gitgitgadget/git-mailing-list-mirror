Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8066A1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKLKih (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55799 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLKie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2517164wmb.5
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3dT5vldE1tZcMpAvBDoXj9cWhy9cI+NNGQtImbC7IY=;
        b=lKk5sjLKNAct5zAhYHtbAPF8PXutRAsSxrhsRxrPd6HpAfpGDbRooBxDnP62cCSqYT
         oiiP0Rl9sYN8tOI5SpQz0gOPZJZGN1yWXoRoWXUlPXH4NavfX5TuE2GH6hgJz2CXHIX0
         xUc2zIZ2AtyNbxd/GGmZElbuRrX3B4TvbwvdKgqR9WgMOdY/G6rh6I0OAGL0OaOU+AYg
         QVlTUht3l2Y6ODaEDOnLweIqgv3rMbxmX43t+kvamXitvs9hGnVY/yF8Xny5hdvBkJOp
         QQcEmJBHwSGOtEW2CAmW3YgDfs2p33A0yG6u8tJI+yJwkzl3NAzvj307YL9lGuP6T0t5
         cl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3dT5vldE1tZcMpAvBDoXj9cWhy9cI+NNGQtImbC7IY=;
        b=eRd/HEWhabv2uiBjce0wfpncBTqXLBIGu81VMfNTNFMtixjS0kXQvXFX8wR2dJT28C
         L0KpvlZeBzOXbCOCSNahuBnztIyJIHY++Qbx4ug3S3PBmVNtjmE6SeeUoGH5TCzM1bDd
         S4RCwERQP02hx8ALKmAz1memOFWpkV7VlnmfsIcBHjyGOfkLSmIjmC+fkv4ouFbT/WFn
         0pm8FVnWIkwjSrkD3CW2wYGVHwWYOjnseeF0+0XyJ5gofqZ+5kjld37Bp6TTn2bNkYSh
         iraQY/GgeJVBNYcVnlPSV2+RLp0OzFZA6KRco9BYVeJw5VWPwmbvLKEWlTK/Mz95nZ/h
         3Yjg==
X-Gm-Message-State: APjAAAUNwUcK0vDSCC+1wAPgapPvxEQGLB7aYo2cMkUG5XZa+hntZO+p
        RbetEyLax002l7M7xFWF21g=
X-Google-Smtp-Source: APXvYqzYUWqRP9efPhbNRrNKg3Co6PNbQvOZuzRJuAWrWbPRX8IYPGrg9dfPi5Pk0xbqkpKp7VVO+A==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr3397094wmc.130.1573555112325;
        Tue, 12 Nov 2019 02:38:32 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:31 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/13] t6120-describe: modernize the 'check_describe' helper
Date:   Tue, 12 Nov 2019 11:38:10 +0100
Message-Id: <20191112103821.30265-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20191112103821.30265-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'check_describe' helper function runs 'git describe' outside of
'test_expect_success' blocks, with extra hand-rolled code to record
and examine its exit code.

Update this helper and move the 'git decribe' invocation inside the
'test_expect_success' block.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 9b184179d1..a2988fa0c2 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -16,14 +16,12 @@ test_description='test describe'
 check_describe () {
 	expect="$1"
 	shift
-	R=$(git describe "$@" 2>err.actual)
-	S=$?
-	cat err.actual >&3
-	test_expect_success "describe $*" '
-	test $S = 0 &&
+	describe_opts="$@"
+	test_expect_success "describe $describe_opts" '
+	R=$(git describe $describe_opts 2>err.actual) &&
 	case "$R" in
 	$expect)	echo happy ;;
-	*)	echo "Oops - $R is not $expect";
+	*)	echo "Oops - $R is not $expect" &&
 		false ;;
 	esac
 	'
-- 
2.24.0.388.gde53c094ea

