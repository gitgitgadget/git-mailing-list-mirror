Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31E21F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJTUtq (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:49:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41874 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUtp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:49:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so27120344lfi.8
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kzVS5EDkoC3bFTJuUe/Qj1XinCWgRoNvw69x+NqPmgk=;
        b=K2aN1Wq6o+SGatirdPEALFwvgSY/4QC4CpacQKxIBVeZU9W57Gn+o529qTRIu2TD/I
         EdL9/52iLfVV7FoeVRvRJ7MeouKyAkTgdoSn90gDUlFSb9+Wbo0GNMqATITqQFLOeWjb
         JAUzPEp9JJQ3+uMncJQW+wpBDUQ6KOx4ul3cLKJqUCagrSXEuep/ASMSvwM+eVF3HcSM
         GEZPWGPZWGCB+3v/LnPcEqCBzBnexlE0PpVn86W7hVdqt1NYQjtUOFAdpQQ56hAewpk9
         88vvoc7uVHaLGmqYMP3npzDrnfXnEIAfwZqoFkdkLNR3e3G8HFkCd01Ppa0kyqUfwj46
         X4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kzVS5EDkoC3bFTJuUe/Qj1XinCWgRoNvw69x+NqPmgk=;
        b=NyHAgsjOl2jr1D0YLqwIL9VwB2EY5q3Bx7C7WN7kc5zoDOcj2yq3yAZyCIgOGKr1Tp
         b+bYMBjGQPKXceSmkQMlXTk8MCpHVkzJIZz9M3KkfjGd6+ejKkSTLSRVSu59MIdqU/1Q
         p1eJcLsWBgIXEHiwnyqb7Lmyr/WYF0tvwSKpjHsk308044ANLhxggXLXp+gtCACRn6Y7
         uwtfAWaASSpNms+p6NtUWtKwvdRzRLkoI2lC4Csrj67khue5FHcQtgu8mmUpRAo/sWO4
         ga1ElD1uk3FjLyfNWckzF3kfURNmlv8g0BSN8MOFb258r9IbbDVK22AlMKqa+UUsny/7
         xhoA==
X-Gm-Message-State: ABuFfoiO2zwQ+7406af8Q6Ka0vg3N550TJeDAUXjhMqlihmtQYr4cDvx
        yAxPxbnuNzsEBMfMgGOc2KPvQz4S
X-Google-Smtp-Source: ACcGV63ufr+WcAulkqqRQUW3YFOnqxfaWAYYVBN84T8kLUYsxx1cfBf4ONGf271ds33s0430147rWA==
X-Received: by 2002:a19:aa8b:: with SMTP id t133-v6mr5325890lfe.92.1540039162473;
        Sat, 20 Oct 2018 05:39:22 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/59] config.txt: move gc.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:10 +0200
Message-Id: <20181020123848.2785-22-pclouds@gmail.com>
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
 Documentation/config.txt    | 109 +-----------------------------------
 Documentation/gc-config.txt | 108 +++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/gc-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fa26cb1090..ebef3c867a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -333,114 +333,7 @@ include::filter-config.txt[]
 
 include::fsck-config.txt[]
 
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
+include::gc-config.txt[]
 
 include::gitcvs-config.txt[]
 
diff --git a/Documentation/gc-config.txt b/Documentation/gc-config.txt
new file mode 100644
index 0000000000..c6fbb8a96f
--- /dev/null
+++ b/Documentation/gc-config.txt
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

