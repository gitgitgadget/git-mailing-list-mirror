From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/8] strbuf: add strbuf_addv
Date: Thu, 24 Feb 2011 10:07:36 -0500
Message-ID: <20110224150736.GA24346@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142711.GB15477@sigill.intra.peff.net>
 <AANLkTi=cBkH5=fmH-k=Sid_4Pwzoa9A4T9z8dcMAjirL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 16:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pscn8-00061R-O5
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 16:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1BXPHh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 10:07:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48854 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599Ab1BXPHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 10:07:37 -0500
Received: (qmail 23856 invoked by uid 111); 24 Feb 2011 15:07:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 15:07:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 10:07:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=cBkH5=fmH-k=Sid_4Pwzoa9A4T9z8dcMAjirL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167821>

On Thu, Feb 24, 2011 at 04:05:13PM +0100, Christian Couder wrote:

> > + =C2=A0 =C2=A0 =C2=A0 len =3D vsnprintf(sb->buf + sb->len, sb->all=
oc - sb->len, fmt, cp);
> > + =C2=A0 =C2=A0 =C2=A0 va_end(cp);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len < 0)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("your vsnpri=
ntf is broken");
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("BUG: your v=
snprintf is broken (returned -1)");
>=20
> Minor nit: why not:
>=20
>  +               die("BUG: your vsnprintf is broken (returned %d)", l=
en);

No reason. I'll switch to yours in my re-roll.

-Peff
