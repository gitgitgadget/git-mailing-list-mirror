Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D971F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbfKHUIW (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:08:22 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:46237 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbfKHUIW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:08:22 -0500
Received: by mail-pf1-f176.google.com with SMTP id 193so5294916pfc.13
        for <git@vger.kernel.org>; Fri, 08 Nov 2019 12:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFcskeK39zI/Kx9pRRmH733yXbwEjoBswMN4ngcWmpU=;
        b=edY6YZfGxSfkf2tuHdwndALUzCIUnEwT38FtNezAMjJj+Ghjv4Cing/LVRiBMzOUN0
         wlUj+FMzLMz9FPoI5vJjYRBuAyNu3Ao/HK0Uz2mxpiWFimXhrVMdSOHkFgNKyCc/MJRS
         kFTGp77bGelxJSKuVebJ/fDJqrXx8OVe/w4l8eiz0C003aDyuPMuutEHceH/y3Kq/jB6
         fA+Uj06QRCmXpQqiz0KVTFye0Fej2YakawFUGGAc+sIFT5JVOYlpys/TfOJtBDHerW2R
         5jOBDfoAaIsb9yGFpb3nLnRRbB4s7vbahC7oI5BRE+S/TC4nULzeMyaQ68pGjQOnSkyN
         3ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFcskeK39zI/Kx9pRRmH733yXbwEjoBswMN4ngcWmpU=;
        b=EoY1UtyxPxtrnXnlJnLs9JgruFDYuD0o/9frUOvYluzuwenegr/CvOWTuIjwccWlpV
         SY2HERzpVo4LzxvUHCGBqIoNhAHHHqc3ZF6EJoIRh4J9eNZWq6JGMECU5W9Ah6T6Uk1J
         8eVe22ApsWH6H5YNNpCEFHOwwcnyYptiOt3LcpmSyAw3mbPRu6SjIwQBv6DDIZw8rk0O
         T+Y7kialVNGSgqwINXdatfaJloJxH+AYEndPZ8p3ZVp6AWqJUNWxB7e9Gu3ib/DYFbfL
         zNpp1GcaReZH+Qb1OV/WoBeSWAO6WJEp5d99PquWAUYRA+ezT+Z2+PpqogSgvX2vOc4i
         dEaA==
X-Gm-Message-State: APjAAAV07qbIVCK0sGcIodRaTcIjgdLgOlYph3kyw8Dbi8hQZ8rEGr7k
        MX6UCH/CCg4J1HzdEgsne1mpZoYK
X-Google-Smtp-Source: APXvYqzc5reUz74MF/A/so+RcOmJSYWJayDHUyPug752gYD8zVhwzYYmriiwgj7WrNQTRLxHdLiqTg==
X-Received: by 2002:a63:1242:: with SMTP id 2mr13804190pgs.288.1573243700791;
        Fri, 08 Nov 2019 12:08:20 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id w62sm8023518pfb.15.2019.11.08.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 12:08:20 -0800 (PST)
Date:   Fri, 8 Nov 2019 12:08:18 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/10] pretty-formats.txt: use generic terms for hash
Message-ID: <922cc6d849ff07f8da8f7c405f8999f2c135c540.1573241590.git.liu.denton@gmail.com>
References: <cover.1572897736.git.liu.denton@gmail.com>
 <cover.1573241590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573241590.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git is planning on upgrading from SHA-1 to be more hash-agnostic,
replace specific references to SHA-1 with more generic terminology.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/pretty-formats.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index b87e2e83e6..71eef684d0 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -4,7 +4,7 @@ PRETTY FORMATS
 If the commit is a merge, and if the pretty-format
 is not 'oneline', 'email' or 'raw', an additional line is
 inserted before the 'Author:' line.  This line begins with
-"Merge: " and the sha1s of ancestral commits are printed,
+"Merge: " and the hashes of ancestral commits are printed,
 separated by spaces.  Note that the listed commits may not
 necessarily be the list of the *direct* parent commits if you
 have limited your view of history: for example, if you are
@@ -20,20 +20,20 @@ built-in formats:
 
 * 'oneline'
 
-	  <sha1> <title line>
+	  <hash> <title line>
 +
 This is designed to be as compact as possible.
 
 * 'short'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 
 	      <title line>
 
 * 'medium'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Date:   <author date>
 
@@ -43,7 +43,7 @@ This is designed to be as compact as possible.
 
 * 'full'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author: <author>
 	  Commit: <committer>
 
@@ -53,7 +53,7 @@ This is designed to be as compact as possible.
 
 * 'fuller'
 
-	  commit <sha1>
+	  commit <hash>
 	  Author:     <author>
 	  AuthorDate: <author date>
 	  Commit:     <committer>
@@ -65,7 +65,7 @@ This is designed to be as compact as possible.
 
 * 'email'
 
-	  From <sha1> <date>
+	  From <hash> <date>
 	  From: <author>
 	  Date: <author date>
 	  Subject: [PATCH] <title line>
@@ -75,7 +75,7 @@ This is designed to be as compact as possible.
 * 'raw'
 +
 The 'raw' format shows the entire commit exactly as
-stored in the commit object.  Notably, the SHA-1s are
+stored in the commit object.  Notably, the hashes are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts or history
-- 
2.24.0.298.g3e88fbd976

