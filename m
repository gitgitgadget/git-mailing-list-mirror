Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F297C04A68
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 14:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238925AbiGZOES (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 10:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239218AbiGZOEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 10:04:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E4713E1F
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h8so20289470wrw.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fjy29URKj3Un18HszCKExbcLlsxvb1I2+KYxkv7oJvo=;
        b=oU8y8z1XmML3eLR9oHbcbma35uP9s0vjFAI2aGM0yb4JW+5OM13vi0dA7m63P8WP43
         vTWEPrsmkgEDqdbCG6l1WWMYp1Yt6KEDw7e1Jrij4FqVYdsTEuikE74EcbPN1vsNbmbe
         t+ADJ9SstzQRx1GX295c6AOLpc9pOXVSl2chwUjwsc/tHyo9YV8mVfpbXoVA+Z4EiZ1E
         H+fSz7Ke3tsuKfotkagFRhWwF/4wSDyAhOQjmawF9rR+6FJgp9uk0Zh5YLhqSaQGMGIb
         ytayiQi06st0k0ZFFj1RVCWeiQe7bZXT3aiyNU24RsDoXwITlngARmBK9VK8qMXi2zcJ
         /VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fjy29URKj3Un18HszCKExbcLlsxvb1I2+KYxkv7oJvo=;
        b=ORzRt6LuOqI6sIV4ioJbFSe2+r3RJNm5kCtNISB5GsKHnmUkktGwucZxaamZrfoRb3
         qdV+5qqwLiirRkw3aO0y8z7YtEtCf2tJPkWphTEZgb+sQ2OhaVCuZDaHjHwb1Fd/QFGL
         4CbdAEEUy0327sGjq5Gcb8sG7ZelbsMdT3ZSsc7YwgKVQ5/0qSfYcxpG7cuQu/p6vvrX
         8ukNz6e7/f3BBcr+VCgfd6j1aqWQ8p+du1dSU4XkmU0dY+RjVeHtPEXDADIHoWZmmnu6
         GJQX+nuDDTHpHHY4eADxmy9yCNG8Fjo3WNL/hjNX8hu3gc8RGCWX0j8b1sYQLQTTXdvh
         7VKg==
X-Gm-Message-State: AJIora/sqKldRRKmagdihbrp3LeBiTssW/ypNjX0OPeurPrToIX4qm05
        v3dOj7e4lFGLADdPT0qFst/ZfymFWeI=
X-Google-Smtp-Source: AGRyM1sdZctk4IkwnTFMDmXDylgWKPGYBo/JsCSpL75vyqFQjIlZDxV23PXXgppg2AiSwaziHfqGsg==
X-Received: by 2002:a05:6000:1d8d:b0:21e:a1bc:6de8 with SMTP id bk13-20020a0560001d8d00b0021ea1bc6de8mr2328248wrb.712.1658844253920;
        Tue, 26 Jul 2022 07:04:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b0021e4edba1e5sm14963447wrp.111.2022.07.26.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:04:12 -0700 (PDT)
Message-Id: <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1658844250.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jul 2022 14:04:08 +0000
Subject: [PATCH 1/3] refs: allow "HEAD" as decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The normalize_glob_ref() method was introduced in 65516f586b693 (log:
add option to choose which refs to decorate, 2017-11-21) to help with
decoration filters such as --decorate-refs=<filter> and
--decorate-refs-exclude=<filter>. The method has not been used anywhere
else.

At the moment, it is impossible to specify HEAD as a decoration filter
since normalize_glob_ref() prepends "refs/" to the filter if it isn't
already there.

Allow adding HEAD as a decoration filter by allowing the exact string
"HEAD" to not be prepended with "refs/". Add a test in t4202-log.sh that
would previously fail since the HEAD decoration would exist in the
output.

It is sufficient to only cover "HEAD" here and not include other special
refs like REBASE_HEAD. This is because HEAD is the only ref outside of
refs/* that is added to the list of decorations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs.c         | 4 ++--
 t/t4202-log.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 90bcb271687..ec3134e4842 100644
--- a/refs.c
+++ b/refs.c
@@ -457,8 +457,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 
 	if (prefix) {
 		strbuf_addstr(&normalized_pattern, prefix);
-	}
-	else if (!starts_with(pattern, "refs/"))
+	} else if (!starts_with(pattern, "refs/") &&
+		   strcmp(pattern, "HEAD"))
 		strbuf_addstr(&normalized_pattern, "refs/");
 	strbuf_addstr(&normalized_pattern, pattern);
 	strbuf_strip_suffix(&normalized_pattern, "/");
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6e663525582..6b7d8e269f7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1025,6 +1025,12 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'decorate-refs-exclude HEAD' '
+	git log --decorate=full --oneline \
+		--decorate-refs-exclude="HEAD" >actual &&
+	! grep HEAD actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
gitgitgadget

