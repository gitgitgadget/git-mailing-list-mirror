From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Ensure author information is set before asking for commit
 message.
Date: Sat, 13 May 2006 21:51:15 -0400
Message-ID: <BAYC1-PASMTP10DC791E7560155D9E71F4AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 14 03:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff5qh-0006Cp-0L
	for gcvg-git@gmane.org; Sun, 14 May 2006 03:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWENB4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWENB4k
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 21:56:40 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:56792 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932301AbWENB4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 21:56:40 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 13 May 2006 18:58:36 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id B2E6A644C17
	for <git@vger.kernel.org>; Sat, 13 May 2006 21:56:38 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060513215115.5bbae2ab.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 01:58:36.0750 (UTC) FILETIME=[E9C3DEE0:01C676F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It's better to find out you need to set your author information
properly before you enter a long commit message.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

 git-commit.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

ae880db6fc12a0774c25925abbcc353fe6c9e46f
diff --git a/git-commit.sh b/git-commit.sh
index 26cd7ca..866ed6c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -640,6 +640,7 @@ case "$no_edit" in
 		exit 1
 		;;
 	esac
+	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
-- 
1.3.2.g260bd
