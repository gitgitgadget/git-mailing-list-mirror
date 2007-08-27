From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] name-rev: Fix non-shortest description
Date: Mon, 27 Aug 2007 21:27:35 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070827192735.GB20753@informatik.uni-freiburg.de>
References: <20070823103817.GF6573@informatik.uni-freiburg.de> <Pine.LNX.4.64.0708231557590.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 27 21:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPkFX-0007sW-8Q
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 21:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbXH0T1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Aug 2007 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbXH0T1n
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 15:27:43 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55221 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757334AbXH0T1n (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2007 15:27:43 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IPkFR-0006D2-Qo; Mon, 27 Aug 2007 21:27:41 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7RJRdsu021475;
	Mon, 27 Aug 2007 21:27:39 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7RJRZZ9021474;
	Mon, 27 Aug 2007 21:27:35 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708231557590.20400@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56871>

Johannes Schindelin wrote:
>=20
> Uwe Kleine-K=F6nig noticed that under certain circumstances, name-rev
> picked a non-optimal tag.  Jeff King analyzed that name-rev only
> takes into account the number of merge traversals, and then the
> _last_ number in the description.
>=20
> As an easy way to fix it, use a weighting factor for merge traversals=
:
> A merge traversal is now made 65535 times more expensive than a
> first-parent traversal.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Just from looking at the patch it seems to do what the log says.  It
passes the test suite and fixed my use case.  So:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>

But if I'd really prefer to know the "oldest" tag that includes the
given rev, I don't want that weighting.  I will try to come up with a
patch that introduces a flag.

Best regards and thanks to Johannes
Uwe

--=20
Uwe Kleine-K=F6nig

primes where sieve (p:xs) =3D [ x | x<-xs, x `rem` p /=3D 0 ]; \
primes =3D map head (iterate sieve [2..])
