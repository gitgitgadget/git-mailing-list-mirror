Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA58FEB64DC
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 15:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjGTPIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjGTPH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 11:07:59 -0400
Received: from mail.zombino.com (c2.zombino.com [IPv6:2a01:4f9:c010:1e4d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BC7BB
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 08:07:57 -0700 (PDT)
Received: from adams (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id 5F76C3EAD9
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 15:07:55 +0000 (UTC)
Date:   Thu, 20 Jul 2023 17:07:54 +0200
From:   Adam Majer <adamm@zombino.com>
To:     git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <ZLlNtbAbVcYH7eFb@adams>
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'll try again with inline patch. I think it wasn't picked up since it
was mime encoded by the mail client..

- Adam


From 90be51143e741053390810720ba4a639c3b0b74c Mon Sep 17 00:00:00 2001
From: Adam Majer <adamm@zombino.com>
Date: Wed, 28 Jun 2023 14:46:02 +0200
Subject: [PATCH] doc: sha256 is no longer experimental

The purpose of this patch is to remove scary wording that basically
stops people using sha256 repositories not because of interoperability
issues with sha1 repositories, but from fear that their work will
suddenly become incompatible in some future version of git.

We should be clear that currently sha256 repositories will not work with
sha1 repositories but stop the scary words.

Signed-off-by: Adam Majer <adamm@zombino.com>
---
 Documentation/git.txt                      | 4 ++--
 Documentation/object-format-disclaimer.txt | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f0cafa2290..666dbdb55c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -553,8 +553,8 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is
 	ignored when cloning and the setting of the remote repository
-	is always used. The default is "sha1". THIS VARIABLE IS
-	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
+	is always used. The default is "sha1". See `--object-format`
+	in linkgit:git-init[1].
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
index 4cb106f0d1..1e976688be 100644
--- a/Documentation/object-format-disclaimer.txt
+++ b/Documentation/object-format-disclaimer.txt
@@ -1,6 +1,2 @@
-THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
-in an early stage.  A SHA-256 repository will in general not be able to
-share work with "regular" SHA-1 repositories.  It should be assumed
-that, e.g., Git internal file formats in relation to SHA-256
-repositories may change in backwards-incompatible ways.  Only use
-`--object-format=sha256` for testing purposes.
+Note: SHA-256 repositories currently will not be able to share work
+with "regular" SHA-1 repositories.
-- 
2.41.0

