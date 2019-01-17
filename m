Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5FB1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 01:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfAQB3m (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 20:29:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54354 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfAQB3k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 20:29:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4041699wmh.4
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 17:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DtqSx7pBpnA/nOfUlgB+XJtkrVCPUoA70Fv87HlSR0=;
        b=nF1Gm9x+FmhX/WP251v2EkTLtduqtorC0fwdAJL4DXmxu4S9alVka3VX4SjiArE4lV
         VQPPkE6yL8CV5EzwUq31G1l0SWCCdOvKxD7XKWrzGkpZIvpyM/TUu/cI6pz8o133jD/+
         CahOPPdGX02ewxIdTfQZ5jp2nbSqL8qWYQQRPWW85TnHLbO+RHSACA/ACWyYOrn7v1HW
         H6Stq2EZLWun/0/7vzNXSHetW5VuBjBwa9T4/TiK9q6dE6rJtUNvp7BOAz8jcdM0t5kz
         SJdS1LFAzbELRWpFPzkWbrneyXSRqgutfgkm3lLqwkMyVsCLVadJ5BQG5cni+3KHFCcm
         y7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DtqSx7pBpnA/nOfUlgB+XJtkrVCPUoA70Fv87HlSR0=;
        b=OHmNVRRO7dZePfACFfFOXg2eRIw97jVnMMe+CxKJM+SLtTScIrAgs8h+7LWAJt1+cH
         +Su3ejUwaBQH2pB8D0uPA0AKV78aaX5Cv5CJfR2essULfN4T5ToYrBSoP5vAETbW35hp
         bFRJjKnzYEeWnxJ2n+ahM2lA+/HoBCPFKho5/DHX2+zxqHcVJ1Y28zUkIxjoDDPc9ucE
         iUp0U0JlAc9erlQtH5RCkpiWHRbKuhznEh8JuAEwLTbZWDx4RpR5ZBblMA9LCy+RaZOe
         cK6eK9A/BMx3yEAQrD1RcgWzwqiu+Khu8/4w6SsG16I38qUCgTKeddOB8ayXKQTNkF8s
         rrTg==
X-Gm-Message-State: AJcUukf1HBjJDDQ3/dY+yUwQR0p4PoeBPPu28a+hplWnPO20UMh8pIRI
        ENBQnqxZgOc+kgPpL79xR2A=
X-Google-Smtp-Source: ALg8bN6NCSq565PzMMaA2ACg6TiJwh3jyqP9Hu9oTVKhKqWVtyt+fw0Hsk3BAKhzCMfY/2VhMJDp6Q==
X-Received: by 2002:a1c:384:: with SMTP id 126mr9554690wmd.26.1547688578504;
        Wed, 16 Jan 2019 17:29:38 -0800 (PST)
Received: from localhost.localdomain (x4db4a994.dyn.telefonica.de. [77.180.169.148])
        by smtp.gmail.com with ESMTPSA id y13sm36818272wme.2.2019.01.16.17.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jan 2019 17:29:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 5/5] travis-ci: build with the right compiler
Date:   Thu, 17 Jan 2019 02:29:13 +0100
Message-Id: <20190117012913.30562-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <20190117012913.30562-1-szeder.dev@gmail.com>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20190117012913.30562-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our 'Makefile' hardcodes the compiler to build Git as 'CC = cc'.  This
CC variable can be overridden from the command line, i.e. 'make
CC=gcc-X.Y' will build with that particular GCC version, but not from
the environment, i.e. 'CC=gcc-X.Y make' will still build with whatever
'cc' happens to be on the platform.

Our build jobs on Travis CI are badly affected by this.  In the build
matrix we have dedicated build jobs to build Git with GCC and Clang
both on Linux and macOS from the very beginning (522354d70f (Add
Travis CI support, 2015-11-27)).  Alas, this never really worked as
supposed to, because Travis CI specifies the compiler for those build
jobs as 'export CC=gcc' and 'export CC=clang' (which works fine for
projects built with './configure && make').  Consequently, our
'linux-clang' build job has always used GCC, because that's where 'cc'
points at in Travis CI's Linux images, while the 'osx-gcc' build job
has always used Clang.  Furthermore, 37fa4b3c78 (travis-ci: run gcc-8
on linux-gcc jobs, 2018-05-19) added an 'export CC=gcc-8' in an
attempt to build with a more modern compiler, but to no avail.

Set MAKEFLAGS with CC based on the $CC environment variable, so 'make'
will run the "right" compiler.  The Xcode 10.1 macOS image on Travis
CI already contains the gcc@8 package from Homebrew, but we have to
'brew link' it first to be able to use it.

So with this patch our build jobs will build Git with the following
compiler versions:

  linux-clang: clang version 5.0.0 (tags/RELEASE_500/final)
  linux-gcc:   gcc-8 (Ubuntu 8.1.0-5ubuntu1~14.04) 8.1.0

  osx-clang: Apple LLVM version 10.0.0 (clang-1000.11.45.5)
  osx-gcc:   gcc-8 (Homebrew GCC 8.2.0) 8.2.0

  GETTEXT_POISON: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh |  5 +++++
 ci/lib-travisci.sh         | 15 ++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 06c3546e1e..dc719876bb 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -40,6 +40,11 @@ osx-clang|osx-gcc)
 	brew install git-lfs gettext
 	brew link --force gettext
 	brew install caskroom/cask/perforce
+	case "$jobname" in
+	osx-gcc)
+		brew link gcc@8
+		;;
+	esac
 	;;
 StaticAnalysis)
 	sudo apt-get -q update
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 69dff4d1ec..a479613a57 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -99,12 +99,14 @@ export DEFAULT_TEST_TARGET=prove
 export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 export GIT_TEST_OPTS="--verbose-log -x --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
-if [ "$jobname" = linux-gcc ]; then
-	export CC=gcc-8
-fi
 
 case "$jobname" in
 linux-clang|linux-gcc)
+	if [ "$jobname" = linux-gcc ]
+	then
+		export CC=gcc-8
+	fi
+
 	export GIT_TEST_HTTPD=YesPlease
 
 	# The Linux build installs the defined dependency versions below.
@@ -118,6 +120,11 @@ linux-clang|linux-gcc)
 	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 osx-clang|osx-gcc)
+	if [ "$jobname" = osx-gcc ]
+	then
+		export CC=gcc-8
+	fi
+
 	# t9810 occasionally fails on Travis CI OS X
 	# t9816 occasionally fails with "TAP out of sequence errors" on
 	# Travis CI OS X
@@ -127,3 +134,5 @@ GIT_TEST_GETTEXT_POISON)
 	export GIT_TEST_GETTEXT_POISON=YesPlease
 	;;
 esac
+
+export MAKEFLAGS="CC=${CC:-cc}"
-- 
2.20.1.499.gf60de1223c

