Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF473C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243920AbiHRHyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbiHRHyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:54:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8357143E7F
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:54:06 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso492651wmr.3
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fKFklA/nO1yJkUkiDcN5PqlqM3lnBX9T2+RfKS/hflo=;
        b=h/OQW19HKL/epIAfqI3uV1B0SYsqQrIcp6nleJBGovqczE6u4YDokaNySX2fpcgQ8c
         KI0jCCUKS9Gm+eWSQYzHEBtc6ALXkhh+REmPLx4s1Q/G50qYbo/biUsxgcnj/HG8td8V
         HdVBta5d+0kpjd00msXcfhdzhn7Xow+lMO9kkaj6uSstEa7UOZv9VhOM5oGVOMjjvIpb
         05C7i/qWWAKw28aeNyZ1YrLL4SXaHWJaO4YQZEimQ9LUrym0/o5Kt6L3YhD1UGxoXDeG
         M11UustwpE/sn/2RMNgAkeFRpwLlSxGDaE9lNHh9WHUUKxnRcgjpYhZUTRQ8FfV4rCk2
         nEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fKFklA/nO1yJkUkiDcN5PqlqM3lnBX9T2+RfKS/hflo=;
        b=BjUlqRyjaduc5zACmisEhfloTF7D4959UNW97iS5ab3f1x5NdZ4ChE67NIXaAIJRZ9
         xCe8fuDml+3EG2Nl6EaacjDCwYLHWVEKlntao2jaE3JEEdQw/ep2Ssb+NasA+3HpTCsT
         ED7pCAaEVumlYqs7dUtxNWheO8FupBZVIpHta1ygY1/Eg4UgJiQHdOS4esanGSXy7gNX
         fE8uZanb0WQ4YvDTB1yZYw+IswUPWYHYqotc7Lf6LMKKpkvH2D4aIYgWW6EJAEujvGZC
         r+n6SncYdHC3is0T/VuGFm/IpCOarqW1aizG0L9l+aUFgvIXIpywXIHuEPXansXQ1ywK
         Oi4Q==
X-Gm-Message-State: ACgBeo2p/T87nOeKV/Qa5VBqWU9D59AcRhatz0zwwAl16Z+vUw6XdPbV
        L9Cr5Maj5XV0xZbpF9uNm0qqdRtOuD0=
X-Google-Smtp-Source: AA6agR7sFtUSzHxpozrn/yWfYUCbprwGpdj7nEuYhoh0Bvut2Xf6eg7JMTj+XOl3VevL7j0hSXEx0A==
X-Received: by 2002:a05:600c:3d93:b0:3a6:1ac3:adf8 with SMTP id bi19-20020a05600c3d9300b003a61ac3adf8mr1020946wmb.125.1660809244783;
        Thu, 18 Aug 2022 00:54:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003a608d69a64sm4721768wms.21.2022.08.18.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:54:04 -0700 (PDT)
Message-Id: <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
From:   "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:54:03 +0000
Subject: [PATCH v2] trailer: allow spaces in tokens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Max Bernstein <max@bernsteinbear.com>

The docs (for example, https://git-scm.com/docs/git-interpret-trailers)
say that whitespace should be allowed inside tokens:

> There can also be whitespaces inside the token and the value.

The code since e4319562bc2834096fade432fd90c985b96476db does not allow
that, so re-enable and add a test.

Signed-off-by: Max Bernstein <max@bernsteinbear.com>
---
    trailer: allow spaces in tokens
    
    Changed since v1:
    
     * "Fixed" a format-patch test. I'm not sure if the new output is what
       everyone might expect for this particular case.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1309%2Ftekknolagi%2Fmaint-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1309/tekknolagi/maint-v2
Pull-Request: https://github.com/git/git/pull/1309

Range-diff vs v1:

 1:  404a6d1b193 ! 1:  4d490851ac2 trailer: allow spaces in tokens
     @@ Commit message
      
          Signed-off-by: Max Bernstein <max@bernsteinbear.com>
      
     + ## t/t4014-format-patch.sh ##
     +@@ t/t4014-format-patch.sh: test_expect_success 'signoff: not really a signoff' '
     + 	4:Subject: [PATCH] subject
     + 	8:
     + 	9:I want to mention about Signed-off-by: here.
     +-	10:
     +-	11:Signed-off-by: C O Mitter <committer@example.com>
     ++	10:Signed-off-by: C O Mitter <committer@example.com>
     + 	EOF
     + 	test_cmp expect actual
     + '
     +
       ## t/t7513-interpret-trailers.sh ##
      @@ t/t7513-interpret-trailers.sh: test_expect_success 'only-trailers omits non-trailer in middle of block' '
       	test_cmp expected actual


 t/t4014-format-patch.sh       |  3 +--
 t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
 trailer.c                     |  7 +-----
 3 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index fbec8ad2ef7..db95cb6ee66 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1544,8 +1544,7 @@ test_expect_success 'signoff: not really a signoff' '
 	4:Subject: [PATCH] subject
 	8:
 	9:I want to mention about Signed-off-by: here.
-	10:
-	11:Signed-off-by: C O Mitter <committer@example.com>
+	10:Signed-off-by: C O Mitter <committer@example.com>
 	EOF
 	test_cmp expect actual
 '
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 97f10905d23..47bf83003ef 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1481,6 +1481,46 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
 	test_cmp expected actual
 '
 
+test_expect_success 'supports spaces inside token' '
+	git config --unset trailer.sign.command &&
+	cat >expected <<-\EOF &&
+		Signed-off-by: nobody <nobody@nowhere>
+		some other trailer: a value
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	echo "wrote to expected" 1>&2 &&
+	git interpret-trailers --only-trailers >actual <<-\EOF &&
+		subject
+
+		it is important that the trailers below are signed-off-by
+		so that they meet the "25% trailers Git knows about" heuristic
+
+		Signed-off-by: nobody <nobody@nowhere>
+		some other trailer: a value
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'does not support space at beginning of token' '
+	cat >expected <<-\EOF &&
+		Signed-off-by: nobody <nobody@nowhere> not a trailer: thing
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	echo "wrote to expected" 1>&2 &&
+	git interpret-trailers --only-trailers --unfold >actual <<-\EOF &&
+		subject
+
+		it is important that the trailers below are signed-off-by
+		so that they meet the "25% trailers Git knows about" heuristic
+
+		Signed-off-by: nobody <nobody@nowhere>
+		 not a trailer: thing
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'only input' '
 	git config trailer.sign.command "echo config-value" &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index d419c20735e..d02a9154512 100644
--- a/trailer.c
+++ b/trailer.c
@@ -618,17 +618,12 @@ static int token_matches_item(const char *tok, struct arg_item *item, size_t tok
  */
 static ssize_t find_separator(const char *line, const char *separators)
 {
-	int whitespace_found = 0;
 	const char *c;
 	for (c = line; *c; c++) {
 		if (strchr(separators, *c))
 			return c - line;
-		if (!whitespace_found && (isalnum(*c) || *c == '-'))
+		if (isalnum(*c) || *c == '-' || (c != line && (*c == ' ' || *c == '\t')))
 			continue;
-		if (c != line && (*c == ' ' || *c == '\t')) {
-			whitespace_found = 1;
-			continue;
-		}
 		break;
 	}
 	return -1;

base-commit: ad60dddad72dfb8367bd695028b5b8dc6c33661b
-- 
gitgitgadget
