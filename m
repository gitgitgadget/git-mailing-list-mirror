From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rebase.sh: Change .dotest directory to .git-dotest
Date: Tue, 5 Feb 2008 15:28:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802051524580.8543@racer.site>
References: <ve53xwob.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 16:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMPjf-0000pN-79
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 16:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYBEP2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 10:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbYBEP2v
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 10:28:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:60866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751479AbYBEP2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 10:28:50 -0500
Received: (qmail invoked by alias); 05 Feb 2008 15:28:48 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 05 Feb 2008 16:28:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YCUMhT2SY5coNCu8PoGHONvSROfSPevqtIs7Hm2
	VCh0XX7oHmt/0p
X-X-Sender: gene099@racer.site
In-Reply-To: <ve53xwob.fsf@blue.sea.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72672>

Hi,

On Tue, 5 Feb 2008, Jari Aalto wrote:

> Change git specific doings into namespace .git*. Define new variable 
> WORKDIR, which points to working directory .git-dotest.

No.

If at all, it should be in .git/rebase/, not in .git-dotest/.  Note that 
we have a different directory already for interactive rebase and rebase 
-m, .git/.dotest-merge/ (which could have been a better name, too).

But the consensus was that there might be scripts relying on the name of 
the directory, so we left it as-is, and did not even consolidate both 
versions into the same name.

So _if_ you still want to change it, you need a looooong-term switch-over 
plan.  For one, you _have_ to install a symbolic link in order not to 
break existing scripts, and remove it afterwards.

Ciao,
Dscho
