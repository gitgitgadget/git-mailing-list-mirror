Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8902D20248
	for <e@80x24.org>; Tue, 26 Mar 2019 12:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfCZMKL (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 08:10:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33600 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCZMKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 08:10:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so8188281pgk.0
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqFJ6Thq69FbrG0EoDN83AmFFg8yogUqcg3/D/b+yqE=;
        b=XivZuPA6qrLWUMZgT9zZl8PQhOkbwtJKgcvgzK3GSTsn7DQX+2JeMSteaUhaaunuVH
         Kd5aN1+nuTsCj+FzuBqsP9MsmGAyXDtajzJ9Fel9bOTrmNwzZY+RZTM0dkxGbQloKRGU
         PA7y+QJpp8WOfCR9efaeP5afDmdpJ2gm0ooYPBytHC1HoKwqC01eU4u6ZbaXPcE9PJbM
         yIwYyGaOWg+l+2FmMGGRqYgYdNynu0hkTf8u5h72epjLRUYdUM67VM7FYKVvXKD+3TUQ
         v2r5KMB7tzUvnHQD/TTc2KWgP1TwDUXVd/yLwODj7IcQ8NaJex/7X5KkmFUVDiUeDB6w
         +tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UqFJ6Thq69FbrG0EoDN83AmFFg8yogUqcg3/D/b+yqE=;
        b=P06P5/AToDXkq/CcNgOwSnRwl/LWtBzbgnnxdtJvAMrJeukU6AqKbcB1ri5FviF426
         pFg1wBLCb84TbvinatfTiByV/OoOX5iVzU25Kxj4dE5BYGAjLF/TI5X3M1FXMuywORgC
         6OYfnj9zi8BNIPcj7Z99+Mkz+4cdQcXcVO2lpGuWnfLAuV8/ujc8gY677Z/O9Tipk0Hn
         3aT4ZXPqHm6aHF14CQAIsav19YpefVSnge+JOV+SLj25YInYS0oXTrVvZ+AKI7HKHpnM
         VkN3MOp6qjGfU5SwtWMROWEk3zkUOvJoC2ngaKXIaKnWWOFVe6cq3hy7nQwzqTBCkQTl
         gVZg==
X-Gm-Message-State: APjAAAUXkduN9y0Sz58yVLDu6MjO0EOU/iWsgwJwDj5MtUVzRxtg8VAr
        5qF30oGI9vBGCwRjHK8PEySpAhY5
X-Google-Smtp-Source: APXvYqxg8u3yVYz/bd8YgDbhmd5PUIyFGZ1a3Oq0eiCIQz5dFf+64fBZ7H4ywBhVWviw5NdKTtPgAA==
X-Received: by 2002:a62:1e82:: with SMTP id e124mr29418252pfe.258.1553602210135;
        Tue, 26 Mar 2019 05:10:10 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id t190sm31293604pfb.33.2019.03.26.05.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:10:08 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Mar 2019 19:10:03 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] read-tree.txt: clarify --reset and worktree changes
Date:   Tue, 26 Mar 2019 19:09:39 +0700
Message-Id: <20190326120939.31657-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of --reset stays true to the first implementation in
438195cced (git-read-tree: add "--reset" flag, 2005-06-09). That is,
--reset discards unmerged entries. Or at least true to the commit
message because I can't be sure about read-tree's behavior regarding
local changes.

But in fcc387db9b (read-tree -m -u: do not overwrite or remove untracked
working tree files., 2006-05-17), it is clear that "-m -u" tries to keep
local changes, while --reset is singled out and will keep overwriting
worktree files. It's not stated in the commit message, but it's obvious
from the patch.

I went this far back not because I had a lot of free time, but because I
did not trust my reading of unpack-trees.c code. So far I think the
related changes in history agree with my understanding of the current
code, that "--reset" loses local changes.

This behavior is not mentioned in git-read-tree.txt, even though
old-timers probably can just guess it based on the "reset" name. Update
git-read-tree.txt about this.

Side note. There's another change regarding --reset that is not
obviously about local changes, b018ff6085 (unpack-trees: fix "read-tree
-u --reset A B" with conflicted index, 2012-12-29). But I'm pretty sure
this is about the first function of --reset, to discard unmerged entries
correctly.

PS. The patch changes one more line than necessary because the first
line uses spaces instead of tab.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-read-tree.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5c70bc2878..12a25bc954 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -38,8 +38,9 @@ OPTIONS
 	started.
 
 --reset::
-        Same as -m, except that unmerged entries are discarded
-        instead of failing.
+	Same as -m, except that unmerged entries are discarded
+	instead of failing. If `-u` is used, updates leading to loss
+	of local changes will not abort the operation.
 
 -u::
 	After a successful merge, update the files in the work
-- 
2.21.0.479.g47ac719cd3

