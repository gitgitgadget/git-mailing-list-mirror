From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 0/6] --dirstat fixes, part 2
Date: Wed, 27 Apr 2011 10:24:07 +0200
Message-ID: <1303892653-3958-1-git-send-email-johan@herland.net>
References: <1303870359-26083-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 10:24:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF02t-0000XB-K6
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654Ab1D0IYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:24:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:37992 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab1D0IYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 04:24:18 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA004DVY0H9Y70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 10:24:17 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id ED4281EA5937_DB7D2B0B	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 08:24:16 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id CEE291EA38BF_DB7D2B0F	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 08:24:16 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA008RHY0G8H20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 10:24:16 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1303870359-26083-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172190>

Hi,

Here's version 3 with patch 5/6 changed to use integer permille calculation
instead of floating point percent calculations. Patch 6/6 also has minor
updates caused by the 5/6 changes (s/percent/permille/ plus updated test
vectors). The other patches are unchanged.


Have fun! :)

...Johan

Johan Herland (6):
  Add several testcases for --dirstat and friends
  Make --dirstat=0 output directories that contribute < 0.1% of changes
  Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
  Add config variable for specifying default --dirstat behavior
  Allow specifying --dirstat cut-off percentage as a floating point number
  New --dirstat=lines mode, doing dirstat analysis based on diffstat

 Documentation/config.txt       |   44 ++
 Documentation/diff-options.txt |   54 ++-
 diff.c                         |  191 ++++++++-
 diff.h                         |    3 +-
 t/t4046-diff-dirstat.sh        |  908 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1167 insertions(+), 33 deletions(-)
 create mode 100755 t/t4046-diff-dirstat.sh

-- 
1.7.5.rc1.3.g4d7b
