From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/2] gitweb: clean up git_check_feature() calls
Date: Fri, 28 Nov 2008 21:39:53 +0100
Message-ID: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1227904793-1821-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1227904793-1821-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 28 21:41:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6A92-0007Jo-4C
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 21:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYK1Ujl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbYK1Ujl
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 15:39:41 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:5524 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbYK1Ujk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 15:39:40 -0500
Received: by ey-out-2122.google.com with SMTP id 6so687928eyi.37
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 12:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=scWosHIpXpwiopxBgWz7Fi0qNuVk1CHiHOxgQbXAqZg=;
        b=Jvg5lh9aL+/4I3JN/rKWmtyY4cR4XF4mSlklxgutvTRG4cFHiZdAzbhnunvf6iUtoL
         /fkZ6a25CQrJiP7bTUvLNqkVSJ+LhidTgT/ov047I3xyLQg3TDzXYxTizyeUbgjFLy/q
         UiuQdqGeH7tMtZiESemXgh8yZqhXmxGOgSuZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HUQQrdOAKyzMQqZhTO8UhmgOpWg+j0TjtQmbaSrfRkMqx+gjd6abGQ0s9RzLZkip+H
         mV4DKHfjbUVtLeSmDf9ZUddDflu9uAHhA5Cmj8ufplD9XSQ+GkpkwkVUkK8pnK3YT+MT
         YWtfZbgkVYFaPAHa7scEhy7Q8N+85GusdYK2g=
Received: by 10.103.102.17 with SMTP id e17mr3290387mum.136.1227904777086;
        Fri, 28 Nov 2008 12:39:37 -0800 (PST)
Received: from localhost ([78.15.14.10])
        by mx.google.com with ESMTPS id j2sm2682020mue.35.2008.11.28.12.39.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 12:39:36 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1227904793-1821-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101884>

Since git_check_feature now returns a scalar, the parentheses around the
variables initialized from git_check_feature() are not needed.

We remove them for stylistic consistency and to prevent unnecessary
ambiguity in the code.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 128d7ad..b0d00ea 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -828,7 +828,7 @@ sub href (%) {
 		}
 	}
 
-	my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
 	if ($use_pathinfo) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
@@ -2119,7 +2119,7 @@ sub git_get_projects_list {
 	$filter ||= '';
 	$filter =~ s/\.git$//;
 
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if (-d $projects_list) {
 		# search in directory
@@ -2965,7 +2965,7 @@ EOF
 	}
 	print "</div>\n";
 
-	my ($have_search) = gitweb_check_feature('search');
+	my $have_search = gitweb_check_feature('search');
 	if (defined $project && $have_search) {
 		if (!defined $searchtext) {
 			$searchtext = "";
@@ -2979,7 +2979,7 @@ EOF
 			$search_hash = "HEAD";
 		}
 		my $action = $my_uri;
-		my ($use_pathinfo) = gitweb_check_feature('pathinfo');
+		my $use_pathinfo = gitweb_check_feature('pathinfo');
 		if ($use_pathinfo) {
 			$action .= "/".esc_url($project);
 		}
@@ -3472,7 +3472,7 @@ sub is_patch_split {
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	print "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
 		print(($#{$difftree} + 1) . " files changed:\n");
@@ -3986,7 +3986,7 @@ sub git_project_list_body {
 	# actually uses global variable $project
 	my ($projlist, $order, $from, $to, $extra, $no_header) = @_;
 
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 	my @projects = fill_project_list_info($projlist, $check_forks);
 
 	$order ||= $default_projects_order;
@@ -4446,7 +4446,7 @@ sub git_summary {
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
 	my @forklist;
-	my ($check_forks) = gitweb_check_feature('forks');
+	my $check_forks = gitweb_check_feature('forks');
 
 	if ($check_forks) {
 		@forklist = git_get_projects_list($project);
@@ -4475,7 +4475,7 @@ sub git_summary {
 	}
 
 	# Tag cloud
-	my $show_ctags = (gitweb_check_feature('ctags'))[0];
+	my $show_ctags = gitweb_check_feature('ctags');
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
@@ -4765,7 +4765,7 @@ sub git_blob {
 		$expires = "+1d";
 	}
 
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
 		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
@@ -4858,7 +4858,7 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $basedir = '';
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -5856,7 +5856,7 @@ insensitive).</p>
 <dt><b>commit</b></dt>
 <dd>The commit messages and authorship information will be scanned for the given pattern.</dd>
 EOT
-	my ($have_grep) = gitweb_check_feature('grep');
+	my $have_grep = gitweb_check_feature('grep');
 	if ($have_grep) {
 		print <<EOT;
 <dt><b>grep</b></dt>
@@ -5873,7 +5873,7 @@ EOT
 <dt><b>committer</b></dt>
 <dd>Name and e-mail of the committer and date of commit will be scanned for the given pattern.</dd>
 EOT
-	my ($have_pickaxe) = gitweb_check_feature('pickaxe');
+	my $have_pickaxe = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
 		print <<EOT;
 <dt><b>pickaxe</b></dt>
@@ -5925,7 +5925,7 @@ sub git_shortlog {
 
 sub git_feed {
 	my $format = shift || 'atom';
-	my ($have_blame) = gitweb_check_feature('blame');
+	my $have_blame = gitweb_check_feature('blame');
 
 	# Atom: http://www.atomenabled.org/developers/syndication/
 	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-- 
1.5.6.5
