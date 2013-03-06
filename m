From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 22:31:29 +0100
Message-ID: <20130306213129.GE15375@pengutronix.de>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	git <git@vger.kernel.org>, kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:32:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLwW-00061w-Av
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab3CFVbl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 16:31:41 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39495 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab3CFVbk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:31:40 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDLvx-0001Tt-4f; Wed, 06 Mar 2013 22:31:33 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1UDLvu-00029w-19; Wed, 06 Mar 2013 22:31:30 +0100
Content-Disposition: inline
In-Reply-To: <7vr4jsp756.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217549>

Hello Junio,

On Wed, Mar 06, 2013 at 01:09:41PM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > But it would apply to the content that is outside
> > of the hunk marker; we have changed the concept of what is in the b=
ase
> > and what is in the conflict by shrinking the conflict to its smalle=
st
> > size.
>=20
> Hmm, unless you mean by "base" something entirely different from
> "what was in the common ancestor version", I do not think I can
> agree.  The point of diff3 mode is to show how it looked line in the
> common ancestor and what the conflicting sides want to change that
> common version into; letting the user view three versions to help
> him decide what to do by only looking at the part inside conflict
> markers.
>=20
> We show "both sides added, either identically or differently" as
> noteworthy events, but the patched code pushes "both sides added
> identically" case outside the conflicting hunk, as if what was added
I didn't test, but "both sides removed identically" should be moved out=
,
too, shouldn't it?

> relative to the common ancestor version (in Uwe's case, is it 1-14
> that is common, or just 10-14?) is not worth looking at when
> considering what the right resolution is.  If it is not worth
> looking at what was in the original for the conflicting part, why
> would we be even using diff3 mode in the first place?
because even zdiff3 contains more information than merge. And compared
to diff3 it's smaller sometimes and so easier to understand.

Other than that I agree fully to the things Jeff said so far.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
