From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] require pathspec for "git add -u/-A"
Date: Tue, 12 Mar 2013 07:28:40 -0400
Message-ID: <20130312112840.GA13186@sigill.intra.peff.net>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
 <1362786889-28688-2-git-send-email-gitster@pobox.com>
 <vpqmwubgsqy.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 12 12:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFNOK-0005oK-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 12:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587Ab3CLL2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 07:28:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49592 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab3CLL2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 07:28:43 -0400
Received: (qmail 26106 invoked by uid 107); 12 Mar 2013 11:30:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Mar 2013 07:30:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2013 07:28:40 -0400
Content-Disposition: inline
In-Reply-To: <vpqmwubgsqy.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217948>

On Sun, Mar 10, 2013 at 04:49:09PM +0100, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As promised in 0fa2eb530fb7 (add: warn when -u or -A is used without
> > pathspec, 2013-01-28), "git add -u/-A" that is run without pathspec
> > in a subdirectory will stop working sometime before Git 2.0, to wean
> > users off of the old default, in preparation for adopting the new
> > default in Git 2.0.
> 
> I originally thought this step was necessary, but I changed my mind. The
> warning is big enough and doesn't need to be turned into an error.
> 
> If this step is applied, it should be applied at 2.0, not before, as
> this is the big incompatible change. Re-introducing a new behavior won't
> harm users OTOH.

FWIW, I agree with this. The warning is enough without an error period
(unless the intent was to switch to the error and stay there forever,
but I do not think that is the proposal).

-Peff

PS I wonder how others are finding the warning? I'm finding it slightly
   annoying. Perhaps I just haven't retrained my fingers yet. But one
   problem with that retraining is that I type "git add -u" from the
   root _most_ of the time, and it just works. But occasionally, I get
   the "hey, do not do that" warning, because I'm in a subdir, even
   though I would be happy to have the full-tree behavior. I guess we
   already rejected the idea of being able to shut off the warning and
   just get the new behavior, in favor of having people specify it
   manually each time?
