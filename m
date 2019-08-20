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
	by dcvr.yhbt.net (Postfix) with ESMTP id E53A11F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfHTHTP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43754 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfHTHTO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:14 -0400
Received: by mail-io1-f66.google.com with SMTP id 18so10042879ioe.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4FscKSUAFYJROFmnFKe37tWakj/S+S0ILgO/AMRiXs=;
        b=lmysCh76a6KMlR2DqpTFOIP9zMdwRCu/Q3OXO3+cB47FBQqGIhiGOFOCjwcAekMipo
         K+xfxQt180XqvvyEtCDme+lQHaKh1ADGhxbEq6KqBiuzRzCRk5BHXKpzXhp/z7LmV5QC
         sOW4Sa/Vw3KvmekTC8BT6AHniotV61UPKPlymQNfsju9//c8f+wVW2kYP6nmJDKO3Wsz
         tVgBlNqaGNzIp8tvZcFGxYcEEVsyG7tMztYQ5eO0QCWn0fEH40IxyPuM41CIRYHlxzfB
         MXjjnGguU/N+GTFoRrlnpeu4ldadQrDY7frylrzDxBKoT3UKwAadMPIJqNRyXBXFncQx
         ekLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4FscKSUAFYJROFmnFKe37tWakj/S+S0ILgO/AMRiXs=;
        b=kHYwf4Zzof/hkWaKIuC0PU3nchXgiPEdoESiY/t0BhEn9zw0JD2zzbwxf2dQefpC54
         ZDqcJSjda9EEaYN885lBEnavsJr+RWI+U5hYrVjIZdCvfEpPSMq6yYJLTSN3Zhg9962N
         /rrSUFxIwDcqJJClax0pdThJaMnMn2yl7tNbIZHfomiEt2LBQ+jF0fPipJ9qTVMKCtYD
         tV0uVOQtB2CiWN5AQvkyo3X7BxkWkZe0qbZwqowxVFzxvN+hOqdHoZUjI9niwSiuLQjB
         2SXAe5ckd81TJNOA1JqmhTcC6RN1WzQPx9pheanTLTaob7pTcAgsSjMVCJUiwmeoCWiC
         SpCw==
X-Gm-Message-State: APjAAAVdLB5MQMIVB/t0CttRkMVb6Bb4bKau6CcLGvFTT02GeHf6r4UE
        VftE6NDR3DBwEbNpT2mwkPWbHrQA
X-Google-Smtp-Source: APXvYqwcAsxXgmOZrZUDk8fU9ovYEV36eYOFb6oJAmMKZf/UI4eGv088xflIqZIg3NSdUX85Wz+mMw==
X-Received: by 2002:a6b:b3c3:: with SMTP id c186mr30705213iof.76.1566285553416;
        Tue, 20 Aug 2019 00:19:13 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id k9sm17273885ioa.10.2019.08.20.00.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:13 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 11/13] Doc: add more detail for git-format-patch
Message-ID: <c12534ab5dc67bdecad45e10d45d428bc783cb09.1566285151.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566285151.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-format-patch.txt, we were missing some key user information.
First of all, document the special value of `--base=auto`.

Next, while we're at it, surround option arguments with <>.

Finally, document the `format.outputDirectory` config and change
`format.coverletter` to use camel case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b9b97e63ae..95bc4d53ca 100644
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
 		   [--[no-]cover-letter] [--quiet]
@@ -159,7 +159,7 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=Message-Id::
+--in-reply-to=<Message-Id>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
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

