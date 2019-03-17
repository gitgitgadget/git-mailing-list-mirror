Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0F620248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfCQMto (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:49:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36447 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMto (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:49:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id r124so9517104pgr.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tOVVS8Z4adb5nGyio/rZP5BiTWZiQYGAfXZvL0LLUI=;
        b=BdpztBiwC+v3pPBIO26EKDIpF6dhuqIuNaaDnU8ZKV5Phx2rSWjg9WezL0Y4Wqoq6P
         uaDvPSwWEB8u69+QsqnfFDM8Ecfnig8Fju4l7XLqTUvYRPQbLo0Ct524XowfwTpZuAX7
         6ZEgNlGZOYS/YXqcQqDC5nhQoZuaM5UfTxkYHz3SOu0KcgGwanXHUgf6SJd7VXhR01rA
         lMYIK6NpgDTOGqAfSFZT+giYbL3YytqYcAh/q4NJktdwArbS+7JAPhv0y3CdY0nC9TVj
         RHFWauubHeoOgD4isHZdGO1qYGi7+QkKEyLZcIO0enuqtm09qhtQ+HxDfYbC8uxGMPdN
         L+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tOVVS8Z4adb5nGyio/rZP5BiTWZiQYGAfXZvL0LLUI=;
        b=Adr6DM7YDUmxq6wL/x0+KjPFQE88H9+jSoIdjlTo5q3ACIaL5k8WEyilq6V3RrBXoM
         FRTsNEOVliCD+W9n8C5xanbMVJCfFypsBPnxmWA2KVeRgaWszVROgQ83WaSdoKqBn+gy
         fdHBdLEGKMpthXzwYIqd7kIdTE7eA19+DiuLMcl0NDEzJ0jVIhllyrIdUDFMKJRRkk71
         QyOJZXCegUQz8nVOVtcAhEl3mWCx8PYr/hAcEcwBmmmiLZgmN0dkfaECivOKfZKhOQD2
         Y5RAg10YfAATAANTxNbw7A26QV4rBzmTgjdX8YxZhbgI3mrD9VZ/oVhI1g1XNi2F8GvX
         Rk6g==
X-Gm-Message-State: APjAAAWckt6z3juXN8Zh/moECc7MQmy1cE9FlpNpM3+nXJxTVlGN4U9B
        H0K5zJQ3anLjiz1Yu9ZatuM=
X-Google-Smtp-Source: APXvYqxGeKV8nI9TByhnml4UX68zQmsshbxWdz3Zx0iH6CZgOPGIr6BP2Miic3wRAIE06rRm6SlMnA==
X-Received: by 2002:a65:6383:: with SMTP id h3mr12660368pgv.11.1552826983698;
        Sun, 17 Mar 2019 05:49:43 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g12sm28073492pfd.72.2019.03.17.05.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:49:42 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:49:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 01/26] git-checkout.txt: spell out --no-option
Date:   Sun, 17 Mar 2019 19:49:01 +0700
Message-Id: <20190317124926.17137-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easier to search for and also less cryptic.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f179b43732..99c8c0dc0f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -118,7 +118,8 @@ OPTIONS
 --quiet::
 	Quiet, suppress feedback messages.
 
---[no-]progress::
+--progress::
+--no-progress::
 	Progress status is reported on the standard error stream
 	by default when it is attached to a terminal, unless `--quiet`
 	is specified. This flag enables progress reporting even if not
@@ -262,7 +263,7 @@ edits from your current working tree. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 Note that this option uses the no overlay mode by default (see also
-`--[no-]overlay`), and currently doesn't support overlay mode.
+`--overlay`), and currently doesn't support overlay mode.
 
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted ref is already checked
@@ -270,7 +271,8 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
---[no-]recurse-submodules::
+--recurse-submodules::
+--no-recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
@@ -283,7 +285,8 @@ Note that this option uses the no overlay mode by default (see also
 	Do not attempt to create a branch if a remote tracking branch
 	of the same name exists.
 
---[no-]overlay::
+--overlay::
+--no-overlay::
 	In the default overlay mode, `git checkout` never
 	removes files from the index or the working tree.  When
 	specifying `--no-overlay`, files that appear in the index and
-- 
2.21.0.548.gd3c7d92dc2

