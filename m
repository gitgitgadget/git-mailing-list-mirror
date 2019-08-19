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
	by dcvr.yhbt.net (Postfix) with ESMTP id A02CF1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfHSXwz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:52:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40185 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfHSXww (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:52:52 -0400
Received: by mail-io1-f65.google.com with SMTP id t6so8238182ios.7
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4DbMXy2z1gLsyGdOTjULdsDq3aeWkjG0a6Lp3YIfLq8=;
        b=Kvl1hBKUdqVg0mloyQRJOi6XRFsMy2YPSNUM1pp2Vb02BN2WK5FjGS3iywiuZPRYwH
         2dQ1xU2U/OTxd3gZUhqYv2ykSs3qC9VJg6YaOYDdaObF42daQM/ifOBKwfV3C7lTTKFL
         4R/T10lttn1d1WumnJ4yhT1alvuDsyKhE+3yn5l4AUmsn3ehreW8b/SxwX1MsxhJTZCt
         LfYFPuwvzw3R5qBj1SrgCEkQzaMaE/nz/ljDGkfWgB1tmfAmRSY66joaC8tO8U5syckB
         XVW9slpx3vWe/uBJnzoB9wzS3AWWL9L8arybegaxW2u2T6uVZPjxfOq0w5yrfYKTaQBq
         aWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4DbMXy2z1gLsyGdOTjULdsDq3aeWkjG0a6Lp3YIfLq8=;
        b=IzXqFhifdVbKpTYQXT3rKClcdJxwaQakDuifK+2R6bvpDKigkfXMaBnqPA8lr/3cGu
         HnD8894DftnZf84ovDMOHPN3CBDYGCyl/oU8J+5azHy25gmqhPRiSei9x1n6bthiB0cD
         h/fiHJCySDZAzebtmGZjbxedB7JdIatAa5zCezmY7ycmntmSF3k5D/Puiz0Q6+aKp7Qp
         dOtf9EVblmwvK1OUvMkaRjf2MZeoNdKfsjBfXjk2lrGKv1iZAeDSkf+cUjsvB5HaiW4g
         JQcGo7lxVvY4qIpYGArNnACr6b5DU+ci0Ef5rv+6mXMwYWM8rUZGgW6rxKkKkRYGAP6S
         X4Aw==
X-Gm-Message-State: APjAAAW8wZNrRgkOgKTxiJUluDi4N7f8/n4kJe+GIe5CporpIdZ2oKe8
        GWPKIz5C6F5EjovFlByhDyiXpyNA
X-Google-Smtp-Source: APXvYqzuMzNm45oLXoKcGefggu4zLcDw1d4bALqF7BqevnA7ZW0Tw1WdkAqVdrZ3M1hMlf1O7kPm/g==
X-Received: by 2002:a5e:d70a:: with SMTP id v10mr7825706iom.19.1566258770791;
        Mon, 19 Aug 2019 16:52:50 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id n21sm9804863iom.69.2019.08.19.16.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:52:50 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:52:48 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/4] Doc: add more detail for git-format-patch
Message-ID: <fd908bcc01884469dce966fbc384d6982687b4bd.1566258525.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566258525.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

