Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1770207F8
	for <e@80x24.org>; Thu,  4 May 2017 09:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbdEDJuk (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:50:40 -0400
Received: from mout.gmx.net ([212.227.15.18]:50897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbdEDJui (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:50:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEMs-1dPN5Z395O-00OsS6; Thu, 04
 May 2017 11:50:31 +0200
Date:   Thu, 4 May 2017 11:50:31 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 5/7] t4003, t4005, t4007 & t4008: handle CR/LF in t/README
 & t/diff-lib/README
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <8afbd831b79b5978c1c2f8641a911c02e4175de2.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KRnbcso738TMZYVzFksYXZ5aMKnyy2+yssFYPsUUBnAcuAUbqgY
 qifVXQujK2uc+suMC2jdG5UFlaLqHnwtHcxMLkmU1NVE6GI/epu3bgGChZfcQV71WPcnzS8
 9GxymzDmtK0am8r1ndFT84n20hkHvGnAUqDPoQlILIlx4yqPMUjuboINH581STHamIazpt5
 1b8eERz8tHVYhhouFfRAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xWdlteBUgvM=:cOmabizd8r+8SIPJmp1Wk2
 /snkrbcKQrrt6gor/yE+erlF8AmsXs7DEJDnAJrMuMq8UBIbuoP6RmN2XqLuwuI2nk6gEBlDt
 huw1ejP5EWy+sgEykQh9M2y+wS52BsfgtA6IocvuAO03vYOylAQ6QiCrfwKTlRJVPLWYEOGNb
 wd0w1j7gbU80qDe0oa55M0VnS3T/B8nY9vKYiRX5XyTG8Qq9l1L8UsHPJ5/Ya32FT9rxWP615
 CEQHY2hryMcoJ5OjlgC3lGsW+ayeFbJaiwCTqc+Yryv3v01Yy3aujAppFW5KtllBXgmfol49Y
 Sv3BNO3tSiB/TLQqHvRmEp9GE+gr/odx5M/JJdh14/BPX68rCKDYCKjIoX0uPnratpSh9fUl+
 eq0ZJqIKnVOcRoavYLwou/pwaa/EQAxRKc8bl53vMmw+Ksp7CMAWk/BzT0XF49/ApgYItBHDT
 h26dOGrlZZXTX63NLBKOUGBPpKDu1RhXcPsvTcQMuzbMNRnlk/3Bq4o37Cd/JnSseBIJeCqW6
 JNqOko5Z+OD2y3RuehroKINSHGuN6YLEfPYL9dSz+Tb7T8kxM9up2nqvjle2CMpdNJ2k6lU5G
 dVa4OgyIpqh6/Xaz+FfoAlkkYuHOax4fRyIM3R7vr9IPiKhtbCcGBt7TSBfvzys2OAK499QJh
 b+NZGh7LZHi5PWJtbLhz2IAMTJHup6UIhJj/9maMHR25MOGBY9FWyuAoPr+yq7iFjrt//QJyv
 FwPfiranrE7/6hHcwYpMkMUQqzof1/eagy5fWSkJ1B0syQ4luDQgZIQ2r173qcLr/1vENlRwY
 l/1NHag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seeing as Git originates from the Linux ecosystem, it is understandable
that the assumption of Unix line endings is deeply ingrained in Git's
source code as well as its test suite.

However, we must not force files that are otherwise unrelated to tests
to have Unix line endings just to appease test scripts that may use
them. Instead, the test scripts should be indifferent what line endings
files outside their corresponding tNNNN/ directories have.

As t4003-diff-rename-1.sh, t4005-diff-rename-2.sh, t4007-rename-3.sh &
t4008-diff-break-rewrite.sh make hard-coded assumptions about the SHA-1
of the tested files, and as those files' contents originate from outside
this script's sphere of authority, it must handle CR/LF line endings in
those files gracefully. We do that by simply stripping out CR bytes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4003-diff-rename-1.sh      | 4 ++--
 t/t4005-diff-rename-2.sh      | 4 ++--
 t/t4007-rename-3.sh           | 2 +-
 t/t4008-diff-break-rewrite.sh | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index df2accb6555..c3e0a3c3fc9 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -11,7 +11,7 @@ test_description='More rename detection
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -99,7 +99,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
index 135addbfbda..f1641c35ee2 100755
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -11,7 +11,7 @@ test_description='Same rename detection as t4003 but testing diff-raw.
 
 test_expect_success \
     'prepare reference tree' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      echo frotz >rezrov &&
     git update-index --add COPYING rezrov &&
     tree=$(git write-tree) &&
@@ -71,7 +71,7 @@ test_expect_success \
 
 test_expect_success \
     'prepare work tree once again' \
-    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
+    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
      git update-index --add --remove COPYING COPYING.1'
 
 git diff-index -C --find-copies-harder $tree >current
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
index dae327fabbf..0157fde5503 100755
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -11,7 +11,7 @@ test_description='Rename interaction with pathspec.
 
 test_expect_success 'prepare reference tree' '
 	mkdir path0 path1 &&
-	cp "$TEST_DIRECTORY"/diff-lib/COPYING path0/COPYING &&
+	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >path0/COPYING &&
 	git update-index --add path0/COPYING &&
 	tree=$(git write-tree) &&
 	echo $tree
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 9dd1bc5e162..5af4fa6aadb 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -25,8 +25,8 @@ Further, with -B and -M together, these should turn into two renames.
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
 test_expect_success setup '
-	cat "$TEST_DIRECTORY"/diff-lib/README >file0 &&
-	cat "$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
+	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/README >file0 &&
+	tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >file1 &&
 	git update-index --add file0 file1 &&
 	git tag reference $(git write-tree)
 '
-- 
2.12.2.windows.2.800.gede8f145e06


