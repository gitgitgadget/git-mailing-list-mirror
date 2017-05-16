Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9034F1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 19:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752115AbdEPT7V (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 15:59:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34308 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751577AbdEPT7U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 15:59:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so40393840wmf.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EQFH9UDth9RXGiDLwRxP2OBtlzhYbsQ6TK0rXKhL5Dk=;
        b=Squbem5xPHSHvZjPO4tPGKVCeaIoKWkHZFti5NQLiwrC0vUB5ta186RLJ9KcAt5C7i
         Av2WVFnbHqyJZ/xPIyYdr+8GzD/wT2yx2AJP84hMymiM2PrYTnbDMBG50QbyfDt6VgkA
         1rTd+Xo5uzSZWuPPAvJGexqZ3yTEhIVqb4hsqRwOACSluDdG5DgG/G8yCf+NoMfrkd+z
         rZWszcbwq0pGoVfhJkcWipnmwoD5GTs3W/OP6HxKbEPMu3lyv09PQMnkSNypL1YgAW6Q
         5C6IJj1I+su3wLd3nYJua6YoRjEo8MumhafjzCS42N60qtF7fWjGdOJ4fz5eQGbW6j1y
         R5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQFH9UDth9RXGiDLwRxP2OBtlzhYbsQ6TK0rXKhL5Dk=;
        b=oxXvpGfskKsOKNLqQ+6Pjd8o4T/svfiVgu45TM/vK9IvsJT+wLOVVlKoE7hMJvXAWs
         ppX+KmpYb2jh2mLLv0dKXKLvWnLVKXJB0fGE7Zyo/uX+g7P/HvOAMSk2ZY7EaZBeM5DP
         3COqijCfqt1hA1tbPEb10HVid0bj0TG22vHhAUDRGQxNAUeMafbPAVR7ZwNhHePTVz7c
         ywKC6FN5a+CLilQsyN7G3da36JvfqXwIT0g6rwTq9weLiKJmoYkS2S0n+8cw/7WOLk1P
         1Wplf+PsZqez5TKUhbBpi0ZjpOOIvFaAwS7physf7qMoq8NFwLqp1/ifSdh8nh65qY+g
         OeFA==
X-Gm-Message-State: AODbwcARIbtB8SzUQR1jQOWKsqRw4LFZmK10SfU/N7iCwWOEIUrP/+t5
        M5aVn1aWKr/YTA==
X-Received: by 10.28.138.73 with SMTP id m70mr7633216wmd.99.1494964759408;
        Tue, 16 May 2017 12:59:19 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id h70sm7844309wma.14.2017.05.16.12.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 May 2017 12:59:18 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] completion: add git stash push
Date:   Tue, 16 May 2017 20:59:45 +0100
Message-Id: <20170516195945.745-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.13.0.rc2.279.g813ba54fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When introducing git stash push in f5727e26e4 ("stash: introduce push
verb", 2017-02-19), I forgot to add it to the completion code. Add it
now.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index af658995d5..3f01249116 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2810,7 +2810,7 @@ _git_show_branch ()
 _git_stash ()
 {
 	local save_opts='--all --keep-index --no-keep-index --quiet --patch --include-untracked'
-	local subcommands='save list show apply clear drop pop create branch'
+	local subcommands='push save list show apply clear drop pop create branch'
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
@@ -2825,6 +2825,9 @@ _git_stash ()
 		esac
 	else
 		case "$subcommand,$cur" in
+		push,--*)
+			__gitcomp "$save_opts --message"
+			;;
 		save,--*)
 			__gitcomp "$save_opts"
 			;;
-- 
2.13.0.rc2.279.g813ba54fc

