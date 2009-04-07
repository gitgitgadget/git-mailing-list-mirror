From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 10:10:19 +0200
Message-ID: <20090407081019.GK20356@atjola.homenet>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic> <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm> <fabb9a1e0904051436i1dc9c1bdhe86a23e470c756f9@mail.gmail.com> <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:12:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6Pj-0002bA-Pf
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZDGIKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 04:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZDGIK2
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:10:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:33679 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751901AbZDGIK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:10:27 -0400
Received: (qmail invoked by alias); 07 Apr 2009 08:10:23 -0000
Received: from i59F5A3DA.versanet.de (EHLO atjola.local) [89.245.163.218]
  by mail.gmx.net (mp001) with SMTP; 07 Apr 2009 10:10:23 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+/4rwEWgy/UsRjaQdy3FWOfEEjLmZqySowEzuJ2e
	bIswazqjb4LnmZ
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904052315210.6741@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115929>

On 2009.04.05 23:24:27 -0400, Nicolas Pitre wrote:
> On Sun, 5 Apr 2009, Sverre Rabbelier wrote:
>=20
> > Heya,
> >=20
> > On Sun, Apr 5, 2009 at 23:28,  <david@lang.hm> wrote:
> > > Guys, back off a little on telling the gentoo people to change.
> >=20
> > I agree here, we should either say "look, we don't really support b=
ig
> > repositories because [explanation here], unless you [workarounds
> > here]" OR we should work to improve the support we do have. Of cour=
se,
> > the latter option does not magically create developer time to work =
on
> > that, but if we do go that way we should at least tell people that =
we
> > are aware of the problems and that it's on the global TODO list (no=
t
> > necessarily on anyone's personal TODO list though).
>=20
> For the record... I at least am aware of the problem and it is indeed=
 on=20
> my personal git todo list.  Not that I have a clear solution yet (I'v=
e=20
> been pondering on some git packing issues for almost 4 years now).
>=20
> Still, in this particular case, the problem appears to be unclear to =
me,=20
> like "this shouldn't be so bad".

It's not primarily pack-objects, I think. It's the rev-list that's run
by upload-pack.  Running "git rev-list --objects --all" on that repo
eats about 2G RSS, easily killing the system's cache on a small box,
leading to swapping and a painful time reading the packfile contents
afterwards to send them to the client.

Bj=F6rn
