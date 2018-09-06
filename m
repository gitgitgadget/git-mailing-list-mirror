Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57161F404
	for <e@80x24.org>; Thu,  6 Sep 2018 02:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIFHVi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 03:21:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40624 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeIFHVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 03:21:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so9649955wrw.7
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T82e//Vxf1JHA47F3rOxa/m4mgJYM9Ctlm84aLecuGQ=;
        b=XWQ1SVffwbv9Q/nrRvNTDO9/RuWbwr5a+7fUFE5xpiNLXNHQsYJF2DQAt1U60/NfoS
         1kdiU6Eg7QbhaiqxGZ1ZgfpmJC8jVadehSEGQjtClZUwqgd4jqi6L3Z2UZ4sa1njF8gu
         bDLacdHg+uAvwjT6oq+FKFe80gjsVQDES1YrKB/wJ9W/qKocc7BDSwLj41dXyhqdSgDz
         JC8RaXOjtPDWsjZvPChqnl+rEa1rRmNU+bHvfBtbKwm3RiD22+p4O+fDDsUxHI4zBsvY
         JSg6KEDPStOkqnYG5F2vbmubZNsTMdx9ugeMehrN59vV2BFNFKWD8adEYQPosle/SVju
         8mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T82e//Vxf1JHA47F3rOxa/m4mgJYM9Ctlm84aLecuGQ=;
        b=uIwdfvyv4IFPTQYE47MitdtfVYhGUULyS4uuS+vLOBDlsPHQEkatD/TXbC4Q22dB7G
         qffJdqulvy1E888fpP/uLB2wO+nLlt7ueAbGuLI3PD9WNbJ/zb6LcG/xQCV2R5Rb2Bm2
         4aR8UeBaK12RwpLa1De8enh/XImzo+u/QG13jPxxUGKBtgyo+gPpVCI3WTFkp95FhH2c
         lwwa6PeZgWuicikiV7D+tcWEVDzvLrvtGhh5LfufLdW//algPA60CMyFjRQVe007xhd1
         3Ow9lAErZvDELwGSkMAengR/IFtkrrGjfrrXYHKBD6hi/vYpzRPF/6bsAjgtrzatFE3N
         ulEw==
X-Gm-Message-State: APzg51BGgZH1jZpc7m3SRBZxd67A2Hr1dy6gA/nZub5kREyORMCrqMOz
        iklqrjBJATczij8seQXNQp1E10CKPRk=
X-Google-Smtp-Source: ANB0Vda+ZDv7kSugbkUQbv4wC2FMc7Gs6Cjkr1XzESQxUNrZxZXWDC+CMpZ3A5Heo7P21fMtwPpB1g==
X-Received: by 2002:adf:8167:: with SMTP id 94-v6mr439369wrm.127.1536202110814;
        Wed, 05 Sep 2018 19:48:30 -0700 (PDT)
Received: from localhost.localdomain (x4db1b35b.dyn.telefonica.de. [77.177.179.91])
        by smtp.gmail.com with ESMTPSA id y10-v6sm3979999wrl.87.2018.09.05.19.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 19:48:29 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] t0090: disable GIT_TEST_SPLIT_INDEX for the test checking split index
Date:   Thu,  6 Sep 2018 04:48:07 +0200
Message-Id: <20180906024810.8074-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.188.g56c5ee2db1
In-Reply-To: <20180906024810.8074-1-szeder.dev@gmail.com>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test 'switching trees does not invalidate shared index' in
't0090-cache-tree.sh' is about verifying the behaviour of the split
index feature, therefore it should be in full control of when index
splitting is performed, like all the tests in 't1700-split-index.sh'.

Unset GIT_TEST_SPLIT_INDEX for this test to avoid unintended random
index splitting.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t0090-cache-tree.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 7de40141ca..65b5152b9b 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -242,14 +242,18 @@ test_expect_success 'no phantom error when switching trees' '
 	test_must_be_empty errors
 '
 
+
 test_expect_success 'switching trees does not invalidate shared index' '
-	git update-index --split-index &&
-	>split &&
-	git add split &&
-	test-tool dump-split-index .git/index | grep -v ^own >before &&
-	git commit -m "as-is" &&
-	test-tool dump-split-index .git/index | grep -v ^own >after &&
-	test_cmp before after
+	(
+		sane_unset GIT_TEST_SPLIT_INDEX &&
+		git update-index --split-index &&
+		>split &&
+		git add split &&
+		test-tool dump-split-index .git/index | grep -v ^own >before &&
+		git commit -m "as-is" &&
+		test-tool dump-split-index .git/index | grep -v ^own >after &&
+		test_cmp before after
+	)
 '
 
 test_done
-- 
2.19.0.rc0.188.g56c5ee2db1

