Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77DFC25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiHJPq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiHJPqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:46:23 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90721E24
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:22 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1168e046c85so8439559fac.13
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cJEODe1SqNaPDY+Mrs2e+uqqLwk5Xs04cQ39SgRR6zQ=;
        b=iPPIC4olh1W95qy/MnCt4s39IDpO8swN2U85DhHmQwyllghG/L/Qmq2rKqdrg7sEKv
         PS5om4LGDv5FPACBdCzaLEDSpgSJECP0jXKXHRNMOCJO359PsvA9Qq5NKlCmNkUeTkG7
         WLy1LVKb35tCi2r+3QbXnF3BJ0SpztqVedZlK631PTjadCij4clKD3Ay2VpN4ovzKCCf
         LMejdkMG3M9G5RF22op4LO3tTEfNeYp0dxDgDmiMvf8Wk1OlDJLRmH2eYgs/USmG2Y3C
         BTFjIb2jxpaxHTuMHkq9+iUJhgXpAc6dyEdj395qi8ZVu+bJvXKKqct4OhHG6kv/EmT5
         W+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cJEODe1SqNaPDY+Mrs2e+uqqLwk5Xs04cQ39SgRR6zQ=;
        b=lAbNXh7nDO21TyXDdFLEEAmqMwjWu6MhH+VLey91FF3Mhx3QHoscCWd1wBPI9ouSq4
         eI9VNDjHhipsIFvp100zOumcpeNUhAo2gPNhZguRJN+rv31jJsS1jAhT76eRorvkOQVW
         b/fHXNC+eQTBEGKuFgby3ifNebxUEmt5ic/89kFr2crKovo3XW/ktGTV158GsqMTXGiI
         D7ImyTob3t8D09rUtXBN8tfVSERt/1KrCQSnWBGpGXwIVwK+sLT6TcmDeM2ViNcasDp6
         0mjZJs6oKI3RrSx/yN9Jr8zifAYkylA4g/wJbl1zoGQuLFXcY0klnGiTm8r17uXEl7rR
         +QJw==
X-Gm-Message-State: ACgBeo1SQPP9WdtVc19xE5DaNbHJeeH/yylBWUQpQx4avP8G48AChlma
        7u7qajdpvsOHC+f9n99G5VC4+bTGdnQ=
X-Google-Smtp-Source: AA6agR5hhyYz2wjEBbLOjwy2XCdMbR7uCoPwQbo3uUPGirL1fQdKNtbkJs1k5PNYYQszObw18pYNDA==
X-Received: by 2002:a05:6870:d6a3:b0:10b:df7d:8243 with SMTP id z35-20020a056870d6a300b0010bdf7d8243mr1811156oap.68.1660146381642;
        Wed, 10 Aug 2022 08:46:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id a19-20020a056870619300b0010d4aba3339sm3826302oah.42.2022.08.10.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:46:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/7] mergetools: vimdiff: fix comment
Date:   Wed, 10 Aug 2022 10:46:12 -0500
Message-Id: <20220810154618.307275-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810154618.307275-1-felipe.contreras@gmail.com>
References: <20220810154618.307275-1-felipe.contreras@gmail.com>
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

