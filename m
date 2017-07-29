Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B7A2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdG2WZI (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:25:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36092 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbdG2WZG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:25:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id y129so26938754pgy.3
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QxqHKvbA9jtJFS3GTg3zDWjTzWsZYn6q0Nz8ZfCJ88=;
        b=rLBAJwxEouhAei/wVl/zVXePphRzBNG8+V0qlOXYEw5bC4z01V9WHwbiZfQIRwd+/B
         H+7dFFyqEkCbb4ABuKcY5lXwVvoI+q++PEx7K53KABaxpPvz+FjFdKIQRjaPi29aEZMA
         iLCKAvcGbEceMQAuULq4eiOOM00ABYReKAPzIrrAdmshjZFnujIETa2UYuS4nIXpIkGq
         3zTr2PJPvPfST/n7cq6k5/yE6YnnfHJvie6BypD4/EB8vVjUf6mqoZiL58303mzvP8So
         lY7k9O+cfZwxt5lKeCyZ00jbIRFxL6q8/k+VeKo8lL5z/1ss7Z/D8ks49MXA3xOZ1YiG
         CBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QxqHKvbA9jtJFS3GTg3zDWjTzWsZYn6q0Nz8ZfCJ88=;
        b=QxNz623TRaprgVDKKIM4Re/dqRX7ax/rggeJPbaAei5PY+LF/0+DoPovyR+uWPoioW
         9Opq6b8wpYJ24SdQhM7MIsZjlb5EZLsCS/qZugU6+lQDmhpd4Z0/yc17HUhsuNnC5MGr
         h0yhKqCQJYEjsqJYywg3Ah5HmRI4s6slT83nb6lvvsJ69dQB1Jg3EH5sUBA6hgRX4E/q
         B2yysxdCHZkgAoYfxk637cjzyIMf7FIYp9LEn7c/WgwXkjC8/ZHR6JMdvt+9THaeHJjz
         3qkWT+STCDApToyjDnvXP5eINHUs+f6WyzvR8DX6O85GmNtWFBC17dINNNpxtjfSVRjo
         tabg==
X-Gm-Message-State: AIVw1130EfPwPCcgTkaCBo7AxJX9q5gORH4vxfjfrFYvMov+y2h13bty
        JZ0vK7xXe+/hr7wBVuo=
X-Received: by 10.101.91.15 with SMTP id y15mr11463541pgq.88.1501367105466;
        Sat, 29 Jul 2017 15:25:05 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:25:04 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 10/13] submodule foreach: document '$sm_path' instead of '$path'
Date:   Sun, 30 Jul 2017 03:53:58 +0530
Message-Id: <20170729222401.12381-11-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This patch is same as its previous version.
Although here I'll like to add a point that we aim to slowly drop the support
of the variable 'path'.

 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..a23baef62 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,14 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the superproject,
+	$sha1 is the commit as recorded in the superproject, and
+	$toplevel is the absolute path to the top-level of the superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.13.0

