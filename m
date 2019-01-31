Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3D01F453
	for <e@80x24.org>; Thu, 31 Jan 2019 09:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAaJVV (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 04:21:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34094 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfAaJVV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 04:21:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id j10so1121484pga.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 01:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFh96ICZsc2z5DO6OORRFkqVxsM0SW7BRBnUtRmeH4s=;
        b=aWO164vgdQVH526ECCDACvM2QI3s20tHDsfDJlDLuHcvjfAozej48Qi6YDlam3tIOg
         p00CtvDprgLeDN/wHuLWrpPfZTLAqvA6XTN004xfjmTPcVln7jAj6bZIwFWZgc0YTgLE
         DptWnxlihYciI+Sd80CFeEO/3NsBmHXNYx0RgITJQMlDwS0q5bwUDPBJQczm1Qw69fza
         FgmXSWl/259114mBo/Sr8MvsBWZ2aFnwrBXWsmfXqvqj6dJHAY5V6Urguy5R0JXMAPKv
         leSPy/HdewQ7CqE6it4CPmMq/fQLcmnyp0RSf45PGr95O98FwLGrrT4LoHbxHRkRxzHp
         NOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFh96ICZsc2z5DO6OORRFkqVxsM0SW7BRBnUtRmeH4s=;
        b=I2jYhAMt/OyMUEyqvbtnwscfhBGgGIuwObJQiC35M1xBmJNLlYiCMS/dCHAvazwDc1
         qHwPfrPKOEgAWM25qROSN0kdd8mK1gGscaD50Tr9Fr7b/1eVJI6DJPVmfbG/G33g0sOk
         PmSLLYoNoOchGGXnma11UNp/lET+eYpnEwMo+ybuRCJqeUzYqIO0TdhAj8Zqa05+0td1
         BsuZ0+qN7BhULoyTmicvyErzJ83W2UOwYEs/4Snea93c+1UAOjRxGvhnByc2Ejs9m1CF
         GdA309YksFHZ5qXdtNJA4iOrOaD5Bd6CHUh041gq1zpy5nWsC3xvxfdcW1Zwj+pQvUTy
         nScQ==
X-Gm-Message-State: AJcUukeU9GyGvUDzSWLMS2Sef1Hz3fOBDAfggQFLaGAsmcGx5+VUjkdA
        ygKk12hbL+200/MMOhpdMReHvPJR
X-Google-Smtp-Source: ALg8bN7RzyWVqsVuWiXT4gYXgUttBtLTs0rZ1tPY9NHi7HJyFN9vQPG0yCH38ziZpKbIH0f6pLv6Fg==
X-Received: by 2002:a63:3703:: with SMTP id e3mr30308066pga.348.1548926480321;
        Thu, 31 Jan 2019 01:21:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 125sm5279326pfg.39.2019.01.31.01.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:21:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 31 Jan 2019 16:21:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] git-commit.txt: better description what it does
Date:   Thu, 31 Jan 2019 16:21:12 +0700
Message-Id: <20190131092112.6197-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
References: <CACsJy8C2fx-+NxS+ahmmHDgLrwtyiCV6WEEfpmYwfcPM3kYVvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of git-commit jumps right into the commit content, which
is important, but it fails to mention how the commit is "added" to the
repository. Update the first paragraph saying a bit more about branch
update to fill this gap.

While at there, add a couple linkgit references when the command is
first mentioned.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 On Thu, Jan 31, 2019 at 02:43:41PM +0700, Duy Nguyen wrote:
 > I notice git-commit.txt does not say anything about branch update
 > business though. Maybe some more updates there...

 Maybe something like this. Although I feel I'm quite close to some
 rabbit hole.

Documentation/git-commit.txt | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..8148ba10b3 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -17,16 +17,19 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Stores the current contents of the index in a new commit along
-with a log message from the user describing the changes.
+Creates a new commit containing the current contents of the index with
+a log message from the user describing the changes. The commit is the
+direct child of the tip of the current branch. The branch is updated
+to point to the new commit (unless no branch is associated with the
+working tree, see "NOTES" section).
 
-The content to be added can be specified in several ways:
+The content to be committed can be specified in several ways:
 
-1. by using 'git add' to incrementally "add" changes to the
-   index before using the 'commit' command (Note: even modified
-   files must be "added");
+1. by using linkgit:git-add[1] to incrementally "add" changes to the
+   index before using the 'commit' command (Note: even modified files
+   must be "added");
 
-2. by using 'git rm' to remove files from the working tree
+2. by using linkgit:git-rm[1] to remove files from the working tree
    and the index, again before using the 'commit' command;
 
 3. by listing files as arguments to the 'commit' command
@@ -349,6 +352,18 @@ changes to tracked files.
 :git-commit: 1
 include::date-formats.txt[]
 
+NOTES
+-----
+If a branch is associated with the working tree, 'HEAD' points to this
+branch. When a new commit is created, the branch is updated to point
+to the new commit. As a result, resolving 'HEAD' still gives the new
+commit.
+
+If no branch is associated with the working tree (i.e. "detached HEAD"
+as described in linkgit:git-checkout[1]), 'HEAD' records the object
+name of the previous commit directly. When a new commit is created, it
+will be updated to point to the new commit.
+
 EXAMPLES
 --------
 When recording your own work, the contents of modified files in
-- 
2.20.1.682.gd5861c6d90

