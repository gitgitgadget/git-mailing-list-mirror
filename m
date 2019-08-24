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
	by dcvr.yhbt.net (Postfix) with ESMTP id 019181F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHXI1U (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38695 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXI1T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:19 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so25688063iog.5
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t4FscKSUAFYJROFmnFKe37tWakj/S+S0ILgO/AMRiXs=;
        b=dHC3DEvlIO5ylHbxxgaqvV3HztM21l6nM+URWwDUn/5PIx88BofYoiH0o0MvGvvYkY
         39l//AlZpRysCyeouf8e7X9tlVm/0LZA8r7F6Ci6RdVKPCwWBbAkQpcCH4RYM4lYqZH6
         BSDEB8HpHr38rEGXHo5iCZaeZRdf3PJzkU/tf8p0tn7ZRitmuhE44wnCgeAMYUo8NGJ3
         NscUqzbqvP3TcRNbFdvbPEjuoEcEfnUli3Suc1jIFx8ahR/eBJO29OlApEwgy/eVLie3
         IEog0erFNlBHXYzD8yhu9nT8LTDQ5CCPuteKDweeGzHmU/IfTEl6Kbq86u6ErJI+iu6G
         XdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t4FscKSUAFYJROFmnFKe37tWakj/S+S0ILgO/AMRiXs=;
        b=ZF+IV1AOQ89RWenVHrkxksVTT/462Xwe12hwdu9dvsLU9ltM61nhzPTmAqhJxfhVv9
         lShISmkmSsRj7WtHx9kDEqtNkrud3aYSAPAt6J+LSYKeURKBf6Hf+bxrcG5UcEcqTE3E
         VjuTlJlUVChnPmEjoMEPr2L+Y9YKmQUOdB81on6JrnWdTaHfJcWiEdJn4Le2xvFxgcbX
         8g8XN3k2ugpCYmzpicsPYnOl/xlGwppLBxMVc5eCideg2VA3VJQUDVh2ElPeMj6unH7S
         iRqOVRahQOL4KlPfj13LGc+uwVZ79Y8CjOMc7xp2jXdsblxbjzynqgUlSkC1k4NhS115
         5rIQ==
X-Gm-Message-State: APjAAAWoytLGDiDFPSid/gAwChSOTUdkp/xDQi6Dhn8W3T2MrJLDET8z
        x62NlaZ2/pyjKVg8elBlWAt63xfv
X-Google-Smtp-Source: APXvYqxC5zqrt3j2N5gmxDQRytgI0OzNopmKwazQYe2EBxWGfs4pNezL2wxOA6R2fvNjVU38Ste9XQ==
X-Received: by 2002:a5d:9c08:: with SMTP id 8mr4241457ioe.9.1566635238218;
        Sat, 24 Aug 2019 01:27:18 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q3sm4267265ios.70.2019.08.24.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:17 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:15 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 12/13] Doc: add more detail for git-format-patch
Message-ID: <a97f861e6a9889545a61a750791257757fc5b8df.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
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

