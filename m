From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 1/4] subtree: support split --rejoin --squash
Date: Wed, 22 Jan 2014 20:59:23 -0700
Message-ID: <20140123035923.GA4176@comcast.net>
References: <20131207185853.GA3353@comcast.net>
 <CAMzgWy18wH4_Ds00x7UASQjLgN8LiEucFSZFp-5PJio_pEwmnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Penninckx <ibizapeanut@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 05:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6BXz-00025D-28
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 05:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbaAWEFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 23:05:31 -0500
Received: from qmta06.emeryville.ca.mail.comcast.net ([76.96.30.56]:39738 "EHLO
	qmta06.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752311AbaAWEFa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 23:05:30 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2014 23:05:30 EST
Received: from omta01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by qmta06.emeryville.ca.mail.comcast.net with comcast
	id HFNc1n0070EPchoA6FzReN; Thu, 23 Jan 2014 03:59:25 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta01.emeryville.ca.mail.comcast.net with comcast
	id HFzP1n00c1UYGSS8MFzQfV; Thu, 23 Jan 2014 03:59:24 +0000
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id 669701E96261; Wed, 22 Jan 2014 20:59:23 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <CAMzgWy18wH4_Ds00x7UASQjLgN8LiEucFSZFp-5PJio_pEwmnA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390449565;
	bh=63VKcf/xsMfY/Ryu117vcPF4blsIbIoX6vtfEppVuWw=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=c/YdZtt5ZTjC7H+KajIu+ArMadfziJQoictUsT1WbjrUzaFrJkfBESpNaxzS3c3B0
	 Ge5p61spyO36Ax9mX3t9cQsVqs0wjXbZbLc8pbBc7Nntj8+cPF3ps/44qX9fbgRARA
	 kSYaZHVOQAG8Y/M+Ru3sFPFCyhVcSATFf/7db36PRN6Mdco4kw7y59tGFKdNIMAQ5m
	 AUbBScjSz23F2nNSY7AXqij8KJBjPUgMZn9hhQDgxrfbCmSd7UVSHKZRboVSXxbffR
	 9tOAvTCs5xk3up9T3tRjDocw1DHmPq+xqpAx2LfVgtMkJtDmmNF8SHoRwJcPXDMPq/
	 IdZeu9QDs89VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240901>

On Wed, Jan 22, 2014 at 03:58:28PM +0100, Pierre Penninckx wrote:
> 2013/12/7 Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> > Subject: [PATCH 1/4] subtree: support split --rejoin --squash
> >
> > Allow using --squash with "git subtree split --rejoin".  It
> > will still split off (and save to --branch) the complete
> > subtree history, but the merge done for the "--rejoin" will
> > be merging a squashed representation of the new subtree
> > commits, instead of the commits themselves (similar to
> > how "git subtree merge --squash" works).
> >
> > Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> > ---
> >
> > I can think of a couple of possible objections to this patch.
> > Are these (or any others) worth fixing?
> >
> > 1. Perhaps someone want the saved subtree (--branch) to have
> >    a squashed representation as well, as an option?  Maybe we
> >    need two different --squash options?  Something
> >    like "--rejoin-squash"?
> > 2. It could definitely use some automated tests.  In fact,
> >    pre-existing --squash functionality is hardly tested at
> >    all, either.
> >       See patch 4 comments for a script I use to help with
> >    mostly-manual testing.
>
> Sorry to bother you with this again, but I was wondering if those patches
> would be integrated into git anytime soon.
> And if not, if there is something I can do to help.
> 
> I found them by the way, thanks a lot!
> 
> Pierre

I'm not sure when or if the patches will make it in.  Junio's
weekly "What's cooking..." email has asked for "Comments?" about
them for the past several weeks, but I have yet to see
anyone actually comment about them.

Searching throught the last couple of years of mailing list
archives for "subtree" reveals a general lack of a active
maintainer(s) to help review and improve patches for "git
subtree".  Given the general lack of help and feedback, it is
understandable that Junio has largely limited inclusion of
subtree patches to trivially obvious bug fixes.

                        - Matthew Ogilvie
