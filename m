Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFFA41F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbeJTUtU (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43369 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTUtU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id r8-v6so33085795ljc.10
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JecqEokIeoo/YSwSG5/tAy/giPcWrXEIG1KjgWtbP4=;
        b=TtXW1fCKdXMoU+T1OlHuFuNPW3D/7eg4JeOarRwcEUik4xgjavcR6muWxFPl3q1CjJ
         930BqxkKTxAiVhoxhZG1VZ6H2OWB0iftz1YB1DqgXqZSsQLgUg+UuSqtfKEldiTSyZIt
         zH+MSsALmAs5izfypZDreja4B39jWAceiPBlBYjpSVJF3SeDQOlKRMyoirT17uJamAuS
         s2NCi/zsFylgiTRHF0EJb23r+iSi1MZj9M6FJci4v+vMoxO+GwC+MN+q2caABmsGN+jl
         Yx2cgXIfFYvJNAdPGturBRjTw7D5x2U7m0ErXinOF6U9mblV1IxOBMu8BctDBJ4w48az
         9JLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JecqEokIeoo/YSwSG5/tAy/giPcWrXEIG1KjgWtbP4=;
        b=rulMhCxFAnK4aoXt+wEYY5ElCcAq6gYkEE1TGO5fcN769hrgQFfYRKx3sACARZ8jbg
         9nKvv9e10+9js65xQwk2R0zE/YfGsuzVU7266Rkn9ISnMzfGKnyXH+dT74utm4VNy3A2
         mjERmSKTkUW1hFyyNB+SPH//0f4xgRL03BcoHMCg3cZpL58F7vLkXQLweUjL/4d1k3sj
         5zkLh2KrDRtpLffaimsWjdhmnCNahifZTsKkk6GVchJ2jwq1db2Qz2PrHPdBEjTasLSL
         9K9x5h9rarFmwHZe5N+OEEhww/IB77DnYLIB8zeetVVCAiI4CYVKagGSkGImTLtYEZds
         XY8Q==
X-Gm-Message-State: ABuFfogZU4+WRkdRJcOahfvz55p1VZWiz+JkCHWzkvJ1qwfqAFicX4hA
        8JWIf4ZDXeNFCPHH483h2Mosf9XZ
X-Google-Smtp-Source: AJdET5fj3fLWZWQRyfgnOIueuL+b14k/qoS4wzbSoPVcaEWTCfzfgG+cjTW6L7iLgs6RX6w4mdPabA==
X-Received: by 2002:a2e:5d8f:: with SMTP id v15-v6mr1092614lje.86.1540039137724;
        Sat, 20 Oct 2018 05:38:57 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:38:56 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/59] config.txt: move advice.* to a separate file
Date:   Sat, 20 Oct 2018 14:37:50 +0200
Message-Id: <20181020123848.2785-2-pclouds@gmail.com>
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
 Documentation/advice-config.txt | 82 ++++++++++++++++++++++++++++++++
 Documentation/config.txt        | 84 +--------------------------------
 2 files changed, 83 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/advice-config.txt

diff --git a/Documentation/advice-config.txt b/Documentation/advice-config.txt
new file mode 100644
index 0000000000..7f80cddcd4
--- /dev/null
+++ b/Documentation/advice-config.txt
@@ -0,0 +1,82 @@
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
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 552827935a..a0b0ef582f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -287,89 +287,7 @@ inventing new variables for use in your own tool, make sure their
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
+include::advice-config.txt[]
 
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
-- 
2.19.1.647.g708186aaf9

