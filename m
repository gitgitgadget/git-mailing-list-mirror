Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6A91F45F
	for <e@80x24.org>; Fri, 10 May 2019 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfEJPdI (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 11:33:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35834 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfEJPdH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 11:33:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so5687328edr.2
        for <git@vger.kernel.org>; Fri, 10 May 2019 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zvCEN/X1Bkyhvze6aus/cT9mduQdjAEjAH4lnyhl8fs=;
        b=htFNQggoYlpmBDEFmbvEjb93otDgJwE4GTmOC81qFAChp5INby5O/JoP4ta9lKsAoG
         iPrBYUNzMoCR0FiM0ESPK9/gol9oHt9WeX/7YU+IgTjso57aysfy6Mdq/exrx+jJ8WKC
         llzf5IBDOC5mvwTOaDLJ9GRBoJd1X0XaE4jyKt9ymBoP3ixv6oDoEn45q5L+Mx8BuXf8
         YslS6Eri/cQBsw+CB6LLQkG0X2HKbYgq6bk82weJZ+UdCAegu2dxXcmrnmypKagnz3/m
         PgmFJEp817awSug83hV2l/hXW0WnNPxNJ1quh76x/JqSd+78g+AnME5ag7cj7x+vINwp
         S9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zvCEN/X1Bkyhvze6aus/cT9mduQdjAEjAH4lnyhl8fs=;
        b=jMivQgcfX68LfyGF1vEwUHJ5iAtFsiNbLbH/LwL4kaRpPx6Gg3TQHpZtJMBRLy2Gvb
         g3ys8y+K7jEd1ZMz4Z8ALviCddAEkPjuXVGvr6Oy0cEJm7C+jSaAaAUiH6tlNb9soTbz
         ulDVrjzQe2IPcCpMd7B4FG/iwwnPbWx/whWZL44yhOsos16nPJlaFalOToOsBjVeELfe
         c5EO30CVsmyWDx+02NH5uHo6qclGIS40bMssfgiMABItFd+t4Fvyd3Oj3RgT57awneb5
         IYi+Pg7fH8uqyaey+AUCZoPIg/RIjKSKh6VKWZWcRkPrPrPuFi0edo+gOGVMytXvGaSi
         lpNQ==
X-Gm-Message-State: APjAAAXPTq2kJssIWn1/RvUHs4wwXJej/TdG2ja9P5Vt2uz7VTpu3aNZ
        WRuXkxU3Jy+PT0nPxhp8uDzL5sFY
X-Google-Smtp-Source: APXvYqzMUc0MfwTxnuvOYg99ce7BPrkMBHG9xFeEcWOUwDyFNgQRFSmKlmJ4OG2y1vudloiHcV2pCw==
X-Received: by 2002:a50:913d:: with SMTP id e58mr11915191eda.107.1557502385839;
        Fri, 10 May 2019 08:33:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm793679ejx.81.2019.05.10.08.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 08:33:05 -0700 (PDT)
Date:   Fri, 10 May 2019 08:33:05 -0700 (PDT)
X-Google-Original-Date: Fri, 10 May 2019 15:33:03 GMT
Message-Id: <fc580e902bedb92b5caea8047c1ddd1c9fc822f6.1557502383.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.183.git.gitgitgadget@gmail.com>
References: <pull.183.git.gitgitgadget@gmail.com>
From:   "Mike Mueller via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] p4 unshelve: fix "Not a valid object name HEAD0"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Mike Mueller <mike.mueller@moodys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mike Mueller <mike.mueller@moodys.com>

git p4 unshelve was failing with these errors on Windows:

fatal: Not a valid object name HEAD0
Command failed: git cat-file commit HEAD^0

(git version 2.21.0.windows.1, python 2.7.16)

The pOpen call used by git-p4 to invoke the git command can take either a
string or an array as a first argument.  The array form is preferred
however the extractLogMessageFromGitCommit method was using the string
form, which makes the caller responsible for escaping the command text
appropriately (see https://docs.python.org/2/library/subprocess.html)

Somewhat ironically, the carat character is the escape character in
Windows and so should be escaped (HEAD^^0).  Without the extra carat, the
OS was passing an escaped 0 to the git command instead, and the git
command was rejecting the invalid object name "HEAD0"

The behaviour can be confirmed by typing ECHO HEAD^0 at the command-
prompt, which emits HEAD0.

The solution is simply to use the array format of passing the command to
fOpen, which is preferred and used in other parts of this code anyway.

Signed-off-by: Mike Mueller <mike.mueller@moodys.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 5b79920f46..0b5bfcbc5e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -737,7 +737,7 @@ def extractLogMessageFromGitCommit(commit):
 
     ## fixme: title is first line of commit, not 1st paragraph.
     foundTitle = False
-    for log in read_pipe_lines("git cat-file commit %s" % commit):
+    for log in read_pipe_lines(["git", "cat-file", "commit", commit]):
        if not foundTitle:
            if len(log) == 1:
                foundTitle = True
-- 
gitgitgadget
