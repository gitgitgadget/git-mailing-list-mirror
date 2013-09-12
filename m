From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Re-Transmission of blobs?
Date: Thu, 12 Sep 2013 12:35:32 +0200
Message-ID: <20130912103531.GD14259@raven.wolf.lan>
References: <20130910130837.GA14259@raven.wolf.lan>
 <xmqqsixcy395.fsf@gitster.dls.corp.google.com>
 <20130911112758.GB14259@raven.wolf.lan>
 <xmqqsixbth4h.fsf@gitster.dls.corp.google.com>
 <20130912074241.GC14259@raven.wolf.lan>
 <20130912092339.GA30702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 12:40:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK4Js-0002XO-OW
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586Ab3ILKkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 06:40:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:57742 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab3ILKkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:40:09 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1VK4Jk-0001W2-7d; Thu, 12 Sep 2013 12:40:08 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 5757D7638E; Thu, 12 Sep 2013 12:35:32 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130912092339.GA30702@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234644>

On Do, Sep 12, 2013 at 05:23:40 -0400, Jeff King wrote:
> On Thu, Sep 12, 2013 at 09:42:41AM +0200, Josef Wolf wrote:
>
> I think Junio is referring to the reachability bitmap work. We may know
> that the other side has commit "E" (and therefore every object reachable
> from it), but we do not walk the graph to find the complete set of
> reachable objects. Doing so requires a lot of CPU and I/O, and in most
> cases does not help much.

I'm not sure I understand correctly. I see that bitmaps can be used to
implement set operations. But how comes that walking the graph requires a lot
of CPU? Isn't it O(n)?

> However, if we had an index of reachable objects (e.g., a bitmap) for
> each commit, then we could very cheaply compute the set difference
> between what the other side wants and what they have.

Those bitmaps would be stored in the git metadata? Is it worth it? Storing a
bitmap for every commit just to be used once-in-a-while seems to be a pretty
big overhead to me. Not to mention the interoperability problems you mentioned
below.

> JGit has support for pack bitmaps already. There was a patch series a
> few months ago to implement a similar functionality for C git, but the
> on-disk format was not compatible with JGit's. That series has been
> reworked off-list to be compatible with the JGit implementation.
> 
> Those patches need a little cleanup before they are ready for the list,
> but hopefully that should happen soon-ish.

Sounds like you're already almost done and don't really need help
anymore. Just out of curiosity, I'd be interested in a pointer anyway ;-)

-- 
Josef Wolf
jw@raven.inka.de
