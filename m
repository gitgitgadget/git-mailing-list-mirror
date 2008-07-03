From: Jeff King <peff@peff.net>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 3 Jul 2008 15:08:29 -0400
Message-ID: <20080703190829.GA18205@sigill.intra.peff.net>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr> <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com> <7vzlpe8nyo.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.10.0806212343560.18093@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0806221107540.15126@fbirervta.pbzchgretzou.qr> <7vtzflolis.fsf@gitster.siamese.dyndns.org> <7vtzfln5zw.fsf@gitster.siamese.dyndns.org> <20080703021541.GK18147@mail.rocksoft.com> <alpine.DEB.1.00.0807031303080.9925@racer> <08353871-5C94-4E97-9589-DC3980C47CD4@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Stoakes <tim@stoakes.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 21:09:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEUBS-0005eM-Qv
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 21:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137AbYGCTIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 15:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbYGCTIc
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 15:08:32 -0400
Received: from peff.net ([208.65.91.99]:4052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbYGCTIb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 15:08:31 -0400
Received: (qmail 3257 invoked by uid 111); 3 Jul 2008 19:08:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 15:08:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 15:08:29 -0400
Content-Disposition: inline
In-Reply-To: <08353871-5C94-4E97-9589-DC3980C47CD4@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87305>

On Thu, Jul 03, 2008 at 03:37:30PM +0200, Wincent Colaiuta wrote:

>>> This [changing git status to use the pager automatically] was quite a
>>> nasty change to sneak on people I think.
>>
>> Well, I think that a command producing pages and pages of output
>> without stopping is useless.  Therefore, _I_ maintain that it makes
>> tons of  sense.
>
> Ditto. For me, the change was very welcome. Sure, usually the status
> output is short, but on those occasions where it isn't (big file
> reorganizations etc) I was quite sick of doing the "git status, oops
> that output was too long let's try again, git -p status" dance. It was
> also incongruous with my very first experiences with Git, where I had
> been pleasantly surprised that "git log" automatically invoked the
> pager whereas "svn log" just spewed output into my console until ^C.

I think there is not much point in discussing whether "git status"
should use a pager. It is obvious at this point that some people love
it, and some people despise it, and it seems to be a matter of personal
preference. The only sane way forward seems to be configurable paging.
So the next steps are:

  - getting a configurable paging patch that is good enough; I just
    posted another trial, but there are still a few caveats. I would
    love to hear commentary on whether people find it acceptable.

  - once there is a patch, there is still the matter of "on by default,
    make people configure off" versus "off by default, make people
    configure on". And then you can make arguments about how the default
    changes the new user experience, but hopefully there will be a
    little less vehemence on both sides, since it is "here's what new
    users should see" and not "here's what I am forced to see every
    day".

-Peff
