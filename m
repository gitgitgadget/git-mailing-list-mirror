From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
 branch
Date: Tue, 19 Feb 2008 13:17:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191313290.30505@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080219125840.GA14049@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:18:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSMR-0000tf-UB
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbYBSNRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYBSNRk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:17:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:56310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752270AbYBSNRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:17:40 -0500
Received: (qmail invoked by alias); 19 Feb 2008 13:17:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 19 Feb 2008 14:17:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kNx13RBykB8dmqICGVpH2EBRTSzKEfxKjurTaSv
	TMLkxIzt4XVcHo
X-X-Sender: gene099@racer.site
In-Reply-To: <20080219125840.GA14049@localhost>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74400>

Hi,

On Tue, 19 Feb 2008, Clemens Buchacher wrote:

> On Mon, Feb 18, 2008 at 05:34:45PM +0000, Johannes Schindelin wrote:
>
> > Thanks for the patch, I think it good.  Now, if we only had automated 
> > tests... ;-)
> 
> Thank you. Implementing a test should be fairly difficult, since we need 
> at least a WebDAV capable webserver, right? Do you having something in 
> mind?

Actually, thinking about it again, it should not be _that_ difficult.  We 
would need to ship a httpd.conf.in, pick a port (maybe 8111, because that 
is already used in t5703-daemon.sh), generate httpd.conf and then start 
Apache with that.

If Apache does not want to start, skip this test.  (This might happen due 
to Apache not being installed, or the DAV modules not being installed, or 
Apache not finding them, or...)

And of course, we would want to have something like NO_SVN_TESTS (maybe 
NO_APACHE_TESTS) to be able to skip the tests, since they are pretty 
expensive (starting Apache and all).

> And yes, 'peer' apparently refers to the local end in this case.

Thanks for the clarification.

Ciao,
Dscho
