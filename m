Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14DB1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeJWFG1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 01:06:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36702 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbeJWFG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 01:06:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so46434890wrw.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1hxw2dE1Psk7NtochpJlWsHaCZ/1tphENb1kx7LCZw=;
        b=CzxhSEL6jJAdZUKEpBnmSU7nunJHzFHTE5ftA3VJUn8u9wC7/cZdUC2++6V8wfJU0A
         2LDtAJntRIlw5O55/eST11z0MmBn75jZfENdZHdU8xEDwxSJwjKIw1t6C/aLu8rKSTPp
         Gg+lQ8pwqyAAULIAi5ELf+tqFAnlhV+qtvW7D6aGx/0SRv/anc2Bm4csUCBaO7XeMvzJ
         tkXgoTRz/iip29nOibt5my/rcl2IcWvBdy5pjKcamsT8ixQw6Ys5XhapqMKLzUY8eTIr
         BVHhscwO7MTsBMkjMzriUX4jSinTcaZBFqTg04qkFYYDkwHKMY5SmQwRAhL5SngJY7Nk
         UKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1hxw2dE1Psk7NtochpJlWsHaCZ/1tphENb1kx7LCZw=;
        b=unXqOzVOGkV1MRA/QmWF+DsWQjZwFAOZlv+US5YqrDbbeK+vELNEGllyfD2eCrsGwR
         PfFgKZ/GT1ihcMbf1YvbZE1AUfAmH86MTE+wvugG5+j1eFqS6eg8aP0YhkLH3/Tid453
         kn5LxxlKt3oJnLpDYejMrOl9fogqLARwv0FtI+bmTJdQjQ4QqQSTMfnY0szJfrYalzot
         csyLxGk3xOHbkTfbUfIp23tg1rJT/bNCuY6YpJUAOFDEgj4hFgAN61UNAbMU/LTFW/Rt
         QuNmbuwFLUzOqAmu3hCE6JXhhLwYv1zPqV0MYn5/CBaGvzaqmJeCXGoZ0zjVxot0FHxK
         f+EA==
X-Gm-Message-State: AGRZ1gJIg/XtV0m3Y5YVgheT9V5xYhMIE9T2LK0gBoRpbo2yzv6kln0+
        mWPBatlG1xlcv4nZ5WkgpkJwc8+Y
X-Google-Smtp-Source: AJdET5fNATdO3x9I5XVO4/kj6hWSNRsFic+kvEqEvxNNARSUvP30vfZjwOZ1NIfDcIIthOpsYk2Y1g==
X-Received: by 2002:a5d:45c6:: with SMTP id b6-v6mr8278006wrs.296.1540241180611;
        Mon, 22 Oct 2018 13:46:20 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:4936:e72c:acbd:e1bd])
        by smtp.gmail.com with ESMTPSA id r134-v6sm9526526wmg.9.2018.10.22.13.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 13:46:20 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH 1/6] doc: clarify boundaries of 'git worktree list --porcelain'
Date:   Mon, 22 Oct 2018 22:45:41 +0200
Message-Id: <20181022204546.20354-2-asheiduk@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181022204546.20354-1-asheiduk@gmail.com>
References: <20181022204546.20354-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Defined delimiters for 'git worktree list --porcelain' make the format
easier to parse in scripts. For example

	sed -n '/^worktree ID$/,/^$/p'

extracts only the information for the worktree 'ID'.

The format did not changed since [1], only the guaranty is added.

[1] bb9c03b82a (worktree: add 'list' command, 2015-10-08)

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/git-worktree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e2ee9fc21b..73520434f6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -270,8 +270,8 @@ Porcelain Format
 The porcelain format has a line per attribute.  Attributes are listed with a
 label and value separated by a single space.  Boolean attributes (like 'bare'
 and 'detached') are listed as a label only, and are only present if and only
-if the value is true.  An empty line indicates the end of a worktree.  For
-example:
+if the value is true.  The first attribute of a worktree is always `worktree`,
+an empty line indicates the end of the record.  For example:
 
 ------------
 $ git worktree list --porcelain
-- 
2.19.1

