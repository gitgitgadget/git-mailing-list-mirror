From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Style all tables using CSS
Date: Mon, 19 Nov 2007 14:16:11 +0100
Message-ID: <1195478172-17226-2-git-send-email-jnareb@gmail.com>
References: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 14:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6Un-00070o-LU
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbXKSNQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXKSNQn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:16:43 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:33752 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbXKSNQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:16:42 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1825123fkz
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 05:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lrbv3pDyEnJ2HqG+Z1xCnTPq/zFlueISh4tsPk1cV4M=;
        b=A8HKjGZ0jduuTzoIDmBUiHieqAmiDY/EMNzMfxOzG4Yk/WmFcX5kxQ7guQ17VzyxHN1W5bUkHdWnsU4sVlZ9SkIBdAfpNYbRzgFC43oE1TBvKDq/d4W70pMlBlECgLphPOZcG1QdwAeQIGKvntq4iJePrmGowsK8276nB1rfKEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D8gEgAvK2P/AjbaQmNRCYfP2R4iL8ZCuH7L1TzSfS6pzCqb0c1Y7e9rwgbpfHD/f27MZjc2BpffPmWgnS53kv/ihZYlsGlfuS6CHq8gQ9mKDee6I9MTw9jL3KQCYGCOkYt7hAOsTiBNUUhFTNKaKL/f1PVvHLPEu4ronZ2OPYVw=
Received: by 10.82.126.5 with SMTP id y5mr13829929buc.1195478200794;
        Mon, 19 Nov 2007 05:16:40 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.246])
        by mx.google.com with ESMTPS id v23sm8801814fkd.2007.11.19.05.16.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 05:16:39 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lAJDGa9Q017265;
	Mon, 19 Nov 2007 14:16:36 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lAJDGPSU017264;
	Mon, 19 Nov 2007 14:16:25 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65438>

Remove all cellspacing="0" attributes from tables in gitweb,
replacing it by CSS rule.  Add CSS classes for all tables.

While at it, change class(es) of table for commit message and commit
authorship search from "grep" to "commit_search"; similarly,
"grep_search" class is now used for table with results of grep (files)
search.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
All tables now get equivalent of 'cellspacing="0"' attribute.

 gitweb/gitweb.css  |    4 ----
 gitweb/gitweb.perl |   22 +++++++++++-----------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 1b88879..17c60e4 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -170,14 +170,10 @@ a.text:hover {
 
 table {
 	padding: 8px 4px;
-}
-
-table.project_list {
 	border-spacing: 0;
 }
 
 table.diff_tree {
-	border-spacing: 0;
 	font-family: monospace;
 }
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e788ef9..3d532dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3544,7 +3544,7 @@ sub git_shortlog_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
-	print "<table class=\"shortlog\" cellspacing=\"0\">\n";
+	print "<table class=\"shortlog\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
@@ -3590,7 +3590,7 @@ sub git_history_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} unless (defined $to && $to <= $#{$commitlist});
 
-	print "<table class=\"history\" cellspacing=\"0\">\n";
+	print "<table class=\"history\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
@@ -3650,7 +3650,7 @@ sub git_tags_body {
 	$from = 0 unless defined $from;
 	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
 
-	print "<table class=\"tags\" cellspacing=\"0\">\n";
+	print "<table class=\"tags\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $taglist->[$i];
@@ -3713,7 +3713,7 @@ sub git_heads_body {
 	$from = 0 unless defined $from;
 	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
-	print "<table class=\"heads\" cellspacing=\"0\">\n";
+	print "<table class=\"heads\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
@@ -3750,7 +3750,7 @@ sub git_search_grep_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
-	print "<table class=\"grep\" cellspacing=\"0\">\n";
+	print "<table class=\"commit_search\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
@@ -3891,7 +3891,7 @@ sub git_summary {
 	git_print_page_nav('summary','', $head);
 
 	print "<div class=\"title\">&nbsp;</div>\n";
-	print "<table cellspacing=\"0\">\n" .
+	print "<table class=\"projects_list\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
@@ -3965,7 +3965,7 @@ sub git_tag {
 
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
-	      "<table cellspacing=\"0\">\n" .
+	      "<table class=\"object_header\">\n" .
 	      "<tr>\n" .
 	      "<td>object</td>\n" .
 	      "<td>" . $cgi->a({-class => "list", -href => href(action=>$tag{'type'}, hash=>$tag{'object'})},
@@ -4405,7 +4405,7 @@ sub git_tree {
 	}
 	git_print_page_path($file_name, 'tree', $hash_base);
 	print "<div class=\"page_body\">\n";
-	print "<table cellspacing=\"0\">\n";
+	print "<table class=\"tree\">\n";
 	my $alternate = 1;
 	# '..' (top directory) link if possible
 	if (defined $hash_base &&
@@ -4627,7 +4627,7 @@ sub git_commit {
 		git_print_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
 	}
 	print "<div class=\"title_text\">\n" .
-	      "<table cellspacing=\"0\">\n";
+	      "<table class=\"object_header\">\n";
 	print "<tr><td>author</td><td>" . esc_html($co{'author'}) . "</td></tr>\n".
 	      "<tr>" .
 	      "<td></td><td> $ad{'rfc2822'}";
@@ -5226,7 +5226,7 @@ sub git_search {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
-		print "<table cellspacing=\"0\">\n";
+		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
 		$/ = "\n";
 		my $git_command = git_cmd_str();
@@ -5293,7 +5293,7 @@ sub git_search {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
-		print "<table cellspacing=\"0\">\n";
+		print "<table class=\"grep_search\">\n";
 		my $alternate = 1;
 		my $matches = 0;
 		$/ = "\n";
-- 
1.5.3.5
