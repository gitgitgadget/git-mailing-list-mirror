From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Weird behaviour when importing from a subversion repository (empty
 dir/ambiguous argument)
Date: Mon, 11 Apr 2011 09:01:54 +0200
Message-ID: <4DA2A762.1020203@drmicha.warpmail.net>
References: <003701cbf76a$0329dba0$097d92e0$@heigl-online.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: HH-developing@heigl-online.at
X-From: git-owner@vger.kernel.org Mon Apr 11 09:02:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9B8P-0004aV-Je
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 09:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab1DKHB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 03:01:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57830 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753938Ab1DKHB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 03:01:58 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 723DA20704;
	Mon, 11 Apr 2011 03:01:56 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 11 Apr 2011 03:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RQ7rGW0pCazZMJRaq+SOuyFhzLY=; b=f4l1nBBcRzg+SbPCubbNj+IHLaW+J3m+s921mkCLPgzsj4GnrVC3TfvrylfIAnDzp+yD10hyWr3C0sJX6EYyS4EL+IRuCkBJTgCrSv2amv8sqv1ZAFRZHwQfHG7eYCNrGH93duqIi+JhxbKWs5s0XehSnDHbHdttH8DH1Vp6T68=
X-Sasl-enc: nm6g+zu8Xxi3CmYS2pyossdK4V2EwP0KazH/w1+ejYep 1302505316
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8BA1C441619;
	Mon, 11 Apr 2011 03:01:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <003701cbf76a$0329dba0$097d92e0$@heigl-online.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171311>

HH-developing@heigl-online.at venit, vidit, dixit 10.04.2011 12:28:
> Hi everybody!
> I=E2=80=99m a software developer in lower Austria and started introdu=
cing subversion in my company some time ago. It was mainly for myself t=
o have a history. Now when I looked for myself I came to git.=20
> When I=E2=80=99m more comfortable with it we=E2=80=99ll switch at com=
pany too.
>=20
> So I=E2=80=99ve tried to clone our main project and I got an error. I=
 have to say I cloned some other even bigger subversion projects and it=
 worked, so something must be special here.
> I hope you read this long mail, I tried to separate it in sections an=
d tried to shorten the output a little bit.
>=20
>=20
> My command:
> git svn clone "[subversionrepo]"  [gitclonedir] -T trunk -b branches =
-t tags --username [subversionuser]
>=20

"git svn --version" please :)

>=20
> The error:
> fatal: ambiguous argument 'a41f9bd5959dde85035bd047bf730cc62eaee12a^.=
=2E1cb281cf44644da76ed94764f7770bb9e11d7424': unknown revision or path =
not in the working tree.
> Use '--' to separate paths from revisions
> rev-list a41f9bd5959dde85035bd047bf730cc62eaee12a^..1cb281cf44644da76=
ed94764f7770bb9e11d7424: command returned error: 128
> if I do the same with --no-follow-parent, it works, but I assume then=
 I=E2=80=99m losing the branch/tag connection to the trunk. If I=E2=80=99=
m losing the branches I can live with it (I think I did more branching =
in the last days with git, then with subversion the last year =E2=98=BA=
 ), but I=E2=80=99m interested and if there is a possibility I=E2=80=99=
ll prefer to import the subversion project completely.
>=20
>=20
>=20
> I did some further investigation:
> =E2=80=9Egit log a41f9bd5959dde85035bd047bf730cc62eaee12a=E2=80=9C wo=
rks giving me:
>     git-svn-id: [subversionrepo]/branches/Pluginstruktur-HEH@158 ebb3=
a944-7b90-0446-bc25-369ed2d31b3f
> git log a41f9bd5959dde85035bd047bf730cc62eaee12a^ (this should be the=
 parent, right?) says =E2=80=9Eunknown revision or path not in the work=
ing tree.=E2=80=9C
>=20
>=20
>=20
> I think it=E2=80=99s a failure I did in subversion some months ago:
> Rev 158: Created an empty folder 'Pluginstruktur-HEH'.
> Rev 159: Deleted folder =E2=80=9A Pluginstruktur-HEH=E2=80=98 (don=E2=
=80=99t ask why)
> Rev 160: branched from trunk to branches/Pluginstruktur-HEH
>=20
> So in Rev 158 there was an empty folder in branches, in Rev 159 no fo=
lder and in Rev160 a non empty folder out oft he trunk.
> Perhaps this ist the problem, because between Rev 158 and Rev159 ther=
e was a single empty folder an das I found out git doesn=E2=80=99t trac=
k empty folders. Perhaps that=E2=80=99s why Rev158 (git: a41f9bd5959dde=
85035bd047bf730cc62eaee12a) doesn=E2=80=99t have a parent here.

The problem is that r158 has no parent - you started with an empty
folder and created a new root commit (just like git checkout --orphan)
which happens to be empty.

In several places, "git svn" assumes that "A^ B" makes sense, particula=
r
that A has a parent. We fixed a couple of these in the past, which is
why I asked for your version above.

> Maybe you can shed some led in this and how I may solve this.  Can I =
just leave out revision 158 and 159 when doing git svn clone, because i=
t was nothing more than creating an empty folder and deleting an empty =
folder? I=E2=80=99ve read somewhere on the net you can also use a svndu=
mp as base for a git import, perhaps I then may leave rev 158/159 out i=
n the dumb, but I don=E2=80=99t know how to use exactly an svndump as a=
 git import and also if this wuld be a solution for me.

You could first clone up to and including r157, and then fetch from r16=
0
in your case. Still, "git svn" should be able to cope.

Michael
