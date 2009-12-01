From: David Soria Parra <sn_@gmx.net>
Subject: [PATCH v2] Add --track option to git clone
Date: Tue,  1 Dec 2009 23:51:03 +0100
Message-ID: <1259707865-6561-1-git-send-email-sn_@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 23:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFbZ3-0005ib-OP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbZLAWvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 17:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754527AbZLAWvH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:51:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:42643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750929AbZLAWvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 17:51:06 -0500
Received: (qmail invoked by alias); 01 Dec 2009 22:51:11 -0000
Received: from e180068007.adsl.alicedsl.de (EHLO localhost.localdomain) [85.180.68.7]
  by mail.gmx.net (mp049) with SMTP; 01 Dec 2009 23:51:11 +0100
X-Authenticated: #4427663
X-Provags-ID: V01U2FsdGVkX18fP4d8ioofM2lr5c7O1mQWv9NAtKHZPuPl8CDsph
	iM3LyRj/Bf87pD
X-Mailer: git-send-email 1.6.6.rc0.268.g1c272
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134264>

Update: 
 + added a test

The following series adds a --track option to git clone. If the --track option
is specified only the given remote branch will be received and checked out.

It tries to make the following usecase possible:
Imagine you are working on a project that has 1.x and a 2.x branch. The project
itself requires a complex setup (webserver, configuration files, etc). Setting up
1.x and 2.x branch requires a lot of work, but a developer needs to maintain both.
He'll use the --track option to clone the 2.x branch into a directory and does the same
with the 1.x branch, where he setup the project. He can use locally separate repositories
while still being able to push to just one remote repository.

I'm aware that it's not possible to give more than one --track option. Implementing
the possibility to specify multiple --track option would certainly a good improvment
later, but would also require a lot more work as far as I understand the clone code.

Being able to specify just one --track option is a compromise of doing a small change
and implementing this feature.
