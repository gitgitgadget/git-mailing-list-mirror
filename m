Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF0C433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1735D60EB4
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhJ0Hvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbhJ0Hvn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F02C061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e4so2501843wrc.7
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pwdyCR0wgp3QygnQ53RXts/rz/SCa8YoiLNLmK8eyKU=;
        b=cX8mUPuyfIC4jxZxR2d08G5M6Gire+qV7931Z9oM/HCbbHG5dLVbihDOKaYYV+pgqM
         GTD6gB4k+FBfEn438ylI4ZBdBLdHK47iy7Iw79lzNFyK2+3Y7YLcYzwmXZr6AxClXa34
         7e+csWz7XgqXI616DwDVQPd3VmZSHmKZqXma3abYJwp7oHvcRfea4szTEvkIhmrPuMV+
         gx/ehpq8aKkt4OVfajna08J/ohaX0ncTTLfjpuXOtiS3kgbtGFcMcqeo7cboFxF+KZ7Q
         yl/idW0gNZWwV2aOXaJ6z0IkESAQlPoYFToeHrL/FABoj5CdneFWsYSvguTx3zyOJ6EB
         mdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pwdyCR0wgp3QygnQ53RXts/rz/SCa8YoiLNLmK8eyKU=;
        b=YW+XWoaN/XROVk6pyjj/ijMF3XsX4ri9LVQvGGDa77Fo513f4XXXOCGs60falTz0kb
         /2KHdIrpzsZagGxO7VYG+DraDnH++FrYZOZnTx/X+7aDPrHFei1Gv0VWSt8piFLB/st3
         CxfKukyzJdRWwKa4NCXeZnwbX7SA0oUp8tw1G7MrDRjOtGYiIZnOnvkCnNULuOj5zc3P
         MRtyQ3qS51Cd8wB4NUyQr85jy9t045CrnIqWmbm7Z8Yg69wh40wXy0DWH1Xwa+rX2grn
         yV4Pa3S7ZPpSWeFk2wL5/5e9DudHZZkAecZxDNC+wrHX6qMtj3KIHski029xmBsgmEdQ
         7CJA==
X-Gm-Message-State: AOAM5324c78wZ+3LY+ig46+oJdTYE8rlb8UnZm9BHpqnHW/3qAKm/e7E
        VyTnvEgSz4+/PxKSriVHo6uNoYZzYeE=
X-Google-Smtp-Source: ABdhPJwT7NeN7ZUq+hbjHAurTsDeIFZ8/vPJQBVzr1rwJ8ZB6eAf8pyB/ZSQAKWvxA//RKjvB/HBbg==
X-Received: by 2002:adf:e987:: with SMTP id h7mr125773wrm.82.1635320956892;
        Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm15518219wrr.28.2021.10.27.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Message-Id: <20387ce355759629f9456d8b02226ba2600e2d36.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:12 +0000
Subject: [PATCH 5/5] clean/smudge: allow clean filters to process extremely
 large files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

The filter system allows for alterations to file contents when they're
moved between the database and the worktree. We already made sure that
it is possible for smudge filters to produce contents that are larger
than `unsigned long` can represent (which matters on systems where
`unsigned long` is narrower than `size_t`, most notably 64-bit Windows).
Now we make sure that clean filters can _consume_ contents that are
larger than that.

Note that this commit only allows clean filters' _input_ to be larger
than can be represented by `unsigned long`.

This change makes only a very minute dent into the much larger project
to teach Git to use `size_t` instead of `unsigned long` wherever
appropriate.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 convert.c                   |  2 +-
 t/t1051-large-conversion.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index fd9c84b0257..5ad6dfc08a0 100644
--- a/convert.c
+++ b/convert.c
@@ -613,7 +613,7 @@ static int crlf_to_worktree(const char *src, size_t len, struct strbuf *buf,
 
 struct filter_params {
 	const char *src;
-	unsigned long size;
+	size_t size;
 	int fd;
 	const char *cmd;
 	const char *path;
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 38aa0d8a075..c488850bee4 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -95,4 +95,14 @@ test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output'
 	test "$size" -ge $((5 * 1024 * 1024 * 1024))
 '
 
+# This clean filter writes down the size of input it receives. By checking against
+# the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on input' '
+	dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) >big &&
+	test_config filter.checklarge.clean "wc -c >big.size" &&
+	echo "big filter=checklarge" >.gitattributes &&
+	git add big &&
+	test $(test_file_size big) -eq $(cat big.size)
+'
+
 test_done
-- 
gitgitgadget
