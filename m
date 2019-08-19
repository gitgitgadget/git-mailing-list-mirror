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
	by dcvr.yhbt.net (Postfix) with ESMTP id B6D4F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 02:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfHSChl (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 22:37:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35197 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfHSChk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 22:37:40 -0400
Received: by mail-io1-f68.google.com with SMTP id i22so807575ioh.2
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 19:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSgcLkGjFQvkbemdd0RfcKQtgdzFOOG5Ggqz1dwOXjM=;
        b=TZMo8txQgWvxTmkHDlm6BETaTXreFAFNjtMUqoM3NOkgTPYNSDCBIWYuB0EBVkSeTZ
         2viSH1U6GbQPVgkGJwLoT4kabIqzlHDqw9U0v4vmTcxa5gMCj2cVXE2ShNxMjpsPAz5d
         pk7bnkW79iU3ndMVuzKYSBW/86HHpc8o3ANP/dewWnCVFFrVUGcP+uBtlNmvVrUlC1Ca
         /Zxeleqy4nhC9r4AoBBh2DqeI+tmYzzzM2aASW0mKQV0yvJFPPUOHSVlVnksJTJhyVuC
         srRZ/GGHK9gMNHjEfyjHpUCBHWWnEGgnI/2bLp60+5I5GqYuKoKNee4TNIHiyb4Xso+W
         d4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSgcLkGjFQvkbemdd0RfcKQtgdzFOOG5Ggqz1dwOXjM=;
        b=aaXm5FfFTHF5UyQPK5twgTnteMJRBto+JWIZEUVbjUejWtf7ktp2tw4cHKGALuRWmX
         xUCqZW/HSRnOECAkfkTcqGnFI4Ba+voR0JvynaIasDfa9lLDWeiCNlVvV7kY1mZI7QZq
         2dsrhx0UTWUwXOQSbLWrT6EHDsTpa6rSw5vcAkNt2xps8K5Dzvkfqaza74rh00KBeaO7
         KLPZf4Ch/PDQmIiXI0E4hmyW9MPyLvpyFWG05y6RblycYqTdlylXV4AswgSJhXmL3yRq
         Aq0yn7evzdeNnNOLUZsO8u+AYhib4kJGBCt0OlKAofukbYEz33mYi1UYyJ1fBzmuwgJg
         UMgg==
X-Gm-Message-State: APjAAAW1ONa/pm0//hbPcjYe/X0Y8SwbqgthCB64vnldMRrTWxqCRs83
        mByMTQP2OIwMB1P7L/JByGBD0Wc5
X-Google-Smtp-Source: APXvYqxiXscpnXCdbc2qGZDv4OSg/B4Q2d54a1OHiJhkB7gAzz4DLzx+lW4qOhLF0GmYqnp4MXK5Xg==
X-Received: by 2002:a5e:9747:: with SMTP id h7mr8299214ioq.299.1566182259412;
        Sun, 18 Aug 2019 19:37:39 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id r7sm11071408ioa.71.2019.08.18.19.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 19:37:38 -0700 (PDT)
Date:   Sun, 18 Aug 2019 22:37:37 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] Doc: add more detail for git-format-patch
Message-ID: <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
References: <cover.1566182184.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566182184.git.liu.denton@gmail.com>
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
`format.coverletter` to use camelcase.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index b9b97e63ae..0e2dd59c0f 100644
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
@@ -193,13 +193,17 @@ will want to ensure that threading is disabled for `git send-email`.
 
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
 
@@ -314,7 +318,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 --base=<commit>::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
-	below for details.
+	below for details. If <commit> is equal to "auto", a base commit
+	is automatically chosen.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
@@ -330,8 +335,9 @@ CONFIGURATION
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
@@ -343,7 +349,8 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signOff = true
-	coverletter = auto
+	outputDirectory = <directory>
+	coverLetter = auto
 ------------
 
 
-- 
2.23.0.248.g3a9dd8fb08

