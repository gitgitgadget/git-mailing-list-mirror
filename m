From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 19/19] gitweb: Remove creating directory for temporary files
Date: Fri, 25 Aug 2006 21:35:27 +0200
Message-ID: <200608252135.27894.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 25 21:35:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGhSz-0005vB-Oc
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 21:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbWHYTfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 15:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWHYTfk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 15:35:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:44690 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422814AbWHYTfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 15:35:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so877293nfa
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 12:35:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DG8A/09XymLbZZjO2+euHQ/9lJ27Lqw6JlzrGUj/RiMK4cBbT1ZtSTmKDRbaKj6O7YIJj1oCLn+uqcyw5HVdOCG/Qr8zRJfXzEbUQNV/nHsdc0SIpYneQniXAV4xJ5+dgdKlxmbyt4mSlVfq7Pzxk2P4ndOPn+jQ3moOK6OzIUE=
Received: by 10.48.202.19 with SMTP id z19mr5801920nff;
        Fri, 25 Aug 2006 12:35:36 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id d2sm2934344nfe.2006.08.25.12.35.36;
        Fri, 25 Aug 2006 12:35:36 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26011>

Remove $git_temp variable which held location for temporary files
needed by git_diff_print, and removed creating $git_temp directory.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is last patch in this (admittedly quite large) series, removing
dependency on external diff, and the need for temporary files, from
gitweb.

You can view new gitweb in work at
  http://front.fuw.edu.pl/cgi-bin/jnareb/gitweb.cgi

Changes are in branch "gitweb/web" in repository available at
  http://front.fuw.edu.pl/jnareb/scm/git.git/

Comments appreciated.


 gitweb/gitweb.perl |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2f932f0..a6d6637 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -31,9 +31,6 @@ # absolute fs-path which will be prepend
 #our $projectroot = "/pub/scm";
 our $projectroot = "++GITWEB_PROJECTROOT++";
 
-# location for temporary files needed for diffs
-our $git_temp = "/tmp/gitweb";
-
 # target of the home link on top of all pages
 our $home_link = $my_uri || "/";
 
@@ -144,9 +141,6 @@ # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
 $projects_list ||= $projectroot;
-if (! -d $git_temp) {
-	mkdir($git_temp, 0700) || die_error(undef, "Couldn't mkdir $git_temp");
-}
 
 # ======================================================================
 # input validation and dispatch
-- 
1.4.1.1
