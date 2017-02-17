Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E6D920136
	for <e@80x24.org>; Fri, 17 Feb 2017 14:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934344AbdBQOU4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 09:20:56 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36510 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934431AbdBQOUu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 09:20:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id a123so2292341pgc.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoAPjvnNI0tXD3RgSfvQv7BjSkQ1Te/l0Ubq57ex+Tc=;
        b=Ky8ITlMaTqxZc575LWjYfQmMN0vtkNWWgTLHFh6aL/jw21FGeuX0GMbi27AYBoXy1q
         njJoN9ZYJOskR8Bo15ohmRDt6Eojk9z1YRT5zfnNQW1SWjkAFMwozCX3VWS3ly2BRyg1
         oXeeJci5pfSXdMh4iiVPR3lGL4GsYRwmKc1c9QItLWLmlnO1HLUIWj8p/pa2bwCOo6Y7
         +fxySpvQYe/2yJWaG8abDnNlmKdx0syvH5pfnJemRXtXZB0HzMWuMOVEDsL/b9RDexoP
         QbmhnmsOJyI0UuTO8pLvGsMfRuT/ZABBFenXkJWwcU1zZFxLm0yQPgiFDXOzdlLn7i9k
         JIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoAPjvnNI0tXD3RgSfvQv7BjSkQ1Te/l0Ubq57ex+Tc=;
        b=BauJofmpXl5jJ65OhKl23s7u2sr6RWLYC2BYZEeoqaBpuDZVYnvybkj8rV6LvBaAgk
         7p2+uGHIOEVIu2W+q8JAouo3i9uZocAp22yJ1dwVOeJcVc/8zeGA1GHJO2EfSGths047
         EWLpgoUvUA2jQZ5MUgpsJGa7vEYPxdOCIiDH5ZjY5p2+CgVq/2yj5oJJpkjFl7L1qUh7
         k4uBPgrOI7xUNtzOewaqyTF6QeFvcSqOcQptke5Pa5HIjwDOWClb0N69SrV8T9OJeW9o
         /aD8hu5Cz6fvJf3t3NbDJu4jnpyAefAAErgy+pNz8flX/B1CjyF+jgEDr67nRej4gRr7
         69GA==
X-Gm-Message-State: AMke39kZRqjiugqG4/Z3QuMbQgVgsnj+8Cq7lUYpmd8EjHTXbZt4jDfpBZ9cbaBmKIMcCQ==
X-Received: by 10.99.127.71 with SMTP id p7mr10499747pgn.125.1487341249764;
        Fri, 17 Feb 2017 06:20:49 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id g64sm20082797pfc.57.2017.02.17.06.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 06:20:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 17 Feb 2017 21:20:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/15] rev-list: expose and document --single-worktree
Date:   Fri, 17 Feb 2017 21:19:08 +0700
Message-Id: <20170217141908.18012-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170217141908.18012-1-pclouds@gmail.com>
References: <20170217141908.18012-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/rev-list-options.txt | 8 ++++++++
 revision.c                         | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5da7cf5a8..dd773f97c 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -179,6 +179,14 @@ explicitly.
 	Pretend as if all objects mentioned by reflogs are listed on the
 	command line as `<commit>`.
 
+--single-worktree::
+	By default, all working trees will be examined by the
+	following options when there are more than one (see
+	linkgit:git-worktree[1]): `--all`, `--reflog` and
+	`--indexed-objects`.
+	This option forces them to examine the current working tree
+	only.
+
 --ignore-missing::
 	Upon seeing an invalid object name in the input, pretend as if
 	the bad input was not given.
diff --git a/revision.c b/revision.c
index ecfd6fea6..2a27e55fe 100644
--- a/revision.c
+++ b/revision.c
@@ -2222,6 +2222,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 			return error("invalid argument to --no-walk");
 	} else if (!strcmp(arg, "--do-walk")) {
 		revs->no_walk = 0;
+	} else if (!strcmp(arg, "--single-worktree")) {
+		revs->single_worktree = 1;
 	} else {
 		return 0;
 	}
-- 
2.11.0.157.gd943d85

