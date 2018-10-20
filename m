Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459551F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbeJTUtm (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35522 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUtl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id d7-v6so6542126lfi.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zy78mJxw+JQMJ4FD8qmcUz2lhcQhL7o755G8d49fOnk=;
        b=Dw8z/skRQ+mu3S9rrzzH2uGjBC6R4ZyBjP9o+hKuLV0hfFJu2YAV7efX4qTvIa9TiY
         Uyl6dy8AM73bliuDSTcCTs71aWut+6XICDbU/fmIP0dUZ6Evygj8Y4VM+4H+J40MOOuE
         XGsL/uHhCvkBoc5yaYKV7DIrUxFo1gy1lIZYUvMGpV0HH87ViSHlQ+APeVqYtVSR2uE3
         VYfyPbDkDJQ2pLLUq2ax5VXAID0oyyeqIwPY0olNEiEcI6OrLRfuT8WJA1G3nDYqm2n6
         RH4NkwPpdqwZutx9Hek8SqCJnodtnGjRlXHqHN/YqjIkqKrie3tngOXGL8Fab/Jasuor
         34yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zy78mJxw+JQMJ4FD8qmcUz2lhcQhL7o755G8d49fOnk=;
        b=AQNnG4WOJ6p+0gnPIDJpraXmnLi3T4aJCdzm0EXalrslX0vXTsKSMMYyljmIz9k0xq
         IUlJGHH29bqRrd2nanxLTaquOzmEd9kbH/3FKAI4f9l3hdDraL3Ga9kzz5Pof0JQTo+A
         xLjwCE4Azvda1BMw3srj8vLTrhyqIvTlMvl31DJ/FzBFGC+6OowvNW9NiN23JdtgwV+2
         SnRgFaV8PHWYnDmoC7RVff6zDqMql5hp1eiEWphgBYj2klGe/501o0Y9wKilN/qMZXMo
         dzLw+bn7o7Q3jMY285s1CG4Lwp8yhasX76QfITZw66CClq7CBSHyqNEl7zWZdO+Z87/4
         292Q==
X-Gm-Message-State: ABuFfojSuC+Wk/DW/ej8it396mIo8Kzwo3tfihH4l7QVzEB4c01A6E0C
        /ZSrgYUriWpc0mz51bc0RGzIJXlM
X-Google-Smtp-Source: ACcGV63/IdTNIz9ECrFBFN1+Pk1tpHj+Q0YbwdX5/1fbWCprxwEomXrRww1zMaxXGGUFaGRADAT1Iw==
X-Received: by 2002:a19:f514:: with SMTP id j20-v6mr5271375lfb.13.1540039159345;
        Sat, 20 Oct 2018 05:39:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/59] config.txt: move filter.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:08 +0200
Message-Id: <20181020123848.2785-20-pclouds@gmail.com>
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
 Documentation/config.txt        | 10 +---------
 Documentation/filter-config.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/filter-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 66791f0918..7c7dde188c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -329,15 +329,7 @@ include::fetch-config.txt[]
 
 include::format-config.txt[]
 
-filter.<driver>.clean::
-	The command which is used to convert the content of a worktree
-	file to a blob upon checkin.  See linkgit:gitattributes[5] for
-	details.
-
-filter.<driver>.smudge::
-	The command which is used to convert the content of a blob
-	object to a worktree file upon checkout.  See
-	linkgit:gitattributes[5] for details.
+include::filter-config.txt[]
 
 fsck.<msg-id>::
 	During fsck git may find issues with legacy data which
diff --git a/Documentation/filter-config.txt b/Documentation/filter-config.txt
new file mode 100644
index 0000000000..90dfe0ba5a
--- /dev/null
+++ b/Documentation/filter-config.txt
@@ -0,0 +1,9 @@
+filter.<driver>.clean::
+	The command which is used to convert the content of a worktree
+	file to a blob upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	The command which is used to convert the content of a blob
+	object to a worktree file upon checkout.  See
+	linkgit:gitattributes[5] for details.
-- 
2.19.1.647.g708186aaf9

