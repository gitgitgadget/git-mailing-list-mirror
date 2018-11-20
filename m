Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C011F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 19:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeKUGVg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:21:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40461 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeKUGVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so3474940wmf.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2lrytxya4V7Ko+zCsu0ChFlej5XANHpv+2dI2aMPT0=;
        b=pFEvt+ZlZd8WXPMote0RR2VPURl99NS7QtRggGR9lehv9wJE20Nz8elVjujQTmy9GW
         OHr4kyZjZVGaHlHNg6J16fv4jIGEChfjCh8nlZg46RWcSO5aDS9m/DieR0HSAKe59kSL
         fxUYnn84izOQQw7umxLlX+MgzWlAAl82RGEGvY4xulrgZlHsIJmSgD7nHFl5NFkkKUPD
         kqjedq5o3rwiGmcKV8OGV6Nr/CTI/pQODepqo2YymDLgUWs3J0fVmS2CGuAAQlVw+qbD
         vHzzkmMWjT0syJDBF0T/hvmnaW9D5V6Z9hXDkV7/diw3IUXkuGbhz/ZiYYQizRlAzGT9
         hvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2lrytxya4V7Ko+zCsu0ChFlej5XANHpv+2dI2aMPT0=;
        b=MjGgHvxxt57FK5d3Dno4+/cARkIosx1zV4W10kvFjLxBSikbuguegHTW90werf49wy
         kTBeP5eU7Atp3jjlMu9I/paWaO4ysBxiyh99a3lqhu5BInID1zXlHXEV2Vq/YdilHmb+
         5iZZEpJyTtKXEPqjeEkNfSZ95fTktRArUDrIFTWX0vY+Jd9M26ENZWyShtMiD9Cv7qoS
         PuDs4I1Sgmx+8tfUDNFKn+hNazmfmdXXBsgW7bGVtiPNU1dz888H3XtSRQDb8USU7NuP
         2uOdTOByWMSPWTNiR3xNhpsPFyRFbp6KP6eAwh78rxSGqe5F8t+HWggHVflI+m9VnDYh
         FqFw==
X-Gm-Message-State: AA+aEWYvl908oHTxTRR7RDWLsJJDQ4YcMHnaaWLGaKdWzEuz95QVJLG4
        cdMRBtqIcql0DmvjH0vlvct5IN9fUns=
X-Google-Smtp-Source: AFSGD/XlZH2HZEzWC7Vm08nr+pwBJ/A73YtgnB9K1K/YRpjbUaq0kRo92lFUeJhta3PdW6hRV5CNHg==
X-Received: by 2002:a1c:6382:: with SMTP id x124-v6mr3531705wmb.145.1542743445184;
        Tue, 20 Nov 2018 11:50:45 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p14sm12589415wrt.37.2018.11.20.11.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 11:50:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] commit-graph write: remove empty line for readability
Date:   Tue, 20 Nov 2018 19:50:26 +0000
Message-Id: <20181120195027.3260-6-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181120165800.GB30222@szeder.dev>
References: <20181120165800.GB30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the empty line between a QSORT(...) and the subsequent oideq()
for-loop. This makes it clearer that the QSORT(...) is being done so
that we can run the oideq() loop on adjacent OIDs. Amends code added
in 08fd81c9b6 ("commit-graph: implement write_commit_graph()",
2018-04-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index fd1fd61750..0e98679bce 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -888,7 +888,6 @@ void write_commit_graph(const char *obj_dir,
 	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
-
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
-- 
2.20.0.rc0.387.gc7a69e6b6c

