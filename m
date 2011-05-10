From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Tue, 10 May 2011 16:20:03 -0400
Message-ID: <20110510202003.GF14456@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <7viptjq0ua.fsf@alter.siamese.dyndns.org>
 <20110509220459.GA3719@sigill.intra.peff.net>
 <BANLkTimUn9e=5CfDcvQdgNYY4_pqbi8peQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Lee <davidomundo@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtPi-0003Pc-O5
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab1EJUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:20:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54745
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab1EJUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:20:07 -0400
Received: (qmail 25780 invoked by uid 107); 10 May 2011 20:22:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 16:22:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 16:20:03 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimUn9e=5CfDcvQdgNYY4_pqbi8peQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173358>

On Tue, May 10, 2011 at 08:47:53AM -0400, Jay Soffian wrote:

> On Mon, May 9, 2011 at 6:04 PM, Jeff King <peff@peff.net> wrote:
> > I think it is important to note that calling them both "origin" is
> > definitely the wrong thing. The proposal is instead that "git push"
> > without a remote would default to something besides "origin". For people
> > who publish multiple places, it might even make sense for it to be an
> > iterative push to each place.
> 
> While developing in a particular repo, I constantly have to push to
> two compile machines. I just dropped a Makefile into the top of my
> working tree:
> 
> all: push
> amend:
> 	git amend -a
> 	git --no-pager diff @{1}
> 	make push
> push:
> 	make -j 2 mac win
> mac:
> 	git push mac
> win:
> 	git push win

Yeah, I have scripts to help with that sort of thing now. But that is
often an unsatisfactory solution, because either:

  1. Your Makefile is not version-controlled.

  2. Your are polluting the project history with stuff specific to your
     workflow. I would not get very far proposing that git.git's
     Makefile contain such a thing. :)

That's how Junio ended up with his "Meta" directory (and I have one,
too, but with drastically different things in it).

-Peff
