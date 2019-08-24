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
	by dcvr.yhbt.net (Postfix) with ESMTP id D62AF1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfHXI1W (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37453 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXI1V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:21 -0400
Received: by mail-io1-f67.google.com with SMTP id q22so25657667iog.4
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fexot9BjtyUt1mPRwfvfi5uGzaCGXiamiNuHKm47t5E=;
        b=kCU8Dn/S0h7QEYoiv3FXxKcgE1+00gJr2X4VGk6CtTjVUCTJs0m2POoXM3bAzEOiQr
         +IPTxcGJe5z8QnvWMWkVi7jWhxi0FquPg0v/Pvk1eJOFwfonU8YpG6lrdNaDXrtaRLi7
         k4dY7XQ8Rga8I9YxEFZ00mCkLVjlgMpfEZI99R1q5YXV01/DkWJgrRJlMmjQqfEd1pml
         pneS6o7XbYJstHx6LFh5qnKjBgAfsYBPKKNHSOpRlLgEkhI/0ced+qkYEQdthgspS0Kw
         yimcdBj1O1Foelgl8ukn4c0Vf0jeIS0IyJrHRFVt7L6+Tc+iJyfzWvddVDqJmBPv4P3I
         BnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fexot9BjtyUt1mPRwfvfi5uGzaCGXiamiNuHKm47t5E=;
        b=TWm0rP3CgZhCYWMFiqyfBBBAuYSqkPnpS8MaPDbF0p9MibItksMz9V1f488oCGkd9H
         vbNZv7MlfOPcU43EeBOlwPlV9X/sdC4npYikj9WRzAKn0Womkljc3jKtOD46UFSK3Wo7
         UgeQ9jZCmj4oEmF5ydxXVN5DvrFU0l5Ze62JDPMiVWzR/DbFmAIJXaGD2oduqHBlcVeH
         q6CRLV18Y8QZeZYtsb3/1a22FUM1zgKczSPfOP9kzThtVeyYGto6UFuapTrP4/2J9BEr
         fbqD77dsYXy4hgrYO6tcKegHU0M+vqg7h2M3hkXTlp6gDCk6v7iQAPA0GpOUmGGF1ZVX
         zwfw==
X-Gm-Message-State: APjAAAW6nDiPGGWRLRRj0tbT7f/qF87V3dVezqAOhORKD7EK3pNRac6K
        XrJvwoFIfIrg6Y8XzwLDIB9qOkzE
X-Google-Smtp-Source: APXvYqzp2oHmH8srHh+PZmnATe33Wl0UPvTulYpxQf5jSBs0fPjhSCZtQDDB4q+HCZ/oG51+31HJSA==
X-Received: by 2002:a02:5105:: with SMTP id s5mr8820110jaa.42.1566635240533;
        Sat, 24 Aug 2019 01:27:20 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id f9sm3961148ioc.47.2019.08.24.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:20 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:18 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 13/13] config/format.txt: specify default value of
 format.coverLetter
Message-ID: <7c8522abf2aca59615e68993345c61e255f3a0c2.1566635008.git.liu.denton@gmail.com>
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

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |  1 +
 Documentation/git-format-patch.txt | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..cb629fa769 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -77,6 +77,7 @@ format.coverLetter::
 	A boolean that controls whether to generate a cover-letter when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
+	Default is false.
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 95bc4d53ca..0ac56f4b70 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -17,9 +17,9 @@ SYNOPSIS
 		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
-		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
+		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--rfc] [--subject-prefix=<Subject-Prefix>]
+		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
@@ -159,9 +159,9 @@ Beware that the default for 'git send-email' is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
---in-reply-to=<Message-Id>::
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
 
-- 
2.23.0.248.g3a9dd8fb08

