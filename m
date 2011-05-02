From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: clarify meaning of --html-path, --man-path,
 and --info-path
Date: Mon, 2 May 2011 01:07:45 -0500
Message-ID: <20110502060745.GC14547@elie>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 08:07:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGmIY-0005hv-84
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 08:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab1EBGHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 02:07:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52242 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1EBGHv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 02:07:51 -0400
Received: by iyb14 with SMTP id 14so4421637iyb.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 23:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mxikdcd8SOEu9ef8dbEsc6SZI9T0YudC3mH6TvEjwrU=;
        b=xG8ws5xeV2/p0R7u2hD6UQ0S6RGWUCnb+SXNlz2NGtt0useEzAOq/P4DvrVNgRzrhz
         0P91vg7N+kSvOBXonUFIzNZBnk/x0csqDNt5gnwz6vI3q7cFyDyS057B+YrRgtrMC9QC
         HCnqpIxfjThz56meKRdzW0gvxJYDOb9ziWTy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KPbUCzh+gxNeD1pDa1162J+C/p3/a4qT4rDXsJZ6F2Xliuvtuq/unfnn6DXuP/6I5h
         /L/g1PgHBd/WuG40rRxANcWAifzL/KSw+/ExNd8PH531Va0gpfJZUhgHQP5tCaDK9Q5e
         zspwnQSkjGe54wgiOBFWa654kjjZLYCmX6gzc=
Received: by 10.42.147.137 with SMTP id n9mr9256019icv.383.1304316471037;
        Sun, 01 May 2011 23:07:51 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.sbcglobal.net [69.209.62.211])
        by mx.google.com with ESMTPS id 19sm2233593ibx.52.2011.05.01.23.07.49
        (version=SSLv3 cipher=OTHER);
        Sun, 01 May 2011 23:07:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172563>

These options tell UI programs where git put its documentation, so
"Help" actions can show the documentation for *this* version of git
without regard to how MANPATH and INFOPATH are set up.  Details:

. Each variable tells where documentation is expected to be.  They do
  not indicate whether documentation was actually installed.

. The output of "git --html-path" is an absolute path and can be used
  in "file://$(git --html-path)/git-add.html" to name the HTML file
  documenting a particular command.

. --man-path names a manual page hierarchy (e.g.,
  /home/user/share/man).  Its output can be passed to "man -M" or put
  at the beginning of $MANPATH.

. --info-path names a directory with info files (e.g.,
  /home/user/share/info).  Its output is suitable as an argument to
  "info -d" or for inclusion in $INFOPATH.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry for the long tangent.  Maybe a summary can be useful.

 Documentation/git.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7e9b521..5295315 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -287,16 +287,16 @@ help ...`.
 	the current setting and then exit.
 
 --html-path::
-	Print the path to wherever your git HTML documentation is installed
-	and exit.
+	Print the path, without trailing slash, where git's HTML
+	documentation is installed and exit.
 
 --man-path::
-	Print the path to wherever your git man pages are installed
-	and exit.
+	Print the manpath (see `man(1)`) for the man pages for
+	this version of git and exit.
 
 --info-path::
-	Print the path to wherever your git Info files are installed
-	and exit.
+	Print the path where the Info files documenting this
+	version of git are installed and exit.
 
 -p::
 --paginate::
-- 
1.7.5
