From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 0/5] Various StGit patches
Date: Thu, 12 Mar 2009 12:08:50 +0000
Message-ID: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:11:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhjkp-0003cT-OW
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbZCLMJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756670AbZCLMJ2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:09:28 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49919 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756654AbZCLMJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:09:25 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2CC7iZm017548;
	Thu, 12 Mar 2009 12:07:44 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 12:09:14 +0000
User-Agent: StGit/0.14.3.348.gf982
X-OriginalArrivalTime: 12 Mar 2009 12:09:14.0115 (UTC) FILETIME=[5C0DDD30:01C9A30B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113050>

Some of these patches were posted before and there were some suggestions
which I added. The "Check for local changes with goto" patch was
slightly improved so that the "stgit.keep" option could be set to "yes"
if this is preferred as a default behaviour.

I plan to implement transition as many commands as possible to the new
infrastructure. For some of them it should be trivial. The "status"
command needs some support in stgit.lib.


Catalin Marinas (5):
      Convert "float" to the lib infrastructure
      Convert "sink" to the new infrastructure
      Add automatic git-mergetool invocation to the new infrastructure
      Add mergetool support to the classic StGit infrastructure
      Check for local changes with "goto"


 examples/gitconfig         |   24 +------
 stgit/argparse.py          |    5 +
 stgit/commands/edit.py     |    2 -
 stgit/commands/float.py    |   75 +++++++++-------------
 stgit/commands/goto.py     |    9 ++-
 stgit/commands/resolved.py |    5 -
 stgit/commands/sink.py     |   86 +++++++++++--------------
 stgit/config.py            |    1 
 stgit/git.py               |   33 ++++++----
 stgit/gitmergeonefile.py   |  150 --------------------------------------------
 stgit/lib/git.py           |   35 +++++++++-
 stgit/lib/transaction.py   |   17 ++++-
 t/t0002-status.sh          |    3 -
 t/t1501-sink.sh            |    2 -
 t/t2300-refresh-subdir.sh  |    2 -
 t/t2800-goto-subdir.sh     |    4 +
 t/t3000-dirty-merge.sh     |    2 -
 17 files changed, 153 insertions(+), 302 deletions(-)
 delete mode 100644 stgit/gitmergeonefile.py

-- 
Catalin
