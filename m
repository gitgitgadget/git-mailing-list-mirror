From: Johan Herland <johan@herland.net>
Subject: [CGit RFC/PATCH 0/5] Commit graph on CGit's 'log' view
Date: Tue, 13 Jul 2010 23:40:16 +0200
Message-ID: <1279057221-28036-1-git-send-email-johan@herland.net>
References: <1279056219-27096-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnDW-0004Or-Vd
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab0GMVkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 17:40:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:64044 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970Ab0GMVkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 17:40:35 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00ATVMVMA660@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 243B51EA573D_C3CDD52B	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 052CA1EA3B29_C3CDD52F	for <git@vger.kernel.org>; Tue,
 13 Jul 2010 21:40:34 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L5I00782MVL0N10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 13 Jul 2010 23:40:34 +0200 (MEST)
X-Mailer: git-send-email 1.7.0.4
In-reply-to: <1279056219-27096-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150922>

Hi,

Here are some patches to implement an ASCII-art commit graph on CGit's
'log' page. The patches reuse the graph-drawing code from Git's own
'git log --graph'. As such, these patches depend on the two patches
I just submitted to the Git list for extending the graph.h API.

More detailed: Patch #4 in this series (ui-log: Implement support for
commit graphs) depend on patch #1 in the other series (Make
graph_next_line() available in the graph.h API), while patch #5 in
this series (ui-log: Colorize commit graph) depends on patch #2 in the
other series (Enable custom schemes for column colors in the graph
API).

Otherwise, the first patch in this series is a minor cleanup patch,
while patches #2 and #3 prepare for the introduction of commit graphs
in patch #4.


Have fun!

...Johan


Johan Herland (5):
  ui-stats: Remove unnecessary #include
  ui-log: Move 'Age' column to the right of 'Author', like in gitk
  ui-log: Refactor display of commit messages
  ui-log: Implement support for commit graphs
  ui-log: Colorize commit graph

 cgit.c       |    6 +++
 cgit.css     |   31 ++++++++++++-
 cgit.h       |    3 +
 cgitrc.5.txt |   15 ++++++-
 shared.c     |    1 +
 ui-log.c     |  140 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 ui-stats.c   |    2 -
 7 files changed, 168 insertions(+), 30 deletions(-)
