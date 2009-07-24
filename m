From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 06/10] gitweb: Use light/dark for class names also in 'blame' view
Date: Sat, 25 Jul 2009 00:44:06 +0200
Message-ID: <1248475450-5668-7-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTWN-0007x3-QG
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbZGXWpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbZGXWpk
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:45:40 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:61555 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868AbZGXWpj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:45:39 -0400
Received: by fxm18 with SMTP id 18so1688410fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zN4oPN2GLTmSoM5RzHEprfpQ2XtuOr+m9HI9a1j0MXk=;
        b=aHIKXnBR6BvgSJthLp0s2f6CGh5aEl2qqOaHRxgvgbpPE8W/ICeb5DqPgepL7MFdOo
         NSio0VcvFOTdXPdHsN7BcSq6MTg5TmSC6Sx2coDhqkTvKCl8hluoAI4v7b5y4O1Lj6Vp
         NB2rQULWkmkiAPHgpNMRXRftUycFGDrQGLbmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QI5xzliVEfe0vL9DKDm0B0Klm6QXLusQm38fdmF35SYWaK/igk35LyrRXacuHaEPJN
         ohUGvAnxx8sPd/rDftF5WARIEs+JtXliR34DTqAp4FMpoa9featGX+/y2Aoqq5CcunaN
         8FlS2ybi7nx26NvdRNmEWdl9kEBAeKB694VPc=
Received: by 10.103.175.9 with SMTP id c9mr2046397mup.3.1248475538451;
        Fri, 24 Jul 2009 15:45:38 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id i5sm14981227mue.25.2009.07.24.15.45.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:45:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMp9ej005820;
	Sat, 25 Jul 2009 00:51:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMocGx005804;
	Sat, 25 Jul 2009 00:50:38 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123964>

Instead of using "light2" and "dark2" for class names in 'blame' view
(in place of "light" and "dark" classes in other places) to avoid
changing style on hover in 'blame' view while doing it for other views
(like 'shortlog'), use more advanced CSS, relying on the fact that
more specific selector wins.

While at it add a few comments to gitweb CSS file, and consolidate
some repeated info.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is identical to previous version (patch 4/3 in previous
version of this series).

This is an RFC because 

1. I am not sure if I did it correctly.  I had to fiddle a bit with CSS
(using "table.blame .light:hover" in place of "table.blame tr.light:hover")
to get the same behaviour (well, the same as far as I have checked it).

2. Commit message could use improvements (single sentence, blergh).

 gitweb/gitweb.css  |   17 ++++++++++-------
 gitweb/gitweb.perl |    2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 4763337..8f68fe3 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -226,22 +226,25 @@ th {
 	text-align: left;
 }
 
-tr.light:hover {
-	background-color: #edece6;
-}
-
-tr.dark {
-	background-color: #f6f6f0;
+/* do not change row style on hover for 'blame' view */
+tr.light,
+table.blame .light:hover {
+	background-color: #ffffff;
 }
 
-tr.dark2 {
+tr.dark,
+table.blame .dark:hover {
 	background-color: #f6f6f0;
 }
 
+/* currently both use the same, but it can change */
+tr.light:hover,
 tr.dark:hover {
 	background-color: #edece6;
 }
 
+/* boundary commits in 'blame' view */
+/* and commits without "previous" */
 tr.boundary td.sha1,
 tr.no-previous td.linenr {
 	font-weight: bold;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ea1ab5f..2cb60be 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4801,7 +4801,7 @@ sub git_blame {
 	git_print_page_path($file_name, $ftype, $hash_base);
 
 	# page body
-	my @rev_color = qw(light2 dark2);
+	my @rev_color = qw(light dark);
 	my $num_colors = scalar(@rev_color);
 	my $current_color = 0;
 	my %metainfo = ();
-- 
1.6.3.3
