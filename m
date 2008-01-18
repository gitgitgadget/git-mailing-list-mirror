From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: fix double free()
Date: Fri, 18 Jan 2008 14:54:47 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181454400.5731@racer.site>
References: <alpine.LSU.1.00.0801171943360.5731@racer.site> <20080118063417.GB22089@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, nigel.magnay@gmail.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:55:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFscq-0006Ti-Uq
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761388AbYAROyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYAROyz
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:54:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:42647 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753512AbYAROyy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:54:54 -0500
Received: (qmail invoked by alias); 18 Jan 2008 14:54:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 18 Jan 2008 15:54:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198VIVdy118MHC8oLNRuCqdl71jL3Qj2MTF7eo9/O
	cp6yTcKWOwjd9R
X-X-Sender: gene099@racer.site
In-Reply-To: <20080118063417.GB22089@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71025>

Hi,

On Fri, 18 Jan 2008, Mike Hommey wrote:

> On Thu, Jan 17, 2008 at 07:45:11PM +0000, Johannes Schindelin wrote:
> > 
> > There was an extra free(url) in remote_exists() (both if clauses before 
> > that contain a free(url) already), which resulted in a crash on Windows.
> 
> Mmmmmm the free(url) you remove has been added in 3a462bc9 and the 
> free(url) in the if clauses before have been removed in the same commit. 
> I fail to see how that could lead to a double free().

Yes, I confirm that my "fix" is wrong, because it was based on an 
_obsolete_ source tree.  Git-1.5.4-rc3-preview20080113.exe of msysGit 
appears not to have a problem with HTTP pushing.

Sorry for the noise,
Dscho
