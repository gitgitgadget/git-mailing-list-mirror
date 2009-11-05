From: "Joshua J. Kugler" <joshua@eeinternet.com>
Subject: Re: Problem signing a tag
Date: Thu, 05 Nov 2009 00:37:26 -0800
Organization: EE Internet
Message-ID: <200911042337.26820.joshua@eeinternet.com>
References: <200911021558.17550.joshua@eeinternet.com>
 <200911040947.50226.joshua@eeinternet.com>
 <4AF28CE4.5000906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:37:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xqf-0005HS-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZKEIha convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 03:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbZKEIha
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:37:30 -0500
Received: from msgmmp-3.gci.net ([209.165.130.13]:64138 "EHLO msgmmp-3.gci.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbZKEIh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 03:37:29 -0500
Received: from hyperion.eeinternet.com ([206.174.62.163])
 by msgmmp-1.gci.net (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0KSM005N1NYKMQ80@msgmmp-1.gci.net> for
 git@vger.kernel.org; Wed, 04 Nov 2009 23:37:33 -0900 (AKST)
Received: from hosanna.lan (216-67-98-32.static.acsalaska.net [216.67.98.32])
	by hyperion.eeinternet.com (Postfix) with ESMTP id 8A2CE3F21D; Wed,
 04 Nov 2009 23:37:32 -0900 (AKST)
X-Face: %RQZkR-ZZZ/},^dzp$qPotQ8:EI[dl6TX^9<K):};#rjcB`apZ95_e*NbqV8Db$,=?utf-8?q?r=7C7x=5FK=0A=09TOpQkS5A?=>=R9nGN)Qva<p+^;@rEbe*bA5XUd<=?utf-8?q?csl=3BT0d=5FP=3AdH21=2EuJAZ=24iao=26H!K=3A9u=7E=7B9=0A=09WV4=5BX4?=
 =?utf-8?q?*=7B=60=5Evlz=5FIVZ?=)R^X5{:l6#=%fLpM^!}~B"CN.R%wwU-Ni-L2TgD](24jBa=_G@
 =?utf-8?q?Zga=0A=09KNcSq4/Lv=3AJm!z=5D=2Ee5=25IgMb=5Cl-xGs=2EN5M4=5D=3A?=
 =?utf-8?q?vz2?="XrHM]j$h/aNM2J_1}}i@"
 =?utf-8?q?l=26Phy5=3FU1=0A=09mfdxMpo=7D?=)/ixNj03,scN>w*od72RYo9i+XAj
In-reply-to: <4AF28CE4.5000906@drmicha.warpmail.net>
Content-disposition: inline
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132212>

On Wednesday 04 November 2009, Michael J Gruber said something like:
> > So, the docs consider 2 a fatal error, even though it appears it
> > isn't. It seems that
> > http://github.com/git/git/blob/a6dbf8814f433a7fbfa9cde6333c98019f6d
> >b1e4/builtin-tag.c#L202 needs to be patched to something along the
> > lines of:
> >
> > rv =3D finish_command(&gpg)
> > if ((rv && rv !=3D2)  || !len || len < 0)
> >
> > Probably digging in to the gpg source code to figure out what
> > errors are and aren't fatal would be in order.
> >
> > Thanks again for your help! Glad to know what I needed to do to
> > sign my tags!
>
> Dig dig dig... gpg exits with 2 in a lot of cases, one would need to
> parse fd-error to find out more. But it also looks as if gpg exits
> normally with a good passphrase. So I tried, and at least with gpg
> 1.4.9 and git 1.6.5.2 I can sign tags with "use-agent" and without a
> running agent: I get asked for the passphrase (after reporting the
> agent MIA), and everything's fine.
>
> My gpg returns 0 in this case; it returns 2 only if I don't enter the
> passphrase. So, this seems to depend on the version of gpg. Or on
> entering the correct passphrase ;)
>
> Michael

That is weird.  Because when working from the prompt (with agent MIA),=20
gpg 1.4.9, it would accept my pass phrase, and would print the=20
signature (either binary or ascii armored), but it will still exit with=
=20
2.  I don't understand it.  I'll pop on #gnupg tomorrow and ask about=20
it.

Thanks again for your help with this!

j

--=20
Joshua Kugler
Part-Time System Admin/Programmer
http://www.eeinternet.com
PGP Key: http://pgp.mit.edu/ =C2=A0ID 0x14EA086E
