From: Peter Osterlund <petero2@telia.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: 04 Jul 2005 14:32:36 +0200
Message-ID: <m3y88m21ln.fsf@telia.com>
References: <1119994003.9631.6.camel@localhost.localdomain>
	<m3ekagp9mk.fsf@telia.com>
	<1120385280.6845.12.camel@localhost.localdomain>
	<m3oe9k6p40.fsf@telia.com>
	<1120425269.6845.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 04 14:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpQB0-00046o-RB
	for gcvg-git@gmane.org; Mon, 04 Jul 2005 14:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGDMfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 08:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVGDMfm
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 08:35:42 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:7645 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261658AbVGDMf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2005 08:35:28 -0400
Received: from r3000.localdomain (62.20.229.161) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 42B94E2900223BCB; Mon, 4 Jul 2005 14:35:25 +0200
Received: from r3000.localdomain (r3000.localdomain [127.0.0.1])
	by r3000.localdomain (8.13.1/8.13.1) with ESMTP id j64CZMaS016258;
	Mon, 4 Jul 2005 14:35:22 +0200
Received: (from petero@localhost)
	by r3000.localdomain (8.13.1/8.13.1/Submit) id j64CWcik015928;
	Mon, 4 Jul 2005 14:32:38 +0200
X-Authentication-Warning: r3000.localdomain: petero set sender to petero2@telia.com using -f
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1120425269.6845.28.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> writes:

> On Sun, 2005-07-03 at 14:38 +0200, Peter Osterlund wrote:
> > Catalin Marinas <catalin.marinas@gmail.com> writes:
> > > I know that using -A gives a more detailed output in case of a conflict.
> > > The problem is that you will get a conflict even if the changes are
> > > identical, making it impossible to detect when a patch was merged
> > > upstream.
> > 
> > OK, I see. How about using wiggle instead?
> > 
> >         http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/
> > 
> > That's what patch-utils uses if you run "pushpatch -m". wiggle is also
> > a lot smarter than diff3, so there will be fewer cases that result in
> > a conflict. Maybe a parameter to "stg push" could enable wiggle mode.
> 
> I haven't used wiggle before but I will give it a try (though I prefer
> such a tool not to be too smart since it might make mistakes). Anyway, I
> will make this configurable, i.e. you could put something like below in
> the .stgitrc file:
> 
> merger = 'diff3 -m -E %(branch1)s %(ancestor)s %(branch2)s'
> 
> or
> 
> merger = 'wiggle -m %(branch1)s %(ancestor)s %(branch2)s'
> 
> > Is there a way in StGIT to undo a push that results in a large mess of
> > conflicts?
> 
> Good point. No, there isn't yet. I will think about an undo command. At
> the moment, the old top and bottom ids of a patch are saved so that the
> patch before the merge can be retrieved but there isn't any command to
> make use of them.

I agree with the other comments, it's probably not wise to rely on
wiggle, and wiggle sometimes makes a mess. However, it often does the
right thing, and with a configurable merge program and an undo
function, this should not be a problem. Just undo and try again if you
don't like the result.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
