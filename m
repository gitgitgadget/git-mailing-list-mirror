Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E01C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72D261108
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 12:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhKCM1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbhKCM1E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 08:27:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48021C061210
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 05:23:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s13so3318273wrb.3
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 05:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CyQwBMc0QhC+BoUy3qvr76W2I+ICamSRnjkbz64mBcs=;
        b=eE+8/R2SxeUqvxHrWxUZxn0gDDXkG4kaWtMcQ2iEVIG4VkV0wucXWMOqiF8G8Yq1KU
         9bXi7rHWexKd0jEmu8plUs1g/sQqGoAIhTOR3s2FwGrGQ5VFx1QhhJVaU+xz/g7NudWF
         EsgWvhPddZ12LudtrYM+wKfpKMYvNvi+o1kvbK6+7WYYPVzElKSkXscz0mKgWxiY/W7d
         VbHwck2KMAEhOBklGAaR5f0I+dht4XCAKvLWu2jWGT+x2hpLCvFlIi96d97ncrj+MGg4
         L1SWv1tDCwvzH871md1/JvJFP9l7qR/JaRbWo7w7544O1IjrpzrYmRcHgrQTsNNpBcLU
         Z06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CyQwBMc0QhC+BoUy3qvr76W2I+ICamSRnjkbz64mBcs=;
        b=Tye9Q8C207Jb+HRwajQ7gEfJbBR+ZTEYZl4ROQI8zKNmtiwx98eVRgLcCQe4US3VFS
         xS/4Y/fBzESfVN7TcEFhIc3lKAFyWYIrJFfUp+r3jiS0r113bmIOCM+m+PPNV4Ofo5FE
         aSy7fkoSNnPZNv7HI/d3OMVeDMOUtPE+EL2Ig23r/9yjvYmeEIl1ONWotM8J3m+LrsAk
         KMY9ifs4xGkxDeXLcQG3j+0G/GcGZlyA3lcDfuB1x2GeB9u89chGsOWiyKe7FS9oK5X8
         uKRYAxgsv2E9Mzrl03wWUU0fYyVYNTprArFvLhuq/u//YqMvbEZyycgZsnyi7rLnS0hj
         QNFQ==
X-Gm-Message-State: AOAM533D1WduKGNygkswb+6WsPFa6BRaSo6zr4eim+SW78OxB+cxW/FT
        VdCDUEvq+C5J++4PKV7CP2Os4HpPJ+E=
X-Google-Smtp-Source: ABdhPJwP5gItA9fmtvwKAl3OdQlTDKWJ9yF3KFAgBXztKoLTH710AeCElnOKKSvEvJLn0AG7CsmJsg==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr46596866wrn.257.1635942237645;
        Wed, 03 Nov 2021 05:23:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm1735375wrh.16.2021.11.03.05.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:23:57 -0700 (PDT)
Message-Id: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
In-Reply-To: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
References: <pull.1071.git.1635857935312.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 03 Nov 2021 12:23:55 +0000
Subject: [PATCH v2] ci: disallow directional formatting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As described in https://trojansource.codes/trojan-source.pdf, it is
possible to abuse directional formatting (a feature of Unicode) to
deceive human readers into interpreting code differently from compilers.

For example, an "if ()" expression could be enclosed in a comment, but
rendered as if it was outside of that comment. In effect, this could
fool a reviewer into misinterpreting the code flow as benign when it is
not.

It is highly unlikely that Git's source code wants to contain such
directional formatting in the first place, so let's just disallow it.

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
    
    Changes since v1:
    
     * The code was moved into a script in ci/.
     * We use git ls-files now to exclude files marked as binary in the Git
       attributes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1071%2Fdscho%2Fcheck-for-utf-8-directional-formatting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1071/dscho/check-for-utf-8-directional-formatting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1071

Range-diff vs v1:

 1:  6a1661fd887 ! 1:  bbf963695ba ci: disallow directional formatting
     @@ Commit message
          possible to abuse directional formatting (a feature of Unicode) to
          deceive human readers into interpreting code differently from compilers.
      
     +    For example, an "if ()" expression could be enclosed in a comment, but
     +    rendered as if it was outside of that comment. In effect, this could
     +    fool a reviewer into misinterpreting the code flow as benign when it is
     +    not.
     +
          It is highly unlikely that Git's source code wants to contain such
     -    directional formatting in the first place, so let's disallow it.
     +    directional formatting in the first place, so let's just disallow it.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ .github/workflows/main.yml: jobs:
           - uses: actions/checkout@v2
           - run: ci/install-dependencies.sh
           - run: ci/run-static-analysis.sh
     -+    - name: disallow Unicode directional formatting
     -+      run: |
     -+        # Use UTF-8-aware `printf` to feed a byte pattern to non-UTF-8-aware `git grep`
     -+        # (Ubuntu's `git grep` is compiled without support for libpcre, otherwise we
     -+        # could use `git grep -P` with the `\u` syntax).
     -+        ! LANG=C git grep -Il "$(LANG=C.UTF-8 printf \
     -+          '\\(\u202a\\|\u202b\\|\u202c\\|\u202d\\|\u202e\\|\u2066\\|\u2067\\|\u2068\\|\u2069\\)')"
     ++    - run: ci/check-directional-formatting.sh
         sparse:
           needs: ci-config
           if: needs.ci-config.outputs.enabled == 'yes'
     +
     + ## ci/check-directional-formatting.sh (new) ##
     +@@
     ++#!/bin/bash
     ++
     ++# This script verifies that the non-binary files tracked in the Git index do
     ++# not contain any Unicode directional formatting: such formatting could be used
     ++# to deceive reviewers into interpreting code differently from the compiler.
     ++# This is intended to run on an Ubuntu agent in a GitHub workflow.
     ++#
     ++# `git grep` as well as GNU grep do not handle `\u` as a way to specify UTF-8.
     ++# A PCRE-enabled `git grep` would handle `\u` as desired, but Ubuntu does
     ++# not build its `git` packages with PCRE support.
     ++#
     ++# To work around that, we use `printf` to produce the pattern as a byte
     ++# sequence, and then feed that to `git grep` as a byte sequence (setting
     ++# `LC_CTYPE` to make sure that the arguments are interpreted as intended).
     ++#
     ++# Note: we need to use Bash here because its `printf` interprets `\uNNNN` as
     ++# UTF-8 code points, as desired. Running this script through Ubuntu's `dash`,
     ++# for example, would use a `printf` that does not understand that syntax.
     ++
     ++# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
     ++# U+2066..U+2069: LRI, RLI, FSI and PDI
     ++regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
     ++
     ++! git ls-files -z ':(attr:!binary)' |
     ++LC_CTYPE=C xargs -0r git grep -Ele "$(LC_CTYPE=C.UTF-8 printf "$regex")" --


 .github/workflows/main.yml         |  1 +
 ci/check-directional-formatting.sh | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 ci/check-directional-formatting.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..36b7a0bee38 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -289,6 +289,7 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
+    - run: ci/check-directional-formatting.sh
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/ci/check-directional-formatting.sh b/ci/check-directional-formatting.sh
new file mode 100755
index 00000000000..ab894715cf1
--- /dev/null
+++ b/ci/check-directional-formatting.sh
@@ -0,0 +1,25 @@
+#!/bin/bash
+
+# This script verifies that the non-binary files tracked in the Git index do
+# not contain any Unicode directional formatting: such formatting could be used
+# to deceive reviewers into interpreting code differently from the compiler.
+# This is intended to run on an Ubuntu agent in a GitHub workflow.
+#
+# `git grep` as well as GNU grep do not handle `\u` as a way to specify UTF-8.
+# A PCRE-enabled `git grep` would handle `\u` as desired, but Ubuntu does
+# not build its `git` packages with PCRE support.
+#
+# To work around that, we use `printf` to produce the pattern as a byte
+# sequence, and then feed that to `git grep` as a byte sequence (setting
+# `LC_CTYPE` to make sure that the arguments are interpreted as intended).
+#
+# Note: we need to use Bash here because its `printf` interprets `\uNNNN` as
+# UTF-8 code points, as desired. Running this script through Ubuntu's `dash`,
+# for example, would use a `printf` that does not understand that syntax.
+
+# U+202a..U+2a2e: LRE, RLE, PDF, LRO and RLO
+# U+2066..U+2069: LRI, RLI, FSI and PDI
+regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
+
+! git ls-files -z ':(attr:!binary)' |
+LC_CTYPE=C xargs -0r git grep -Ele "$(LC_CTYPE=C.UTF-8 printf "$regex")" --

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
gitgitgadget
