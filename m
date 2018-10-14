Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E051F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbeJOFzo (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38231 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:43 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1-v6so16083266ede.5
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRQgY5Q/3ta8Cp5rk6QcII830ZYNplLX1CNd4hZriAA=;
        b=SHP9mMr/FB0+M4MvjetVF3h02K7D9ar2+HSFNaC0awQnecktpLWNyI6Mf7JrUyka7T
         4Z9ixMDaZyFY3iBi8+41g1htZmKwTkcv2JE3HIBmTVciqGFVg9qhAV0o0p32PTDTDywD
         cW4RgmPk9KShRipVDcB8XLPY0DT4B/NAcnSJC8XWa2O5luhWKdiIlfT306+S5xs0I1sY
         Dmp3LG//6vg5PT3Iv3Ka275f8Ied2bDLnDDSiA06vXOrWOOg+n4E5eZpHPOFvz1hp9yw
         LpwkeqBqUNmtoVHG/wTeED8beBFUlgMc+a4NHHl2K0rdI9yT9yIYu6uYB9VTIk8yLuUM
         LKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRQgY5Q/3ta8Cp5rk6QcII830ZYNplLX1CNd4hZriAA=;
        b=LNhqclA76S0DwLivUmYlE8++uddd5nArf0v9JJtpIvz0Y4zNzlIyGCgB2AhduCQ6h5
         NcII9BScJJBAlwQglKbcGoq5f2BY/s4iMSuRYJirxtYVBdsRlHzSTyEWpcwirL7CerKf
         MDJ9spQLQNYl7rEm4Iw8EgnTIfxIG72sIME8cEqISyPeXUH+UdXl2B6Dozd6Hecw9x1G
         uTk+SP4YQVZL7GgNexv2CwZ1hUhrghsOwrpTvfq9COz8QK/AyHiTU0qdyFZmcJ4oV9uh
         S4X/dUbJEDCS7atEi5OivTytB4x1h/7n6d9oP8GkxsQjKTKtKHtLAQgcoYx28BAKrdkD
         qbXg==
X-Gm-Message-State: ABuFfogG7fDqvq81CmW1ta+bYbFX9pcbcmL/rkeO/I0lGz5ZpCi0Qdqm
        y90CmcQNJGW6H3LH2aLsxLGQrVcV
X-Google-Smtp-Source: ACcGV60rZuz0EyRffhFMqmA4t+B0OuThb6jzr2A9T1smNm8nSh1d7CXXr4jrD5+H2JgDBD7do9N7ew==
X-Received: by 2002:a17:906:5e4c:: with SMTP id b12-v6mr16739752eju.52.1539555196247;
        Sun, 14 Oct 2018 15:13:16 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:15 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 07/21] stash: mention options in `show` synopsis
Date:   Mon, 15 Oct 2018 01:11:13 +0300
Message-Id: <ac293e2a43d792447dd810f96614a0ba2ea5827f.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mention in the documentation, that `show` accepts any
option known to `git diff`.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.23.g10a62394e7

