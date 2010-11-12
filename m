From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH 0/2] RFC: Better handling of git init remote-spec
Date: Fri, 12 Nov 2010 12:31:44 +0100
Message-ID: <cover.1289561504.git.peter@softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 12:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGrzP-00008W-9o
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 12:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab0KLLkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 06:40:10 -0500
Received: from smtp.getmail.no ([84.208.15.66]:59461 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752465Ab0KLLkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 06:40:09 -0500
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR005BOSEVYR10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:07 +0100 (MET)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 1D1C01EA5518_CDD2797B	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:07 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 06F1B1EA2CBE_CDD2797F	for <git@vger.kernel.org>; Fri,
 12 Nov 2010 11:40:07 +0000 (GMT)
Received: from perkele ([84.215.142.63]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBR008XKSEUJT00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 12 Nov 2010 12:40:07 +0100 (MET)
Received: by perkele (Postfix, from userid 501)	id A69212FC06; Fri,
 12 Nov 2010 12:40:04 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161336>

>From time to time I forget myself and try to initialize a repository on a remote
machine by writing something like

  git init --bare remote.machine:myrepo.git

just to get a local directory called "remote.machine:myrepo.git" set up.

Or, even worse, a

  git init --bare ssh://remote.machine/myrepo.git

These patches try to fix this. The first patch tries to detect if a remote
repository specification was supplied, and just stop with an error message.
That one is fairly safe.

The second one I haven't got working yet, but I have the beginnings of a
patch that actually tries to run "git-init" on the remote repository. Any
ideas on how to get this actually working (it should be possible for the
"ssh" transport at least) are welcome.

Peter Krefting (2):
  Detect attempts at calling git init specifying a remote repository.
  WIP: Allow running git init on a remote repository specification.

 builtin/init-db.c |   16 +++++++++++++++-
 remote.c          |   11 +++++++++++
 remote.h          |    1 +
 3 files changed, 27 insertions(+), 1 deletions(-)

-- 
1.7.3
