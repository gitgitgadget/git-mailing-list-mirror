Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35E3207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999137AbdDZL7l (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:63340 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954315AbdDZL7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:38 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M03qC-1dxN2S35Bc-00uKQR; Wed, 26
 Apr 2017 13:59:28 +0200
Date:   Wed, 26 Apr 2017 13:59:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 5/9] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <975e7749c2fba9dc263cca1d04879c703c0b3c66.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M23vmkcLcTI5VKpjZHuhnlRX8+BhwjeL4j9FrV+ysF7iyhXRSTK
 zDLd7xRbAi/NY5MpPLygSdrdyrh6nJDrr9dD+2yJKcFqJ00zHvFP5nASEyHXWHw0n7cYpAT
 Xe2AtlvfD7vc4XxXlRW4fGfpZdOVzC8xaFcMr1j1X4/hDVUURfjg1rN2kdNY6UYbXCWv3i9
 5DAi0w6sK+A11H/a2/XIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NDj9nO4deYA=:sUG8t9RNi+drUM70O/abaM
 P2fJq8z0RVZ79QGCGtZK9Od+0JdpxfxA/rq9b79tdpVoSvav4R7h8nwefwrvbqPoiMG6IPMQy
 bTOJewgkK/4J/PnxExCQ4i2itsufxlgoG8iUwu+R/iOPveycQiwdmIkGs/6e0e84cOegSU9xY
 O8LE90LZMx6J7aUzC8VVkA92KDzwOMcW+rnJ84ua1yDYDQcTBATT08qMkS4ZrSe9I/sF5DEMI
 qlsjAmxMVWK5P7cfS7puKwbxV9+Vndg1z7+9ikjieP9HjEBh9F9MWZRP/BWaN3597l9dtyrsa
 DuVDlH15VB28J+uNxJ3Px9w39sC+/V8Yj0D+SOy0xRIorJoIOsBORakUg9oYCWE3oUuWvOAr0
 6861OVnfxdH0bpeji0MtpRokAJ+ZTAFppWsnlDe8irG6/kR1HqX8AxY74pwJWNv77AG5noLK/
 +bDq8tPVuR09j/bn9ZnAUeo1AeZlZXhceg0SIHyxB9MfouVs3xkwoMwcZKLtilw57CUxZYthu
 J/rzJZhm0LkF+Wg1wqNdnAtbySw4JtcUHNL57uqmuO2gfGVRoFBFkRY/Q1tadLcJrQFE3yQCL
 eh1nmDTlyWzcb64Gh68/aCFyJ0/kNZvcLS96Ud27n0QHKGhFpGo8zu1QJqlZEoJJzQ8YsfsfV
 XRiZRgjbgJWHcW37NLf1OgdwiOQwxPQYFm+GZsdt6pCs+QfyjEIUNXOJ9AdoMR4PI/PLMWiTQ
 geZVR2tIsbiMZruqrMm+bLqSTGDwJ2hXdcmN5KKP8usfGRDTtTePdnFF7xw90DeYmc7cBEn+T
 SJ6QRjO
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
index 33d392ba112..61113be08a4 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1242,20 +1242,13 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the command isn't recognized in the following line:
- - badcmd $(git rev-list --oneline -1 master~1)
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
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
@@ -1277,20 +1270,13 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 	test E = $(git cat-file commit HEAD | sed -ne \$p)
 '
 
-cat >expect <<EOF
-Warning: the SHA-1 is missing or isn't a commit in the following line:
- - edit XXXXXXX False commit
-
-You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
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
2.12.2.windows.2.406.gd14a8f8640f


