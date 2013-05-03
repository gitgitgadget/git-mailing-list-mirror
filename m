From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: zsh: don't override suffix on _detault
Date: Fri,  3 May 2013 16:35:50 -0500
Message-ID: <1367616950-20700-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 23:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYNfK-0001Ei-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760475Ab3ECVhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:37:12 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:62623 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3ECVhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:37:11 -0400
Received: by mail-yh0-f48.google.com with SMTP id f35so374735yha.7
        for <git@vger.kernel.org>; Fri, 03 May 2013 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=70oq6uLSxTc72CxOt+C04v6jmpZN/NUzm3/+aBxUwak=;
        b=L41Kk1wjvU+ntJ58D721EcB2siTnyXv0cqRCwLHvBs3TUi5+2CLK0et4x1TzbsP72i
         Op/dycRWTOco7R6bqovC7ejzfxliUDfOWiCVVfSq8cpjnILh4EczXTFz926TvydKmaMZ
         4SuHhCB1xf303FErb62czBamsL6oXeAHWYMI3Y3PwyWUr+26DrLuzu61CfaLV/QDutCJ
         9dzHuJ6y0ssQGwfRMY9lBQCq+5rmpZT7eiTsD15G2rvyDlQWioZWQEQcJz3qLORl/k7p
         gfAexUAuR30BhGtnQ3Zy6L1mtBjK/1WjsFA6P63RwXV+ry7fUKztkwiJnsc2DUfG9eU6
         uUsA==
X-Received: by 10.236.223.137 with SMTP id v9mr10419327yhp.166.1367617030927;
        Fri, 03 May 2013 14:37:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id e64sm23924745yhm.4.2013.05.03.14.37.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 14:37:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223323>

zsh is smart enough to add the right suffix while completing, there's no
point in trying to do the same as bash.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 49f0cb8..2565d2e 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -198,7 +198,7 @@ _git ()
 		emulate ksh -c __${service}_main
 	fi
 
-	let _ret && _default -S '' && _ret=0
+	let _ret && _default && _ret=0
 	return _ret
 }
 
-- 
1.8.3.rc0.401.g45bba44
