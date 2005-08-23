From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: arch2git import script
Date: Wed, 24 Aug 2005 01:11:57 +1200
Message-ID: <46a038f90508230611337c695e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 23 15:14:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7YZW-0000za-Mg
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 15:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVHWNMC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 09:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVHWNMB
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 09:12:01 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:15563 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750789AbVHWNMA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 09:12:00 -0400
Received: by rproxy.gmail.com with SMTP id i8so1151788rne
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 06:11:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KFf1hZVciObZ8ntUD5Ofryrk4mgBlDFvqDaGUCaa+xLqzmT4zbMLOArhEWZOBVIyRVgWeBgN57F8G01A6c2H0w31R+DIsVq1jo4EjZT3dLGPEXqBFH4k6YwpiEhA6Khw9hEYb6kAvQX6G4JX0Wf0sCzMS37TJzRUGEOUsZxfQkI=
Received: by 10.38.104.32 with SMTP id b32mr423185rnc;
        Tue, 23 Aug 2005 06:11:57 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 23 Aug 2005 06:11:57 -0700 (PDT)
To: GIT <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

First draft of an Arch import. Very limited but will import one
"branch" into one head. The basics are for it to follow branches, and
some support for marking merges (or at least what git would consider
merges.

TODO:
- proper branch switching
- binary file handling
- get the date format right!
- parse the output of cat-archive-log to know what files to add/delete
and cleanup the logmsg
- ensure all shell invocations have error handling
- allow multiple "Archives"
- learn to run repeatedly over the same git repo, importing only new commits
- track cherrypicking to identify how far branches are merged (in the
git sense)
- a few options as to how to follow (or not) the history
  - follow a full branch starting from a full import "down" with
branches opening from it.
  - follow a branch history "up"

An example invocation to import the sears-ldap-dev branch is:

  mkdir sample-import
  cd sample-import;
  git-archimport-script -t /tmp/some/dir -i \
      -A arch-eduforge@catalyst.net.nz--2004 sears-ldap--dev

the commit message needs cleanup, the dates are bogus, and we aren't
marking deletes... but it otherwise works great! ;)

cheers,


martin
