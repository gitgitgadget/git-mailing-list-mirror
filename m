Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D811FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932473AbcIBQXf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:54988 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932449AbcIBQXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:34 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2ojS-1aqdTb1szm-00sbWC; Fri, 02 Sep 2016 18:23:29
 +0200
Date:   Fri, 2 Sep 2016 18:23:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <b2f3188f323b70f935956256f037820125b16568.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:62zxGXHK2ugPw/PdmNoSs5qk7NBFIPS9VYMHB0IhO2UibOJ/V/a
 gXL3TluRvGjb7vFlh4qqPiEuHbocpAR/jbhK65K+pP42qekCD8VoSrLMyZLKmtE2+VW8Drg
 dky1FCFAHfDn0EDxi1H/5CzHfmE7tp2Mo7uZmA+7cBnRBKrsErOxkHG2LAddI6W+kq2nCOf
 sSSZ21FIQjcpKZkUniL/Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vmvSZbnz6rQ=:pfnGMQj+LqC/QZQfD68kU3
 WCGN2lDNjfr+PIMIRSmodrFpv8pB4l7Z/m2hR+Dz0VHAWzcnXEXZ5FLwtMz1SQCi2vJZiJVDt
 nB4o1rUJ3xIm2mkca4FOnekC6eH+HYt5WD2z2/xy73ZsS72IB3E+KIzEhfI/4U9h2zl0cJk6S
 BasuKzJAfNbqwipXDzkjaB/Zu5rl0hQxPORJM4QKskoAjcUeODejN+73AONIrtloSFJhZWXBy
 k+oWj31zNMSkG8NQHenwkPRV3TQtSBpcs8Vgy7xSO+cac5+OSLnasgEn7VxpjxdUxMF9MCvhS
 SvcZHN1tUVuYLWFwIqT5EF0Tjzdk0ycqfPUn2o1cr9qRS7kqLOlOn1b106gMz7cAapD0fmuKL
 5zZwM4yNBTil1XkkJbwbYwfqqvS/pn+RWzWX4oYB0hNPigVzHEk1er4ek4i4PEmXHFPylmU1C
 907aTmaelgwwreIm1XILCp//2ng5xJ656Y7he5fdEQRi785UjIkOxwNLt5+A6IztfvjL9DxrZ
 d1hMQoBn/JInOBrWonoViwQe5zJAh7SqkW4PVHaAnIosBX8+uRcH5c+A4fpmBqSouqHyFWZoT
 vM/9fLfQ+/2JIeoM4keDB7wOef3dRL81d3OcKSIuXNTlSBThiqoC8IrhwcuXy/oZ9ruQ5cFfa
 LXjLKGoyjCvZjlqgHm+B5tRFMyJwR89LkI6fZyffAIaqWGFp9gvwZhwlNw5MvoIJOR2L9lxoV
 23iObVHI1wZiFESCz8r2FRdtOrqJJ3MDOLmMALhJIxWOv+QzIp66OYotmB3EDWoDVsy/j3506
 8fXi6jp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests were a bit anal about the *exact* warning/error message
printed by git rebase. But those messages are intended for the *end
user*, therefore it does not make sense to test so rigidly for the
*exact* wording.

In the following, we will reimplement the missing commits check in
the sequencer, with slightly different words.

So let's just test for the parts in the warning/error message that
we *really* care about, nothing more, nothing less.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 597e94e..a18759e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1215,20 +1215,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the command isn't recognized in the following line:
- - badcmd $(git rev-list --oneline -1 master~1)
-
-You can fix this with 'git rebase --edit-todo'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad command' '
 	rebase_setup_and_clean bad-cmd &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 3 bad 4 5" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "badcmd $(git rev-list --oneline -1 master~1)" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 3 drop 4 5" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p) &&
@@ -1250,20 +1243,13 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the SHA-1 is missing or isn't a commit in the following line:
- - edit XXXXXXX False commit
-
-You can fix this with 'git rebase --edit-todo'.
-Or you can abort the rebase with 'git rebase --abort'.
-EOF
-
 test_expect_success 'static check of bad SHA-1' '
 	rebase_setup_and_clean bad-sha &&
 	set_fake_editor &&
 	test_must_fail env FAKE_LINES="1 2 edit fakesha 3 4 5 #" \
 		git rebase -i --root 2>actual &&
-	test_i18ncmp expect actual &&
+	test_i18ngrep "edit XXXXXXX False commit" actual &&
+	test_i18ngrep "You can fix this with .git rebase --edit-todo.." actual &&
 	FAKE_LINES="1 2 4 5 6" git rebase --edit-todo &&
 	git rebase --continue &&
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
-- 
2.9.3.windows.3


