Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C7751F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJTUud (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:33 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40887 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeJTUud (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:33 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so33087542ljr.7
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fBS3t6UklLLosk0faAgQoTDvcgou98WfB2fVt8XNgI8=;
        b=fc0rFTZaBbRnUVcTytVQfj/DAEP3tZ0/y1vUatUJ9dReCxOHwFewMR32KlDjK5RC9W
         nyOYEMG8v3j+6ZelUfx5ELE9jYHQ6JfNZ39r0YN0zYky3dxX7I+j9H4hSRvbNaqt9Stb
         4aIGMS/V4yCFlCp2KAHmE68QOj5P/jOpTwDxAjjhT0wEn4HRqIsY29oI+uFM0vlzm/Fn
         KX7kj5ZGrFVrdt7Ny0jA3ZHWDZ7w00QsJx+Om0/Up7sD26z0W8JCkaeiCQLE8a4TTL77
         ljmoOa0dxFjsMGbCxS14ofj9IqfOxSHmsbiBc0dP8SqgMU0BAagjGUX52pSnXd56Leth
         hTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBS3t6UklLLosk0faAgQoTDvcgou98WfB2fVt8XNgI8=;
        b=BRRul018IUwYYKXCKkIa2KbPVUSxYYmL/W5mQ1uHLNxiTN+v/oOceeOlhQiN5GitqY
         vLuREhB9xZIDSC2ScowWgRgZ2xmxcGDLHRIOr/BJF0qKHFYogMr/00rKUFm4V4VaQqJd
         +Ci5VbaiTsepaummyKR8Lsvm1NpF8lOc0Q33YgvwYADMVX9GbaH2idTlHY7bIu0+qnh6
         25ZymDOF2i1oOiyfQ/5e4QVpDSjX/ZxJBffU+PxueCy6QCT4PBOCFGMJ71WLbFbwFHub
         CNC1wE0M6zKUPrPAVAGtzZQCiq+h+emnFcWs9q1i2fNFubRuyF2bFlPCcE2zYdZ2cSZc
         Rx1Q==
X-Gm-Message-State: ABuFfojFDlHcnq0UmF8u1cIS5jz73dP7JOHluEA6IS0qB9YMbCxU/JkT
        S4xckhnFMnayzIqNIRWkJ48VbIpm
X-Google-Smtp-Source: ACcGV61XuUu+8rIChYgT22SzI62OHAvQ84AUqENivo34XWMHYUlVv675ZmjfEXVkJw8zWlMXglf7FQ==
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr20429215ljc.37.1540039210221;
        Sat, 20 Oct 2018 05:40:10 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:09 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 45/59] config.txt: move repack.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:34 +0200
Message-Id: <20181020123848.2785-46-pclouds@gmail.com>
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
 Documentation/config.txt        | 28 +---------------------------
 Documentation/repack-config.txt | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/repack-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec8b61e1ba..c3618b00a4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -648,33 +648,7 @@ include::remote-config.txt[]
 
 include::remotes-config.txt[]
 
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
+include::repack-config.txt[]
 
 rerere.autoUpdate::
 	When set to true, `git-rerere` updates the index with the
diff --git a/Documentation/repack-config.txt b/Documentation/repack-config.txt
new file mode 100644
index 0000000000..a5c37813fd
--- /dev/null
+++ b/Documentation/repack-config.txt
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

