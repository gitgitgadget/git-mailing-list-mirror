Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B71C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B8220731
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588444934;
	bh=Ekp2eAVfYactbje9AS2EkS6vKh0kRAaQ4EJcyMqcLkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9mjqAq9s+087KXx/fP4r9mQjHqDHOn8qn8553/1IGDp9uUwwc7/YIfkQFU5ACgxo
	 IFLe+d4pvGrCAljn84vN2AM2OSXpOGzrhR/O+5sBYLd9WqEIodliI1maqjVDWBBbCH
	 pMDXEbNRIiBjJcurt+a/bhiLx35Ov12KimUlC+HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgEBSmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 14:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgEBSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 14:42:11 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C45F20731;
        Sat,  2 May 2020 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588444931;
        bh=Ekp2eAVfYactbje9AS2EkS6vKh0kRAaQ4EJcyMqcLkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufDoEWlEyqe+rtQXHXzUypcALI5jacnSTn4B8fqvBkj1cGIIc884CTL3BfyE5B3Q8
         l/e4SQ7enunhLrc13NFj6IMnLes5Ey+Y5RWOpjQNtwzBZ/hRVQdSY+QHIzk2boTT1N
         yICqvwp9HlB3JJwBKBe/sgwYD5edLMaTZ7BNHD1Y=
From:   Wolfram Sang <wsa@kernel.org>
To:     git@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>
Subject: [PATCH tig 2/2] Drop unneeded '!' in docs
Date:   Sat,  2 May 2020 20:41:52 +0200
Message-Id: <20200502184152.26550-2-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502184152.26550-1-wsa@kernel.org>
References: <20200502184152.26550-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 99d8d00 ("User-defined commands no longer need to be
prefixed with '!'"), we don't need it anymore. Also, remove a
superfluous comment.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 doc/manual.adoc  | 2 +-
 doc/tigrc.5.adoc | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/doc/manual.adoc b/doc/manual.adoc
index cf87ba1..0d772ea 100644
--- a/doc/manual.adoc
+++ b/doc/manual.adoc
@@ -208,7 +208,7 @@ Example user-defined commands:
 
  - Copy commit ID to clipboard:
 
-	bind generic 9 !@sh -c "echo -n %(commit) | xclip -selection c"
+	bind generic 9 @sh -c "echo -n %(commit) | xclip -selection c"
 
  - Add/edit notes for the current commit used during a review:
 
diff --git a/doc/tigrc.5.adoc b/doc/tigrc.5.adoc
index 1aa8085..6b40afe 100644
--- a/doc/tigrc.5.adoc
+++ b/doc/tigrc.5.adoc
@@ -780,8 +780,7 @@ file:
 	gitk-bg = !"gitk HEAD --not $(git rev-parse --remotes) &"
 	publish = !"for i in origin public; do git push $i; done"
 [tig "bind"]
-	# @-prefix means that the console output will not be shown.
-	generic = V !@git gitk-bg
+	generic = V @git gitk-bg
 	generic = > !git publish
 --------------------------------------------------------------------------
 
-- 
2.20.1

