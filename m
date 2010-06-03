From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/5] Documentation/rev-list-options.txt: Fix missing line in
 example history graph
Date: Fri, 04 Jun 2010 01:17:33 +0200
Message-ID: <1275607057-26645-2-git-send-email-johan@herland.net>
References: <1275607057-26645-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 04 01:18:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKJfv-0007BM-51
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 01:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756220Ab0FCXR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 19:17:58 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40864 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab0FCXR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 19:17:57 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G00DBHOPWCWC0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:17:56 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id BBA151EA5877_C083824B	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:17:56 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9CDC41EA3147_C083824F	for <git@vger.kernel.org>; Thu,
 03 Jun 2010 23:17:56 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3G007W6OPOV330@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 04 Jun 2010 01:17:56 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1275607057-26645-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148371>

In the detailed explanation of how the revision machinery does history
simplification, the current text presents an example history and explains
how various options of the revision machinery affect the resulting list
of commits. The first simplification mode mentioned is the default mode,
in which a number of commits is omitted from the example graph according
to the history simplification rules. The text states (among other things)
that commit "C was considered via N, but is TREESAME", and therefore
omitted. However, the accompanying graph does not list the effect on the
implicit parentage, i.e. that commit I takes C's place as a parent of N.

Running 'git rev-list --parents P' does indeed list I as a second parent
of N, and the accompanying graph should therefore also show this line.

Signed-off-by: Johan Herland <johan@herland.net>
Cc: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/rev-list-options.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index b9fb7a8..81815e1 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -440,7 +440,7 @@ This results in:
 +
 -----------------------------------------------------------------------
 	  .-A---N---O
-	 /         /
+	 /     /   /
 	I---------D
 -----------------------------------------------------------------------
 +
--
1.7.0.4
