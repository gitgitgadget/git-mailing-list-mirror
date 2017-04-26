Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9218F207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999068AbdDZL7a (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:54504 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954263AbdDZL72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:28 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgHHO-1dR5HP3pyQ-00Nijg; Wed, 26
 Apr 2017 13:59:18 +0200
Date:   Wed, 26 Apr 2017 13:59:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/9] rebase -i: remove useless indentation
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <12ea7b6754b3378be2b8e69d0fc5bb146bd2df63.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kBX3C1gy4HAJVlPrZhnztg+duNxvXP2FpTDl4sxqO4pNuE4UpEt
 7+XGXmdxBU98llaBxeRlVNW8n4Y7Rw1ruQ1HlqjYAP4sn2kOU5yQFUiL//FZe1xJUQAPzDU
 eIduu/HwAT7a1rrYXf8aGwAyxca8FOysTjTPfIBiIChPjO6uaOVeqebMrMOxdtb2pJLtXYJ
 iv36acE+9CEaEKdUE7UNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xb9p6wVtY04=:BcuA+eUsWCWHicDE1oISG5
 +SPfwmiwUDMg4ziEF9K/cm0PnXk9H3soZAmTclcMcvTqJXzzML4VxAvtcYusa7w2yhoE3x7X2
 bCaKWJXF8UjI32aOHEEkg2MC0yTAfyyxiYGYomGbNQjJuvYju1HhAQqtrXvp5H5g3Zv1KCUF8
 NsuPRYneuDI+smjlaKGCnLgesuQE8jG30XJbCWALU9E1QlFqdV8A46/2feri4BMing4bkEcqx
 FtwaCXpIc+NGSgk887PE0RgHx+PJcYdvngyekjvC1o5XMMoRoG2rjOtv4JxdV06EjdOHDX6CX
 EXzYcJ2U1cJbPOM4N1R0ELyKeS4CObmutCiNv5AlFGYOwgGnETso/IKPhaqBVRTyLKkCQSCEX
 a/jiDbD1QFbxCVJ1V/e1rZxdhvkJr1gl53uL4lSXHSkZdHDqAgGYWTjgdjXuwRngeoIj+egIL
 OzWmsIKpgXXV4khbuzIVfM6c74mttFSVTbPe5vB7jhuTTizmWkNGvaOyAytZRuoizCgnx45Mh
 vj+100b28EmsZZUMxAnWZk3W1ijwGz3Oo7IzQE/pQrqwhvFZs2rlwz9UuSULlHAnUUlDJe/7u
 zYuBkLGnzGID30fx5gLi4ndvlT4Uw0J9GVFScgACRIA9gKklO1GRRi7Kbh38K7qAziWJt0wCl
 4qlJdQ7OBxVoqPKWWkg/dY5mTpW3FD2puNOZRpdvbksMJsehDS0wiGugSegs/DZMVxmHqoMpF
 XjUsClJYNEbXXcot4Ag/nrtmXgyAUyEMPjulw316P2WSfvX306qk9zg9myRjhFWnxQNbhBmiq
 BAOZDRa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands used to be indented, and it is nice to look at, but when we
transform the SHA-1s, the indentation is removed. So let's do away with it.

For the moment, at least: when we will use the upcoming rebase--helper
to transform the SHA-1s, we *will* keep the indentation and can
reintroduce it. Yet, to be able to validate the rebase--helper against
the output of the current shell script version, we need to remove the
extra indentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 609e150d38f..c40b1fd1d2e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -155,13 +155,13 @@ reschedule_last_action () {
 append_todo_help () {
 	gettext "
 Commands:
- p, pick = use commit
- r, reword = use commit, but edit the commit message
- e, edit = use commit, but stop for amending
- s, squash = use commit, but meld into previous commit
- f, fixup = like \"squash\", but discard this commit's log message
- x, exec = run command (the rest of the line) using shell
- d, drop = remove commit
+p, pick = use commit
+r, reword = use commit, but edit the commit message
+e, edit = use commit, but stop for amending
+s, squash = use commit, but meld into previous commit
+f, fixup = like \"squash\", but discard this commit's log message
+x, exec = run command (the rest of the line) using shell
+d, drop = remove commit
 
 These lines can be re-ordered; they are executed from top to bottom.
 " | git stripspace --comment-lines >>"$todo"
-- 
2.12.2.windows.2.406.gd14a8f8640f


