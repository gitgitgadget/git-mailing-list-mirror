From: Jonathan Nieder <jrnieder@gmail.com>
Subject: PATCH 09/10] Update svn-fe manual
Date: Mon, 9 Aug 2010 17:55:43 -0500
Message-ID: <20100809225543.GE4429@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OibHo-0004Ua-3F
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab0HIW5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:57:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43045 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0HIW5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:57:10 -0400
Received: by vws3 with SMTP id 3so7134920vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bsI5UtKWzI7TvAxTi0gchoJQXir1HITZpCMz+mKGT3s=;
        b=OZZTUpPEmfYs4miudrGtvVCQIDoBMXEzkR2ytGVKhiDOpzh7JeUEtiRuKyT8dmWsB0
         2ffuV9MV9TpyM3qxiw1DHJEb291HFeVfC/CHtyQ1Rxf2hoq+LtRDQ6uZw4b0RQVSD95x
         ocooDYhvZjhdLQJTSx4jVsxpP7VAHI6nQJvQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Pmj0+aoVMcC3Ztlt4Si5mYcsEs9lhvm7ivVSxBqEPzl2gbXWRhiWmkkcnxy49qtnvw
         lfQ4hNM07VAVy0BXBP7o+eZHYT2zhgofRNCF+FYfTt2MGwCb0LzdXy2rs94vG+0087UZ
         qp8KK6adT0CsuprlzHdGu3A6yUW6GBIT9xWbU=
Received: by 10.220.59.202 with SMTP id m10mr9874736vch.188.1281394629843;
        Mon, 09 Aug 2010 15:57:09 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id v11sm2895241vbb.11.2010.08.09.15.57.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:57:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153046>

The svn-fe example does not litter the working directory with
.bin files any more (hoorah!).

The permissive error handling implies a known bug.  We should
be flagging iffy input and, even if we continue, reporting it
on exit.

Cc: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/svn-fe.txt |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index de30f83..fb0ee56 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -43,11 +43,9 @@ user <user@UUID>
 as committer, where 'user' is the value of the `svn:author` property
 and 'UUID' the repository's identifier.
 
-To support incremental imports, 'svn-fe' will put a `git-svn-id`
-line at the end of each commit log message if passed an url on the
-command line.  This line has the form `git-svn-id: URL@REVNO UUID`.
-
-Empty directories and unknown properties are silently discarded.
+To support incremental imports, 'svn-fe' puts a `git-svn-id` line at
+the end of each commit log message if passed an url on the command
+line.  This line has the form `git-svn-id: URL@REVNO UUID`.
 
 The resulting repository will generally require further processing
 to put each project in its own repository and to separate the history
@@ -56,9 +54,9 @@ may be useful for this purpose.
 
 BUGS
 ----
-Litters the current working directory with .bin files for
-persistence. Will be fixed when the svn-fe infrastructure is aware of
-a Git working directory.
+Empty directories and unknown properties are silently discarded.
+
+The exit status does not reflect whether an error was detected.
 
 SEE ALSO
 --------
-- 
1.7.2.1.544.ga752d.dirty
