From: Jeff King <peff@peff.net>
Subject: Re: push.default documented in "man git-push"?
Date: Wed, 3 Oct 2012 17:40:51 -0400
Message-ID: <20121003214051.GD4484@sigill.intra.peff.net>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7v7gr75s40.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKG-0001DP-S0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425Ab2JCVky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 17:40:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39487 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756347Ab2JCVkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 17:40:53 -0400
Received: (qmail 13049 invoked by uid 107); 3 Oct 2012 21:41:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Oct 2012 17:41:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2012 17:40:51 -0400
Content-Disposition: inline
In-Reply-To: <7v7gr75s40.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206939>

On Wed, Oct 03, 2012 at 11:26:55AM -0700, Junio C Hamano wrote:

> Please do not label the list as "These variables affect this
> command" to give a false impression that it is the complete list if
> it isn't.
> 
> Unless somebody promises to keep an up-to-date complete list there
> (or even better, come up with a mechanism to help us keep that
> promise automatically, perhaps by annotating pieces with structured
> comments in config.txt and automatically appending such a section to
> manual pages of relevant commands), that is.
>
> With a weaker phrase, e.g. "These configuration variables may be of
> interest", such a list may not hurt readers, but personally I do not
> think it adds much value to have a list of variables without even a
> single line description of what each is used for.

We talked a while ago about actually moving the config options into the
individual manpages, and generating config.txt to simply contain an
index of keys and where their definitions may be found. That also has
the "list without description" characteristic. But presumably you would
be looking for keys in the manual of the command you want to affect, and
the master list would mostly be for redirecting you to the right
manpage.

It does break down a little when you have keys that could go in multiple
pages. In many cases, this can be solved by a canonical location that
describes the shared concepts. For example, `diff.*` should probably go
into a `gitdiff(7)` that talks about the various diff options and
formats.

Of course, that only works if you think pulling out the shared diff bits
from git-diff*, git-log, etc into a separate manpage is a good idea. I
do, because I think it makes it more clear to the reader how the
concepts connect (as opposed to simply including shared bits inline in
the manpages, as we do now, with no indication that the same content is
going to apply in many places). But it does have a downside that
individual manpages are not as easily searchable via the pager, as you
may have to follow a cross-reference to find what you want.

-Peff
