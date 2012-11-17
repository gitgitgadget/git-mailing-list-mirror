From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] tcsh-completion re-using git-completion.bash
Date: Sat, 17 Nov 2012 11:56:05 +0100
Message-ID: <20121117105605.GB12052@goldbirke>
References: <CAFj1UpEdft+L5KW+tMy6Lqm1eUkHQgwWuXaC0UTUdqwW=ohk-Q@mail.gmail.com>
 <CAMP44s1RtOj6LKCNJ8SX8KSA8eNCMZ+4D-VfQ+WtXju-KhG8ng@mail.gmail.com>
 <CAFj1UpHLf2je_+b1e5B_5thZ03UYVmW=CWhAh63kNRCbke0kQw@mail.gmail.com>
 <CAMP44s1RvMSBu2RJqKw9ne4cJyMO4dbFc-gW2HgsN2-uviv=fA@mail.gmail.com>
 <CAFj1UpHMc-bHJgSZKY13YH_69TXkz-50g5xpLA6C+Eh0aqcN9A@mail.gmail.com>
 <CAMP44s3S4c7ciJNurxGdS2o_TDJJDkGK73dtCGji+C1NoV+Jvw@mail.gmail.com>
 <20121116204017.GX12052@goldbirke>
 <CAMP44s2UVGKa7XkqPxdxQ2ueSMn=Xn4qihy5JWbDovH85n8BwQ@mail.gmail.com>
 <20121116212224.GA12052@goldbirke>
 <CAMP44s3pi0iDOho_qYZEutebDNDveWWv6wEAs-C1bs1A_yL+Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Khouzam <marc.khouzam@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 11:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZg4x-0005uh-3U
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 11:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab2KQK4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Nov 2012 05:56:15 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:53760 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab2KQK4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2012 05:56:09 -0500
Received: from localhost6.localdomain6 (p5B1303A3.dip0.t-ipconnect.de [91.19.3.163])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LzFPp-1TDSGV2B7Z-014NFD; Sat, 17 Nov 2012 11:56:06 +0100
Content-Disposition: inline
In-Reply-To: <CAMP44s3pi0iDOho_qYZEutebDNDveWWv6wEAs-C1bs1A_yL+Sg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ZRPv1XfvcjkNTIVuJP7VPCmrQz7esXqTLDC6FJ0r/5U
 JwX0H8B2W+og+BkWLTccFzcbW6rDaAa0qaMZQsk0l9JQuB1EfI
 OPMhEkQwQlZPg3SLBLaytV919d5ISCxPk7HRQFN6JuWMf+JTXs
 8gGIiY9II+QJ+cgi59HWSDYnur7UzoxLAvFxUfXtDOFVDzGP+E
 JmJhGDf2IUUrWkzIP2U8FObKqnY1fcR6fy4BBEuhWi0xmKc46h
 Z5IDIJer3tnJjWdq9R5cpSmy1oau2elTn6Dd1onkCen/lqh2Rs
 jHstjCZzLd74EBVcGWvriEEA8nOWkvCYNhmAaEW4mdJnezEQVB
 MM73A3PTkzhdJxjNQo1w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209936>

On Fri, Nov 16, 2012 at 10:46:16PM +0100, Felipe Contreras wrote:
> On Fri, Nov 16, 2012 at 10:22 PM, SZEDER G=E1bor <szeder@ira.uka.de> =
wrote:
> > On Fri, Nov 16, 2012 at 10:03:41PM +0100, Felipe Contreras wrote:
>=20
> >> > As I understand the main issues with using the completion script=
 with
> >> > zsh are the various little incompatibilities between the two she=
lls
> >> > and bugs in zsh's emulation of Bash's completion-related builtin=
s.
> >> > Running the completion script under Bash and using its results i=
n zsh
> >> > would solve these issues at the root.  And would allow as to rem=
ove
> >> > some if [[ -n ${ZSH_VERSION-} ]] code.
> >>
> >> We can remove that code already, because we now have code that is
> >> superior than zsh's bash completion emulation:
> >>
> >> http://article.gmane.org/gmane.comp.version-control.git/208173
> >
> > Which depends on the completion script having a wrapper function
> > around compgen filling COMPREPLY.
>=20
> No, it does not. Previous incarnations didn't have this dependency:
>=20
> http://article.gmane.org/gmane.comp.version-control.git/196720

Good.

> > However, COMPREPLY will be soon
> > filled by hand-rolled code to prevent expansion issues with compgen=
,
> > and there will be no such wrapper.
>=20
> I'm still waiting to see a resemblance of that code, but my bet would
> be that there will be a way to fill both COMPREPLY, and call zsh's
> compadd. But it's hard to figure that out without any code. Which is
> why I'm thinking on doing it myself.
>=20
> But even in that case, if push comes to shoves, this zsh wrapper can
> ultimately read COMPREPLY and figure things backwards, as even more
> previous versions did:
>=20
> http://article.gmane.org/gmane.comp.version-control.git/189310

Even better.  I was just going to propose that zsh's completion could
just read the contents of COMPREPLY at the end of _git() and _gitk(),
because this way no zsh-induced helper functions and changes would be
needed to the completion script at all.

However, running the completion script with Bash would also prevent
possible issues caused by incompatibilities between the two shells
mentioned below.

> >> This is the equivalent of what Marc is doing, except that zsh has =
no
> >> problems running bash's code. Note there's a difference with zsh's
> >> emulation bash (or rather bourne shell, or k shell), and zsh's
> >> emulation of bash's _completion_. The former is fine, the later is
> >> not.
> >
> > There are a couple of constructs supported by Bash but not by zsh,
> > which we usually try to avoid.
>=20
> Yes, and is that a big deal?

Not that big, but I wanted to point out that it's not "fine" either.
Just a slight maintenance burden, because we have to pay attention not
to use such constructs.
