From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 17:17:54 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483678383@xmail3.se.axis.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
	<AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
	<AANLkTikDcZRHpKp9phlThK5x-8A0OfTYIlhGkqookiFj@mail.gmail.com>
	<AANLkTil-nMo5E2laacYm48-HGbhseEICWsUHwTlc3l47@mail.gmail.com>
	<AANLkTimo2P3JIJ2zhD3QtT2wgfr4WmXPkVVxUDpiOfJH@mail.gmail.com>
	<AANLkTilsqlqX0f8_LhXBssCGMuTdS_mCw7V3lVrMb4XK@mail.gmail.com>
 <AANLkTin8MTa5zUhqh3dOfNN0nmI2kAeiqNreYn7TZnf1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"mduft@gentoo.org" <mduft@gentoo.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: "kusmabite@gmail.com" <kusmabite@gmail.com>,
	Marko Kreen <markokr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 17:18:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeql-0005pO-RV
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0E0PST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 11:18:19 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:57567 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0E0PSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 11:18:18 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o4RFHuxb028814;
	Thu, 27 May 2010 17:17:56 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 27 May 2010 17:17:55 +0200
Thread-Topic: [PATCH] compat: Add another rudimentary poll() emulation
Thread-Index: Acr9qxwSo2kNoblVSm6Kkpt4gpEwRAAA+XAw
In-Reply-To: <AANLkTin8MTa5zUhqh3dOfNN0nmI2kAeiqNreYn7TZnf1@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147873>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Erik Faye-Lund
> Sent: den 27 maj 2010 16:44
> To: Marko Kreen
> Cc: Jonathan Nieder; Jonathan Callen; git@vger.kernel.org;
> mduft@gentoo.org; Sverre Rabbelier; Michael J Gruber; Johannes Sixt;
> msysGit
> Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
>=20
> On Thu, May 27, 2010 at 4:32 PM, Marko Kreen <markokr@gmail.com> wrot=
e:

[cut]

> > Ah, ok. =A0I though this is the nfds for select(). =A0In this case =
it can
> > still fail, as nfds=3D1 for poll() can still go over FD_SETSIZE for
> > select() if the fd value is big enough. =A0On non-windows, that is.
>=20
> I don't quite get where one would get a fd that's value is FD_SETSIZE
> or above from. I mean, FD_SETSIZE would have to be the maximum value
> of a file descriptor, or else you risk open() or socket() returning
> file descriptors that cannot be select()'ed. Which would just be
> insane, no?
>=20
> --
> Erik "kusma" Faye-Lund

That is exactly how e.g. Linux works. If your application can have more=
=20
than 1024 file descriptors open simultaneously, you are restricted to=20
use poll() as you risk having a file descriptor with a value >=3D 1024.
And using FD_SET() with a file descriptor >=3D 1024 will trash memory..=
=2E

//Peter
