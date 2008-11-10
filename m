From: Francis Galiegue <fg@one2team.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 21:24:59 +0100
Organization: One2team
Message-ID: <200811102124.59973.fg@one2team.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <871vxjl5af.fsf@erwin.mina86.com> <200811102117.30372.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Nazarewicz <mina86@tlen.pl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdLU-0004hm-5P
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYKJUZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 15:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbYKJUZa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:25:30 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:40648 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbYKJUZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 15:25:29 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 7C31192C003;
	Mon, 10 Nov 2008 21:25:17 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id D2D007001F;
	Mon, 10 Nov 2008 21:25:27 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811102117.30372.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100560>

Le Monday 10 November 2008 21:17:29 Jakub Narebski, vous avez =C3=A9cri=
t=C2=A0:
> Michal Nazarewicz wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> >> Dnia poniedzia=C5=82ek 10. listopada 2008 18:38, Michal Nazarewicz=
 napisa=C5=82:
> >>> Jakub Narebski <jnareb@gmail.com> writes:
> >>>> The reason why git doesn't support keywords like $Revision$ or $=
Date$
> >>>> is performance: the $Revision$ and $Date$ are keywords related t=
o
> >>>> _commit_ data, not blob data.
> >>>
> >>> In my case identifying content not commit would be even better.
> >>
> >> Well, in that case using `ident` attribute would be enough
> >> (but cryptic).
> >
> > Yes, but it forces me to do some voodoo magic (ie. checkout) to get=
 the
> > Id in the file, ;) like so:
> >
> > #v+
> > $ echo '$Id$'>bar && git add bar && git commit -m 'Added bar' && ca=
t bar
> > Created commit d49d436: Added bar
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >  create mode 100644 bar
> > $Id$
> > $ rm bar && git checkout bar && cat bar
> > $Id: 055c8729cdcc372500a08db659c045e16c4409fb $
> > #v-
>
> Well, _some_ command has to be invoked to expand keywords. "git add"
> doesn't do that (perhaps it should?), so you need to use checkout.
>

If "git add" aims to do that, you'd have to be very, VERY careful, not =
to=20
substitute in the wrong place to start with, not to attempt substitutio=
n in=20
binary files...

And this would have a sizeable cost, imho. If you really want to do thi=
s,=20
isn't there a hook somewhere that can do that for you, instead of modif=
ying=20
git add directly?

--=20
=46rancis Galiegue
ONE2TEAM
Ing=C3=A9nieur syst=C3=A8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=C3=A9
75116 Paris
