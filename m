Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B66C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E9206CD
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588445315;
	bh=2CQ+lkWnEClwpp67x4LUq6HF6UKnefOVN5MmxOkHww4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q1SixzfilSYPTKCXYAQkK7XKBWnb3pBGmba3726/chG7pq4kR/FrKGI8XpWh7P2Sn
	 Dml6h4SYM2Uf/MbIujakhaFsFSygEsWitvihwaBjKApAub0HzTyQXw4DDuCGA6tFRT
	 GQ2S6fxtput0+mjenaHHdeLzE9cD9GV7u725l0+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEBSse (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 14:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgEBSsd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 14:48:33 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBDBE20757;
        Sat,  2 May 2020 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588445313;
        bh=2CQ+lkWnEClwpp67x4LUq6HF6UKnefOVN5MmxOkHww4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7VLoxtqQNYaH5YlH9RGEbD+VUxSNJ8G7Ox7lQgZca/NX0tftAYsthXpFY6uTumnY
         NT9VzHKWzv6lGOMooqR/VxKKp0ef2Qwrf5DRIzKmlAFVpvTmawyIWYjGGlQJgr56u2
         uajfPZJve8ZpZgAouvpRA8VXC3bm6em+jfiPDo9M=
From:   Wolfram Sang <wsa@kernel.org>
To:     git@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [PATCH RESEND tig 2/2] Drop unneeded '!' in docs
Date:   Sat,  2 May 2020 20:48:25 +0200
Message-Id: <20200502184825.26707-2-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502184825.26707-1-wsa@kernel.org>
References: <20200502184825.26707-1-wsa@kernel.org>
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

This time with proper CCs. Sorry for the noise!

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

