Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE84A1FF7F
	for <e@80x24.org>; Fri,  9 Dec 2016 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbcLII67 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 03:58:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34459 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932499AbcLII65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 03:58:57 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so1710628pgc.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WkL7qbkQXhmPHMyU+gmY7LE5WzOEGlI3kCgPTJIgp2s=;
        b=GwB3DPskuYS0UssUBKUu6F7HnH88OyGtT79j0S6HBawEPQjT2fYXLTvXmoGRU7EhrE
         9GifWrszvs5b1Vs+m/wAomsanW2blhoGOQXeVDMI21pZglH+PpupGjSMphD5AlGQojES
         z7rpb2bnOYwcMI7VLJD5MAYidu7RrIBS6WwXZcjCia6IT4Cn/D7EfYTWfUbibe3vmLE3
         bdnEGfBGbzAGpxkM7s+ZVl/10YZCnQjCTIQ23SDCJaJjvRQFpSCkDrTiMDfKKAeSUmEF
         I4vEHKlNwvoSCkMReMQ8rJHKCHWfQloa8+g0miwjZ7Gbkic9Aagl0jcf41Hj4i5FiM14
         UECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WkL7qbkQXhmPHMyU+gmY7LE5WzOEGlI3kCgPTJIgp2s=;
        b=PxxGQB86wU1lVzT0BXoRT5rTeDiyI3NEkYmql72EHbge7FET0Pm3ntnKBGJUsJeHjY
         C3FZ4RIaEqG/8IfWp2K3Z36kAjLgDairhpGDn72stgVzQWffwfAfaSzsesZcaWR6CiH3
         FKfT4iI013S8Rsw4bginse6lqotwHrkgCE92O+WhiCmPd0mrGb/RRT/q/US7xq4eL+36
         bL4NoepbmuFbEOQI4S+tQo+Onc/3xP7E3/nBMwOlgVbXe9Xd4xpfAIZF1DiOUUGAeOUb
         VFA26WtWkOmQkYelMPjx8UsziOETbOUXZb9h24eQs0f/+M4yiuUSTcOTVswwmoQ5mF/a
         iZ/w==
X-Gm-Message-State: AKaTC02ixn9GW2UTtTCY8S75DKfF53KxqjxXjdWHhKaIpQX3acpGo6GyKWnps+Xy0lYeeQ==
X-Received: by 10.98.192.148 with SMTP id g20mr80763526pfk.36.1481273936707;
        Fri, 09 Dec 2016 00:58:56 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by smtp.gmail.com with ESMTPSA id o26sm55587687pfk.91.2016.12.09.00.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 00:58:55 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH 3/3] difftool: rename variables for consistency
Date:   Fri,  9 Dec 2016 00:58:48 -0800
Message-Id: <20161209085848.10929-3-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.26.gb65c994
In-Reply-To: <20161209085848.10929-1-davvid@gmail.com>
References: <20161209085848.10929-1-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Always call the list of files @files.
Always call the worktree $worktree.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool.perl | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 99b03949bf..4e4f5d8138 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -100,7 +100,7 @@ sub changed_files
 
 sub setup_dir_diff
 {
-	my ($workdir, $symlinks) = @_;
+	my ($worktree, $symlinks) = @_;
 	my @gitargs = ('diff', '--raw', '--no-abbrev', '-z', @ARGV);
 	my $diffrtn = Git::command_oneline(@gitargs);
 	exit(0) unless defined($diffrtn);
@@ -109,7 +109,7 @@ sub setup_dir_diff
 	# changed files.  The paths returned by diff --raw are relative to the
 	# top-level of the repository, but we defer changing directories so
 	# that @ARGV can perform pathspec limiting in the current directory.
-	chdir($workdir);
+	chdir($worktree);
 
 	# Build index info for left and right sides of the diff
 	my $submodule_mode = '160000';
@@ -121,7 +121,7 @@ sub setup_dir_diff
 	my $wtindex = '';
 	my %submodule;
 	my %symlink;
-	my @working_tree = ();
+	my @files = ();
 	my %working_tree_dups = ();
 	my @rawdiff = split('\0', $diffrtn);
 
@@ -173,14 +173,14 @@ EOF
 		}
 
 		if ($rmode ne $null_mode) {
-			# Avoid duplicate working_tree entries
+			# Avoid duplicate entries
 			if ($working_tree_dups{$dst_path}++) {
 				next;
 			}
 			my ($use, $wt_sha1) =
 				use_wt_file($dst_path, $rsha1);
 			if ($use) {
-				push @working_tree, $dst_path;
+				push @files, $dst_path;
 				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
 			} else {
 				$rindex .= "$rmode $rsha1\t$dst_path\0";
@@ -227,14 +227,14 @@ EOF
 
 	# Changes in the working tree need special treatment since they are
 	# not part of the index.
-	for my $file (@working_tree) {
+	for my $file (@files) {
 		my $dir = dirname($file);
 		unless (-d "$rdir/$dir") {
 			mkpath("$rdir/$dir") or
 			exit_cleanup($tmpdir, 1);
 		}
 		if ($symlinks) {
-			symlink("$workdir/$file", "$rdir/$file") or
+			symlink("$worktree/$file", "$rdir/$file") or
 			exit_cleanup($tmpdir, 1);
 		} else {
 			copy($file, "$rdir/$file") or
@@ -278,7 +278,7 @@ EOF
 		exit_cleanup($tmpdir, 1) if not $ok;
 	}
 
-	return ($ldir, $rdir, $tmpdir, @working_tree);
+	return ($ldir, $rdir, $tmpdir, @files);
 }
 
 sub write_to_file
@@ -388,9 +388,9 @@ sub dir_diff
 	my $error = 0;
 	my $repo = Git->repository();
 	my $repo_path = $repo->repo_path();
-	my $workdir = $repo->wc_path();
-	$workdir =~ s|/$||; # Avoid double slashes in symlink targets
-	my ($a, $b, $tmpdir, @worktree) = setup_dir_diff($workdir, $symlinks);
+	my $worktree = $repo->wc_path();
+	$worktree =~ s|/$||; # Avoid double slashes in symlink targets
+	my ($a, $b, $tmpdir, @files) = setup_dir_diff($worktree, $symlinks);
 
 	if (defined($extcmd)) {
 		$rc = system($extcmd, $a, $b);
@@ -411,13 +411,13 @@ sub dir_diff
 	my %tmp_modified;
 	my $indices_loaded = 0;
 
-	for my $file (@worktree) {
+	for my $file (@files) {
 		next if $symlinks && -l "$b/$file";
 		next if ! -f "$b/$file";
 
 		if (!$indices_loaded) {
 			%wt_modified = changed_files(
-				$repo_path, "$tmpdir/wtindex", $workdir);
+				$repo_path, "$tmpdir/wtindex", $worktree);
 			%tmp_modified = changed_files(
 				$repo_path, "$tmpdir/wtindex", $b);
 			$indices_loaded = 1;
@@ -425,7 +425,7 @@ sub dir_diff
 
 		if (exists $wt_modified{$file} and exists $tmp_modified{$file}) {
 			my $errmsg = "warning: Both files modified: ";
-			$errmsg .= "'$workdir/$file' and '$b/$file'.\n";
+			$errmsg .= "'$worktree/$file' and '$b/$file'.\n";
 			$errmsg .= "warning: Working tree file has been left.\n";
 			$errmsg .= "warning:\n";
 			warn $errmsg;
-- 
2.11.0.26.gb65c994

