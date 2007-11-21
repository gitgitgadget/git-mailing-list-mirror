From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb: kernel versions in the history (feature request,
	probably)
Date: Wed, 21 Nov 2007 16:18:31 +0100
Message-ID: <20071121151831.GO1001@machine.or.cz>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz> <47436E0F.6080003@o2.pl> <20071121032009.GB4175@fieldses.org> <20071121075217.GA1642@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Jarek Poplawski <jarkao2@o2.pl>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:19:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurLp-0000qe-93
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbXKUPSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbXKUPSe
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:18:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:38216 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbXKUPSd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:18:33 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id BDFA85A5A8; Wed, 21 Nov 2007 16:18:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071121075217.GA1642@ff.dom.local>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65662>

On Wed, Nov 21, 2007 at 08:52:17AM +0100, Jarek Poplawski wrote:
> ...
> tags
> 4 days ago 	v2.6.24-rc3 	Linux 2.6.24-rc3
> 2 weeks ago 	v2.6.24-rc2 	Linux 2.6.24-rc2
> 4 weeks ago 	v2.6.24-rc1 	Linux 2.6.24-rc1
> 6 weeks ago 	v2.6.23 	Linux 2.6.23
> 
> which drives me crazy, because, without looking at the calendar, and
> calculator, I don't really know which month was 6 weeks ago, and 4
> days ago, either!

I have myself never been sure if the relative times are a good idea or
not. :-) Sometimes I hate them, sometimes they are more convenient...

At any rate, if you click at the tag name, you should get tag page with
full date.

> So, I go to the: http://www.eu.kernel.org/pub/linux/kernel/v2.6/, 
> do some scrolling, look at this:
> ChangeLog-2.6.23             09-Oct-2007 20:38  3.8M  
> 
> and only now I can guess, this napi patch didn't manage to 2.6.23.
> Of course, usually I've to do a few more clicks and reading to make
> sure where it really started.
> 
> So, this could suggest this 2007-10-10 (probably stored with time
> too), could be useful here... but it seems, I'm wrong.

Yes, there are three scenarios:

(i) The patch has been _created_ after the release date. It can't be in
the release.
(ii) The patch has been created before the release date, but _committed_
after the release date. It can't be in the release either.
(iii) The patch has been committed before the release date. It _still_
might not be in the release if it comes from a different branch.
Imagine, say, tglx accepting the patch in his branch, then Linus
releasing new kernel version, and only _then_ Linus merging tglx's
branch.

So the time information isn't really too useful if you want to be any
sort of reliable.

> Of course, this problem doesn't look so hard if we forget about
> git internals: I can imagine keeping a simple database, which
> could simply retrieve commit numbers from these ChangeLogs, and
> connecting this with gitweb's commit page as well... For
> performance reasons, doing it only for stable and testing, so with
> -rc 'precision' would be very helpful too.

It isn't too hard if we don't forget about git internals either. It's
just that getting this information might not be cheap. But maybe I'm
wrong and this won't be a problem for sane projects. Someone should post
a patch. ;-)

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
