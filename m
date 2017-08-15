Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6F03208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbdHOMxl (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 08:53:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34942 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbdHOMxi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 08:53:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id r77so1371392wmd.2
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CfirOHkYDbfOtMlxR8tdwKnxsW5v0JvL7K9lwCWk1YM=;
        b=HXym3WsKg3u4WielK2D6VD0AQFuu4hB5aEoSNX/gmz/BrYILYOV39VpZW1CGctENpz
         86J0dRvi7qYPb8TfD0Wj0oXW/dKaL+9AIGwBbNDmgX78H3R16Edgx9IqUoHT+glKalmv
         69pn87SKj4QA/mfI3zR/cT6BUKob9n2DxvrCYQlQvVLM5LKornIE4jzZ2QlwY9UfrKes
         6MH9w4uJPOOscDieUxxXsl5qqa1VUf+VTKAFE7BuChF2/1LDeII9O6mThUB/o8pMBLwe
         ooLefFqzh1Hb5t5FYDPGi4GNGwEW4RYEGPxyr3gHz2sQdt5+amUeY2HQIGjZMixZzvM4
         vVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CfirOHkYDbfOtMlxR8tdwKnxsW5v0JvL7K9lwCWk1YM=;
        b=N6c7uAbpDeKBOd4B6Jh7Dyj3fJSM5ZuqiCUxgwVpXTOrwcd8Em/6BE1Ub2U2FIo0po
         OeC+J7jXZsJ2/J9AKt7K7Ee/uYMpyn3MswxSH3L5MTP1N9ocEAKiCFx44h/PU6kq/sHT
         h5x+IbeyYn6gtS7G3AQgDAMtY9dHOX4mk/yRlQNXcdSd09N1oR/+3SsZmtmpIEObOrWh
         qBay0ryTPM7Zd9JMXk/Jy4jNX0bEFKX+XozFGRAiEPkV3uX2etPXL7Lk3VoNA3TfmN+7
         VHq/Aed3obRABExMZUh5dT5yU5YPlORixeGomXMpb07yDCanPaAsMWSKA7k18KAr3doB
         OfSQ==
X-Gm-Message-State: AHYfb5giAyVsGnD0NRLQp3i99I4d0xhoFDyk+t6822jIR44ypW/piFat
        wcBWdjkgcNdDpQUM
X-Received: by 10.28.161.3 with SMTP id k3mr610876wme.155.1502801617256;
        Tue, 15 Aug 2017 05:53:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id k14sm4006617wrg.11.2017.08.15.05.53.36
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 05:53:36 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] Makefile: define GIT_THREAD_SANITIZER
Date:   Tue, 15 Aug 2017 14:53:03 +0200
Message-Id: <258b5b68f29d680fea0a35b5db40783819df222e.1502780344.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.gdfeca7a7e
In-Reply-To: <cover.1502780343.git.martin.agren@gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using ThreadSanitizer (tsan), it can be useful to avoid triggering
false or irrelevant alarms. This should obviously be done with care and
not to paper over real problems. Detecting that tsan is in use in a
cross-compiler way is non-trivial.

Tie into our existing SANITIZE=...-framework and define
GIT_THREAD_SANITIZER when we are compiling for tsan.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 461c845d3..e77a60d1f 100644
--- a/Makefile
+++ b/Makefile
@@ -1033,6 +1033,9 @@ BASIC_CFLAGS += -fno-omit-frame-pointer
 ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DNO_UNALIGNED_LOADS
 endif
+ifneq ($(filter thread,$(SANITIZERS)),)
+BASIC_CFLAGS += -DGIT_THREAD_SANITIZER
+endif
 endif
 
 ifndef sysconfdir
-- 
2.14.1.151.gdfeca7a7e

