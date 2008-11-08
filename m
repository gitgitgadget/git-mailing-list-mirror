From: Francis Galiegue <fg@one2team.com>
Subject: Re: Init on push
Date: Sat, 8 Nov 2008 21:44:25 +0100
Organization: One2team
Message-ID: <200811082144.25261.fg@one2team.com>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com> <200811082108.34535.fg@one2team.com> <7v3ai2c5sd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:48:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyujI-0003yr-U1
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbYKHUrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 15:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYKHUrB
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:47:01 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:59910 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbYKHUrA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 15:47:00 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 60E8492C011;
	Sat,  8 Nov 2008 21:46:48 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id D9CC47001F;
	Sat,  8 Nov 2008 21:46:58 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v3ai2c5sd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100424>

Le Saturday 08 November 2008 21:38:10 Junio C Hamano, vous avez =C3=A9c=
rit=C2=A0:
> Francis Galiegue <fg@one2team.com> writes:
> > Le Saturday 08 November 2008 21:06:01 Jakub Narebski, vous avez =C3=
=A9crit=C2=A0:
> >> Junio C Hamano wrote:
> >> >  - Teach "-D $there" option to "git init", which does an "mkdir =
-p $it
> >> > && chdird $it" before it does its work.
> >>
> >> Shouldn't it be "-C $there" (like make and tar)?
> >
> > I agree with that. It's pretty much a standard for quite a few "com=
mand
> > line people", insofar as I always look for such an option in case I=
 want
> > to know whether a command has the ability to chdir() to a different
> > directory than the current one :p
>
> In this particular case, it is not "chdir() before starting" but "mkd=
ir
> and then chdir() into it".  Using -C would be counterproductive.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I have missed the mkdir part, but then here this is mkdir _-p_...

I mean, what is the cost of mkdir -p the/dir and then git init -C the/d=
ir? I=20
don't think it's that good an idea to have git create the directory in =
this=20
case...

Think of what would happen if you git -D a/b, and a is a symlink to, wh=
ere,=20
somewhere (doesn't exist, exists but if you touch it you're {in trouble=
,good=20
for jail time, whatever}).

I personnaly think that the directory creation SHOULD be created to the=
=20
commands that are meant for it, just as git handles dir creation in its=
 own=20
space (a git repository).

--=20
=46rancis Galiegue
ONE2TEAM
Ing=C3=A9nieur syst=C3=A8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=C3=A9
75116 Paris
