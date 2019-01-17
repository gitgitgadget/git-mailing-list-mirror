Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F1F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAQNYI (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:24:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40948 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfAQNYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:24:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so1030306wmf.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbRoZAdu+TcBQdcQa4kQS1JEKpeT0Wyx0L9iJ5ik6zA=;
        b=RFtaOCKYuYM3zGDOqIkh/33JmkN2eljbozgD5grmBlzqcCP41tVrGOTryK+oYPo+xO
         j3C67YvM7yEXAl1ATSeV9YAwPFDfN3pZZreo1bUpYfjeEk+jgDX61dWJYGCXdFeUHyY5
         95nQTMdrubz+ZxQTJbuVhNJ6ivsZ6gcXgd+mgEbFY4+AQJVagzYwwUOCSBdCIVzjDsF2
         T3i1winz4rIiNRTpC+R9LRqiop/Ij8oHbeNw5qMs2j2rSevPzGAM7cKxKNF84AVjNhaG
         B+rBEH40SXUm26TrPMz99I38+id/5Mn8dKZMjpXQEPrsgirOt9jlBy6Hpa1ItUe44nmT
         lV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbRoZAdu+TcBQdcQa4kQS1JEKpeT0Wyx0L9iJ5ik6zA=;
        b=Tu5AzL+Ti8Exg/IzDSA24DYM6H0hiefG7LY4sFcaxHgplxubr9sKt0ArZ4xTTY6Nj8
         DKXGCC6oD7+w9AdhIugE4SUX97Mf4SJ3H4lh02rxY7TIsqh7tW9cFJk5YcYuikS4ydHB
         A5pd2I4CxBqkgByhPxwr3KHSkdKGIP0xaPwwtiFZjZI/NXC9q++o1RDMAGc/KTvZbWG1
         3/3eMVt56P0VgMKyvlu2ehuViypqn7Zwrf6etOFAAEfvLc9/oNz68JcmOjW4/7ktOcyD
         JPWyKRNi8h+8Nfs4uoZpNYSmImOCH4j5w/7N41Oy7wCwRbEgkG+n5hiiiU3zaVmAamsi
         Gs0g==
X-Gm-Message-State: AJcUukeDnAfvmv2i7F03af7KtT5Cr+lqfuTKKWcy8OGL5IJUi/GaOWAg
        V+WFJqD3cU6Va1rkxh8gY68XkXnryL8=
X-Google-Smtp-Source: ALg8bN5t1Zw9N/SZDayc8gAW5F9otWo5PbPBNoG8IqbMBLKjLq59Y+RoEP7UrZvZuDONudAJp4U5sw==
X-Received: by 2002:a1c:8f41:: with SMTP id r62mr11242278wmd.141.1547731445962;
        Thu, 17 Jan 2019 05:24:05 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6sm39113844wrd.88.2019.01.17.05.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:24:04 -0800 (PST)
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
Subject: [PATCH] commit-graph write: use pack order when finding commits
Date:   Thu, 17 Jan 2019 14:23:45 +0100
Message-Id: <20190117132345.29791-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.1.153.gd81d796ee0
In-Reply-To: <20190116132947.26025-10-avarab@gmail.com>
References: <20190116132947.26025-10-avarab@gmail.com>
MIME-Version: 1.0
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
cache for our sole big pack on linux.git than if we had it populated
via for_each_object_in_pack(). Now we're 3% faster without the "cat"
instead.

The tests were done on an unloaded Linux 3.10 system with 10 runs for
each.

1. 736eb88fdc ("for_each_packed_object: support iterating in
   pack-order", 2018-08-10)

2. 0750bb5b51 ("cat-file: support "unordered" output for
   --batch-all-objects", 2018-08-10)
---

This is conceptually different from my "commit-graph write: progress
output improvements" series but conflicts with it, so it's based on
top of it. This patch goes after its 9/9.

 commit-graph.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index b6a074c80d..68124e8385 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -839,7 +839,8 @@ void write_commit_graph(const char *obj_dir,
 				die(_("error adding pack %s"), packname.buf);
 			if (open_pack_index(p))
 				die(_("error opening index for %s"), packname.buf);
-			for_each_object_in_pack(p, add_packed_commits, &oids, 0);
+			for_each_object_in_pack(p, add_packed_commits, &oids,
+						FOR_EACH_OBJECT_PACK_ORDER);
 			close_pack(p);
 			free(p);
 		}
@@ -885,7 +886,8 @@ void write_commit_graph(const char *obj_dir,
 			oids.progress = start_delayed_progress(
 				_("Finding commits for commit graph among packed objects"),
 				approx_nr_objects);
-		for_each_packed_object(add_packed_commits, &oids, 0);
+		for_each_packed_object(add_packed_commits, &oids,
+				       FOR_EACH_OBJECT_PACK_ORDER);
 		if (oids.progress_done < approx_nr_objects)
 			display_progress(oids.progress, approx_nr_objects);
 		stop_progress(&oids.progress);
-- 
2.20.1.153.gd81d796ee0

