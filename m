From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Mon, 7 Nov 2011 16:31:23 -0500
Message-ID: <20111107213123.GA10965@sigill.intra.peff.net>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 22:31:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNWmx-0000Da-3C
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 22:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab1KGVb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 16:31:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35934
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab1KGVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 16:31:25 -0500
Received: (qmail 30250 invoked by uid 107); 7 Nov 2011 21:31:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 16:31:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 16:31:23 -0500
Content-Disposition: inline
In-Reply-To: <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185029>

On Mon, Nov 07, 2011 at 01:25:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That makes sense. But I think it fits in with git's current UI to do
> > this via a combination of push options and refspecs. Even if we want to
> > wrap it in some "git remote" command for convenience, I think what
> > you're asking should be implemented as part of "git push".
> 
> Yeah, I think it makes sense to give --prune to "push" just like "fetch"
> already has. These two are the primary (and in the ideal world, only)
> operations that talk to the outside world. "remote add -f" might have been
> a tempting "convenience" feature, but I personally think it probably was a
> mistake for the exact reason that letting anything but "push" and "fetch"
> talk to the outside world just invites more confusion. There does not have
> to be 47 different ways to do the same thing.

I don't mind "add -f" too much, which is at least very clear that it is
simply a convenience feature for "git remote add foo && git fetch foo".
But the other "git remote" features like "set-head -a", which can't be
done any other way, or the "auto-check-what-the-remote-has" feature of
"git remote show" are a little gross.

Anyway, I think we are on the same page; this feature (and btw, I think
this is a great feature that we should have) should go into "push".

-Peff
