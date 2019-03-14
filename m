Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD5A20248
	for <e@80x24.org>; Thu, 14 Mar 2019 19:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCNTM4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 15:12:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36359 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCNTMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 15:12:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id e16so3884727wme.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=LA0k/QxaFAJVbRbI8vi5HxthdDk1FBIgqgY41+1weJE=;
        b=m+dpFwAGG81LE7GaGhbRjGOKrKtX7BIkUF33NUbiayR/KWJN3jc1Fx33WbO8QWklwO
         9nwGWGCqj+y5bQKe3jF4RytqmSNf6TI+oDCY272SqFM1tp7yHS1qjOSM7kviqOT1WKD9
         u5WiEX0hz/YN+zS+bm3pShg32PW/W9XG05S3+QDtu/3DAykLpI6pOj0ravaCG1tWkRmJ
         Foa93XiRIxuCMjP9X764sXqYnBfkmWzQ77oPHSAIRv6JUraOl8DFTKyiG/I7bSoD8vB/
         AnGpm19grNtPgy9jXGLJdTeRoQ+Giz54KO2wuHa/dZv53lh/3Tu1zPpZaM+hDXtpu+rQ
         F90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=LA0k/QxaFAJVbRbI8vi5HxthdDk1FBIgqgY41+1weJE=;
        b=fvOwadNW8phcSGoyxs22Em/J1y1SgCgqGXJA4TK5ZULxWaUmAHhDTLwd0P1ajycQGa
         ek7W1SF1xtUWqOt/kHKlg58sYwqK9cznne4RJ8JHIuS4btyaN4NMrnXLel9Kfop/4hEY
         Gb7lT8HEy1VNVrsmULOxwfMtjI1AKb5RDBkx7C2V97PB1ZYoSBhBa5Zkm/peanLQiZTU
         xQ6kJ5D/fDgWbNUyvuabOnIhXa0nqUms1zOCaVJswsf2SuUJ5jJ1VdWL8skoKD/+tM+k
         kWZjxWfYsRtnTiK1k7N5drP+sAfYMKrxkTkIOOGpkMi1j1jtrq5VPzBBso2ufw/pDkvC
         bOLA==
X-Gm-Message-State: APjAAAVi3wCe7GZgQXjyvrGh8LnMIEs8CjrdOx1Gmwp7GY5Lca6B/ngT
        dQyU8qvONrXxe1xGJjF34X14PBTm/Q+ikQ==
X-Google-Smtp-Source: APXvYqwBXbt0jHqxE/AmEawLBR40YHfiIdDU1Ix+5qcZu27psqmNl/uZrHS7s0o4wULEvP2sASFnVg==
X-Received: by 2002:a1c:b38a:: with SMTP id c132mr28172wmf.49.1552590773187;
        Thu, 14 Mar 2019 12:12:53 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-186-210.as13285.net. [89.242.186.210])
        by smtp.gmail.com with ESMTPSA id a2sm20328788wrr.60.2019.03.14.12.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 12:12:52 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/2] am/cherry-pick/rebase/revert: document --rerere-autoupdate
Date:   Thu, 14 Mar 2019 19:12:32 +0000
Message-Id: <20190314191234.25553-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190314191234.25553-1-phillip.wood123@gmail.com>
References: <xmqqef7a9hbx.fsf@gitster-ct.c.googlers.com>
 <20190314191234.25553-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This option was missing from the man pages of these commands.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-am.txt          | 5 +++++
 Documentation/git-cherry-pick.txt | 5 +++++
 Documentation/git-rebase.txt      | 5 +++++
 Documentation/git-revert.txt      | 5 +++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6f6c34b0f4..fc3b993c33 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -99,6 +99,11 @@ default.   You can use `--no-utf8` to override this.
 	am.threeWay configuration variable. For more information,
 	see am.threeWay in linkgit:git-config[1].
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 --ignore-space-change::
 --ignore-whitespace::
 --whitespace=<option>::
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index b8cfeec67e..d64e72462f 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -148,6 +148,11 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.txt[]
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..fbf9a4d70a 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -300,6 +300,11 @@ See also INCOMPATIBLE OPTIONS below.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 837707a8fd..6afccb2f1e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -101,6 +101,11 @@ effect to your index in a row.
 	Pass the merge strategy-specific option through to the
 	merge strategy.  See linkgit:git-merge[1] for details.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 SEQUENCER SUBCOMMANDS
 ---------------------
 include::sequencer.txt[]
-- 
2.21.0

