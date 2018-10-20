Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4191F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeJTUuu (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41649 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbeJTUut (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so33076548lja.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpbjE5d8gxwgmVBq/RttQFquWp7rFFgQ3Hw4HI2o+mI=;
        b=CWGDaOtGyx48Eh9TLCDJHN1JJKNtdLvk1cRM5mRE0nF9XK+HCa1JnuZVCdLJEqEYQW
         z/iTXRZ5qKYZb78d4mp6WKV5tuqL4IbVYl/XZWxE3r8ED9rYgGkZLyuOQ4ikhh5dv0MB
         WcXdgvIMQhRBEiYD+KG+uUuevL/3QSD3ukoUaZUR7ru23vph4FLjvl2ylOTNURlVOMWQ
         iS1mtNEWPT0sVWhP6ZMKhehkp0oAZcodazB25jUoWUDdWVeuNo5RdzarTdqm7IwHbDmT
         GGFvg3kb+hiqp7ikPKm9K7KEfj2V/Cv1IEDnt3k3oo9Mo5wrRDbskyMDXFXYNisofYbz
         iCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpbjE5d8gxwgmVBq/RttQFquWp7rFFgQ3Hw4HI2o+mI=;
        b=nTx7AzzMarqimtQUW0wppiCUaIxd5U5/FCGMUkYPSncLED6g+cE05pNJJQCnD/0eqm
         Hf/FgcLYgCOYUCu2649loqDs0meRo6U0KeLJ3VPr1FoYLjuaKCocq8k8KQ/0gnvjgHAX
         YFAtUP8AV2TTz1rv4vtJUj5zhvC62ATYpjL0HJ2E47z5L8xAi0l+1U1ALQDzx3Fhn1Nc
         bSM2AAhxkfmAaHRJcAeGdQIXPjTHOj06PTLQ7M43dANay0UvtMcOFzS0L1dRJmlaGuOG
         qATbkX63oZzAoaV1SogndIlqjkESzqg+WyaNhmPGrG5iukJN5F+9IYEdwYMHRjEF9hci
         oFyw==
X-Gm-Message-State: ABuFfoipHtVg9kcqqhRLpSiN8bwwrnSE8RaD8LR11QUG918HrWC7XJvp
        Wd9FJbvANQaqop5r3NwJaXkaACU8
X-Google-Smtp-Source: ACcGV603u+64RZFkJPyUJyxx3V7Ne096vDELAaOKh3wHR9gcKBWRt/TPPGAHnb1CJK42HGmS6HNu/Q==
X-Received: by 2002:a2e:9851:: with SMTP id e17-v6mr22402176ljj.143.1540039227364;
        Sat, 20 Oct 2018 05:40:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:26 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 58/59] config.txt: move web.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:47 +0200
Message-Id: <20181020123848.2785-59-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt     | 5 +----
 Documentation/web-config.txt | 4 ++++
 2 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/web-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 05fb670be2..76a0e3ed90 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -682,10 +682,7 @@ include::user-config.txt[]
 
 include::versionsort-config.txt[]
 
-web.browser::
-	Specify a web browser that may be used by some commands.
-	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
-	may use it.
+include::web-config.txt[]
 
 worktree.guessRemote::
 	With `add`, if no branch argument, and neither of `-b` nor
diff --git a/Documentation/web-config.txt b/Documentation/web-config.txt
new file mode 100644
index 0000000000..beec8d1303
--- /dev/null
+++ b/Documentation/web-config.txt
@@ -0,0 +1,4 @@
+web.browser::
+	Specify a web browser that may be used by some commands.
+	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
+	may use it.
-- 
2.19.1.647.g708186aaf9

