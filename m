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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F4AF1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfHXI1K (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42345 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXI1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:09 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so25544172iob.9
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HzHM2p4PCj3fdTdY+0mjHZTAYWCWVROiB8/myMHWwY8=;
        b=pCknu4+CBziTYZAPX3bcTzoM8zGHYUiVCwRT8BmuU/PCT7zreWN4DQ5pGgUwy9rNSz
         4/5ZiOR9LOC0BBahOwCkjco+ZvuDC1cfngBYyhZriOOYKFNGs/+fGT2SOGHGCFqDhRs3
         1BiuuyLqFiVRITG+fMspEg+6J6V88iHkWGXc/2KtsndrLDWz5AjRnWcTMR8Sp4QLdc+l
         2rgktLcJWdcZmqlyhgR+yiyNgkMmH19796xEIcjX3gzV2mKjLOUzFHWBh6XJkLTTPOQR
         zvfNIPp20Dj6z+0h2udZ5EmpX4Lla1OiIU0qaWId6kdES9ESqN0MwB0WApTqfTGqWa8N
         7Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HzHM2p4PCj3fdTdY+0mjHZTAYWCWVROiB8/myMHWwY8=;
        b=OVxVsf4/8KMR0VdyMP3PoKZF7Kxpd/qnXRLorbpXupGsq34wAYeOOiSBe1nFcoHEdN
         pqSLK708FkUqAWE5wCo6Eml2+ahXpMjFYk+On29S2tV5Ockuy/xf38U7+74VvIi/nko7
         zQpLbeqtnTFzIdYjAH4X4sFzhcvVdlUuxMjO5r8isbEeBt0LOWsMaOD78a1kMZ9xRkwu
         HSzkad7Gb/wK3kXr5vrohiQK5B1URKPEn0QTndhlgBVHrDV/lMfgg6KVsx1+TtgK4FNJ
         ON9Es6JfRi+u0Y2h6FeNFKG0QsY9RAKqUvAjVh/7aydWPAdma9g3PDw+P98Gplw4EPyv
         fJjg==
X-Gm-Message-State: APjAAAWaaSPNT3y5RiChV67B+wZq6+rNnEUIlIvqxfy1xkrTalJbtX7u
        czhuhxyZnLN4oRxVQ/A1ybksTDDW
X-Google-Smtp-Source: APXvYqyBeWCakum2Cqh0CsW/eNFV+gax9g/ITzB68wTHuk2AlNUiMRLa6CJ7KG7q6HtqQVQ6Pebahw==
X-Received: by 2002:a02:cc6c:: with SMTP id j12mr8747262jaq.29.1566635228473;
        Sat, 24 Aug 2019 01:27:08 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id g12sm3919477ioe.50.2019.08.24.01.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:08 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:06 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 08/13] t4014: let sed open its own files
Message-ID: <7d9a24a97972ab8a8a1cfe1f2605630e154886be.1566635008.git.liu.denton@gmail.com>
References: <cover.1566285151.git.liu.denton@gmail.com>
 <cover.1566635008.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1566635008.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, we were using a redirection operator to feed input into
sed. However, since sed is capable of opening its own files and provides
better error messages on IO failure, make sed open its own files instead
of redirecting input into it.

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

