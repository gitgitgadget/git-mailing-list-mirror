Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0A71F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 13:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436867AbeKWAIH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 19:08:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45360 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436848AbeKWAIH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 19:08:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so9261332wrr.12
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 05:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txvgHzg9CEoMYFfcKj0P5kWqe+iDVdSisr9a2sY3U4A=;
        b=tIATKP/M8UjCso5wCj8F4eJ4sNexKnijLKadSVgwPgyPKaBMgsNcT/hIitI8eFG7ZZ
         Sbx2vHrh3Y01UlTFvMq4r9zCMrKvsn1FSPhyC+EanP2/yGEHY1qCr6VlubcHTeuSIoTm
         naqGxQuJkFbBSUoNKbimD0fuEEyeewnESLo1wywMwI1Xvrbc7mGMnOiEzFZcV8nqFsMD
         Gh9qnayuE5Ct/8MEW6ZcwSRytNzCKNlUzwglVHktIKEyr7SthptvHFXCDRz66O2q9VaB
         frXSJUc//F/Zm+p6bg09nGtuxudISTwnu1TrPumKyrsvokdUMbxblZfsLkpy2blg4xNK
         Slgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txvgHzg9CEoMYFfcKj0P5kWqe+iDVdSisr9a2sY3U4A=;
        b=ljr95W7v1n5M3RC3O40UZiRiRbmYi4sSqKzgf6gdY0t/U0Klgr9YKbSNzkI1+fSqaA
         h7Jq8K0GANvYTtjFnIYH+OC1+NKykny25GkNbLOIRVZORiw2jdhWzwHq81OgKZeoKmMM
         OZ3We8azIp+L+Lgccx24KLVQGPDgrpJUf4CfdhuIERs1lsoBGBmjeKBSpgaXIW2R5mDp
         KCVEt/d7Vvk3Z4KrtiU1vVY0yTxr9Fu+UkuNm6A6Vo8LkOOPcYVSdiNj4av0CTf+CQMP
         E6ZCIkK4b8amPK5im3m82Ivt9JDySJZoWbg3tuldAZX7ysqEDzuqSWH/0KiBcu8aXf/x
         oMng==
X-Gm-Message-State: AA+aEWahkX4lqRtX6kWxbwgR7w6UPfwIGA2h887Ms7suSjOpPOKXAAL2
        jntHCdKs8A7x+SZvbUaGMmQQ9SY3h2s=
X-Google-Smtp-Source: AFSGD/Ut4dYLQUwyes+cpmqDEXC7KsBRrGup0YHtyjJNtzDMCliQ1Ou6DlWGWxuxJevSVIoNdQ93kw==
X-Received: by 2002:adf:ea52:: with SMTP id j18mr9261287wrn.108.1542893324664;
        Thu, 22 Nov 2018 05:28:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id t82-v6sm5418165wme.30.2018.11.22.05.28.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 05:28:43 -0800 (PST)
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
Subject: [PATCH v3 08/10] commit-graph write: remove empty line for readability
Date:   Thu, 22 Nov 2018 13:28:21 +0000
Message-Id: <20181122132823.9883-9-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181121012600.26951-1-szeder.dev@gmail.com>
References: <20181121012600.26951-1-szeder.dev@gmail.com>
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
index cb1aebeb79..21751231e0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -890,7 +890,6 @@ void write_commit_graph(const char *obj_dir,
 	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
-
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
-- 
2.20.0.rc0.387.gc7a69e6b6c

