From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Fix asciidoc callouts in git man pages
Date: Fri, 28 Apr 2006 09:13:37 -0400
Message-ID: <BAYC1-PASMTP1046BB48C01D83AC57A694AEB20@CEZ.ICE>
Reply-To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Fri Apr 28 15:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZSrL-0004Dp-Nx
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 15:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWD1NSJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 09:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWD1NSI
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 09:18:08 -0400
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:46579 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1030389AbWD1NSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 09:18:08 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from guru.attic.local ([69.156.138.66]) by BAYC1-PASMTP10.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 06:19:54 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by guru.attic.local (Postfix) with ESMTP id B1A1B7001EA
	for <git@vger.kernel.org>; Fri, 28 Apr 2006 09:13:37 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <11462300171565-git-send-email-seanlkml@sympatico.ca>
X-Mailer: git-send-email 1.3.1.gc672
X-OriginalArrivalTime: 28 Apr 2006 13:19:54.0625 (UTC) FILETIME=[70449710:01C66AC6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Started out just wanting to update the git-branch man page
to include the "-r" option but noticed that the asciidoc 
callouts weren't being rendered in its man page.  Then 
noticed the same was true for all the man pages where
they are used. 

It turns out we've not been following the guidelines 
properly on how to use them.  The fact that they show up
in a useful way in the html docs is really an accident.
Even there they're not showing up as intended.

Unfortunately, even after all the docs are fixed up to use
the proper format, they still don't render properly in the
man format.   Seems this is a missing feature in the "xmlto"
command.

The final patch in this series adds an xsl fragment which
is passed to xmlto so that the callouts appear properly in 
the man pages.

Sean

 Documentation/Makefile             |    2 +
 Documentation/callouts.xsl         |   16 ++++++++
 Documentation/everyday.txt         |   45 +++++++++++------------
 Documentation/git-branch.txt       |   57 ++++++++++++++++++++---------
 Documentation/git-checkout.txt     |   18 +++++----
 Documentation/git-diff.txt         |   38 ++++++++++---------
 Documentation/git-init-db.txt      |    8 ++--
 Documentation/git-log.txt          |    7 ++--
 Documentation/git-reset.txt        |   72 ++++++++++++++++++------------------
 Documentation/git-update-index.txt |   31 ++++++++--------
 10 files changed, 163 insertions(+), 131 deletions(-)
