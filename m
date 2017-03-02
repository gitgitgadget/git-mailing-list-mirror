Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CAB120133
	for <e@80x24.org>; Thu,  2 Mar 2017 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdCBK7t (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 05:59:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32920 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdCBK7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 05:59:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so4272561wma.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dFA0n9utnTEoK6i0RPbVt47UKtXQ0s9cuxOPV/ebVqQ=;
        b=YyupeHa1+xM/LuL9cshfyQBWwz4tGpVDrS0xEh+hQgwkJTyFmBGlaf6j9XJob8xNsH
         965kOra+GIwx0QBJlr9ugvM6VTk5U6GceCCiCfPAVUlKfkj4qCdkHjvVEutHAUgSrDYT
         E0scuJyosZYodIsdHsyXSOdrIeNrJDeEraLdvr5G8JYqnEFKqhzNgW48MYU/vdfBnHyu
         m3+CmVkNqdtb9ZCczuT4wKsFrEvQXfaComdZYJdP2PT1YPddT0h6mVVorLh4NnfZjRoF
         Zvz8CI2NWUZaCJYOkoaBW246mtXCXEPTAdBcydyLKPdBn8QvP+odKoW60s11oGDX60/b
         gudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dFA0n9utnTEoK6i0RPbVt47UKtXQ0s9cuxOPV/ebVqQ=;
        b=Ulcl0/tW76/npORQhEeJcZuv+LbmEnND5a+qabO7p/aq0o9GtpIHL7QFyxq+JsYLlK
         4yNQQC3KrNgeCafMcrPF28xdXvJpR8Qxb9W+zQfMAwvJ7FDecRtORyHa6dJJZHI4a0ar
         kZ+4jYZu2hP3zZICF+oiDCZQJ+q6DMnIp/RAeMPm4qXYvbis2MzzXn1Jj2TGMkSnjeYf
         lojepK5Y8NlatglACK/aNajnmhmtgwlseTUeRsM0srJpFAMePBzdSkZnJ+mGD4Twg+on
         rm6+mWTLcLfamj7LbWAS9YndZiavCCVk0FNejp2oYiCacHWlwq0HI5QalDo7GSNpiVUr
         L2ZQ==
X-Gm-Message-State: AMke39nUkMsMRwe7ufpoyMTpdXACt6BaNLqAnflc+KtwyPUTP+UBbIA7WXZiaWnvCPHNDQ==
X-Received: by 10.28.15.142 with SMTP id 136mr7861362wmp.66.1488451918429;
        Thu, 02 Mar 2017 02:51:58 -0800 (PST)
Received: from slxBook4.fritz.box (p5DDB5AF2.dip0.t-ipconnect.de. [93.219.90.242])
        by smtp.gmail.com with ESMTPSA id 10sm26641048wmk.26.2017.03.02.02.51.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Mar 2017 02:51:57 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH v1] Travis: also test on 32-bit Linux
Date:   Thu,  2 Mar 2017 11:51:57 +0100
Message-Id: <20170302105157.59791-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When Git v2.9.1 was released, it had a bug that showed only on Windows
and on 32-bit systems: our assumption that `unsigned long` can hold
64-bit values turned out to be wrong.

This could have been caught earlier if we had a Continuous Testing
set up that includes a build and test run on 32-bit Linux.

Let's do this (and take care of the Windows build later). This patch
asks Travis CI to install a Docker image with 32-bit libraries and then
goes on to build and test Git using this 32-bit setup.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Thanks for the patch Dscho!

The patch looks good to me in general but I want to propose the following
changes:

(1) Move all the docker magic into a dedicated file "ci/run-linux-32-build.sh"
    This way people should be able to run this build on their local machines
    without TravisCI. However, I haven't tested this.

(2) The docker build command inherits the Git test environment variables.
    This way we use the same environment variables as in all other TravisCI
    builds (plus it would use *your* variables if you run it locally).

(3) Silence the apt update/git output as is it clutters the log.
    I did not silence stderr output!

(4) Remove (to my knowledge) superfluous "compiler: clang" in the Linux32 job.

I added my sign-off. I hope this is the right thing to do in this "I took your
patch and changed it to suggest an improvement" situation.

You can see a successful run here:
https://travis-ci.org/larsxschneider/git/jobs/206945950


One thing that still bugs me: In the Linux32 environment prove adds the
CPU times to every test run: ( 0.02 usr  0.00 sys +  0.00 cusr  0.00 csys ...
Has anyone an idea why that happens and how we can disable it?


Cheers,
Lars


Notes:
    Base Ref:
    Web-Diff: https://github.com/larsxschneider/git/commit/82995ed59c
    Checkout: git fetch https://github.com/larsxschneider/git travisci/linux32-v1 && git checkout 82995ed59c

 .travis.yml             |  9 +++++++++
 ci/run-linux32-build.sh | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100755 ci/run-linux32-build.sh

diff --git a/.travis.yml b/.travis.yml
index 9c63c8c3f6..c8c789c437 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,15 @@ env:

 matrix:
   include:
+    - env: Linux32
+      os: linux
+      sudo: required
+      services:
+        - docker
+      before_install:
+        - docker pull daald/ubuntu32:xenial
+      before_script:
+      script: ci/run-linux32-build.sh
     - env: Documentation
       os: linux
       compiler: clang
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
new file mode 100755
index 0000000000..b892fbdc9e
--- /dev/null
+++ b/ci/run-linux32-build.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Build and test Git in a docker container running a 32-bit Ubuntu Linux
+#
+
+set -e
+
+APT_INSTALL="apt update >/dev/null && apt install -y build-essential "\
+"libcurl4-openssl-dev libssl-dev libexpat-dev gettext python >/dev/null"
+
+TEST_GIT_ENV="DEFAULT_TEST_TARGET=$DEFAULT_TEST_TARGET "\
+"GIT_PROVE_OPTS=\"$GIT_PROVE_OPTS\" "\
+"GIT_TEST_OPTS=\"$GIT_TEST_OPTS\" "\
+"GIT_TEST_CLONE_2GB=$GIT_TEST_CLONE_2GB"
+
+TEST_GIT_CMD="linux32 --32bit i386 sh -c "\
+"'$APT_INSTALL && cd /usr/src/git && $TEST_GIT_ENV make -j2 test'"
+
+sudo docker run \
+    --interactive --volume "${PWD}:/usr/src/git" \
+    daald/ubuntu32:xenial /bin/bash -c "$TEST_GIT_CMD"

base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
--
2.11.1

