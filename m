Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726961FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 18:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757383AbdJKSGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 14:06:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36195 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdJKSGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 14:06:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id z11so2906444pfk.3
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7hiuwkx1R68qYi0jDBMzElQ6QR6s6X1LvMnM4vZgSvo=;
        b=X2preN27gtB54LKrAmVYfoiabuEPglWfmNVVxZz8j2EHVCIVmpp7JLEATURpUqdMZv
         t281IHGKffiH/UXKZbWjMHrAnJ74bTipk/GwFjdUinINJLAreW440FipPDDwhiX4P++R
         1J0zR3YZFCBKLfxQWmYvW806B18Jzf/SmEnDkUS2M+zvOiU/U0xxJ97apY1Ywm7OZULw
         AC3c4vJvARocZ6wAADYPILyRM5L7PdhgLhgg0IVTd2a5GV/U1MsUroODJAq0PnUwyxL3
         SDGxysa0Q9mv4zf0ErVIV5/veLvCv626JMR5o+bA2FahiGYO5+aTY0Pww4GdNlsM3a04
         3y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7hiuwkx1R68qYi0jDBMzElQ6QR6s6X1LvMnM4vZgSvo=;
        b=pWhhJf18ELuKfGN/1bNeXzrGiAzhVivG9ptzqAVwUFNJt7pV68S6HYbTXOO+ZQ+PIb
         113eMX5CgEkqP9/wUePGoTc+OH9N25SUKhsEVMPDVE5u8qYHBlVkbvCoNh38Nu1aK0KF
         V1rYJ2TIwFkUgnG3mq8q7nSrJdFBWSNz10jkXp5hBa3wUDAke58KCMz+uQe6L4IBXW2x
         gsSvtO9TFgk4NpqdGyghFSxR7yfvyPoXf3sLTJMD8dJ9gDOu0KPfF9xKDWBawnGCn/YC
         KGJBZZbMfkl8BDbZjIfYCFhEgz0qZnkDSlkvZ7Wk0l/Xw8zIOfVmfBkon7PR7i/LVNQf
         GsMw==
X-Gm-Message-State: AMCzsaVDUiOAIee5rPOJntdTfiDucrHKdrOxgYtpCBw3N92Bu3GiOovX
        9tKobcdPsChM+eVXI5hIf1so7P42
X-Google-Smtp-Source: AOwi7QAEoIS4EKLVhLSuzXSnCPXxaAELL33HAG5+ZHUFf2IIRsn8HZaqu/EKiaGa/z0AYVumRBOZNA==
X-Received: by 10.159.207.134 with SMTP id z6mr328416plo.258.1507745204379;
        Wed, 11 Oct 2017 11:06:44 -0700 (PDT)
Received: from localhost.localdomain (64.71.239.49.rev.vmobile.jp. [49.239.71.64])
        by smtp.gmail.com with ESMTPSA id b9sm26035394pff.63.2017.10.11.11.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 11:06:43 -0700 (PDT)
From:   Takahito Ogawa <aiueogawa217@gmail.com>
X-Google-Original-From: Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
To:     git@vger.kernel.org
Cc:     Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Subject: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
Date:   Thu, 12 Oct 2017 03:06:27 +0900
Message-Id: <20171011180627.153-1-takahito.ogawa@datagrid.co.jp>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <n>
References: <n>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash" behavior without any arguments was changed in
1ada5020b ("stash: use stash_push for no verb form", 2017-02-28).
This is equivalent to "git stash push" but document says
"git stash save".

Correct it.

Signed-off-by: Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 00f95fee1..63642c145 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
 The modifications stashed away by this command can be listed with
 `git stash list`, inspected with `git stash show`, and restored
 (potentially on top of a different commit) with `git stash apply`.
-Calling `git stash` without any arguments is equivalent to `git stash save`.
+Calling `git stash` without any arguments is equivalent to `git stash push`.
 A stash is by default listed as "WIP on 'branchname' ...", but
 you can give a more descriptive message on the command line when
 you create one.
-- 
2.13.1

