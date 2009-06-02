From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/2] "git submodule update" enhancements (Was: What's cooking
 in git.git (May 2009, #04; Sun, 31))
Date: Wed, 03 Jun 2009 00:59:10 +0200
Message-ID: <1243983552-24810-1-git-send-email-johan@herland.net>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	apenwarr@gmail.com, peter.hutterer@who-t.net,
	markus.heidelberg@web.de, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 03 01:00:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBcyQ-0008Pn-TQ
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 01:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbZFBXAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbZFBXAm
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 19:00:42 -0400
Received: from mx.getmail.no ([84.208.15.66]:34193 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751845AbZFBXAl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 19:00:41 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM00JXOVX2BF70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:00:38 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKM00EMTVVXLQ80@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 03 Jun 2009 01:00:38 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.2.224626
X-Mailer: git-send-email 1.6.3.rc0.1.gf800
In-reply-to: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [Stalled and may need help and prodding to go forward]
>
> * ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
>  + git-submodule: add support for --rebase.
>
> There was a discussion on --rebase vs --merge and needs for unified
> configuration variable handling for this patch...

Here is my previous patch, split in two, so as not to hold back the
introduction of "git submodule update --rebase": The first patch
changes the associated config variable from "submodule.<name>.rebase"
to "submodule.<name>.update", and the second patch introduces
"git submodule update --merge".

AFAIK, nobody objects to the first patch, so that one should be safe
to apply.

As for the second patch, Dscho has argued against it, although he
has not yet responded to my last email from a week ago. Nobody
(except me) has explicitly supported the patch, although both Avery
and yourself has questioned Dscho's arguments.

Not sure what I can do to bring the discussion toward a conclusion...


...Johan

Johan Herland (2):
  Rename submodule.<name>.rebase to submodule.<name>.update
  git-submodule: add support for --merge.

 Documentation/git-submodule.txt |   19 ++++++++--
 Documentation/gitmodules.txt    |   12 +++++-
 git-submodule.sh                |   43 ++++++++++++++--------
 t/t7406-submodule-update.sh     |   76 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 119 insertions(+), 31 deletions(-)
