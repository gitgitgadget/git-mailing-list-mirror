From: "martin f. krafft" <madduck@debian.org>
Subject: [TopGit PATCH] Print help message when command is not proper
Date: Thu, 20 Nov 2008 13:08:48 +0100
Message-ID: <1227182928-24916-1-git-send-email-madduck@debian.org>
Cc: "martin f. krafft" <madduck@debian.org>
To: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Thu Nov 20 13:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L38MZ-0002cl-Lw
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 13:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbYKTMJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 07:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754254AbYKTMJB
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 07:09:01 -0500
Received: from clegg.madduck.net ([193.242.105.96]:55512 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbYKTMJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 07:09:01 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 950031D40AF;
	Thu, 20 Nov 2008 13:08:50 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id EAB619F34F;
	Thu, 20 Nov 2008 13:08:48 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A821445F4; Thu, 20 Nov 2008 13:08:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
X-Virus-Scanned: ClamAV 0.94.1/8653/Thu Nov 20 10:04:07 2008 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101411>

When invoked with an unknown subcommand, or when --help is sought for
a command that does not exist, TopGit prints the help message.

Signed-off-by: martin f. krafft <madduck@debian.org>

---
 tg.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/tg.sh b/tg.sh
index 4dcc15e..2464612 100644
--- a/tg.sh
+++ b/tg.sh
@@ -232,6 +232,8 @@ do_help()
 		fi
 	else
 		echo "`basename $0`: no help for $1" 1>&2
+		do_help
+		exit 1
 	fi
 }
 
@@ -279,6 +281,7 @@ help|--help|-h)
 *)
 	[ -r "@cmddir@"/tg-$cmd ] || {
 		echo "Unknown subcommand: $cmd" >&2
+		do_help
 		exit 1
 	}
 	. "@cmddir@"/tg-$cmd;;
-- 
tg: (f17218e..) fixes/more-help (depends on: upstream)
