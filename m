From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 27/40] Windows: Implement a custom spawnve().
Date: Fri, 29 Feb 2008 01:18:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290117540.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-28-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281535210.22527@racer.site> <200802282204.20168.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:20:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtuu-0002ey-5X
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYB2BT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYB2BTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:19:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:50915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751171AbYB2BTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:19:24 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:19:20 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp026) with SMTP; 29 Feb 2008 02:19:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/senQfV/TsgschNr76mhAzqST/cF6XCBgNhx3+iJ
	Kr8RxbXH+JDHPu
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282204.20168.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75483>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 16:36, Johannes Schindelin wrote:
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > -	cmd->pid = spawnvpe(_P_NOWAIT, cmd->argv[0], cmd->argv, (const 
> char**)env); 
> > > +	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
> >
> > Should this not be "#define spawnvpe mingw_spanvpe" in git-compat-util.h
> > instead?
> 
> No. We don't mimic the API of the original spawnvpe. Why obfuscate this fact?

Oops.  I forgot that.  Maybe we do not want to call the function 
mingw_spawnvpe(), then?  (That fact is what made me believe that the 
#define was a good idea, after all.)

Ciao,
Dscho

