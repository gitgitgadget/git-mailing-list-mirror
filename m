Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F76B1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeJ0PFA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:05:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44845 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbeJ0PE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so3085357ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObmG/6lFfqXhbh6H0yTdozyNtVpj9GT7/wfaNAp6wfw=;
        b=nj7C/UtJaBva7IcQU8tWEFCSoZ324EjoNdCtrHkHjDxaA4i9sTu4jpBdIkBA6qgHVM
         G1VFMTNyjNHE2hHgjUWf9kP9qCS5Z8N+lqOSvFf/2q7JO0kxv3OalKm/OWd0V6lDEmgm
         iZ9dGEWOsTFQMsTWrsD9l475oww78iayGuwRn5ui3QKyOduiCIAqwIiNNIvE9idFDGws
         xaHkNE0GBbnXC9kAAlDX0zInNsAySN3y7lAyl0Rj8FYYVGhHszhwT/tKg9Oyq5DTdYY6
         Ror0uwB8J/BsWDjW65r60UWNN3/3pB/nu512lcT9mlKpHskig3S/KxdzvWY02cN1UhTx
         5esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObmG/6lFfqXhbh6H0yTdozyNtVpj9GT7/wfaNAp6wfw=;
        b=oinnBAuULtgbFGwVVF0RzdbWyZy8JlXtkXxeG0dqV6yEF2+flJUDH1CscoTd6UY1a8
         q6koL+yNikE6NKQaCeLNmmszdefbtIA+1lndLHpizQ+/5FEYwVECb9h8007YpYuY3Z/3
         vIYc+aUWFD4TgQX/WQRc+1QyQP3R77GbfA0JRYaRu2oArfBSRb4uLCrGjazj/BNa/kXe
         mMSKsSGAVOhVhR5+K6Lsu+oUD9kpH/5tK8E9VaeS4s0eqwDMYyW+nz1+bOs8m8fCNhhu
         tmWup70vDgoGllwulmpmNthDR7qKJKYuSflNZY3axEJWOSdh68jGo4Jr53XWTvYy2Baw
         ecdw==
X-Gm-Message-State: AGRZ1gJFv03ZeAOOb+OeWf90fObe8/b9yYqMHVEhJpo1iOKVk2DGUOLl
        Rad33nuG1SECKgOOI0x+tDR6lP+5
X-Google-Smtp-Source: AJdET5d3a86nvONRCcAsQ+vzc0UPSjBQWceLklFZzWfV0x+FtwUn8nz0wTKJhPmlIaBZaJ2qRd4QQA==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr4020609ljh.65.1540621504507;
        Fri, 26 Oct 2018 23:25:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:25:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 59/78] config.txt: move repack.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:32 +0200
Message-Id: <20181027062351.30446-60-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt        | 28 +---------------------------
 Documentation/config/repack.txt | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/config/repack.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9aa849ce8b..0ce5081f22 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -397,33 +397,7 @@ include::config/remote.txt[]
 
 include::config/remotes.txt[]
 
-repack.useDeltaBaseOffset::
-	By default, linkgit:git-repack[1] creates packs that use
-	delta-base offset. If you need to share your repository with
-	Git older than version 1.4.4, either directly or via a dumb
-	protocol such as http, then you need to set this option to
-	"false" and repack. Access from old Git versions over the
-	native protocol are unaffected by this option.
-
-repack.packKeptObjects::
-	If set to true, makes `git repack` act as if
-	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
-	details. Defaults to `false` normally, but `true` if a bitmap
-	index is being written (either via `--write-bitmap-index` or
-	`repack.writeBitmaps`).
-
-repack.useDeltaIslands::
-	If set to true, makes `git repack` act as if `--delta-islands`
-	was passed. Defaults to `false`.
-
-repack.writeBitmaps::
-	When true, git will write a bitmap index when packing all
-	objects to disk (e.g., when `git repack -a` is run).  This
-	index can speed up the "counting objects" phase of subsequent
-	packs created for clones and fetches, at the cost of some disk
-	space and extra time spent on the initial repack.  This has
-	no effect if multiple packfiles are created.
-	Defaults to false.
+include::config/repack.txt[]
 
 rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.txt
new file mode 100644
index 0000000000..a5c37813fd
--- /dev/null
+++ b/Documentation/config/repack.txt
@@ -0,0 +1,27 @@
+repack.useDeltaBaseOffset::
+	By default, linkgit:git-repack[1] creates packs that use
+	delta-base offset. If you need to share your repository with
+	Git older than version 1.4.4, either directly or via a dumb
+	protocol such as http, then you need to set this option to
+	"false" and repack. Access from old Git versions over the
+	native protocol are unaffected by this option.
+
+repack.packKeptObjects::
+	If set to true, makes `git repack` act as if
+	`--pack-kept-objects` was passed. See linkgit:git-repack[1] for
+	details. Defaults to `false` normally, but `true` if a bitmap
+	index is being written (either via `--write-bitmap-index` or
+	`repack.writeBitmaps`).
+
+repack.useDeltaIslands::
+	If set to true, makes `git repack` act as if `--delta-islands`
+	was passed. Defaults to `false`.
+
+repack.writeBitmaps::
+	When true, git will write a bitmap index when packing all
+	objects to disk (e.g., when `git repack -a` is run).  This
+	index can speed up the "counting objects" phase of subsequent
+	packs created for clones and fetches, at the cost of some disk
+	space and extra time spent on the initial repack.  This has
+	no effect if multiple packfiles are created.
+	Defaults to false.
-- 
2.19.1.647.g708186aaf9

