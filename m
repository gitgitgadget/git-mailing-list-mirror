Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A451F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437807AbeKWCTk (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437788AbeKWCTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so9503449wmh.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WLVC23+Lckx1MtsV6l2XoNybaleRo3b4ttuktAeA+M=;
        b=V50rdkVz1DN1UR/A1qMJ57+NY7f45603VE3/76VYeY9iZw9ZJ5uenfoI0H/GA/LgOi
         pFLSCP8YYPdRt5zpeojQwJz/MCA9sG291lPljjpJN6zeSSG6+rEqjBDrPd28ESQfzStU
         kMG3+sjc+B0HUaORYYlXIYBthdpf7QGJrEiYN6fW6TY0ynVpzcReboLd3csj6D2KVtTN
         aKkqp6Nrq5CGrcUwDCvZ1DtsqGN8OajEli7R2l6/tia1ySziNFSsUrOC5F0YRlTmgFaS
         umPJO+RSNwueDljy5s2ukyJ+nfpx0LXv/M7QaOq3J7SCedjOvSZk2houlLGDjEXrtPum
         n2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WLVC23+Lckx1MtsV6l2XoNybaleRo3b4ttuktAeA+M=;
        b=BTE3OYVf/8myMbfbBAO0eEb5+2TC45aQysrUGmfuF9rY1ZlXhObVb05vnjm/T47qWh
         ophTssT8Ly3IQiYRLXYOSPb/UY5UxML+wFKqnEWnBJtLoBxFbozncmZpQlZLVA01Li48
         lOS3ocszbthltWCyq77k+sYvIyyJ0BwXpibO9tJxc811gcrteYjOSk0Nso5qTTOzYC27
         oBsV4WpVBy/ZNlZB5QFI9wnFltXqho7bZKhYMgTK8JeLDdIGNTyg/twNNStpfC/Ef3rv
         Ycbdj750vSQPqzk5It6YVKdNr/sNtdEUAqSA0dkDDp+OyycTwIGJaNBn9aPjgbd0rvfa
         39zQ==
X-Gm-Message-State: AGRZ1gKuxpOLLYN4u+VVHM0wTC9yZhUAKBo9JP5VlSy2og7V/+qT1X6o
        D6wb2auO4YnHjW+WuOWFqDroLtAjLQE=
X-Google-Smtp-Source: AFSGD/V1OIJwT4Vq2k3AglHIZwKSfvbMTtfUE4dwbbTB6egByiulhLdluCwcl+8n/3rhcRjVq0d5sw==
X-Received: by 2002:a1c:a8cf:: with SMTP id r198mr9566838wme.95.1542901186177;
        Thu, 22 Nov 2018 07:39:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:45 -0800 (PST)
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
Subject: [PATCH v4 08/10] commit-graph write: remove empty line for readability
Date:   Thu, 22 Nov 2018 15:39:20 +0000
Message-Id: <20181122153922.16912-9-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
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
index 43b15785f6..199155bd68 100644
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

