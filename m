Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9457B1F461
	for <e@80x24.org>; Mon, 13 May 2019 00:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfEMAYl (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 20:24:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60673 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727047AbfEMAYl (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 May 2019 20:24:41 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ACC262202A;
        Sun, 12 May 2019 20:24:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 12 May 2019 20:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=mesmtp; bh=kqNP/iXc8evbPVSybjm70cx
        hOnBEI+RP59HAgypmqH8=; b=FtlT3B/kdJmzytRhLT0YmryGSTYsgXmuyhSlk9l
        4DXOd7VJ+JNu8SMWCcbOkAWC42ohgiMQXVIPzb7AqZ4t+Sgc9kWze0JPnLLHuyip
        ZeWTd9d01Iyfz4o7ANz5U2ngi2+QtahKEn0v9GXSF5k+TEIvbdf9d15xTm6jWnyx
        bKlU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kqNP/iXc8evbPVSyb
        jm70cxhOnBEI+RP59HAgypmqH8=; b=E9QseybXZ7dAd2LpOvxHTkQWYQRW4InXv
        JdCys6tNmtVxPz7yifo6NRh+SlPalvj63REroUsngdcsZ9YLIpgjEV9oUqCQavgF
        F5FKZRc38jHPSrOMOxwaQFrsvtthBeStL0efCSdqTIHwGLPWntQRValcsx+5USJN
        DuBay9WplgMyRJGI6+epXByRgyuNCcFJh/gMs/ctYVKOr5j3CQtsoQAyw8j/+P/p
        3zTtM8Gsuf4ZPOjm5Z6qtwc28Tn1FmJ48xQ4QUp0RgKxaO7f1AkDR1iWq+vASL3g
        F+bJWplVdbm4C/VOlhrGigfzZ4vtU1jMQYX9v9LWdNu3KN6TNDlLA==
X-ME-Sender: <xms:RrnYXJqn_-GdbLOmGcdrGROyLhMODcwp1pA6u98inlhlBrxNRD13Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucfkphepkedurddukeejrddvvdegrddufedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hhihesrghlhihsshgrrdhishenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:RrnYXHq2HtmXPz7NLpV6ZwpFeT07DZqK__wqt5BQvyJ-G-40xHytug>
    <xmx:RrnYXIaeQJHP-1lFo3_iCgIKdk6gZFG-tKXe8DuGriZRavuuYHZd9Q>
    <xmx:RrnYXF_DK3HUXUVmJOG5JdjPBAM7z7sSCGRmexzZoA8hNMw0IpkE2g>
    <xmx:R7nYXNLKf9lcUTEkGTiOVSakNybFE9CR4SLHWAjTdU-NsJj5NK3THw>
Received: from localhost (130.224.187.81.in-addr.arpa [81.187.224.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 539788005C;
        Sun, 12 May 2019 20:24:38 -0400 (EDT)
From:   Alyssa Ross <hi@alyssa.is>
To:     git@vger.kernel.org
Cc:     Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] doc: explain why file: URLs and bundles don't mix
Date:   Mon, 13 May 2019 00:23:55 +0000
Message-Id: <20190513002355.25031-1-hi@alyssa.is>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 Documentation/urls.txt | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index b05da95788..c83d9f859e 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -43,14 +43,24 @@ syntaxes may be used:
 - \file:///path/to/repo.git/
 
 ifndef::git-clone[]
-These two syntaxes are mostly equivalent, except when cloning, when
-the former implies --local option. See linkgit:git-clone[1] for
-details.
+These two syntaxes are mostly equivalent, with some exceptions:
+
+- When cloning, the former implies --local option. See
+  linkgit:git-clone[1] for details.
+
+- The latter is implemented using linkgit:git-upload-pack[1], which
+  expects its repository to be a directory, and therefore does not
+  work for bundles (see linkgit:git-bundle[1]).
 endif::git-clone[]
 
 ifdef::git-clone[]
-These two syntaxes are mostly equivalent, except the former implies
---local option.
+These two syntaxes are mostly equivalent, with some exceptions:
+
+- The former implies --local option.
+
+- The latter is implemented using linkgit:git-upload-pack[1], which
+  expects its repository to be a directory, and therefore does not
+  work for bundles (see linkgit:git-bundle[1]).
 endif::git-clone[]
 
 When Git doesn't know how to handle a certain transport protocol, it
-- 
2.21.0

