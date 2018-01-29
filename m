Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105EA1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 17:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeA2RRi (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 12:17:38 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33543 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA2RR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 12:17:27 -0500
Received: by mail-wr0-f194.google.com with SMTP id s5so8095896wra.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eeOcZ3RE4xEt+sOI9AmVkzDY2fXqS7aQ8zEtQN3lBSE=;
        b=hOrMDDc8WsxKyDvpwgbS/ZMAGMrAhMR5jDymVEjDGZtR/BwGiCAiDqZjcsl6jsfI73
         LtaiicWs70IkX08iFXtQGDIQK4thM/BZfRfxUG+h1swP7ryKHlbI27ezXsb0bpHSZ2Fo
         4lGo3ItInSU0or3uVMqMBfa9g+eOvofuhepMDmb9GQx2SlOx+8Coz8+UWkpL5M2FJpYX
         tGIQrSQaaYrvJXHGIKGLkdk6tSqu2LCQxY5oGPltt7EnWnrbf0Lz84ETRzgmW7i49kGa
         2Xf+RtlVOG3UYg4mYa5jkLG869AraOQQXjq6UJU8nt+bSk5qHs3mpttrkvP8i8ildwS3
         rvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeOcZ3RE4xEt+sOI9AmVkzDY2fXqS7aQ8zEtQN3lBSE=;
        b=m3pJkHpAjczguKkzbShAi5d/yQoo8Ob8Vukhv1f2lbY0mBg1YUCrK4Gu3/9b9FgZqp
         vkHOevEMmbpTHza10b+h4aRHzga/RdWU6WOlXE9lKDl+a/nnYLskmh2/JbJ+7AgPqMnG
         q1lAq6yTCdcbAY+5nh9J9eT8ALABWglZOQ83/wCeAFBV3MQMPK1Kh79Qm9v7joVKUOii
         T5fqtHy9rwz2LqyNatP7A/iviLhFBxJX06smIM+GuJfv55ilfwwDUjWHElBhu+olJyLi
         qBFgzF0LJIOEohSCgJU12lpzvFXVhJwvBOKl3yN2mGJzjptILSLwATrcVBOe3e0mM9bE
         XduQ==
X-Gm-Message-State: AKwxytfN+qQ1phDXQjOKci05QK9cucU+hEZDtH4uZdfK3CkF/f2RTjp3
        OULuCRagJazrvsms6aIGnb8=
X-Google-Smtp-Source: AH8x224ESmYLJjfO8bigUpjYltgQhe1HJpslnxuKMrmj8fJ7Cn4D/iULBaCcImXsXR6LQb/q0BD+mA==
X-Received: by 10.223.192.129 with SMTP id d1mr21199286wrf.50.1517246245784;
        Mon, 29 Jan 2018 09:17:25 -0800 (PST)
Received: from localhost.localdomain (x590c5617.dyn.telefonica.de. [89.12.86.23])
        by smtp.gmail.com with ESMTPSA id p21sm4050876wmc.28.2018.01.29.09.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jan 2018 09:17:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 2/5] travis-ci: use 'set -e' in the 32 bit Linux build job
Date:   Mon, 29 Jan 2018 18:17:10 +0100
Message-Id: <20180129171713.17471-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180129171713.17471-1-szeder.dev@gmail.com>
References: <20180129171713.17471-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The script 'ci/run-linux32-build.sh' running inside the Docker
container of the 32 bit Linux build job uses an && chain to break the
build if one of the commands fails.  This is problematic for two
reasons:

  - The && chain is broken, because there is this in the middle:

    test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&

    Luckily it is broken in a way that it didn't lead to false
    successes.  If installing dependencies fails, then the rest of the
    first && chain is skipped and execution resumes  after the ||
    operator.  At that point $HOST_UID is still unset, causing
    'useradd' to error out with "invalid user ID 'ci'", which in turn
    causes the second && chain to abort the script and thus break the
    build.

  - All other 'ci/*' scripts use 'set -e' to break the build if one of
    the commands fails.  This inconsistency among these scripts is
    asking for trouble: I forgot about the && chain more than once
    while working on this patch series.

Enable 'set -e' for the whole script and for the commands executed
under 'su' as well.

While touching every line in the 'su' command block anyway, change
their indentation to use a tab instead of spaces.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/run-linux32-build.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index 5a36a8d7c..248183982 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -6,29 +6,29 @@
 #   run-linux32-build.sh [host-user-id]
 #
 
-set -x
+set -ex
 
 # Update packages to the latest available versions
 linux32 --32bit i386 sh -c '
     apt update >/dev/null &&
     apt install -y build-essential libcurl4-openssl-dev libssl-dev \
 	libexpat-dev gettext python >/dev/null
-' &&
+'
 
 # If this script runs inside a docker container, then all commands are
 # usually executed as root. Consequently, the host user might not be
 # able to access the test output files.
 # If a host user id is given, then create a user "ci" with the host user
 # id to make everything accessible to the host user.
-HOST_UID=$1 &&
-CI_USER=$USER &&
-test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER) &&
+HOST_UID=$1
+CI_USER=$USER
+test -z $HOST_UID || (CI_USER="ci" && useradd -u $HOST_UID $CI_USER)
 
 # Build and test
 linux32 --32bit i386 su -m -l $CI_USER -c '
-    set -x &&
-    cd /usr/src/git &&
-    ln -s /tmp/travis-cache/.prove t/.prove &&
-    make --jobs=2 &&
-    make --quiet test
+	set -ex
+	cd /usr/src/git
+	ln -s /tmp/travis-cache/.prove t/.prove
+	make --jobs=2
+	make --quiet test
 '
-- 
2.16.1.158.ge6451079d

