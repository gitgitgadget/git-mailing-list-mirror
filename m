From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] parse-options: Allow abbreviated options when unambiguous
Date: Sun, 14 Oct 2007 14:01:30 -0700
Message-ID: <20071014210130.GA17675@soma>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 23:02:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhAal-00022s-6K
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 23:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbXJNVBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 17:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758162AbXJNVBc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 17:01:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:45152 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753774AbXJNVBb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 17:01:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 923277DC0FE;
	Sun, 14 Oct 2007 14:01:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071014180815.GK1198@artemis.corp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60904>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Sun, Oct 14, 2007 at 06:02:33PM +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Sun, 14 Oct 2007, Johannes Schindelin wrote:
> > 
> > > When there is an option "--amend", the option parser now recognizes 
> > > "--am" for that option, provided that there is no other option beginning 
> > > with "--am".
> > 
> > And an amend for ultra-abbreviated options (as you noticed on IRC):
> > 
> > diff --git a/parse-options.c b/parse-options.c
> > index afc6c89..acabb98 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -137,6 +137,11 @@ is_abbreviated:
> >  				abbrev_flags = flags;
> >  				continue;
> >  			}
> > +			/* negated and abbreviated very much? */
> > +			if (!prefixcmp("no-", arg)) {
> > +				flags |= OPT_UNSET;
> > +				goto is_abbreviated;
> > +			}
> >  			/* negated? */
> >  			if (strncmp(arg, "no-", 3))
> >  				continue;
> 
>   squashed on top on the previous, and pushed to my ph/parseopt branch.

Awesome.  Thanks to both of you.

-- 
Eric Wong
