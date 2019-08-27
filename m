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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C63C1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 04:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH0EFM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 00:05:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33600 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfH0EFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 00:05:11 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so43084417iog.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5CZtzHBRy270Vzz6Wj11mXIU6zXYVoRh3DdTKzfWSdQ=;
        b=o+X6oV5OJWb3TfPULav7aj+c5sxN7d44LGfITm3izMPqwbDkBd8+cZ86r5mcFHUU3+
         CGL9dJMjimT0+qoMB7ymEbh7BM1CLpiNT/4N4l9ZFMSUvqQxUtxAdJvj1O/2X545BOhG
         O+hzvIpMKRaj5DcZ66mDcqocOjQUh97lbG+l5+OMgg0ZhS/LIs4lKKmIuswRDdCiH4SX
         1iFznLx+tBh5KsWRmM4JjO3TnDy432bpvRvMFv2V25dU+zta4/T/XqjmsTySaYSrC3It
         SClW1JGjgHgIOh4PlFYpTDVGxlmpsVLZBKkfr+UsoNLHKeSsf2ZKW/1+grPVsQZzzQIl
         3v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5CZtzHBRy270Vzz6Wj11mXIU6zXYVoRh3DdTKzfWSdQ=;
        b=o/vd8/G+AuojjlAipb40xvaSXUAy4QpEkx77I/9XhTpeHViWMfEiFxweuQRT1dUz08
         /ONdp80PQcK/EFEXdQLlMC2wDX37SHVRhIrsdcknsObLSI8BdwwioaZbhQo1r9wHs4zh
         b2yLeNB3CwC4ybNo8tytJ6+O+Vp+hZSaP10pYqiDaER47f1qLqfnOYdKNLlPVKKA6uS5
         lc/2Wr3JuEg2wjS1BjL/ZACvc45imoe+wVmug57K2adKkpBoAFNAY9000wsrPQ5rz1ja
         fE0JtNtmpmHcoGS7Aoybdl0zUAgMcAc7g+mEbni2V11zaNZgeEFAJ28L/AiZZTL9KpxY
         xP1A==
X-Gm-Message-State: APjAAAWItd7DfR5XPF3ZJUoI30ghnNqS4ZTueM1INTL8ECD2cpxboHLU
        vMktvLTJe42EqhaZ5pGqp1nJN47m
X-Google-Smtp-Source: APXvYqwzXqQyMwcXTrgWUMF3z2KS6v5oNiOaHP1zrrIFuJgg7rSEvpf9Nm17MqACfXBwQwOCv2e2qw==
X-Received: by 2002:a5d:8457:: with SMTP id w23mr1818245ior.189.1566878710042;
        Mon, 26 Aug 2019 21:05:10 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q8sm11443768ion.82.2019.08.26.21.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 21:05:09 -0700 (PDT)
Date:   Tue, 27 Aug 2019 00:05:07 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 08/13] t4014: let sed open its own files
Message-ID: <967e624bb4ade3ec1ddaa4e30566e2d938a6cfed.1566878374.git.liu.denton@gmail.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566878373.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, we were using a redirection operator to feed input into
sed. However, since sed is capable of opening its own files, make sed
open its own files instead of redirecting input into it.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2048fb2008..35cf798847 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -596,7 +596,7 @@ EOF
 
 test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 	git format-patch --cover-letter -2 &&
-	sed -e "1,/A U Thor/d" -e "/^\$/q" <0000-cover-letter.patch >output &&
+	sed -e "1,/A U Thor/d" -e "/^\$/q" 0000-cover-letter.patch >output &&
 	test_cmp expect output
 '
 
@@ -635,7 +635,7 @@ EOF
 
 test_expect_success 'format-patch -p suppresses stat' '
 	git format-patch -p -2 &&
-	sed -e "1,/^\$/d" -e "/^+5/q" <0001-This-is-an-excessively-long-subject-line-for-a-messa.patch >output &&
+	sed -e "1,/^\$/d" -e "/^+5/q" 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch >output &&
 	test_cmp expect output
 '
 
@@ -890,7 +890,7 @@ test_expect_success 'prepare mail-signature input' '
 test_expect_success '--signature-file=file works' '
 	git format-patch --stdout --signature-file=mail-signature -1 >output &&
 	check_patch output &&
-	sed -e "1,/^-- \$/d" <output >actual &&
+	sed -e "1,/^-- \$/d" output >actual &&
 	{
 		cat mail-signature && echo
 	} >expect &&
@@ -901,7 +901,7 @@ test_expect_success 'format.signaturefile works' '
 	test_config format.signaturefile mail-signature &&
 	git format-patch --stdout -1 >output &&
 	check_patch output &&
-	sed -e "1,/^-- \$/d" <output >actual &&
+	sed -e "1,/^-- \$/d" output >actual &&
 	{
 		cat mail-signature && echo
 	} >expect &&
@@ -923,7 +923,7 @@ test_expect_success '--signature-file overrides format.signaturefile' '
 	git format-patch --stdout \
 			--signature-file=other-mail-signature -1 >output &&
 	check_patch output &&
-	sed -e "1,/^-- \$/d" <output >actual &&
+	sed -e "1,/^-- \$/d" output >actual &&
 	{
 		cat other-mail-signature && echo
 	} >expect &&
@@ -992,7 +992,7 @@ test_expect_success 'format-patch wraps extremely long subject (ascii)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^$/q" patch >subject &&
 	test_cmp expect subject
 '
 
@@ -1031,7 +1031,7 @@ test_expect_success 'format-patch wraps extremely long subject (rfc2047)' '
 	git add file &&
 	git commit -m "$M512" &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^Subject/p; /^ /p; /^$/q" <patch >subject &&
+	sed -n "/^Subject/p; /^ /p; /^$/q" patch >subject &&
 	test_cmp expect subject
 '
 
@@ -1040,7 +1040,7 @@ check_author() {
 	git add file &&
 	GIT_AUTHOR_NAME=$1 git commit -m author-check &&
 	git format-patch --stdout -1 >patch &&
-	sed -n "/^From: /p; /^ /p; /^$/q" <patch >actual &&
+	sed -n "/^From: /p; /^ /p; /^$/q" patch >actual &&
 	test_cmp expect actual
 }
 
@@ -1160,7 +1160,7 @@ test_expect_success '--from=ident replaces author' '
 	From: A U Thor <author@example.com>
 
 	EOF
-	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
 	test_cmp expect patch.head
 '
 
@@ -1172,7 +1172,7 @@ test_expect_success '--from uses committer ident' '
 	From: A U Thor <author@example.com>
 
 	EOF
-	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
 	test_cmp expect patch.head
 '
 
@@ -1182,7 +1182,7 @@ test_expect_success '--from omits redundant in-body header' '
 	From: A U Thor <author@example.com>
 
 	EOF
-	sed -ne "/^From:/p; /^$/p; /^---$/q" <patch >patch.head &&
+	sed -ne "/^From:/p; /^$/p; /^---$/q" patch >patch.head &&
 	test_cmp expect patch.head
 '
 
@@ -1197,7 +1197,7 @@ test_expect_success 'in-body headers trigger content encoding' '
 	From: éxötìc <author@example.com>
 
 	EOF
-	sed -ne "/^From:/p; /^$/p; /^Content-Type/p; /^---$/q" <patch >patch.head &&
+	sed -ne "/^From:/p; /^$/p; /^Content-Type/p; /^---$/q" patch >patch.head &&
 	test_cmp expect patch.head
 '
 
@@ -1788,7 +1788,7 @@ test_expect_success 'interdiff: cover-letter' '
 	git format-patch --cover-letter --interdiff=boop~2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" 0000-cover-letter.patch &&
 	test_i18ngrep ! "^Interdiff:$" 0001-fleep.patch &&
-	sed "1,/^@@ /d; /^-- $/q" <0000-cover-letter.patch >actual &&
+	sed "1,/^@@ /d; /^-- $/q" 0000-cover-letter.patch >actual &&
 	test_cmp expect actual
 '
 
@@ -1804,7 +1804,7 @@ test_expect_success 'interdiff: solo-patch' '
 	EOF
 	git format-patch --interdiff=boop~2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" 0001-fleep.patch &&
-	sed "1,/^  @@ /d; /^$/q" <0001-fleep.patch >actual &&
+	sed "1,/^  @@ /d; /^$/q" 0001-fleep.patch >actual &&
 	test_cmp expect actual
 '
 
-- 
2.23.0.248.g3a9dd8fb08

