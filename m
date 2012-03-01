From: Luiz-Otavio Zorzella <zorzella@gmail.com>
Subject: Bug: no-op "rebase -i" failures (easily reproduceable)
Date: Thu, 1 Mar 2012 10:47:08 -0800
Message-ID: <CAFjr8EukvC6zsa2vzUWL+YDNLMUh5apmwGQZ1s5WkHg-bC17Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 19:47:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3B2N-0002ph-J6
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 19:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab2CASra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 13:47:30 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:56476 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab2CASr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 13:47:29 -0500
Received: by wejx9 with SMTP id x9so561930wej.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 10:47:28 -0800 (PST)
Received-SPF: pass (google.com: domain of zorzella@gmail.com designates 10.216.144.138 as permitted sender) client-ip=10.216.144.138;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of zorzella@gmail.com designates 10.216.144.138 as permitted sender) smtp.mail=zorzella@gmail.com; dkim=pass header.i=zorzella@gmail.com
Received: from mr.google.com ([10.216.144.138])
        by 10.216.144.138 with SMTP id n10mr3965892wej.56.1330627648459 (num_hops = 1);
        Thu, 01 Mar 2012 10:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TFyB5lpkaJKiELfr1dV/m1JTNLV9hA94fz2L/yKqygQ=;
        b=cnMYzuIYmW9cOWTtrRCEDetHawXyvjvjOMJIBk3m/v+yLjoTb8T7NzyGdHiGbIGOqm
         iBEVF/sdOhvG8nzLiE04AFknxG7t4GLbsUeMwTuImUJFXVBIwOZAJjhq8u359qWTIuqI
         s0bcM+jAeqQ6Ch8KxnW/KYijJkgadbSAiIesI=
Received: by 10.216.144.138 with SMTP id n10mr3197848wej.56.1330627648342;
 Thu, 01 Mar 2012 10:47:28 -0800 (PST)
Received: by 10.216.3.9 with HTTP; Thu, 1 Mar 2012 10:47:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191956>

I'm having problems with running commands like "git rebase -i HEAD~40"
in my codebase. With git's own git repo, and I got a different error,
but I think it's related: I start with a clean tree and issue a no-op
git rebase which fails.

$ git --version
git version 1.7.7.3

$ git clone git://github.com/gitster/git.git
Cloning into 'git'...
remote: Counting objects: 129018, done.
remote: Compressing objects: 100% (41859/41859), done.
remote: Total 129018 (delta 94779), reused 118799 (delta 85455)
Receiving objects: 100% (129018/129018), 28.21 MiB | 252 KiB/s, done.
Resolving deltas: 100% (94779/94779), done.

$ cd git

$ git checkout -b blow
Switched to a new branch 'blow'

$ git branch
* blow
  master

$ EDITOR=echo git rebase -i HEAD~40
/usr/local/google/z/gitblow/git/.git/rebase-merge/git-rebase-todo
error: could not apply ec7ff5b... make lineno_width() from blame
reusable for others

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To check out the original branch and stop rebasing run "git rebase --abort".
Could not apply ec7ff5b... make lineno_width() from blame reusable for others

******************************************

Zorzella
