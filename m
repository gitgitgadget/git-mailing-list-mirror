Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A581F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393181AbfAPNaY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:30:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45369 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393158AbfAPNaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:30:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so6877049wrr.12
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSbp6ax1SErZl6HkIEM5tIrxmcblhU9P25q521QZwCA=;
        b=teGQBxdxoWdfaORipg7Lca8/HCapb81CSxMAF07NtD0TFPmbyIc0xi5icpgkJiW0Fw
         PfB/HD1SJVBmEp9L3NZicnv7GNwQ/j0gNkpNM/M4luUH1LQitIJpIFmUWuHPlBOO8UQw
         AOCclzadlsf5tFjSOlv0klAt40oy5iC04heKQ3X15f2/cdWDHPD81h8gMPPngGNkCftR
         pr29X2c1enWUyNZPqtTfW8VGG49k4JTnnpJLCrM94w7yEwfo3jLGxJ9Y791dWvl6ZZ11
         c9FRnWUqbyk3Mn4qBpBSDR8cVHqt39YdXENhVdfdqTOUfE+Z8uHOSdaHdkwcRI4sNjQt
         9Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSbp6ax1SErZl6HkIEM5tIrxmcblhU9P25q521QZwCA=;
        b=uZzhdHwnHFPCQPd6NBBNfwBR6KAEHzwjAtA0aJXhItAajqgFHy2+THNDQ0s06Tvs8o
         ngrrPRm4Ml8pZL2OuyiuzKF65nOyqtNJhb7J+sn1cCJKXwO4PRRGixyptPIqd0ptOL8r
         ePXVfIkdMGPdM1ZF/9yyr5CoEww4JLrONDKL/f+YkvvmeJ64oB6Yz2hzCu/ABAnxYh1i
         tJrBlm0dfNz/RIOl3rOtMwZ6qGuAgyc72hxuetIZJeD1bKLPuYiioVqWN2MV3NL6WdR+
         eg0mVvJfgbjY7b1HgsrUBb8JYBA+B6u+2N3Qb1yasbyhYmVSm/LZPpKAquPRFN7jOghf
         vm1g==
X-Gm-Message-State: AJcUukfgAwOr+o4x+fZwvRNro3a51ds7ZIAC9xufAXhQgfEgya+pS242
        gz07pWl+j4m/PxEz90Pkly+CrZqx0s4=
X-Google-Smtp-Source: ALg8bN5Kdnoi1wX84fS9WTgPDiPuAiRwK58wejDV+n8Bp/1BDZzUx9fOhFDUiSgkuqyTXudueft55Q==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr7485919wrs.268.1547645421226;
        Wed, 16 Jan 2019 05:30:21 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 10sm44283964wmy.40.2019.01.16.05.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:30:19 -0800 (PST)
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
Subject: [PATCH v5 7/9] commit-graph write: remove empty line for readability
Date:   Wed, 16 Jan 2019 14:29:45 +0100
Message-Id: <20190116132947.26025-8-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20181122153922.16912-2-avarab@gmail.com>
References: <20181122153922.16912-2-avarab@gmail.com>
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
index c6f8e73980..7138bbd02f 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -894,7 +894,6 @@ void write_commit_graph(const char *obj_dir,
 	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
-
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
-- 
2.20.1.153.gd81d796ee0

