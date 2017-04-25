Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755121FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431350AbdDYNwJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:57456 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945974AbdDYNwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOwY7-1cwfcc3CCN-006R4S; Tue, 25
 Apr 2017 15:51:53 +0200
Date:   Tue, 25 Apr 2017 15:51:52 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/9] rebase -i: remove useless indentation
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <768857b7dfd19c3568f5e0c0ebed36157a0658e7.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:dXUdiwUO77BdUo5nOOG5GQ1w3SRWto1AK3Zsut15LX1RM07mmVf
 yza0utBH7zsHMYuP/5JroVZwgx79WC4FuY/t5NSjNO0AyZhbq0KCFskaf/jpMoE6QOSSq72
 HpBt9XHOESMWfq9+vu71cmAD9hij9rRxgbPmtI+P6OjAQzJczSDNoyDqLZ19IEcTPcd1qE/
 dOoN1WL419nRr9NqyEa9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AqAjS5xLVaM=:bxNKGpdJBsA8/v9QSixCwn
 Vg8/++weEf3LwvUi/Hkiaa5vtPLh2okpzZfjQJIrmiNh6b6eAowIdXpk3g09z1WWAxGgcPm8M
 C4H9ru6EuWLyw5lZ7Dp5nyTZ6gcvlRRLhDEmjk9Re9SpTNekxdS3/kA8a+wvRBeTy8qeAx5oa
 /lUS/IuCp/hfT3irmLRGr+5PW8x/cRYeGexYHC6Na1rHOHoKXFnqOe1Z7ZhEB9Ld9ZAyMGOZK
 H0CBw49CWuNk/B5XAop2euzZ605r2B70LcXxIDzKFXiPt9wa4jA2UeS/05IS10l0ZwgU9s9Bb
 fxNZqt6ey8ZTdbje6578IKtOJ9Y4jCgivI9/gN4zXCQqJ+/0zFJD7I+GEsOeL479vMNlB5p6n
 SRcx3iM1/JSSKGuhATzCEc/JLVCO/k2NyfQTdmBRIMmTrA5BSUF8F5WNYOiNityq/ApSIK5Yh
 uk3Y3pyFGlSYnx2fILpk7QsDuYvUtVHpTBUxlToIUrG+2zl0rvrE0CT3jWicjpOp4x6iOVRTb
 4Z25iLv/JYPfr7QwMm2qlt2Xgd/DeTf8F83LxW+wTOcZClnMypil7XW7NdN5Ali0LTlfWZFRQ
 tZJ3B07QzBbx8JQfllC5zv0cX+CcqLyqs6nI7pUw753cAffe3akgpCZktyRWBJRka6PyxA23z
 DK6NZw/EG53acFeATCk3KYNgDR5KKSumgkM04dTAB4TCMJtTimv+vDwioVfi8qNyHyhkKnxrA
 iVO+6fLz98VnLQgNnSeYW5ULDCmHfBWnQM54Oc3Ib+uwytzdgGHN+UxrY4xpXNc3CmTAMO0KK
 XVjlyl5
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


