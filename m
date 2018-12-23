Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0A21F405
	for <e@80x24.org>; Sun, 23 Dec 2018 19:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbeLWTZU (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 14:25:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51422 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbeLWTZU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 14:25:20 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so13775196ite.1
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djC3s84dGAMQIOq+CQPsrIsn6MDZCrWIRk2hymhHJro=;
        b=ZVdzIOz/D6FK/rf5wHNPwVzvpawUy4Lw8rYwyaARBjJjG0ktLjJ0A0mz7kOchGeoWI
         55dWURUPnZ97I8Oqr9vRiQqpZxtvicLl99ImvvzVnVT8DW/o7TqmQuDISqEOcfB/vWfo
         M0+z5KjWWUeT5XnelzuYb6/tDgfXFrX8JndCJgC0B+lWsmWHqqp/8crtFdjjEiEHqFK4
         ExqTyW0ZDXi4hvl5VKXFEUwiThmLzfGPzTFatd49dNAoDldVNweI3N6oaIfWt7FlmXZC
         /FlHuhflxcpIwV7UyTr3ibmJasufYhiSxiExTfj051VZ7sEEg/wtBYhPEiuh5l3sYE9w
         k5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=djC3s84dGAMQIOq+CQPsrIsn6MDZCrWIRk2hymhHJro=;
        b=f4keJTFrcBLTA3rq7gS79oo0UUSiLT5VglzZpiA4jti9ooICQDUmpjqFNei0CsyMWj
         hXDsJ2ra0qdc4NcwM5Fcl7g/g49GDZyMnke2PGEh4O+O3uA30MuWC65CZoaCWlnB0tPy
         kJCprgLvdF1+28G9JqqF4M5Kd3nndijckazBKM0M7I85EQJMbuCR9SbQxcYTmX06pnu2
         txUR/fWCxvVwPTMNjLl33rTZdBnIr6kH8QvMB28ClGx676ZcmVo8Dty8oosEUUY7B3mA
         TKoYNTdfHuPEjg/qOd3wrioQle1NNkQISVEF/fFDC0kYgJXKQ9O4E4SXjqLyqu/5bcLE
         99eA==
X-Gm-Message-State: AA+aEWbrPCp0xIDALtrvq6wXxvY+gFWb4AYgtKZ0wa5SQzIxEL5J+DGH
        umsydxggA8B4yGdsVK2dgQHyPumR0Ho=
X-Google-Smtp-Source: ALg8bN7R2/1Z7nAejNV3I/Ty3mWDGOq3diB/0psAFS9ete+nyuaExHaCKtlCk2SHzKASf22ZrYdDUA==
X-Received: by 2002:a24:2912:: with SMTP id p18mr7104274itp.16.1545593118586;
        Sun, 23 Dec 2018 11:25:18 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id j10sm100104iop.14.2018.12.23.11.25.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 23 Dec 2018 11:25:17 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=D0=9E=D0=BB=D0=B5=D0=B3=20=D0=A1=D0=B0=D0=BC=D0=BE=D0=B9=D0=BB=D0=BE=D0=B2?= 
        <splarv@ya.ru>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] doc/config: do a better job of introducing 'worktree.guessRemote'
Date:   Sun, 23 Dec 2018 14:24:35 -0500
Message-Id: <20181223192435.24803-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for this option jumps right in with "With `add`",
without explaining that `add` is a sub-command of "git worktree".
Together with rather odd grammatical structure of the remainder of the
sentence, the description can be difficult for newcomers to understand.
Clarify by improving the grammar and mentioning "git worktree add"
explicitly.

Reported-by: Олег Самойлов <splarv@ya.ru>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Reference: https://public-inbox.org/git/0E640233-B2CB-465D-9713-BBECE331CA80@ya.ru/

Documentation/config/worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/worktree.txt b/Documentation/config/worktree.txt
index b853798fc2..048e349482 100644
--- a/Documentation/config/worktree.txt
+++ b/Documentation/config/worktree.txt
@@ -1,6 +1,6 @@
 worktree.guessRemote::
-	With `add`, if no branch argument, and neither of `-b` nor
-	`-B` nor `--detach` are given, the command defaults to
+	If no branch is specified and neither `-b` nor `-B` nor
+	`--detach` is used, then `git worktree add` defaults to
 	creating a new branch from HEAD.  If `worktree.guessRemote` is
 	set to true, `worktree add` tries to find a remote-tracking
 	branch whose name uniquely matches the new branch name.  If
-- 
2.20.1.415.g653613c723

