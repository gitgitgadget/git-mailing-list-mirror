From: Jeff King <peff@github.com>
Subject: Re: [PATCHv2 3/9] archive: refactor list of archive formats
Date: Thu, 23 Jun 2011 13:30:13 -0400
Message-ID: <20110623173013.GA7364@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
 <20110622012333.GC30604@sigill.intra.peff.net>
 <BANLkTim7O3pcJAy4U1d6QiS6cvv2-Og21A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 23 19:31:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZnkD-0007u7-89
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 19:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094Ab1FWRaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jun 2011 13:30:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34527
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932861Ab1FWRaT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 13:30:19 -0400
Received: (qmail 22247 invoked by uid 107); 23 Jun 2011 17:30:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jun 2011 13:30:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2011 13:30:13 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim7O3pcJAy4U1d6QiS6cvv2-Og21A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176284>

On Thu, Jun 23, 2011 at 02:05:35PM -0300, Thiago Farina wrote:

> > +static struct archiver tar_archiver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 "tar",
> > + =C2=A0 =C2=A0 =C2=A0 write_tar_archive,
> > + =C2=A0 =C2=A0 =C2=A0 0
> A named constant instead of 0, like you did with
> ARCHIVER_WANT_COMPRESSION_LEVELS, would be better? 0 here means the
> archiver does not want compression?

It's actually a bit-wise flag, so it is not "no compression", but "no
flags". So "0" is fairly idiomatic. Given that it's a static initialize=
r
that will default to 0, probably a more readable version would be:

  static struct archiver tar_archiver =3D {
          "tar",
          write_tar_archive
  };

-Peff
