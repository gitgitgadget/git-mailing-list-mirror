Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F7A1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 10:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBAKJ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 05:09:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBAKJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 05:09:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so2725759pgp.6
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 02:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=38I5tdsrrSnOGN2y/vDiBiRl7XEo/N18RrER3WzNdiQ=;
        b=ltmRx4T3whIBmGObTcC5L8cDASEJl1aLumDWUNQrl1rPqoXJg18jDZ7PvlQwcWMX+J
         AjiJsnLsDivizEZDjFSxCyJrtfYsifwxUkT+2OvqMldeFQipZUpe0+xWHvDVurRmrhRs
         x9jH/DpJLaeM/0L8Hkumo27l2r2qCAdwZKnXBmv7bHX+yL0l9/hIO/8kF1GqV/dAMpNT
         HXmUbR9doL/ikJWLM1Y+nMSsT3SDLqmCRNHzdso3Fn+bMLKNkSBAeRzhsaMvkjxRd0uQ
         OAlQzrDpJ1xCG9nenrnmhjK3uZ8NUzBq7XkyGQSi/5OQhOFkmOOtVgkNaJfNSxVCGGRd
         RBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=38I5tdsrrSnOGN2y/vDiBiRl7XEo/N18RrER3WzNdiQ=;
        b=RVq3tkxThdz6uBpVkROoD0baFSLfVjY3DZJCW8Y9dAeznmqtcFKfj8P1iHwVOMR+wC
         RtIM+47V2KKn/iC+lupu03kpakZCLUb5595X8e9h2WqvE+Jewopw9X7bKwrmvMc3FQXi
         jsl7A4u++vy3RQVSav6uLR8yRg0wzrtKZFDt2w72fVXWiH7F+zX1pAC2sP8zAS0CAkn9
         vBMKr4HQ2P2mHG1Pm/UUS9g2GJZt8e2lqw4D6EQnYLn6adCJU9741oQjZ4yVJRrpByzo
         szp6kmc0X2/jf9a/nSKfsAadHOIkPV7Ll8AiFHZipxSLAU1GuG3o+yPaFqCjsUhwKxmS
         0VFw==
X-Gm-Message-State: AJcUukdu7nSrVUrTj0gO4Ll+udCU8mqMu0UiaQsV0Y2+83ip64S2fB0O
        3isWGbyaImJuwvMXbjnc5xtpu6cL
X-Google-Smtp-Source: ALg8bN6JiQfRi9Hc+qHb7ly6w7akfMZaW9kbXzueKkiI9R5wrkjVUZ65OKsnYVL5vpnAC6naVOmAlQ==
X-Received: by 2002:a62:c42:: with SMTP id u63mr38001821pfi.73.1549015765819;
        Fri, 01 Feb 2019 02:09:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a195sm15379526pfa.7.2019.02.01.02.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:09:25 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 01 Feb 2019 17:09:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] git-commit.txt: better description what it does
Date:   Fri,  1 Feb 2019 17:09:10 +0700
Message-Id: <20190201100910.30432-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190131092112.6197-1-pclouds@gmail.com>
References: <20190131092112.6197-1-pclouds@gmail.com>
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

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 NOTES section is gone. First paragraph updated.

 Documentation/git-commit.txt | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..a85c2c2a4c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -17,16 +17,20 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Stores the current contents of the index in a new commit along
-with a log message from the user describing the changes.
+Create a new commit containing the current contents of the index and
+the given log message describing the changes. The new commit is a
+direct child of HEAD, usually the tip of the current branch, and the
+branch is updated to point to it (unless no branch is associated with
+the working tree, in which case HEAD is "detached" as described in
+linkgit:git-checkout[1]).
 
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
-- 
2.20.1.682.gd5861c6d90

