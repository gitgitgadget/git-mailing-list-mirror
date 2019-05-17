Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1177C1F461
	for <e@80x24.org>; Fri, 17 May 2019 00:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEQA1r (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:27:47 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39422 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEQA1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:27:46 -0400
Received: by mail-it1-f196.google.com with SMTP id 9so9246285itf.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnrW+La4eX3HzQvomWyUA7+FYmydTRAfymlwknQqwvg=;
        b=jhgJbLf7ASnwH59ZUrA/j/+rZdDZSkv6Ph4GyZg0lYmE156wPejSif9v6eZufUXrYh
         OEsEYB+pRLC9NmFq7AT6AvI25pI6mhZQbtrX8AHZguVISU6o4GkhHw/jtHWCLbzlXDwI
         +ykVcvgvqOenSKtvnaSxY04Ojg/FcKM4e6ipYh9A8/9dPlRPu93OnOt4e1mNppy3hsB+
         srmxzBcUZb/OD7I3hYEYUR/M5RXqHtz41NFi7MGIrcapGEg4zxSVb56tK0gkz8MkrLHx
         h38KIez2CD7+ywAQAaMwm15tYydQjqnej6qmGsu8Xn22G2lNDjHgVHQZKGMOVPgp8cjr
         jkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnrW+La4eX3HzQvomWyUA7+FYmydTRAfymlwknQqwvg=;
        b=s4FojxxNEG9o+hHwKncrG9UHgOn6TquaMCx+g5S1zk5S7VulnRG4xK/N8NieC4XYSI
         j/mSMe/kvoUOjlu6/dtLNJUFKatRQlS1ARGB3ovaaPlmjnzUY8O+2VjLP69Y3lyWqvRM
         NhWcTPJiafTF8fWlAz5mFhE2qmQyOeLKjej8yvrRkTkmqS3IGcwGbDEBd9Le6CENd3Cp
         sW/oRSkLsngWNvOr3xXEdhlj+NX/YOy/09JyvEyM52IpoVfOOmEQoMnPSpIdOoCkAWnJ
         f37WLDNSZ/cgrtmCG+muV071Cy1LVJ8K4rjzpyI9YbWa9ZEAd20Q8YJjaBvv7b9JpOlR
         Oonw==
X-Gm-Message-State: APjAAAUR2KFs/3nDwRC7UHBg1oaQKXlmqJYXihaFyXfJkJdyHHW25iYr
        QbhGYeKblxHx1iWxxeUmPPlbELFU
X-Google-Smtp-Source: APXvYqwoKOzVGIPGOVCBm42v2+cdp5B3I5ZVUk6KREUs3V5rpPoE5fCXtbMXHnixJSyiig0+IHHnkQ==
X-Received: by 2002:a24:e9c4:: with SMTP id f187mr457794ith.50.1558052865516;
        Thu, 16 May 2019 17:27:45 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id i72sm2267149iti.18.2019.05.16.17.27.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 17:27:44 -0700 (PDT)
Date:   Thu, 16 May 2019 20:27:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] Doc: add more detail for git-format-patch
Message-ID: <1082db2e1b6cdcaa13e32cf33ca0dafba9bc8925.1558052674.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <cover.1558052674.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch.txt, we were missing some key user information.
First of all, using the `--to` and `--cc` options don't override
`format.to` and `format.cc` variables, respectively. They add on to each
other. Document this.

In addition, document the special value of `--base=auto`.

Finally, while we're at it, surround option arguments with <>.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..7b71d4e2ed 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,9 +17,9 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
+		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--rfc] [--subject-prefix=Subject-Prefix]
+		   [--rfc] [--subject-prefix=<Subject-Prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
@@ -158,7 +158,7 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=Message-Id::
+--in-reply-to=<Message-Id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
@@ -192,13 +192,17 @@ will want to ensure that threading is disabled for `git send-email`.
 
 --to=<email>::
 	Add a `To:` header to the email headers. This is in addition
-	to any configured headers, and may be used multiple times.
+	to any configured headers, and may be used multiple times. The
+	emails given will be used along with any emails given by
+	`format.to` configurations.
 	The negated form `--no-to` discards all `To:` headers added so
 	far (from config or command line).
 
 --cc=<email>::
 	Add a `Cc:` header to the email headers. This is in addition
-	to any configured headers, and may be used multiple times.
+	to any configured headers, and may be used multiple times. The
+	emails given will be used along with any emails given by
+	`format.cc` configurations.
 	The negated form `--no-cc` discards all `Cc:` headers added so
 	far (from config or command line).
 
@@ -309,7 +313,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 --base=<commit>::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
-	below for details.
+	below for details. If <commit> is equal to "auto", a base commit
+	is automatically chosen.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
-- 
2.21.0.1049.geb646f7864

