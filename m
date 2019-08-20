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
	by dcvr.yhbt.net (Postfix) with ESMTP id C52131F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbfHTHTC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42653 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHTC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:02 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so10067699iob.9
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pQmeh6he9iEyqMs6LHy0NzLVmE3L+BX4bVCvFJpJrE=;
        b=tnnXhkssOT0GoQmk6wtMiYibXewMXR0J345la+wTlZuKdNQCbymFv3mwTuJZhwYoSO
         Ny0SWKeY1JYCkG7O+z6Jqp4xptNVxxUUjHkpSZ7QgT/WygAPyRWRmoKWyAD9+JNClsNG
         s2ilZElLrSjFhiUYXq8gUOXBU+UWFfiPobVN1rCfQRZ7Z+E43usmKB6iKpnlzWukYv2d
         zt8XtGfSa/UfxYKbYoCBwMhtfLJ/w4AqLGRvorTUb3bsGo/a1Apw+I8UcTHPdag0JmjK
         8dnOXMowrIZl0X7h6Bk0d63TsipGUzeBUDTK5n6j9UCTS3TbK6L0NcWqMcqxCaNwOiJa
         DHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pQmeh6he9iEyqMs6LHy0NzLVmE3L+BX4bVCvFJpJrE=;
        b=Fxn2bFI5AbE6mKaGvjJyqswAXIrK9SPGjSQu8xgoWvQFPN/nX6mq2MxKd8iNVuqMyp
         AMmvUdouFROMdO2gaVefJfwRTtQu+FzgG3wBrzrGfmMAZaJYMyerZ+2z8jC4GWEjfgnA
         VPer2g+UDMB9BuITI9+welY31BOKNV03bv3yXqsFFxFQfJ5KStGYaxDSnBySy7jQoaeH
         9Q0pF9lzlNCDuqX5h1bghzH00Ojd9LDZn2AALkkYjTKK+LgHjkHI47Ke//YMzyyyP1We
         yneEkeTV7S6NK23NbbGytcaa37LyR+2pPBeb2ykzg/CsAb7XIuSzorTW0516mf+kJi7C
         hhfg==
X-Gm-Message-State: APjAAAWImiUcEdOp/5GDJwo/Jo5+aHjwAvQCMKa1wdcC4OuYrjEiD748
        +1TaiJGV6w0NZbzSxHZ/RShqBb4f
X-Google-Smtp-Source: APXvYqxdJ4IFeEzRC8wRUIxO+0Eusx9E3k5qQ3FEsdh4dFaoz7LrIfkAsheZcLJrBzijuwdm665Y3w==
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr2112983jar.71.1566285540885;
        Tue, 20 Aug 2019 00:19:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id q3sm10954854ios.70.2019.08.20.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:00 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:18:58 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 06/13] t4014: use indentable here-docs
Message-ID: <b4295846f5416f706e7f962d511eb77c9b59b7af.1566285151.git.liu.denton@gmail.com>
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

The convention is to use indentable here-docs within test cases so that
the here-docs line up with the rest of the code within the test case.
Change here-docs from `<<\EOF` to `<<-\EOF` so that they can be indented
along with the rest of the test case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 368 ++++++++++++++++++++--------------------
 1 file changed, 184 insertions(+), 184 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 075affb1e5..c07d868491 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1211,282 +1211,282 @@ append_signoff()
 
 test_expect_success 'signoff: commit with no body' '
 	append_signoff </dev/null >actual &&
-	cat <<\EOF | sed "s/EOL$//" >expect &&
-4:Subject: [PATCH] EOL
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat <<-\EOF | sed "s/EOL$//" >expect &&
+	4:Subject: [PATCH] EOL
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject' '
 	echo subject | append_signoff >actual &&
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: commit with only subject that does not end with NL' '
 	printf subject | append_signoff >actual &&
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	body
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: no existing signoffs and no trailing NL' '
 	printf "subject\n\nbody" | append_signoff >actual &&
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: misc conforming footer elements' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: my@house
-(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
-Tested-by: Some One <someone@example.com>
-Bug: 1234
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: my@house
-15:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: my@house
+	(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
+	Tested-by: Some One <someone@example.com>
+	Bug: 1234
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: my@house
+	15:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: some random signoff-alike' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
-Fooled-by-me: my@house
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	body
+	Fooled-by-me: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-I want to mention about Signed-off-by: here.
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:I want to mention about Signed-off-by: here.
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	I want to mention about Signed-off-by: here.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:I want to mention about Signed-off-by: here.
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: not really a signoff (2)' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-My unfortunate
-Signed-off-by: example happens to be wrapped here.
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:Signed-off-by: example happens to be wrapped here.
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	My unfortunate
+	Signed-off-by: example happens to be wrapped here.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:Signed-off-by: example happens to be wrapped here.
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Signed-off-by: my@house
-Signed-off-by: your@house
+	Signed-off-by: my@house
+	Signed-off-by: your@house
 
-A lot of houses.
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: my@house
-10:Signed-off-by: your@house
-11:
-13:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	A lot of houses.
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: my@house
+	10:Signed-off-by: your@house
+	11:
+	13:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff at the end, no trailing NL' '
 	printf "subject\n\nSigned-off-by: C O Mitter <committer@example.com>" |
 		append_signoff >actual &&
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-9:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	9:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: the same signoff NOT at the end' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Signed-off-by: C O Mitter <committer@example.com>
-Signed-off-by: my@house
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-11:Signed-off-by: C O Mitter <committer@example.com>
-12:Signed-off-by: my@house
-EOF
+	Signed-off-by: C O Mitter <committer@example.com>
+	Signed-off-by: my@house
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	12:Signed-off-by: my@house
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: tolerate garbage in conforming footer' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Tested-by: my@house
-Some Trash
-Signed-off-by: C O Mitter <committer@example.com>
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-13:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Tested-by: my@house
+	Some Trash
+	Signed-off-by: C O Mitter <committer@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	13:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: respect trailer config' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:
-12:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:
+	12:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual &&
 
 	test_config trailer.Myfooter.ifexists add &&
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-Myfooter: x
-Some Trash
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-11:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Myfooter: x
+	Some Trash
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	11:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'signoff: footer begins with non-signoff without @ sign' '
-	append_signoff <<\EOF >actual &&
-subject
+	append_signoff <<-\EOF >actual &&
+	subject
 
-body
+	body
 
-Reviewed-id: Noone
-Tested-by: my@house
-Change-id: Ideadbeef
-Signed-off-by: C O Mitter <committer@example.com>
-Bug: 1234
-EOF
-	cat >expect <<\EOF &&
-4:Subject: [PATCH] subject
-8:
-10:
-14:Signed-off-by: C O Mitter <committer@example.com>
-EOF
+	Reviewed-id: Noone
+	Tested-by: my@house
+	Change-id: Ideadbeef
+	Signed-off-by: C O Mitter <committer@example.com>
+	Bug: 1234
+	EOF
+	cat >expect <<-\EOF &&
+	4:Subject: [PATCH] subject
+	8:
+	10:
+	14:Signed-off-by: C O Mitter <committer@example.com>
+	EOF
 	test_cmp expect actual
 '
 
-- 
2.23.0.248.g3a9dd8fb08

