From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH (contingency)] Document "curl" requirements.
Date: Wed, 13 Jul 2005 13:11:00 -0700
Message-ID: <7vk6juxy97.fsf@assigned-by-dhcp.cox.net>
References: <20050713021240.88AAD63780@morimoto.progeny.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:15:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsndA-0002uk-4l
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVGMUOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVGMUMU
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:12:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24772 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262757AbVGMULD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 16:11:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713201100.YFHI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 16:11:00 -0400
To: darrint@progeny.com (Darrin Thompson)
In-Reply-To: <20050713021240.88AAD63780@morimoto.progeny.com> (Darrin Thompson's message of "Tue, 12 Jul 2005 21:12:40 -0500 (EST)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

darrint@progeny.com (Darrin Thompson) writes:

> Cause setting environment variable GIT_SSL_NO_VERIFY to turn off
> curl's ssl peer verification.
>
> Only use curl for http transfers, instead of curl and wget.

I do not mind curl per se, since we already require libcurl for
http-pull, but it would be nice if we document what external
software we depend on in one place.  Something like this on top
of what you posted?

------------
Not just libcurl, but now we require curl executable as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/INSTALL b/INSTALL
--- a/INSTALL
+++ b/INSTALL
@@ -41,8 +41,10 @@ Issues of note:
 	  can avoid the bignum support by excising git-rev-list support
 	  for "--merge-order" (by hand).
 
-	- "libcurl".  git-http-pull uses this.  You can disable building of
-	  that program if you just want to get started. 
+	- "libcurl" and "curl" (executable).  git-http-pull and
+	  git-fetch-script use them.  If you do not use http
+	  transfer, you are probabaly OK if you do not have
+	  these two.
 
 	- "GNU diff" to generate patches.  Of course, you don't _have_ to
 	  generate patches if you don't want to, but let's face it, you'll
