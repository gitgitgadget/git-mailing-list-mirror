From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] completion: support 'git config --local'
Date: Tue, 12 Feb 2013 19:05:19 -0500
Message-ID: <20130213000519.GA31758@sigill.intra.peff.net>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
 <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
 <20130212211140.GA29358@sigill.intra.peff.net>
 <7v1uclfafi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Dasa Paddock <dpaddock@esri.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:05:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Pr8-00073g-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 01:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab3BMAFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 19:05:22 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45632 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab3BMAFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 19:05:21 -0500
Received: (qmail 7317 invoked by uid 107); 13 Feb 2013 00:06:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Feb 2013 19:06:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2013 19:05:19 -0500
Content-Disposition: inline
In-Reply-To: <7v1uclfafi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216227>

On Tue, Feb 12, 2013 at 02:13:05PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure I understand the original poster's point about "git config
> > -l --local". "-l" does not take a limiter, does it?
> 
> "git config -l core.\*" will just die without limiting the output to
> everything under core. hierarchy, so you are right---the combination
> does not make any sense.  You have to say
> 
>     git config -l | grep ^core\\.
> 
> or something like that.
> 
> Completing "git config -l --lo<TAB>" still may help, though.

Ah, I think I see Dasa's original point now. He was interested in fixing
"--lo<TAB>" to complete "--local". But the line he pointed to in his
original message is not the right place for that; it is the site of an
unrelated spot which should _also_ be fixed to use "--local", but for a
different reason (restricting the variables suggested for "--local --get
<TAB>" properly).

So yeah. Matthieu's patch is the right thing to do, as it covers both
(mine fixed only half of it).

-Peff
