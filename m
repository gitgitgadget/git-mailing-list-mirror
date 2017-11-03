Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E057E20450
	for <e@80x24.org>; Fri,  3 Nov 2017 19:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbdKCTWE (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 15:22:04 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:52645 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdKCTWD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 15:22:03 -0400
Received: by mail-io0-f195.google.com with SMTP id f20so8507631ioj.9
        for <git@vger.kernel.org>; Fri, 03 Nov 2017 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+aL6ph/cWw4hrBxOV7UuR+up7zs/nO7bd93C6RLzw1s=;
        b=kfMepzdJ2s8acrGmO7/eqErH6N8MFNxr0s7xffjRxW2ps6waPNeB3uWuScWvzF7LWi
         XQVMaCGqfG3q5v4ZF2s92QrJRazgoGy9rGg9E+swCaYsDHrdKo9RhREDCbjbwYUHjYGW
         wrWl8knyXIySqRluQ2J/bHL/9vvWl8uxXtGbl4rMB+158S3P3WfIisTF1wviatvrJUEV
         Jllg7w6g3tsAa3JLlrZOsm3doBD+J3WBkUmmx+KbToTCDJ0CQ5jZD7rPNT9saBu0vimF
         OUV5kagqTZFXCD++Hm4chzfBfeP9whLnOESxOIltNp+aLnTDLc8H/bm32tWSgTzAqsH+
         eZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+aL6ph/cWw4hrBxOV7UuR+up7zs/nO7bd93C6RLzw1s=;
        b=H4AXaw6ygB5IwLnzT+f1F8Az3azDJ3U4D2vZTSg2h2qEFuemhDBgnKAcYaxW0L6Xvx
         8VlfftKylXFEH5uLXmgtLWyyyeujjJmTT/Ck5hKL+HLhSZ3VmUICE98cbQP4xMGYk6l1
         01hGe/HpzrTCDUjzwEufwKskUZkOaZAslenhb/hP3QOosOD1tf33n38vxILdD+VLmAUN
         DZQ39dppuDYng7jyv7hbMdUeB0cVmfeselXHZ+OtZA70UFC8FF61kqxKB1HJqTcql/db
         XbgHwU4oYbH/6yWKdgdX9b5gJSChfRjZDWTIw2fVlJWnQwJzu4wVhm52/tsOLc23AKWA
         BZMw==
X-Gm-Message-State: AJaThX4A4r/o1D4fveSar2EhdK7+QIuO7KgQNSbljqsvV4VS9Eva2OGj
        H+wmEPDC+eOObjVelsTv4NVGlA==
X-Google-Smtp-Source: ABhQp+Sq8xTWdUi68p1zugmDk42/xpJxbRhRmDYgsEhmnTKP7LI39hg8x+NQKC2Eul4fLybSakw5YA==
X-Received: by 10.36.200.139 with SMTP id w133mr72876itf.26.1509736922408;
        Fri, 03 Nov 2017 12:22:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d18c:4f4e:b4ae:5b93])
        by smtp.gmail.com with ESMTPSA id 194sm1727151ito.20.2017.11.03.12.22.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Nov 2017 12:22:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: [PATCH] config: document blame configuration
Date:   Fri,  3 Nov 2017 12:21:58 -0700
Message-Id: <20171103192158.1669-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.7.g980e40477f
In-Reply-To: <CAGZ79kZaCwU8S8R-nAzCcV=izpTnsbZsBjJLpoWkid2AF54f9g@mail.gmail.com>
References: <CAGZ79kZaCwU8S8R-nAzCcV=izpTnsbZsBjJLpoWkid2AF54f9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options are currently only referenced by the git-blame man page,
also explain them in git-config, which is the canonical page to
contain all config options.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Now with 'commit object name'.
 Thanks!
 
 Documentation/config.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1ac0ae6adb..9593bfabaa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -949,6 +949,23 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the `--whitespace` option. See linkgit:git-apply[1].
 
+blame.showRoot::
+	Do not treat root commits as boundaries in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.blankBoundary::
+	Show blank commit object name for boundary commits in
+	linkgit:git-blame[1]. This option defaults to false.
+
+blame.showEmail::
+	Show the author email instead of author name in linkgit:git-blame[1].
+	This option defaults to false.
+
+blame.date::
+	Specifies the format used to output dates in linkgit:git-blame[1].
+	If unset the iso format is used. For supported values,
+	see the discussion of the `--date` option at linkgit:git-log[1].
+
 branch.autoSetupMerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
-- 
2.15.0.7.g980e40477f

