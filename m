From: Prudhvee Narasimha Sadha <prudhvi.sada@gmail.com>
Subject: [PATCH] for the SoC15 micro project, Make "git -C '' cmd" not to barf.
Date: Fri, 6 Mar 2015 07:16:36 +0530
Message-ID: <CAMS+ib3dDP6PmHvLJsSs-6XCy233gxjU6=+_7id8yuk9xTnCJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 02:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YThLh-0002pt-8G
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 02:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975AbbCFBqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 20:46:40 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:39838 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbbCFBqh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 20:46:37 -0500
Received: by oigi138 with SMTP id i138so15258734oig.6
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 17:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=WtNufWsC7lsE73bMHePnRtegIsoqM7bgityMv0QNx50=;
        b=DelKvJnIWrU1jGNB/JdmnOw9Beh38svKhpwLKNG+b7ua2m5yt4PfsJD6MCq/8qeZ6Y
         5BErrOL9jHPvroAoD+tIS60cGDOmcR+H0Ysz66kyMQiKPJJ6YixEmyK8XdUc0ifMAAdK
         59azh7kB4Hmqmaobi1lWy2sD4+fGDWZIWwUjx62A3i7gdyTwly+JnKWIu2V0AtzMv46F
         Eep1zvTy1NP06eujGij/QxX9oN0tfe2uuvQOlvYu0BoRL4X3H/GCCxp6yKArDBB7yjvS
         Mdu3x0G0pcOj49JaZZCKNcZwFXJCf+eSCQn2BoVL6OqiDEpZi4h3fBXn8aXgBgihuMQY
         NbLA==
X-Received: by 10.60.150.202 with SMTP id uk10mr9230039oeb.14.1425606396062;
 Thu, 05 Mar 2015 17:46:36 -0800 (PST)
Received: by 10.202.95.213 with HTTP; Thu, 5 Mar 2015 17:46:36 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264884>

Hi,
    here is my patch for the micro project, Please review the code.


prudh@prudh-Studio-1569:~/git$ git diff
diff --git a/git.c b/git.c
index 8c7ee9c..364788b 100644
--- a/git.c
+++ b/git.c
@@ -205,6 +205,8 @@ static int handle_options(const char ***argv, int *argc, int
                                usage(git_usage_string);
                        }
                        if (chdir((*argv)[1]))
+                               if(*(*argv)[1]==0);
+                       else if(chdir((*argv)[1]))
                                die_errno("Cannot change to '%s'", (*argv)[1]);
                        if (envchanged)
                                *envchanged = 1;




Thank you,
Prudhvee
