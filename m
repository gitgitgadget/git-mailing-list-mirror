From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Sat, 17 Nov 2012 15:17:14 +0100
Message-ID: <20121117141714.GJ12052@goldbirke>
References: <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
 <20121116204017.GX12052@goldbirke>
 <CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
 <20121116212224.GA12052@goldbirke>
 <CAMP44s3pi0iDOho_qYZEutebDNDveWWv6wEAs-C1bs1A_yL+Sg@mail.gmail.com>
 <20121117105605.GB12052@goldbirke>
 <CAMP44s3FFEGJDa6cnwVY0aJkoU_-OdvDPD0gPQtrUqdY2JCpWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 15:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZjD9-0003Kh-7e
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 15:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827Ab2KQORQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 09:17:16 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:52361 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2KQORQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 09:17:16 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MOYSH-1TcjU72yXt-006ao0; Sat, 17 Nov 2012 15:17:14 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3FFEGJDa6cnwVY0aJkoU_-OdvDPD0gPQtrUqdY2JCpWw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:N4hCa0TnAXlWMUpPn0acUCG1pKWlhNq1g39tE+0DzB0
 KmnCOLojYt37i4tiZ12315T0y5PDIjGKkb4iaMZdOqfLqbMakC
 weq95zslGhTjrrhofPs0xwamMZPOvHridYjK2/2QnAbrKiCIgG
 nElGsC2PN7c/7GH2RHvzx6q9Vmxvfsap/lXONIZe0gwfyinbV5
 n1twKLO4QCNlKTbr+GF4P4n7/tbPktwcHvrJuOyICBKwkPEzqH
 7DQ9iNB01Ap4TyQ6Hr1gpVkJnMiiEgtQK5arsr4rtCKlQA7ASi
 VhljXDr+Fb5+lqQPO+5QgXULmVV93V/4JhWZK+IpWHPuuElj8k
 4cNj10eZYCulPKJtFndU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209958>

On Sat, Nov 17, 2012 at 12:46:27PM +0100, Felipe Contreras wrote:
> On Sat, Nov 17, 2012 at 11:56 AM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
> > On Fri, Nov 16, 2012 at 10:46:16PM +0100, Felipe Contreras wrote:
>=20
> >> But even in that case, if push comes to shoves, this zsh wrapper c=
an
> >> ultimately read COMPREPLY and figure things backwards, as even mor=
e
> >> previous versions did:
> >>
> >> http://article.gmane.org/gmane.comp.version-control.git/189310
> >
> > Even better.  I was just going to propose that zsh's completion cou=
ld
> > just read the contents of COMPREPLY at the end of _git() and _gitk(=
),
> > because this way no zsh-induced helper functions and changes would =
be
> > needed to the completion script at all.
>=20
> I would rather modify the __gitcomp function. Parsing COMPREPLY is to=
o
> cumbersome.

Each element of COMPREPLY contains a possible completion word.  What
parsing is needed to use that, that is so cumbersome?

> > However, running the completion script with Bash would also prevent
> > possible issues caused by incompatibilities between the two shells
> > mentioned below.
>=20
> It could, but it doesn't now.
>=20
> >> >> This is the equivalent of what Marc is doing, except that zsh h=
as no
> >> >> problems running bash's code. Note there's a difference with zs=
h's
> >> >> emulation bash (or rather bourne shell, or k shell), and zsh's
> >> >> emulation of bash's _completion_. The former is fine, the later=
 is
> >> >> not.
> >> >
> >> > There are a couple of constructs supported by Bash but not by zs=
h,
> >> > which we usually try to avoid.
> >>
> >> Yes, and is that a big deal?
> >
> > Not that big, but I wanted to point out that it's not "fine" either=
=2E
> > Just a slight maintenance burden, because we have to pay attention =
not
> > to use such constructs.
>=20
> Do we have to pay attention?

Unless you don't mind possible breakages of zsh completion, yes.

> I say when we encounter one of such maintenance burden issues _then_
> we think about it. In the meantime for all we know sourcing bash's
> script from zsh is fine.

That's a cool argument, will remember it when it again comes to
refactoring the __gitcomp() tests.  For now those tests work just
fine.  When we encounter maintenance burden issues, like fixing a bug
requiring the same modification to all of those tests, then we'll
think about it. ;)
