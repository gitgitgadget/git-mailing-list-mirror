From: "Kevin Leung" <kevinlsk@gmail.com>
Subject: [PATCH] git-p4: Wrong sync config filename
Date: Wed, 2 Apr 2008 16:23:00 +0800
Message-ID: <e66701d40804020123qb66f52fo13c32e939a7d6f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, simon@lst.de
X-From: git-owner@vger.kernel.org Wed Apr 02 10:23:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgyG8-0007Wt-OD
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 10:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYDBIXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 04:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbYDBIXJ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 04:23:09 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:38203 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYDBIXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 04:23:06 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3408436fkr.5
        for <git@vger.kernel.org>; Wed, 02 Apr 2008 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LyvEKLXbTfKWClWYzg4a26BeloGHF9vp0A3s9PUb08E=;
        b=PJ4x1QrQHiasrA4dcZSZbo1I7y9S2+g+muaGyXGix1jtF4N8ZCB3AyPPvCxG5TDPaUTV+Fy1E2bl6fX91aW1mkUaRD4QxM44uQ2wZYmo+qqx+aIX9kEMPdYAxI/C8I0HwaqopLBt5nfZc05oC03tPgcf3RsRRc+o1rKbMBvT1TI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=babmXqsvonRLcWc8veN6ui3B9j99Mn4KVdAxDCKUC4eoNFrwsAyugdIMAyJfn87+GdMVjc1dr6NEXeeiyflkCr4COYCkbpCt0z6Wl5OuW+vUt3E/MgMO68J2UPVWlnx+mQ7uoO6Ng98jRPG32nVg277IS0Z002UjWFF0V2NLu0E=
Received: by 10.78.132.2 with SMTP id f2mr28361113hud.19.1207124584068;
        Wed, 02 Apr 2008 01:23:04 -0700 (PDT)
Received: by 10.78.14.3 with HTTP; Wed, 2 Apr 2008 01:23:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78689>

The filename should be p4-git-sync.cfg.db instead of p4-git-sync.cfg.

Signed-off-by: Kevin Leung <kevinlsk@gmail.com>
---
I encounter this problem after submitting the changelist to Perforce.

I was using Mac OS X 10.5 with Python 2.5.1. I am not sure if this patch will
help others.

Change 29323 submitted.
All changes applied!
Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //depot/POPCAT/
Import destination: refs/remotes/p4/master
Importing revision 29323 (100%)
Do you want to rebase current HEAD from Perforce now using git-p4
rebase? [y]es/[n]o n
Traceback (most recent call last):
  File "/Users/kevin/bin/git-p4", line 1828, in <module>
    main()
  File "/Users/kevin/bin/git-p4", line 1823, in main
    if not cmd.run(args):
  File "/Users/kevin/bin/git-p4", line 835, in run
    os.remove(self.configFile)
OSError: [Errno 2] No such file or directory:
'/Users/kevin/cdc.git/popcat/.git/p4-git-sync.cfg'

 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c80a6da..623757a 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -796,7 +796,7 @@ class P4Submit(Command):
                 self.logSubstitutions[tokens[0]] = tokens[1]

         self.check()
-        self.configFile = self.gitdir + "/p4-git-sync.cfg"
+        self.configFile = self.gitdir + "/p4-git-sync.cfg.db"
         self.config = shelve.open(self.configFile, writeback=True)

         if self.firstTime:
-- 
1.5.4.5
