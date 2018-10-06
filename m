Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489441F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 04:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJFLa2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 07:30:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeJFLa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 07:30:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so14637052wrb.6
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id;
        bh=7VUXgIFiAuSiuO7W1qyAwJd1Tu/jYuyWTwWRjValqho=;
        b=reaaXhrNd/16OgchNCPHK+9ON4fcCZ+a6AQbE0jpEGKddCqLX4B/yplxc1gHlFA9Cr
         gPlHXuvyh0fzfgtmBFqXelEsvspVdKd502hLanpMSTQ7sODArd3z7nuquVR9Rv3vkt+v
         b8uJJ9MKuHu2fKtp7c2dzfKTmE+Vp6EAih2tXhrtRL7uzjUMovLmt9mczhG3PhQXfQSo
         W3Es19UVefqlZYm2BOV8jGTEn+4L1nX3bxtIfk2bDLTeEyD01KRaUlC7fnCD28LDeFdZ
         Bqypfx/2P3Ek6c3RwqgdBEr8+Mw2RsTdAqZwBShIepqRmQQdENuzgLkJ7DTRI7yuneJf
         aGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id;
        bh=7VUXgIFiAuSiuO7W1qyAwJd1Tu/jYuyWTwWRjValqho=;
        b=j7u9l3G0QX8Ro/N57N9v/jaxcRnOacoXkPdzlHv1cOyMDaS3TOIfczolI/MZXrIKyO
         N7f41U1gR70ispfFeeod7ByY0YjBovsZDccke+mUKouloy9cptOw+PU4b+ZuoJcLeMd+
         /aPyBZ87Yvv5oR+/tZdvwjfz8tSXQibM4EqIXKOQ1qfPEc8ROySXoOgHypR2z5m3VY45
         Vrv43fhjrEJlIcCV1JtSk4hpYooziWqYUEjfKDyiFVdoPB9E4njfSocGnrw6L1a08Z8V
         y49WxFjPsoz5hHARCCHXi5Slm6wIlnrAqxxyOrwBv5lpvPmjv5x2GA5UhaF27wYRI8pA
         2TiA==
X-Gm-Message-State: ABuFfohvXkel94e0pauR8NcjdHbssTX1m9p3pbuDf3gm0M3JhkjtGuHB
        HQafxSm754JHeBt/RR5p+93zJzESeBI=
X-Google-Smtp-Source: ACcGV60snKUP+YtIgH6nfMwjSX5Ejo0q8rwrhXHa6cUlfc/dm66tDvCF0tgHNXkCyYg7uZqZPKl5+A==
X-Received: by 2002:adf:8103:: with SMTP id 3-v6mr9895319wrm.106.1538800118901;
        Fri, 05 Oct 2018 21:28:38 -0700 (PDT)
Received: from gmail.com (ip114.ip-142-44-232.net. [142.44.232.114])
        by smtp.gmail.com with ESMTPSA id 140-v6sm5939436wmx.34.2018.10.05.21.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 21:28:38 -0700 (PDT)
Subject: [PATCH] docs: graph: Remove unnecessary `graph_update()' call
Date:   Sat, 06 Oct 2018 04:20:16 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <3dda7b8f75854716ac6b205ca05a7656-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sample code calls `get_revision()' followed by `graph_update()',
but the documentation and source code indicate that `get_revision()'
already calls `graph_update()' for you.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/technical/api-history-graph.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
index 18142b6d29..d9fd98d435 100644
--- a/Documentation/technical/api-history-graph.txt
+++ b/Documentation/technical/api-history-graph.txt
@@ -115,7 +115,6 @@ struct commit *commit;
 struct git_graph *graph = graph_init(opts);
 
 while ((commit = get_revision(opts)) != NULL) {
-	graph_update(graph, commit);
 	while (!graph_is_commit_finished(graph))
 	{
 		struct strbuf sb;
-- 
2.18.0

