From: Jeff King <peff@peff.net>
Subject: Re: git push output goes into stderr
Date: Thu, 8 Sep 2011 03:07:06 -0400
Message-ID: <20110908070706.GA1454@sigill.intra.peff.net>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
 <7v8vq3ztym.fsf@alter.siamese.dyndns.org>
 <20110906074916.GC28490@ecki>
 <20110907215716.GJ13364@sigill.intra.peff.net>
 <CAMK1S_gro=THLkc_wrHSLwUVaJp9k-zRDuFDQpOGaiyBTHiDnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>,
	Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 08 09:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Yhs-0001Ls-A0
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075Ab1IHHHN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Sep 2011 03:07:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37583
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755856Ab1IHHHM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 03:07:12 -0400
Received: (qmail 10473 invoked by uid 107); 8 Sep 2011 07:07:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Sep 2011 03:07:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2011 03:07:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMK1S_gro=THLkc_wrHSLwUVaJp9k-zRDuFDQpOGaiyBTHiDnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180944>

On Thu, Sep 08, 2011 at 11:12:48AM +0530, Sitaram Chamarty wrote:

> > But with a program whose main function is to perform an action, lik=
e
> > "git push", I think there are really two ways to look at it:
> >
> > =C2=A01. There is no main output; any progress or status update is =
just
> > =C2=A0 =C2=A0 diagnostic chat, and should go to stderr.
> >
> > =C2=A02. The main output is the status report; it goes to stdout, a=
nd
> > =C2=A0 =C2=A0 progress updates go to stderr.
>=20
> I always thought if you write stuff to stdout the remote client gets
> confused because it is executing to a defined protocol and suddenly
> sees unexpected input in the middle.
>=20
> Bit if *you* are saying this (output random stuff to STDOUT) can
> happen if we want it to, clearly I was wrong...

=46or the remote side, yes, we have to be sure not to pollute stdout,
because that's where the protocol is going.. But the status table is
generated on the client side, so stdout is just connected to the user's
terminal there.

We already generate --porcelain status output from push on stdout (and
again, that makes sense to me philosophically, because the user is
asking push to generate the output). So it's clearly not a big deal.
It's just a matter of taste.

-Peff
