From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: MinGW port usable
Date: Mon, 29 Jan 2007 23:20:43 +0100
Message-ID: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 29 23:20:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBers-0002xT-3z
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 23:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbXA2WUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 17:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbXA2WUs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 17:20:48 -0500
Received: from smtp2.noc.eunet-ag.at ([193.154.160.116]:34418 "EHLO
	smtp2.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbXA2WUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 17:20:47 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.noc.eunet-ag.at (Postfix) with ESMTP id A232637D27
	for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:20:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1D28D3BDC0
	for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:20:44 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38100>

I'd like to point interested parties to the MinGW port at

 git://repo.or.cz/git/mingw.git

which is now in a usable state, methinks. I'm using it with git-gui and gitk 
on a (almost) production repository.

The README.MinGW at 
http://repo.or.cz/w/git/mingw.git?a=blob_plain;f=README.MinGW;hb=master gives 
an overview on the state. The transfer via native git protocol does not work 
and cannot be made working without major surgery(*). Theoretically, using 
netcat (nc) as GIT_PROXY_COMMAND should work, but not in my setup for some 
reason that I still do not know.

(*) The reason is that on Windows read() and write() cannot operate on 
descriptors created by socket(). A work-around is to implement a (threaded) 
proxy, but that's almost the same as if netcat were used as 
GIT_PROXY_COMMAND.

Junio, you may like to cherry-pick these two non-critical commits from my 
repository:

8c8bb94f94f1d972c7ffadda4744cf343fac6f34 gitk: Use peek-remote instead of 
ls-remote.
46580d2192d79a469f8b40fc1081db9116ad5517 Add a missing fork() error check.

-- Hannes
