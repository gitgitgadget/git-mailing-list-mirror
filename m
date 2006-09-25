From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] Remove git-zip-tree
Date: Mon, 25 Sep 2006 12:31:52 +0200
Message-ID: <4517B018.4040907@innova-card.com>
References: <45154D63.8030107@lsrfire.ath.cx>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 25 12:31:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRnkA-0008OU-3v
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 12:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWIYKbL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 06:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWIYKbL
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 06:31:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:44710 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751000AbWIYKbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 06:31:09 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1476746nfa
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 03:31:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=VNA5oHl+7OS3O3EeOXJ6VdJwEEqbhw3NWr63o7P0lGXz65rBkjHsyxBV55XWJa5f+InHMYjkBH7SkB4OliYK55E/WkvKzBcJPHSCGRyMUBiSFDU8awXDYez6MufV5ft9wcjiICB5RwSr663O1YKGZTYJSDb1RtanFR6Xbx00cGo=
Received: by 10.48.162.15 with SMTP id k15mr1251800nfe;
        Mon, 25 Sep 2006 03:31:08 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id r33sm4834649nfc.2006.09.25.03.31.06;
        Mon, 25 Sep 2006 03:31:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <45154D63.8030107@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27732>

Rene Scharfe wrote:
> git-zip-tree can be safely removed because it was never part of a formal
> release.  This patch makes 'git-archive --format=zip' the one and only git
> ZIP file creation command.  
> 
[snip]
> -
> -Currently git-zip-tree can handle only files and directories, symbolic
> -links are not supported.
> -
> -OPTIONS
> --------
> -
> --0::
> -	Store the files instead of deflating them.
> -
> --9::
> -	Highest and slowest compression level.  You can specify any
> -	number from 1 to 9 to adjust compression speed and ratio.
> -

We should keep these options documented somewhere... What about this ?

-- >8 --

Subject: [PATCH] git-archive: update documentation

This patch documents zip backend options.

It also adds git-archive command into the main git manual
page.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 Documentation/git-archive.txt |   13 +++++++++++++
 Documentation/git.txt         |    3 +++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 913528d..031fcd5 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -40,6 +40,7 @@ OPTIONS
 
 <extra>::
 	This can be any options that the archiver backend understand.
+	See next section.
 
 --remote=<repo>::
 	Instead of making a tar archive from local repository,
@@ -52,6 +53,18 @@ path::
 	If one or more paths are specified, include only these in the
 	archive, otherwise include all files and subdirectories.
 
+BACKEND EXTRA OPTIONS
+---------------------
+
+zip
+~~~
+-0::
+	Store the files instead of deflating them.
+-9::
+	Highest and slowest compression level.  You can specify any
+	number from 1 to 9 to adjust compression speed and ratio.
+
+
 CONFIGURATION
 -------------
 By default, file and directories modes are set to 0666 or 0777 in tar
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 1bf5ef5..2135b65 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -266,6 +266,9 @@ gitlink:git-am[1]::
 gitlink:git-applymbox[1]::
 	Apply patches from a mailbox, original version by Linus.
 
+gitlink:git-archive[1]::
+	Creates an archive of files from a named tree.
+
 gitlink:git-bisect[1]::
 	Find the change that introduced a bug by binary search.
 
-- 
1.4.2.1
