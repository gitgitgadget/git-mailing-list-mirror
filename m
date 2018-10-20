Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23F1E1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeJTUuc (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39527 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUub (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id p11-v6so717825lfc.6
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbRW1ApzkAZI4YMS40CJYJyyLyq9E03qmWv3FboBQx8=;
        b=ZO5asg35QxQi51IC2F0Pr8/c5KfPiKYp+ssnMSJKW6kmMCvKZpQPm1kWKyd6Ysy+7g
         95cyYHwMCf8GFqrWq4l6dqgrzGkwMEpxJXV6q9rBw8HGHuTeR6iUwml+p+1mORSsbfu4
         BBSc+Z8qrXV+Dozjh04lN9rDC/TN6U+wiQ+kjkptaSEB3feUPrUHHoJUp51HfeXSi/Dw
         G7EYC67Rtvf33UQZMtheTrVMd/1/3DWRtIMhqqFntNwvmKespLykjRhRPjhuou1G+KRA
         zaNw5z9qmbA4QDTkFz8HT4wSuW1fQZlpM6YZdC3oZDr+D/VKTKTy9IWvp43CBx9H7j/W
         C8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbRW1ApzkAZI4YMS40CJYJyyLyq9E03qmWv3FboBQx8=;
        b=byHVShGQy3o990/EOHF4w7NXsYTZl/a8XX72YTkVnhNPvCMHDffEWbf2MTdm2lwxn+
         sxb2zvcodNbEYU7qbcIQm/QJgxtxC4M/l8nIIir9KfepN9QCS5EKQiWTJ9mLxAEPW4eX
         NLTSI576lj+Z2pwL/TrPKTFk86aTQ6mh1xLCJV/2Y0cM3slLY9LeZ6YwS7/i+W1U1d6X
         6ji6syMMVZIjy/xuKvLGBCkNl9304/degAnYuWyaDegApfohuKfG0wbu42MDRFCjqZO1
         sHxely2+aFqWqWeGcLOhE8kwwnK7o81U3d2UeKN+RZ7rAnlA8+Ef4a0+38ENhrPPvsdV
         gaSQ==
X-Gm-Message-State: ABuFfoh2nv3EqWIkEosXXw177/ky7vfL9b0C2hTrq0aPTGydAMQWhnGL
        tYgPWoxMEl8mnjbvyruxBvFrnOmy
X-Google-Smtp-Source: ACcGV63DRuueZ9jG9LMQd3WVVdYmluywlwf/T5C3hCgjmqVFFvbi+FifJPch2+nXU4VmKB7d29cEoA==
X-Received: by 2002:a19:cb94:: with SMTP id b142mr5543922lfg.117.1540039209115;
        Sat, 20 Oct 2018 05:40:09 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 44/59] config.txt: move remotes.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:33 +0200
Message-Id: <20181020123848.2785-45-pclouds@gmail.com>
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
 Documentation/config.txt         | 4 +---
 Documentation/remotes-config.txt | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/remotes-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 71844cf8e3..ec8b61e1ba 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,9 +646,7 @@ include::receive-config.txt[]
 
 include::remote-config.txt[]
 
-remotes.<group>::
-	The list of remotes which are fetched by "git remote update
-	<group>".  See linkgit:git-remote[1].
+include::remotes-config.txt[]
 
 repack.useDeltaBaseOffset::
 	By default, linkgit:git-repack[1] creates packs that use
diff --git a/Documentation/remotes-config.txt b/Documentation/remotes-config.txt
new file mode 100644
index 0000000000..4cfe03221e
--- /dev/null
+++ b/Documentation/remotes-config.txt
@@ -0,0 +1,3 @@
+remotes.<group>::
+	The list of remotes which are fetched by "git remote update
+	<group>".  See linkgit:git-remote[1].
-- 
2.19.1.647.g708186aaf9

