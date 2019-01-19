Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092701F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfASUVz (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbfASUVw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so18991363wrp.3
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyjqvubp003W3u5uYdAHZrnISz65SFC/0PmlICtX8aw=;
        b=rDTo+NoTPnW0hZBoRqJFHDkHgGsluFDjw/UqfreJEKuodUIZUzZ/lNQVssxsxV5KKC
         L99+xjf7Lu6kZKP5CjGn5cpNpHCCQoZLLocN8Rf0HEAMv3AzVmtUAqaJu2F0/f5bwc3g
         yGsD0HvRdfzQEerDANJM+v9dkDx2tglqgZX5kkl+ckFwfp6W/xeaCkZV9KqaQYfMWNhL
         6azyrHRcvS1GNJhMwLResq/kNk5eVoK9rkTCI00jRFMQpD71y1y9B1RfBfkDVY2FgJjc
         s7vw63ERrPhm0/QAgehdms0F1cUXDGmZVM5Mstes2nqatVhivKOO9PdOUN0/HXvLw2TZ
         8eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyjqvubp003W3u5uYdAHZrnISz65SFC/0PmlICtX8aw=;
        b=rseER47xfrNG0GfpZmBr4dEJZKpuHNgO7zGZxCwaXbgi1kLzZnoBjoOxlNdJnZ8ZDy
         pxukjGBK/HWx2lhRFD5t1yoHYMLXQvPhSH+xtuNi4xHwT0OQnkjALe0HItzMk/sqQ5xs
         ZfEFcVxXjIOmd939PFLpHjfRseNNi5ox+uc4NGgwqEsBkVrGkMvj59LKZzKbzdqDq88x
         LW2ibPHIiWWD8/ZUlGKrUXSMLUJQT0qf7wGPLvT2k3sERFObVFtU+nFBJIP5agW2rTvA
         LZ9347Qp6leScO5VGq9dw9mAqbDRSRjFZe8wD3tQbXfsf04+fJNIbfVj714Twp4v1+f/
         o8BQ==
X-Gm-Message-State: AJcUuke5AVAFfRRm/g1BJup+VBblUaJzTY6HFgNfaU47o13iEHCecP0d
        jmKQFkSS4Yea5lwgID0KlCG+TTiWC5o=
X-Google-Smtp-Source: ALg8bN7IU48qU7+WEoH8GRRc4gDrd8LiN9medn9jDQWCVscz8v8i2AYmxYecUnm4cGXSAik97B80KA==
X-Received: by 2002:adf:d243:: with SMTP id o3mr22349322wri.66.1547929310643;
        Sat, 19 Jan 2019 12:21:50 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:50 -0800 (PST)
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
Subject: [PATCH v6 08/10] commit-graph write: remove empty line for readability
Date:   Sat, 19 Jan 2019 21:21:19 +0100
Message-Id: <20190119202121.3590-9-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190116132947.26025-1-avarab@gmail.com>
References: <20190116132947.26025-1-avarab@gmail.com>
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
index 936119b1f9..d4a7280fa1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -896,7 +896,6 @@ void write_commit_graph(const char *obj_dir,
 	close_reachable(&oids, report_progress);
 
 	QSORT(oids.list, oids.nr, commit_compare);
-
 	count_distinct = 1;
 	for (i = 1; i < oids.nr; i++) {
 		if (!oideq(&oids.list[i - 1], &oids.list[i]))
-- 
2.20.1.153.gd81d796ee0

