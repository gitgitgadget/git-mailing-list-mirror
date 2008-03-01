From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: FastCGI support in gitweb
Date: Sat, 01 Mar 2008 13:50:23 -0800 (PST)
Message-ID: <m38x12jeqt.fsf@localhost.localdomain>
References: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: "Juan Jose Comellas" <juanjo@comellas.org>,
	Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Mar 01 22:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVZcA-0001LP-HS
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 22:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbYCAVui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 16:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbYCAVui
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 16:50:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:48700 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050AbYCAVu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 16:50:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1067276ugc.16
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 13:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=ww8CqB6oU3CuTrxTEVRYDAWCggEOJA+1xUbmaaTQuuQ=;
        b=FenHH25GEHd0nOOyPs/A66yB1N44YKyj60/i7SDhq9j45URA/vhtFjEPh3xSGWwsa0PTKbAxyYqkemHJfNlPKG6ia2MHZRwTg7kMlWHwjpVuZgwcl9bMA2EpJdmO32C89v0WLeiUdYq0wFdH91oi65rQ9BFLoOyN+ETm2+PMUc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=JILRMLvQVnVVyFXn27D8hb1WuqrUjjPGa7/H9jeloOttTUCyskYVUQjpTl6vtvf3c0WIytNWqWZsliS/qg6vAF4V15GGVoHZR50Uyd/9MiQnUlLHpRwVCNJ1XQKCyw3MuSl/ARL6rBWGQv/KUPkJYk5DhmoRzqoE/FvQxFWQnYY=
Received: by 10.67.26.7 with SMTP id d7mr3294811ugj.23.1204408224408;
        Sat, 01 Mar 2008 13:50:24 -0800 (PST)
Received: from localhost.localdomain ( [83.8.199.142])
        by mx.google.com with ESMTPS id 5sm1292438ugc.25.2008.03.01.13.50.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 13:50:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m21LoM3n002460;
	Sat, 1 Mar 2008 22:50:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m21LoIOE002457;
	Sat, 1 Mar 2008 22:50:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1c3be50f0803011334u2629011cg85cb8728a244ea4e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75705>

--=-=-=

"Juan Jose Comellas" <juanjo@comellas.org> writes:

> I've seen that the current version of Gitweb (1.5.4.2) does not
> support FastCGI, and looking in Google I found that about a year ago a
> patch was sent to the list adding this functionality to it. I couldn't
> find any additional emails indicating why they weren't accepted. Is
> there any plan to add FastCGI support to Gitweb?

First, as far as I understand it, the patch made gitweb had to be used
with FastCGI server.  It has no comments in code, and if I remember
correctly the commit message was also fairly nonexistent.  It mixes
FastCGI changes with site-wide changes.  It wrapped the whole file in
"until last request" loop instead of wrapping dispatch only.

Also I am not sure if gitweb doesn't rely on variables being correctly
set which they are not in FastCGI mode.

But most important part: it was never resend (IIRC it was send when
gitweb development was in separate repository)


I have attached the FastCGI patch and CC-ed the author.

--=-=-=
Content-Disposition: attachment; filename=gitweb-FastCGI.patch
Content-Description: gitweb-FastCGI.patch

From: root <root@vgasm.watts.utsl.gen.nz>
Date: Wed, 22 Mar 2006 00:53:07 +0000 (+1200)
Subject: add support for FastCGI
X-Git-Url: http://utsl.gen.nz/gitweb/?p=gitweb;a=commitdiff;h=56d7d436644ab296155a697552ea1345f2701620

add support for FastCGI
---

--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -5,10 +5,22 @@
 # (C) 2005, Kay Sievers <kay.sievers@vrfy.org>
 # (C) 2005, Christian Gierke <ch@gierke.de>
 #
+# FastCGI adaptations:
+#   (c) 2006, Sam Vilain <sam.vilain@catalyst.net.nz>
+#
 # This program is licensed under the GPLv2
 
+# 
+
 use strict;
 use warnings;
+
+my $last_request = sub { 1 };
+my $pre_dispatch_hook = sub { };
+my $post_dispatch_hook = sub { };
+my $CGI = "CGI";
+my $pre_listen_hook = sub { };
+
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
@@ -16,7 +28,34 @@ use Encode;
 use Fcntl ':mode';
 binmode STDOUT, ':utf8';
 
-my $cgi = new CGI;
+    if (@ARGV) {
+	require Getopt::Long;
+	Getopt::Long::GetOptions
+	    ( "fastcgi|f" => sub {
+		  require CGI::Fast;
+		  $CGI = "CGI::Fast";
+		  my $c;
+		  # let each child service 100 requests
+		  $last_request = sub { ++$c > 100 }
+	      },
+              "nproc|n=i"   => sub {
+		  my ($arg, $val) = @_;
+		  require FCGI::ProcManager;
+                  my $pm = FCGI::ProcManager->new({
+			n_processes => $val,
+                  });
+	          $pre_listen_hook    = sub { $pm->pm_manage        };
+	          $pre_dispatch_hook  = sub { $pm->pm_pre_dispatch  };
+	          $post_dispatch_hook = sub { $pm->pm_post_dispatch };
+              },
+            );
+    }
+
+$pre_listen_hook->();
+do {
+my $cgi = $CGI->new or last;
+$pre_dispatch_hook->();
+
 my $version =		"264";
 my $my_url =		$cgi->url();
 my $my_uri =		$cgi->url(-absolute => 1);
@@ -24,7 +63,7 @@ my $rss_link =		"";
 
 # absolute fs-path which will be prepended to the project path
 #my $projectroot =	"/pub/scm";
-my $projectroot =	"/home/kay/public_html/pub/scm";
+my $projectroot =	"/var/lib/git";
 
 # location of the git-core binaries
 my $gitbin =		"/usr/bin";
@@ -40,7 +79,7 @@ my $home_text =		"indextext.html";
 
 # source of projects list
 #my $projects_list =	$projectroot;
-my $projects_list =	"index/index.aux";
+my $projects_list =	"/var/lib/git";
 
 # input validation and dispatch
 my $action = $cgi->param('a');
@@ -51,10 +90,10 @@ if (defined $action) {
 	}
 	if ($action eq "git-logo.png") {
 		git_logo();
-		exit;
+	goto out;
 	} elsif ($action eq "opml") {
 		git_opml();
-		exit;
+	goto out;
 	}
 }
 
@@ -85,7 +124,7 @@ if (defined $project) {
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
 } else {
 	git_project_list();
-	exit;
+	goto out;
 }
 
 my $file_name = $cgi->param('f');
@@ -154,61 +193,62 @@ sub validate_input {
 
 if (!defined $action || $action eq "summary") {
 	git_summary();
-	exit;
+	goto out;
 } elsif ($action eq "heads") {
 	git_heads();
-	exit;
+	goto out;
 } elsif ($action eq "tags") {
 	git_tags();
-	exit;
+	goto out;
 } elsif ($action eq "blob") {
 	git_blob();
-	exit;
+	goto out;
 } elsif ($action eq "blob_plain") {
 	git_blob_plain();
-	exit;
+	goto out;
 } elsif ($action eq "tree") {
 	git_tree();
-	exit;
+	goto out;
 } elsif ($action eq "rss") {
 	git_rss();
-	exit;
+	goto out;
 } elsif ($action eq "commit") {
 	git_commit();
-	exit;
+	goto out;
 } elsif ($action eq "log") {
 	git_log();
-	exit;
+	goto out;
 } elsif ($action eq "blobdiff") {
 	git_blobdiff();
-	exit;
+	goto out;
 } elsif ($action eq "blobdiff_plain") {
 	git_blobdiff_plain();
-	exit;
+	goto out;
 } elsif ($action eq "commitdiff") {
 	git_commitdiff();
-	exit;
+	goto out;
 } elsif ($action eq "commitdiff_plain") {
 	git_commitdiff_plain();
-	exit;
+	goto out;
 } elsif ($action eq "history") {
 	git_history();
-	exit;
+	goto out;
 } elsif ($action eq "search") {
 	git_search();
-	exit;
+	goto out;
 } elsif ($action eq "shortlog") {
 	git_shortlog();
-	exit;
+	goto out;
 } elsif ($action eq "tag") {
 	git_tag();
-	exit;
+	goto out;
 } else {
 	undef $action;
 	die_error(undef, "Unknown action.");
-	exit;
 }
 
+$post_dispatch_hook->();
+
 # quote unsafe chars, but keep the slash, even when it's not
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
@@ -2405,3 +2445,7 @@ sub git_shortlog {
 	print "</table\n>";
 	git_footer_html();
 }
+
+out:
+    exit;
+} until ( $last_request->() );

--=-=-=


-- 
Jakub Narebski
Poland
ShadeHawk on #git

--=-=-=--
