Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF2C001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 13:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGaNmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 09:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGaNmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 09:42:06 -0400
Received: from mail.zombino.com (c2.zombino.com [IPv6:2a01:4f9:c010:1e4d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35D1170B
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 06:42:05 -0700 (PDT)
Received: from adams (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id 349893E98A;
        Mon, 31 Jul 2023 13:42:04 +0000 (UTC)
Date:   Mon, 31 Jul 2023 15:42:02 +0200
From:   Adam Majer <adamm@zombino.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] doc: sha256 is no longer experimental
Message-ID: <ZMe6KmzZGVubYpvO@adams>
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <ZLlNtbAbVcYH7eFb@adams>
 <xmqqr0p230rj.fsf@gitster.g>
 <d8ba032f-51bc-0bab-fd24-25dea0d56966@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ba032f-51bc-0bab-fd24-25dea0d56966@zombino.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove scary wording that basically stops people using sha256
repositories not because of interoperability issues with sha1
repositories, but from fear that their work will suddenly become
incompatible in some future version of git.

We should be clear that currently sha256 repositories will not work with
sha1 repositories but stop the scary words.

Signed-off-by: Adam Majer <adamm@zombino.com>
---
 Documentation/git.txt                      |  4 ++--
 Documentation/object-format-disclaimer.txt | 15 +++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index f0cafa2290..11228956cd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -553,8 +553,8 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is
 	ignored when cloning and the setting of the remote repository
-	is always used. The default is "sha1". THIS VARIABLE IS
-	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
+	is always used. The default is "sha1".
+	See `--object-format` in linkgit:git-init[1].
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
index 4cb106f0d1..359f393ec9 100644
--- a/Documentation/object-format-disclaimer.txt
+++ b/Documentation/object-format-disclaimer.txt
@@ -1,6 +1,9 @@
-THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
-in an early stage.  A SHA-256 repository will in general not be able to
-share work with "regular" SHA-1 repositories.  It should be assumed
-that, e.g., Git internal file formats in relation to SHA-256
-repositories may change in backwards-incompatible ways.  Only use
-`--object-format=sha256` for testing purposes.
+Note: At present, there is no interoperability between SHA-256
+repositories and SHA-1 repositories.
+
+Historically, we warned that SHA-256 repositories may later need
+backward incompatible changes when we introduce such interoperability
+features. Today, we only expect compatible changes. Furthermore, if such
+changes prove to be necessary, it can expected that SHA-256 repositories
+created with today's Git will be usable by future versions of Git
+without data loss.
-- 
2.41.0

