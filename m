Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865FC20282
	for <e@80x24.org>; Wed, 14 Jun 2017 13:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdFNNHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 09:07:39 -0400
Received: from mout.gmx.net ([212.227.15.18]:55308 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751934AbdFNNHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 09:07:37 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3x6-1dzwU73v7M-00erPO; Wed, 14
 Jun 2017 15:07:28 +0200
Date:   Wed, 14 Jun 2017 15:07:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v5 03/10] rebase -i: remove useless indentation
In-Reply-To: <cover.1497444257.git.johannes.schindelin@gmx.de>
Message-ID: <c7af03867e96e6ce6bf0a7bb858f6018513a4341.1497444257.git.johannes.schindelin@gmx.de>
References: <cover.1497444257.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WDfmIn/+B8qSel/m0+2zudi/1VBcoGXU8TZhpKtnlpMFNMO02xc
 g7tiWcBspBGXecuFBJ4SCeTVgJm5sNjL1HiE2CQVvY3SD8MohhkibuchCcWraLS3pklfgI2
 CYxgm6Ao2HJx3RYbnaoYcVkfMayzipnEx5rPrAF5ytNzKiyRlAsBgAJ/GTl7rMEMBIdv22X
 rlHpsMoiqtHwDDJkBx9yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eQaUSEHb/QE=:uJgRPpDOxvGh26+O8Z/3R7
 n4qZ9/yEGPVtu0QKjsdQAObWa/zBXp6tDQmF3pMu6lMN5ckvVaj76FP/KXK3RL/Co9nD4rmxk
 JLGpjBVGd5XqvF807Ih5aSEk3E/8CznXvKt3SNfy4jxh4G/0R1IL4uc7huMD3isiryNwiOtHh
 UDJFN0g50PW+BfPn5qy3YFFuRYzMgEbDtCU4LrQpFKFk5gT8Q7f09WRZChqqoT2rDizzuiwqv
 xOoz7wqPpZ6QAIlmtAzz4D9xaGrFggqXQrmQhgD1wN8OBoDR3QakfjD4RlVesFsUMwTOqXarH
 tJ/H03W8NVf2ExMACkQ5H//vi6ImQEOu7EPDHQDkwIG/eksPoMhskFltQMhYScDWzxaEx73YV
 H2tnCnnzkSEHklhD2serS+gnz3fZ3PkZa9D6WD0occx4XXbpqKoNzTAIBY1Cue9LvWeUcukL3
 OgVFT7VuGw6BMHiV/2Y0y5Vf94k03Vxff2OGf8F2VsVvb/GqHeXIu3reRUiekocQqvQAxItNO
 xZ59vdKBmrCE5XbS7TTil0cYN9qBT4hTWv+fqhfdIM3tQ8h841Z1R8fc5Gav7GQYDzjXzmliy
 r7Bpd+XPZEH2nWdoEq2nDuNcUQxsePu9/kmcUZq2kdDkVm9/MiZ3MA0cjwqxHWYqvlDoNpbo8
 NBAVU4sH0LP+USS/111cX6W3YEFAyi8Nzmi32s3G6hJtPUJxFPNm1Nn8nPGIlPQXnewzDZVA5
 dLjH8lx7/1KGsgl5xrYrVzKgQ9Xbw+/3HAkDogkOm1TZpLa5vxCTuAjDKCURHdCQtMwbEpARB
 6gg7GLi
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
index 05766835de1..93372c62b2e 100644
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
2.13.1.windows.1.1.ga36e14b3aaa


