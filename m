From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: cannot fetch arm git tree
Date: Fri, 21 Jan 2011 16:25:44 +0100
Message-ID: <20110121152544.GQ14956@pengutronix.de>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com>
 <20110116092315.GA27542@n2100.arm.linux.org.uk>
 <20110116110819.GG6917@pengutronix.de>
 <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com>
 <20110116134248.GD27542@n2100.arm.linux.org.uk>
 <4D398C43.1000306@vollmann.ch>
 <20110121134728.GO14956@pengutronix.de>
 <20110121135725.GR13235@n2100.arm.linux.org.uk>
 <4D3997FE.5030109@vollmann.ch>
 <20110121145025.GS13235@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Detlef Vollmann <dv@vollmann.ch>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Fri Jan 21 16:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgIsA-0002B3-MN
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 16:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496Ab1AUPZx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jan 2011 10:25:53 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45333 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab1AUPZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 10:25:52 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PgIrz-0008Dv-QK; Fri, 21 Jan 2011 16:25:47 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PgIrw-0002UB-UF; Fri, 21 Jan 2011 16:25:44 +0100
Content-Disposition: inline
In-Reply-To: <20110121145025.GS13235@n2100.arm.linux.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165376>

On Fri, Jan 21, 2011 at 02:50:26PM +0000, Russell King - ARM Linux wrot=
e:
> On Fri, Jan 21, 2011 at 03:28:14PM +0100, Detlef Vollmann wrote:
> > It seems to be an implementation of the git protocol using
> > HTTP as transport.
> > Some info on this is at <http://progit.org/2010/03/04/smart-http.ht=
ml>.
>=20
> Setting up Smart HTTP
>=20
> ...
>    To set it up, it=E2=96=A0s best to walk through the instructions o=
n the
>    `git-http-backend` documentation page. Basically, you have to inst=
all Git
>    v1.6.6 or higher on a server with an Apache 2.x webserver (it has =
to be
>    Apache, currently - other CGI servers don=E2=96=A0t work, last I c=
hecked). Then
>    you add something similar to this to your http.conf file:
>=20
>  SetEnv GIT_PROJECT_ROOT /var/www/git
>  SetEnv GIT_HTTP_EXPORT_ALL
>  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
>=20
> Great.  Deciding that it will be http://servername.example.com/git/ i=
s
> really damned annoying as that's traditionally where gitweb lives,
> which requires a different script alias.
>=20
> It seems that due to a lack of coordination between different git
> developers, people running webservers have a choice between providing
> gitweb or this http extension.
>=20
> I'm really not interested in working out how to bodge this into worki=
ng
> along side the existing gitweb setup by adding lots of rewrite rules,=
 so
> as gitweb got there first I think it has priority, that's what we hav=
e
> and we'll have to live without the smart http extensions.
IIRC it's designed to live along side the http:// clone url.
git-http-backend can still serve dumb http clients including a web
browser.
=20
But note that as git-http-backend less info it has to calculate much
more.  So the load it introduces should be comparable to running
git-daemon as should be the times to fetch from it.  So AFAIK the only
reason to run it is that more corporate users can access port 80.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
