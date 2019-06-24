Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C21A1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfFXNDm (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:03:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33465 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfFXNDk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:03:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so6868518plo.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kpsTrKeejQKjX//MvqRRoECShM4Yo8nP4Pv1CD9O90=;
        b=R5bxCJgzR5Uzkw5ZD2T2v6nnQ6gooNWdQZcfjlLX88QLsU3sOYi/rtUW0r3kxrEdzM
         7PSvwnVLCBnMHZe51DEgIfhUv269ynBzWHxfHub9EL+5pnBELhVpuSIl/o3w8ABWLaHy
         6is/NIvKvaPH5+rbwmO5sIX19fJY6658GHka2WXH6QjUe2NNz4AHVnfzxu103npjJ2yh
         3JfSTsbEO1qYsFd9qF30CTm8fbj9h5ySwsEN3mSPZJYKV2jh+PX/x65ofPY0yyzdwTa5
         4jlJ4jLD48EuvhBJZ7w2ixZUMUkqfZUrBKt8soqAWuNGFTveIAo+LqdjKM2sfNlz+6l3
         Ji5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kpsTrKeejQKjX//MvqRRoECShM4Yo8nP4Pv1CD9O90=;
        b=c6Ah6qFl1jC1dgkWqVVGIbRGbMrS9ZWFYZp9fDQ6m8esiObwTSE/oUcPR2MTsgWhYo
         L2h01gRd8xjt3NgNdHFJL03mYWmaeF+S/eGMAW9GFyLiI/6Ggb/S2SFdV9z+FFy4A8Uc
         D3QC+EPLSJIF0bzpgEwbNEGzaboxMhs5Qbrv1bxoplXS+N7IEgmw98mRMu8cfnElx4pB
         GMRpT1q72QMv7DKCTERFlD/i1PjUFc+NctBtBh7Pm2ILmAw15GB1UFKSgqnul4G9tMyA
         hVi7VTT9HKta6elwl7VI3m1Z5oGlrfcMNbsC2Ia/aCpRYtufx6+0qBedBnwxa2wlbyxy
         pFjA==
X-Gm-Message-State: APjAAAU2FnEYsX0jGZ7+NTfZuPvRk6+l35vLWC7+BQiSl9vsw3pdYUpa
        loBF3AwHPArEz1V+6yJrzoYLYVrQ
X-Google-Smtp-Source: APXvYqy1aah0SnFDQCmX9WmQum+V/QpYm5sZY5/TxyQ6NuIV0mPLZuldjWcKn1HD/BYErREdZqBpPg==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr63663961plb.270.1561381419864;
        Mon, 24 Jun 2019 06:03:39 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id q144sm21115359pfc.103.2019.06.24.06.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:03:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Jun 2019 20:03:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/10] t3008: use the new SINGLE_CPU prereq
Date:   Mon, 24 Jun 2019 20:02:26 +0700
Message-Id: <20190624130226.17293-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190624130226.17293-1-pclouds@gmail.com>
References: <20190624130226.17293-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t3008-ls-files-lazy-init-name-hash.sh | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-lazy-init-name-hash.sh
index 64f047332b..7f918c05f6 100755
--- a/t/t3008-ls-files-lazy-init-name-hash.sh
+++ b/t/t3008-ls-files-lazy-init-name-hash.sh
@@ -4,15 +4,9 @@ test_description='Test the lazy init name hash with various folder structures'
 
 . ./test-lib.sh
 
-if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
-then
-	skip_all='skipping lazy-init tests, single cpu'
-	test_done
-fi
-
 LAZY_THREAD_COST=2000
 
-test_expect_success 'no buffer overflow in lazy_init_name_hash' '
+test_expect_success !SINGLE_CPU 'no buffer overflow in lazy_init_name_hash' '
 	(
 	    test_seq $LAZY_THREAD_COST | sed "s/^/a_/" &&
 	    echo b/b/b &&
-- 
2.22.0.rc0.322.g2b0371e29a

