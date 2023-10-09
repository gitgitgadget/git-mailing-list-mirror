Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9711EE95A97
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 23:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379049AbjJIXfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 19:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJIXfO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 19:35:14 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425BA7
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 16:35:12 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S4Fkh74g6z9sSS;
        Tue, 10 Oct 2023 01:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1696894509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD9ROmTwt/AoEiVVzoWDQP138HBIDuStSHGs1J8J0pk=;
        b=0z4fXnLysPSrTGG5juW7fV+0d9QlMh03oJMoLlGo8gm+Z/0A4LSe1ViEkxexW7eAunlKgI
        r+DcJd8JLAQSEPdg9nOuD+qOUYuw1NgxWrh5ZfxS7LYs34eY0gevzZpEbGm0372v2l5CTB
        situRUhICbGhKb7tbuqOLN+1WBoA7dk7iHaIApl/APJ9r7rwUqk/64QXZRb195prMfiyUZ
        Ip+fpfMeMOCUFIshXx/YepoIi9T5h9kaFvgJoxKpHgkLzVQ6nNUFqXs+tjmSDE0YwDfxwm
        BD/FKHln6xYuk4SejFrEWjMYQ2ebQhhSJijXJw8HTUmrgGMZZLVLGAmkfnd33Q==
From:   Hugo Sales <hugo@hsal.es>
To:     git@vger.kernel.org
Cc:     Hugo Sales <hugo@hsal.es>
Subject: [PATCH 3/3] mv: Add documentation for new `-p' flag
Date:   Tue, 10 Oct 2023 00:34:58 +0100
Message-ID: <20231009233458.1371351-4-hugo@hsal.es>
In-Reply-To: <20231009233458.1371351-1-hugo@hsal.es>
References: <20231009233458.1371351-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S4Fkh74g6z9sSS
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 Documentation/git-mv.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index fb0220fd18..70c1e9572c 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -15,13 +15,14 @@ DESCRIPTION
 -----------
 Move or rename a file, directory or symlink.
 
- git mv [-v] [-f] [-n] [-k] <source> <destination>
- git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
+ git mv [-v] [-f] [-n] [-k] [-p] <source> <destination>
+ git mv [-v] [-f] [-n] [-k] [-p] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
-In the second form, the last argument has to be an existing
-directory; the given sources will be moved into this directory.
+In the second form, the last argument refers to a directory, which has
+to exist unless -p is specified, in which case it gets created; the
+given sources will be moved into this directory.
 
 The index is updated after successful completion, but the change must still be
 committed.
@@ -39,6 +40,9 @@ OPTIONS
 -n::
 --dry-run::
 	Do nothing; only show what would happen
+-p::
+--parents::
+	Create missing parent directories in the <destination> or <destination directory> path. Similar to `mkdir -p', all missing leading directories are created.
 
 -v::
 --verbose::
-- 
2.42.0

