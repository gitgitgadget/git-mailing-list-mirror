From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive without path
Date: Sat, 05 Dec 2009 00:11:01 +0100
Message-ID: <4B199705.5010202@lsrfire.ath.cx>
References: <20091130123203.GA11235@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhJ7-0002fz-1X
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbZLDXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757614AbZLDXLL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:11:11 -0500
Received: from india601.server4you.de ([85.25.151.105]:35605 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757613AbZLDXLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 18:11:09 -0500
Received: from [10.0.1.101] (p57B7BFCB.dip.t-dialin.net [87.183.191.203])
	by india601.server4you.de (Postfix) with ESMTPSA id 1319D2F8065;
	Sat,  5 Dec 2009 00:11:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091130123203.GA11235@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134583>

Dmitry Potapov schrieb:
> I have never run "git archive" inside of a subdirectory but somehow I
> have always assumed that it creates an archive containing all files in
> it regardless the current directory. In fact, the git-archive man page
> says so:
> 
> path
>     If one or more paths are specified, include only these in the
>     archive, otherwise include all files and subdirectories.

This sentence doesn't specify whose files and subdirectories are to be
included -- those in the repository's root or those in the current
directory.  Let's fix that.

-- >8 --
Subject: archive: clarify description of path parameter

Mention that path parameters are based on the current working directory.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
--
 Documentation/git-archive.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 3d1c1e7..e579791 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -74,8 +74,9 @@ OPTIONS
 	The tree or commit to produce an archive for.
 
 path::
-	If one or more paths are specified, include only these in the
-	archive, otherwise include all files and subdirectories.
+	Without an optional path parameter, all files and subdirectories
+	of the current working directory are included in the archive.
+	If one or more paths are specified, only these are included.
 
 BACKEND EXTRA OPTIONS
 ---------------------
