Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 991782090B
	for <e@80x24.org>; Tue, 19 Sep 2017 07:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdISHPv (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 03:15:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35927 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdISHPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 03:15:49 -0400
Received: by mail-pg0-f68.google.com with SMTP id d8so1588417pgt.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TK2JseSEMZGiN2FZRErEkf1jfq5fn9W9T3J0IRBPa1k=;
        b=HNCTDp5LTallFk9fRB2KkzSor0c8TD+UiNf2cWdpCaNGbZ+h4pg27eN2EUQCgLr4/S
         4rjFOwh39eHSve6R+J2oa4K4IfvE9ICXv7Usft3ruQR8hASiERf8Q+gz+EBsGpkaGf5r
         s/KMFPZGj77DNt0GS63nkMeVi5/fR1gLIgWwL6yvDlJoeYfgr7+XQYz1aSKGoIAJbCBO
         9OQ3eFGSgUGlJxcIw6iImfKmvQ+/sND8ekwTyD9hy0bDXOObz41Ui4b9wsZlF5YfRhzP
         4sty+McHlzNjKMGTbfwAcTHFZgyP1V7Le/RD31ugu6uxMUfz4koFVuX2D0VTsfujaYi0
         hmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TK2JseSEMZGiN2FZRErEkf1jfq5fn9W9T3J0IRBPa1k=;
        b=OLku2FmQJVFd1G/dQJuHGB8ltIgZNg2PMJOKWfYywjf5HfJ7x5f2OJmEkyE3g2OEbx
         uqmNiu87jOFyO7ZFpSkpV8b/v4kbM+GIduFT74RTBdb22Jf/hoN4XhpxmzBIGncLJYBn
         n7zAtxCBsm4h8/HH/NsQor3RISnUqtd1Lqs2CbjAmB3rZpLFJGaPqlYBwnHtcVRfYxwB
         mPiUypGyhQpeSkDb5BOkmFhpet0suoVmWq/35BAzc9yruDWpUdlkPpCax5CcIEASjBCT
         gI5air0J1ngZNkySGLNZXUvyhCBrXOXm++HEEsq8U/GTcL5eAPDb7UdyQffHh0l24+ZI
         WN3w==
X-Gm-Message-State: AHPjjUiVC9hmuMIc/YPifLYgCfC2lLWsMS35UbsuAsAzwGtktJ6D5vwX
        AXLdjyGPS82fLMzX3LEcTtC67wz+rVU=
X-Google-Smtp-Source: AOwi7QCEEr3/SgYD/LX7lmwXyznTE+hlZ4gUHnKiw8YdfyTjNuuxi2ONS5l7FoaSDlPW5sNao27U+g==
X-Received: by 10.98.25.71 with SMTP id 68mr438237pfz.65.1505805349115;
        Tue, 19 Sep 2017 00:15:49 -0700 (PDT)
Received: from glitch-pc.sce.com ([117.209.170.72])
        by smtp.gmail.com with ESMTPSA id d126sm1927863pgc.85.2017.09.19.00.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 00:15:48 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [RFC PATCH 2/5] branch: document the usage of certain parameters
Date:   Tue, 19 Sep 2017 12:45:22 +0530
Message-Id: <20170919071525.9404-3-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.930.g532ff9be2
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Documentation for a certain function was incomplete as it didn't say
what certain parameters were used for.

So, document them for the sake of completeness and easy reference.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 branch.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/branch.h b/branch.h
index b07788558..33b7f5d88 100644
--- a/branch.h
+++ b/branch.h
@@ -15,6 +15,11 @@
  *
  *   - reflog creates a reflog for the branch
  *
+ *   - if 'force' is true, clobber_head indicates whether the branch could be
+ *     the current branch; else it has no effect
+ *
+ *   - quiet suppresses tracking information
+ *
  *   - track causes the new branch to be configured to merge the remote branch
  *     that start_name is a tracking branch for (if any).
  */
-- 
2.14.1.1006.g90ad9a07c

