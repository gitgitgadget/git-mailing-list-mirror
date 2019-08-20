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
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6F71F461
	for <e@80x24.org>; Tue, 20 Aug 2019 07:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfHTHTH (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 03:19:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38185 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTHTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 03:19:07 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so7641860iog.5
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H5/xKaS0Q7q+s1z6WTgX/echzNq9gpIJV3Kh1OwBZ6Q=;
        b=BdAUjpzw94caXEXxxPreGfnMMsmsgqeB8CS9fOdCfNt3h0eJf5DikGyuhe0EEK3OiT
         WtNIN2kTKjuhIyXrMKp2gL5H3s3c1YSplAKaoAOJ6A/63myO6iotzXbEUg/mW9h+8vaX
         8siAlIRmDvGneLNYMCJyWsVINcLafvGg/9k0BrzZw4Pt1W/eLuYXwTOiIfyk4C6o90iS
         Lr/NgMvcU2QYEtckudoSullIMDSSihiIoHWum5rnXpSRroaw6sP8Y56VhyXeLSsTPRzc
         pPktNO9qzaW/Uv+CUis/LtAgxan/9gKmkyAx8J4Cj6x5Iv3pEmJIFNrJ9VXOep9ldytP
         WyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5/xKaS0Q7q+s1z6WTgX/echzNq9gpIJV3Kh1OwBZ6Q=;
        b=fwYxKXCnW+dfu7HDq1m6PYeYvbBMQ4hN14aDZiym/UHjy4gCCV6gc0rCuBHiaHZPaB
         99z/TjpiDAGt8iQw0lDWDWxZwhPqzGMg026pUe/8ZmJOHWk+oOc3m+rf+8EVS4Aon+2Z
         JdsrPvq+HB+eOxU+21PmDg321kDKAPTsIX9vzjr7PpcoRG6aff2GfZicgSV0bpiKl0tt
         EXaWq9QDeCjBta6NNuO7+AGrzSX+I+h0W48lTTp7l6pw86m6Mf1boHQ/SApDgRJp1fdr
         Gbil9Flb+FUKlB++Na0nQ55isX/tRp9H/RFEf792mju7o7DFK9GAftu+eTZ+ZycFGSN0
         R/SA==
X-Gm-Message-State: APjAAAUx4pWM//Uy/jvspJRz2rkU0YF8hw5UfyD5ohboVQSp5eO4uaBl
        oFezTjxvWTNzRjgd+4Uv1Kv8d/pG
X-Google-Smtp-Source: APXvYqwKhTcCLHTMF90HCv7wldZzWiflqx5mq9KBYpTzs+LcXhdVxvar5+CWZdrt6ycHsDokzqRQhA==
X-Received: by 2002:a6b:cf17:: with SMTP id o23mr6250986ioa.176.1566285546020;
        Tue, 20 Aug 2019 00:19:06 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id p9sm17951756ios.1.2019.08.20.00.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:19:05 -0700 (PDT)
Date:   Tue, 20 Aug 2019 03:19:03 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/13] t4014: use test_line_count() where possible
Message-ID: <de08dd886d70425e7b89a6fcd97d2472ecb97454.1566285151.git.liu.denton@gmail.com>
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

Convert all instances of `cnt=$(... | wc -l) && test $cnt = N` into uses
of `test_line_count()`.

While we're at it, convert one instance of a Git command upstream of a
pipe into two commands. This prevents a failure of a Git command from
being masked since only the return code of the last member of the pipe
is shown.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4014-format-patch.sh | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 2048fb2008..176af4b902 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -60,23 +60,23 @@ test_expect_success setup '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout master..side >patch0 &&
-	cnt=$(grep "^From " patch0 | wc -l) &&
-	test $cnt = 3
+	grep "^From " patch0 >from0 &&
+	test_line_count = 3 from0
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream' '
 	git format-patch --stdout \
 		--ignore-if-in-upstream master..side >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream handles tags' '
 	git tag -a v1 -m tag side &&
 	git tag -a v2 -m tag master &&
 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
-	cnt=$(grep "^From " patch1 | wc -l) &&
-	test $cnt = 2
+	grep "^From " patch1 >from1 &&
+	test_line_count = 2 from1
 '
 
 test_expect_success "format-patch doesn't consider merge commits" '
@@ -90,22 +90,23 @@ test_expect_success "format-patch doesn't consider merge commits" '
 	git checkout -b merger master &&
 	test_tick &&
 	git merge --no-ff slave &&
-	cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
-	test $cnt = 3
+	git format-patch -3 --stdout >patch &&
+	grep "^From " patch >from &&
+	test_line_count = 3 from
 '
 
 test_expect_success 'format-patch result applies' '
 	git checkout -b rebuild-0 master &&
 	git am -3 patch0 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'format-patch --ignore-if-in-upstream result applies' '
 	git checkout -b rebuild-1 master &&
 	git am -3 patch1 &&
-	cnt=$(git rev-list master.. | wc -l) &&
-	test $cnt = 2
+	git rev-list master.. >list &&
+	test_line_count = 2 list
 '
 
 test_expect_success 'commit did not screw up the log message' '
@@ -795,7 +796,8 @@ test_expect_success 'options no longer allowed for format-patch' '
 
 test_expect_success 'format-patch --numstat should produce a patch' '
 	git format-patch --numstat --stdout master..side >output &&
-	test 5 = $(grep "^diff --git a/" output | wc -l)
+	grep "^diff --git a/" output >diff &&
+	test_line_count = 5 diff
 '
 
 test_expect_success 'format-patch -- <path>' '
@@ -852,8 +854,8 @@ test_expect_success 'format-patch --signature --cover-letter' '
 	git config --unset-all format.signature &&
 	git format-patch --stdout --signature="my sig" --cover-letter \
 		-1 >output &&
-	grep "my sig" output &&
-	test 2 = $(grep "my sig" output | wc -l)
+	grep "my sig" output >sig &&
+	test_line_count = 2 sig
 '
 
 test_expect_success 'format.signature="" suppresses signatures' '
@@ -1591,7 +1593,8 @@ test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
 	git format-patch master..side &&
-	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
 '
 
 test_expect_success 'format-patch -o overrides format.outputDirectory' '
-- 
2.23.0.248.g3a9dd8fb08

