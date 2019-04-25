Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69B91F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfDYJrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:47:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42121 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfDYJrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:47:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id x15so6462033pln.9
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTs5Td2lMBESYoatzTSxSzj70hsTaR1/2QdJ1oT2jQA=;
        b=LyI6Sxwci0unwfDYLjLl6kWOY7xElhah5dZYdrWLTqqXXD0DZ4HW268SLMfe0HRqfM
         ENJdgsASTpJ/w6CajUyTKBfczkmfy2xj46uQqy778k3PedqZSJRrDLzr+NoplruQCbOK
         Ts9v4ptRCazzDSAQFXeInliDjyloaMHdM/5FeXFVdjFp9RtC/3LYUqUU7BIkS5LxeZLS
         ski/SvjcG96WRJHf2lP+1PszCu8ZP9C5+WHUCle6esGXqnxvTaTuqlQtpYP7UYiqVIP0
         Rjm/UXCo6NqqQkw97j7W6yMIeB70Q8Tx1z7JeFsjl7rhwGm+5c7MVb01D1WQEldC8y6R
         ywnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTs5Td2lMBESYoatzTSxSzj70hsTaR1/2QdJ1oT2jQA=;
        b=YGS9G6qI8jBBD6c3fola73n5gC3kBN8mNCJ5gziv0XPjgWrpyPOMMcCkFG4eNkbuGx
         1lz9FYdOIAM+YJNterChGK8PJUkUnadtnjWxWwHdco3SEZi3W3WdD0T8EYMWOvlT/Vd9
         1aJBJnyT36i1qTL9ZjZeCPzXZ0FnOqeFcOo4450QfXXPS9HRV6It+BYIMMr+sxNkPrVs
         UIevy113Yd3vWHRsc2KBu73IoWPP/QxR6+gRLLZLQ0VGFyTrW1ejLwP5+Kml2EtzlTZo
         qcrpKwK+5kvyNqJ5p4fPmp+eoFZpw3w59Hh8cPXmYa4vcrrWVEPU6jLyh+BKYtDhOrdi
         llIA==
X-Gm-Message-State: APjAAAVDJcFKCZB/yf0mznDwbc+GZFCx+yoRVtN6edBSX0y4M+QNbfq6
        rd+yuPdJOcExZoPIOtr7ol4=
X-Google-Smtp-Source: APXvYqzs/hBkUqZdjRFPSgqWemkkm8UnTEhkvSrOLHvuxmWGhYQN7pg6UGSknznd5oE2XNUnQwSjPw==
X-Received: by 2002:a17:902:968b:: with SMTP id n11mr37842576plp.118.1556185652860;
        Thu, 25 Apr 2019 02:47:32 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id 128sm25189391pgb.47.2019.04.25.02.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:47:32 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:47:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 16/16] Declare both git-switch and git-restore experimental
Date:   Thu, 25 Apr 2019 16:46:00 +0700
Message-Id: <20190425094600.15673-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two commands are basically redesigned git-checkout. We will not
have that many opportunities to redo (because we run out of verbs, and
that would also increase maintenance cost).

To play it safe, let's declare the two commands experimental in one or
two releases. If there is a serious flaw in the UI, we could still fix
it. If everything goes well and nobody complains loudly, we can remove
the experimental status by reverting this patch.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-restore.txt | 2 ++
 Documentation/git-switch.txt  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index b608f3f360..d90093f195 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -28,6 +28,8 @@ commit as the restore source.
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
 OPTIONS
 -------
 -s <tree>::
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index f15e5bdcf4..197900363b 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -29,6 +29,8 @@ Switching branches does not require a clean index and working tree
 however if the operation leads to loss of local changes, unless told
 otherwise with `--discard-changes` or `--merge`.
 
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
 OPTIONS
 -------
 <branch>::
-- 
2.21.0.854.ge34a79f761

