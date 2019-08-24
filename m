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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FF4B1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 08:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfHXI1F (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 04:27:05 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47098 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfHXI1E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 04:27:04 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so25511937iog.13
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/pQmeh6he9iEyqMs6LHy0NzLVmE3L+BX4bVCvFJpJrE=;
        b=jVXVej3RaZ7Y17X60q59oWcyeHyzbj9+5u9cXvTZ4sMWI9UMBACbvpFKaHh7Sc+o6g
         25io+7gubfc7Ux93xRrJmHVVZRVPq+V2Smd5MHTT+S1vL8r6oGmtpIUav2zJzBC7EbnC
         Ap9z0yyyLXJlMc64rk8WHcJY0ucMA83KTyjh5iNSRIMcHUN/nJ9D7sXStCkWZ0JFWQoz
         KYTG+1Nnm+zbPFZs9vYuoSaLjHVp9Vy1lGA243EIYY4DoPPfKv+VbOmDMU6Z4vlGg9oA
         bVS6JT4lQyTgGNTNQCYEQhaU+eVsXYxtwd3iO2THEWazWgJZ3AYwQQm59Q7Y0ZddRcCq
         6Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/pQmeh6he9iEyqMs6LHy0NzLVmE3L+BX4bVCvFJpJrE=;
        b=hBos5gQWo85bixYqMbWFhF9xjY/AWtQXt5lDpbLp9XqGBPvJ3rseqNIuDnSCDw0vec
         otwcVW4W2E0PxBXdNHIpEX+R2oQX+ZShlI4EtYKz7nhojAga6BA2nObTY7kAwaBW5Hws
         /ccWyklIGCoKU9M/7bNSmfpIQbPs9R5XrXsQ67FBWzOUJt8BSIYgD1mYXnpKRmdXODIL
         d8MwkzsppI+JlZ5u4lnYQGeQ681VzBpqAJF94MsTfPthHvl6q0KDEpgBf4vfH443QfWB
         TF/pOzl3LIr2OrwoU3F8LpkN14cxr3uPMAT7ZHAfoZbLSd/+pZSB4fFxPcrywPwumeoJ
         GA3A==
X-Gm-Message-State: APjAAAXf4SgpUknptRYAR9jpC/6bBYLLqTcgEfcyPLdtZQFOv7fMwfSx
        8ngIXs6KySORvC6ccxIO9jERk81I
X-Google-Smtp-Source: APXvYqzrHC8vxHsdpx3Wd/wtc35WPy0JizFsbSDt1nL11VQ7P/jMNKvbeVz8CGubQfZ4BdII1Emoyg==
X-Received: by 2002:a5e:d611:: with SMTP id w17mr11593118iom.34.1566635223606;
        Sat, 24 Aug 2019 01:27:03 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id o2sm3429574iob.64.2019.08.24.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 01:27:03 -0700 (PDT)
Date:   Sat, 24 Aug 2019 04:27:00 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH 06/13] t4014: use indentable here-docs
Message-ID: <90ad0fcf703e8b932789194b0a86ce061ffd48e0.1566635008.git.liu.denton@gmail.com>
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

