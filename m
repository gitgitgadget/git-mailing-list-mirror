Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DE71F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 12:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbcHXM51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 08:57:27 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38787 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752958AbcHXM50 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Aug 2016 08:57:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 473322051D;
        Wed, 24 Aug 2016 08:56:54 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 24 Aug 2016 08:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp;
         bh=uEsSitFRWiD6WeYM8MMPweWm2jo=; b=mMOEQa/PfyCG00y8e1Qj0tN/7egr
        MEzVfPK54lVP1FfLCTzdVKzp8XMm+aaI4qS7z1CsTPKzMlyYmlcm9nLfHgTT2zUa
        HkR7kwoBMP6EwCF/fjofCa/7dMOAy91Qri75+s/cElHKjhPVOE0212W00TbmVaXa
        kF4kPsLwOkGJruo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-sasl-enc:x-sasl-enc; s=smtpout; bh=uEsSitFRWiD6WeYM8MMPweWm2j
        o=; b=UL4G2N8tgk2CVwZWqQU3veBNtBUgzlc9Pe+ABLijVJU1gBWu7agpouIf+9
        ZO6GCPdMof44HPa193xEWJREuht4JN3Wivy1eC8CnUjqP54zIdwwSZ43Rly/HhkR
        U24ax3K058qEd4blCl1mHYhpyaqW72FVtc5E5dkjIgNFD8OzY=
X-Sasl-enc: 6ujBJV9rhT6+LGA40TtU3gc7srW2HdIrf/9HNO4xIwgr 1472043413
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id D79BDF29D0;
        Wed, 24 Aug 2016 08:56:53 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation/git-patch-id: give working code example
Date:   Wed, 24 Aug 2016 14:56:52 +0200
Message-Id: <5d33c4682e6251fc724b35c6f1c2f2a477a41b0a.1472043384.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.0.rc0.268.ge3ba28a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As it stands, the documentation gives the impression that

git diff-tree <treeish> | git patch-id

would be a working invocation of git patch-id, leaving the novice user
in the dark.

Make it explicit that 'git diff-tree -p' would be the command to use.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-patch-id.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index cf71fba..67f8e28 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -21,7 +21,7 @@ have the same "patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
-When dealing with 'git diff-tree' output, it takes advantage of
+When dealing with 'git diff-tree -p' output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
 commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
-- 
2.10.0.rc0.268.ge3ba28a

