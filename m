From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] gitweb: allow extra breadcrumbs to prefix the trail
Date: Thu, 4 Jul 2013 18:08:51 +0100
Message-ID: <alpine.LSU.2.00.1307041752030.26246@hermes-2.csi.cam.ac.uk>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk> <20130703215930.GT408@google.com> <CANQwDwcneUzzXS-Du-3Aca3-Vp8ycSzVqUv1rVRVhaNUWfeokw@mail.gmail.com> <alpine.LSU.2.00.1307040940400.26246@hermes-2.csi.cam.ac.uk> <CANQwDwd9siyeu5xqS5Un+=8ioEaDbpT30vBpgJCVNUEcszcv1g@mail.gmail.com>
 <alpine.LSU.2.00.1307041559140.26246@hermes-2.csi.cam.ac.uk> <CANQwDwfCYPBjGfmKOLju-Zey4WrVrXfaymJtu9g1OYvOUfBTcw@mail.gmail.com> <alpine.LSU.2.00.1307041646250.26246@hermes-2.csi.cam.ac.uk>
 <CANQwDwfNrqZvLNYS6kqZdgX-ab5fK3RmQqAN3qKTW2TGnaDaUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-958422304-1372957731=:26246"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 19:09:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uun1r-0005xt-7b
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 19:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756729Ab3GDRIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 13:08:53 -0400
Received: from ppsw-mx-f.csi.cam.ac.uk ([131.111.8.149]:40031 "EHLO
	ppsw-42.csi.cam.ac.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756646Ab3GDRIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 13:08:52 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:38425)
	by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpa (EXTERNAL:fanf2) id 1Uun1X-0003Bz-8c (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 18:08:51 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1Uun1X-0003M0-KE (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jul 2013 18:08:51 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <CANQwDwfNrqZvLNYS6kqZdgX-ab5fK3RmQqAN3qKTW2TGnaDaUg@mail.gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229596>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-958422304-1372957731=:26246
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
>
> In what situation do you need those extra breadcrumbs useful? What
> necessity / itch to scratch is behind idea of this patch?

For an example, see https://git.csx.cam.ac.uk/x/ucs/git/git.git

I have three items in @extra_breadcrumbs which point to the University
home page, my department home page, and my git server's home page; there
are a number of gitolite accounts on the server each of which has a
project listing which is where gitweb's home link points.

(I expect to change the link texts to make it less confusing when you
happen to be looking at my department's account on the git server...)

our @extra_breadcrumbs =3D (
  [ cam =3D> 'http://www.cam.ac.uk/'      ],
  [ ucs =3D> 'http://www.ucs.cam.ac.uk/'  ],
  [ git =3D> 'https://git.csx.cam.ac.uk/' ],
);

This is in line with our house style (none of which I have implemented on
this server yet) - there are other examples of similar breadcrumb trails
at https://raven.cam.ac.uk and http://new-webmail.hermes.cam.ac.uk

There is a more generic version of this description and config example in
v2 of my patch. I hope it is clear enough. I'll send a v3 patch with the
code tweak.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Forties, Cromarty: East, veering southeast, 4 or 5, occasionally 6 at first=
=2E
Rough, becoming slight or moderate. Showers, rain at first. Moderate or goo=
d,
occasionally poor at first.
--1870870024-958422304-1372957731=:26246--
