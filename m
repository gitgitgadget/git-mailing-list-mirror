From: Cheng Leong <leongc@alumni.rice.edu>
Subject: [PATCH/RFC] Restore line limit option in post-receive-email
Date: Fri, 11 Nov 2011 00:35:11 -0600
Message-ID: <1320993311-27112-1-git-send-email-leongc@alumni.rice.edu>
Cc: kpfleming@digium.com, Cheng Leong <leongc@alumni.rice.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 07:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROkiM-0000yQ-S8
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 07:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab1KKGfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 01:35:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51748 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab1KKGfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 01:35:41 -0500
Received: by ggnb2 with SMTP id b2so3859501ggn.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=PntdZrvXM25LU/GIY+fCDinx5cpDy01tSe860+QDtSw=;
        b=ZV3Oez2rtNBXSjBTe0pstXJ9Zsg7qKLX4P7b2hmo1lovYwlyed3p3ysoD/p/u+GlNA
         cC4I1X+W2FImn7y4aaWeuz/hsTciEzFdvPF3TKcgLhJRTwv34Iu1BCdoXvlzFayzafoy
         13xk/pZbuIFs324+1m2biaY/AhzGbYOLa2auA=
Received: by 10.146.74.10 with SMTP id w10mr1239718yaa.14.1320993341417;
        Thu, 10 Nov 2011 22:35:41 -0800 (PST)
Received: from localhost (adsl-71-145-128-75.dsl.austtx.sbcglobal.net. [71.145.128.75])
        by mx.google.com with ESMTPS id q5sm84321yhm.7.2011.11.10.22.35.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 22:35:38 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185254>

The hooks.emailmaxlines config currently has no effect. Stop
prep_for_email from clobbering the already-initialized maxlines
variable in the contrib/hooks/post-receive-email example.

Signed-off-by: Cheng Leong <leongc@alumni.rice.edu>
---
 contrib/hooks/post-receive-email |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index ba077c1..ac2e0ed 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -85,7 +85,6 @@ prep_for_email()
 	oldrev=$(git rev-parse $1)
 	newrev=$(git rev-parse $2)
 	refname="$3"
-	maxlines=$4
 
 	# --- Interpret
 	# 0000->1234 (create)
-- 
1.7.7.1.msysgit.0
