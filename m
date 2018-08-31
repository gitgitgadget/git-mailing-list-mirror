Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61BD1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIAAT1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeIAAT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so12249521wrb.8
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qX1VWsBl85J2GPk5z/LxnHwdtss2j2nQbDcbyN4MsoI=;
        b=XsdwnhGIkQmPSt+WRcx+d8hd685DU7F658dHID+G5phHS/9O7aR0+mbqBRB2JtJ4wW
         VwZHIACXv8e6B1neSmjSTpftiuYlSpdKgKW8CT36dNURtuGdiizNdKZNoBop9DdNhdd0
         U3C+2k9+zcsFtZLk2okpsIrfp16mRvmcB/JPrwZlMtY5/LwIpRrfwi6apNZNZL3usBxy
         Ryam8JtDavhxmUfR9N4RZvKD5kD+Rz1DuM4bRKn6GFMl+cQqKsCCqmq/rIc21Q/Bnz3c
         mwnUtoRtZwe9tkAZ+ZA5q3cKfr4a+tTghni07hO9iqihAqNOOPlJpMKO9Y3ogNEnlL2R
         A/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qX1VWsBl85J2GPk5z/LxnHwdtss2j2nQbDcbyN4MsoI=;
        b=OyrpYvfugIr1yWCRLI9MOZ9T4CTE/pDFNfEcV859WbChyVokrYweCVnVML2S+G0pua
         gn8lcYAKKHFEK/voGd5qJEE0QGHlXkFmrYrbUY2ZuVMIV1FzwIh1Yvf8i2SIkosPsPIP
         PofEjpt/XOwdqFxrkYd+b9U/zyN6RBMOhQ4oiDOt4aP2sSOe4Ac7AJq3E9q2onPv+8JL
         tS+RmbQwjLPSkcdRmvAQqPCk+k9Xifnu+AukRAF0d6r72Sls7j0w2cimCXmVyVCFpeAw
         td4rAfcIIqF/BQSL5qkUIhDBy10tFECbT7uVfF99A/YRk4QtolLWDBwslcrcfKz7JGR8
         MmKQ==
X-Gm-Message-State: APzg51Dr3llnN4lSTE+wDuIOnW2m0dcHGFOrWP0uyoXPAIkJ6EbHcb63
        Ov+VjWUWOH/JGRqKjQzeewPIDKEhndM=
X-Google-Smtp-Source: ANB0VdaBI5YS9u299p2KA26McXAa49fX/jLvoygj9D2D4BI/PStQ0mBBDz3gMJsC7wEMNdwWCm+vxQ==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12-v6mr11717353wrt.27.1535746222151;
        Fri, 31 Aug 2018 13:10:22 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 3/9] push tests: use spaces in interpolated string
Date:   Fri, 31 Aug 2018 20:09:58 +0000
Message-Id: <20180831201004.12087-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The quoted -m'msg' option would mean the same as -mmsg when passed
through the test_force_push_tag helper. Let's instead use a string
with spaces in it, to have a working example in case we need to pass
other whitespace-delimited arguments to git-tag.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 62d5059f92..8b67f08265 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1009,7 +1009,7 @@ test_force_push_tag () {
 }
 
 test_force_push_tag "lightweight tag" "-f"
-test_force_push_tag "annotated tag" "-f -a -m'msg'"
+test_force_push_tag "annotated tag" "-f -a -m'tag message'"
 
 test_expect_success 'push --porcelain' '
 	mk_empty testrepo &&
-- 
2.19.0.rc1.350.ge57e33dbd1

