From: Jeff King <peff@peff.net>
Subject: Re: Tilde spec - befuzzled
Date: Wed, 29 Feb 2012 02:34:08 -0500
Message-ID: <20120229073408.GA14181@sigill.intra.peff.net>
References: <4F4C995D.9000504@diamand.org>
 <4F4CA354.2070503@op5.se>
 <87zkc38a3v.fsf@thomas.inf.ethz.ch>
 <7vaa42zrw8.fsf@alter.siamese.dyndns.org>
 <CAH5451m=6XhRj1osN_Dw7zKvAW-jtru+EbCkRvo8aNRMbJS6bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, Andreas Ericsson <ae@op5.se>,
	Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 08:34:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2e3F-0007FY-FA
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 08:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab2B2HeM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 02:34:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60959
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369Ab2B2HeL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 02:34:11 -0500
Received: (qmail 19869 invoked by uid 107); 29 Feb 2012 07:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Feb 2012 02:34:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Feb 2012 02:34:08 -0500
Content-Disposition: inline
In-Reply-To: <CAH5451m=6XhRj1osN_Dw7zKvAW-jtru+EbCkRvo8aNRMbJS6bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191813>

On Wed, Feb 29, 2012 at 12:18:07PM +1100, Andrew Ardill wrote:

> >>>> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> >>>> A suffix '{tilde}<n>' to a revision parameter means the commit
> >>>> object that is the <n>th generation grand-parent of the named
> >>>> commit object, following only the first parents.
> >>>>
> >>>> Hang on, *grand*-parents?
> >>>> ...
> >>
> >> Perhaps we should reword it as "n-th first-parent ancestor"? =C2=A0=
Barring
> >> confusion about the position of the dashes, that leaves little roo=
m for
> >> error.
> >
> > I think we could either go "easier to read but not precise"
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0... that is the <n>th generation (grand-=
)parent of ...
> >
> > or "may sound scary but correct"
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0the ancestor reached by walking the firs=
t-parent chain <n> times
> >
> > I am not sure which bucket "n-th first-parent ancestor" falls into.
>=20
> The terms might be too technical, however my understanding was that
> HEAD^n takes <n> steps along a breadth-first traversal of the commit
> tree rooted at HEAD, while HEAD~n uses a depth-first traversal.

The term breadth-first has me confused, as it implies that we will
traverse the breadth of the tree before descending to the next level of
depth. As if foo^3 would mean "well, foo only has two parents, so go on
to the next level of the tree". It is really a breadth-only traversal,
and the tilde is a depth-only traversal.

Anyway, it seems to me the OP's confusion can be cleared up with
s/grand-parent/ancestor/. Of course, while we are here, it might be
worth expanding or improving the text if there are other confusing
aspects (which I'm not sure there are).

-Peff
