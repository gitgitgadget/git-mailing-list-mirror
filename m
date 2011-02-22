From: Jeff King <peff@peff.net>
Subject: Re: How to create tags outside of refs/tags?
Date: Tue, 22 Feb 2011 03:14:58 -0500
Message-ID: <20110222081458.GA11825@sigill.intra.peff.net>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com>
 <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com>
 <20110222080305.GA11177@sigill.intra.peff.net>
 <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 09:15:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrnOo-0007no-HX
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 09:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab1BVIPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 03:15:03 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab1BVIPC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 03:15:02 -0500
Received: (qmail 31130 invoked by uid 111); 22 Feb 2011 08:15:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 22 Feb 2011 08:15:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Feb 2011 03:14:58 -0500
Content-Disposition: inline
In-Reply-To: <7vvd0cebi6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167535>

On Tue, Feb 22, 2011 at 12:09:37AM -0800, Junio C Hamano wrote:

> >   # tell git to ignore boring stuff
> >   git config tag.ignore 'boring/*'
> >   git config --add tag.ignore 'more-boring/*'
> 
> Hmph, isn't that what "grep -v" was invented for?

Heh. Yeah, but I think the point is that you will want to do this _every
time_, so it saves typing. I guess you could make an alias. Or even more
hack-ish, a custom tag.pager that filters the results. ;)

Yet another option that would work in my example is to use
"interesting/*" as a positive pattern. But that implies that all of the
interesting ones can be grouped in that way.

I dunno. I don't really care much either way. I would probably not be a
user of this feature myself.

> Also it is unclear if the boring tags will or will not be propagated (or
> should or should not be, for that matter) to outer world when you do "git
> push --tags" with your "ignore".  Most likely some people do want to see
> them hidden (e.g. when publishing), and some others do want to be pushed
> (e.g. when backing the repository up).

I think changing the config name to tag.list-ignore would make it more
obvious what is going on. If you don't want to push certain tags, I
think refspecs are the way to do that, and this should be a purely local
display thing.

-Peff
