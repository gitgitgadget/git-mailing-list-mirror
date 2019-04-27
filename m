Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECA541F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfD0MQK (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:16:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40813 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfD0MQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:16:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so2827472plr.7
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mx1UzFMzNKALVI1DVETOr4VjO0FPdiQEYI1RE/GGvcM=;
        b=MQKdQhQlLMci2jBBikTbYd3fMmCq6YtmjRVNG2v2pzwLfKbNlZR2i1LJnd6Nq5LhNM
         LZgDrtPQ+rRVmfoDJGz0QaxMAXUjyCgGfNuR/M0ONPkHxM86IJP8roFzjI1b+iq4tI1j
         QcgqloI7LBJg9S424ZMTp/v3uYw3PM910AzCwyH+6pNEVWf+BaU2BiqvDG1rU1LFmReQ
         nTV1qQTtmSzFWmA1427y0TmqngcN0oydCQMJPZECdpZoP5zNDZExiYS8FEWW1syTJWzy
         PRqCLcqA9RJ8NMzKF6vl2qbg0YBMhmHgLJw13ZO/FMwj9/vFKWhiubHKlp3pbo/Hgtzj
         j/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mx1UzFMzNKALVI1DVETOr4VjO0FPdiQEYI1RE/GGvcM=;
        b=fnVYwj5ehes/g2FmymyXIexRYHWa3UmylCNTVNGFIoxAFtU039ACLbMr5QuNe2r5vb
         XKk6KDvOI0mrETjMdcsGln7yNjbUv8+vw9uT7m8xf78vAKBROZR8S1PM9MXkIMCUrJjx
         bPaRyuarcBRqJhswWO+IaKEPjwpvZcIOgfp85ixNA5O/8zie3s4XXebianCubd7GJYJa
         bEcfTUtGo2IgPLmLsnT8DG76xbW/hQAYmPRNFhZY4hLJtQuEI5UvTHt7ONrmZxMfTGWh
         5QPt6OA+2uDyMyU0E6nQInzOZt8nzzEMzxiFvoqGwSdPFDBBJyYZ/gK+Cd2OBOTpTAVz
         BsYQ==
X-Gm-Message-State: APjAAAUcvM1uMc0bk2Oc9xj+NYPmVH4REqLTEJ0aKAC7JdOz13gdDgG1
        oyNDjr67HyfkflMqQIr5mmuJS3bj
X-Google-Smtp-Source: APXvYqyNa8LLuTLSZIkYtIoLePXJbU1Phzoq+TG/b9Tm6iKC867iQiER9WuzIaePYwtcrVKeJaQVIw==
X-Received: by 2002:a17:902:bb84:: with SMTP id m4mr15568821pls.302.1556367368932;
        Sat, 27 Apr 2019 05:16:08 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.1])
        by smtp.gmail.com with ESMTPSA id d129sm51980947pfa.142.2019.04.27.05.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:16:08 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:16:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] revisions.txt: mark optional rev arguments with []
Message-ID: <90c787c219d25f38c1d53ae837160994a7bc6355.1556367012.git.liu.denton@gmail.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
 <cover.1556367012.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556367012.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In revisions.txt, an optional rev argument was not distinguised.
Instead, a user had to continue and read the description in order to
learn that the argument was optional.

Since the [] notation for an optional argument is common-knowledge in
the Git documentation, mark optional arguments with [] so that it's more
obvious for the reader.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index e5f11691b1..68cce2ca06 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -95,7 +95,7 @@ some output processing may assume ref names in UTF-8.
   The construct '@{-<n>}' means the <n>th branch/commit checked out
   before the current one.
 
-'<branchname>@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
+'[<branchname>]@\{upstream\}', e.g. 'master@\{upstream\}', '@\{u\}'::
   The suffix '@\{upstream\}' to a branchname (short form '<branchname>@\{u\}')
   refers to the branch that the branch specified by branchname is set to build on
   top of (configured with `branch.<name>.remote` and
@@ -103,7 +103,7 @@ some output processing may assume ref names in UTF-8.
   current one. These suffixes are also accepted when spelled in uppercase, and
   they mean the same thing no matter the case.
 
-'<branchname>@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
+'[<branchname>]@\{push\}', e.g. 'master@\{push\}', '@\{push\}'::
   The suffix '@\{push}' reports the branch "where we would push to" if
   `git push` were run while `branchname` was checked out (or the current
   `HEAD` if no branchname is specified). Since our push destination is
@@ -131,7 +131,7 @@ from one location and push to another. In a non-triangular workflow,
 This suffix is also accepted when spelled in uppercase, and means the same
 thing no matter the case.
 
-'<rev>{caret}', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
+'<rev>{caret}[<n>]', e.g. 'HEAD{caret}, v1.5.1{caret}0'::
   A suffix '{caret}' to a revision parameter means the first parent of
   that commit object.  '{caret}<n>' means the <n>th parent (i.e.
   '<rev>{caret}'
-- 
2.21.0.1000.g11cd861522

