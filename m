From: Pedro Werneck <pjwerneck@gmail.com>
Subject: bug? Python traceback on git push
Date: Wed, 30 May 2012 19:11:38 -0300
Message-ID: <CA+u+8CLcUtTCkWN2bZvR8JNmgnCoX+TwRK3_e64zWaV__jOo7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 00:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZr7d-0000r9-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 00:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246Ab2E3WMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 18:12:00 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62367 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757053Ab2E3WL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 18:11:59 -0400
Received: by vcbf11 with SMTP id f11so229609vcb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 15:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=2JkIduLy3edvCj5vsj84FCKi4HvgP1I1ccZDr1Ngvao=;
        b=KPmK01Cz6hhIiil0n0y7AUwNqjX49L3K29b6ChUsq6GLwRqRpa2iBjr5FYdHHrggR1
         7jG+fB6QZJ5p030OLWox6nZqfmzCSVdVkKrsCD9zgIXfz3ZFcAHyem8eYnfmPH3tJfx8
         d7l36oBl7BahVFmJ/NlsPTbk38P4XIQTt4OrPShOxZqjSdRwdMDATQp8sBh5FmJCtx8G
         UdWM2fzKT39Agv7vEQcvWFezhdo8qLAPAx/bDPdEM3P4L2MnbGVdtgkHUq4pOD6j85z6
         woo7ySave0IF+klXx7P5/UoBg4+0GQphaOQxiUTw5iOJ2/WZu6olUdqy73cB6RBWuBsa
         rQmg==
Received: by 10.52.66.205 with SMTP id h13mr15765571vdt.87.1338415918925; Wed,
 30 May 2012 15:11:58 -0700 (PDT)
Received: by 10.220.153.71 with HTTP; Wed, 30 May 2012 15:11:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198845>

git 1.7.9.5

I was pushing to a repository

push actually seems to have worked, but popped this weird python traceback


(tcf-env)werneck@werneck:~/devel/tcf-api/src/tcf$ git push
Warning: Permanently added 'bitbucket.org,207.223.240.181' (RSA) to
the list of known hosts.
Counting objects: 15, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 860 bytes, done.
Total 8 (delta 7), reused 0 (delta 0)
remote: Traceback (most recent call last):
remote:   File "/opt/python/domains/bitbucket.org/current/bitbucket/scripts/git/hooks/pre-receive",
line 9, in <module>
remote:     from bitbucket.apps.repo2.hooks import prehooks
remote:   File "/data/vol1/www/venvs/deployed/bitbucket/apps/repo2/hooks.py",
line 4, in <module>
remote:     from orochi.hooks import failonerror, HookError, HookManager
remote:   File "/opt/python/domains/bitbucket.org/current/bitbucket/local/env/lib/python2.7/site-packages/orochi/hooks.py",
line 9, in <module>
remote:     from orochi.git import githook
remote:   File "/opt/python/domains/bitbucket.org/current/bitbucket/local/env/lib/python2.7/site-packages/orochi/git.py",
line 23, in <module>
remote:     from orochi.lock import lock
remote:   File "/opt/python/domains/bitbucket.org/current/bitbucket/local/env/lib/python2.7/site-packages/orochi/lock.py",
line 9, in <module>
remote:     from mercurial.lock import lock as mlock
remote: ImportError: No module named mercurial.lock
To git@bitbucket.org:titansgroup/tcf-api.git
 ! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'git@bitbucket.org:titansgroup/tcf-api.git'

(tcf-env)werneck@werneck:~/devel/tcf-api/src/tcf$ git pull
Warning: Permanently added 'bitbucket.org,207.223.240.181' (RSA) to
the list of known hosts.
Already up-to-date.

(tcf-env)werneck@werneck:~/devel/tcf-api/src/tcf$ git push
Warning: Permanently added 'bitbucket.org,207.223.240.181' (RSA) to
the list of known hosts.
Counting objects: 15, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (8/8), done.
Writing objects: 100% (8/8), 860 bytes, done.
Total 8 (delta 7), reused 0 (delta 0)
remote: bb/acl: pjwerneck is allowed. accepted payload.
To git@bitbucket.org:titansgroup/tcf-api.git
   16b3b54..a50f671  master -> master


-- 
---
Pedro Werneck
