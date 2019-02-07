Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCB61F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfBGKeF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42761 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBGKeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id m6so1140051pfa.9
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWXSQ3BXX1mxZ9i3qG3ZQkSM38NL1qdlRSw4Xz6Bp2s=;
        b=RUFSwxWqyiKBGpZI5mONXM2uJUXt23XDRCoF7veJ6ZLj2O9ugZtAGeZccWJfLEWQYD
         Di8QrWJVnUU9RuwZ0ldFOTV/AhS/HN9LsXSaQD4mve4L8Sgm6xCzvyryx3uqymS9rxRU
         FOlYgsZEMW3XyjYITS6ha2nwDMXstYTZdfZX7IvYJAQSRcrweO4CwMnxXGZHwumiJ+Pt
         j9/QwSYwjiZy3WNuh+HHPZkniDsLAt3TTltCAUY0L1wUpsiaL05ZIy1krGKujNOr/qWw
         qmvCbft1B7wlUnlsCvjJ+gp+c4776xob+Eon6LDHeWAZh0rYmy9WqPh88Z2++oIhDy+6
         wKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWXSQ3BXX1mxZ9i3qG3ZQkSM38NL1qdlRSw4Xz6Bp2s=;
        b=D9VhAH2UMCXpQazb5iA3csBDJ1VcVJeVlorfaYuA6pmxDttw+jI2DQjpAA9WZPoLy6
         QwYpBPhP0FqZpAPP1MjQB1UzDglYkYACprjvSy90z8IXryNl702AqwcQeM7nQvOqF5nb
         eMftCxNbTQM83QAAuHhJgTBhnSAWaObGVm2NCRjJn1yfIz6yff4ecFo+16TwHd17FupJ
         1ooKIMC9Iq7QuTG8ug86K0Ss8sA4RiMKSOha1KHa/5A49rNli6hEaPckmKujAW9DKb30
         s1U+e0HUapl/Ta43UVhSl0PBW3cnELHQQ3Om62takGG5Prtb/Qz+frFDNc2wOoRvULRQ
         esJg==
X-Gm-Message-State: AHQUAubQKZ1N1HYnEtYemBPLTFCaRqhLtzdk8cOn5v1CXEE6rL44RCjW
        BAiS3gjUyHFIiq6zqqMByb/T6XWH
X-Google-Smtp-Source: AHgI3IYg9iW70cJ4fuMxYEQlrwOttVxAKPoZnClLlOZgRY6ZPQnuwH2Pi0D86qCGrz89mMs0m7BpYw==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr14293680pgm.254.1549535644047;
        Thu, 07 Feb 2019 02:34:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 7sm12650417pfm.8.2019.02.07.02.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:33:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/21] diff.c: convert --check
Date:   Thu,  7 Feb 2019 17:33:09 +0700
Message-Id: <20190207103326.10693-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 1cdbe8e688..5e16082091 100644
--- a/diff.c
+++ b/diff.c
@@ -4939,6 +4939,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("synonym for --dirstat=files,param1,param2..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
+		OPT_BIT_F(0, "check", &options->output_format,
+			  N_("warn if changes introduce conflict markers or whitespace errors"),
+			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4967,9 +4970,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--check"))
-		options->output_format |= DIFF_FORMAT_CHECKDIFF;
-	else if (!strcmp(arg, "--summary"))
+	if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
-- 
2.20.1.682.gd5861c6d90

