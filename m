Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148E51F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 15:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeKUBeb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 20:34:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39757 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKUBeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 20:34:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id b13so2330206wrx.6
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7/012vgfZU58ex+5EZrccnyYPYhhrrQXZinDbn9r2w=;
        b=GXh1wW/uXLniCGa7dW9uDxW8PgGufPEztw7yhT+E8041RgkTlJPlHSrDeamZsxIso2
         agNC7iA8OqJ+suyVkdm3PNnfSZK/RQVxfFe7dz2KyDgGVoOEsWTDICOGZHALR/Yh5boV
         BYk/A9UzYg/tydmjgjdP39sgSw0V3Dfjgt8u2KCSgNUPot9gwQRKk+ccvJ1YZJKQdp1Q
         wGT333k68+l4q8nfr0nvgf+H/8fGA3lr7EXF16zAGroIhFsab7q+UZ30TFNWz7v0RrDd
         6pmvdMESRqbNSYLD1BUt38Kk0qnBsMszbgBhX4fCgugo3NG4be5xpnMT4ZUWIv4iR821
         LAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7/012vgfZU58ex+5EZrccnyYPYhhrrQXZinDbn9r2w=;
        b=mqs8YaDPCqMdbvNgo5v8F6gq/fM1nOCJEPuqVYhTwq/7QdUxjavdROlvAF6vcMux4G
         GwXQAHLjM2Q6KxjrA4aEicv/2BkLfsA+Q4lwCr0kPI7cUjS7kpZs2a+InsMqlW5utihG
         XZRVwWflRl21qenWcK9eGbH7u9CCKF7YXlEGUE6zj6vlfbQm1IqwWK3bztS65mW+Ynxo
         0qKi0xCBpjwlyosMWrUi9LPj5Ho/8GTu9l0wiitFV/TOhLT9MFuhpzEdt4hYOqBEElOE
         SrWgWzZmzfJfOrBtGPAc2+bH5Xmp/P9yJSGMmYQYrppqQFD697/cyH4a8V5P8oLfwxw8
         m5MQ==
X-Gm-Message-State: AA+aEWYDtTlpNAX3JO+63t0CZhBkpl8YkD3AQnH+ll6LZdDn4i+/TqFR
        30faF53eOfbbfpCfwVEmyHbBaV6fMrU=
X-Google-Smtp-Source: AFSGD/VFgBgphq5Um9W5z27eUrNh9NZO277+UEzvwchkv6uD3tJRUB/x7BQf0WhNUUh709EhSyTaNw==
X-Received: by 2002:adf:83a7:: with SMTP id 36mr2317759wre.13.1542726294594;
        Tue, 20 Nov 2018 07:04:54 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j13sm26378460wrx.5.2018.11.20.07.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 07:04:53 -0800 (PST)
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
Subject: [PATCH 1/6] commit-graph write: rephrase confusing progress output
Date:   Tue, 20 Nov 2018 15:04:38 +0000
Message-Id: <20181120150443.12997-2-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181119225720.GV30222@szeder.dev>
References: <20181119225720.GV30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rephrase the title shown for the progress output emitted by
close_reachable(). The message I added in 7b0f229222 ("commit-graph
write: add progress output", 2018-09-17) gave the impression that it
would count up to the number of commit objects.

But that's not what the number means. It just represents the work
we're doing in several for-loops to do various work before the graph
is written out. So let's just say "Annotating commit graph", that
title makes no such promises, and we can add other loops here in the
future and still consistently show progress output.

See [1] for the initial bug report & subsequent discussion about other
approaching to solving this.

1. https://public-inbox.org/git/20181015165447.GH19800@szeder.dev/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 40c855f185..e6d0d7722b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -648,7 +648,7 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
 
 	if (report_progress)
 		progress = start_delayed_progress(
-			_("Annotating commits in commit graph"), 0);
+			_("Annotating commit graph"), 0);
 	for (i = 0; i < oids->nr; i++) {
 		display_progress(progress, ++j);
 		commit = lookup_commit(the_repository, &oids->list[i]);
-- 
2.20.0.rc0.387.gc7a69e6b6c

