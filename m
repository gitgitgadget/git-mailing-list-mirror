Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536AF1F576
	for <e@80x24.org>; Thu, 25 Jan 2018 09:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeAYJkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 04:40:42 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45797 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeAYJkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 04:40:39 -0500
Received: by mail-pf0-f195.google.com with SMTP id a88so5368319pfe.12
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTKRKLb0IF7mrk+A76AJWotVMF0vncTBb5jHxPCKUWA=;
        b=onK96Ajx+CTFjzue9bHrp+DeSHrYxcuUv8w5Mh8v14cbWJJnI4f6eoxDx6HjokbTV3
         MG53Ifb1VxHAj/1dDZgdoz//nYTW7rlgC1YhCP2JPuxlz8QJV37g5+G9rTEsmc193b5X
         6V0QifeDCZI2eKreUOuAtk/+9oh5t4KbxxVpCaFIEzoG2+zCXYjg4POXSXvrXkrsqs0X
         NCD2WjqCayCrQcwZus6qkVR5rBXwFcB86sB+iV0+yVslV5+IPAf9lGid7kZLWH7kp/Pi
         iMe0v6pSyzptk8Vqs42i9D54kVmpz9ib4fVlSzfEyEJDRGtlPLhDDFEZM8X41zdFJaUP
         caWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xTKRKLb0IF7mrk+A76AJWotVMF0vncTBb5jHxPCKUWA=;
        b=YTBQevv3wsxjZ7w1utH9z0CQhiXnnOhbcTjb1ijP3qpWt1AnMDSaJw7Z64ZDjdtGPi
         //2o9S/ORlIpdgOM2yFJ3t5nqjYO5pjOnytgnWxot5/z+aLGqjQjv1kXPhMBdgkaZi/N
         5DMtp3GHDmfd1/7Cx6XMgMQEe4IIdNrYd4T+2/aMRNkSBeGSpux9BhIqDKVklI66Pg+E
         KNSD6f8i4vdw/aE/us8GhV0QoRFe6qHj+dfDMxHJWZR0V0plUu+Tm4vAqWgorrlrJJnR
         lVixGYSoBdLU1pYFsgYVwhfi/zjLqv9tfJQSJ3oka58OVxu/2N56cPdnOtkdDzRP6hDq
         jegQ==
X-Gm-Message-State: AKwxytcegBgjTElMOWI4ohKuAoHany4OhN3RWuEa4RolAK2IxlZuN9tZ
        JNoF5YViCzQi7+qRASeoOfGKtw==
X-Google-Smtp-Source: AH8x227QcZJV+nsJH/167ex3DIWw4fYRwYjoKZ+7h3pIvK1qDuZP0SPOIMgD9c/r17DL9Jlxc+a/PQ==
X-Received: by 2002:a17:902:6f08:: with SMTP id w8-v6mr10674232plk.155.1516873239083;
        Thu, 25 Jan 2018 01:40:39 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id f72sm15638106pff.145.2018.01.25.01.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2018 01:40:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Jan 2018 16:40:32 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] merge: support --strategy '?' for git-completion.bash
Date:   Thu, 25 Jan 2018 16:40:31 +0700
Message-Id: <20180125094031.6584-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.0.47.g3d9b0fac3a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bash completion support gets the list of available strategies with a
grep and sed trick which does not work on non-C locale since the anchor
string is translated and it does not cover custom strategies either.

Let's do it a better way and make git-merge provide all available
strategies in machine-readable form.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Another, perhaps better, option is add "git merge --list-strategies".
 It requires some code movement, so I'll try with a simpler approach
 first.

 Documentation/merge-options.txt        | 3 +++
 builtin/merge.c                        | 7 +++++++
 contrib/completion/git-completion.bash | 9 +--------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 3888c3ff85..cd4342844f 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -97,6 +97,9 @@ option can be used to override --squash.
 	If there is no `-s` option, a built-in list of strategies
 	is used instead ('git merge-recursive' when merging a single
 	head, 'git merge-octopus' otherwise).
++
+The special strategy '?' lists all available strategies and exits
+immediately. No merge operation is done.
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/builtin/merge.c b/builtin/merge.c
index 30264cfd7c..a09d04302c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -140,6 +140,13 @@ static struct strategy *get_strategy(const char *name)
 		}
 		exclude_cmds(&main_cmds, &not_strategies);
 	}
+	if (!strcmp(name, "?")) {
+		for (i = 0; i < main_cmds.cnt; i++)
+			puts(main_cmds.names[i]->name);
+		for (i = 0; i < other_cmds.cnt; i++)
+			puts(other_cmds.names[i]->name);
+		exit(0);
+	}
 	if (!is_in_cmdlist(&main_cmds, name) && !is_in_cmdlist(&other_cmds, name)) {
 		fprintf(stderr, _("Could not find merge strategy '%s'.\n"), name);
 		fprintf(stderr, _("Available strategies are:"));
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c5..6d947be858 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -594,14 +594,7 @@ __git_is_configured_remote ()
 
 __git_list_merge_strategies ()
 {
-	git merge -s help 2>&1 |
-	sed -n -e '/[Aa]vailable strategies are: /,/^$/{
-		s/\.$//
-		s/.*://
-		s/^[ 	]*//
-		s/[ 	]*$//
-		p
-	}'
+	git merge --strategy '?'
 }
 
 __git_merge_strategies=
-- 
2.16.0.47.g3d9b0fac3a

