Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2431F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 20:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKNUrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 15:47:13 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46589 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKNUrN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 15:47:13 -0500
Received: by mail-pg1-f180.google.com with SMTP id r18so4512400pgu.13
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 12:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpOYn5mSIQBBTIVObG1RgMlnl0Xx7hwE0GdlRzlKgFw=;
        b=aq9s/98WIx/pAA0QqzqWjiKUWf0B2Ob5vZHWj6yVDVGx83/srSi2p9UhDkWM87idKQ
         4lqmCA4IHccu94Z1wOJw3dFsmT16JhKi1Q/XdtMvDdaUG0UzkDb07/AZaofyDxZ/EtyV
         J6KocKJ/S32ysGFdgIR1pDvfrGUdIicAzuop7d/Yr7dy03MJWMMowA/TR8F5rKLJptWZ
         acq+4MH7tnwd79FbwqpAIiZe8mlkMF9p3gOD8egiJy6IJ4D3YssE6MZvhs8mxv58NmTC
         Jk2n3iXokwShiKGxfdFpxwTqgRMhKf92xl8p9ZBLcBVSU7Y9rzSWB0EXvBnnjy9K2Ipg
         LaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpOYn5mSIQBBTIVObG1RgMlnl0Xx7hwE0GdlRzlKgFw=;
        b=Ub7wZ71wbKbUzulR9NpHli+bqlfzqldnb0w77cHXAJbkIO97qHwWhS1C3DXoOTEPLu
         IJ1jwlC/AvgMXSZy2xg6fxY2AhS+leJLj1FR68b4iBqM36FKQP9r0VvGN4G8CzsUaePY
         IVyaByLBUbS4purvmxi7BI7+xI4VzH5yGO1eVL0OW9NqQH88jcAobZcQqJS+JqcGK5JA
         DoEcMgKE82hOYaCyhqVvSJ/lVqmX1Q3/daF93GwmnSRN1ZQVLqqLEe0NaDZ7rbjUw1ia
         UDLHjqI/8KTz2Ju7oaNdoR5MBi3ZIfTuRZSKvkYxGHW6JbGKXCPCXxmFqaJBSjymqGrT
         DY2g==
X-Gm-Message-State: APjAAAUbWJNGBnCTnjnrMQXEzAm3yPAOZAFfdbVjnsRQS7YZkDo7I/42
        UwZXxoz3NEOifIT6jtXbWfg/RT95
X-Google-Smtp-Source: APXvYqw+l2+/xmc99xPUp9cppR2n/d1tLEJ8MiJjkL4YWV75ib0/iZgkr/RJ+Kd+6OsmVKhRpWmoww==
X-Received: by 2002:a17:90a:1:: with SMTP id 1mr15305935pja.42.1573764432421;
        Thu, 14 Nov 2019 12:47:12 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id v3sm9584239pfi.26.2019.11.14.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 12:47:11 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:47:10 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v3 02/10] pretty-formats.txt: use generic terms for hash
Message-ID: <4f2a9bef3238a4fe58b5f1e0cb96809669f27882.1573764280.git.liu.denton@gmail.com>
References: <cover.1573241590.git.liu.denton@gmail.com>
 <cover.1573764280.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573764280.git.liu.denton@gmail.com>
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
index 31c6e8d2b8..4cefa64eeb 100644
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
2.24.0.346.gee0de6d492

