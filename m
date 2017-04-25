Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7BC1FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431358AbdDYNwV (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:62686 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1431331AbdDYNwI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmJsk-1cTP9N2T4c-00a1Iu; Tue, 25
 Apr 2017 15:52:03 +0200
Date:   Tue, 25 Apr 2017 15:52:02 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 5/9] t3404: relax rebase.missingCommitsCheck tests
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <b63c3c4bfa5d9686647dc107f143ce58fa5074ec.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6Jr3o4q6MUtgf0mJrhlib6thORqYazWeaqi3p6MvQipZdlQ42W2
 xz1eVOO8RdSXrhcAUuZJ2JGqQWqGhiBotUVal6gsXLlq61WAG3C583J/Fmh333ad/+X/bZN
 E1exKxCzLRtgcRVcHwE+6ITuKiZ5R/boB6Du+F5H6LolAvg3zG1CKHY9qQk+dCQ3746vKj4
 l95a+JZfTTHQ5K1zkxqzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7lRZSjTxoV8=:DPe7ygK84i7deSZluadvn4
 10ogBZ+3fLsFjgiOdSTEq7l4ZxODFbZD2E5owMoJfI2v0EHu+O2MaSY2lhvZyPKYdx76Bh+Hs
 jICkLaMcsvRNH/bVGtO02zp4ccpjjN2NWnYHVFypKjNtxHvL7ShH9CeiS8ZP3A8LZkbUlr2Y/
 bnJ+oWMhdNEAuCz9vqf2O7N7G89H2LeKKqlY3xiyD8AUBJtgZBf4xxdT739n1CKPIu2Wxwg9C
 YSQis9HmEPdRWqf5Xl9ScGEhgYylQViVPxNG169m/dt8cYoJT1cFhLmdTvWuPrpW0LkS9HUsW
 3RxsqDZ0austM+gFUvOa6KRjnlZvfWagyu7k/nelABpqXNcA+a8PEmoexbXBu4ZBOfV/tjSh1
 XO01lJ084OSrfLKZ6jHAu07UvTWK8kKj/FTuA2fJ2ZInE2tOa9iXTjMmO7hx4h1n+Zr0ZUziP
 gl7m1nHSKVScVMYD0sg//wF+jPDMtzRYVR2v/ng9bHnYKzI5j82oD8npvlOPRJNY+ILaHq6b5
 amcwZUoTLKoy+PgIVQYP4KMbaejRu52xJWOByAA9PBAGRpW+Ky/NIiv40+nxlienUpp15teRU
 hSafXRfdhCWK1UUUH0gM4/ahQC3ICMvZKA7ChLIydYsY5LDP8Ics+WaR2MGtqX0CJZVSzRL4P
 9o9SYNZ+0xNpLn/UYUspNxuHSGK2o3ni5L9OJ6bCpzSTK6waxa/eLJ1JkWqcyBB1oz66echo/
 Y7whsV+R/e5TCUqfvrhi6Jxv6iYUOU/ul33+46C0AJQUhPwe1tb0YmRohaYkG9JnuznqKOoFt
 BYQ2Log
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


