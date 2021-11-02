Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE7C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D6060FC2
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhKBNBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhKBNBd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:01:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D337C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:58:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so2020403wmd.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XXRugLMTZf0TpLXZEqlAonsDelbhk9vdIn65ZnwId7A=;
        b=KuY32GWZy1BnmvYp13oEaeQO7Pwlsg/X2kicJryfrwfF0Pl+bA0wkeaQMye/lsg9hn
         kWOmE5UxgNUOjfhQlufajQfoXIKPyQT9tPd/Hx/JIk2uYsaLy/u94QnPfTZIQTI1qZIq
         Mky96hD1B+87jdL8t5mkJlFrCotHOuPeFey32QnfTRRJrxBujy+E6rF21ZwTRVVzzI7z
         edPDhaOLOAzi3grfsQNTKyHx0HX0zLEEMssfExvboemklueAJ1UIhDBkaCWqdYFjM4i+
         c10QpWMtxL0nw0otglaHNDwd4oKNh5v66k5kDK7sKGGIi0MvSpMky0Li0VbnNodgzUfu
         DzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XXRugLMTZf0TpLXZEqlAonsDelbhk9vdIn65ZnwId7A=;
        b=blDRhHheGWBlcOHy0xzyJGYIxe2bSpK34bDPpbo3c7EmMSf6AfWHH5vJ4WSvMWyJ5o
         xu+Ne87DxXji/rmEjL2o/WlZhoKrm8GYJJ6o/O0cfekkGHBCO76XO0kZ+uS1e0UWuufs
         eBaCpxZ0tXH/SQAmQxi5zJ8NppGYqifsC65jW8L0XzTUTR70Glyo41kA3+N6ZsRt3zPL
         o+UbrP/bIx21IAEVTVeYxNi/3YAQbZ/QMF/6JgXbqvVfvhBXxz8aFse41F3VPlmprXrp
         TXeZaPYZ8Dm5bAl5ihihhWcMqqYsp61wExLb2Tz+VagcxINIEIUxY+CzRpHfwdh9zStX
         YGiQ==
X-Gm-Message-State: AOAM532SUsWgnYiEfyp7beCq6976V/Act/CHXieEc1iT5qi9R8CUUM3f
        k2fgip7W/yivBZ5WhUQV1tCh0fcLtzo=
X-Google-Smtp-Source: ABdhPJz2fOra5koHhbu2IsiwEWuJqwKwY5/fZ9Apxp2vXHN7jolkYggYNe16mnQONFv5GpVd+dYrEQ==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr6972099wml.11.1635857936651;
        Tue, 02 Nov 2021 05:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m125sm2460044wmm.39.2021.11.02.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:58:56 -0700 (PDT)
Message-Id: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 12:58:55 +0000
Subject: [PATCH] ci: disallow directional formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As described in https://trojansource.codes/trojan-source.pdf, it is
possible to abuse directional formatting (a feature of Unicode) to
deceive human readers into interpreting code differently from compilers.

It is highly unlikely that Git's source code wants to contain such
directional formatting in the first place, so let's disallow it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: disallow directional formatting
    
    I just stumbled over
    https://siliconangle.com/2021/11/01/trojan-source-technique-can-inject-malware-source-code-without-detection/,
    which details an interesting social-engineering attack: it uses
    directional formatting in source code to pretend to human readers that
    the code does something different than it actually does.
    
    It is highly unlikely that Git's source code wants to contain such
    directional formatting in the first place, so let's disallow it.
    
    Technically, this is not exactly -rc material, but the paper was just
    published, and I want us to be safe.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1071%2Fdscho%2Fcheck-for-utf-8-directional-formatting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1071/dscho/check-for-utf-8-directional-formatting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1071

 .github/workflows/main.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..7b4b4df03c3 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -289,6 +289,13 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
+    - name: disallow Unicode directional formatting
+      run: |
+        # Use UTF-8-aware `printf` to feed a byte pattern to non-UTF-8-aware `git grep`
+        # (Ubuntu's `git grep` is compiled without support for libpcre, otherwise we
+        # could use `git grep -P` with the `\u` syntax).
+        ! LANG=C git grep -Il "$(LANG=C.UTF-8 printf \
+          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\|\u2067\\|\u2068\\|\u2069\\)')"
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
gitgitgadget
