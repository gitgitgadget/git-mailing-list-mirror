Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D56CC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2591A61058
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 13:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhKDNQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhKDNQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 09:16:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0CC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 06:13:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b12so8570870wrh.4
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ip5UjQ+5bNKMPoDVgCh6WcSRLyNPFkojsTI4g8aNSMM=;
        b=ZY1yBna32Lz5KqcURD5Ra06yLdsuWSUeBz/0+6fNUFjykEM94g+vXuRS+ur6lYi8Ek
         Hm8Y6gtSB5Ffksdy5jXDhvFuh3p8+7oqR2KPaG0Y/ptGzG7QcWdeHpyYLyljn8d8bRGQ
         Gwhn9e3UX0KSLbEpz9+JAxBdJlVf9xI6epRNaH8XS4Rl2erzql6TlA2dWSi5IMx+Feu/
         3FzcBGAMXSayJNAMiP4Qtos+HCBQkjcuMpBq5lxXxNENiEX+tZSt8xjaI5S5QsuNGWkt
         qqz44z8Bpcqe/sxanVkbdGdBvWmfRBiqkWckLdclsD9IzYyd3ETVmugWa3TB5dg/xIxX
         Z1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ip5UjQ+5bNKMPoDVgCh6WcSRLyNPFkojsTI4g8aNSMM=;
        b=jfEcs3WRFmba9iaB5v6dEUFsZCpOogSdHHAvgSxfVF8UDlOC+RySEbqQSK5ohJ2o1y
         T+nJseSH76aj1Tf7gxjTYJlnA5u1Dopb4u/KavN71TSU+SmOxGQ7UW6rDk67WFs6nLCf
         dsbKVeYvLz5lqOXpAlIj5uKaGg45ENazvIPXH5OuV3Ee8rIdMICwr+Ljglv9sl0rZs5q
         UZhI8Irgi4wfupg49h4kCGYgHYwKSRIjLXudrq3Y0ZuKfXQeHZTBGxwJRn8Wno9snuqh
         IiqebfqVhVSwWyBaZfItRT1tzQTgvc6nnwHJYHAfJZN+uifl6jcRDzUMf/86U3kLTyJX
         zMow==
X-Gm-Message-State: AOAM532Lph7k9WQeGtQ4fu8St5C7/wQNstN/qJJcisepQ3ZbKFP0aWE4
        /T6H5dGgyt7MVcxIdeS33Mpc1glE0ws=
X-Google-Smtp-Source: ABdhPJzrqGM9JPaAO4pb6H1SvDOnrDo7J1ZdTTtT+Sb0J2DcHNLhtgPThWu2AMgaQQraWaqs3bDs7w==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr61971384wrr.228.1636031610963;
        Thu, 04 Nov 2021 06:13:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm5456144wre.46.2021.11.04.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 06:13:30 -0700 (PDT)
Message-Id: <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
In-Reply-To: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Nov 2021 13:13:29 +0000
Subject: [PATCH v3] ci: disallow directional formatting
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
    
    A couple days ago, I stumbled over
    https://siliconangle.com/2021/11/01/trojan-source-technique-can-inject-malware-source-code-without-detection/,
    which details an interesting social-engineering attack: it uses
    directional formatting in source code to pretend to human readers that
    the code does something different than it actually does.
    
    It is highly unlikely that Git's source code wants to contain such
    directional formatting in the first place, so let's disallow it.
    
    Technically, this is not exactly -rc material, but the paper was just
    published, and I want us to be safe.
    
    Changes since v2:
    
     * The pathspec excluding binary files is now used directly instead of
       doing the ls-files | xargs dance.
     * Corrected a code comment: my custom git grep was not PCRE-enabled,
       but Ubuntu's isn't. But git grep -P still does not understand \uNNNN.
     * Even if the *.po files currently pass the check, the script is now
       future-proof by excluding them.
     * Renamed the script to have the .bash extension, to indicate that it
       requires a Bashism (i.e. a printf that understands the \uNNNN
       syntax).
    
    Changes since v1:
    
     * The code was moved into a script in ci/.
     * We use git ls-files now to exclude files marked as binary in the Git
       attributes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1071%2Fdscho%2Fcheck-for-utf-8-directional-formatting-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1071/dscho/check-for-utf-8-directional-formatting-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1071

Range-diff vs v2:

 1:  bbf963695ba ! 1:  80447819de3 ci: disallow directional formatting
     @@ .github/workflows/main.yml: jobs:
           - uses: actions/checkout@v2
           - run: ci/install-dependencies.sh
           - run: ci/run-static-analysis.sh
     -+    - run: ci/check-directional-formatting.sh
     ++    - run: ci/check-directional-formatting.bash
         sparse:
           needs: ci-config
           if: needs.ci-config.outputs.enabled == 'yes'
      
     - ## ci/check-directional-formatting.sh (new) ##
     + ## ci/check-directional-formatting.bash (new) ##
      @@
      +#!/bin/bash
      +
     @@ ci/check-directional-formatting.sh (new)
      +# to deceive reviewers into interpreting code differently from the compiler.
      +# This is intended to run on an Ubuntu agent in a GitHub workflow.
      +#
     -+# `git grep` as well as GNU grep do not handle `\u` as a way to specify UTF-8.
     -+# A PCRE-enabled `git grep` would handle `\u` as desired, but Ubuntu does
     -+# not build its `git` packages with PCRE support.
     ++# To allow translated messages to introduce such directional formatting in the
     ++# future, we exclude the `.po` files from this validation.
     ++#
     ++# Neither GNU grep nor `git grep` (not even with `-P`) handle `\u` as a way to
     ++# specify UTF-8.
      +#
      +# To work around that, we use `printf` to produce the pattern as a byte
      +# sequence, and then feed that to `git grep` as a byte sequence (setting
     @@ ci/check-directional-formatting.sh (new)
      +# U+2066..U+2069: LRI, RLI, FSI and PDI
      +regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
      +
     -+! git ls-files -z ':(attr:!binary)' |
     -+LC_CTYPE=C xargs -0r git grep -Ele "$(LC_CTYPE=C.UTF-8 printf "$regex")" --
     ++! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
     ++	-- ':(exclude,attr:binary)' ':(exclude)*.po'


 .github/workflows/main.yml           |  1 +
 ci/check-directional-formatting.bash | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100755 ci/check-directional-formatting.bash

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6ed6a9e8076..deda12db3a9 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -289,6 +289,7 @@ jobs:
     - uses: actions/checkout@v2
     - run: ci/install-dependencies.sh
     - run: ci/run-static-analysis.sh
+    - run: ci/check-directional-formatting.bash
   sparse:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
new file mode 100755
index 00000000000..e6211b141aa
--- /dev/null
+++ b/ci/check-directional-formatting.bash
@@ -0,0 +1,27 @@
+#!/bin/bash
+
+# This script verifies that the non-binary files tracked in the Git index do
+# not contain any Unicode directional formatting: such formatting could be used
+# to deceive reviewers into interpreting code differently from the compiler.
+# This is intended to run on an Ubuntu agent in a GitHub workflow.
+#
+# To allow translated messages to introduce such directional formatting in the
+# future, we exclude the `.po` files from this validation.
+#
+# Neither GNU grep nor `git grep` (not even with `-P`) handle `\u` as a way to
+# specify UTF-8.
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
+! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+	-- ':(exclude,attr:binary)' ':(exclude)*.po'

base-commit: 0cddd84c9f3e9c3d793ec93034ef679335f35e49
-- 
gitgitgadget
