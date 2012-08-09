From: Jerome Reybert <jreybert@gmail.com>
Subject: [PATCH] git bash completion handles alias options
Date: Thu,  9 Aug 2012 22:52:23 +0200
Message-ID: <1344545544-8538-1-git-send-email-jreybert@gmail.com>
Cc: Jerome Reybert <jreybert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 22:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzZik-0004se-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 22:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab2HIUwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 16:52:37 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52428 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab2HIUwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 16:52:36 -0400
Received: by weyx8 with SMTP id x8so558607wey.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LOFA7FOZAfVbrUr+i8eft686VkFvTIBPMAbdNj3b2jc=;
        b=T2f6+QIQnTkHCkc2/yorQAiZb5gQFLYTep6G6YjS7A2LU7lnVA6Yl1yA2C/+1cajCA
         8MWhcu0vEd7MoGlHYPB+qOK3j+K++J2FYYLlF89S4O3c9u7rLq0T+Yuqiw7sve7XVfLA
         QHm3xHnSfr8Osby+Px7CI9qjF/JPxRVgPXSSKRcTREjMUSvOlbKoDXeGfp8xBM4b0MeX
         7p+iBoZ+9ow+A89OsJlfZ/YGfXjWZ9BJUggpisb4O2Clifh3OTZP39q8LGQhwvTJTgov
         e9oicrApGm8Af0DJ0MH05+JOTy0UhP3x9yLlqPEWWnBzyJYrSdDDMEjvZHA99o4pIUIw
         rGzA==
Received: by 10.216.198.137 with SMTP id v9mr282108wen.116.1344545555204;
        Thu, 09 Aug 2012 13:52:35 -0700 (PDT)
Received: from dionysos.lin.mbt.kalray.eu (mailhost.kalray.eu. [217.108.237.233])
        by mx.google.com with ESMTPS id l6sm3748100wiz.4.2012.08.09.13.52.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 13:52:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.91.gf4edd99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203181>

git bash completion now handles git alias options. It means that options which
change the completion behavior for complete commands will also change the
behavior of completion for aliased command.  

bash completion now handle git alias options. I did a use case in another
commit: a checkout alias which only complete local branches, ie. only 'refs'
ones, not 'remotes'. With this new alias completion, I added an option to do
that in checkout command and hacked _git_checkout complete function.

Best,
  Jerome

Jerome Reybert (1):
  git bash completion handles alias options

 contrib/completion/git-completion.bash | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

-- 
1.7.12.rc0.91.gf4edd99
