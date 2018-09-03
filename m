Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3952B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeIDBcb (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43206 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so603513plv.10
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=szv3s/GdDre1u5YB3z/aDfuPlfOdb074ZXqSEKlGi1M=;
        b=PI8hChS9b8SFSwocEnz4BYx0Pvf0rhCiuTlkpehN9fEuv3ITJFNJwH7rjNse9jnczL
         9U53Cb2VBQwH+PHsj2YbU6lkVzd7kH11J4F+PlmY/tOm+z07QrM6AmxZW8otI9jVG9GF
         +LV5FhsUMYK3+8zLRogHtapgGLB0oHxqrfgkXSt1Y2aBA/bBr+EnmGZM5FPQTeoDMKi+
         ftSMuXJNkbOF81XwskiYfrmp0eWaE2A66P9G24Oz2b9V0GdlVN22T4VQfL82OIbSgyEh
         eV4APMNIqoBrH+x46TLGyEpTq3g44OBmb/OWzqhApltD3rohl9b+69NmiLoGtJ5WVye4
         ikSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=szv3s/GdDre1u5YB3z/aDfuPlfOdb074ZXqSEKlGi1M=;
        b=nd/AKbTWwgh3tx1g2wfWPojDb62Xf0JRas6cvCByjOQxAiM7oiGtp38Z7HDpdE5WVJ
         bfpt3VriQNScQMqFRtQopZLSIw+PLM6K2kGaUr15g8ofeXI2zfJ48OmndTq2htMXxoKT
         LAmAI4Z5bfHLQerGy/k/ro1QYbO/WIx4UqREwmCSrvOWijvxkPSzxUujQWpsbn5KStdd
         fRUomI7i2DOZBoFTli7rr/81NveYAs9F2PP3PWw7v5qbrETl4A/3HVrSeifAElrP2tux
         7L6uUcdLBXxergnYr1TgSJr6KbDaJF5qQbNuicbTJoqhdWbX+IG2WWsk2ZK7uj82I53R
         iVFg==
X-Gm-Message-State: APzg51B+8kiYS96DM6xEOcY7TkDT112NeXoZhO7Aad/2N8ymWLeYKmE5
        6MBFnKnHaOme/Ww5QYpN673br2TP
X-Google-Smtp-Source: ANB0VdYkph3k3cnhX6l7UAd5rl5US2qKUv31mXfscNfY31+EBglQjqD/hpIBPIfoWfjgVjIDWlt0Jw==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22-v6mr29849961pll.24.1536009031016;
        Mon, 03 Sep 2018 14:10:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 16-v6sm31602432pfo.164.2018.09.03.14.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:30 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:30 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:18 GMT
Message-Id: <858b80bfcfada8f8306181c6ca7c131217494c78.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/9] ci: rename the library of common functions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The name is hard-coded to reflect that we use Travis CI for continuous
testing.

In the next commits, we will extend this to be able use Visual Studio
Team Services, too.

So let's adjust the name to make it more generic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh     | 2 +-
 ci/{lib-travisci.sh => lib.sh} | 0
 ci/print-test-failures.sh      | 2 +-
 ci/run-build-and-tests.sh      | 2 +-
 ci/run-linux32-docker.sh       | 2 +-
 ci/run-static-analysis.sh      | 2 +-
 ci/run-windows-build.sh        | 2 +-
 ci/test-documentation.sh       | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename ci/{lib-travisci.sh => lib.sh} (100%)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 75a9fd2475..961064658e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -3,7 +3,7 @@
 # Install dependencies required to build and test Git on Linux and macOS
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
diff --git a/ci/lib-travisci.sh b/ci/lib.sh
similarity index 100%
rename from ci/lib-travisci.sh
rename to ci/lib.sh
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index d55460a212..7aef39a2fd 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -3,7 +3,7 @@
 # Print output of failing tests
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 # Tracing executed commands would produce too much noise in the loop below.
 set +x
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2a5bff4a1c..e28ac2fb9a 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -3,7 +3,7 @@
 # Build and test Git
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 ln -s "$cache_dir/.prove" t/.prove
 
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 21637903ce..751acfcf8a 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -3,7 +3,7 @@
 # Download and run Docker image to build and test 32-bit Git
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 docker pull daald/ubuntu32:xenial
 
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 5688f261d0..dc189c7456 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -3,7 +3,7 @@
 # Perform various static code analysis checks
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 make --jobs=2 coccicheck
 
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index d99a180e52..a73a4eca0a 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -6,7 +6,7 @@
 # supported) and a commit hash.
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 test $# -ne 2 && echo "Unexpected number of parameters" && exit 1
 test -z "$GFW_CI_TOKEN" && echo "GFW_CI_TOKEN not defined" && exit
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index a20de9ca12..d3cdbac73f 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -3,7 +3,7 @@
 # Perform sanity checks on documentation and build it.
 #
 
-. ${0%/*}/lib-travisci.sh
+. ${0%/*}/lib.sh
 
 gem install asciidoctor
 
-- 
gitgitgadget

