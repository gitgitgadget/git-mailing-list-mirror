From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] Apply N -> A status change in diff-helper
Date: Mon, 12 Sep 2005 11:03:43 +1000
Message-ID: <20050912010343.GA32376@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
X-From: git-owner@vger.kernel.org Mon Sep 12 03:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEcjl-0006Uo-0v
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVILBDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVILBDy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:03:54 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:10182 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1751114AbVILBDy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 21:03:54 -0400
Received: (qmail 4135 invoked by uid 507); 12 Sep 2005 11:03:46 +1000
Received: from 22.107.233.220.exetel.com.au (HELO arnor.apana.org.au) (220.233.107.22)
  by jay.exetel.com.au with SMTP; 12 Sep 2005 11:03:46 +1000
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.36 #1 (Debian))
	id 1EEcjZ-0007Cl-00; Mon, 12 Sep 2005 11:03:45 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1EEcjX-0008QT-00; Mon, 12 Sep 2005 11:03:43 +1000
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8355>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

When the git diff status 'N' was changed to 'A', diff-helper.c was
not updated accordingly.  This means that it no longer shows the
diff for newly added files.

This patch makes that change in diff-helper.c.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -91,7 +91,7 @@ int main(int ac, const char **av) {
 			if (*cp++ != ' ')
 				break;
 			status = *cp++;
-			if (!strchr("MCRNDU", status))
+			if (!strchr("AMCRDU", status))
 				break;
 			two_paths = score = 0;
 			if (status == DIFF_STATUS_RENAMED ||

--azLHFNyN32YCQGCU--
