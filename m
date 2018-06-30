Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53281F516
	for <e@80x24.org>; Sat, 30 Jun 2018 09:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934863AbeF3JIs (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 05:08:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45887 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeF3JIb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 05:08:31 -0400
Received: by mail-lf0-f67.google.com with SMTP id m13-v6so8442217lfb.12
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMFMMnYAPiGbfykAK4PzIWKnFDy5wUX3EKsRABCJZBg=;
        b=QGH3pXAICCqiGG5mlvwN3cKDCXeyhz3bPusEUMlIU+7lZNhQFVBnMb9bfmVJzrSadK
         qWWJ9+gSlJEAoTW/fViufIBPjlLh4/Q9VY06NTkIQZjNiT7iY9+D6q2ppMKYZzhyHeza
         BfA/k9Aw7ewRpUDAVqcpSuk1jt8wpb7iKcilOYD+eAvioUT+kys8Ryn0rVu1tLO5kqmh
         W1isfe7Txrszdq6znX7JgmJJ2g5phwXL3PiU8hD4uQrgujlY+cI3x8b8wglxBgkPPul6
         uoyLLMkqdx/AC3ZgO4S2ALE6yCcB61C4HhcVA4mJcHjDTZpc0SJIuucW4FNUdoUanlKf
         jOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMFMMnYAPiGbfykAK4PzIWKnFDy5wUX3EKsRABCJZBg=;
        b=RKzcjYY5uyVcprvXhXSjor3ff4Gw98pIz01+1u7gRjgipb/5hfZiUxUT2DFjFLe3GT
         03D4QoUSd/ttStZlpoYYQ957kSRNDdVcUMh0iyP/1cjOyUQts7l/8Yr22rqARkjs0yus
         hk6eWXAmCYkGp5WRp5Ht/lSbrt3qRcbMEQuFIZ35f0yZ8L6kBnvRM6ZKO17OlWWVLDMx
         i69G4/2+95cWtWo4YAiLoaYVlMmpoB1aKMkRfBJCH+j+URWy6rBNuWLOiajC4rn0KHun
         oa52ZjE+ZQtNGA7hHDUYB+It1U3VYYze1JYaPcYS4sz7ibv3sa46b/k4Xvc3/cH1oxTa
         eXNQ==
X-Gm-Message-State: APt69E25MAwJ4VhWjuU85g4zHBYW0nUePiJ9iSwy2DsnrtvFDo3zSY2J
        KHAxupbUqUu9IqAwbRxt25ASFw==
X-Google-Smtp-Source: AAOMgpec5DZe6NRcZiHL5Dc3jFFTh4hDErInX4WKshOnoEO9EnSnM/H0HplLxdV3FzRcRzngpQegQQ==
X-Received: by 2002:a19:cd08:: with SMTP id d8-v6mr12301239lfg.41.1530349709532;
        Sat, 30 Jun 2018 02:08:29 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q5-v6sm1831508ljq.33.2018.06.30.02.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 02:08:28 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/23] builtin/grep.c: mark strings for translation and no full stops
Date:   Sat, 30 Jun 2018 11:08:00 +0200
Message-Id: <20180630090818.28937-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.476.g39500d3211
In-Reply-To: <20180630090818.28937-1-pclouds@gmail.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9774920999..58f941e951 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -489,7 +489,7 @@ static int grep_cache(struct grep_opt *opt, struct repository *repo,
 	}
 
 	if (repo_read_index(repo) < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
 
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
-- 
2.18.0.rc2.476.g39500d3211

