Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 292661F404
	for <e@80x24.org>; Mon, 22 Jan 2018 13:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeAVNcx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 08:32:53 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:44250 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeAVNcq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 08:32:46 -0500
Received: by mail-wr0-f173.google.com with SMTP id w50so8665648wrc.11
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G7cfhv+DmZnIxGy7YrBb44xjjEZ+YUC/R7srltXCJxQ=;
        b=a8x5FrlvvT8/zn6zt2FAzTlRFkgWvfxOG8zq0tMDZChHKzVuR63XhzpAJfhqQyIvYq
         YpZ2rFsSBZmlHJByJC6bnBel2vN3uzxkOkrB43Jzz0moPXx45Xbf8a7GnikNdhDhqzHO
         mKXhsOciV7Lt3JofU6CgI7kM+WQCkpUbfKtS9UAn2yBQqIQck+C5eEHfUV76PO+axqa/
         73oQ1dBGBr1FfUfWRYPN94FfVvFCSjMBnxofjKuzcBJ9qyBrgB2tfmxwGrSSsW2KUImE
         esEmjloCdp/FSMveqg5KfVE4ecFoFCVlDNk2IJ601TWC/N7clyqPg5n2CL1BFHzld4h8
         6heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7cfhv+DmZnIxGy7YrBb44xjjEZ+YUC/R7srltXCJxQ=;
        b=MQLfJniaCEU2hYrIyv6MsYQKIk0Mf+o9ysMhOEbRQ+G0sGb4iAX6aFsVj+DjXI31hN
         ggT7w3u5kNPNn6EA4cTDldVmecNDmmw3+F7P70Js3rkJ2z7h3GkOPWBuq8H2B8UV1rz7
         LMtoWNeSlW6PWFFULziIN7yd8WbpKGdPY38LJW9GZ1QfX/ucYDmY0qXdh+eJ8e3dXef1
         UQnIO3fYL3pBqxz2gVLS/+C9Pcp3NQ+D9Qv64NZSITVgs9yH8tFgJpTKKFZZO01kjqwP
         BdhsFXCys4H2SY8+sxgtHxB9lBH0nc6x6TozS7XuhBgb50xVxmIlYKmDh/99o9F3rhPe
         SpPw==
X-Gm-Message-State: AKwxyte4yV+VorG9bResNwjtVLE/Xlk5czz91UcXAcMZgGJPH5EZVHIU
        9EYasSQhe4/aPLNsYwKcUKo=
X-Google-Smtp-Source: AH8x224p1Mz2BOgkFBaydNrPhRT4ZiHyMpxGiQlShQDwYHBbWUAAhdtc3t9ohBoKACfEjPgG0M4Grw==
X-Received: by 10.223.135.187 with SMTP id b56mr6631001wrb.164.1516627965471;
        Mon, 22 Jan 2018 05:32:45 -0800 (PST)
Received: from localhost.localdomain (x590e64ec.dyn.telefonica.de. [89.14.100.236])
        by smtp.gmail.com with ESMTPSA id c54sm24284520wrg.68.2018.01.22.05.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jan 2018 05:32:45 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/5] travis-ci: don't run the test suite as root in the 32 bit Linux build
Date:   Mon, 22 Jan 2018 14:32:19 +0100
Message-Id: <20180122133220.18587-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.80.gc0eec9753d
In-Reply-To: <20180122133220.18587-1-szeder.dev@gmail.com>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI runs the 32 bit Linux build job in a Docker container, where
all commands are executed as root by default.  Therefore, ever since
we added this build job in 88dedd5e7 (Travis: also test on 32-bit
Linux, 2017-03-05), we have a bit of code to create a user in the
container matching the ID of the host user and then to run the test
suite as this user.  Matching the host user ID is important, because
otherwise the host user would have no access to any files written by
processes running in the container, notably the logs of failed tests
couldn't be included in the build job's trace log.

Alas, this piece of code never worked, because it sets the variable
holding the user name ($CI_USER) in a subshell, meaning it doesn't
have any effect by the time we get to the point to actually use the
variable to switch users with 'su'.  So all this time we were running
the test suite as root.

Reorganize that piece of code in 'ci/run-linux32-build.sh' a bit to
avoid that problematic subshell and to ensure that we switch to the
right user.  Furthermore, make the script's optional host user ID
option mandatory, so running the build accidentally as root will
become harder when debugging locally.  If someone really wants to run
the test suite as root, whatever the reasons might be, it'll still be
possible to do so by explicitly passing '0' as host user ID.

Finally, one last catch: since commit 7e72cfcee (travis-ci: save prove
state for the 32 bit Linux build, 2017-12-27) the 'prove' test harness
has been writing its state to the Travis CI cache directory from
within the Docker container while running as root.  After this patch
'prove' will run as a regular user, so in future build jobs it won't
be able overwrite a previously written, still root-owned state file,
resulting in build job failures.  To resolve this we should manually
delete caches containing such root-owned files, but that would be a
hassle.  Instead, work this around by changing the owner of the whole
contents of the cache directory to the host user ID.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh  | 30 +++++++++++++++++++++++++-----
 ci/run-linux32-docker.sh |  2 +-
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index c9476d6598..e37e1d2d5f 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -3,11 +3,17 @@
 # Build and test Git in a 32-bit environment
 #
 # Usage:
-#   run-linux32-build.sh [host-user-id]
+#   run-linux32-build.sh <host-user-id>
 #
 
 set -ex
 
+if test $# -ne 1 || test -z "$1"
+then
+	echo >&2 "usage: run-linux32-build.sh <host-user-id>"
+	exit 1
+fi
+
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
@@ -18,11 +24,25 @@ linux32 --32bit i386 sh -c '
 # If this script runs inside a docker container, then all commands are
 # usually executed as root. Consequently, the host user might not be
 # able to access the test output files.
-# If a host user id is given, then create a user "ci" with the host user
-# id to make everything accessible to the host user.
+# If a non 0 host user id is given, then create a user "ci" with that
+# user id to make everything accessible to the host user.
 HOST_UID=$1
-CI_USER=$USER
-test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
+if test $HOST_UID -eq 0
+then
+	# Just in case someone does want to run the test suite as root.
+	CI_USER=root
+else
+	CI_USER=ci
+	useradd -u $HOST_UID $CI_USER
+	# Due to a bug the test suite was run as root in the past, so
+	# a prove state file created back then is only accessible by
+	# root.  Now that bug is fixed, the test suite is run as a
+	# regular user, but the prove state file coming from Travis
+	# CI's cache might still be owned by root.
+	# Make sure that this user has rights to any cached files,
+	# including an existing prove state file.
+	test -n "$cache_dir" && chown -R $HOST_UID:$HOST_UID "$cache_dir"
+fi
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c "
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 15288ea2cf..21637903ce 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -9,7 +9,7 @@ docker pull daald/ubuntu32:xenial
 
 # Use the following command to debug the docker build locally:
 # $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
-# root@container:/# /usr/src/git/ci/run-linux32-build.sh
+# root@container:/# /usr/src/git/ci/run-linux32-build.sh <host-user-id>
 
 container_cache_dir=/tmp/travis-cache
 
-- 
2.16.1.80.gc0eec9753d

