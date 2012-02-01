From: "Harald Heigl" <Harald@heigl-online.at>
Subject: AW: Project structure of .NET-Projects using git submodule or something different
Date: Wed, 1 Feb 2012 22:07:26 +0100
Message-ID: <000601cce125$808b3cb0$81a1b610$@heigl-online.at>
References: <002401cce069$75ecc1a0$61c644e0$@heigl-online.at> <4F29A0BE.8000803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 22:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsiDL-0007O3-9f
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab2BAVHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 16:07:34 -0500
Received: from xserv02.internex.at ([85.124.51.102]:42111 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754654Ab2BAVHa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 16:07:30 -0500
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 11819 invoked from network); 1 Feb 2012 21:07:27 -0000
Received: by simscan 1.4.0 ppid: 11786, pid: 11807, t: 0.3960s
         scanners: clamav: 0.97.3/m:54/d:14385
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 1 Feb 2012 21:07:27 -0000
In-Reply-To: <4F29A0BE.8000803@web.de>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGEO7+ptvilZ+p+By5B5tRag0k/awHm5zMqlqqUlbA=
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189542>

Hi, thanks for your answer!

> -----Urspr=FCngliche Nachricht-----
> Von: Jens Lehmann [mailto:Jens.Lehmann@web.de]
> Gesendet: Mittwoch, 01. Februar 2012 21:30
> An: Harald Heigl
> Cc: git@vger.kernel.org
> Betreff: Re: Project structure of .NET-Projects using git submodule o=
r
> something different
>=20
> Am 31.01.2012 23:41, schrieb Harald Heigl:
> > Let's assume following Project structure (Dependencies and
> Subdependencies
> > are submodules and submodules of the submodules)
> > Project
> > 	Dependency 1
> > 		Dependency 2
> > 		Dependency 3
> > 	Dependency 4
> > 	Dependency 2
> >
> >
> > The problem is if I want to build them I need to build 2+3, then 1,=
 4
and 2
> > again and then the project. As you may see project 2 is a submodule=
 of
> > dependency 1 and also of project. I don't feel comfortable with thi=
s
setup.
> > What do you think?
>=20
> Hmm, we try to avoid that kind of setup as having checked out differe=
nt
> versions of the "Dependency 2" submodule could have rather surprising
> effects. We get along really well with "Dependency 2" only being pres=
ent
> in the superproject and having "Dependency 1" reference that instead =
of
> having its own copy (So we have submodules which are depending on hav=
ing
> other submodules right next to them). Then the superproject is respon=
sible
> for tying it all together.

I think you're right, my first thoughts were that if I start a new proj=
ect I
just "git submodule dependency1" and get all the required dependencies =
and
the dependencies within the dependencies and so on ... .=20
With your solution I "git submodule dependency1" and have to think abou=
t the
dependencies it depends on. On the other hand we are just a small compa=
ny
and the number of submodules is not too big and the missing references =
in a
new project would be easily identifiable, so ... .

And if I want to checkout dependency 1 individually (for whatever reaso=
n), I
could still do something like this:
SuperDependency1 (with solution-File)
           Dependency1 (as submodule)
           Dependency2 (dependency of dependency1 - as submodule)
           Dependency3 (dependency of dependency1 - as submodule)

Thanks again, I see my concept causes some trouble ...

Any other thoughts or other workflows with git or with tools build arou=
nd
git?

Thanks again,
Harald
