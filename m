Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0651F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeJ0PEX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44118 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbeJ0PEX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id m18-v6so2471557lfl.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3XPmTqP0G12z0939PDD3XqFijM/s0SbKg08fAcRgRY=;
        b=nEcZsge9ZUGERss3gN+/AqOW9EcTM5nAho2w6sL79jdkKY6QtDbI8CHMEi11UCX4C8
         4bj9oCNEh1BRhn3S64XnEzJbDIxUkdcdoOWWQTpUd9XDCMYYCiFXbTvWDrJCmgizSVv3
         v6adQ1S6V0s1nYho0uhHfowqFgdvU70+kACfrbr/U9srwwxPyxcZF5jYAr4mCbZCSvIr
         wgLLE+eb8wkdsPr+DvhWpA7y0E5eJm9ILayH03QQeG6tRT9RkLYUiRiWTMTOe3Z8/bmF
         evNIZZjW4x1BYJ8Q6/8vafX4GmUYpKsnaYuLGh2M6uXIqV04F2Ox1T+SJ4APVgPLNTMq
         78Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3XPmTqP0G12z0939PDD3XqFijM/s0SbKg08fAcRgRY=;
        b=sZ1A6y8ynOKHpCSRgbghWIMtZpWdnLtUmbh5awk34zUGXWKTutVk1Z7/wSu/4FlW6+
         ohZx6kUeBn2y5WmOIR9dY/0NuasF8XWYlmMnQELzEG7j41XUFdw1shWtsyS3nSYJqgqz
         jcztuMiiKmyy0N6u+vcZnRowY+e3xRLu1SxF31BHozt5fisyu+4bVhUxtisqJTTi0ht0
         pSrjSktasY3LUcn2SK7S6jUjprhg4uI3MrOyYcAf7Zh8GvVyaMxU8qyxL46UInIZ0Vwp
         kZEGiMGjTt1Pe/p26jzZ3EjI/pEBdxYRMpXVFfwjWFjcD2vm7gP6TbVvlJRPcngp8E51
         A17A==
X-Gm-Message-State: AGRZ1gJZ8AKot25/4AwjBDMeuNN+lri/ajcjrjF5P2GKepxNh/xq4vpU
        NVk1hNNJgLoeImszhwEBSJSL7UnT
X-Google-Smtp-Source: AJdET5fpWMXsTAZRWSEzRyfQU1/ry+cpVN10C34kpgYbiBizYfyn/nKz2mAIu7ufVChoXmXMbAToJg==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr3898733lfe.73.1540621466571;
        Fri, 26 Oct 2018 23:24:26 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:25 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 26/78] config.txt: move gc.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:59 +0200
Message-Id: <20181027062351.30446-27-pclouds@gmail.com>
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
 Documentation/config.txt    | 109 +-----------------------------------
 Documentation/config/gc.txt | 108 +++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/config/gc.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f70f95d5cf..dee012a5d5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -333,114 +333,7 @@ include::config/filter.txt[]
 
 include::config/fsck.txt[]
 
-gc.aggressiveDepth::
-	The depth parameter used in the delta compression
-	algorithm used by 'git gc --aggressive'.  This defaults
-	to 50.
-
-gc.aggressiveWindow::
-	The window size parameter used in the delta compression
-	algorithm used by 'git gc --aggressive'.  This defaults
-	to 250.
-
-gc.auto::
-	When there are approximately more than this many loose
-	objects in the repository, `git gc --auto` will pack them.
-	Some Porcelain commands use this command to perform a
-	light-weight garbage collection from time to time.  The
-	default value is 6700.  Setting this to 0 disables it.
-
-gc.autoPackLimit::
-	When there are more than this many packs that are not
-	marked with `*.keep` file in the repository, `git gc
-	--auto` consolidates them into one larger pack.  The
-	default	value is 50.  Setting this to 0 disables it.
-
-gc.autoDetach::
-	Make `git gc --auto` return immediately and run in background
-	if the system supports it. Default is true.
-
-gc.bigPackThreshold::
-	If non-zero, all packs larger than this limit are kept when
-	`git gc` is run. This is very similar to `--keep-base-pack`
-	except that all packs that meet the threshold are kept, not
-	just the base pack. Defaults to zero. Common unit suffixes of
-	'k', 'm', or 'g' are supported.
-+
-Note that if the number of kept packs is more than gc.autoPackLimit,
-this configuration variable is ignored, all packs except the base pack
-will be repacked. After this the number of packs should go below
-gc.autoPackLimit and gc.bigPackThreshold should be respected again.
-
-gc.writeCommitGraph::
-	If true, then gc will rewrite the commit-graph file when
-	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
-	'--auto' the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
-	for details.
-
-gc.logExpiry::
-	If the file gc.log exists, then `git gc --auto` will print
-	its content and exit with status zero instead of running
-	unless that file is more than 'gc.logExpiry' old.  Default is
-	"1.day".  See `gc.pruneExpire` for more ways to specify its
-	value.
-
-gc.packRefs::
-	Running `git pack-refs` in a repository renders it
-	unclonable by Git versions prior to 1.5.1.2 over dumb
-	transports such as HTTP.  This variable determines whether
-	'git gc' runs `git pack-refs`. This can be set to `notbare`
-	to enable it within all non-bare repos or it can be set to a
-	boolean value.  The default is `true`.
-
-gc.pruneExpire::
-	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
-	Override the grace period with this config variable.  The value
-	"now" may be used to disable this grace period and always prune
-	unreachable objects immediately, or "never" may be used to
-	suppress pruning.  This feature helps prevent corruption when
-	'git gc' runs concurrently with another process writing to the
-	repository; see the "NOTES" section of linkgit:git-gc[1].
-
-gc.worktreePruneExpire::
-	When 'git gc' is run, it calls
-	'git worktree prune --expire 3.months.ago'.
-	This config variable can be used to set a different grace
-	period. The value "now" may be used to disable the grace
-	period and prune `$GIT_DIR/worktrees` immediately, or "never"
-	may be used to suppress pruning.
-
-gc.reflogExpire::
-gc.<pattern>.reflogExpire::
-	'git reflog expire' removes reflog entries older than
-	this time; defaults to 90 days. The value "now" expires all
-	entries immediately, and "never" suppresses expiration
-	altogether. With "<pattern>" (e.g.
-	"refs/stash") in the middle the setting applies only to
-	the refs that match the <pattern>.
-
-gc.reflogExpireUnreachable::
-gc.<pattern>.reflogExpireUnreachable::
-	'git reflog expire' removes reflog entries older than
-	this time and are not reachable from the current tip;
-	defaults to 30 days. The value "now" expires all entries
-	immediately, and "never" suppresses expiration altogether.
-	With "<pattern>" (e.g. "refs/stash")
-	in the middle, the setting applies only to the refs that
-	match the <pattern>.
-
-gc.rerereResolved::
-	Records of conflicted merge you resolved earlier are
-	kept for this many days when 'git rerere gc' is run.
-	You can also use more human-readable "1.month.ago", etc.
-	The default is 60 days.  See linkgit:git-rerere[1].
-
-gc.rerereUnresolved::
-	Records of conflicted merge you have not resolved are
-	kept for this many days when 'git rerere gc' is run.
-	You can also use more human-readable "1.month.ago", etc.
-	The default is 15 days.  See linkgit:git-rerere[1].
+include::config/gc.txt[]
 
 include::gitcvs-config.txt[]
 
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
new file mode 100644
index 0000000000..c6fbb8a96f
--- /dev/null
+++ b/Documentation/config/gc.txt
@@ -0,0 +1,108 @@
+gc.aggressiveDepth::
+	The depth parameter used in the delta compression
+	algorithm used by 'git gc --aggressive'.  This defaults
+	to 50.
+
+gc.aggressiveWindow::
+	The window size parameter used in the delta compression
+	algorithm used by 'git gc --aggressive'.  This defaults
+	to 250.
+
+gc.auto::
+	When there are approximately more than this many loose
+	objects in the repository, `git gc --auto` will pack them.
+	Some Porcelain commands use this command to perform a
+	light-weight garbage collection from time to time.  The
+	default value is 6700.  Setting this to 0 disables it.
+
+gc.autoPackLimit::
+	When there are more than this many packs that are not
+	marked with `*.keep` file in the repository, `git gc
+	--auto` consolidates them into one larger pack.  The
+	default	value is 50.  Setting this to 0 disables it.
+
+gc.autoDetach::
+	Make `git gc --auto` return immediately and run in background
+	if the system supports it. Default is true.
+
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero. Common unit suffixes of
+	'k', 'm', or 'g' are supported.
++
+Note that if the number of kept packs is more than gc.autoPackLimit,
+this configuration variable is ignored, all packs except the base pack
+will be repacked. After this the number of packs should go below
+gc.autoPackLimit and gc.bigPackThreshold should be respected again.
+
+gc.writeCommitGraph::
+	If true, then gc will rewrite the commit-graph file when
+	linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
+	'--auto' the commit-graph will be updated if housekeeping is
+	required. Default is false. See linkgit:git-commit-graph[1]
+	for details.
+
+gc.logExpiry::
+	If the file gc.log exists, then `git gc --auto` will print
+	its content and exit with status zero instead of running
+	unless that file is more than 'gc.logExpiry' old.  Default is
+	"1.day".  See `gc.pruneExpire` for more ways to specify its
+	value.
+
+gc.packRefs::
+	Running `git pack-refs` in a repository renders it
+	unclonable by Git versions prior to 1.5.1.2 over dumb
+	transports such as HTTP.  This variable determines whether
+	'git gc' runs `git pack-refs`. This can be set to `notbare`
+	to enable it within all non-bare repos or it can be set to a
+	boolean value.  The default is `true`.
+
+gc.pruneExpire::
+	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
+	Override the grace period with this config variable.  The value
+	"now" may be used to disable this grace period and always prune
+	unreachable objects immediately, or "never" may be used to
+	suppress pruning.  This feature helps prevent corruption when
+	'git gc' runs concurrently with another process writing to the
+	repository; see the "NOTES" section of linkgit:git-gc[1].
+
+gc.worktreePruneExpire::
+	When 'git gc' is run, it calls
+	'git worktree prune --expire 3.months.ago'.
+	This config variable can be used to set a different grace
+	period. The value "now" may be used to disable the grace
+	period and prune `$GIT_DIR/worktrees` immediately, or "never"
+	may be used to suppress pruning.
+
+gc.reflogExpire::
+gc.<pattern>.reflogExpire::
+	'git reflog expire' removes reflog entries older than
+	this time; defaults to 90 days. The value "now" expires all
+	entries immediately, and "never" suppresses expiration
+	altogether. With "<pattern>" (e.g.
+	"refs/stash") in the middle the setting applies only to
+	the refs that match the <pattern>.
+
+gc.reflogExpireUnreachable::
+gc.<pattern>.reflogExpireUnreachable::
+	'git reflog expire' removes reflog entries older than
+	this time and are not reachable from the current tip;
+	defaults to 30 days. The value "now" expires all entries
+	immediately, and "never" suppresses expiration altogether.
+	With "<pattern>" (e.g. "refs/stash")
+	in the middle, the setting applies only to the refs that
+	match the <pattern>.
+
+gc.rerereResolved::
+	Records of conflicted merge you resolved earlier are
+	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
+	The default is 60 days.  See linkgit:git-rerere[1].
+
+gc.rerereUnresolved::
+	Records of conflicted merge you have not resolved are
+	kept for this many days when 'git rerere gc' is run.
+	You can also use more human-readable "1.month.ago", etc.
+	The default is 15 days.  See linkgit:git-rerere[1].
-- 
2.19.1.647.g708186aaf9

