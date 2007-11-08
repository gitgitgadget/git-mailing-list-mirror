From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH amend] git-mailsplit: with maildirs not only process
	cur/, but also new/
Date: Thu, 8 Nov 2007 08:31:01 +0100
Message-ID: <20071108073101.GA4875@ferdyx.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <20071106085418.14211.qmail@54d7c9212e25c5.315fe32.mid.smarden.org> <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 08:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq1rI-0006TM-5v
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbXKHHbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 02:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbXKHHbH
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:31:07 -0500
Received: from 170.Red-213-96-222.staticIP.rima-tde.net ([213.96.222.170]:55230
	"EHLO smtp.ferdyx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbXKHHbG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:31:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp.ferdyx.org (Postfix) with ESMTP id 7CF518D307;
	Thu,  8 Nov 2007 08:32:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ferdyx.org
Received: from smtp.ferdyx.org ([127.0.0.1])
	by localhost (tungsteno.ferdyx.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gy+fsoSXlbjy; Thu,  8 Nov 2007 08:32:33 +0100 (CET)
Received: from posidon.ferdyx.org (posidon.ferdyx.org [192.168.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ferdyx.org (Postfix) with ESMTP id E08818D305;
	Thu,  8 Nov 2007 08:32:32 +0100 (CET)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	ferdy@gentoo.org; Thu,  8 Nov 2007 08:31:01 +0100 (CET)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junio@pobox.com>, Alex Riesen <raa.lkml@gmail.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <7vfxzh7ajt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63944>

On Wed, Nov 07, 2007 at 06:09:26PM -0800, Junio C Hamano wrote:
> Gerrit Pape <pape@smarden.org> writes:
>=20
> > When saving patches to a maildir with e.g. mutt, the files are put =
into
> > the new/ subdirectory of the maildir, not cur/.  This makes git-am =
state
> > "Nothing to do.".  This patch lets git-mailsplit additional check n=
ew/
> > after reading cur/.
> >
> > This was reported by Joey Hess through
> >  http://bugs.debian.org/447396
> >
> > Signed-off-by: Gerrit Pape <pape@smarden.org>
> > ---
> >
> > On Mon, Nov 05, 2007 at 01:58:50PM +0100, Jakub Narebski wrote:
> >> > +        for (i =3D 0; i < 2; ++i) {
> >> Wouldn't it be better to use sizeof(sub)/sizeof(sub[0]) or it's ma=
cro
> >> equivalent ARRAY_SIZE(sub) instead of hardcoding 2 to avoid errors=
?
> > I made the array NULL-terminated.
> >
> > On Mon, Nov 05, 2007 at 04:26:24PM -0500, Jeff King wrote:
> >> Isn't the subject line now wrong?
> > Yes, thanks.
> >
> > On Mon, Nov 05, 2007 at 11:52:58PM +0100, Alex Riesen wrote:
> >> Why is missing "cur" (or "new", for that matter) a fatal error?
> >> Why is it error at all? How about just ignoring the fact?
> > As suggested by Jeff, I made it ignore the error on ENOENT.
>=20
> Looks good to me.  Final acks please?

=46ixed my concern too.

Acked-by: Fernando J. Pereda <ferdy@gentoo.org>

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
