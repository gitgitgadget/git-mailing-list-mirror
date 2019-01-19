Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EAA1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 20:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbfASUVk (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 15:21:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45021 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbfASUVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 15:21:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so18941231wrt.11
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 12:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBhPv90zJG2W11C+QstOxuqhCF+LWqjiQipLdUAnzOc=;
        b=Wqpe+F1dr4IvYJHhxQ+94u6VpHStgwRvJGOAUlzW0lBCTRe3KOCND3AG56jUvXO1tZ
         Be1IooqjbQmv69xMcTMpNLAmflU1fXd/jetTuOyOTI9/YNETIJ8R6h11vpZTJtWmA/yQ
         p3YSt1/0HorXX0LCdL7EBiTqq0VAbUIAQU9CN0JQtr/YE0pNuDCxPwKzOHJeI9gYKalk
         T+qB1U6Etorpc1B9FtMY7eSO12qt2Zpf8OPfYlf95M72+5oZntfnxvI8EO3Sdz/ud0LS
         yMkPoPGOZE5YJqKt9lDEaJO41HgWLEMBOnpX/n8Wn/uIFzGqmuLAdZU4oprRWKkrwxcs
         NhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBhPv90zJG2W11C+QstOxuqhCF+LWqjiQipLdUAnzOc=;
        b=KCSQrO36vWVPCvolX1xfN/w98CFShLCsu72Ideu2DhuTyfF9yjvZejkZKWBrNlvqvM
         AO3JtF/knhRUSdb9woNAUrOXyLVJHRcDFIpIY1wAM6qTQrnhEeVrfdO3sdf9KRt+7SxV
         +iw5/gnCzNNA/gZmemB+sV9HkAM3Kk2E/RLdAiHxLI+SpWfZjkLLqX4DUw/sWZp+eyvl
         IkrCDhCykgClqucCekHoQA9Qd1oqgmNmbiclYjOuO945f/PfB4CULmRSfUxsPpT+IvDM
         HhU/htPhlwbcFzb/k+whd5U/XucyI1p26E86hqlK/4LZlfikZv0qXimyBX9NLSdt0NOy
         tyXw==
X-Gm-Message-State: AJcUukc6LQJT/i3YvIqbGhFPSwk+iK1bYeZaWDlRDW4B9O9IdV3/+vbu
        EGzuFpLHILR4j0ZUjyMCwAmHjrV4WaE=
X-Google-Smtp-Source: ALg8bN5DRuY1iYq8JWUFZ6lFkLahWVIfKBdVvVtwNiESMGWknijM0btos6POQEYbMhqx/YlPUna17w==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr21700841wrq.15.1547929297907;
        Sat, 19 Jan 2019 12:21:37 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g188sm56196229wmf.32.2019.01.19.12.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 12:21:37 -0800 (PST)
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
Subject: [PATCH v6 01/10] commit-graph write: use pack order when finding commits
Date:   Sat, 19 Jan 2019 21:21:12 +0100
Message-Id: <20190119202121.3590-2-avarab@gmail.com>
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

Slightly optimize the "commit-graph write" step by using
FOR_EACH_OBJECT_PACK_ORDER with for_each_object_in_pack(). See commit
[1] and [2] for the facility and a similar optimization for "cat-file".

On Linux it is around 5% slower to run:

    echo 1 >/proc/sys/vm/drop_caches &&
    cat .git/objects/pack/* >/dev/null &&
    git cat-file --batch-all-objects --batch-check --unordered

Than the same thing with the "cat" omitted. This is as expected, since
we're iterating in pack order and the "cat" is extra work.

Before this change the opposite was true of "commit-graph write". We
were 6% faster if we first ran "cat" to efficiently populate the FS
cache for our sole big pack on linux.git, than if we had populated it
via for_each_object_in_pack(). Now we're 3% faster without the "cat"
instead.

My tests were done on an unloaded Linux 3.10 system with 10 runs for
each. Derrick Stolee did his own tests on Windows[3] showing a 2%
improvement with a high degree of accuracy.

1. 736eb88fdc ("for_each_packed_object: support iterating in
   pack-order", 2018-08-10)

2. 0750bb5b51 ("cat-file: support "unordered" output for
   --batch-all-objects", 2018-08-10)

3. https://public-inbox.org/git/f71fa868-25e8-a9c9-46a6-611b987f1a8f@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5c8fb4b134..981faf0465 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -816,7 +816,8 @@ void write_commit_graph(const char *obj_dir,
 				die(_("error adding pack %s"), packname.buf);
 			if (open_pack_index(p))
 				die(_("error opening index for %s"), packname.buf);
-			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
+			for_each_object_in_pack(p, add_packed_commits, &oids,
+						FOR_EACH_OBJECT_PACK_ORDER);
 			close_pack(p);
 			free(p);
 		}
@@ -854,7 +855,8 @@ void write_commit_graph(const char *obj_dir,
 		if (report_progress)
 			oids.progress = start_delayed_progress(
 				_("Finding commits for commit graph"), 0);
-		for_each_packed_object(add_packed_commits, &oids, 0);
+		for_each_packed_object(add_packed_commits, &oids,
+				       FOR_EACH_OBJECT_PACK_ORDER);
 		stop_progress(&oids.progress);
 	}
 
-- 
2.20.1.153.gd81d796ee0

