Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E4620248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfCMXzD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40490 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMXzC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id t5so3898133wri.7
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29pkbaKIcEZV76rA9luir7yhyIu1NXmLODyRRnt9pU0=;
        b=DD15jTwxKQFYHemQ0OcFvsKL7vIB906m2UJizrgkwCEJ00Mn4hiYsq2jIQJ0oMzcR9
         NkYerzZUYQRdJ1+8ztcWkD2c7B3DEV+PgSyFnifOPcmwBNLMcNcpXSx2jtMQ4tNTifv0
         PMfHQJzTLdufFa88QkoeMUjqDkPVqnpqS7upJgdUNWgl5w3agU9dT69jSKs5rKZpGNMz
         oenj6AJ5CXnnLctKUNRYELbFan/a/d9Jjw3cIHPfl0d9uhLAjX47aZ5vtI7JNGnchzD8
         AjNtSBJeJ7VHb4t+51DoiaPnsXrODxLJFqXHmuDnPbsOAtI/krxIggnAW7ZQSa9ZJ6oH
         RQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29pkbaKIcEZV76rA9luir7yhyIu1NXmLODyRRnt9pU0=;
        b=jvveOPwetlMLgC7/vA9zjn7xsuYX+Meb5AxAke8zUCXqRp5EEWMl43bYV4jHxO3zte
         88xYX58098ycIfXWxk9q8J2lTJAIXsmLw5g/ye84ewifW4GFaCGDaAYAtQHbaTXt9P3P
         j89/PMlnpOJXgD0MracMzqVfuvzrYzyfoyFItaPo3/la1xPea2fScM4gcIfbP/ddNdm8
         xpEojsLdQ13MrhYErpCDIZuYBOjnPK2eG8wjZzTSb90rXzGKFtFlyYGVLAbbWPHEgMJ2
         j96VW7O3L31+mq0WYerh3DqV7UbK7nCFVpf8AE1juvuzT7FTkUj1P6k9ERGXhKEcqy4y
         NTiw==
X-Gm-Message-State: APjAAAV2j/V8zZxW7sGEyFHlMF34+kaXj1WMJeZpiDEjaJVAFqot83sQ
        bY4Obiz7Ums3Jr/GtfFKimPCN6+R
X-Google-Smtp-Source: APXvYqyjNLHXfvyVLgeDrpbCXKzRLj68cRIwjdt7/6UUuesAMEtqmJBOYCpO0GJ9D2/LGf6g6qWLJA==
X-Received: by 2002:adf:c543:: with SMTP id s3mr27829033wrf.192.1552521300167;
        Wed, 13 Mar 2019 16:55:00 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.54.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:54:59 -0700 (PDT)
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
Subject: [PATCH 1/5] gc: remove redundant check for gc_auto_threshold
Date:   Thu, 14 Mar 2019 00:54:35 +0100
Message-Id: <20190313235439.30439-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Checking gc_auto_threshold in too_many_loose_objects() was added in
17815501a8 ("git-gc --auto: run "repack -A -d -l" as necessary.",
2007-09-17) when need_to_gc() itself was also reliant on
gc_auto_pack_limit before its early return:

    gc_auto_threshold <= 0 && gc_auto_pack_limit <= 0

When that check was simplified to just checking "gc_auto_threshold <=
0" in b14d255ba8 ("builtin-gc.c: allow disabling all auto-gc'ing by
assigning 0 to gc.auto", 2008-03-19) this unreachable code should have
been removed. We only call too_many_loose_objects() from within
need_to_gc() itself, which will return if this condition holds, and in
cmd_gc() which will return before ever getting to "auto_gc &&
too_many_loose_objects()" if "auto_gc && !need_to_gc()" is true
earlier in the function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 020f725acc..8c2312681c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -157,9 +157,6 @@ static int too_many_loose_objects(void)
 	int num_loose = 0;
 	int needed = 0;
 
-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
 		return 0;
-- 
2.21.0.360.g471c308f928

