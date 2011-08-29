From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/2] am: fix stgit patch mangling
Date: Mon, 29 Aug 2011 18:44:07 +0200
Message-ID: <1314636247-26125-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4x6-0000C8-PH
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab1H2Qok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:44:40 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39775 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab1H2Qoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:44:39 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so5919990wwf.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 09:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hKxF4limngpwjIJObF+X9Sba+lmb/GZFnEoO/d7G8uI=;
        b=JfsgAMkZv5B/dmoprykh7QeP3NcYRINEaWMFsEs91QYq00eTnPDJcUeO5ZjMHDEewc
         du8knTuDuzQH3xNJl4rKl34C/awdckfe+zQ584ZLbV77encKzDscdvWlwRU9XQ2GxWZP
         031x9DItIggNoZLywZYFpFdAyxM6woZgvk+WE=
Received: by 10.216.194.70 with SMTP id l48mr1807277wen.89.1314636278825;
        Mon, 29 Aug 2011 09:44:38 -0700 (PDT)
Received: from localhost ([151.54.153.147])
        by mx.google.com with ESMTPS id b47sm3029750wed.46.2011.08.29.09.44.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 09:44:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.331.g25483.dirty
In-Reply-To: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180318>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 729ee51..14696d4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -295,7 +295,7 @@ split_patches ()
 			perl -ne 'BEGIN { $subject = 0 }
 				if ($subject > 1) { print ; }
 				elsif (/^\s+$/) { next ; }
-				elsif (/^Author:/) { print s/Author/From/ ; }
+				elsif (/^Author:/) { s/Author/From/ ; print ;}
 				elsif (/^(From|Date)/) { print ; }
 				elsif ($subject) {
 					$subject = 2 ;
-- 
1.7.7.rc0.331.g25483.dirty
