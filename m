From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: use single quotes for values replaced by the Makefile
Date: Wed, 2 Aug 2006 22:17:20 +0200
Message-ID: <E1G8N9c-0004GK-Gz@moooo.ath.cx>
References: <20060802192333.GA30861@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 22:17:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8N9l-0003tw-JF
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 22:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHBURZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWHBURZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 16:17:25 -0400
Received: from moooo.ath.cx ([85.116.203.178]:12163 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932173AbWHBURY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 16:17:24 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060802192333.GA30861@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24673>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
This patch is on top of the last one.
> Now I noticed a problem: do not use the @@FOO@@ in double quotes
> because perl will spit a lot of warnings like "Possible unintended
> interpolation of @GIT_VERSION in string" Either we should use
> another delimiter or use single quotes (this is the way it is done
> in git-send-email.perl and git-svn.perl).  I don't know how likely
> it is that characters that are interpreted different in double
> quotes are in filenames but I'd prefer single quotes just to be on
> the safe site.  This disallows using '/etc/foo/$ENV{SITE_NAME}' as
> config file but one can just use '/etc/foo/bar' which requires
> '/etc/foo/$ENV{SITE_NAME}'.
---
 gitweb/gitweb.perl |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d5b2de8..f4c0d87 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,18 +18,18 @@ use File::Find qw();
 binmode STDOUT, ':utf8';
 
 our $cgi = new CGI;
-our $version = "@@GIT_VERSION@@";
+our $version = '@@GIT_VERSION@@';
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
 our $rss_link = "";
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-our $GIT = "@@GIT_BINDIR@@/git";
+our $GIT = '@@GIT_BINDIR@@/git';
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
-our $projectroot = "@@GITWEB_PROJECTROOT@@";
+our $projectroot = '@@GITWEB_PROJECTROOT@@';
 
 # location for temporary files needed for diffs
 our $git_temp = "/tmp/gitweb";
@@ -39,18 +39,18 @@ our $home_link = $my_uri;
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = "@@GITWEB_SITENAME@@" || $ENV{'SERVER_NAME'} || "Untitled";
+our $site_name = '@@GITWEB_SITENAME@@' || $ENV{'SERVER_NAME'} || "Untitled";
 
 # html text to include at home page
-our $home_text = "@@GITWEB_HOMETEXT@@";
+our $home_text = '@@GITWEB_HOMETEXT@@';
 
 # URI of default stylesheet
-our $stylesheet = "@@GITWEB_CSS@@";
+our $stylesheet = '@@GITWEB_CSS@@';
 # URI of GIT logo
-our $logo = "@@GITWEB_LOGO@@";
+our $logo = '@@GITWEB_LOGO@@';
 
 # source of projects list
-our $projects_list = "@@GITWEB_LIST@@";
+our $projects_list = '@@GITWEB_LIST@@';
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
@@ -60,7 +60,7 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
-our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
+our $GITWEB_CONFIG = '@@GITWEB_CONFIG@@';
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
 # version of the core git binary
-- 
1.4.2.rc2.g4713
