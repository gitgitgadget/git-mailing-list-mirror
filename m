Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AC41200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbcLZKXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:01 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33238 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755059AbcLZKW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:58 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so52474481wmu.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fxkid3anQLJpAoBkWIKs3nFPM3NWeQEpvH+ANQ6T0aY=;
        b=RnXnqWP5jGRDs0y9DHTZDppKrnUV8wkIZdKP+C3spca/btmjrNsDNn7CkSseLfoj0w
         z/lk7lENfOGi4EZF4oW/CgUz6aM1X8plVz7Q9vX6qYoVQv6a2jAX32+wQx+AcQKM7vT5
         kn5pTt7e/ypQhfgWGkDKrsP9YCjbsxBnS3Wg4U/lkwjp0tin1knNoX2Xxf/GJQ5K7ozO
         JfzeAw3IdNtqWJceoCGsvH0qgUd96Tucqm8JiSdYWDpc71CBRZWm2ZAtfsAYWael+MWl
         1r15IoY5JdceVZS85gsvwO19/x0OJ6cNjlvFwXgmkouACs5JSGQAR3A7D1KDbyf/qQ+O
         h97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fxkid3anQLJpAoBkWIKs3nFPM3NWeQEpvH+ANQ6T0aY=;
        b=PTW0jZYI/Ipp3jbrApRC59aDmIDwGQU1xBn0Leb1/cZXsVoD0goqtcvGbWq/NK12aU
         /laJCqMa7GLDByI2Unh+zpa4mZQGLDIuItwD9cYwu7vdUy5Uag2T9qG/Fwt971UaOBdX
         NgJ/Xn7TtfRADzVHOQTQ/c4CydbEPjm5zKGtnxMAF59AE8TrLoaQ9Zfj4QlxBWbtVE1Y
         Qy9a8whzSeUMR+WhOBu6xbPW/xCDKqWZRmVolIWsfb4tQoAfXpKhDASr6XIPCgDTL6Bh
         ryckEToVNnF+6ifLx/ElsxfLos145nlKKtG7wUgVZ/h1GhCeMbj0j2+JD3xhVM7SxU1f
         RkdQ==
X-Gm-Message-State: AIkVDXLI2zA1t2Ri5B+vkSGUXcC9q0miKutX5grrNoG48+y7AxgsOctLu+DH97LOWVEDqg==
X-Received: by 10.28.17.145 with SMTP id 139mr23851723wmr.50.1482747776440;
        Mon, 26 Dec 2016 02:22:56 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:55 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 20/21] Documentation/config: add splitIndex.sharedIndexExpire
Date:   Mon, 26 Dec 2016 11:22:21 +0100
Message-Id: <20161226102222.17150-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0f5a77980..24e771d22e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2786,6 +2786,17 @@ splitIndex.maxPercentChange::
 	than 20 percent of the total number of entries.
 	See linkgit:git-update-index[1].
 
+splitIndex.sharedIndexExpire::
+	When the split index feature is used, shared index files with
+	a mtime older than this time will be removed when a new shared
+	index file is created. The value "now" expires all entries
+	immediately, and "never" suppresses expiration altogether.
+	The default value is "one.week.ago".
+	Note that each time a new split-index file is created, the
+	mtime of the related shared index file is updated to the
+	current time.
+	See linkgit:git-update-index[1].
+
 status.relativePaths::
 	By default, linkgit:git-status[1] shows paths relative to the
 	current directory. Setting this variable to `false` shows paths
-- 
2.11.0.209.gda91e66374.dirty

