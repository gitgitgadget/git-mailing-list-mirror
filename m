From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Problem in our test setup
Date: Thu, 15 Nov 2007 06:24:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150618300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 07:25:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYAe-0006xf-5K
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765410AbXKOGZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765409AbXKOGZK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:25:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:54190 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765003AbXKOGZH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:25:07 -0500
Received: (qmail invoked by alias); 15 Nov 2007 06:25:05 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp057) with SMTP; 15 Nov 2007 07:25:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yS/w+1K8y79wmEkX4g8L0yPvyloRWSdNSpoVCSg
	2rL2dmKxMmHnJF
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65066>

Hi,

I just realised that our test setup has a serious problem.  In my 
semi-private builtin-commit branch, there is no runstatus anymore.  Now, 
I got a new toy yesterday, and installed git on it (my fork, including 
builtin-commit), and all of a sudden tests were failing.

The failing tests were t3001 and t4001, because they call runstatus, and 
runstatus is no longer there in the builtin-commit branch.

So why did I not catch this earlier?

Because my prefix is the default prefix, which is $HOME/bin, and which is 
not turned off in the tests.  So git finds "runstatus", because it is 
still installed.

Now, things get worse if you install to /usr/bin/, which I do sometimes, 
too, because you _cannot_ remove that from the PATH.

Okay, so removing a command is not all that common, but that means that we 
have to be extra careful when we do so.

Ciao,
Dscho
