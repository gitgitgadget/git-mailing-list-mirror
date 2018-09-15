Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754961F404
	for <e@80x24.org>; Sat, 15 Sep 2018 16:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIOViT (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 17:38:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45843 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeIOViT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 17:38:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id r4-v6so10259165lff.12
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TW8NTny0NLELx+a9R2ql+H426IEN4BmTk4V3jr9Ub9w=;
        b=u7lL0c26BPoeB7e48PgJCBBt7sulZqN0kq+7sMVgvJ/TboMovHeKLrh+wvACACG3Bt
         DzBBQWJfg8TxsmS7POWOFtFSGeTfEejLMDDq8ZAJsSJ3pU7g5+w28jobQsbamtigzbx0
         JkZvxgxI/HgnP5Bm8nX5u4T3kWk4AXESb44ugTjkVHAkH0L0ZFuCoGEnPWCqm1w63b+0
         ik3EL0Uh2/uIzYrdiCLSeS3hArNlI9izbijUmX4gChJ6IBHU0/u/Z9+uSWUCud75wyH+
         0/QO6id68fExM9gDjKfB3YkczpfAWgLMd3gVFzTwNCFbIiU+HAsCl5dssrA20pyGPph5
         PUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TW8NTny0NLELx+a9R2ql+H426IEN4BmTk4V3jr9Ub9w=;
        b=U1o2bGUEfJrBB5iS/JvMbDmGfT2bIIhhOKDLS9k00ca5ISpOfRkp1teD0E3ZCsisAM
         /BWg1FXIH0y0NH0bWLZ3IScmy3frDQJPStEiZIFv8YPNrN/utrpM9MmgGt2cvEd2b8t0
         yf4vyYCLc42hcq8Tjh18ZXHAbrL1yBLCkZkgCcMb126UgcZj5U5JpOQncboTYyMmDNWK
         ByI27zlk7enI9CYqij32QzBNzvWmXOJBuXCyG/oPHdfixMDXeUAroJWgn4az7tdYwgpS
         NNiMpiBk9vCstUNODBTd4+ex+oWldy3PnygmZUChjDxjNHYcwKtBSfdvr/s0T18wYeM5
         7DUA==
X-Gm-Message-State: APzg51DmbWXx/RweStuZbckL2l+bcwSRO8d3MZZGDSMsSY6zuOmKrcow
        4oStg98cKA9T7fOizcUZxPCmiCri
X-Google-Smtp-Source: ANB0VdZuTGA8QMtofAHc1I7DwBCPCvSuiKOGhTNCfzE9uJeyCZevOP95W7C8vj9wWNZx1/RjteGV9w==
X-Received: by 2002:a19:9f06:: with SMTP id i6-v6mr11413807lfe.149.1537028328427;
        Sat, 15 Sep 2018 09:18:48 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id i2-v6sm1934852lfa.78.2018.09.15.09.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 09:18:47 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 09/23] read-cache.c: remove implicit dependency on the_index
Date:   Sat, 15 Sep 2018 18:17:45 +0200
Message-Id: <20180915161759.8272-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180915161759.8272-1-pclouds@gmail.com>
References: <20180909085418.31531-1-pclouds@gmail.com>
 <20180915161759.8272-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 6f772b2885..563500fe98 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -823,7 +823,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	ret = refresh_cache_entry(&the_index, ce, refresh_options);
+	ret = refresh_cache_entry(istate, ce, refresh_options);
 	if (ret != ce)
 		discard_cache_entry(ce);
 	return ret;
@@ -1493,7 +1493,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.19.0.rc0.337.ge906d732e7

