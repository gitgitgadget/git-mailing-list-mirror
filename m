From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 01/15] fast-export: avoid importing blob marks
Date: Sun, 11 Nov 2012 11:38:28 -0500
Message-ID: <20121111163827.GA11408@sigill.intra.peff.net>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
 <509FD425.5030702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaYa-0004z8-3n
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606Ab2KKQib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 11:38:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab2KKQia (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:38:30 -0500
Received: (qmail 574 invoked by uid 107); 11 Nov 2012 16:39:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:39:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:38:28 -0500
Content-Disposition: inline
In-Reply-To: <509FD425.5030702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209397>

On Sun, Nov 11, 2012 at 05:36:53PM +0100, Torsten B=C3=B6gershausen wro=
te:

> On 11.11.12 14:59, Felipe Contreras wrote:
> > test_expect_success 'test biridectionality' '
> > +	echo -n > marks-cur &&
> > +	echo -n > marks-new &&
> Unless I messed up the patch:
>=20
> Minor issue: still a typo "biridectionality"
> Major issue:  "echo -n" is still not portable.
>=20
> Could we simply use
>=20
> touch  marks-cur  &&
> touch marks-new

Yes, "echo -n" is definitely not portable.  Our preferred way of
creating an empty file is just ">file".

-Peff
