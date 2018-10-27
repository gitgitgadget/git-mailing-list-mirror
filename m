Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E509E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeJ0PEt (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43719 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeJ0PEs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so1844433lja.10
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TrES8Ilm1hQEnz+QmAgztK6hW2lE0IPFVSqQHOgnd4=;
        b=FskiPs+c1kXtH0ncZsWFc6xu0oYLzTip+K5f/2BTEx8n6JyyYYhTPKOFT1xJt2hIP0
         rLUffHZ0KuP+DcO4RgJhJ//YzSxLEHYuar2o3QYVLfA8SqiWHmKJHpl6RuEXhaYJsyTh
         Ze/IIMfRAzBqP3NmK2prgMVBNMFL2bM/myqNZeyhPstllnvM8ED29Xs3FjbzHx9ihQvW
         m7dBr+p4fqBnnA+TNWDebOC0IT3aP3q6s8OJrsQv0JyyfvYKzpcufgka4V+1pIMvE0mU
         77jMdpvHD2i/ZrMH5pzMMCJHw4X4UYZPuX0geRnaEUJW76Tc7A3OeP2NdQJzOcSl3ANL
         P8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TrES8Ilm1hQEnz+QmAgztK6hW2lE0IPFVSqQHOgnd4=;
        b=dmM/aB3vcVDfierGN3WKaeKCoxRdYOKNWksOfWDBm9E9sci2irE6ZaXB8O/ms3Ad3a
         xI116LM5bNlwwfq2LDOngZrXK8OoUiVPvnauNZqTXcGMe6ffhHXU7RylTYNsjSOpRoNL
         CSkaJuSQNlpdFPrJZnMq+erJkk2b8xVOXcsplKbn2ofG6+gFTMchfQgDaESOTB7xVwuG
         sh6qiXqeD/bSjvJ71RXsJGf/ZQ7yhV11fXT0+whvqmODerwNg4E6uP5ynB4qBBcWojPO
         13BZL/RBOf7sn2NUrSYWnzhLbe7+RPMbpxXeOBMt0FkzFsHhNlxKlGYclC2VB/HaqM5U
         AZTw==
X-Gm-Message-State: AGRZ1gLRJy10xyJL8sK4LPm33NeUCzGLMVIGEwACu6Gw1oGX873YZe6D
        LQLRTtBc8pRdzhCK2Kh4Fcb2xm9W
X-Google-Smtp-Source: AJdET5dEP1GFdmrDPkri7WvD+kmIpB8jUL2ILGcmtE96jaI4nrzAAfrYMBpWHUtvGyvrJuu/LidDWw==
X-Received: by 2002:a2e:a202:: with SMTP id h2-v6mr3633402ljm.143.1540621491975;
        Fri, 26 Oct 2018 23:24:51 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:51 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 48/78] config.txt: move notes.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:21 +0200
Message-Id: <20181027062351.30446-49-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt       | 60 +---------------------------------
 Documentation/config/notes.txt | 59 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/config/notes.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 35a6b4e0e0..babe2e5682 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -375,65 +375,7 @@ include::config/merge.txt[]
 
 include::config/mergetool.txt[]
 
-notes.mergeStrategy::
-	Which merge strategy to choose by default when resolving notes
-	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
-	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
-	section of linkgit:git-notes[1] for more information on each strategy.
-
-notes.<name>.mergeStrategy::
-	Which merge strategy to choose when doing a notes merge into
-	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
-	linkgit:git-notes[1] for more information on the available strategies.
-
-notes.displayRef::
-	The (fully qualified) refname from which to show notes when
-	showing commit messages.  The value of this variable can be set
-	to a glob, in which case notes from all matching refs will be
-	shown.  You may also specify this configuration variable
-	several times.  A warning will be issued for refs that do not
-	exist, but a glob that does not match any refs is silently
-	ignored.
-+
-This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
-+
-The effective value of "core.notesRef" (possibly overridden by
-GIT_NOTES_REF) is also implicitly added to the list of refs to be
-displayed.
-
-notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
-
-notes.rewriteMode::
-	When copying notes during a rewrite (see the
-	"notes.rewrite.<command>" option), determines what to do if
-	the target commit already has a note.  Must be one of
-	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
-	Defaults to `concatenate`.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
-environment variable.
-
-notes.rewriteRef::
-	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  The ref may be a
-	glob, in which case notes in all matching refs will be copied.
-	You may also specify this configuration several times.
-+
-Does not have a default value; you must configure this variable to
-enable note rewriting.  Set it to `refs/notes/commits` to enable
-rewriting for the default commit notes.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
+include::config/notes.txt[]
 
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
new file mode 100644
index 0000000000..aeef56d49a
--- /dev/null
+++ b/Documentation/config/notes.txt
@@ -0,0 +1,59 @@
+notes.mergeStrategy::
+	Which merge strategy to choose by default when resolving notes
+	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
+	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
+	section of linkgit:git-notes[1] for more information on each strategy.
+
+notes.<name>.mergeStrategy::
+	Which merge strategy to choose when doing a notes merge into
+	refs/notes/<name>.  This overrides the more general
+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
+	linkgit:git-notes[1] for more information on the available strategies.
+
+notes.displayRef::
+	The (fully qualified) refname from which to show notes when
+	showing commit messages.  The value of this variable can be set
+	to a glob, in which case notes from all matching refs will be
+	shown.  You may also specify this configuration variable
+	several times.  A warning will be issued for refs that do not
+	exist, but a glob that does not match any refs is silently
+	ignored.
++
+This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
++
+The effective value of "core.notesRef" (possibly overridden by
+GIT_NOTES_REF) is also implicitly added to the list of refs to be
+displayed.
+
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`) and this variable is set to `true`, Git
+	automatically copies your notes from the original to the
+	rewritten commit.  Defaults to `true`, but see
+	"notes.rewriteRef" below.
+
+notes.rewriteMode::
+	When copying notes during a rewrite (see the
+	"notes.rewrite.<command>" option), determines what to do if
+	the target commit already has a note.  Must be one of
+	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
+	Defaults to `concatenate`.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
+environment variable.
+
+notes.rewriteRef::
+	When copying notes during a rewrite, specifies the (fully
+	qualified) ref whose notes should be copied.  The ref may be a
+	glob, in which case notes in all matching refs will be copied.
+	You may also specify this configuration several times.
++
+Does not have a default value; you must configure this variable to
+enable note rewriting.  Set it to `refs/notes/commits` to enable
+rewriting for the default commit notes.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
+environment variable, which must be a colon separated list of refs or
+globs.
-- 
2.19.1.647.g708186aaf9

