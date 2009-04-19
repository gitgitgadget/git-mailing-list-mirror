From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 0/3 RFC] http://code.google.com/p/egit/issues/detail?id=79
Date: Sun, 19 Apr 2009 20:30:06 +0200
Message-ID: <1240165809-16703-1-git-send-email-robin.rosenberg@dewire.com>
References: <200904181905.55119.robin.rosenberg.lists@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Apr 19 20:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvbo7-0000re-H1
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 20:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbZDSSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 14:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbZDSSaN
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 14:30:13 -0400
Received: from mail.dewire.com ([83.140.172.130]:19104 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752921AbZDSSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 14:30:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 31DED1491656;
	Sun, 19 Apr 2009 20:30:11 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bxa+J+k0OsP; Sun, 19 Apr 2009 20:30:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 934EE8026F8;
	Sun, 19 Apr 2009 20:30:10 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
In-Reply-To: <200904181905.55119.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116909>

Here is a possible solution, though I have a problem with the test case. I'd
like to invent something better. The problem with the "Simulate breakpoints"
patch is that it patches core functions and not just the test case. Using AOP
would solve it, but that is too much for a single test case.

Robin Rosenberg (3):
  Add test cases dedicated to the WindowCache
  Simulate breakpoints
  Rescan for packs and retry once if object lookup scan fails

 .../tst/org/spearce/jgit/lib/WindowCacheTest.java  |  132 ++++++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   76 +++++++++--
 .../src/org/spearce/jgit/lib/WindowedFile.java     |    7 +
 3 files changed, 202 insertions(+), 13 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/WindowCacheTest.java
