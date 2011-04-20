From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] log: convert to parse-options
Date: Wed, 20 Apr 2011 16:51:20 +0200
Message-ID: <20110420145120.GC5236@bee.lab.cmartin.tk>
References: <7v7hawiww7.fsf@alter.siamese.dyndns.org>
 <20110419123325.GA10814@bee.lab.cmartin.tk>
 <20110420023817.GA14201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCYkb-0002jp-8h
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 16:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1DTOvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2011 10:51:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48047 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751020Ab1DTOvX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 10:51:23 -0400
Received: from bee.lab.cmartin.tk (z39c5.pia.fu-berlin.de [87.77.57.197])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A210546132;
	Wed, 20 Apr 2011 16:51:06 +0200 (CEST)
Received: (nullmailer pid 18644 invoked by uid 1000);
	Wed, 20 Apr 2011 14:51:20 -0000
Content-Disposition: inline
In-Reply-To: <20110420023817.GA14201@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171867>

On Tue, Apr 19, 2011 at 10:38:17PM -0400, Jeff King wrote:
> On Tue, Apr 19, 2011 at 02:33:31PM +0200, =3D?UTF-8?q?Carlos=3D20Mart=
=3DC3=3DADn=3D20Nieto?=3D wrote:
>=20
> > Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
>=20
> This is not about your patch at all, but rather that I notice in your
> "From" header that your name is doubly rfc2047-encoded. It looks like
> this:
>=20
>   From: =3D?us-ascii?B?PT9VVEYtOD9xP0Nhcmxvcz0yME1hcnQ9QzM9QURuPTIwTm=
lldG8/?=3D
>     =3D?us-ascii?Q?=3D3D?=3D <cmn@elego.de>
>=20
> which decodes to the literal string:
>=20
>   =3D?UTF-8?q?Carlos=3D20Mart=3DC3=3DADn=3D20Nieto?=3D
>=20
> which in turn decodes again to your proper name.
>=20

Ah, so that's what been going on.

> We made some changes to format-patch's quoting recently, and I want t=
o
> make sure this is not a regression. Can you describe your workflow fo=
r
> sending these patches? What I think probably happened is:
>=20
>   1. format-patch encoded your name because of the non-ascii characte=
rs
>=20
>   2. the result was fed literally into mutt via cut-and-paste or
>      otherwise pulled into the editor, rather than "mutt -f patch-fil=
e".
>=20
> Which is not a regression, but just an annoying behavior that has bee=
n
> there for a while[1]. But I wanted to double-check.

As I was only sending one patch, I did what the intertubes suggested
and used "mutt -H patch-file" which I guess that's the problem. I only
noticed this because someone mentioned it, after I sent another patch.

So no regression, and a --leave-utf8-alone option would be useful here.

Cheers,
   cmn
