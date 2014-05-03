From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Sat,  3 May 2014 22:49:30 +1000
Message-ID: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOT-0001U2-G9
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaECMuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:08 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61075 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECMuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:06 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so2278226pdj.18
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6H8mLQApKKITYWjDBCErzEemfArjWawAkAlHRTOSEjI=;
        b=PrKEcgeymUlc5PbZujwV2itwjR6fch2LL65+WAtCRMxkn/R1dGVdvYFqRUIbUkoU+9
         vNbmggGbvkq+D07iyEMVk5zGqHUOeNX5qkHmZG+duU2QAPQJoUXcj+3DACOKv9nIt5gj
         OJz1J66L/RwUZ68nw/Q8QmaVmOaF/4YxFKzgAjgbmMBE2mWZN6l9+nN3BxePI00lQP57
         kxYJSjj4aOeZTIuO6Lic4awM+I9H52AYO7mT0ng/AFVKE7JmhdMzgJIA/cXK/eNwesi7
         rBxVm1R6UkCFst/Yf/mlwuvBFZktU//SYWEOx3luBTBiaY3yJm4TWRGDCmSYA9gr1Eu2
         Ed1A==
X-Received: by 10.66.147.99 with SMTP id tj3mr17227775pab.47.1399121405312;
        Sat, 03 May 2014 05:50:05 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.49.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:04 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248038>

contrib/subtree/Makefile is a shambles in regards to it's consistency
with other makefiles, which makes subtree overly painful to include in
build scripts.

The main issues are that calls are made to git itself in the build
process, and that a subtree-exclusive variable is used for specifying
the exec path. Patches 1/5 through 3/5 resolve these.

The "cleanup" fixes (4/5 and 5/5) are based on precedents set by other
makefiles across the project.

One problem is foreseen: 3/5 will necessitate that package maintainers
who already have git-subtree included in their packages update their
build-scripts.

Signed-off-by: James Denholm <nod.helm@gmail.com>
Based-on-patch-by: Dan McGee <dpmcgee@gmail.com>

James Denholm (5):
  contrib/subtree/Makefile: scrap unused $(gitdir)
  contrib/subtree/Makefile: Use GIT-VERSION-FILE
  contrib/subtree/Makefile: s/libexecdir/gitexecdir
  contrib/subtree/Makefile: Doc-gen rules cleanup
  contrib/subtree/Makefile: clean rule cleanup

 contrib/subtree/Makefile | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
1.9.2
