From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 00/16] make usage text consistent in git commands
Date: Sat, 23 Feb 2013 16:20:38 -0800
Message-ID: <1361665254-42866-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:21:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLO-0008Ux-0Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab3BXAVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:03 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:59254 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759111Ab3BXAVB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:01 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so928769dak.39
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=6xIpGuvh8KFjN9FoPEHs8QSDz4aQYDJ0R3EpDytaCag=;
        b=cYGeAUXg3IJBD2Hn3JO6TOD/H4PV4O3uNG7NfnQXuW4bIndz/Y8GJMXXt8R7cKlgRT
         S10sMQzQtJAdiKJdOmNiyxViiR5AeqOKS282uPthql8kS6CS+WO9CGYGb2/AGnCYI9QB
         aGs46rBH8S3vUzL9gBIMDrX1421mH2fcIB4AiU6BGaiK0cDppC68iRhdMAGP7HYJlTc0
         3EhhcqYF7c9dAz63ss+RpKVNPU0F4sZTmv5tHe8xQ1e7xsA6ZZBnl3ROZugHmmEaCMGb
         QgZLtynxV28wTPf4txdxcfaIx3b69fxBqRoADDGK1edjiBoYkj2qdoL40f8/qudi/M2t
         eO4Q==
X-Received: by 10.66.72.201 with SMTP id f9mr11593244pav.38.1361665260985;
        Sat, 23 Feb 2013 16:21:00 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.20.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:00 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216941>

Various helper commands around Git say "Usage: ..." when
invoked as "git $cmd -h".  This is inconsitent with the core
git commands which all use the lowercase "usage: ..." form.

Adjust these so that they match the convention used by
builtin/help.c and git.c.

I fixed a tiny problem in import-zips.py while I was in
there, though it's unlikely that anyone uses such an old
Python these days.

There are still one or two results for "git grep Usage:"
near the tests, but end users do not ever see them so I
figured it was best to leave them as-is.

David Aguilar (16):
  git-sh-setup: make usage text consistent
  git-svn: make usage text consistent
  git-relink: make usage text consistent
  git-merge-one-file: make usage text consistent
  git-archimport: make usage text consistent
  git-cvsexportcommit: make usage text consistent
  git-cvsimport: make usage text consistent
  git-cvsimport: make usage text consistent
  contrib/credential: make usage text consistent
  contrib/fast-import: make usage text consistent
  contrib/fast-import/import-zips.py: fix broken error message
  contrib/fast-import/import-zips.py: use spaces instead of tabs
  contrib/examples: make usage text consistent
  contrib/hooks/setgitperms.perl: make usage text consistent
  templates/hooks--update.sample: make usage text consistent
  Documentation/user-manual.txt: make usage text consistent

 Documentation/user-manual.txt                      |  4 +-
 .../gnome-keyring/git-credential-gnome-keyring.c   |  2 +-
 .../osxkeychain/git-credential-osxkeychain.c       |  2 +-
 .../credential/wincred/git-credential-wincred.c    |  2 +-
 contrib/examples/git-remote.perl                   |  2 +-
 contrib/examples/git-svnimport.perl                |  2 +-
 contrib/fast-import/git-import.perl                |  2 +-
 contrib/fast-import/git-import.sh                  |  2 +-
 contrib/fast-import/import-zips.py                 | 98 +++++++++++-----------
 contrib/hooks/setgitperms.perl                     |  2 +-
 git-archimport.perl                                |  2 +-
 git-cvsexportcommit.perl                           |  2 +-
 git-cvsimport.perl                                 |  2 +-
 git-cvsserver.perl                                 |  2 +-
 git-merge-one-file.sh                              |  2 +-
 git-relink.perl                                    |  2 +-
 git-sh-setup.sh                                    |  6 +-
 git-svn.perl                                       |  2 +-
 templates/hooks--update.sample                     |  2 +-
 19 files changed, 70 insertions(+), 70 deletions(-)

-- 
1.8.2.rc0.247.g811e0c0
