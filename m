Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7099F2018E
	for <e@80x24.org>; Sun, 14 Aug 2016 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbcHNVqo (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:46:44 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:52420 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcHNVql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:46:41 -0400
Received: from localhost.localdomain ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z3Esb3wiWcpskZ3EtbC7Dt; Sun, 14 Aug 2016 22:46:40 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=Q1RafEM-AAAA:8 a=O0FzWlqHWzHqSC-_ZPEA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=9Sz_LSTYZ1aKGkXfnLjD:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Subject: [PATCH v1 3/3] doc: rebase: clarify fixup! fixup! constraint
Date:	Sun, 14 Aug 2016 22:46:30 +0100
Message-Id: <20160814214630.1312-4-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160814214630.1312-1-philipoakley@iee.org>
References: <20160814214630.1312-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfG9CQeXAAaLo5IMCDd9+ccJwH+VjjZeLEfvoLJcJA9LXuS+n1YZjugl1vcTw5dVA7NphqELcNTKQdAyiRn+uSXiVhpDChgHNFXJIX/R0CHQyKuUNr2lF
 aYMDMVdL7SBgoGYS23Uoq6Ho2dwSbIJKFKwtXhbmtq0r8+xrULM/9APn
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

22c5b13 (rebase -i: handle fixup! fixup! in --autosquash, 2013-06-27)

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v1
the historical discussion about this is here
https://public-inbox.org/git/20130611180530.GA18488%40oinkpad.pimlott.net/

I certainly misunderstood what this meant. It sounded like only one fixup! was
allowed per commit (i.e. one mistake) - fixing two mistakes wouldn't be
allowed. Hindsight is a wonderful thing.

Also, does 'earliest commit requiring fixup/squash' fully convey that
its the one to fix.
---
 Documentation/git-rebase.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 66b789a..91eb107 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -425,9 +425,9 @@ without an explicit `--interactive`.
 	automatically modify the todo list of rebase -i
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
-	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
-	"fixup! " or "squash! " after the first, in case you referred to an
-	earlier fixup/squash with `git commit --fixup/--squash`.
+	commit from `pick` to `squash` (or `fixup`).  Commits with repeated
+	"fixup! " or "squash! " in the subject line are considered to refer
+	to the earliest commit requiring fixup/squash.
 +
 This option is only valid when the '--interactive' option is used.
 +
-- 
2.9.0.windows.1

