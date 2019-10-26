Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2B21F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 00:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfJZAyH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 20:54:07 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37236 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJZAyH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 20:54:07 -0400
Received: by mail-pf1-f202.google.com with SMTP id p2so3301845pff.4
        for <git@vger.kernel.org>; Fri, 25 Oct 2019 17:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y3Fiac5txPHVx9xTV1cDzfoXLO4V6rxVog7fuQtH0tg=;
        b=UcwIaaLLmor0+bKZzNfOSpX9pEuWlFXUMSlyGyM3E88FrvW693pwP31yTXBTAgPD9Q
         KqM18TXcNf5B3yHf6vAJFgbVVqpALW2GxKAOPsyw2QPS0Rm6vyQ9w/Pbh8eA0u0cnEgd
         H9kUTqojG1cCHMUmq/1DohAT2mIS+EvATasN/z9TNQqsifQ6+4S/FPo9qrG5dj5EqSkl
         gmJpLU/kJJyXSU49f7veK4Btze3YGRopqlCJMMz3HT8LmQdWU4blTEnSGEAlchWThxRC
         9+jIyYxorYb0NQW/ix9w18QSTdXVPKVS5yrSGG3oxhWZ9AJ/vzrKxc9BYz65L/ZNQ68u
         MXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y3Fiac5txPHVx9xTV1cDzfoXLO4V6rxVog7fuQtH0tg=;
        b=Yytj7+GZfqnoNDtJYzxLAsTPYEa0nhMGmdj9IQ29hbUOv57Go7KEBVmIN3H+dhAefG
         QCCooQWQtK/DbEEnnoFcYmIu3MUpRtbSgqIYgED9WhBI7Fh/y+IlbMxL7rYXzSSH8c0s
         AVu3U2dhHib1b4Dbwxmo583iupApUyRurBSw4wlC+NzEYhyWBCCyQHiB5PwJMcfvwZJ3
         gmcVy+v8bBHREhE2r6etQsoULFXiwVyzxYTH+4pP3l5w+PCjTcWxJLhz6joMuWvuJdGw
         aUbcgX1mSVb26wMj95UzytmbzgmaOGjrGUBnfx/uHsoq8NitB9QOWGcggkOLIAUTlTAA
         Em6g==
X-Gm-Message-State: APjAAAWj3j36QYYy2A+DmOhM30hD+O1w9Mp8cCd9+1SJBpLZMVTMrblW
        UX5SsCspQ1snkJjgqtS+vymOwOKuKQVgLY+JfbcnFr3DmBb5e329ul5i7pn2pecd34vp1+7cZcI
        0YETDN3aX0mL40P6twAxkSWWmC1ke+byoKODQLBbQsL340Go+AMLFrVUxpu/l3+WxvuQGpWeXkg
        ==
X-Google-Smtp-Source: APXvYqwrJP9TATtHZPNIWjCGXJvSqnLjv57/w+u8z60Gpe8SrrAKPpJ+tS1pfeDAP0igJy0vvvlZ5lBw6hvxv1wMH3g=
X-Received: by 2002:a63:2c53:: with SMTP id s80mr7459390pgs.377.1572051244482;
 Fri, 25 Oct 2019 17:54:04 -0700 (PDT)
Date:   Fri, 25 Oct 2019 17:51:58 -0700
In-Reply-To: <20191026005159.98405-1-emilyshaffer@google.com>
Message-Id: <20191026005159.98405-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191026005159.98405-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH 2/3] myfirstcontrib: add dependency installation step
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indicate that the user needs some dependencies before the build will run
happily on their machine; this dependency list doesn't seem to be made
clear anywhere else in the project documentation. Then, so the user can
be certain any build failures are due to their code and not their
environment, perform a build on a clean checkout of 'master'. Also, move
the note about build parallelization up here, so that it appears next to
the very first build invocation in the tutorial.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/MyFirstContribution.txt | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 12b7256454..b8ffeda07e 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -38,6 +38,30 @@ $ git clone https://github.com/git/git git
 $ cd git
 ----
 
+[[dependencies]]
+=== Installing Dependencies
+
+To build Git from source, you need to have a handful of dependencies installed
+on your system. For a hint of what's needed, you can take a look at
+`ci/install-dependencies.sh`.
+
+To install the dependencies needed for a basic build on Linux, run something
+like this (or replace `apt` with your distribution's package manager of choice):
+
+----
+# apt install libssl-dev zlib1g-dev libcurl4-gnutls-dev libexpat1-dev
+----
+
+Make sure that your environment has everything you need by building your brand
+new clone of Git from the above step:
+
+----
+$ make
+----
+
+NOTE: The Git build is parallelizable. `-j#` is not included above but you can
+use it as you prefer, here and elsewhere.
+
 [[identify-problem]]
 === Identify Problem to Solve
 
@@ -138,9 +162,6 @@ NOTE: When you are developing the Git project, it's preferred that you use the
 `DEVELOPER` flag; if there's some reason it doesn't work for you, you can turn
 it off, but it's a good idea to mention the problem to the mailing list.
 
-NOTE: The Git build is parallelizable. `-j#` is not included above but you can
-use it as you prefer, here and elsewhere.
-
 Great, now your new command builds happily on its own. But nobody invokes it.
 Let's change that.
 
-- 
2.24.0.rc0.303.g954a862665-goog

