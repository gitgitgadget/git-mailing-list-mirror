From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/5] gitweb: Selecting diffs in JavaScript
Date: Sun, 26 Aug 2007 19:21:29 +0200
Message-ID: <20070826172129.GK1219@pasky.or.cz>
References: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121315-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926121911-git-send-email-mkoegler@auto.tuwien.ac.at> <11796926122089-git-send-email-mkoegler@auto.tuwien.ac.at> <20070826011742.GF1219@pasky.or.cz> <20070826161701.GA3300@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Sun Aug 26 19:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPLnt-0003Sb-CP
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 19:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbXHZRVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 13:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754048AbXHZRVd
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 13:21:33 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55207 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963AbXHZRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 13:21:33 -0400
Received: (qmail 17827 invoked by uid 2001); 26 Aug 2007 19:21:29 +0200
Content-Disposition: inline
In-Reply-To: <20070826161701.GA3300@auto.tuwien.ac.at>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56705>

On Sun, Aug 26, 2007 at 06:17:01PM CEST, Martin Koegler wrote:
> http://repo.or.cz/w/git/repo.git?a=search&h=HEAD&st=grep&s=GitAddLinks
> reveals, that the function GitAddLinks is never called.
> You should add a call to GitAddLinks in fixBlameLinks or call
> both functions in <body onload="...">.

Whoops, sorry - I already had that in, but must have accidentally
removed it again.

> > One thing for certain is that I would get rid of GitAddLinks and instead
> > have href() add the extra links there, by default display: none and
> > javascript code making it show.
> 
> display: none will only work in CSS capable browses, but not text
> browsers. Also why do we want do increase the size of each generated
> page?

These are both good points. The only thing I'm worried about is browser
performance; at least my Firefox can take noticeable few hundreds of
milliseconds to insert the links to only moderately sized pages.

> > Also, there are obvious UI bugs, like
> > commit and tree entries for commits having redundant base/diff links;
> 
> Is this really a bug? I think it makes the interface more consistent.
> 
> Would it be clear for a (new) user, why some tree entries have the
> base/diff links and some not?

My aim is rather to have every single _entry_ to have a single base/diff
linkpair. Having two linkpairs seems more confusing to me.

> > But maybe it needs more general overhaul and the links added explicitly
> > in the views, because it really makes sense to have only a single
> > linkpair per entry and it would be good to have this always at the same
> > place, and perhaps in a different color. Hmm. And it seems that it's
> > getting in the way, overally.
> 
> Unless this should be come part of the official gitweb, adding each
> link explicitly would be a maintaince nightmare.

This should become part of the official gitweb, what's the point
otherwise. :-)

> Changing the color of the base/diff links is no problem. If somebody
> is interessed in this (and tells me, which colors I should use), I can
> adapt my patch.
>
> > What about having another item in the main action menu, 'diff'?
> > Base/diff links are by default display: none but show up when you click
> > at 'diff', in green. They will keep showing up until you click 'diff'
> > again. When you click 'base', both the selected base link and main
> > 'diff' link changes color to red.
> 
> We could call GitAddLinks, if the user clicks on the diff link instead
> of calling GitAddLinks at page load time.
> 
> I could rewrite the JavaScript for this, if you think it is so more useful.

That would be awesome.

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
