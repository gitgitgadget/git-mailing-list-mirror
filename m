From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/9] git-verify-pack: show usage when no pack was specified
Date: Thu, 10 Aug 2006 17:02:31 +0200
Message-ID: <11552221581434-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3Z-0007Kf-59
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161299AbWHJPCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWHJPCl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:41 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:9413
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161299AbWHJPCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:39 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 6BC8C7028; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25189>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/verify-pack.c b/verify-pack.c
index ef00204..7201596 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -34,6 +34,7 @@ int main(int ac, char **av)
 	int errs = 0;
 	int verbose = 0;
 	int no_more_options = 0;
+	int nothing_done = 1;
 
 	while (1 < ac) {
 		char path[PATH_MAX];
@@ -50,8 +51,13 @@ int main(int ac, char **av)
 			strcpy(path, av[1]);
 			if (verify_one_pack(path, verbose))
 				errs++;
+			nothing_done = 0;
 		}
 		ac--; av++;
 	}
+
+	if (nothing_done)
+		usage(verify_pack_usage);
+
 	return !!errs;
 }
-- 
1.4.2.rc2.g822a
