Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE5A207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdEDJuO (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:50:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:63904 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdEDJuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:50:12 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lb5Tp-1dm6fO1WsT-00khbe; Thu, 04
 May 2017 11:49:59 +0200
Date:   Thu, 4 May 2017 11:49:58 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 4/7] t3901: move supporting files into t/t3901/
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <f63ec7ce151febfc7bc64cfbf424d93b56a92ef5.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:th3WIMznrrLOr1+XW8HiDzw7Y4+DzBE19dAeOOFffikyEFNCBuv
 GAx2RC7Bmx2X/TIH8pUYhmUcZHru7u6I2H4vTwOAVptHoOErUM+3PqDco7jKYKoXqP2gR0L
 s3DvBh7+dIwSUBvJingROOVCrLOLXsSkQDaEfuNGstQxGbUSnlVxUatz2qQo5D1U+m7YpKT
 pMKsRgi9nwJAX5enHjFNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pUXyjtRNx5M=:y8P+1u7waO+HAHDunl93aN
 DewxnlmF0fuvoKMp3f1lbJxMJjDODhXdMbMz7HchkzcoJWUXg1bYVM35PCW6A2JqwCXOhqgjB
 5KSYzakS2gqA8dP6cJNEZSSvILZTQovFYNKXWxbBpmli7bbsMLtRxfrodEA/2Gv13yvKbEScs
 uoEvHqSac+UMbM84yIBoMNZRgGnG1h8/Rcmqa6n+gfLR5yoNH26/YFxljKi8BhV5jbyHuI6j8
 nc/1N543PnfRP2wnq4cyKUibhRr7XbX9/60kZ9tmBQVchhuVKhzicd5v0MhkapLkiAhlCHC2W
 lu7OyI/JizQXD3bjEvTFFtPhp0DUJ4TH+abo/LP42/AVwQk/vWJVnM8FUbK14JAlA6QvfGH0E
 JdIxXAVf5n9spK1I0wP5+HAyWPahbHJ0aQIzc4YstK+B2e/gnL95njp/zzChJ3eIkS6MwEPUk
 /h7XRwuVW1kOnrtwKv/JCWE0HQEJYi4PF0Y4i1Kwmlf5Ap3G4Mjof7tS49IV0CsKVDRP5XCCU
 LNw6Oo5ExNnlq5zM5vLqoD8XSLzhMjLT4tKWvUYf8dGuoPlw9dTXs9yg+7RHu94adTSvrOy2C
 eFyBCt5AlWSY4hFu64paIcCqwdq1tLlZOSlVcA8rVW4+Okloyuf8easH5vGaPyh2KZLErcDWK
 NZrakMoMq11c3OV4mafa4hAnc+4k5ecsPPwoXevFjt9o3LPhbNzkT1t5OOqhQz4jY6y5Et/gP
 36eUYmFI1Ri6sxNWVZQLSf8g9a19AsMxPzcQD/KfDRtDapn4itT9Xfd3bmEegKJ7Mko8YUcwR
 iIkDvG/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current convention is to either generate files on the fly in tests,
or to use supporting files taken from a t/tNNNN/ directory (where NNNN
matches the test's number, or the number of the test from which we
borrow supporting files).

The test t3901-i18n-patch.sh was obviously introduced before that
convention was in full swing, hence its supporting files still lived in
t/t3901-8859-1.txt and t/t3901-utf8.txt, respectively.

Let's adjust to the current convention.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0203-gettext-setlocale-sanity.sh      |  4 ++--
 t/t3901-i18n-patch.sh                    | 38 ++++++++++++++++----------------
 t/{t3901-8859-1.txt => t3901/8859-1.txt} |  0
 t/{t3901-utf8.txt => t3901/utf8.txt}     |  0
 t/t9350-fast-export.sh                   |  2 +-
 t/t9500-gitweb-standalone-no-errors.sh   |  4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)
 rename t/{t3901-8859-1.txt => t3901/8859-1.txt} (100%)
 rename t/{t3901-utf8.txt => t3901/utf8.txt} (100%)

diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index a2124600811..71b0d74b4dd 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -8,7 +8,7 @@ test_description="The Git C functions aren't broken by setlocale(3)"
 . ./lib-gettext.sh
 
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_commit "iso-c-commit" iso-under-c &&
 	git show >out 2>err &&
 	! test -s err &&
@@ -16,7 +16,7 @@ test_expect_success 'git show a ISO-8859-1 commit under C locale' '
 '
 
 test_expect_success GETTEXT_LOCALE 'git show a ISO-8859-1 commit under a UTF-8 locale' '
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_commit "iso-utf8-commit" iso-under-utf8 &&
 	LANGUAGE=is LC_ALL="$is_IS_locale" git show >out 2>err &&
 	! test -s err &&
diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
index f663d567c8a..923eb01f0ea 100755
--- a/t/t3901-i18n-patch.sh
+++ b/t/t3901-i18n-patch.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 
 	# use UTF-8 in author and committer name to match the
 	# i18n.commitencoding settings
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	test_tick &&
 	echo "$GIT_AUTHOR_NAME" >mine &&
@@ -55,7 +55,7 @@ test_expect_success setup '
 		# the second one on the side branch is ISO-8859-1
 		git config i18n.commitencoding ISO8859-1 &&
 		# use author and committer name in ISO-8859-1 to match it.
-		. "$TEST_DIRECTORY"/t3901-8859-1.txt
+		. "$TEST_DIRECTORY"/t3901/8859-1.txt
 	fi &&
 	test_tick &&
 	echo Yet another >theirs &&
@@ -100,7 +100,7 @@ test_expect_success 'rebase (U/U)' '
 
 	# The result will be committed by GIT_COMMITTER_NAME --
 	# we want UTF-8 encoded name.
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	git checkout -b test &&
 	git rebase master &&
 
@@ -110,7 +110,7 @@ test_expect_success 'rebase (U/U)' '
 test_expect_success 'rebase (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
 	git rebase master &&
@@ -122,7 +122,7 @@ test_expect_success !MINGW 'rebase (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
 	git rebase master &&
@@ -135,7 +135,7 @@ test_expect_success !MINGW 'rebase (L/U)' '
 	# to get ISO-8859-1 results.
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
 	git rebase master &&
@@ -148,7 +148,7 @@ test_expect_success 'cherry-pick(U/U)' '
 
 	git config i18n.commitencoding UTF-8 &&
 	git config i18n.logoutputencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard master &&
 	git cherry-pick side^ &&
@@ -163,7 +163,7 @@ test_expect_success !MINGW 'cherry-pick(L/L)' '
 
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard master &&
 	git cherry-pick side^ &&
@@ -178,7 +178,7 @@ test_expect_success 'cherry-pick(U/L)' '
 
 	git config i18n.commitencoding UTF-8 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard master &&
 	git cherry-pick side^ &&
@@ -194,7 +194,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
 
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard master &&
 	git cherry-pick side^ &&
@@ -207,7 +207,7 @@ test_expect_success !MINGW 'cherry-pick(L/U)' '
 test_expect_success 'rebase --merge (U/U)' '
 	git config i18n.commitencoding UTF-8 &&
 	git config i18n.logoutputencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
 	git rebase --merge master &&
@@ -218,7 +218,7 @@ test_expect_success 'rebase --merge (U/U)' '
 test_expect_success 'rebase --merge (U/L)' '
 	git config i18n.commitencoding UTF-8 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard side &&
 	git rebase --merge master &&
@@ -230,7 +230,7 @@ test_expect_success 'rebase --merge (L/L)' '
 	# In this test we want ISO-8859-1 encoded commits as the result
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
 	git rebase --merge master &&
@@ -243,7 +243,7 @@ test_expect_success 'rebase --merge (L/U)' '
 	# to get ISO-8859-1 results.
 	git config i18n.commitencoding ISO8859-1 &&
 	git config i18n.logoutputencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard side &&
 	git rebase --merge master &&
@@ -254,7 +254,7 @@ test_expect_success 'rebase --merge (L/U)' '
 test_expect_success 'am (U/U)' '
 	# Apply UTF-8 patches with UTF-8 commitencoding
 	git config i18n.commitencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard master &&
 	git am out-u1 out-u2 &&
@@ -265,7 +265,7 @@ test_expect_success 'am (U/U)' '
 test_expect_success !MINGW 'am (L/L)' '
 	# Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
 	git config i18n.commitencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard master &&
 	git am out-l1 out-l2 &&
@@ -276,7 +276,7 @@ test_expect_success !MINGW 'am (L/L)' '
 test_expect_success 'am (U/L)' '
 	# Apply ISO-8859-1 patches with UTF-8 commitencoding
 	git config i18n.commitencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	git reset --hard master &&
 
 	# am specifies --utf8 by default.
@@ -288,7 +288,7 @@ test_expect_success 'am (U/L)' '
 test_expect_success 'am --no-utf8 (U/L)' '
 	# Apply ISO-8859-1 patches with UTF-8 commitencoding
 	git config i18n.commitencoding UTF-8 &&
-	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 
 	git reset --hard master &&
 	git am --no-utf8 out-l1 out-l2 2>err &&
@@ -303,7 +303,7 @@ test_expect_success 'am --no-utf8 (U/L)' '
 test_expect_success !MINGW 'am (L/U)' '
 	# Apply UTF-8 patches with ISO-8859-1 commitencoding
 	git config i18n.commitencoding ISO8859-1 &&
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 
 	git reset --hard master &&
 	# mailinfo will re-code the commit message to the charset specified by
diff --git a/t/t3901-8859-1.txt b/t/t3901/8859-1.txt
similarity index 100%
rename from t/t3901-8859-1.txt
rename to t/t3901/8859-1.txt
diff --git a/t/t3901-utf8.txt b/t/t3901/utf8.txt
similarity index 100%
rename from t/t3901-utf8.txt
rename to t/t3901/utf8.txt
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b5149fde6ec..8dcb05c4a57 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -70,7 +70,7 @@ test_expect_success 'iso-8859-1' '
 
 	git config i18n.commitencoding ISO8859-1 &&
 	# use author and committer name in ISO-8859-1 to match it.
-	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	test_tick &&
 	echo rosten >file &&
 	git commit -s -m den file &&
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 6d06ed96cbc..cc8d463e01a 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -519,7 +519,7 @@ test_expect_success \
 
 test_expect_success \
 	'encode(commit): utf8' \
-	'. "$TEST_DIRECTORY"/t3901-utf8.txt &&
+	'. "$TEST_DIRECTORY"/t3901/utf8.txt &&
 	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
 	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
 	 echo "UTF-8" >> file &&
@@ -529,7 +529,7 @@ test_expect_success \
 
 test_expect_success \
 	'encode(commit): iso-8859-1' \
-	'. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
+	'. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
 	 test_when_finished "GIT_AUTHOR_NAME=\"A U Thor\"" &&
 	 test_when_finished "GIT_COMMITTER_NAME=\"C O Mitter\"" &&
 	 echo "ISO-8859-1" >> file &&
-- 
2.12.2.windows.2.800.gede8f145e06


