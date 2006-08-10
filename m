From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 8/9] git-verify-pack: no need to count errors
Date: Thu, 10 Aug 2006 17:02:37 +0200
Message-ID: <11552221583276-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:04:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3y-0007Pt-5u
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWHJPCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbWHJPCr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:10949
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161310AbWHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id BDDC47035; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25196>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/verify-pack.c b/verify-pack.c
index 1076001..f12cefe 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -49,7 +49,7 @@ static const char verify_pack_usage[] = 
 
 int main(int ac, char **av)
 {
-	int errs = 0;
+	int err = 0;
 	int verbose = 0;
 	int no_more_options = 0;
 	int nothing_done = 1;
@@ -65,7 +65,7 @@ int main(int ac, char **av)
 		}
 		else {
 			if (verify_one_pack(av[1], verbose))
-				errs++;
+				err = 1;
 			nothing_done = 0;
 		}
 		ac--; av++;
@@ -74,5 +74,5 @@ int main(int ac, char **av)
 	if (nothing_done)
 		usage(verify_pack_usage);
 
-	return !!errs;
+	return err;
 }
-- 
1.4.2.rc2.g822a
