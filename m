From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 20:50:16 +0100
Message-ID: <20071031195016.GA24332@atjola.homenet>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <7vodefj2lk.fsf@gitster.siamese.dyndns.org> <20071031055303.GB3326@atjola.homenet> <20071031134358.GD15182@dpotapov.dyndns.org> <20071031140028.GA30207@diana.vm.bytemark.co.uk> <20071031143641.GF15182@dpotapov.dyndns.org> <20071031180557.GA12211@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJaL-0005I8-5l
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 20:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbXJaTuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXJaTuV
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 15:50:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:59469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754501AbXJaTuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 15:50:20 -0400
Received: (qmail invoked by alias); 31 Oct 2007 19:50:18 -0000
Received: from i577B953D.versanet.de (EHLO localhost) [87.123.149.61]
  by mail.gmx.net (mp021) with SMTP; 31 Oct 2007 20:50:18 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19jzPV+IaJjoOq1bFBahB9z1JeBMCVsZrtRy6tmGW
	An4N8YZUSIpqAb
Content-Disposition: inline
In-Reply-To: <20071031180557.GA12211@coredump.intra.peff.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62857>

On 2007.10.31 14:05:57 -0400, Jeff King wrote:
> On Wed, Oct 31, 2007 at 05:36:41PM +0300, Dmitry Potapov wrote:
>=20
> > Hmm... I looked at the mail again and I cannot see where 8859-1 is
> > specified. It seems that context encoding is not specified at all.
> > Of course, it is incorrect to use non ASCII characters in a mail
> > without specifying encoding. Apparently, because I use utf-8 in the
> > terminal, the Sign-off line displays correctly for me, so I did not
> > notice the problem. Sorry for the noise...
>=20
> It is our old friend vger adding the iso-8859-1 header, I think, sinc=
e
> no encoding was specified.
>=20
> I think the problem is that git-format-patch only decides whether to
> append a MIME header based on the commit message contents; it does no=
t
> take the Signed-Off-By into account. This may also be the cause of th=
e
> recent complaints from Matti Aarnio.

Yep, that's it. If the Signed-Off-By was added by commit -s, it works,
while format-patch -s causes the header to be missing, although the
Signed-Off-By is utf-8 encoded. Will try to remember that.

Thanks,
Bj=F6rn
