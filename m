Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74F320A26
	for <e@80x24.org>; Fri, 22 Sep 2017 22:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdIVWw5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 18:52:57 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:52813 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbdIVWw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 18:52:56 -0400
Received: by mail-pg0-f49.google.com with SMTP id i195so1296654pgd.9
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 15:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BAYm2skkYQr0vL5jmria7WKAnEm8fRQeIdyDl0AUC40=;
        b=V7uBv61dXnsC8i/kL1Sn1l5f7y37dTq3zVn/p8jB1jvAaGbEOZ00FubNCOaXXKeFE5
         IUvmVdL3EmLd8S6JrSXU7rSudEZXzGQs0BC9jw7ti0N2o6vPlDQYY1z2crXQ9FIamHlL
         EKdwr7SfolCowerGmp5Gv5XWThvRhWrveV74+mJ41XVnb/c3eFFXBjzfdEiPuTUKwolv
         bd03nmiPSyk3Eia1KBxgb4CXba1LdhN0AZsOjLszswS2NHxXXUr+Qjj/logEyHUvbNr/
         NHOKUR5uiVvodsIofFktCUB5cI/sx/ASShwmZevaL1XCSXRDqZ/ikCgNryUjqbf8P5w/
         gY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BAYm2skkYQr0vL5jmria7WKAnEm8fRQeIdyDl0AUC40=;
        b=oJv1+xdRpGUymwXBbQnIFt7r/GLmm1NTy55BEvxX6J/QMHFdcY5GW7q1/b5JS9deez
         Kb9osoudpwZ+GNo4QEEwLDLgPfmcZEovhrGU4Or5Eocks5FvAEWDl4Zhmp1LypB7YJ6q
         GLE26WKGFv2hwK/4GJzqjqkkAXRIkm5h8FAkMBYU+JjaVAzqsvEqw7Skx2QpwwHD1z26
         fo1yz1FsNPTrREqr1we+YCFgzF5jikYRUnNLlPEMZptcqaom5prOYo46/rGGBP6QVxmi
         872iYX1qVM29ImnO/CHOsx22R3h586yWMbC8feAe8gcDtlIoPlc1XPiq77TEF21YIwO0
         P98g==
X-Gm-Message-State: AHPjjUitymgt/K7j1xA69g92ipUeDlOYGhv/XVeC3NexbCfJuuPkGvHl
        NuTKOBTzliU42C8M+rR0JicR5g==
X-Google-Smtp-Source: AOwi7QDqnaZHjtWfT5EKkK2lkU6mpzSt0wtDsu1lqDC6+sY2uHrsFQLnXfJjyGDCN+v+4rBjLxpcIQ==
X-Received: by 10.99.96.10 with SMTP id u10mr569370pgb.70.1506120776125;
        Fri, 22 Sep 2017 15:52:56 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:d91e:db02:7f11:b424])
        by smtp.gmail.com with ESMTPSA id c7sm1061004pfc.55.2017.09.22.15.52.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 15:52:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCHv2] Documentation/config: clarify the meaning of submodule.<name>.update
Date:   Fri, 22 Sep 2017 15:52:50 -0700
Message-Id: <20170922225250.19705-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <20170922213740.GL27425@aiede.mtv.corp.google.com>
References: <20170922213740.GL27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With more commands (that potentially change a submodule) paying attention
to submodules as well as the recent discussion[1] on
submodule.<name>.update, let's spell out that submodule.<name>.update
is strictly to be used for configuring the "submodule update" command
and not to be obeyed by other commands.

These other commands usually have a strict meaning of what they should
do (i.e. checkout, reset, rebase, merge) as well as have their name
overlapping with the modes possible for submodule.<name>.update.

[1] https://public-inbox.org/git/4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com/
    submodule.<name>.update was set to "none", triggering unexpected
    behavior as the submodule was thought to never be touched.
    However a newer version of Git taught 'git pull --rebase' to also
    populate and rebase submodules if they were active.
    The newer options such as submodule.active and command specific
    flags would not have triggered unexpected behavior.

Reported-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

Jonathan writes:
> You'll want to update Documentation/gitmodules.txt, too.

No. /grumpycat

It should already be fine, as I read it as if it is only relevant to 
"git submodule update" there, already:

  submodule.<name>.update::
	Defines the default update procedure for the named submodule,
	i.e. how the submodule is updated by "git submodule update"
	command in the superproject. This is only used by `git
	submodule init` to initialize the configuration variable of
	the same name. Allowed values here are 'checkout', 'rebase',
	'merge' or 'none'. See description of 'update' command in
	linkgit:git-submodule[1] for their meaning. Note that the
	'!command' form is intentionally ignored here for security
	reasons.
 

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dc4e3f58a2..1ac0ae6adb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3085,10 +3085,14 @@ submodule.<name>.url::
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
-	The default update procedure for a submodule. This variable
-	is populated by `git submodule init` from the
-	linkgit:gitmodules[5] file. See description of 'update'
-	command in linkgit:git-submodule[1].
+	The method by which a submodule is updated by 'git submodule update',
+	which is the only affected command, others such as
+	'git checkout --recurse-submodules' are unaffected. It exists for
+	historical reasons, when 'git submodule' was the only command to
+	interact with submodules; settings like `submodule.active`
+	and `pull.rebase` are more specific. It is populated by
+	`git submodule init` from the linkgit:gitmodules[5] file.
+	See description of 'update' command in linkgit:git-submodule[1].
 
 submodule.<name>.branch::
 	The remote branch name for a submodule, used by `git submodule
-- 
2.14.0.rc0.3.g6c2e499285

