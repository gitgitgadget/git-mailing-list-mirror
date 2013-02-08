From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build
 the script
Date: Fri, 8 Feb 2013 12:43:50 -0500
Message-ID: <20130208174350.GA28266@sigill.intra.peff.net>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vhaln7wkg.fsf@alter.siamese.dyndns.org>
 <20130208042800.GB4157@sigill.intra.peff.net>
 <vpqzjzeaevm.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rzk-00059l-E2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946791Ab3BHRnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:43:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42404 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760131Ab3BHRnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:43:52 -0500
Received: (qmail 31320 invoked by uid 107); 8 Feb 2013 17:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 12:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 12:43:50 -0500
Content-Disposition: inline
In-Reply-To: <vpqzjzeaevm.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215790>

On Fri, Feb 08, 2013 at 06:34:37PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > That seems much cleaner to me. If done right, it could also let people
> > put:
> >
> >   CONTRIB_PERL += contrib/mw-to-git/git-remote-mediawiki
> 
> Actually, you can already do this:
> 
>   SCRIPT_PERL += contrib/mw-to-git/git-remote-mediawiki.perl
> 
> probably not by design, but it works!

So putting:

  ROOT=contrib/mw-to-git
  git-remote-mediawiki: FORCE
          @make -C ../.. SCRIPT_PERL=$(ROOT)/$@.perl $(ROOT)/$@

in contrib/mw-to-git/Makefile would already work? Neat.

-Peff
