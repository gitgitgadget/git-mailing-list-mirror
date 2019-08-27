Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB1391F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfH0EFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46026 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:21 -0400
Received: by mail-io1-f68.google.com with SMTP id t3so42918206ioj.12
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STrhgLV+GP1f/OkDRDYo2571zVPeQnjc85O1EKDAM+k=;
        b=us902jgduWEd1oV4ZOMDX4jZNiIdXMkmbOKnuj/VpM21V5OCbtnG0ZZpi5gLeWpRzx
         xKixut2Z8EJZhvS/g40QhNFkupgC4DGITVIeVmUTxOloqL8eGDpU/MoVETPn5F7SPok5
         6ULs0aKGwL2GPXSJWq/Gvl9T1KJPkl4fljS2bdatBF5duZjhK35lhlY0+XVsYSWl2CQj
         gRXaLEtEV5CUuXlZjFZEN6FOTje7l5KZ1HJkez1N8k9ro3/XJlNC9wgUxfnD7hqKxl5d
         /eFM/vug3zwTt2duoSo3IAOFAEJL0uu+vfSe4Ai1sorvR2bgoR9AL+/RxFnUS8T2uIK4
         TtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STrhgLV+GP1f/OkDRDYo2571zVPeQnjc85O1EKDAM+k=;
        b=VlxuMZbS2VJhxqJDbDMmYbQYEJqXu2uyXUl/QtX+CV0Y/tCanw+TjI7c1NeHlhtczg
         0+so19JiUZ8bn44nb4Nm59sGOcrRT7bo/uSkogvQlKy3zFdzxGzS2uVNLpv0aZa72jVg
         FaMe1t/OTnsGTPV6Zp3gE0Nlmrr6VHrVwLxBVMm2roFUQPQah4MSZLLgB7KHNTQpYQOj
         YNMs8TrbyC9p+/V29KnXUfYQdnGUDl/3DrxDECDhkddxWSmSRZx7wUNB/MHbbKpjB696
         fJSWW/w9nmIIgvEfMyyttjAjCGb1jJJazomotgEzmOucHeHiV7lUkqvXpPowHUimqUfx
         n3VA==
X-Gm-Message-State: APjAAAWLLOlW49nhf3PPo4vLw/7Ke/QiGRyubIUatLdlTbuj+sTAFkED
        Wf7ukzW2uAHplG/SVY24g2UUUR+V
X-Google-Smtp-Source: APXvYqyhnnFlM5ErwvA5U0nWn8sIPImuPjQ4FLDdMSQFFAhXxmSvPtpyz+7P4Rzw2GOdwiCmGh7BhA==
X-Received: by 2002:a6b:e511:: with SMTP id y17mr4834407ioc.228.1566878720076;
        Mon, 26 Aug 2019 21:05:20 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id w6sm11701206iob.29.2019.08.26.21.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:19 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 12/13] Doc: add more detail for git-format-patch
Message-ID: <fd343b99c5bc3a73c3896805ea4283c9f39a9d04.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch.txt, we were missing some key user information.
First of all, document the special value of `--base=auto`.

Next, while we're at it, surround option arguments with <> and change
existing names such as "Message-Id" to "message id", which conforms with
how existing documentation is written.

Finally, document the `format.outputDirectory` config and change
`format.coverletter` to use camel case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b9b97e63ae..0ac56f4b70 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,9 +17,9 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
+		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--rfc] [--subject-prefix=Subject-Prefix]
+		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -159,9 +159,9 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=Message-Id::
+--in-reply-to=<message id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
-	reply to the given Message-Id, which avoids breaking threads to
+	reply to the given <message id>, which avoids breaking threads to
 	provide a new patch series.
 
 --ignore-if-in-upstream::
@@ -171,9 +171,9 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
---subject-prefix=<Subject-Prefix>::
+--subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<Subject-Prefix>]'. This
+	line, instead use '[<subject prefix>]'. This
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
@@ -314,7 +314,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 --base=<commit>::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
-	below for details.
+	below for details. If <commit> is "auto", a base commit is
+	automatically chosen.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
@@ -330,8 +331,9 @@ CONFIGURATION
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
@@ -343,7 +345,8 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signOff = true
-	coverletter = auto
+	outputDirectory = <directory>
+	coverLetter = auto
 ------------
 
 
-- 
2.23.0.248.g3a9dd8fb08

