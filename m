Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C6D20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbfBYXRG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54434 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfBYXRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so583471wmh.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvWu474eTYwniuBl+HpsjQxXC5wjlFARAMdp36Fnf9w=;
        b=Iy2TqJk1QOpxjJx0yhvxNLyIk6CKcM2Z31Y09HwcJtdl6kAiRJFSMGhd7tmqhCVVUE
         T5CeNQmrZQab5eUBLfYwCpjypqHTwSrYRgwhvcRR3qlh44ARPBZmOvBkt3WgcL+DJ9pN
         ypAbILVL79CdRh9Vr8kaCa9M6BBuH2XJuiQ2Hc9OAsBs1udwo2rBMT8PcY1pQrPx8oRq
         utmsztfc8oxhwZdIgZ5SEA2DbUpWstDbG4Sf8eRqdswv0Yd0h8OUvcEeADMFk2YtpFQ2
         TulPnybzTUVGyzo9WAjxiyTG+2W8vflpc5WZ0lNswaI6dahlnwaD3X3A/ikn4etiguDr
         BRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvWu474eTYwniuBl+HpsjQxXC5wjlFARAMdp36Fnf9w=;
        b=UY6MQjaKlQHyofVyecDlGhwgVjkOzOs23t+pzV82XmFMpLRpdg1UZ0cvlr+ysmjGwk
         YAcE76vYaM6OmiMGryqNaa84lXiqTMH1ymSLRmNbGIfQKV2VFsalS8RqLBBNKp+WU3pG
         ucX2qC0qbIl1m74cNG1Yxv9678Q5qULwBXdOg/6BmMfGokK3fP+jjS7aHedtrTmTixCp
         BFW6JTvCyCn4Jxt+zjFUJ2mpY1SKGvwr7Setx1yimd8HOLw6pk1x2XgumhJ7Ae95mN/A
         8OTtymlTdD5Qmg/BSniUJg+0cakyIFrJiqJdQjLfbJSKMpohNn0wSkd/7pl7k3OCgH7C
         v/dw==
X-Gm-Message-State: AHQUAuZ79q/pZnXuoccZhNjcT3m8EkVzVd+2iIfwRGZFQBsdp+cd7YR6
        5F4lIZ1oDiN7nUZzchk3P397l/e0
X-Google-Smtp-Source: AHgI3IaxapUkhEnc51+o5TVHZUw/YBpfhAmLP89xSVOrNK4JuSfYqvjTdzSa9YqCmgMAT1EQs0+TrQ==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr728861wmb.10.1551136623012;
        Mon, 25 Feb 2019 15:17:03 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id d15sm22613831wrw.36.2019.02.25.15.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:02 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 10/27] stash: mention options in `show` synopsis
Date:   Mon, 25 Feb 2019 23:16:14 +0000
Message-Id: <20190225231631.30507-11-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Mention in the documentation, that `show` accepts any
option known to `git diff`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c47911..e31ea7d303 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git stash' list [<options>]
-'git stash' show [<stash>]
+'git stash' show [<options>] [<stash>]
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
@@ -106,7 +106,7 @@ stash@{1}: On master: 9cc0589... Add git-stash
 The command takes options applicable to the 'git log'
 command to control what is shown and how. See linkgit:git-log[1].
 
-show [<stash>]::
+show [<options>] [<stash>]::
 
 	Show the changes recorded in the stash entry as a diff between the
 	stashed contents and the commit back when the stash entry was first
-- 
2.21.0.rc2.291.g17236886c5

