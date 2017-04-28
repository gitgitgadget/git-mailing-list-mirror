Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D18E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2992613AbdD1Vcz (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:32:55 -0400
Received: from mout.gmx.net ([212.227.15.18]:58673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992569AbdD1Vcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:32:53 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3j17-1dufbF30Ft-00rKj1; Fri, 28
 Apr 2017 23:32:40 +0200
Date:   Fri, 28 Apr 2017 23:32:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 06/10] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <f43af06e50eaeb93289692ca64d706a0be769bb9.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T7bh6SZKtmKRJYpnw7mi4ewrol7YWuD5L5VknNFC5y1tvajBXxM
 js7EjBcDuNA1JYsR5GZ6u1lr6pQ12wKK6sAkhWdA1I36tNuTPmVPZwjAyuZZ8fFtIfX4YbM
 XrLKrrWgSH8vz6Y9e1YGKUq3QiS1evvMUqVMStKMGIs2R/OAIvAxLnrTc6g8H5ysWSQjoWH
 q38mvXFlhlPoNTwiB9tuQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p8iGAWDHwd4=:2hbSuZCpWQMQlEvMTa/o+G
 r/CPg0pmvjYZmkLJ+9Q/79it79RNjzyLU62nRlYDxwawvKo+NhWgkNvRvv1fXJQre5vp13nOe
 CN3xmTpVFOnAzq3Y9w3KcoQd1f8TqDhIz5Yl28YOdrY+26EfMfaEqYStj2gC2/SUHAQro0JkS
 PUrdR4VN4Kz//G/t0gXB0FHKtsgi6ba3QCx059NXrfQBK0KoZdSztZaJYM3Ux0e//mVulqg4V
 2X1qYm43esRgyp6uvWQweX39zV/J6EQbXeG9pLjGm65+nIvpSbJsmYY10L/R/qM46nioiF3Po
 i4YQF0ThnYmU/0cfVenm1GMa+g4ZmbbRC5l4Uav7BtbGYtXzEhxtCx6ZAt9AfsYK7jQojw7Hn
 ID44l3da98bect3HL7O5X5mnL2GyIc9eCZiSnSdg9JtsSZ4E5fvyudmV8PuXrMuXe08JvWjrB
 n5QXNvtzprwVO9BmFhuw9GcjEIcLhGG9ZroBlOVxVkuNP5emb3Xsmt4B+zBJe211NJuwq6tmf
 xYKhdZMH80/f+sfPei2lnOMbs3LhiPz0LmwnJEKXfp2vFs00tpZG8glJOEjUnon6mvNgsXNRr
 cN07xJGVUECJSDW8dvKaq34EzSqT1pZpBN4aNsrT+zSo2svWp7GiCdnarw7ROQxeYTEPRW6cI
 kE9H6BoDczvSOD6J0U2HWKkoOZJ5rYTDVg5L+Pjk6uuM19G7op2DMfSMKeKIL2xVG2/dQMNdN
 xsj2jZ0LUyC7y6g37QfGiG9dw6a0Awo5+SBcO2ti98bPjt14vY9Y/NCEAu1zAQW3t1bYkdv9F
 BFxHWJa
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
2.12.2.windows.2.800.gede8f145e06


