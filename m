From: =?UTF-8?Q?Juli=C3=A1n_Landerreche?= <maniqui@gmail.com>
Subject: a more helpful message on "git status" output
Date: Fri, 18 Jul 2014 16:03:43 -0300
Message-ID: <CAKQhN+rK0ftwC5hX4hDhXZbcEGAfCCBXRaQXYnMFLmR=n21OLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 21:04:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8DS2-0004au-6j
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbaGRTEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 15:04:05 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:59059 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbaGRTEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 15:04:04 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so3891984oag.25
        for <git@vger.kernel.org>; Fri, 18 Jul 2014 12:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=aex90eHHXKGMtHMa0sAWPUixNmOAcMloG3CUBxZtgmQ=;
        b=UnhBiPIpJlm5YA9Rv1jQ1/nPgCh+Q44lbsJNIN/z0L/HywHaH/Eks77wJYd1nJQYGd
         e5+Wxhll1JXGNWWRX+udYImOjYILbOfbr0AyWnQrhITW4EO9O0O8D7wu8f9IHWbngNde
         tS5d0GuDcihpym9ge9pJGwdU+oR09WwwT/2suD+Tyhydnu39rMO0VgSmGFEZsXvpX30b
         fleTgt5QxKobHdLMzGIekQpMCUhT7VVj2oziQDy8836oE0Du6Voh9XTsEAtkCJKYinI/
         XqPIwIqbHmSrVwuYlMy+bU85CJDFDd6NjbgPbJ5s+flfDViJtpj5DYF603pL8GrsHCdt
         zFdA==
X-Received: by 10.182.181.42 with SMTP id dt10mr9811239obc.69.1405710243890;
 Fri, 18 Jul 2014 12:04:03 -0700 (PDT)
Received: by 10.182.50.132 with HTTP; Fri, 18 Jul 2014 12:03:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253838>

Hi,
when running "git status", if the current branch can be
fast-forwarded, the user get this message:

  On branch master
  Your branch is behind 'origin/master' by 6 commits, and can be fast-forwarded.
    (use "git pull" to update your local branch)


The suggestion of using "git pull" for updating the local branch,
although it will work, might not be a proper choice or advice in terms
of what is really needed to just update the local branch.

As the user already has the newer commits locally (ie. the commits
have been already "git fetch"ed), he just needs to merge them. Running
"git pull" will unnecessarily try to fetch commits from upstream
again.
So...

Proposal: suggesting the user to run "git merge" or "git merge
origin/master" seems a more helpful suggestion, imo. Also, for
beginners, it helps for better understanding on what's going on, and
goes in hand with the usual advice of using "git fetch" + "git merge"
(instead of "git pull") to grasp better some Git concepts and how Git
works.
So, the output of git status would read like this:

  On branch master
  Your branch is behind 'origin/master' by 6 commits, and can be fast-forwarded.
    (use "git merge origin/master" to update your local branch)

(it could read "git merge" too, if it defaults to merging upstream,
tracked branch).
