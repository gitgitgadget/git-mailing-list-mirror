From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Equivalent of `svn switch` for git-svn?
Date: Thu, 27 Sep 2007 12:54:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709271253040.28395@racer.site>
References: <46FB5086.7070408@apple.com> <20070927100607.GC10289@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iarxu-0000IO-Ju
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbXI0Lz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbXI0Lz0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:55:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:45539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750958AbXI0LzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:55:25 -0400
Received: (qmail invoked by alias); 27 Sep 2007 11:55:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 27 Sep 2007 13:55:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eC7QlRrweY8JL9lDQA9wjirc9ajNUQO3fcaPBhX
	+04zz/dh5vd4Do
X-X-Sender: gene099@racer.site
In-Reply-To: <20070927100607.GC10289@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59291>

Hi,

On Thu, 27 Sep 2007, Pierre Habouzit wrote:

> On Thu, Sep 27, 2007 at 06:41:10AM +0000, Adam Roben wrote:
> > Hi all-
> >   I've recently been informed that the Subversion server I and several 
> > others have been tracking with git-svn will be switching from using the 
> > svn+ssh scheme to the http scheme. To handle this, users of svn will be 
> > running `svn switch` to move their working copies to the new repository 
> > URL. Is there some way to do the same for git-svn? I suspect the biggest 
> > complication will come from the git-svn-id: lines in the commit logs, 
> > since changing that line would require changing the commit hash as well.
> 
>   edit your .git/config, in the section [svn-remote "svn"], change url =

Or use git-config:

	git config svn-remote.svn.url <url>

Or make it a global alias:

	git config --global alias svn-switch 'config svn-remote.svn.url'

so that you can say

	git svn-switch <url>

Ciao,
Dscho
