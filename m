Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA231F403
	for <e@80x24.org>; Tue,  5 Jun 2018 08:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeFEI3H (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 04:29:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42022 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFEI3F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 04:29:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so1384573wrk.9
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cWDKFkRdbIg1t60b0/0qfEeHwcTEp8Qx4M+s7TxtCNk=;
        b=LVadjjNnbiC8WF3QbKyVPUzg2JdMydtDskEb5KJeHWvTHkQChbcfqtG9gHM4MDZJVW
         vnObVHr/XAGHG6VDZUgU6DR5ZOYEATNcv+G+tqI6h6sYeXU9eKpu0iS3Hjtd1vNfavTi
         cMJVdzwzbNc8Mz1urqifLpSUF6TBMCmT4pgEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cWDKFkRdbIg1t60b0/0qfEeHwcTEp8Qx4M+s7TxtCNk=;
        b=lIX4RLCYlBL7KDO1xJxa7PY6jMQ+ucoGfZMFFsB0VclqmqWt8p/CRWkHXU9t93yxrL
         fO6jSVNMYcAQ61lGsPD5a3vFDrMyegLaCFdooiQgfJSpx2f31R1jWTBiVwACCE0t9BOT
         9tRGBZfMvo+T+jtyMvxm06X1bxSpEBXVMyl9NTjPz/olo3hXayG+wfbPMi7NESTUlMZf
         awvezduGMNNeDA7RPPYxnOuB9HgPHEKvisj6OD5zJR85frhU4vIhOi0KdrR1FfaQ2ncU
         LtulosLduEAAlhrmV7Ry25qWixUBOAunFOmEkEG/IRb0reeUYriQZDlVY8MtgKrAX+wu
         zFUQ==
X-Gm-Message-State: ALKqPwd1gpuYNhJf/4gxf0q1DLiJuCvo1SR3kAlpPeM9h2xCjETnsHIW
        ssNJbxgSjhta6sE+eqts5YN10KrY
X-Google-Smtp-Source: ADUXVKKidzrnqkq2Ss77/9jet3JujtjcOcx0RbQQsu+k+QbqWNpaboAuh6StSoRvWOyIBWbfmtQtQg==
X-Received: by 2002:adf:f344:: with SMTP id e4-v6mr15758319wrp.161.1528187343848;
        Tue, 05 Jun 2018 01:29:03 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id u3-v6sm25988533wrm.60.2018.06.05.01.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 01:29:03 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 1/2] git-p4: disable-rebase: allow setting this via configuration
Date:   Tue,  5 Jun 2018 09:28:53 +0100
Message-Id: <20180605082854.17090-2-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180605082854.17090-1-luke@diamand.org>
References: <20180605082854.17090-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This just lets you set the --disable-rebase option with the
git configuration options git-p4.disableRebase. If you're
using this option, you probably want to set it all the time
for a given repo.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt | 5 ++++-
 git-p4.py                | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index e8452528fc..3d83842e47 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -367,7 +367,7 @@ These options can be used to modify 'git p4 submit' behavior.
 
 --disable-rebase::
     Disable the automatic rebase after all commits have been successfully
-    submitted.
+    submitted. Can also be set with git-p4.disableRebase.
 
 Rebase options
 ~~~~~~~~~~~~~~
@@ -690,6 +690,9 @@ git-p4.conflict::
 	Specify submit behavior when a conflict with p4 is found, as per
 	--conflict.  The default behavior is 'ask'.
 
+git-p4.disableRebase::
+    Do not rebase the tree against p4/master following a submit.
+
 IMPLEMENTATION DETAILS
 ----------------------
 * Changesets from p4 are imported using Git fast-import.
diff --git a/git-p4.py b/git-p4.py
index c4581d20a6..5ab9421af8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1379,7 +1379,7 @@ def __init__(self):
         self.shelve = False
         self.update_shelve = list()
         self.commit = ""
-        self.disable_rebase = False
+        self.disable_rebase = gitConfigBool("git-p4.disableRebase")
         self.prepare_p4_only = False
         self.conflict_behavior = None
         self.isWindows = (platform.system() == "Windows")
-- 
2.17.0.392.gdeb1a6e9b7

