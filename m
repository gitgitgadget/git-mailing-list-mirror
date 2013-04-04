From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 4 Apr 2013 13:51:50 -0400
Message-ID: <20130404175150.GA15630@sigill.intra.peff.net>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
 <20130404160359.GA25232@ruderich.org>
 <7vvc82i40a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:52:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNoKq-0007wP-8U
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764184Ab3DDRv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:51:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56116 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764161Ab3DDRv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:51:57 -0400
Received: (qmail 3426 invoked by uid 107); 4 Apr 2013 17:53:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 13:53:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 13:51:50 -0400
Content-Disposition: inline
In-Reply-To: <7vvc82i40a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220042>

On Thu, Apr 04, 2013 at 10:45:25AM -0700, Junio C Hamano wrote:

> Simon Ruderich <simon@ruderich.org> writes:
> 
> > git log -S doesn't respect --no-textconv:
> >
> >     $ echo '*.txt diff=wrong' > .gitattributes
> >     $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
> >     error: cannot run xxx: No such file or directory
> >     fatal: unable to read files to diff
> >
> > Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> > Signed-off-by: Simon Ruderich <simon@ruderich.org>
> > ---
> 
> Sounds sensible.
> 
> With this change fill_one() no longer needs to update textconv, it
> can just take a pointer to one, not a pointer to a pointer to one,
> which is [2/2].
> 
> Peff, anything I missed?

I'm OK with this as-is, but I would also be happy to see the re-ordering
and extra cleanup I mentioned elsewhere.

But either way:

  Acked-by: Jeff King <peff@peff.net>

-Peff
