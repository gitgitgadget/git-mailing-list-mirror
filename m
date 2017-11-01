Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1E620281
	for <e@80x24.org>; Wed,  1 Nov 2017 11:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754508AbdKAL4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 07:56:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:47309 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbdKAL4v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 07:56:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id r196so4310379wmf.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 04:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMvMgagNtVlqPlo/zOU3RRSfTCPWXsuStt/nO1W2m1s=;
        b=Ce8FnuXseGd4TT2NR26a4dbKacntoeg6V2oBez6ryJceXE818KW/1Q5qst4gSH/mbV
         OQcUlgYFtBE5Oj/h6TSNXL754C08rPNEr47D6u714OdeLKRT0OO1+5vdmhryFoR/GCOs
         ivAQw2oP5+932v7Dda6Ki5VYq6KiSwZuvh0TkZlnkBgr9jkL3UHcyGO1EBDditRCETx1
         Q3W5VXFxUh9Vm5rftRk/xVpM/wv+XNPiLTnqFJsIuAjPPf/1c5RT3ms33hcWCqMhPBxG
         zxhfQhqaiYH610mgFd35+z+2nkQUhjPrvN6/o7EbX2VHkav6TTU8AFgbHyU/LKMCufOY
         9Ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JMvMgagNtVlqPlo/zOU3RRSfTCPWXsuStt/nO1W2m1s=;
        b=sTAUoue770/N7lmRqxK+GE+fwEPHupRuJTNdlH9l7s2kfJLQyYIAvrudJpMXLkncuC
         XznAAxDXPY13JREFtkBWa9IJCmKcPTw0Els+MXOrZBNFtqK0EQdG/gecj3vAS8ZTE6/o
         aunsxDn2ZmH7HhiCbiM7ziecsdF8h7hqdU9OgcXnOvipKXMjIrWvISVW2MahYYI2Yh2u
         HmQYM8lpXebVFyAGONU7i3d/I5RxuB7gzC6BdZdky7cZ7yifSUlDKbS41JvxdOxYqllU
         Zl332I7PkMRPAmN4zHGE+/6/oQRlGn1vwAcvgbnvh6IRFPMDSFq71ZVtzHIFP1UMcWVt
         B6zw==
X-Gm-Message-State: AMCzsaWF2ioz2XWVEK3L0eQqYUl1i1mxHK+SRKfbXuhcMqJQMJSVu93G
        v8uvtZZFVFb/qklpXUaoefk=
X-Google-Smtp-Source: ABhQp+QAlHQClGa2/KUgWDnLvj93o/TCrIb+oidv4cOsKjukxAmK615P03/eDgc7aM34ZPtiFqr+lg==
X-Received: by 10.28.7.82 with SMTP id 79mr64422wmh.4.1509537410845;
        Wed, 01 Nov 2017 04:56:50 -0700 (PDT)
Received: from localhost.localdomain (x590d9c13.dyn.telefonica.de. [89.13.156.19])
        by smtp.gmail.com with ESMTPSA id m37sm873346wrm.4.2017.11.01.04.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 04:56:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: don't build Git for the static analysis job
Date:   Wed,  1 Nov 2017 12:56:44 +0100
Message-Id: <20171101115644.15213-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.67.gb67a46776
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The static analysis job on Travis CI builds Git ever since it was
introduced in d8245bb3f (travis-ci: add static analysis build job to
run coccicheck, 2017-04-11).  However, Coccinelle, the only static
analysis tool in use, only needs Git's source code to work and it
doesn't care about built Git binaries at all.

Spare some of Travis CI's resources and don't build Git for the static
analysis job unnecessarily.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index fead995ed..281f101f3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -71,7 +71,7 @@ matrix:
           packages:
           - coccinelle
       before_install:
-      # "before_script" that builds Git is inherited from base job
+      before_script:
       script: ci/run-static-analysis.sh
       after_failure:
     - env: Documentation
-- 
2.15.0.67.gb67a46776

