From: Jeff King <peff@peff.net>
Subject: Re: [Patch 0/5] Create single PDF for all HTML files
Date: Mon, 15 Oct 2012 13:42:43 -0400
Message-ID: <20121015174243.GA31658@sigill.intra.peff.net>
References: <20121006193205.GD3644@sigill.intra.peff.net>
 <505841759.269631.1349538675925.JavaMail.ngmail@webmail08.arcor-online.net>
 <1770841099.101310.1349597668191.JavaMail.ngmail@webmail23.arcor-online.net>
 <20121007225232.GA3490@sigill.intra.peff.net>
 <507BF9C7.1080601@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNogx-0003SU-IH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 19:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab2JORmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 13:42:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53048 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab2JORmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 13:42:49 -0400
Received: (qmail 2962 invoked by uid 107); 15 Oct 2012 17:43:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Oct 2012 13:43:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:42:43 -0400
Content-Disposition: inline
In-Reply-To: <507BF9C7.1080601@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207765>

On Mon, Oct 15, 2012 at 01:55:51PM +0200, Michael J Gruber wrote:

> > I wonder if a more sane route is to drop HTML entirely, convert the
> > asciidoc to docbook (which we already do for manpages), and then create
> > a docbook document that is a collection of all elements, which can then
> 
> Hmm, I think the html output often looks better than the man output
> (tables and such), and it is a formatted, reflowable, interlinked format
> fit for many puposes.

It does look better, but that is because the docbook->roff step is where
things get ugly. In theory, docbook is at least as expressive as HTML,
and has lots of nice semantic markup that gives us flexibility in what
the final product looks like.

There are docbook->epub converters (I think xmlto will do this out of
the box), as well as a host of other formats. But convincing docbook to
create a collection of "refentry" (their term for manpage) articles is
harder than you'd think. I tried a few things when this thread started
and couldn't get anything simple to work (xml has managed to make the
simple act of "include this document in this other document" insanely
complex). But I only spent a few minutes on it.

> > be converted to pdf, epub, or whatever. I would not be surprised if
> > somebody has solved this problem before (but it is not really my itch,
> > so I did not look very far).
> 
> I'd rather ditch docbook and have one toolchain (asciidoc, unless we
> want to switch to something else) only... We've been hunting asciidoc as
> well as docbook compatibility (between versions) and interoperability
> (between them) issues again and again.

Yeah, I really hate our doc toolchain. It just seems like everything
else is even worse. We can ditch docbook, but then how do we make
manpages?

-Peff
