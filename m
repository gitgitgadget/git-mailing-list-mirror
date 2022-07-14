Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9CBC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiGNRob (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240403AbiGNRo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 13:44:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D073E186E7
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u9so3212932oiv.12
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=u9kkIWUTw8DSDAEJ14lLdrgdrZaTmyQ7acSDoNs44Gk=;
        b=Mp6TfQhgOLr6FCDOj+5SSWg84NFhOECVucroLlw3WsKhFnhaO6gmX4r/pm1pjmMua0
         /H0tIDWGKbmDE5PGt2bDBYmlKWrHAB39iriERxSX+0Cb+T3K0ZXfrhBiYk1HEshE46M5
         tLZ9krpVt5oWXiALz053otzdn7ElOxrSCN2//XTCTTp6YLc4v4CUbxzClLHB8jvNKc7x
         jncKD6ccRWvWEAaxc6cYxdEpECiImHcJ+HS85dEpQZmOllB9lbspl473gqdrW6r/C3TK
         TOBjuOugnPDtw/OM+HltfT0ciwE5hdjK44rI2OtsJMlYDCej0akxjqhn/VhjDNXaefVM
         wTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9kkIWUTw8DSDAEJ14lLdrgdrZaTmyQ7acSDoNs44Gk=;
        b=WPZVBPTsboFximfCh7r/d+b+EGT7Ygt9HTwe4beXNzbe3BiaFuh3Azmy+tSkbOvLWm
         Di0+yxlGwkApKAdCp3I1klTLXEZkcH/8iiOhX5LtZQnjUgs2/sD/iKcLNx6hlrSpWE8X
         9kTI9Qbg0gEBV3Z18n19KyAH5S/+hn8QPivX5PjTIK8LtJklQxZT+OFM+eTqHG8X/s9J
         Hq9YRu1j1mpwW+8Frm0zUbauF/Nvjn90+lIhQ3y5z1pZaubf7rk388enegdzD4UQIXgc
         FXDl8LyeqfgzanrIob6O66sTW5eL9X9Q2Bo9mrxqB7Y7G+EJHMn2P0b+SCt8OEvowQ5D
         8Zkw==
X-Gm-Message-State: AJIora/iIBLXh/FyQBDlRxhNGAjiIm1mGrotVuhuke7bXbRykZifX1Cm
        dM3W6Ud22i9iEnDNwiK5bZO10patI34TlQ==
X-Google-Smtp-Source: AGRyM1u0Gsm9myoGQo3xlYOwpFpH1NnzbnpMy/f/cImvzeQh3Rgcdhc+MsXAhzJ5Nt+c/F7FN4gfkA==
X-Received: by 2002:a05:6808:1a26:b0:33a:11da:196 with SMTP id bk38-20020a0568081a2600b0033a11da0196mr7547797oib.185.1657820660702;
        Thu, 14 Jul 2022 10:44:20 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id bx17-20020a056830601100b0061c5ea08b2bsm906304otb.77.2022.07.14.10.44.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:44:20 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] doc: notes: unify configuration variables definitions
Date:   Thu, 14 Jul 2022 14:44:04 -0300
Message-Id: <d39e826756e79ce7fe270175ad0d5ae523528af9.1657819649.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657819649.git.matheus.bernardino@usp.br>
References: <cover.1657819649.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unify duplicated configuration descriptions from git-notes.txt and
config.txt in order to facilitate maintenance and update. There are some
discrepancies between these two files: git-notes.txt received two
updates that were not made in config.txt: see 66c4c32
("Documentation/notes: simplify treatment of default display refs",
2010-05-08) and c5ce183 ("Documentation/notes: clean up description of
rewriting configuration", 2010-05-08 ). And there was also an update to
config.txt not propagated to git-notes.txt: see 2b4aa89 ("Documentation:
basic configuration of notes.rewriteRef", 2011-09-13). Let's make sure
to include all these three updates in the unified version.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/notes.txt | 62 ++++++++++++++++------------------
 Documentation/git-notes.txt    | 54 ++---------------------------
 2 files changed, 31 insertions(+), 85 deletions(-)

diff --git a/Documentation/config/notes.txt b/Documentation/config/notes.txt
index aeef56d49a..552b340987 100644
--- a/Documentation/config/notes.txt
+++ b/Documentation/config/notes.txt
@@ -2,58 +2,54 @@ notes.mergeStrategy::
 	Which merge strategy to choose by default when resolving notes
 	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
 	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
-	section of linkgit:git-notes[1] for more information on each strategy.
+	section
+ifdef::git-notes[above]
+ifndef::git-notes[of linkgit:git-notes[1]]
+	for more information on each strategy.
 
 notes.<name>.mergeStrategy::
 	Which merge strategy to choose when doing a notes merge into
 	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section in
-	linkgit:git-notes[1] for more information on the available strategies.
+	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section
+ifdef::git-notes[above]
+ifndef::git-notes[in linkgit:git-notes[1]]
+	for more information on the available strategies.
 
 notes.displayRef::
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
+	Which ref (or refs, if a glob or specified more than once), in
+	addition to the default set by `core.notesRef` or
+	`GIT_NOTES_REF`, to read notes from when showing commit
+	messages with the 'git log' family of commands.
+	This setting can be overridden on the command line or by the
+	`GIT_NOTES_DISPLAY_REF` environment variable.
+	See linkgit:git-log[1].
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	`rebase`), if this variable is `false`, git will not copy
+	notes from the original to the rewritten commit.  Defaults to
+	`true`.  See also "`notes.rewriteRef`" below.
++
+This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
+environment variable.
 
 notes.rewriteMode::
-	When copying notes during a rewrite (see the
-	"notes.rewrite.<command>" option), determines what to do if
-	the target commit already has a note.  Must be one of
-	`overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
-	Defaults to `concatenate`.
+	When copying notes during a rewrite, what to do if the target
+	commit already has a note.  Must be one of `overwrite`,
+	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
+	`concatenate`.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
 
 notes.rewriteRef::
 	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  The ref may be a
-	glob, in which case notes in all matching refs will be copied.
-	You may also specify this configuration several times.
+	qualified) ref whose notes should be copied.  May be a glob,
+	in which case notes in all matching refs will be copied.  You
+	may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
 enable note rewriting.  Set it to `refs/notes/commits` to enable
 rewriting for the default commit notes.
 +
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
+Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 0a4200674c..79b2c60646 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -316,58 +316,8 @@ core.notesRef::
 	This setting can be overridden through the environment and
 	command line.
 
-notes.mergeStrategy::
-	Which merge strategy to choose by default when resolving notes
-	conflicts.  Must be one of `manual`, `ours`, `theirs`, `union`, or
-	`cat_sort_uniq`.  Defaults to `manual`.  See "NOTES MERGE STRATEGIES"
-	section above for more information on each strategy.
-+
-This setting can be overridden by passing the `--strategy` option.
-
-notes.<name>.mergeStrategy::
-	Which merge strategy to choose when doing a notes merge into
-	refs/notes/<name>.  This overrides the more general
-	"notes.mergeStrategy".  See the "NOTES MERGE STRATEGIES" section above
-	for more information on each available strategy.
-
-notes.displayRef::
-	Which ref (or refs, if a glob or specified more than once), in
-	addition to the default set by `core.notesRef` or
-	`GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the 'git log' family of commands.
-	This setting can be overridden on the command line or by the
-	`GIT_NOTES_DISPLAY_REF` environment variable.
-	See linkgit:git-log[1].
-
-notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`), if this variable is `false`, git will not copy
-	notes from the original to the rewritten commit.  Defaults to
-	`true`.  See also "`notes.rewriteRef`" below.
-+
-This setting can be overridden by the `GIT_NOTES_REWRITE_REF`
-environment variable.
-
-notes.rewriteMode::
-	When copying notes during a rewrite, what to do if the target
-	commit already has a note.  Must be one of `overwrite`,
-	`concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
-	`concatenate`.
-+
-This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
-environment variable.
-
-notes.rewriteRef::
-	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  May be a glob,
-	in which case notes in all matching refs will be copied.  You
-	may also specify this configuration several times.
-+
-Does not have a default value; you must configure this variable to
-enable note rewriting.
-+
-Can be overridden with the `GIT_NOTES_REWRITE_REF` environment variable.
-
+:git-notes: 1
+include::config/notes.txt[]
 
 ENVIRONMENT
 -----------
-- 
2.37.0

