Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004421F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbeACQy5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:54:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:52118 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeACQy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:54:56 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lo2EO-1f8Jz12GpE-00g3XV; Wed, 03 Jan 2018 17:54:51 +0100
Date:   Wed, 3 Jan 2018 17:54:50 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Allow the test suite to pass in a directory whose name
 contains spaces
In-Reply-To: <cover.1514998470.git.johannes.schindelin@gmx.de>
Message-ID: <8d8cb562dcfa3faf65c7427c398158ec29e6fdbc.1514998470.git.johannes.schindelin@gmx.de>
References: <cover.1514998470.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qQv9qcjOG20nXgUho93GiYybvEBUWM2SG90HBz4LcsBocG5/Gk5
 eUAOyX7/AIr6AAyWONPLuxleTvAEV/OyTj9VGNwVFQRz1Pg2vE8UopQOYwiaT1kLo9PNG9V
 3FAcJFyGwrVU72Ct6wt6LvtidNH+UKmVqX2ebIgWMRrFDLKCmVT9OGYNFLT99LNZz/kGq3E
 /tWan92flyQtL81i1Nl6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oHfhDvWyT0M=:bARPq9CSHI4jP6Jn+INa0U
 VR/cG5OT5BqDWS5kiBabXlne/92N0tXUMoeoOTwc1xVtJsMP35unpA922xpNt16PAVf66Pznk
 LmiObMFZbCW2Uw/wbnUHfCaqyfGiFjbRinYxRRWiqpX7v6Hj3EEuGFq+by4AFFCqh5moT+Dt8
 WBGAppzm8NMXFTKtqwFtf7ovn4ou2LRvH/RkSLm7DwRAosaIL3fGwwIdDXnX4gC9JpKbTOOEZ
 rHZImKZUmmkLomjK9a+lryRPWFYokrzfmo6rIsAtO+4lxxaMVDXM60RpS/ffwCjD2jCaOafq2
 9WUM9/LRfpXeQBHhYrAadQ4qFk0JXAyAM7/IHIoFHddYIW0jDenJkJXZBHQDg1OAg2NqULvY3
 dV2cd3/iA3FnLkufpZi7yR0CwdbFvnavF/OPtItogiTbKyHKJQlrWU/SuZRrANEu00ZOeD3mX
 3b6DVU+S1ocDYG6kpWG6yuvjjN0Q+j6ffR0H6ljONkprddmjpA5cswNMDC9l6jWkZcmZVvjCn
 xnEK15iH7zyHjGy/ADK9BqL2bBPP/DW7K5hpGIZB11J6CfwHq5zLlafsgWrFqanK3XChpQv7n
 NMwXo8OruCJbn5UHOpD0XebwetuOl0BF0GsnEs4If6to1wRUvHPneDjD4dC14rmnmv4KjJhFm
 Wb2P99AvrjF7rCqyExQOyWDykgUyyyH9WnW8HPUqGr8JWY00CJdrHsE5IDlKJanzlICxoEHWJ
 5HwcdOHUx5MYfuFNbqqUyrJt1k45ht1NAjLg3/PX8HrkQOXrbXvXXdLub3tSBDi5XAGoTEplP
 Twuw6Qh/p9dsHU2O5bHMGjhiQ9E0A/S3tltUmU/QgW5S0FHwJsSVCMKLsvO7LNq8aoJ/UGO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is totally legitimate to clone Git's source code anywhere, including
into, say, directories whose name (or the name of its absolute path)
contains spaces.

However, a couple of tests failed to anticipate this, for lack of
quoting (or in one instance, for failure to expect more than one space
in the absolute path of the TEST_DIRECTORY). This can be easily verified
by calling these commands in your current clone:

	git clone . with\ spaces
	cd with\ spaces
	make -j15 test

Let's fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7500-commit.sh          | 4 ++--
 t/t9020-remote-svn.sh      | 4 ++--
 t/t9107-git-svn-migrate.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 5739d3ed232..1d33c5feb3e 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -130,8 +130,8 @@ EOF
 test_expect_success 'commit message from template with whitespace issue' '
 	echo "content galore" >>foo &&
 	git add foo &&
-	GIT_EDITOR="$TEST_DIRECTORY"/t7500/add-whitespaced-content git commit \
-		--template "$TEMPLATE" &&
+	GIT_EDITOR=\""$TEST_DIRECTORY"\"/t7500/add-whitespaced-content \
+	git commit --template "$TEMPLATE" &&
 	commit_msg_is "commit message"
 '
 
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 4d81ba1c2c4..6fca08e5e35 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -25,8 +25,8 @@ init_git () {
 	git init &&
 	#git remote add svnsim testsvn::sim:///$TEST_DIRECTORY/t9020/example.svnrdump
 	# let's reuse an existing dump file!?
-	git remote add svnsim testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump
-	git remote add svnfile testsvn::file://$TEST_DIRECTORY/t9154/svn.dump
+	git remote add svnsim "testsvn::sim://$TEST_DIRECTORY/t9154/svn.dump"
+	git remote add svnfile "testsvn::file://$TEST_DIRECTORY/t9154/svn.dump"
 }
 
 if test -e "$GIT_BUILD_DIR/git-remote-testsvn"
diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 9f3ef8f2ef6..ceaa5bad105 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -28,7 +28,7 @@ test_expect_success 'git-svn-HEAD is a real HEAD' '
 	git rev-parse --verify refs/heads/git-svn-HEAD^0
 '
 
-svnrepo_escaped=$(echo $svnrepo | sed 's/ /%20/')
+svnrepo_escaped=$(echo $svnrepo | sed 's/ /%20/g')
 
 test_expect_success 'initialize old-style (v0) git svn layout' '
 	mkdir -p "$GIT_DIR"/git-svn/info "$GIT_DIR"/svn/info &&
-- 
2.15.1.windows.2.391.g0b42e3c56de


