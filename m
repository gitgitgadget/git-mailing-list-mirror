Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3F4201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 16:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422753AbdKRQTT (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 11:19:19 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41431 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030837AbdKRQTS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 11:19:18 -0500
Received: by mail-pf0-f196.google.com with SMTP id j28so4146116pfk.8
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=80Djo1lOLqlP0wOSr3fkwAj3omCy2oR9uGeoCOPhXeg=;
        b=YbhHkv9qn9uIGhM/L0hkxWhzCLT8fAdWTiOZgcvTFpSxgQ8eYv0bYUH9kCM7mky8o6
         zl+vq8Rld/i2nb6+TRUvwMU4Qo/q4oIB8zs3OY+zhxoC2OsEDs+3/5wLzwSw0duYpOmY
         TXgGHogBD+0ynfD54MUnF20LWHVo8dc+ykAtxyB2NPyivIJ9ix4+NUK9TZRYGZeLUrLa
         DyZU5Sq9klZHKW+zu4UH9Z9t1xsn2D0SCiUy17wRYbNFtvbrLIXDsGtYQ3LElC/fphJ1
         lKT0Vo0pm9tp5tMzu+8pTn7pAdtYwPT1Pbq3otvk2QgnWIYBbc3eRTEm0eEpGylT4pKt
         vBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=80Djo1lOLqlP0wOSr3fkwAj3omCy2oR9uGeoCOPhXeg=;
        b=JtTVnmLXtTCOdGQQyvPk59SwiI0jFXcdqw8LEDA79M1KEdjoZjL8FFYetcVb7SJpLa
         R7tsTWlhw4zeb2G30HkTScuJgS4nsDjH7VQlI+teY4mYQMEC8g+sDTrAmLAnzzG7fHbo
         zge0QGn8DKKJU5lURTS9EK4xLJ/Pv1x65K13mZG0JhQp8wwknNGJvMtdQD32UsD80J3x
         JjOlic8uDW3eCanzjGPH9dKheZ2Ag08+vstsVmcavTl3+LpiliCKFIjUr6IsaQBZrJzq
         NmmHHr7fjOLHYMmBCVVnGhdQIkpQImV44tVPZz5a0N/rpXW2JkFXj4I7XlQMPyz6c8pn
         fzAA==
X-Gm-Message-State: AJaThX4MCyNx3NhQ+Od+zD72uefA0jjlBsuGi6ypt7flYhXE0B0yn38c
        DM1wMmXQ9ZFW39BZEDEKxMI=
X-Google-Smtp-Source: AGs4zMZ5xNRxOBgf24juGtTAlgsOZBip41BfdtWoAgvo2L//f5Jq/+hvTZNrJF0rT/WQ6Dgrw59HAQ==
X-Received: by 10.99.108.67 with SMTP id h64mr8571427pgc.119.1511021957722;
        Sat, 18 Nov 2017 08:19:17 -0800 (PST)
Received: from localhost.localdomain ([2405:204:72c0:fc36:f2a4:a5ab:70fc:f807])
        by smtp.gmail.com with ESMTPSA id u12sm13402612pfi.87.2017.11.18.08.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 08:19:16 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: [PATCH] git-rebase: clean up dashed-usages in messages
Date:   Sat, 18 Nov 2017 21:48:10 +0530
Message-Id: <20171118161810.16494-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.291.g0d8980c5d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 6344e8d5e..42a485aaa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -9,7 +9,7 @@ OPTIONS_STUCKLONG=t
 OPTIONS_SPEC="\
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
 git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase --continue | --abort | --skip | --edit-todo
+git rebase --continue | --abort | --skip | --edit-todo
 --
  Available options are
 v,verbose!         display a diffstat of what changed upstream
@@ -216,7 +216,7 @@ run_pre_rebase_hook () {
 }
 
 test -f "$apply_dir"/applying &&
-	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
+	die "$(gettext "It looks like you are in the middle of an am session. Cannot rebase.")"
 
 if test -d "$apply_dir"
 then
-- 
2.15.0.291.g0d8980c5d

