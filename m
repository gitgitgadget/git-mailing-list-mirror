From: Justin Collum <jcollum@gmail.com>
Subject: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 13:27:33 -0700
Message-ID: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 08 22:27:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Wo6-0004ZK-8L
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 22:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966323Ab3HHU1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 16:27:34 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63660 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3HHU1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 16:27:33 -0400
Received: by mail-ie0-f174.google.com with SMTP id w15so2662585iea.5
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=6pZJQ0ciullxqAUEW0NQVVUmonBDWtl20qnYvCj2+WQ=;
        b=B8kupybSTl4lXzyQKL8d+9/6Yb1o9GbJuF9aYezq+GW7WQY1RC62DYKnf0Uvji+pQv
         yXLL0FU6z73GwTIyquBl0LOZ26MYm7Jat+EYKN8FlovpXpZdt5wzbxTVuOp4yPuuBlEL
         /+FTFv7R8Egk2Nz2lxfw5rGcRmFXCp5Rsbuzgf+zIdWLnVqrX0VTrqWFegJ+0YQUAz6X
         F2AG1OBTNk2UPZokpToBF1ssbh/xRhftEZLapbCfYQKYivWm9ErJKdNy/vP3THQYPmwx
         eJgPh0J7byBqCuuit0DhqXqtMlhUujPQ871vaR/v5CMY/A152o00ExRAy8OggWuTyVjT
         trng==
X-Received: by 10.43.77.137 with SMTP id zi9mr2885331icb.106.1375993653497;
 Thu, 08 Aug 2013 13:27:33 -0700 (PDT)
Received: by 10.43.146.70 with HTTP; Thu, 8 Aug 2013 13:27:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231928>

I've run into a strange situation with git lately. It seems that
anything I do involving git will alter the permissions on my index
file to the point that I can't do anything until I re-add the
permissions on the file.

Looks like a bug to me, is it? It does seem like this has started
happening since I moved over to 64b Ubuntu.

$ ll .git
total 156K
...
drwxrwxrwx   2 dev dev 4.0K Jul 23 09:30 hooks
-rwxrwxrwx   1 dev dev  17K Aug  8 13:12 index
drwxrwxrwx   2 dev dev 4.0K Jul 19 09:31 info
...

$ gs
# On branch build-0.3
# Your branch is ahead of 'staging/build-0.3' by 5 commits.
#   (use "git push" to publish your local commits)
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
# scripts/loadMongo.coffee
nothing added to commit but untracked files present (use "git add" to track)

$ ll .git
total 156K
...
drwxrwxrwx   2 dev dev 4.0K Jul 23 09:30 hooks
-rw-rw-r--   1 dev dev  17K Aug  8 13:16 index   # <---------------
this line  <-------------------------------
drwxrwxrwx   2 dev dev 4.0K Jul 19 09:31 info
...

$ git --version
git version 1.8.3.4

Ubuntu:
Distributor ID: Ubuntu
Description: Ubuntu 12.04.2 LTS
Release: 12.04
Codename: precise
