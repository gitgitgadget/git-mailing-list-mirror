From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 21:22:31 +0200
Message-ID: <20090411192231.GA21300@atjola.homenet>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet> <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111055480.4583@localhost.localdomain> <alpine.LFD.2.00.0904111119520.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsioF-0004cm-VZ
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470AbZDKTWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758740AbZDKTWh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:39350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757076AbZDKTWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:36 -0400
Received: (qmail invoked by alias); 11 Apr 2009 19:22:33 -0000
Received: from i59F56F7C.versanet.de (EHLO atjola.local) [89.245.111.124]
  by mail.gmx.net (mp016) with SMTP; 11 Apr 2009 21:22:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19kXNdN7ERkxPUDSKZP4XbDv9KI/7Z9XdmAQP2ywd
	PNHN9NKqshm2kJ
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111119520.4583@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116321>

On 2009.04.11 11:22:09 -0700, Linus Torvalds wrote:
>=20
>=20
> On Sat, 11 Apr 2009, Linus Torvalds wrote:
> > On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
> >=20
> > > And again, the new pack is slightly worse than the old one
> > >  (window=3D250, --depth=3D250).
> > > Old: 240238406
> > > New: 240280452
> > >=20
> > > But again, it's negligible.
> >=20
> > Well, it's sad that it's consistently a bit worse, even if we're ta=
lking=20
> > just small small fractions of a percent (looks like 0.02% bigger ;)=
=2E=20
>=20
> Oh, just wondering: that 0.02% is negligible, but did you use "-f" (o=
r=20
> --no-reuse-delta if you're testing with 'git pack-objects') to see th=
at=20
> it's actually re-computing the deltas?
>=20
> The 0.02% difference might be just because of differences in pack lay=
out.=20
> If you force all deltas to be recomputed, maybe the difference is muc=
h=20
> bigger?

Yep, that was "git repack -adf --window=3D250 --depth=3D250".

Bj=F6rn
