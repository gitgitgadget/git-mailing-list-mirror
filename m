Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E097B1F491
	for <e@80x24.org>; Sat,  2 Jun 2018 11:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeFBLvF (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 07:51:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35346 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFBLu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 07:50:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so6667595wme.0
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 04:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=rZG8MwJ6ItF9nmQqvU4MKWaScJADgNknahTY0ko7kH1nvg9lnBvKRhqDqxEaabymc8
         b+BJfzF5bCqhxRdwX92bbX8oKepW6BsuisXNtZk81YEgnT0Hh0EPMvAGrtelqnJHTZKQ
         KM8C+WTLzelkZZVjzGlysK6uukZXK+t15Ym9reYuVjpknTwFuggPIVSM3FzEtjjASAsb
         /c7YdR01x4Rb9ctQzmVxUIg3yO/eKt/d/sqlZQeJocgZrWXc1qaykYvS39ibJyaWcE/x
         mIcE//6LFbhm3FPJ6h/ooAxbAcGSe63VqWp5Du4a2EZxYBizGPdhvf+y+MHBMN5M6ZXA
         yDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Iw2YiB/ZkIh4oCVAMKTf2c/oj+UFgHHJJM7iLMD06Cw=;
        b=CtTv/YEIbzRTCLYu+cRwyt/9jS2DVji164XTA/loumU9fQrDXcQNYlUEkNWSp8QIGI
         K2X5kqeUDmg8NtQjScqr0Ub7vmLN+5KYyEeJYp0ZFTrCKxurIX5YYcp1UBw4XPAzlv9F
         0H7ekGqjSu4/kKS5P6NPlsvHsuM1HSsuoeItOhsq3u84jzfsFbWebwJFMGK/f+UXDaLU
         53LBJYv0hVazuaEHCwBz8CbtxRJRYJcfgsiPnlUfzltfwzMJIDC/hpQD898x457Qw47I
         aNVFj4WD2jQXowhHkDzCCaVfugpXBmi2hyHqI4ZiKkl7F6jaITij+IZWKMCnRaubE43g
         hzVw==
X-Gm-Message-State: APt69E0Wwph+kXlXsLs/iBRlCf70E5/w4bgt8s7PtRLuZMkJF3n5H/kK
        J9zSYUbzDRQ8jI6fMgSfkA+wi6+L
X-Google-Smtp-Source: ADUXVKIurfjlWkaJMHuKwpmMgnK26kTFwLINFSsUwyRsyTcVmq/XqaJdxDZnIN0AK9fK0lTov8GhGA==
X-Received: by 2002:a1c:eecd:: with SMTP id j74-v6mr5366368wmi.137.1527940256583;
        Sat, 02 Jun 2018 04:50:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v31-v6sm58977794wrc.80.2018.06.02.04.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jun 2018 04:50:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 3/8] checkout.c: introduce an *_INIT macro
Date:   Sat,  2 Jun 2018 11:50:37 +0000
Message-Id: <20180602115042.18167-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180602115042.18167-1-avarab@gmail.com>
References: <20180602115042.18167-1-avarab@gmail.com>
In-Reply-To: <20180601211015.11919-1-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an *_INIT macro for the tracking_name_data similar to what exists
elsewhere in the codebase, e.g. OID_ARRAY_INIT in sha1-array.h. This
will make it more idiomatic in later changes to add more fields to the
struct & its initialization macro.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 checkout.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkout.c b/checkout.c
index bdefc888ba..80e430cda8 100644
--- a/checkout.c
+++ b/checkout.c
@@ -10,6 +10,8 @@ struct tracking_name_data {
 	int unique;
 };
 
+#define TRACKING_NAME_DATA_INIT { NULL, NULL, NULL, 1 }
+
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
@@ -32,7 +34,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 
 const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
-	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
+	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
-- 
2.17.0.290.gded63e768a

