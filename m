From: Jeff King <peff@peff.net>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Thu, 20 Jan 2011 19:20:20 -0500
Message-ID: <20110121002020.GA7874@sigill.intra.peff.net>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch>
 <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
 <20110120231649.GC14184@vidovic>
 <20110120233429.GB9442@sigill.intra.peff.net>
 <4D38CDC4.6010803@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Fri Jan 21 01:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg4jt-00013W-41
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 01:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623Ab1AUAUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 19:20:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49468 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab1AUAUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 19:20:23 -0500
Received: (qmail 15329 invoked by uid 111); 21 Jan 2011 00:20:22 -0000
Received: from 99-189-169-83.lightspeed.snjsca.sbcglobal.net (HELO sigill.intra.peff.net) (99.189.169.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 21 Jan 2011 00:20:22 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jan 2011 19:20:20 -0500
Content-Disposition: inline
In-Reply-To: <4D38CDC4.6010803@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165350>

On Fri, Jan 21, 2011 at 01:05:24AM +0100, Sebastian Pipping wrote:

> > The problem is that we have a bazillion diff options that appear in many
> > manpages, so you are stuck with one of:
> > 
> >   1. repeat them all in each manpage (usually via some automagic
> >      include), which dwarfs the original content, and makes it hard for
> >      users to see subtle differences between commands
> > 
> >   2. Say "this describes only the most frequently used options", which
> >      leaves the user wondering which infrequently used options exist.
> > 
> >   3. Say "we also take diff options, and you can find out more about
> >      diff options in git-diff(1)." This at least points the user in the
> >      right direction, but you can't search for "--color-words" in the
> >      page.
> > 
> >   4. Do (3), but also list the all (or common) diff options in a succint
> >      list without descriptions, and refer the user to git-diff(1). Then
> >      they can grep if they like, and while they won't get the immediate
> >      answer, they will get referred to the right place.
> > 
> > As you can probably guess, I favor option (4), though we already do (3)
> > in some places.
> 
> I agree with Thomas here.  (1) is the only option I find acceptable,
> personally.  If you'd rather not do that, then at least know I now.
> Great to have --color-words around btw.

I'm curious why (4) doesn't work for you. I assumed you came to the
problem by one of:

  - you wanted to know which options "git show" had, so you looked in
    the manpage. Nothing told you about "--color-words", nor referred
    you to a list of diff options. With (4), you would find that it
    accepted all diff options, and then go read the list of diff options
    (if you weren't already familiar with it).

  - you knew about --color-words, and wondered if "git show" supported
    it. In the current case, searching the page turns up nothing. In
    option (4), a search would find it (with a reference to diff options
    if you wanted more details).

The downside is that you sometimes have to be referred. The upside to me
is that it becomes explicit that there is a concept of "diff options"
that you can look up easily and which we can refer to easily in other
parts of the manual. That helps establish a mental model of how git's
options work.

So is it just that being referred is annoying, or something else?

-Peff
