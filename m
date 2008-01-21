From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Should "pull --rebase" try to be a little cleverer?
Date: Mon, 21 Jan 2008 15:47:13 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211542150.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 16:47:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGysH-0002kd-RZ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 16:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988AbYAUPrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbYAUPrR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 10:47:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:48116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752475AbYAUPrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 10:47:16 -0500
Received: (qmail invoked by alias); 21 Jan 2008 15:47:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 21 Jan 2008 16:47:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Q8MJuyVGQhKSc7A9M4jAlwArhqXnkZQ9LhGg3Xh
	PwpTj8G+AFBYHM
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71286>

Hi,

last night an idea hit me: if I "git pull --rebase blabla master", it 
could be that "blabla" decided to rebase "master" already, and ATM this 
would lead to quite a few conflicts, since commits that were not mine were 
rewritten.

However, if we already have refs/remotes/blabla/master, we could DWIM the 
--rebase call to

	git rebase --onto FETCH_HEAD refs/remotes/blabla/master

Of course, this would mean that git-pull would need to source 
git-parse-remote again...

Ciao,
Dscho
