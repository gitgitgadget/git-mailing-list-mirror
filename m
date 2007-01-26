From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: StGIT and repo-config
Date: Sat, 27 Jan 2007 00:12:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701270008410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070125225512.GF4083@nan92-1-81-57-214-146.fbx.proxad.net>
 <b0943d9e0701251545w1b34a0dcg545eeab08d767e38@mail.gmail.com>
 <Pine.LNX.4.63.0701260052590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:12:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAaFS-00015L-1F
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbXAZXMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbXAZXMi
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:12:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:47680 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751743AbXAZXMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:12:37 -0500
Received: (qmail invoked by alias); 26 Jan 2007 23:12:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 27 Jan 2007 00:12:36 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070126175302.GG4083@nan92-1-81-57-214-146.fbx.proxad.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37896>

Hi,

On Fri, 26 Jan 2007, Yann Dirson wrote:

> On Fri, Jan 26, 2007 at 12:58:38AM +0100, Johannes Schindelin wrote:
>
> > I then proposed to have a simple --dump option to repo-config, which 
> > outputs NUL separated key/value pairs (substituting "true" for keys 
> > without -- not with empty! -- values). But somehow the discussion petered 
> > out before anything came out of it.
> 
> Even if that was to be done in git, it would surely be post-1.5, so we
> need another way to do things in the meantime.

I don't think it is too late. If it is simple enough, and stuck behind a 
command line option (not affecting the rest of repo-config), it is safe 
enough to include.

> > The most important point (to me) which came out of the discussion: It is 
> > not at all easy, or straight-forward, to handle multi-vars, i.e. multiple 
> > values for the same key.
> 
> Right, at least for filling a dictionnary.  We would need to declare
> multi-valued parameters as such, which basically means we must only
> try to read those config items we know about, which has all sorts of
> consequences for config.py :)

Well, we have only two multi-valued keys at the moment (AFAIK): 
remote.<branch>.fetch and remove.<branch>.push.

Even if there are more, they are hardly interesting to StGIT, right? So 
why not just pretend that they don't exist, by making a dictionary, 
putting each new key/value pair into it one by one? (Forgetting all but 
the last value for multi-values...)

> It would seem reasonable to start without a cache dictionnary, at least 
> for now.  After all, there are not so many config items to know about in 
> a single stgit run, so IIMHO we're only going to notice a difference for 
> the time needed to run the testsuite.

The point is: it is very easy and short to just stash everything into a 
dictionary, and retrieve it from there.

Ciao,
Dscho
