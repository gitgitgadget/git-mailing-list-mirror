From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Multiple working trees with GIT ?
Date: Thu, 24 Jan 2008 11:04:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801241102260.5731@racer.site>
References: <20080124074952.GA8793@1wt.eu> <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Willy Tarreau <w@1wt.eu>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 12:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHztf-0006Ls-21
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbYAXLEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 06:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYAXLEw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 06:04:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:55337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753844AbYAXLEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 06:04:52 -0500
Received: (qmail invoked by alias); 24 Jan 2008 11:04:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 24 Jan 2008 12:04:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wk0grWSQwT+0X9JE7LP4b8Sxy8xGbgaOP+9wdZf
	Dsoh62oHqcTjy5
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0801240947230.14173@reaper.quantumfyre.co.uk>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71615>

Hi,

On Thu, 24 Jan 2008, Julian Phillips wrote:

> You might want to have a look at the git-new-workdir script in contrib, 
> it does basically the same thing.  It's been there for about 10 months 
> now. It was based on an email from Junio:
> 
> http://article.gmane.org/gmane.comp.version-control.git/41513/

FWIW I have a patch to do something like that in "git branch" itself.

> However, there are some caveats about using this approach, basically 
> about the fact that there is nothing stopping you from updating refs 
> that are currently checked out in another directory and causing yourself 
> all sorts of pain ... the topic has cropped up a couple of times on the 
> list since the script was added.

I agree; maybe we should have a telltale file 
"refs/heads/<bla>.checkedout" which is heeded by "git checkout" and "git 
branch -d/-D", as well as update_ref() (should only update that ref when 
it HEAD points to it)?

Ciao,
Dscho
