From: rupert THURNER <rupert.thurner@gmail.com>
Subject: git svn push, git dcommit leads to commit duplication?
Date: Tue, 19 Jul 2011 21:55:23 +0200
Message-ID: <CAJs9aZ8T+LSOGs-kdncfSJeLANtZqudwc0r-epV7BQ1t4huX9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 21:55:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjGOT-00057M-Aw
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 21:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab1GSTzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 15:55:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41792 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab1GSTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 15:55:44 -0400
Received: by iwn6 with SMTP id 6so4379874iwn.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=mTT1Jmld2mJVGA+dgMjBmmP0jiAWyHsubSxnmrZmQl4=;
        b=GQ7XrTGwvbx1s36sTXCe69FHyN3Ni+Wb0ebZ5epLAHhSZPnw7PDeHJ1K9WKnpwQUdV
         Ubd8ReTLJEcMesivyHozkbTv0rfMtMpsbcB4og7b2FTTVit5WpfkPPpXDi5gCMIngzET
         Zq8zEynFpVUYzI7lfY4ToNffubrwAVxU2kDr8=
Received: by 10.42.147.66 with SMTP id m2mr3523566icv.321.1311105343186; Tue,
 19 Jul 2011 12:55:43 -0700 (PDT)
Received: by 10.42.96.193 with HTTP; Tue, 19 Jul 2011 12:55:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177496>

we keep a svn clone of
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg on
https://github.com/opencsw/pkg-all . usually i synchronize it with
"git svn rebase" and "git push" from a local clone created with "git
svn clone https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg".

last time i changed something in this local clone and pushed it to
github, and commited it to sourceforge via git svn dcommit. now the
commits are there two times, different. my guess was that dcommit
would add the svn related stuff to the existing git commits. what is
the correct usage to keep svn and git in sync?

$ git log origin/master..master
...
commit 38ed3e4dec877b356fbf3799d1419a89ce6d107f
Author: rthurner <rthurner@d3b55034-1cff-0310-a425-aefe953e1e90>
Date:   Sun Jul 17 09:25:14 2011 +0000

    libserf, obsolete devel, and not working 0-0 package

    git-svn-id:
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg@15081
d3b55034-1cff-0310-a425-aefe953e1e90

commit 22340c05f87b19bde70fd04016bee39e24bb6c8b
Author: rthurner <rthurner@d3b55034-1cff-0310-a425-aefe953e1e90>
Date:   Sun Jul 17 09:24:53 2011 +0000

    libserf, obsolete devel, and not working 0-0 package

    git-svn-id:
https://gar.svn.sourceforge.net/svnroot/gar/csw/mgar/pkg@15080
d3b55034-1cff-0310-a425-aefe953e1e90


$ git log master..origin/master
commit 25bf83cd73ad5ffb17a5bfb668ecdbde1b8971bd
Author: THURNER rupert <rupert@opencsw.org>
Date:   Sun Jul 17 11:23:15 2011 +0200

    libserf, obsolete devel, and not working 0-0 package

commit cd516e0f4a319ba2554ca29a911130b43b96f6ec
Author: THURNER rupert <rupert@opencsw.org>
Date:   Sun Jul 17 11:21:36 2011 +0200

    libserf, obsolete devel, and not working 0-0 package
