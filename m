Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E371F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfAPWmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49095 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733220AbfAPWml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:41 -0500
Received: by mail-pf1-f202.google.com with SMTP id t2so5801586pfj.15
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c5eafgfC+uPgjJecVEUZDa4WPYVYyn2cMXyiBBc6yK4=;
        b=tReU6hq8/+emf1+fKTQGCAfZi/H7+0SXid1S1hoWBnhKtSTeIINMaje+kU1xvmdJJh
         5GRytD8WV32ecBT9vlfxtsWvrYWG6lYNa1CNUdAVKWjNGc3TrFKYBzVQGO0eTydeASY7
         +77qyFr3ONH039y8in0Jo44iwve+jSNqQ/lQo1J7sVUVOz5tL9cPVDI2DhoEXUgCuoQ6
         bT0oZOoK78c5OKWT2YMnWkZu+5I59n3lgykm0xPa+NSBlUDfkPq5BmtTGYgToZL5CGXT
         l8t4exPTr0FF8+8VlKsI2YeD2bqLQQVhTIaenQkOnqI3wCE9oJ2CHZtQUBQQJon2p0av
         P/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c5eafgfC+uPgjJecVEUZDa4WPYVYyn2cMXyiBBc6yK4=;
        b=kGzeFtr0mjeB1g+0dMb7OdMFiT0LC71NTHPKexFwLu+JfGQY90BdKCTMjIn2Nu6C5W
         jdlUiuJ6QgwS87p7q5kSlCgWY5DLhtKymZyq7PDxVCgn/3t8mn1QrNoLhT5ZNoVif385
         0ygtuG9Y/m8gE9RZrb7s+xkFVCVtd5valpUHrGMaenCZqkvO3Is83qaC28kmwg+ksQGi
         uM4TxRFSFU9AViW8uRyM9RcRj6Gw1fotmmVw8DztaxKOugLStXrIKXtafTg2SdkT7BT1
         cppxhNeFU20GNZiKsPTQgco6ULRmiKRQqltwaStELCvGa3UjyRit+rCMMKWVAbc2n4Iw
         GSYA==
X-Gm-Message-State: AJcUukdzOhl1Zz2ovBJL+CGhZQyOfcp+5CSkadpodzAQR/pqx3f44MZo
        cB+vzSX6p1KbXQN8teX1JUfkPoA9SRh/T+f7MzXXvHWhohIKiqN2ZKcUYpe9vd/iiI6Ur+CuNbF
        nSVqeKOvLBYQMSDXt0WMkd9LRBSU3x9hwaU5pkDDZzVFA+MxLC7KPGmE57hV6exVeyxYZfnE5+e
        Eg
X-Google-Smtp-Source: ALg8bN4IEYbtn4fQFkNJ8IK63mgbXfcySFjSaRKufKmgLIt7Nibg8qNfWkFHarDTFHR1lft81sfusCys8Sy3yozxjD7a
X-Received: by 2002:a17:902:14cb:: with SMTP id y11mr3463350plg.42.1547678560968;
 Wed, 16 Jan 2019 14:42:40 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:15 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <b5c7322c03d6c26aadd5242eafab880ceac4db9b.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 7/8] t5552: compensate for v2 filtering ref adv.
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Protocol v2 filters the ref advertisement, but protocol v0 does not. A
test in t5552 uses the ref advertisement, so fix it to use protocol v0.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5552-skipping-fetch-negotiator.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
index 30857b84a8..8a14be51a1 100755
--- a/t/t5552-skipping-fetch-negotiator.sh
+++ b/t/t5552-skipping-fetch-negotiator.sh
@@ -127,7 +127,10 @@ test_expect_success 'use ref advertisement to filter out commits' '
 	# not need to send any ancestors of "c3", but we still need to send "c3"
 	# itself.
 	test_config -C client fetch.negotiationalgorithm skipping &&
-	trace_fetch client origin to_fetch &&
+
+	# The ref advertisement itself is filtered when protocol v2 is used, so
+	# use v0.
+	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
 	have_sent c5 c4^ c2side &&
 	have_not_sent c4 c4^^ c4^^^
 '
-- 
2.19.0.271.gfe8321ec05.dirty

