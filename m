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
	by dcvr.yhbt.net (Postfix) with ESMTP id F05E41F609
	for <e@80x24.org>; Fri, 14 Jun 2019 21:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFNV4U (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:56:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35559 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNV4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:20 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so9063462ioo.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bycWu7HVz5EFiPjoDvrvWSXGnX9GWvWGKWGX20az6iQ=;
        b=LX7McKCyuW4xk1Mo6W9xzq/q//UAlAqFwG5bkYSSt/PF3HQw4GU3KCbRj3b15TB4Yn
         U1cjy64qDP6YSKoZgbyKCF8cejnOsHVMpywNzHvOtzegY5n8J61/Aky17JcfJjmRWZcV
         5VgoQNnIRWTfbc0hDKrkdTjOKfsyLePpWP2F4cpV/WEhe+rYuCcAwvCQIrdXLe+gVXU7
         4so6E6OIxBpIzWl0P01wf8Do1vM82bS8DV/P6hdVQLrE/fAd4Z66Rcz73FKn2FB/+Rjt
         uf9cV4DJGPZxlvSJ3wMVadLPaphAxX+H0ZtfVvpttxvCtELtfkv6IsCb7I18wlc72g0F
         uPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bycWu7HVz5EFiPjoDvrvWSXGnX9GWvWGKWGX20az6iQ=;
        b=tEWz+Xy7ZYUJRohGxQ8VP6cibdyHmYTHKL7u0aNTScHbDBAMEc4ISW0KGc74i7SWE/
         CQ6ZSPoTWG8ALNA/yHUZTiRGwAwtBzaQ15uq+CLjLcNhocGY25VpWeGORW60+JEbLzJC
         uoNmdEWwDhZXYPLA5ZY0dftVYREkanq6dgiMcCzvfwaZ2/u9vDVtKH4rkvXIxebZ58Gd
         EaTRohJugt3gmBMnqaGMDtG/ypt1vzVT7DRwlkwlmUYRuZrr86icUolthmXQs5FqKYwD
         XppKUi+p6ipmIqzy5/OkVEAu5S371IvO4boQ2gfdsi+Rx9ZM+ByavjAmhwHAqs0zHM7e
         806A==
X-Gm-Message-State: APjAAAWhz7UaAuKVstDC/LzAVvB010MdICrUrpg6ExgMtSjtEtMqN2Ta
        IpfqwYjammK5MBoYoTZI1Pi1k8x8
X-Google-Smtp-Source: APXvYqwmUhlUxjoErGH30dNcdglI08dSgBQzme3WlDdOog71QQI7XVK6xaz0jekHDbs6U9RYc5Beaw==
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr4210151ioh.281.1560549378679;
        Fri, 14 Jun 2019 14:56:18 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id 15sm5433640ioe.46.2019.06.14.14.56.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:56:18 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:56:16 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v3 2/8] Doc: add more detail for git-format-patch
Message-ID: <14b40b1dec0b6d098abe99d4a64fe501cee56f43.1560547501.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1560547500.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560547500.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch.txt, we were missing some key user information.
First of all, using the `--to` and `--cc` options don't override
`format.to` and `format.cc` variables, respectively. They add on to each
other. Document this.

In addition, document the special value of `--base=auto`.

Next, while we're at it, surround option arguments with <>.

Finally, document the `format.outputDirectory` config and change
`format.coverletter` to use camelcase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 1af85d404f..4e180bbfbb 100644
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
@@ -325,8 +330,9 @@ CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
 defaults for the subject prefix and file suffix, number patches when
-outputting more than one patch, add "To" or "Cc:" headers, configure
-attachments, and sign off patches with configuration variables.
+outputting more than one patch, add "To:" or "Cc:" headers, configure
+attachments, change the patch output directory, and sign off patches
+with configuration variables.
 
 ------------
 [format]
@@ -338,7 +344,8 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signOff = true
-	coverletter = auto
+	outputDirectory = <directory>
+	coverLetter = auto
 ------------
 
 
-- 
2.22.0.355.g3bfa262345

