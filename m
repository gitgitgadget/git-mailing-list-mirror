Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6562F1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeJTUuW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34860 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeJTUuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so33124569ljj.2
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JjeEH7TfqW4rFXhWGewuJVvx95aQ9II2y9kCKBB+QIo=;
        b=jV1sjeWLnwnJfVc97m135lodHpoxoW36GXfEhGLDueo76m8BFhSDYzjDfjjb1yDxzz
         8GMDHUHj5XIQh72oUk5Ok69Bt6KFgMvMSEMdqcvF39g6IFaRodpEsCW5VxUC9WvD4Mr0
         61PtELT9FYFZm4ULvnoTF7V8V65DRsWfN8TgzP8gZ2sgeAwbNb8Q+sCSKR4wLGnoZFXb
         z45F1GMyipyWidoDlFL5417VzD30Fk087yrHqV4gzXH+/MrNEOlUENnTSQR9yD2FswkE
         +FcKQpWoNVKbGjf+lO30B9Kyy6g5jvQGdP60YUwfvhX3Eh3Xnt9vxtBL4BY7ofON3+qW
         VUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JjeEH7TfqW4rFXhWGewuJVvx95aQ9II2y9kCKBB+QIo=;
        b=RDQf3ZtSV35PCkGf3Pgvszj3qu2sXSJkq5y6VpJQAFxuGZnvFnOriO2BtebVFaSbhk
         gpxjlzpUt40fyN50fYc9RGMWcmUmGXFbiX8MUTy6M/9ZcDr/sQhfpPwmFCHbLzN4/iRb
         TyLUsbz+vZpUbvE/mGuH78Kf6tqaK2j2fgXCo3LGVfXoeQGhhGZB09h1bQYto8pjbyn+
         libIJu9nfa5+A0PBB4cCPXE9x37vWcRn4shLHnEvgeyxPKYhEf+m3EmyXNnbjIti2xvI
         TWs18QEtpTdZZc7MTa3z80Ja2fVrucX0XiyktsWg/EaESiPZrr3G0WgntuZpaguYx+Lg
         rKDg==
X-Gm-Message-State: ABuFfojrLFQb0fdIkkBtmzf7xxKlxvL9Tm9EUwY2l/e+8FnRYiTFVNm2
        RKCAXeE8CJXuhJllhBIW+8fl4aHo
X-Google-Smtp-Source: ACcGV62KUm20hNlhzpun+4VBYSaNVPmFelsx+nbb1raVRIbHvzIl5K+nJwbAG98eEyHbecnjDTtw3g==
X-Received: by 2002:a2e:84c5:: with SMTP id q5-v6mr13590845ljh.65.1540039199280;
        Sat, 20 Oct 2018 05:39:59 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 38/59] config.txt: move notes.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:27 +0200
Message-Id: <20181020123848.2785-39-pclouds@gmail.com>
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
 Documentation/config.txt       | 60 +---------------------------------
 Documentation/notes-config.txt | 59 +++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/notes-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9acc42e3c2..d1de7ccc89 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -626,65 +626,7 @@ include::merge-config.txt[]
 
 include::mergetool-config.txt[]
 
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
+include::notes-config.txt[]
 
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
diff --git a/Documentation/notes-config.txt b/Documentation/notes-config.txt
new file mode 100644
index 0000000000..aeef56d49a
--- /dev/null
+++ b/Documentation/notes-config.txt
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

