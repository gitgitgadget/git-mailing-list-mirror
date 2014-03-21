From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 20 Mar 2014 20:49:06 -0400
Message-ID: <20140321004906.GE7774@sigill.intra.peff.net>
References: <53183506.5080002@alum.mit.edu>
 <20140306155626.GB18519@sigill.intra.peff.net>
 <5318A537.4010400@alum.mit.edu>
 <20140306174803.GA30486@sigill.intra.peff.net>
 <08A515BA063C44E5A9EFC754793B2AD8@PhilipOakley>
 <531904E1.6010606@alum.mit.edu>
 <xmqqob1ivqv4.fsf@gitster.dls.corp.google.com>
 <CAP8UFD0UnUGZb9hWyLS1vPJ6fh3QR-g_p5HNQk79Gqhs9YWi0A@mail.gmail.com>
 <20140307171936.GC23587@sigill.intra.peff.net>
 <xmqq8us524pd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:49:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQneB-0006bd-2M
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 01:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966171AbaCUAtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 20:49:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:43661 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965764AbaCUAtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 20:49:09 -0400
Received: (qmail 900 invoked by uid 102); 21 Mar 2014 00:49:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Mar 2014 19:49:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2014 20:49:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8us524pd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244625>

On Wed, Mar 19, 2014 at 03:39:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Mar 07, 2014 at 08:08:37AM +0100, Christian Couder wrote:
> >
> >> > Be it graft or replace, I do not think we want to invite people to
> >> > use these mechansims too lightly to locally rewrite their history
> >> > willy-nilly without fixing their mistakes at the object layer with
> >> > "commit --amend", "rebase", "bfg", etc. in the longer term.  So in
> >> > that sense, adding a command to make it easy is not something I am
> >> > enthusiastic about.
> >> >
> >> > On the other hand, if the user does need to use graft or replace
> >> > (perhaps to prepare for casting the fixed history in stone with
> >> > filter-branch), it would be good to help them avoid making mistakes
> >> > while doing so and tool support may be a way to do so.
> >> >
> >> > So, ... I am of two minds.
> > ...
> > I do not think the features we are talking about are significantly more
> > dangerous than "git replace" is in the first place. If we want to make
> > people aware of the dangers, perhaps git-replace.1 is the right place to
> > do it.
> 
> Sure.
> 
> So should we take the four-patch series for "git replace --edit"?

I think that is certainly going in the right direction, but it is
missing documentation and tests still. Aside from a one-liner bug (which
Christian pointed out on the list), I do not think it will _hurt_
anybody. But it probably should be "finished" before seeing the light of
day. I'd be happy if you wanted to pick it up for "pu" or even "next"
waiting and do that finishing in-tree.

Otherwise, I may eventually get to it and re-roll the whole completed
series.

-Peff
