Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB89E1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbcHNVqr (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:46:47 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:38205 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcHNVql (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:46:41 -0400
Received: from localhost.localdomain ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z3Esb3wiWcpskZ3EtbC7Ds; Sun, 14 Aug 2016 22:46:39 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=xtxXYLxNAAAA:8 a=5rxgeBVgAAAA:8
 a=NEAV23lmAAAA:8 a=O0FzWlqHWzHqSC-_ZPEA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=PwKx63F5tFurRwaNxrlG:22 a=Bn2pgwyD2vrAyMmN8A2t:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Subject: [PATCH v1 2/3] doc: rebase: fixup! can take an object name
Date:	Sun, 14 Aug 2016 22:46:29 +0100
Message-Id: <20160814214630.1312-3-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160814214630.1312-1-philipoakley@iee.org>
References: <20160814214630.1312-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfBEXZBgul3s6TW+7Z+Dwqw3kPs1HuiADwqDv3gckMK8kv/HQ7FyZwn0K3S7Vqo2LLV4H2us1mudvqfhN1Yfa97/jm8h3AXglzGz+8Y0im0ESz7qaNbfc
 Vt3DMfxgO3Sbgzdh4YoLt60n7iXCjmTut7oZw9AfaoGookffu0Ctdnsu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Since 68d5d03 (rebase: teach --autosquash to match on sha1 in addition
to message, 2010-11-04) the commit subject can refer directly to the
destination object hash as a single word.)...

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
v1
This is about the actual commit subject line, rather than the --fixup
options to the commit command.

This came out of https://public-inbox.org/git/FAE9116880074D6FA421942CCAEC368F@PhilipOakley/
where I was expecting to be able to say 'fixup! <sha1> my message', but
I can't (which would be another day's patch - fixup! <rev>! my message').

One question is whether 'standalone' is clear enough, or needs to say
'single word revision'? (which would mean it's not 'object name')

Further, with more digging, I think that any
rev specifier that has no spaces should work [1], despite the 68d5d's
title. Though maybe during the relevant phase of rebase -i some of the
rev specifiers may not work because of the series being rewound - dunno.

[1] https://github.com/git/git/blame/v2.9.2/git-rebase--interactive.sh#L790
---
 Documentation/git-rebase.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0387b40..66b789a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -421,7 +421,8 @@ without an explicit `--interactive`.
 --no-autosquash::
 	When the commit log message begins with "squash! ..." (or
 	"fixup! ..."), and there is a commit whose title begins with
-	the same ..., automatically modify the todo list of rebase -i
+	the same "..." message, or a commit object name (standalone),
+	automatically modify the todo list of rebase -i
 	so that the commit marked for squashing comes right after the
 	commit to be modified, and change the action of the moved
 	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
-- 
2.9.0.windows.1

