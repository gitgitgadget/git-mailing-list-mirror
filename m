From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Wed, 19 Sep 2012 16:37:38 -0400
Message-ID: <20120919203738.GA24383@sigill.intra.peff.net>
References: <20120906151317.GB7407@sigill.intra.peff.net>
 <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
 <7v627aiq47.fsf@alter.siamese.dyndns.org>
 <20120919182715.GF11699@sigill.intra.peff.net>
 <7vzk4lg5yf.fsf@alter.siamese.dyndns.org>
 <20120919194213.GB21950@sigill.intra.peff.net>
 <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Drew Northup <n1xim.email@gmail.com>,
	gitList <git@vger.kernel.org>, Matthieu.Moy@imag.fr,
	andy@aeruder.net, chriscool@tuxfamily.org,
	dmellor@whistlingcat.com, dpmcgee@gmail.com, fonseca@diku.dk,
	freku045@student.liu.se, marius@trolltech.com, namhyung@gmail.com,
	rene.scharfe@lsrfire.ath.cx, s-beyer@gmx.net, trast@inf.ethz.ch
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TER1r-00060V-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab2ISUhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:37:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab2ISUhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:37:40 -0400
Received: (qmail 5925 invoked by uid 107); 19 Sep 2012 20:38:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 16:38:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 16:37:38 -0400
Content-Disposition: inline
In-Reply-To: <C07F05AC-8FBF-4F09-AF13-A291181A06D9@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205997>

On Wed, Sep 19, 2012 at 01:31:50PM -0700, Kevin Ballard wrote:

> > I am a little lukewarm on my patch if only because of the precedent it
> > sets.  There are a trillion options that revision.c parses that are not
> > necessarily meaningful or implemented for sub-commands that piggy-back
> > on its option parser. I'm not sure we want to get into manually
> > detecting and disallowing each one in every caller.
> 
> I tend to agree with your final sentiment there. But the point that
> users may not realize that blame already follows is also valid. Perhaps
> we should catch --follow, as in your patch, but instead of saying that
> it's an unknown argument, just print out a helpful message saying blame
> already follows renames (and then continue with the blame anyway, so
> as to not set a precedent to abort on unknown-but-currently-accepted
> flags).

Sure, that would probably make sense. Care to roll a patch with
suggested wording?

-Peff
