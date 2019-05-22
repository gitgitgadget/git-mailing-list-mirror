Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B086420380
	for <e@80x24.org>; Wed, 22 May 2019 02:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEVCoc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35551 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfEVCoc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:32 -0400
Received: by mail-io1-f66.google.com with SMTP id p2so650441iol.2
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OVwBQkVwnw7Nqcmmmyuh2u2IOyvCnPDjnerd7B3+z1s=;
        b=XnSQwUBg9FUPLJCaqUtiO36xqE6JoJ8s1lJHqCtOVLyWgm+DJlBAtRMEeh+OrVeEpU
         VDgCBKHjRoQoI6PLwef1oYWoCuXoAxI5ugvYI2BNNJTegKpD9yMuJF3CNYgkrn+ZaeQm
         sx6eN4MoPIqPc1UVurqvfPxSmPBF8lip4dkoFppUlktyjo4mNJKG3fc0zQdmctjk4eS+
         Ud3I5xiQPNEX6an56dDFxAjsPOvPDzGjHKcAPMzQNHHUki6fxWcYv3+89gZ1DM0gtObI
         7m0ypOgbCaxRbGov76QwNxeF4/5XeYZHCTxWrXYSRrEEw5Yka6KR6w1bFy+iU2lG7pUy
         F1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OVwBQkVwnw7Nqcmmmyuh2u2IOyvCnPDjnerd7B3+z1s=;
        b=nWvxsRphvKd0p5BAq4PP2g/COJjSEO1YGtfNeCOXEp/GdgQZ5Nytkut7MCwu77mBgC
         FvxtYVJHz3Bst9IclO8fOI8FNAtUSKdFXrOxG4FhdRiO3D3gNBFWvrQM387QUyPlaOGx
         mF68UY65PN2An2d8jZMxdDgplODK9UVSoW+42CZsUAkC8Xgs0EJN1AlKz37lrNZoNcT5
         t8jBgJY0FmZNy4cCZGNlkaDOp0M8wyDgvA+fKE8MbVk+s1b3QLlilIi26EWX+xOYtaHF
         BzSXyGvUDP11lWxLCc3swJdVD+mTI1RrF1AcMIgA6uujvFaRcrhwRBXEANXg0EyNWdHv
         QBJw==
X-Gm-Message-State: APjAAAWI7l+UwChKQh3yDW8Lt08yR6eK7IZe+p55pGFvrNUZ5le55j9o
        /S/umVqFI3WqG3dFZx41IShNWHak
X-Google-Smtp-Source: APXvYqwBxNUNFKq7zXN7nktqHMKFhR7Jd3EaxWvz+wYySuR9NvCYrMSK1cs/b6pm6HV3qhJy63w/yw==
X-Received: by 2002:a6b:ef07:: with SMTP id k7mr2232933ioh.276.1558493070664;
        Tue, 21 May 2019 19:44:30 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id e22sm7522954ioe.45.2019.05.21.19.44.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:29 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:28 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] Doc: add more detail for git-format-patch
Message-ID: <a8cc599fd2c6714c92e21d4dee9763c353e5f550.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
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
2.22.0.rc1.169.g49223abbf8

