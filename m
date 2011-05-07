From: conrad.irwin@gmail.com
Subject: [PATCH v3 0/3] Git commit --patch (again)
Date: Fri,  6 May 2011 22:59:58 -0700
Message-ID: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
Cc: Conrad Irwin <conrad.irwin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 08:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIaYt-0006H7-Em
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 08:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab1EGGAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 02:00:12 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60461 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1EGGAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 02:00:10 -0400
Received: by pwi15 with SMTP id 15so1707382pwi.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=vstbgHJj0Og2NhVeR5v4GbYtf2fvF/1oW68G5WG4caA=;
        b=Hr/btyiVS5/nLq+xaeWefhb1KNuwzeVrpYdOfSh1i5B9VqLrXhCiNj98yClvAfLHo/
         +T6BpZh4Z3ObLmsXQN9DiOqkq3S3aAA9P4pmEf8VJEmfbMoCLE6Ab+Ru9PH5oOAex8K1
         fM9MXT1B9er8tWg5y7F1TPu4/RzW4oFIhYGZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Vfxfc/aLBAKz2YZn4AYCq2pNoHhiGHUHPxR753Ex3InZvfBcpytTmXUAy5qnmpnKiD
         T094CoLejNH/yikVeYivtnz5xA1MY0qYEVWbLw1m27d5lciZwV4ZPKBwwGJjcz3Abcn0
         pvXzfh/K1MILEeiLNaY3t3gKHeLpJa5Y6eKNw=
Received: by 10.68.55.163 with SMTP id t3mr5938383pbp.281.1304748009795;
        Fri, 06 May 2011 23:00:09 -0700 (PDT)
Received: from scarlatti.dunvegan.biz (c-69-181-44-79.hsd1.ca.comcast.net [69.181.44.79])
        by mx.google.com with ESMTPS id s7sm2624191pbn.15.2011.05.06.23.00.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 May 2011 23:00:08 -0700 (PDT)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.75)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1QIaYg-0004gl-NW; Fri, 06 May 2011 23:00:06 -0700
X-Mailer: git-send-email 1.7.5.188.g4817
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173033>

From: Conrad Irwin <conrad.irwin@gmail.com>

Hi all,

I've rebased my support for git commit -p onto the current master
branch. I've posted it to the list twice before [1][2].

The purpose of the branch is to add the -p/--patch flag, used by other
commands such as git add and git checkout, to git commit. This makes it
much easier, and more convenient, to construct well-formed patches after
a session of writing code.

This branch also includes a fix for git-commit --interactive, so that if
the committer aborts after selecting hunks, the index is unchanged (just
as specifying filenames in the arguments doesn't permanently add them to
the index).

Feedback (of any variety) would be much appreciated,

Conrad

[1] http://thread.gmane.org/gmane.comp.version-control.git/164193
[2] http://thread.gmane.org/gmane.comp.version-control.git/165951

Conrad Irwin (3):
  Use a temporary index for git commit --interactive
  Allow git commit --interactive with paths
  Add support for -p/--patch to git-commit

 Documentation/git-commit.txt |   24 ++++++++++++++-------
 builtin/add.c                |    6 ++--
 builtin/commit.c             |   46 +++++++++++++++++++++++++++++++-----------
 commit.h                     |    2 +-
 4 files changed, 54 insertions(+), 24 deletions(-)

-- 
1.7.5.188.g4817
