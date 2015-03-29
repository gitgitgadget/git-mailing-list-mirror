From: Kevin D <me@ikke.info>
Subject: Re: how to make "full" copy of a repo
Date: Sun, 29 Mar 2015 13:05:06 +0200
Message-ID: <20150329110506.GC9387@vps892.directvps.nl>
References: <1427511397.19633.52.camel@scientia.net>
 <20150328143152.GB9387@vps892.directvps.nl>
 <1427595686.4912.17.camel@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Anton Mitterer <calestyo@scientia.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 13:05:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcB1w-0005eU-LE
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 13:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbbC2LFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 07:05:09 -0400
Received: from ikke.info ([178.21.113.177]:33474 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbC2LFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 07:05:08 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id ABBD91DCF6D; Sun, 29 Mar 2015 13:05:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1427595686.4912.17.camel@scientia.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266434>

On Sun, Mar 29, 2015 at 04:21:26AM +0200, Christoph Anton Mitterer wrote:
> On Sat, 2015-03-28 at 15:31 +0100, Kevin D wrote: 
> [..]
> 
> > * reflog (history of refs, though, by default disabled for bare
> >   repositories)
> is there a way to get this copied?
> 
> 

No, the reflog is considered something private to the repository, so
there is no way to git it through git clone.

> [..] 
> 
> > git clone --mirror is used for repositories that regularly get updates
> > from the repositories they were cloned from. Though this is not what you
> > want, it's not difficult to reset the refspecs to the default refspecs.
> What do you mean here? What would I need to reset exactly?

git clone --mirror sets up the fetch refspec in such a way that local
refs would get reset to whatever upstream has:

+refs/*:refs/*

So every time you would fetch / pull, all your branches would reflect
the way they are on the mirrored repo (which is why it's called mirror).

The default refspec is:

+refs/heads/*:refs/remotes/origin/*

Which would only fetch heads (branches), and maps them as remote
tracking branches, so that your local branches are left alone.

> > git clone --mirror is the closest you are going to get by only using
> > git.
> I see, thanks :)
> 
> > So to summarize, git clone is only used for cloning history, which means
> > objects and refs, the rest is not part of cloning. To get more, you have
> > to go outside git.
> 
> Thanks :)
> Chris.
