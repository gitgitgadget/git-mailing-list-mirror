Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E681F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfEEQHI (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:07:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55162 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQHI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:07:08 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so16696483ite.4
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSGrZXrIo5OuwYEzVKI/rvG/GRnj2MKVOwqwKsJyQUY=;
        b=eiEX76sU9EEqpRtHyG+a4e3r4od4KVEdxsJIRmtuI66XN1GjDIDJnb1Do0wet/Iel9
         XwaFNL9Lvljf7idCFIJc+ukbAHbepRdqrzqN9dPJ8o/M5+/tZfotXdILKaQ/xTZCY1p7
         XqgHhcUAfVmH9EMFY/G61MUU0iAmeGdINSvuLaXLB8kyEnWothQ5QzTDwlz1Rd03Yuv3
         TcZBp8J2enGTpNCQtKL+TGZA6vthDkwAjQ0bORrkeb2mgUvYhHk5InRQl0ezFk8qMDCW
         bBTfykr7V22x4Wq+EETHgKlnoRVuwK4Kv4k9ssXcQJQKUTuY9F0qHq11B6wYTqq5bgWd
         c71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSGrZXrIo5OuwYEzVKI/rvG/GRnj2MKVOwqwKsJyQUY=;
        b=ndWih0OSfv2cpr3K/l3zl6o0Zw1+gSfk6Jr9r3/ede9racKUfHAQwsWpvKOSFGVSRk
         OzUBbOnIVLQuVg5NVf6Vd2BBiyqfMsxpnRI32718e2lO8EvXu5Vfv5YbuWIgKFFwVN1X
         orK7NK7ECeo7pjCyQbGsTxjVnbdTavo9Hg8VPwHUiCZKYDprEqC7r4YQZImsg4lQIna4
         omJ13qGvw678TmRYmjr072ZOnfIQH+rwN5kFe1b5NTk9HkkAxRIUb0dnCqXCFsq47tNL
         FOV5cZPY/3nK6BMSXTypht+zgWr04hAsDawsHbnbvZP4tCacspNCnbqG8sNM0SOtB5nj
         F+Og==
X-Gm-Message-State: APjAAAX0CDxPOEtNmfdTM4DXJmTBlkqbcoK3qEt/BmtJs8YN/jQgKtkV
        bVBJRfZXC7dzCTqOsR+zcfMGpZMD
X-Google-Smtp-Source: APXvYqzooIV8RzUb4RHsoROgzCipLGQKQJFIrCpKzmKgZCKPwpKhbCfhm+HtOdVrI82TyBGKziy4eQ==
X-Received: by 2002:a24:68c3:: with SMTP id v186mr11604725itb.128.1557072427045;
        Sun, 05 May 2019 09:07:07 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id n199sm3799585itn.34.2019.05.05.09.07.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:07:06 -0700 (PDT)
Date:   Sun, 5 May 2019 12:07:03 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] revisions.txt: mark optional rev arguments with []
Message-ID: <27379aaea940385a7569c1b8a4ff1aac3fc2c05f.1557072286.git.liu.denton@gmail.com>
References: <cover.1557071877.git.liu.denton@gmail.com>
 <cover.1557072286.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072286.git.liu.denton@gmail.com>
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

Helped-by: Andreas Heiduk <asheiduk@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/revisions.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index e5f11691b1..dd99770c47 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -65,7 +65,7 @@ some output processing may assume ref names in UTF-8.
 '@'::
   '@' alone is a shortcut for `HEAD`.
 
-'<refname>@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
+'[<refname>]@{<date>}', e.g. 'master@\{yesterday\}', 'HEAD@{5 minutes ago}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
   pair (e.g. '\{yesterday\}', '{1 month 2 weeks 3 days 1 hour 1
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
@@ -302,7 +302,7 @@ The 'r1{caret}@' notation means all parents of 'r1'.
 The 'r1{caret}!' notation includes commit 'r1' but excludes all of its parents.
 By itself, this notation denotes the single commit 'r1'.
 
-The '<rev>{caret}-<n>' notation includes '<rev>' but excludes the <n>th
+The '<rev>{caret}-[<n>]' notation includes '<rev>' but excludes the <n>th
 parent (i.e. a shorthand for '<rev>{caret}<n>..<rev>'), with '<n>' = 1 if
 not given. This is typically useful for merge commits where you
 can just pass '<commit>{caret}-' to get all the commits in the branch
-- 
2.21.0.1049.geb646f7864

