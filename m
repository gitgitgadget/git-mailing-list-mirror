From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/2] git-submodule: make it easier to use alternate urls
Date: Tue,  5 Jun 2007 11:29:10 +0200
Message-ID: <11810357523435-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 11:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvVJh-0000zW-Nt
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 11:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763202AbXFEJ0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 05:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763296AbXFEJ0u
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 05:26:50 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:46956 "EHLO mail47.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763202AbXFEJ0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 05:26:49 -0400
Received: from localhost.localdomain (ti231210a080-7628.bb.online.no [80.213.29.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id l559QjKX004735;
	Tue, 5 Jun 2007 11:26:45 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.846.gb8de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49175>


This patch-series teaches git-submodule to register submodule urls in
.git/config during 'git-submodule init' and to perform the actual cloning
during 'git-submodule update', using the url stored in .git/config. So now
the downstream users can specify their preferred urls for each interesting
submodule by editing their .git/config after running 'git-submodule init'.

 Documentation/git-submodule.txt |   16 ++++----
 git-submodule.sh                |   83 ++++++++++++++++++++------------------
 t/t7400-submodule-basic.sh      |   38 ++++++++++++------
 3 files changed, 78 insertions(+), 59 deletions(-)
