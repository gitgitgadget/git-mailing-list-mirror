From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove CGI::Carp::set_programname() call from t9500 gitweb test
Date: Thu,  1 Nov 2007 14:23:16 +0100
Message-ID: <1193923396-17341-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 14:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZyt-0002f9-FF
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbXKANUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbXKANUy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:20:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:8433 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbXKANUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:20:53 -0400
Received: by ug-out-1314.google.com with SMTP id z38so465522ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 06:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+wBfx9tBqpS1+Bt9Hd8/93oID36QsHbpPhnrFOYxLjI=;
        b=QhsbRFri/mfP57uWvw7FyeWXv0Pt8vhPdkbSVe9ozUWdLdU1x3ZY8xPZ0XOo+bfEzy7/0XAxB9KbiV4VwF3oiqihR9Stooq+SopCXZ75FKAtqaIvuVXUTbUtYjbgNOqbY5ZzRPCIdpxVL65u5rgJpDh9hDHuWFD6gTwNHM47tak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=q1446N1VB2vKp6w9VLVJa8Lb6Lv6GiA/9EhA7pjpNn0lyQojG3aQKedeaYMDptisglFMtV3p10JEv9uQ9Ismfg2NIPVtKgXF2CzbLwVGyPV3c33VvDGs8OsFL5cTv69UQzdRZ1H0kzdNYsVPPSFCyvRhmF8aapsSd2BMwaRIqQw=
Received: by 10.66.220.17 with SMTP id s17mr1099860ugg.1193923251556;
        Thu, 01 Nov 2007 06:20:51 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id 25sm2248677ugn.2007.11.01.06.20.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 06:20:49 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1DNMe0017358;
	Thu, 1 Nov 2007 14:23:22 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1DNGWA017356;
	Thu, 1 Nov 2007 14:23:16 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62956>

It does appear to do nothing; gitweb is run as standalone program
and not as CGI script in this test.  This call caused problems later.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t9500-gitweb-standalone-no-errors.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index f7bad5b..1bf0988 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -31,7 +31,6 @@ our \$projects_list = "";
 our \$export_ok = "";
 our \$strict_export = "";
 
-CGI::Carp::set_programname("gitweb/gitweb.cgi");
 EOF
 
 	cat >.git/description <<EOF
-- 
1.5.3.5
