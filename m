From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2 2/2] gitweb: clean up gitweb_check_feature() calls
Date: Sat, 29 Nov 2008 12:15:01 +0100
Message-ID: <1227957301-7417-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 12:16:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Nnz-0007Rp-4h
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 12:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbYK2LOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 06:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYK2LOs
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 06:14:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:56276 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbYK2LOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 06:14:47 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2171884ugf.37
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 03:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LrWez77sx3cXpAAfwGPoc/ac0hJx49YICk6mKsIlrd0=;
        b=Vu9oDy3+y9jUs6hEmVXjhA2cX0C2eU6CuubeGGG+pCPAbrzeYwLJ7t40bBKS39LX7h
         sWCkjTczfozvmU/15tRxzwlpTtiuseE4h3urBhdqgBxNj9H+BJDz3NWLJX7EWGw1uAwh
         n8x0IxBaaTqjvBKMCEqol2gSD31sg9n8rfbxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AS0O+zPQqlmp7hk8qw2iuv9BGDKqNCmkDrx6PGEIar9DmY3h8Qf/G4hSW4C+zKpWFq
         oEdbIUy5Vz19RVXHUOpSYLk1Iemw6zp1UGQdh7pVEaHEKA55CfwnIike9d/+jned7cEC
         as1BgKbHOwA4E95/i3VmLnW8FUWoE25KzAf9Y=
Received: by 10.66.221.19 with SMTP id t19mr1638361ugg.69.1227957285262;
        Sat, 29 Nov 2008 03:14:45 -0800 (PST)
Received: from localhost ([78.13.52.113])
        by mx.google.com with ESMTPS id p32sm1774894ugc.57.2008.11.29.03.14.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Nov 2008 03:14:44 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1227904793-1821-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101905>

Since git_check_feature now returns a scalar, the parentheses around the
variables initialized from gitweb_check_feature() are not needed.

We remove them for stylistic consistency and to prevent unnecessary
ambiguity in the code.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Fixed the commit message, use this instead of the previous one.

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
