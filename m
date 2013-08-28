From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/8] remote-hg: fix test
Date: Wed, 28 Aug 2013 14:23:08 -0500
Message-ID: <1377717793-27170-4-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPd-0003YT-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030Ab3H1T2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:11 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:59595 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3H1T2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:10 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so7264083obc.34
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jbzXYb7Y3rrRXBhoGVaYc3yx9Qg24QelVotyluP8HQ0=;
        b=NvZ/JNN6FiEfjTpAD1xC9/Jzl+3da6CVMeJyI7bxaawmghiw0TdFNa+FN0lH2Bjkea
         2Dvy040Gh7yTSjY8K5K1b2kT529OjzAT6fbz4ONXrFrYGRQ8E8rTnj/JdFD4Pi/vlxq6
         fgyl/Dsz8ESVYPeS/LregN7E/KGMkTf0Oj9CSHO5dq8rIiHrj30wDnawkFBFAQey97bJ
         XO5Kn+p2g33P3NB1iqYNRMEHdU4lDjrvVaFemyDtlI9AEo6NqyCZGLWhdJ23GVfsamjc
         B1Gm0LhyW162BY8mBPK4Fe0l5KyZjEZiSgyWGw88Y2EJTznfNIKWsgYbb85ZftWe7g5z
         bl4Q==
X-Received: by 10.182.237.107 with SMTP id vb11mr7939450obc.84.1377718089424;
        Wed, 28 Aug 2013 12:28:09 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm27512785obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:08 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233196>

It wasn't being checked properly before; those refs never existed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index f7ce8aa..cbf8617 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -580,8 +580,6 @@ test_expect_success 'remote big push fetch first' '
 	check_push 1 --all <<-EOF
 	master
 	good_bmark
-	new_bmark:new
-	new_branch:new
 	bad_bmark:fetch-first
 	branches/bad_branch:festch-first
 	EOF
-- 
1.8.4-fc
