Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2FEB1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 14:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeICTKT (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 15:10:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40203 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so939136wrw.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rmP0DKWyj/n99nRXcKgOE8o65k+sks70Ko0EwLU5Go0=;
        b=u93G2sHVjEdWgCNgURcqzfCZ1MZRiyJikGSIg5RRxEUgm1WcW8pNdHqSIYBsewyDp3
         CPpY9Qt1C9Gno7XgHBQvfK9BMIfFMndazL1GKcJLQ8RmtuuuY6umB56jCCrz228N9WMc
         5UcTCttjoo8kbJhRG65XDF+toHd//R7omkzf0myErvGsBdUAXds17cOaWrjYdvjoaz+H
         ZCWv6Cr27ZdwfhiNU8mYX8BZuL/SWIlAf2dQ+xB87eJe6hNPZlSLu2Yya3IcNRe21biq
         XiZVee0JOk9ib/MYMSFqf7lgOuwKBcA5fr/4HfrkoFXyew+4kHPRIGmz7MBcrem1iRbr
         y5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmP0DKWyj/n99nRXcKgOE8o65k+sks70Ko0EwLU5Go0=;
        b=p6zQwc2Q7m4eGfEkpB/gGiLVzD705LgxoyIeLYqvuO9Nk6svDcLZoNiStNrgBJcKg5
         ccCjTWWyTsPIueGFuXuTKSinRGVZTEYYvdbcpPmZ+0S9kn78qDswceDmWbUUw/xSl7zB
         s8YOYhMX+zPGF9XfHK6Q5aMtn3fbQyWTglSnK3GMeZ4SOn+Z1xFXelsQH4t+SADht5i0
         bATk5hmPU5mVp8t28Pdq8etBu/N5RGCrcmfwAatKteS0zAd0qJ66NMw74Pz307s/3OR/
         ugkoM1i1PsLAlNp1/K+cq3sj2hX/2I39FkexcbLL0KKO0eWdVDqkvDg2/4XKGMvAAYeO
         4kVg==
X-Gm-Message-State: APzg51CokHIwdOafPxObQbqd0WLDBL5/6qGzGTvkPDPSUDKV+4Ei7Wrm
        Soc5hwZ0WbRFkFyLWT6CgfbjHbnr
X-Google-Smtp-Source: ANB0VdZn6GiQCqborRuSUW8vFLXtsWlzbrvVfrQV3O6oxvej6kqPIZLg2UGQcE7+yskldmCbLnOn0w==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr19874816wra.90.1535986187381;
        Mon, 03 Sep 2018 07:49:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e133-v6sm23841649wma.33.2018.09.03.07.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:49:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/10] fsck: add a performance test
Date:   Mon,  3 Sep 2018 14:49:24 +0000
Message-Id: <20180903144928.30691-7-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
References: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a plain performance test for "fsck". This test will not be used to
/ referred to in any upcoming commit of mine in this series, but
having a simple test for fsck performance is valuable, so let's add it
while we're at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p1450-fsck.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100755 t/perf/p1450-fsck.sh

diff --git a/t/perf/p1450-fsck.sh b/t/perf/p1450-fsck.sh
new file mode 100755
index 0000000000..ae1b84198b
--- /dev/null
+++ b/t/perf/p1450-fsck.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+
+test_description='Test fsck performance'
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_perf 'fsck' '
+	git fsck
+'
+
+test_done
-- 
2.19.0.rc1.350.ge57e33dbd1

