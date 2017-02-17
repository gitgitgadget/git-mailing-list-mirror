Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_DBL_ABUSE_BOTCC shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7556E201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 23:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964930AbdBQXhP (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 18:37:15 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36050 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964872AbdBQXhM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 18:37:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so4938078wmd.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JefNlinx4hTyEXJY5G6B8ay50NM5X9ALOM3yBlIK2qc=;
        b=Fagp6bn1Y77x+Yuy6rsDlZRtHsBAkP7voJK1/mknWu9mXA9rMKS2J8N1xjo/VBece+
         Rw0jMWZQx094LLXuCditRYnQHxJVadhclBBssrFhtxAl/c8XIhtIxh/IbU/k8TpTuW4R
         mueFB53cvD8ShG0vpgz8MV0qERmObm5/+lfMNMVmnlD9CbOAAQAM0NcEuK65nEPTqPiM
         uuWqUr+yU5cluyzfV+J622v8EqL0YjOvpQipX3VjtVOiYu3ac2ABtjHl26vIRgQkD5ZS
         OeNZcc3xiYMYpCT03+Rco/fUWzW7Cn9Ojp07/RKa+qj1QNZWSqSwX+RCwppjx6jxujcu
         scbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JefNlinx4hTyEXJY5G6B8ay50NM5X9ALOM3yBlIK2qc=;
        b=EX57TRtJujIqB8LC2ut/X/XzCm449qmG+PCfxpEsyXp2nVeYVpYbpP8VO4z0vIYH+Y
         WEo7XrNRPeLWbzG5q6etZLY6zqTOAUCO5S4XC//ltwxRqY3RZeCSCj2xqwM2pTS+OH6Y
         o0zdkFspfvFXg5yHVey10iZpowSLg3j0lTD7ZJeyM7bKASfpPQUOPdM48iVU70TGQzfA
         hcgKe/C4a0zV1admWRT8HKLn83kpDNuNunXdFyFz1oCcSKZ1Tq3qSshlsysKCOqSDXLh
         xtsHLmAn2za+gdl8vwlaotx4L2lzHjkEgy0AZLYXWnr2CRxmkO9AtI945hLm6sSqgASC
         R1Bg==
X-Gm-Message-State: AMke39mQLPHvie3gHoFfh9+SCW5fYYc4NoabEuUz/s9WrtFOgNoIJ1YWqgX90VY7rlnZOg==
X-Received: by 10.28.1.213 with SMTP id 204mr5810905wmb.70.1487374626177;
        Fri, 17 Feb 2017 15:37:06 -0800 (PST)
Received: from localhost.localdomain (2a02-8420-6e4a-3c00-8e4d-cd7f-8556-25c4.rev.sfr.net. [2a02:8420:6e4a:3c00:8e4d:cd7f:8556:25c4])
        by smtp.gmail.com with ESMTPSA id b10sm3408871wmi.34.2017.02.17.15.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 15:37:05 -0800 (PST)
From:   "=?UTF-8?q?Gr=C3=A9goire=20Paris?=" 
        <gregoire.paris.greg0ire@gmail.com>
X-Google-Original-From: =?UTF-8?q?Gr=C3=A9goire=20Paris?= <postmaster@greg0ire.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Gr=C3=A9goire=20Paris?= <postmaster@greg0ire.fr>
Subject: [PATCH] Document dotfiles exclusion on template copy
Date:   Sat, 18 Feb 2017 00:37:00 +0100
Message-Id: <20170217233700.14643-1-postmaster@greg0ire.fr>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since there is no dotfile in the default template directory, there was
no point in making the check for . or .. more accurate when copying. Now
that you can customize the template directory, it would make sense, but
it's actually a good thing to at this because you would not want to have
your git directory copied in every git directory that is created should
you decide to put your template directory under version control. Plus, it
might be used as a feature by people who would want to exclude some
files.

Signed-off-by: Grégoire Paris <postmaster@greg0ire.fr>
---
Here is a better version.
 Documentation/git-init.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 9d27197..3c5a67f 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -116,8 +116,8 @@ does not exist, it will be created.
 TEMPLATE DIRECTORY
 ------------------
 
-The template directory contains files and directories that will be copied to
-the `$GIT_DIR` after it is created.
+Files and directories in the template directory whose name do not start with a
+dot will be copied to the `$GIT_DIR` after it is created.
 
 The template directory will be one of the following (in order):
 
-- 
2.9.3

