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
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DD41F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 00:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKSAVQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 19:21:16 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:44356 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSAVP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 19:21:15 -0500
Received: by mail-pj1-f51.google.com with SMTP id w8so1991337pjh.11
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 16:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NvHv4lbY0ghqJnrRZDpfM6W77BK71ZLTJGL1W/WWfw=;
        b=VpwteN58nF7PZYHEQPPhtSebiV/4Y9Xgd4WJeblsBMHdeJNiq8jlsjbrlS9snedDuX
         PPOXmNGFZThUwNa+PewEQxIeU1+ytSv4kFsRmXl7N4VtEjLXMlQJOPNxVPXEc1fZGBe7
         OjukG3irkI5U/e79eqXQUs7wgWFBrik2TyZWAHH8yPJyJK0q6G0p8k4oup/EelivMLy2
         aM+147SYgJrbZTRI5I+LlFroG59qtScIKDTZWCiqlxSVAuPFk7nmhMLPeFdTC2eUsoLA
         IEG3EK+CZSosUVGEVN5iV2zBUvcgPqPtDf6PdNdu9dO6f5VUfz1ky+tbGVMSSMwEBZc+
         iHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NvHv4lbY0ghqJnrRZDpfM6W77BK71ZLTJGL1W/WWfw=;
        b=nt7BJXgcFEUDNnzTG7sSWWVwXgzp2RP8g0Cc7jhXfCgYdUVlTUq0pf5ungXdn6NF3t
         g2dbMG1vEaHK9rLLA/hrnLZjBBv1pi0XvErW5A3emLBdwXzoHjjG982lWaHDqn7ByO3t
         +oDZAikpXyi+ze7P4JsZH99HncaL+y9XpqkLUii4fKezLxJHPYwTEPzxK246lRLEbazP
         mEX3w9kXe0lT7AnyeKypU0JfbtLsylQQjlVHVg/ctTbpJH3VZV0xz2SudmM9aTT8wX3t
         MuP/QiRgwLhRgX1g6oWw+lfuXLBo5QWN0rAQ/ZK4ub2brAJCv99CIAsQsTk3wVWQd29S
         U7gg==
X-Gm-Message-State: APjAAAXH1CqCSI6fkVDg+v5HROK2Z19jf9klqJ/UFQJ2aO7DrUb64mZe
        FHl5u9EK0EHgxHGjv2ltp4QJRXsJ
X-Google-Smtp-Source: APXvYqxadOD7776cFRgFOer+Dan3bT8pmcsAvKZf3AWHYDCzbQXs1dJ3Guuzi9WCgRCiCO/m2KyyoA==
X-Received: by 2002:a17:902:7292:: with SMTP id d18mr21272325pll.206.1574122874677;
        Mon, 18 Nov 2019 16:21:14 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id 190sm4493076pga.65.2019.11.18.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 16:21:14 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:21:12 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v4 02/11] pretty-formats.txt: use generic terms for hash
Message-ID: <2cc7cc6e75cfaa4dc62f95027bc1192b973a5c69.1574122784.git.liu.denton@gmail.com>
References: <cover.1573764280.git.liu.denton@gmail.com>
 <cover.1574122784.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574122784.git.liu.denton@gmail.com>
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
2.24.0.420.g9ac4901264

