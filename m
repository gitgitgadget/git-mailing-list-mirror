Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE473A862C
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300282; cv=none; b=cnXT4G0bACFFFks0hXKPYpPMqoY98ujzT8J16Jy1iCCstTMpwwU65nS81eqLbaPoYreAzscPV40fIm1GKg3pgIP2g4eTFQaQGIkpx+snOYgPDgnBPVURT9LChOZfRNEeVxMJzH72zA3DiXGIdDn4AlsVXItwBQ+CPZ7e+cmO1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300282; c=relaxed/simple;
	bh=m93YkUn8Nux/CBk9QPdzdk8/1lNcuvxbJgxwYK8V9hM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uG2Oh6h/E119gbY+IYtViUVE9UVLCRaitVbMGhKppN3WQ/KiM1iXNRepqH/YqeAlaWXGYwEfimUEHpppbOy+QQvblQyzD9O8/g5j8yqynAH8ZYk8NJDSRuOiDxfd/xDQy4Q2Hj1SddXOtJUZyyUVDl/Eowv9sWkjNWIluFFz9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDsMWh/6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDsMWh/6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899c3441177so53593176d6.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772300280; x=1772905080; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwM9IpcgT7h6TTrAbZzRKp7V5+SFsILAXmI1Ccut8pU=;
        b=EDsMWh/6TPs9jOR2dPw+EvNUnNuqs3VkzTGDTsHl8UfxTKULZxGBzsaEGnf4Lr5qR8
         5mkrEcRv/ng4R/MyYbenvGioAHZ7fRE9exIMGLa+EoD1TNYv6R+ssIieTiR5L+V+Eha3
         pO0SpaNY18owzIx2jjxAcprGGL5g9U6aMPsL8ltOZM6ChmxhulFoqGlpiNczMUwiGied
         obQyYjO8oLErP5TwGYRbZH2VLddKRT0ssLv0U+qJ2jQhzfJZTPHJdCkZx7dNoAVwZrZI
         DkVfK/oBzlzy4fM4XPIRSSCBSRnJ4Dkl8ULxs4NF5z+ac9RNuwoIDPZrjgFMuNNUA9Mn
         9wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300280; x=1772905080;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QwM9IpcgT7h6TTrAbZzRKp7V5+SFsILAXmI1Ccut8pU=;
        b=xRCG4YN6eQI8ojFv5IeByd/+/Oa4s0yGHa+lBOGDOlXHZ9blLG2561lrgDRCdWJOmg
         TUqYHjTnPCjoNE7k934MNW35VPw8KGIdfm+kRWSW/O86LqceRcmo0OWAF0xAxBpKcX4I
         DsUTjo4q8YTKyv6jOqkMSdlOqACCwaM/RL59BilNAYeKg8Ka9ja0hTR2QDR1ieiH+Wga
         Tw2Ln9RH9l2bvs26GKzMQcT46MadBtzRG7m/942MA4I9ZvvKUWmDuyjNVtrtVftcc0YZ
         7ti8TzH7skR+bJSgvTLGxue7OaDLMxeMrp2481SooqFaKMJ6E3ZvXZ2TtRgHZvp1Z5Vc
         ddcA==
X-Gm-Message-State: AOJu0YyIpxo/Cjuh1RcMiDb4ir+g0R+E3x1Bxgn34Y08tLECp+F1d8Ln
	9Sw1lf/5anrJhnbPpBS7S7y4rQ9DO7JukceXemB2n03te/8kDEkzPNCYmVmwrBzI
X-Gm-Gg: ATEYQzwuU76w53fKYMD3KzEAHlXHT61hCRD+buNYisB+upsdyfj7jWhTDSzPyrF4Feg
	XTwl8WIqqhPOKcRPrMcSXWS5JzFf1EEw8ctJT4KHpvah5y9KIF+93sGNdOi+NkxS8o1phfSifLb
	hhYwc67V6ngdpz/inr9UxOo2UpBsCxAGq85vH0pHQTfrqDP9IvEZZBHQ9YfPBzR5CN/d0UNbGAD
	MAyrbblfkVqSlKmfDxhZ4+qZpIcB+UUu3rpI0LLjdjnjDJ73ugmkRrvg7XVYgZuefc6fLc8wClL
	/aHgL2LCl1WHFy3L+bcurpps41BHtzEyA4a+zZVTa6r4hI6NHB61ishnBv4nTw+bnS7PgRoFcWx
	nR+DrvbACiGGDIXT6wT16+M68Vw4U59uMDolyGahK2j1hLduMbdZvuDvAumW425p8jQ/OEfvKgQ
	YFfhAg6pfvqXa/Yes4YrtoRC+S
X-Received: by 2002:ad4:596d:0:b0:894:7a38:d665 with SMTP id 6a1803df08f44-899d1d899c4mr101219786d6.3.1772300279626;
        Sat, 28 Feb 2026 09:37:59 -0800 (PST)
Received: from [127.0.0.1] ([4.246.134.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c739000fsm67653456d6.44.2026.02.28.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:37:58 -0800 (PST)
Message-Id: <pull.2180.v2.git.git.1772300277959.gitgitgadget@gmail.com>
In-Reply-To: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
References: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Feb 2026 17:37:57 +0000
Subject: [PATCH v2] fsmonitor-watchman: fix variable reference and remove
 redundant code
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Koji Nakamaru <koji.nakamaru@gree.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The is_work_tree_watched() function in fsmonitor-watchman.sample has
two bugs:

1. Wrong variable in error check: After calling watchman_clock(), the
   result is stored in $o, but the code checks $output->{error} instead
   of $o->{error}. This means errors from the clock command are silently
   ignored.

2. Double output violates protocol: When the retry path triggers (the
   directory wasn't initially watched), output_result() is called with
   the "/" flag, then launch_watchman() is called recursively which
   calls output_result() again. This outputs two clock tokens to stdout,
   but git's fsmonitor v2 protocol expects exactly one response.

Fix #1 by checking $o->{error} after watchman_clock().

Fix #2 by removing the recursive launch_watchman() call. The "/"
"everything is dirty" flag already tells git to do a full scan, and
git will call the hook again on the next invocation with a valid clock
token.

With the recursive call removed, the $retry guard is no longer needed
since it only existed to prevent infinite recursion. Remove it.

Apply the same fixes to the test helper scripts in t/t7519/.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
    fsmonitor-watchman: fix variable reference and remove redundant code
    
    fsmonitor-watchman: fix variable reference and remove redundant code
    
    The is_work_tree_watched() function in fsmonitor-watchman.sample has two
    bugs:
    
     1. Wrong variable in error check: After calling watchman_clock(), the
        result is stored in $o, but the code checks $output->{error} instead
        of $o->{error}. This means errors from the clock command are
        silently ignored.
    
     2. Double output violates protocol: When the retry path triggers (the
        directory wasn't initially watched), output_result() is called with
        the "/" flag, then launch_watchman() is called recursively which
        calls output_result() again. This outputs two clock tokens to
        stdout, but git's fsmonitor v2 protocol expects exactly one
        response.
    
    Fix #1 by checking $o->{error} after watchman_clock().
    
    Fix #2 by removing the recursive launch_watchman() call. The "/"
    "everything is dirty" flag already tells git to do a full scan, and git
    will call the hook again on the next invocation with a valid clock
    token.
    
    Apply the same fixes to the test helper scripts in t/t7519/.
    
    Changes since v1:
    
     * Removed $retry variable and associated logic, which only existed to
       prevent infinite recursion from the now-removed recursive
       launch_watchman() call
     * Fixed commit authorship

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2180%2Fptarjan%2Fclaude%2Ffix-watchman-query-bug-sfbIw-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2180/ptarjan/claude/fix-watchman-query-bug-sfbIw-v2
Pull-Request: https://github.com/git/git/pull/2180

Range-diff vs v1:

 1:  116d26287f ! 1:  b9e00b8ab5 fsmonitor: fix two bugs in watchman hook retry path
     @@
       ## Metadata ##
     -Author: Claude <noreply@anthropic.com>
     +Author: Paul Tarjan <github@paulisageek.com>
      
       ## Commit message ##
     -    fsmonitor: fix two bugs in watchman hook retry path
     +    fsmonitor-watchman: fix variable reference and remove redundant code
      
          The is_work_tree_watched() function in fsmonitor-watchman.sample has
          two bugs:
     @@ Commit message
          git will call the hook again on the next invocation with a valid clock
          token.
      
     +    With the recursive call removed, the $retry guard is no longer needed
     +    since it only existed to prevent infinite recursion. Remove it.
     +
          Apply the same fixes to the test helper scripts in t/t7519/.
      
          Signed-off-by: Paul Tarjan <github@paulisageek.com>
      
       ## t/t7519/fsmonitor-watchman ##
     +@@ t/t7519/fsmonitor-watchman: if ($^O =~ 'msys' || $^O =~ 'cygwin') {
     + 	$git_work_tree = Cwd::cwd();
     + }
     + 
     +-my $retry = 1;
     +-
     + launch_watchman();
     + 
     + sub launch_watchman {
     +@@ t/t7519/fsmonitor-watchman: sub launch_watchman {
     + 
     + 	my $o = $json_pkg->new->utf8->decode($response);
     + 
     +-	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
     ++	if ($o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
     + 		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
     +-		$retry--;
     + 		qx/watchman watch "$git_work_tree"/;
     + 		die "Failed to make watchman watch '$git_work_tree'.\n" .
     + 		    "Falling back to scanning...\n" if $? != 0;
      @@ t/t7519/fsmonitor-watchman: sub launch_watchman {
       		close $fh;
       
     @@ t/t7519/fsmonitor-watchman: sub launch_watchman {
       
      
       ## t/t7519/fsmonitor-watchman-v2 ##
     +@@ t/t7519/fsmonitor-watchman-v2: if ($version ne 2) {
     + 
     + my $git_work_tree = get_working_dir();
     + 
     +-my $retry = 1;
     +-
     + my $json_pkg;
     + eval {
     + 	require JSON::XS;
     +@@ t/t7519/fsmonitor-watchman-v2: sub watchman_query {
     + sub is_work_tree_watched {
     + 	my ($output) = @_;
     + 	my $error = $output->{error};
     +-	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
     +-		$retry--;
     ++	if ($error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
     + 		my $response = qx/watchman watch "$git_work_tree"/;
     + 		die "Failed to make watchman watch '$git_work_tree'.\n" .
     + 		    "Falling back to scanning...\n" if $? != 0;
      @@ t/t7519/fsmonitor-watchman-v2: sub is_work_tree_watched {
       		# Watchman query just to get it over with now so we won't pay
       		# the cost in git to look up each individual file.
     @@ t/t7519/fsmonitor-watchman-v2: sub is_work_tree_watched {
       
      
       ## templates/hooks/fsmonitor-watchman.sample ##
     +@@ templates/hooks/fsmonitor-watchman.sample: if ($version ne 2) {
     + 
     + my $git_work_tree = get_working_dir();
     + 
     +-my $retry = 1;
     +-
     + my $json_pkg;
     + eval {
     + 	require JSON::XS;
     +@@ templates/hooks/fsmonitor-watchman.sample: sub watchman_query {
     + sub is_work_tree_watched {
     + 	my ($output) = @_;
     + 	my $error = $output->{error};
     +-	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
     +-		$retry--;
     ++	if ($error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
     + 		my $response = qx/watchman watch "$git_work_tree"/;
     + 		die "Failed to make watchman watch '$git_work_tree'.\n" .
     + 		    "Falling back to scanning...\n" if $? != 0;
      @@ templates/hooks/fsmonitor-watchman.sample: sub is_work_tree_watched {
       		# Watchman query just to get it over with now so we won't pay
       		# the cost in git to look up each individual file.


 t/t7519/fsmonitor-watchman                |  6 +-----
 t/t7519/fsmonitor-watchman-v2             | 10 ++--------
 templates/hooks/fsmonitor-watchman.sample | 10 ++--------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 264b9daf83..bcc055c1e0 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -38,8 +38,6 @@ if ($^O =~ 'msys' || $^O =~ 'cygwin') {
 	$git_work_tree = Cwd::cwd();
 }
 
-my $retry = 1;
-
 launch_watchman();
 
 sub launch_watchman {
@@ -92,9 +90,8 @@ sub launch_watchman {
 
 	my $o = $json_pkg->new->utf8->decode($response);
 
-	if ($retry > 0 and $o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
+	if ($o->{error} and $o->{error} =~ m/unable to resolve root .* directory (.*) is not watched/) {
 		print STDERR "Adding '$git_work_tree' to watchman's watch list.\n";
-		$retry--;
 		qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
 		    "Falling back to scanning...\n" if $? != 0;
@@ -109,7 +106,6 @@ sub launch_watchman {
 		close $fh;
 
 		print "/\0";
-		eval { launch_watchman() };
 		exit 0;
 	}
 
diff --git a/t/t7519/fsmonitor-watchman-v2 b/t/t7519/fsmonitor-watchman-v2
index 14ed0aa42d..368604c278 100755
--- a/t/t7519/fsmonitor-watchman-v2
+++ b/t/t7519/fsmonitor-watchman-v2
@@ -29,8 +29,6 @@ if ($version ne 2) {
 
 my $git_work_tree = get_working_dir();
 
-my $retry = 1;
-
 my $json_pkg;
 eval {
 	require JSON::XS;
@@ -122,8 +120,7 @@ sub watchman_query {
 sub is_work_tree_watched {
 	my ($output) = @_;
 	my $error = $output->{error};
-	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
-		$retry--;
+	if ($error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
 		my $response = qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
 		    "Falling back to scanning...\n" if $? != 0;
@@ -141,15 +138,12 @@ sub is_work_tree_watched {
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
 		my $o = watchman_clock();
-		$error = $output->{error};
+		$error = $o->{error};
 
 		die "Watchman: $error.\n" .
 		"Falling back to scanning...\n" if $error;
 
 		output_result($o->{clock}, ("/"));
-		$last_update_token = $o->{clock};
-
-		eval { launch_watchman() };
 		return 0;
 	}
 
diff --git a/templates/hooks/fsmonitor-watchman.sample b/templates/hooks/fsmonitor-watchman.sample
index 23e856f5de..429e0a51c1 100755
--- a/templates/hooks/fsmonitor-watchman.sample
+++ b/templates/hooks/fsmonitor-watchman.sample
@@ -29,8 +29,6 @@ if ($version ne 2) {
 
 my $git_work_tree = get_working_dir();
 
-my $retry = 1;
-
 my $json_pkg;
 eval {
 	require JSON::XS;
@@ -123,8 +121,7 @@ sub watchman_query {
 sub is_work_tree_watched {
 	my ($output) = @_;
 	my $error = $output->{error};
-	if ($retry > 0 and $error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
-		$retry--;
+	if ($error and $error =~ m/unable to resolve root .* directory (.*) is not watched/) {
 		my $response = qx/watchman watch "$git_work_tree"/;
 		die "Failed to make watchman watch '$git_work_tree'.\n" .
 		    "Falling back to scanning...\n" if $? != 0;
@@ -142,15 +139,12 @@ sub is_work_tree_watched {
 		# Watchman query just to get it over with now so we won't pay
 		# the cost in git to look up each individual file.
 		my $o = watchman_clock();
-		$error = $output->{error};
+		$error = $o->{error};
 
 		die "Watchman: $error.\n" .
 		"Falling back to scanning...\n" if $error;
 
 		output_result($o->{clock}, ("/"));
-		$last_update_token = $o->{clock};
-
-		eval { launch_watchman() };
 		return 0;
 	}
 

base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
-- 
gitgitgadget
