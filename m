From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/10] support pager.* for aliases
Date: Fri, 19 Aug 2011 01:30:02 -0700
Message-ID: <20110819083001.GA2618@sigill.intra.peff.net>
References: <7vaab6552a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 10:30:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuKT0-0004u2-Om
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 10:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab1HSIaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 04:30:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47289
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1HSIaG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 04:30:06 -0400
Received: (qmail 30001 invoked by uid 107); 19 Aug 2011 08:30:45 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Aug 2011 04:30:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2011 01:30:02 -0700
Content-Disposition: inline
In-Reply-To: <7vaab6552a.fsf@alter.siamese.dyndns.org>
 <7vei0i560a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179684>

On Thu, Aug 18, 2011 at 10:23:33PM -0700, Junio C Hamano wrote:

> > I think of it this way:
> >
> > If the user thinks of the alias as just another form of "log", then we
> > do the right thing: we use log's pager config by default, and respect
> > pager.log. They never set pager.foo, because that is nonsensical in
> > their mental model.
> >
> > If the user thinks of the alias as its own command, then they would
> > expect pager.foo to work. And it does what they expect.
> >
> > But like I said, I don't personally plan on using this. It was just the
> > only semantics that really made sense to me,...
> 
> I can see that argument, but once you start paying attention to "*.foo",
> you have to keep supporting that forever, and also more importantly, you
> need to worry about interactions between "*.foo" vs "*.log". Which one
> should win? Should they combine if both are defined? My "looks confusing"
> includes that can of worms.

It seems obvious to me that the more-specific *.foo form would take
precedence over the *.log form, and anything else would be crazy. But
that is just my gut feeling. If you are confused or worried, then that
is enough for me to say it is not worth pursuing. It's not a feature I
really care about; it was more about fixing something that looked
obviously wrong while I was in the area.

-Peff
