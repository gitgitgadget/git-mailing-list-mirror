From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 04 Aug 2011 00:29:22 +0200
Message-ID: <1312410562.3261.1030.camel@Naugrim.eriador.com>
References: <4E0A08AE.8090407@web.de>
	 <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
	 <7vaabqb7vf.fsf@alter.siamese.dyndns.org>  <4E39BDFF.3050804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 04 00:26:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojtN-0003Ta-Kw
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755684Ab1HCW0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 18:26:16 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:40580 "EHLO
	mailgw21.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755614Ab1HCW0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 18:26:15 -0400
Received: by mailgw21.surf-town.net (Postfix, from userid 65534)
	id 1A5CD4231; Thu,  4 Aug 2011 00:26:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw21.surf-town.net (Postfix) with ESMTP id C30AC4101;
	Thu,  4 Aug 2011 00:26:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw21.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw21.surf-town.net ([127.0.0.1])
	by localhost (mailgw21.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 41qBvUB3kqWU; Thu,  4 Aug 2011 00:26:08 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw21.surf-town.net (Postfix) with ESMTPSA id 986B24150;
	Thu,  4 Aug 2011 00:26:02 +0200 (CEST)
In-Reply-To: <4E39BDFF.3050804@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178639>

Le mercredi 03 ao=C3=BBt 2011 =C3=A0 23:30 +0200, Jens Lehmann a =C3=A9=
crit :
> Am 03.08.2011 21:41, schrieb Junio C Hamano:
> > Jens Lehmann <Jens.Lehmann@web.de> writes:
> >=20
> >> 1) To use me, you need another submodule "foo"
> >>
> >>    This is very helpful when you want to add the Gimp submodule an=
d it
> >>    can tell you you'll need the libpng submodule too in your super=
project
> >>    (but I'd vote to use the submodule name here, not the path as t=
hat
> >>    should be the superproject's decision).
> >=20
> > That is something you can add to .gitmodules in the superproject, n=
o?
> > E.g.
> >=20
> > 	[submodule "Gimp"]
> >         	url =3D http://some/where/
> > 		path =3D gimp/
> >         	depends =3D version 1.2.3 of "Glib"
> >=20
> > 	[submodule "Glib"]
> >         	url =3D http://some/where/else/
> > 		path =3D libs/glib
>=20
> The "depends" information is not very useful inside the superproject,
> because when you already know that there you can simply commit versio=
n
> 1.2.3 of Glib together with Gimp instead of adding that information.
> That's what gitlinks are for, no?
>=20
> But when you fetch a new version of Gimp into your submodule, it woul=
d be
> really nice if the superproject could be notified that the Gimp devel=
opers
> updated to 1.2.4 of Glib and inform you that an update of Glib might =
be
> appropriate. That could avoid having you to dig through compiler erro=
rs to
> find out that the new foobar() function from Glib 1.2.4 is needed (an=
d if
> you need to pull in a bugfix in Glib, you might notice that *a lot* l=
ater
> when you forget to do that).
>=20

Exact, I am really happy to read this.
And better do not bother to have the suproject.
cd to gimp directory, type git status it can tell you every thing and
when your satisfied you just have to type make.
At this point the superproject have not any use.=20

> >> In addition to that, it can (but mustn't) specify any of the follo=
wing:
> >=20
> > I am guessing you meant "does not have to", instead of mustn't, her=
e...
>=20
> Sure, thanks for deciphering that.
>=20
> >> a) Of this submodule "foo" I need at least that version because I =
won't
> >>    compile/work with older versions of that. (this can be tightene=
d to
> >>    "exactly that version" to give henri the behavior he wants, but=
 that
> >>    should be policy, not mandatory)
> >=20
> > The "loose collection of projects" approach like that has its uses,=
 and it
> > is called "repo". Why re-invent it? The behaviour Henri wants to sp=
ecify
> > the exact version is how git submodules work already, so I do not s=
ee
> > there is anything to be done here.
>=20
> Let me make this clear: this is not about changing how submodules are
> committed in a superproject. It is not about having a loose collectio=
n of
> projects, they stay tied together in a defined state by the superproj=
ect.
>=20

Yes but for me, from when I started this this topic, it was all about
having a loose collection of project with dependency references between
them. And get rid of the superproject.
It is my first and only goal.

> Henri wanted it a bit upside down: any submodule could request a cert=
ain
> version of another submodule somewhere else in the repo. And he wante=
d to
> use gitlinks from one submodule to another for that, which I - hopefu=
lly -
> convinced him was no good idea.
>=20

You just convince me that submodules are more than I need and to make a
lighter independent version of submodules which will never been followe=
d
by git commands.

> But I understand his need to have some kind of "version hint" from on=
e
> submodule to another. Just that he wants to take the hint very seriou=
s,
> while I see it as means to communicate from the submodule maintainer =
to
> the superproject developers that another submodule might have to be
> updated too when they do that to his.
>=20

Yes

> >> b) And if you don't know where to get it, use this url
> >=20
> > Again that is the job of .gitmodules in the superproject.
>=20
> Yes. But this idea is about how the url could get into the .gitmodule=
s of
> the superproject in the first place. That can make it easier for the
> superproject's developer to import a submodule into his repo and much=
 more
> important: it makes it possible to pull in submodule dependencies
> automatically e.g. when running "git submodule add --resolve-dependen=
cies
> Gimp".

Only if you have a superproject.
If not do the same thing from the gimp repository, now it contain all
necessary infos to do the job.

> >> That is all stuff the submodule knows better than the superproject=
=2E
> >=20
> > Not necessarily. The version A0 of submodule A may depend on submod=
ule B
> > and may also know it must have at least version B0 of that submodul=
e, but
> > the superproject would know other constraints, e.g. the superprojec=
t
> > itself also calls into submodule B and wants a newer version B1 of =
it.
>=20
> Right. That's what I tried to explain to Henri, the superproject ties=
 it all
> together. But I also like his idea to add a way to communicate inform=
ation
> from the submodule to the superproject, and give the superproject a c=
hoice
> if it wants to use it.
>=20

yes but the superproject contain no code in your design.
Then it will never need anything by itself.
It is only a container which you will inform with data already known by
the submodules I do not see any value to it.

	Henri
