From: Samuel Williams <space.ship.traveller@gmail.com>
Subject: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Wed, 1 Apr 2015 12:29:20 +1300
Message-ID: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 01 01:29:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd5b5-0000Tn-8M
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 01:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbCaX3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 19:29:22 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33698 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbCaX3V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 19:29:21 -0400
Received: by lbbzk7 with SMTP id zk7so7701363lbb.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hCEf8SUhNigtFAjLNhGB+aWRsnG+zswYO+Fn9MGC8z0=;
        b=R5Ynsi0PupsOifPEowoumubB2TRNRgBjNPViuBQKDyqmLlOL24vTdBPxDbxgSEDVjk
         wLq+BCJKYgy6pftgAzQFpPfj0en25PQMSfxvWs4d9OEkADnMuTNRJPIAlyuY78dhjzN5
         tJoyKhhZhEv9A7hAyLRbydO2+BHSG12LlMpLW2N69HJ4xMnKO1PFz9U+Rb5CJBFAb1iW
         FHlsXXWudeGYotKXH6CCyWw7ShinSouydMC9ncHhYEyULdbfvS/BDqp7uXlAvDCI5e8t
         DymRkKrUfDoStxX2htvDOzDvFCk+q4i4fWXgyD7pJEedI0/dCXTqppu7mMMkxvO9rS/o
         573w==
X-Received: by 10.152.42.193 with SMTP id q1mr32016452lal.92.1427844560258;
 Tue, 31 Mar 2015 16:29:20 -0700 (PDT)
Received: by 10.112.20.106 with HTTP; Tue, 31 Mar 2015 16:29:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266582>

I have set up a remote repository like so:

remote $ cat .git/config
[core]
repositoryformatversion = 0
filemode = true
bare = false
logallrefupdates = true
sharedrepository = 1
worktree = /srv/http/www.site.com
[receive]
denyNonFastforwards = true
denyCurrentBranch = updateInstead

This repo is empty by default.

When I try to push into it, I get the following:

local $ git push --set-upstream production master
Counting objects: 29, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (27/27), done.
Writing objects: 100% (29/29), 1.13 MiB | 0 bytes/s, done.
Total 29 (delta 3), reused 17 (delta 0)
fatal: bad revision 'HEAD'
To ssh://remote.net/srv/http/www.site.com
 ! [remote rejected] master -> master (Working directory has staged changes)
error: failed to push some refs to 'ssh://remote.net/srv/http/www.site.com'

Is this expected? Am I doing something wrong? Or, is this a bug in Git?

I would expect if you push to an empty repo, it would update it
(because denyCurrentBranch = updateInstead).

Thanks
