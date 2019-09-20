Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	SPOOFED_FREEMAIL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE8C1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405391AbfITQx5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:53:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39323 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbfITQxy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:53:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so7461659wrj.6
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T0psrQyXUFw9FK3D864Hj1aEuxedrkax3Lr2jcB0C2k=;
        b=dTjsIstPevmpinseAubz8P3Oc0JvHblgJXi/09LA83zNf4m1yrYE1S0/LTBPjycjZB
         ZZBPxzI/28GF0MkiPyzyNvU1u0lSPHiFhYGyccHcaz/QnoW+CWLJ6gdMGqAAr9UGj15s
         ROuRKpG7ZflXYsmpiwC12T4gZbaxEYBTaIbgriZ2CYm3iHMhThSn5NsXEKREdzcqEHvT
         RNPEzrXsbgm2EfdCdllmDYMUzYcLwo2RKNV4tY0ttV8EzvMtcXIcJ4Lxm0pxhJK817oR
         ECBzD5i34EpmQfBDh3h1oTGnhTOon5ooRISR9Zq1MpsNL4RbVCZJEoYiSIEqvWZvtF3V
         IFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T0psrQyXUFw9FK3D864Hj1aEuxedrkax3Lr2jcB0C2k=;
        b=CC7ciC6+R7h84l1Nr826QZr9yoGFgw9pED/EERrtNS02RNMdB+cuvBc89wy87bU9YF
         3O15qIJCdpFlsgEXh2vHs4aqKBjz79rOtppCPIH2gEMLw8P1KMgmZr3nk88zAGTCYqbK
         0doBrU6WG+vL3h33Vlb8R/pFpwE+qWRoSGffolJXQUbppU/D8BHk3TrfIElMd/l/gD+A
         1r4pi6Ddcf0j6rMjKT14/nSJigV8UxWFhnw0cxxNYQKW/MovSgCBrZdq5vD7pp1mAg/Z
         OAx9mm+5F8CY3KD03e5a/Soyssb1eRFjytoZ+ILOC5J+NXuFpYsqH3NSFRMtN8PoK604
         /2+A==
X-Gm-Message-State: APjAAAW6AR88m+IbwdbUCPuItH5b1nuX8MgT/MIA0vv0q2iwpMWMw9Ua
        BVjQHmLB66ljOrzvtTgF4NGfXAez
X-Google-Smtp-Source: APXvYqxnT0/ZF1bbmWCb5G9+ZM4U0LHbOKLWXPv1CVVErQYpx0X91d+RX0g7RsP1BjY8goG9TYxzoA==
X-Received: by 2002:a5d:4444:: with SMTP id x4mr12701134wrr.11.1568998430781;
        Fri, 20 Sep 2019 09:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e20sm4908079wrc.34.2019.09.20.09.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 09:53:50 -0700 (PDT)
Date:   Fri, 20 Sep 2019 09:53:50 -0700 (PDT)
X-Google-Original-Date: Fri, 20 Sep 2019 16:53:43 GMT
Message-Id: <3374574001cf188d9d17ac3aeed1139b82330284.1568998427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v2.git.gitgitgadget@gmail.com>
References: <pull.337.git.gitgitgadget@gmail.com>
        <pull.337.v2.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/6] midx: add progress to expire_midx_packs Add progress
 to expire_midx_packs.  Progress is displayed when the MIDX_PROGRESS flag is
 set.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        William Baker <William.Baker@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: William Baker <William.Baker@microsoft.com>

Signed-off-by: William Baker <William.Baker@microsoft.com>
---
 midx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/midx.c b/midx.c
index 54e4e93b2b..3a0e161aea 100644
--- a/midx.c
+++ b/midx.c
@@ -1206,18 +1206,29 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct progress *progress = NULL;
 
 	if (!m)
 		return 0;
 
 	count = xcalloc(m->num_packs, sizeof(uint32_t));
+
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Counting referenced objects"), 
+					  m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		int pack_int_id = nth_midxed_pack_int_id(m, i);
 		count[pack_int_id]++;
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
+	if (flags & MIDX_PROGRESS)
+		progress = start_progress(_("Finding and deleting unreferenced packfiles"),
+					  m->num_packs);
 	for (i = 0; i < m->num_packs; i++) {
 		char *pack_name;
+		display_progress(progress, i + 1);
 
 		if (count[i])
 			continue;
@@ -1235,6 +1246,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 		unlink_pack_path(pack_name, 0);
 		free(pack_name);
 	}
+	stop_progress(&progress);
 
 	free(count);
 
-- 
gitgitgadget

