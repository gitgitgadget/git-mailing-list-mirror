Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65BB820248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfCNMe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:34:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43102 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCNMe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:34:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so5651461wre.10
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwbWbcDVUm2nj+O0KFnV919PrtAZOMQJBD9zE7ycffE=;
        b=mLgjZQFi//feZiJnmlplylm+aSENi5BHGNp9Zxt5B0pB6OJ5UL+REquOZqFzycBAd4
         j/sbt5sBd0D7XyDbvrjSyTDDVyr7YeQ4FxjT65xq2gW2bAQ6wwKS+jnCGNEHzeU3e5/K
         CzRdob1+PBvuqcQt/1/qUv1EqkLBD9BvOPLcExONXlP35okSa3zRXfU+ULVACb2kkf0o
         rdN53a685Li3U47MMvOAG8rOUcRsmkr+8ZvLOjqn3wjmpmUmGygZ2qVNR/5M/z3GUqei
         xNmfbTLK0xXTwT+wb9pXRNrSds1NAgtLn+R8YfODW2ZKYQDb+w1u7WaFPx8nZgFZxe2A
         OPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwbWbcDVUm2nj+O0KFnV919PrtAZOMQJBD9zE7ycffE=;
        b=L8bWpWvxGKjh9+wQAh+BqS3HYGc1sJu/7MjD6PfchFmNI+1G1kvvqCJDcpuYsQAvGp
         yYfO6kKroy8uNJxZLI5gYObhS6v0Loo2TuewPNRmBM0ALXmvvePTbTYEHV8S16SotAbm
         UVhndSYz0ySrrSuqEmsoEWMS/ANvDAsUZrahfZe6YMuYP8DaM+9YNRUT51Wg+/me4BR5
         4EaCYJ2QkULGe/hRjK0Qsw9EC6udRDGrVLloqMii3wlcth4uXcgUN/lVtI2sqfXBMShF
         t5q8Op/T7TxS+qsI15lAvD/TMAXaU6/ZQSGtOnR5cH3tUGNAQnYAu3fQM+FHdtEsQYSQ
         CD7w==
X-Gm-Message-State: APjAAAVAWEXm/DDU3qI8vdo4Was5UaKKVdzF885NA0mXBa90Sf/l4XNC
        cD3JhgQsihTYIYEkMvrrbIkbVEC5uso=
X-Google-Smtp-Source: APXvYqxmTbCZQzWTJYwhYX+kaJiyhCmEnY3tIKmfHCckqJgVgOtAI6NdYHoJ7szQvjTkpal1f62UrQ==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr30102471wrx.74.1552566894800;
        Thu, 14 Mar 2019 05:34:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.34.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:34:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/7] gc: convert to using the_hash_algo
Date:   Thu, 14 Mar 2019 13:34:34 +0100
Message-Id: <20190314123439.4347-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been a lot of changing of the hardcoded "40" values to
the_hash_algo->hexsz, but we've so far missed this one where we
hardcoded 38 for the loose object file length.

This is because a SHA-1 like abcde[...] gets turned into
objects/ab/cde[...]. There's no reason to suppose the same won't be
the case for SHA-256, and reading between the lines in
hash-function-transition.txt the format is planned to be the same.

In the future we may want to further modify this code for the hash
function transition. There's a potential pathological case here where
we'll only consider the loose objects for the currently active hash,
but objects for that hash will share a directory storage with the
other hash.

Thus we could theoretically have 1k SHA-1 loose objects, and say 1
million SHA-256 objects, and not notice because we're currently using
SHA-1.

So assuming that "gc" eventually learns to pack up both SHA-1 and
SHA-256 objects regardless of what the current the_hash_alg is perhaps
this check should be changed to consider all files in objects/17/
matching [0-9a-f] 38 or 62 characters in length (i.e. both SHA-1 and
SHA-256).

But none of that is something we need to worry about now, and
supporting both 38 and 62 characters depending on "the_hash_algo"
removes another case of SHA-1 hardcoding.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8c2312681c..733bd7bdf4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
 	int auto_threshold;
 	int num_loose = 0;
 	int needed = 0;
+	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
 
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
@@ -163,8 +164,8 @@ static int too_many_loose_objects(void)
 
 	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);
 	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
-		    ent->d_name[38] != '\0')
+		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
+		    ent->d_name[hexsz_loose] != '\0')
 			continue;
 		if (++num_loose > auto_threshold) {
 			needed = 1;
-- 
2.21.0.360.g471c308f928

