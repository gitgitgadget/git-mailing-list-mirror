From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: fix double free()
Date: Fri, 18 Jan 2008 12:14:48 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181213220.5731@racer.site>
References: <alpine.LSU.1.00.0801171943360.5731@racer.site> <20080118063417.GB22089@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, nigel.magnay@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 13:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFq8i-0008Hh-2x
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 13:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760499AbYARMO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 07:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759335AbYARMO5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 07:14:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:33271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760499AbYARMO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 07:14:56 -0500
Received: (qmail invoked by alias); 18 Jan 2008 12:14:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp036) with SMTP; 18 Jan 2008 13:14:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VZRkyAJfVReOrv2qfu6aYxgMEHTv3+AmkhZ3zuA
	6SHUeqLOPuWvN/
X-X-Sender: gene099@racer.site
In-Reply-To: <20080118063417.GB22089@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71005>

Hi,

On Fri, 18 Jan 2008, Mike Hommey wrote:

> On Thu, Jan 17, 2008 at 07:45:11PM +0000, Johannes Schindelin wrote:
> > 
> > There was an extra free(url) in remote_exists() (both if clauses 
> > before that contain a free(url) already), which resulted in a crash on 
> > Windows.
> 
> Mmmmmm the free(url) you remove has been added in 3a462bc9 and the 
> free(url) in the if clauses before have been removed in the same commit. 
> I fail to see how that could lead to a double free().
> 
> Actually, I do see how, because git show 64be904 displays an obviously 
> wrong remote_exists. OTOH, neither next, master nor pu have such code...

Ah, sorry.  I was working on an old git branch, it seems.  Will try with a 
newer one (to see if issue 71 persists).

Ciao,
Dscho
