From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 02 Aug 2011 14:58:34 +0200
Message-ID: <1312289914.3261.836.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com>
	 <20110801221203.GA31614@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 14:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoEVT-0001A5-RB
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 14:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab1HBMza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 08:55:30 -0400
Received: from mail8.surf-town.net ([212.97.132.48]:56733 "EHLO
	mailgw5.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754345Ab1HBMz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 08:55:28 -0400
Received: by mailgw5.surf-town.net (Postfix, from userid 65534)
	id 5F3FB2032C; Tue,  2 Aug 2011 14:55:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw5.surf-town.net (Postfix) with ESMTP id 49B891FEB4;
	Tue,  2 Aug 2011 14:55:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw5.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw5.surf-town.net ([127.0.0.1])
	by localhost (mailgw5.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X04RhgZxTvON; Tue,  2 Aug 2011 14:55:20 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-37-125.w92-141.abo.wanadoo.fr [92.141.172.125])
	by mailgw5.surf-town.net (Postfix) with ESMTPSA id A07C020298;
	Tue,  2 Aug 2011 14:55:14 +0200 (CEST)
In-Reply-To: <20110801221203.GA31614@book.hvoigt.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178465>

Le mardi 02 ao=C3=BBt 2011 =C3=A0 00:12 +0200, Heiko Voigt a =C3=A9crit=
 :
> Hi,
>=20
> On Fri, Jul 29, 2011 at 11:39:37AM +0200, henri GEIST wrote:
> > Let say a concret exemple
> >=20
> > 3 different teams work on libtiff, libpng, and libjpeg they are tot=
ally
> > unrelated.
> >=20
> > One more team is working on the "gimp". And they need those 3 libs =
in
> > specific versions not necessarily there heads.
> >=20
> > One other unrelated team is working on "gqview" and need the same l=
ibs
> > in other specifics versions (Why should they know what te gimp team
> > does)
> >=20
> > Neither "gimp" and "gqview" project will contain directory with tho=
se
> > libs inside. They just depend on them.
> >=20
> > And the last team work on the gnome project which need the "gimp" a=
nd
> > "gqview". It will be this team witch have to care about having both
> > "gimp" and "gqview" sharing the same libs version>
> > And has well the gnome project will not contain "gqview" and "gimp"=
 in
> > its own tree.
> > It will also depend on them.
> >=20
> > It is just the same with aptitude on debian.
> > Each package know there dependency by themselves, does not contain =
there
> > dependencies, and do not need a bigger superpackage to tell them wh=
at
> > are there own dependencies.
>=20
> As Jens mentioned already in this example you have a
>=20
>         somemodule A needs a version of lib C higher than X
> 	somemodule B needs a version of lib C higher than Y
>=20
> relation. Which in the case of submodules is A points to X and B poin=
ts
> to Y. Lets assume X is contained in Y. Since only the superproject kn=
ows
> about both A and B its the only instance that can resolve this confli=
ct
> of dependence on C and can choose Y. In your example aptitude would b=
e
> the superproject containing everything.
>=20

I do not want to have a superproject. just as with aptitude. Each
package store its own dependencies itself.
I do not want to need a super package who now every dependencies of
every possible packages.
=46irst because it is impractical to maintain an exhaustive list of all
possible packages (including unofficial ones.)
Secondly because I have no need for this and it will require somme more
works.
Third for different people witch use and share there own subset off
unofficial package they needs to cook a specific super package for each
unique case.

> This is actually (simplified) the way submodule merge is implemented.=
 So
> you see if you want both A and B to use the same version of C you nee=
d a
> superproject recording this knowledge.

And tha is my problem.

> Adding the ability to point to git repositories outside of the worktr=
ee
> does not solve anything but rather creates more problems. Resolving s=
uch
> dependencies can not be achieved if only A knows that it needs versio=
n X
> and only B knows that it needs version Y.
>=20

Why not it work perfect for me and for debian as well.
Yes I now for speed purpose they scans all the package header and store
their dependency requirement in a database. but it is only for speed an=
d
it is automatic generated by the info "In the packages them selves". I
do not think they ever edit it by hand to define the dependency in the
DB.

In fact I suppose this by what I seen by using it I never looked in the
apt source code.

	Henri GEIST
