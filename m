From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: git log -S problem
Date: Sun, 20 May 2007 21:15:39 +0200
Message-ID: <200705202115.39325.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 21:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HprFZ-0005Jx-4X
	for gcvg-git@gmane.org; Sun, 20 May 2007 21:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbXETTjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 15:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbXETTjV
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 15:39:21 -0400
Received: from smtp4.srv.eunet.at ([193.154.160.226]:49840 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbXETTjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 15:39:20 -0400
X-Greylist: delayed 1417 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 May 2007 15:39:20 EDT
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id C5868983C5
	for <git@vger.kernel.org>; Sun, 20 May 2007 21:15:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3DDE9531F5
	for <git@vger.kernel.org>; Sun, 20 May 2007 21:15:40 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47895>

There is something odd with -S of git log. Try this in your git.git:

$ git log --pretty=oneline -Sbuiltin-merge-base -- Makefile 
71dfbf224ff980f4085f75868dc409118418731e Make merge-base a built-in.

$ git log --pretty=oneline -Smerge-base -- Makefile
e468305a954d95a26bfcdec3bc6e4bd477d95676 [PATCH] Remove the explicit ...
a3df180138b85a603656582bde6df757095618cf Rename git core commands ...
cef661fc799a3a13ffdea4a3f69f1acd295de53d Add support for alternate ...
e590d694ead8d50c2afc7086161d4ddc5d907655 Add more header dependencies.
6683463ed6b2da9eed309c305806f9393d1ae728 Do a very simple "merge-base"...

$ git version
git version 1.5.2

I had expected that the set of commits found by the second search string are a 
proper superset of those found by the first one. What's wrong here? Why does 
a search for 'merge-base' not find occurences of 'builtin-merge-base'?

-- Hannes
