Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C3C00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 00:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244667AbiHIAp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 20:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiHIApx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 20:45:53 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5F2607
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 17:45:52 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l188so12251088oia.4
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 17:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cJEODe1SqNaPDY+Mrs2e+uqqLwk5Xs04cQ39SgRR6zQ=;
        b=m9YgEBDqD2/xw7EdGXcRxmewCJes+4qLaZB2v7dkl6HRodMONvW9eDIgdA4ay9zeXi
         ifB0JAlP6glyKMd/y/XVvtPhxhSac1A/tpy33GPlY7ZtzVnhXmIXwN2PnKum/uXT/VQ9
         VGUmrXNnZ7Dmtaezx/JgOmeDE4qPFhyzx1Xh/TWnJLvCIM5AJTRyIXOFXFVDg5+8bTcH
         etx+DviBZN0SPaf7D65BwOVJqkzq+JEo0Lz+NFbAGmepYqvOyo7UP10lEc4MA/SN1P7e
         oWhfKZvONsi0ezRvN0WgVCosQfeEZe9B0xlmcwcEtZCIQXMofwN+U0WMNq9Az0BBLu+E
         m36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cJEODe1SqNaPDY+Mrs2e+uqqLwk5Xs04cQ39SgRR6zQ=;
        b=nvEAEpk93IUZMHGPbIrEAAm7lhq7m9M/9OVa0utzuFksErvCdpy0U9c81/GxomPClS
         bKEe/3FTHcFPRiuyRM5bIIu/WWIHqIKmu0NL93T1gGqknPFmrTBcrpYIqM637Ldb8HRi
         1iQTQFQZm4UAX16o+zoT5fePkDNPQlQ8QGHE0/Bux6gRmht2Pe94DBL3jLqoxP+vSm49
         3qgNwf4LGWE5G2HBnBxV6mNvsu16FR4FmktrKiEGVXXzUX3wHD1PFEk8oe9MO/xjsQY0
         TOw1xeYT5/4hBDSwhpCU9BL3smyMlS2pko9Lzzo5CInQOPryMaQLZwH0AEJTYMtqdsE7
         E18Q==
X-Gm-Message-State: ACgBeo2bops9/ZhZIXUKC9IFlbzRMjM8sHyu9WvKjceS2J89+hkSMiJv
        qmllZUBqpfrZre03iz+hZGD6mw0JpNQ=
X-Google-Smtp-Source: AA6agR74VQ8dSBl2GDMA1qWxRLarQ9wfZnofyDTG5AeF+o29doYBJaP32L+Xqp3qglaHNCPTo2lyRA==
X-Received: by 2002:a05:6808:16a1:b0:2f9:bfea:e5f3 with SMTP id bb33-20020a05680816a100b002f9bfeae5f3mr9239029oib.28.1660005951873;
        Mon, 08 Aug 2022 17:45:51 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:afaf:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 185-20020a4a0dc2000000b004359da266b4sm2549705oob.14.2022.08.08.17.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 17:45:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/7] mergetools: vimdiff: fix comment
Date:   Mon,  8 Aug 2022 19:45:43 -0500
Message-Id: <20220809004549.123020-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809004549.123020-1-felipe.contreras@gmail.com>
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the variable is wrong, and it can be set to anything, like
1.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 mergetools/vimdiff | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f770b8fe24..ea416adcaa 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -29,8 +29,8 @@
 ################################################################################
 
 debug_print () {
-	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF is set
-	# to "true"
+	# Send message to stderr if global variable GIT_MERGETOOL_VIMDIFF_DEBUG
+	# is set.
 
 	if test -n "$GIT_MERGETOOL_VIMDIFF_DEBUG"
 	then
-- 
2.37.1

