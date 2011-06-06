From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 6 Jun 2011 12:11:43 -0400
Message-ID: <20110606161143.GC11485@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
 <7vei37bxbp.fsf@alter.siamese.dyndns.org>
 <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:12:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTcPa-00081n-49
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 18:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab1FFQMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 12:12:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37927
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174Ab1FFQLw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 12:11:52 -0400
Received: (qmail 7116 invoked by uid 107); 6 Jun 2011 16:11:58 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jun 2011 12:11:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2011 12:11:43 -0400
Content-Disposition: inline
In-Reply-To: <7vaadvbwpw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175132>

On Sun, Jun 05, 2011 at 06:00:11PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> I did some more digging. I don't think the problem is with HEAD at all,
> >> but rather with asking for more than one ref at all.
> >> ...
> >> Does that make sense? If so, then I think the right fix is for testgit
> >> ti ignore all imports after the first one (since the first one will have
> >> done all available refs). And the patch is:
> >
> > After reading Sverre's answer, I think this makes sense as a short-term
> > workaround.  Shall we squah it in to 3/3?
> 
> I'll queue it separately as a tentative commit (below) and leave it in
> 'pu' for now. Please give it a better description so that we can move the
> fix forward.

I'll try the nicer fix Sverre mentioned and post a real patch. I wanted
to add a test for multiple refs to the test suite, but I got bogged down
by other breakages. Some of which I think are the fault of testgit, but
one of which I think may be a problem in the transport-helper code.

I gave up in frustration after many hours of dealing with it on Friday,
but I'll give it another go today. :)

-Peff
