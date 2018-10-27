Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A1C1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeJ0PDz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:03:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34995 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbeJ0PDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id o14-v6so3122942ljj.2
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hik3fj9U2ziIFv/gjeD0okCtxQ2COkHG7sR3v0DcC2k=;
        b=eCjd+/BBr7Xw81oO6Dm1B5bsdVlBCzw+UrN3TBqCOJ36w4afzxdhQ7Sau+eH+vQRWG
         2zDoXc2ef59/vrjamr8a7CT/e5dpQlR1+TZdos4hfxa82JQYNqyyHdGyIjGenaqI+id9
         ZLrh9+86HlzPFmIAyJH//u2b4M4jY7QLXjUFYgDimmxQ4HWYr3qIDw8YPS6FVEwrUz2i
         yzlP8PEtS1NRiwrWz4FWS/ozLFlWMFLHZIrCJXgdJIXmMvzO1K7n1J3idY67K77S0Bp0
         4iUDN9iwM63+ORZPfQuXva7rddDa5N1MAD0Yz4rya8vWC1ousbreiF48xhEleKQq8wr5
         r6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hik3fj9U2ziIFv/gjeD0okCtxQ2COkHG7sR3v0DcC2k=;
        b=QScoma7szsF/nLaoid1R+nIIUDUUS78+VTVLqnExPXREDI1MG0t5jYjyNDKLDMcSQO
         JIaoO7tKG5vmKRHe2x8ru9TYY532dA1wAPrPBekZN9Qc0jvtl31MLcudpEyxMfccesOR
         TE3mBlqqlsTPatM2blruqaCy+DRw2yRyowtThK/L8WRror201HSvdGRsh7n2TQqF97P6
         eA6KQb7v8+znZ+pr/pFCOdMJNrslySTe+n1am3NWwvCENv6P/bKVekxWxrb0tlgtyJ8N
         2g6gGERooCHHASNbxht7xd3wvUd/QTiR7j7v17tTDdQBG/qtNPWZfd2zFX7cCWk0dJH8
         KNkA==
X-Gm-Message-State: AGRZ1gKPT5NRqPmDvQF8JV5nvzEtCoIUPJJT/4ZSx12RrzBpxbx7bTXc
        S/0yZRnlD8nXsCbSHQ0/fOQer8Mu
X-Google-Smtp-Source: AJdET5dKR2BTxtihbRHMUu/Xy31/Eve5s2y7Qq2m6F6SvyLyPMTjqtmDO6CICM8XMAaW/no8L49UGg==
X-Received: by 2002:a2e:81d3:: with SMTP id s19-v6mr3687838ljg.138.1540621438505;
        Fri, 26 Oct 2018 23:23:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:23:57 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/78] config.txt: move advice.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:35 +0200
Message-Id: <20181027062351.30446-3-pclouds@gmail.com>
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
 Documentation/config.txt        | 88 +--------------------------------
 Documentation/config/advice.txt | 86 ++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/config/advice.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff2d0190f6..4d2e21b534 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -287,93 +287,7 @@ inventing new variables for use in your own tool, make sure their
 names do not conflict with those that are used by Git itself and
 other popular tools, and describe them in your documentation.
 
-
-advice.*::
-	These variables control various optional help messages designed to
-	aid new users. All 'advice.*' variables default to 'true', and you
-	can tell Git that you do not need help by setting these to 'false':
-+
---
-	pushUpdateRejected::
-		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent',
-		'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', and 'pushNeedsForce'
-		simultaneously.
-	pushNonFFCurrent::
-		Advice shown when linkgit:git-push[1] fails due to a
-		non-fast-forward update to the current branch.
-	pushNonFFMatching::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. you used ':', or
-		specified a refspec that isn't your current branch) and
-		it resulted in a non-fast-forward error.
-	pushAlreadyExists::
-		Shown when linkgit:git-push[1] rejects an update that
-		does not qualify for fast-forwarding (e.g., a tag.)
-	pushFetchFirst::
-		Shown when linkgit:git-push[1] rejects an update that
-		tries to overwrite a remote ref that points at an
-		object we do not have.
-	pushNeedsForce::
-		Shown when linkgit:git-push[1] rejects an update that
-		tries to overwrite a remote ref that points at an
-		object that is not a commit-ish, or make the remote
-		ref point at an object that is not a commit-ish.
-	statusHints::
-		Show directions on how to proceed from the current
-		state in the output of linkgit:git-status[1], in
-		the template shown when writing commit messages in
-		linkgit:git-commit[1], and in the help message shown
-		by linkgit:git-checkout[1] when switching branch.
-	statusUoption::
-		Advise to consider using the `-u` option to linkgit:git-status[1]
-		when the command takes more than 2 seconds to enumerate untracked
-		files.
-	commitBeforeMerge::
-		Advice shown when linkgit:git-merge[1] refuses to
-		merge to avoid overwriting local changes.
-	resetQuiet::
-		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to enumerate unstaged
-		changes after reset.
-	resolveConflict::
-		Advice shown by various commands when conflicts
-		prevent the operation from being performed.
-	implicitIdentity::
-		Advice on how to set your identity configuration when
-		your information is guessed from the system username and
-		domain name.
-	detachedHead::
-		Advice shown when you used linkgit:git-checkout[1] to
-		move to the detach HEAD state, to instruct how to create
-		a local branch after the fact.
-	checkoutAmbiguousRemoteBranchName::
-		Advice shown when the argument to
-		linkgit:git-checkout[1] ambiguously resolves to a
-		remote tracking branch on more than one remote in
-		situations where an unambiguous argument would have
-		otherwise caused a remote-tracking branch to be
-		checked out. See the `checkout.defaultRemote`
-		configuration variable for how to set a given remote
-		to used by default in some situations where this
-		advice would be printed.
-	amWorkDir::
-		Advice that shows the location of the patch file when
-		linkgit:git-am[1] fails to apply it.
-	rmHints::
-		In case of failure in the output of linkgit:git-rm[1],
-		show directions on how to proceed from the current state.
-	addEmbeddedRepo::
-		Advice on what to do when you've accidentally added one
-		git repo inside of another.
-	ignoredHook::
-		Advice shown if a hook is ignored because the hook is not
-		set as executable.
-	waitingForEditor::
-		Print a message to the terminal whenever Git is waiting for
-		editor input from the user.
---
+include::config/advice.txt[]
 
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
new file mode 100644
index 0000000000..57fcd4c862
--- /dev/null
+++ b/Documentation/config/advice.txt
@@ -0,0 +1,86 @@
+advice.*::
+	These variables control various optional help messages designed to
+	aid new users. All 'advice.*' variables default to 'true', and you
+	can tell Git that you do not need help by setting these to 'false':
++
+--
+	pushUpdateRejected::
+		Set this variable to 'false' if you want to disable
+		'pushNonFFCurrent',
+		'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', and 'pushNeedsForce'
+		simultaneously.
+	pushNonFFCurrent::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to the current branch.
+	pushNonFFMatching::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		'matching refs' explicitly (i.e. you used ':', or
+		specified a refspec that isn't your current branch) and
+		it resulted in a non-fast-forward error.
+	pushAlreadyExists::
+		Shown when linkgit:git-push[1] rejects an update that
+		does not qualify for fast-forwarding (e.g., a tag.)
+	pushFetchFirst::
+		Shown when linkgit:git-push[1] rejects an update that
+		tries to overwrite a remote ref that points at an
+		object we do not have.
+	pushNeedsForce::
+		Shown when linkgit:git-push[1] rejects an update that
+		tries to overwrite a remote ref that points at an
+		object that is not a commit-ish, or make the remote
+		ref point at an object that is not a commit-ish.
+	statusHints::
+		Show directions on how to proceed from the current
+		state in the output of linkgit:git-status[1], in
+		the template shown when writing commit messages in
+		linkgit:git-commit[1], and in the help message shown
+		by linkgit:git-checkout[1] when switching branch.
+	statusUoption::
+		Advise to consider using the `-u` option to linkgit:git-status[1]
+		when the command takes more than 2 seconds to enumerate untracked
+		files.
+	commitBeforeMerge::
+		Advice shown when linkgit:git-merge[1] refuses to
+		merge to avoid overwriting local changes.
+	resetQuiet::
+		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
+		when the command takes more than 2 seconds to enumerate unstaged
+		changes after reset.
+	resolveConflict::
+		Advice shown by various commands when conflicts
+		prevent the operation from being performed.
+	implicitIdentity::
+		Advice on how to set your identity configuration when
+		your information is guessed from the system username and
+		domain name.
+	detachedHead::
+		Advice shown when you used linkgit:git-checkout[1] to
+		move to the detach HEAD state, to instruct how to create
+		a local branch after the fact.
+	checkoutAmbiguousRemoteBranchName::
+		Advice shown when the argument to
+		linkgit:git-checkout[1] ambiguously resolves to a
+		remote tracking branch on more than one remote in
+		situations where an unambiguous argument would have
+		otherwise caused a remote-tracking branch to be
+		checked out. See the `checkout.defaultRemote`
+		configuration variable for how to set a given remote
+		to used by default in some situations where this
+		advice would be printed.
+	amWorkDir::
+		Advice that shows the location of the patch file when
+		linkgit:git-am[1] fails to apply it.
+	rmHints::
+		In case of failure in the output of linkgit:git-rm[1],
+		show directions on how to proceed from the current state.
+	addEmbeddedRepo::
+		Advice on what to do when you've accidentally added one
+		git repo inside of another.
+	ignoredHook::
+		Advice shown if a hook is ignored because the hook is not
+		set as executable.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
+--
-- 
2.19.1.647.g708186aaf9

