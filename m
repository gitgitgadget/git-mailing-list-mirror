From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: rc6-git8 Makefile from cg-export and bz2 patch don't agree
Date: Wed, 17 Aug 2005 12:20:04 -0400
Message-ID: <E1E5Qe5-0001HV-2f@approximate.corpus.cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Aug 17 18:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5QeH-0000xo-Gw
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVHQQUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVHQQUN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 12:20:13 -0400
Received: from smtpauth05.mail.atl.earthlink.net ([209.86.89.65]:47016 "EHLO
	smtpauth05.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751158AbVHQQUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 12:20:12 -0400
Received: from [24.41.6.91] (helo=approximate.corpus.cam.ac.uk)
	by smtpauth05.mail.atl.earthlink.net with asmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1E5QeB-0001yp-On; Wed, 17 Aug 2005 12:20:11 -0400
Received: from sanjoy by approximate.corpus.cam.ac.uk with local (Exim 4.52)
	id 1E5Qe5-0001HV-2f; Wed, 17 Aug 2005 12:20:05 -0400
To: git@vger.kernel.org
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47838e41faa7aa56b4a956eefa668d25d8bc88340136506db00350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wanted to get a clean 2.6.12-rc6-git8 tree, so I looked up the commit
id (3edea4833a1efcd43e1dff082bc8001fdfe74b34) at
<http://kernel.org/pub/linux/kernel/v2.6/snapshots/>, updated my .git
repository with

rsync -a --delete --verbose --stats --progress \
   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
   .git/

then did 
  cg-export /tmp/xyz <commit-id>

Strangely, the Makefile doesn't match what I would get by applying
patch-2.6.13-rc6-git8.bz2.  In the exported Makefile,

EXTRAVERSION =-rc6

whereas from the patch, Makefile (line 151 of the diff) has 

EXTRAVERSION = -rc6-git8

Was this a case of hand-editing the diff or did I not use the cg/git
commands correctly?

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
