From: "Harald Heigl" <Harald@heigl-online.at>
Subject: AW: Weird behaviour when importing from a subversion repository (empty dir/ambiguous argument)
Date: Mon, 11 Apr 2011 10:09:46 +0200
Message-ID: <000901cbf81f$d3c52b60$7b4f8220$@heigl-online.at>
References: <003701cbf76a$0329dba0$097d92e0$@heigl-online.at> <4DA2A762.1020203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 10:10:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9CCG-00089d-42
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 10:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab1DKIJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 04:09:56 -0400
Received: from xserv02.internex.at ([85.124.51.102]:39050 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754115Ab1DKIJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 04:09:55 -0400
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 29854 invoked from network); 11 Apr 2011 08:09:49 -0000
Received: by simscan 1.4.0 ppid: 29805, pid: 29838, t: 0.2343s
         scanners: clamav: 0.97/m:53/d:12966
Received: from mail.se-t.at (HELO setnbheh) (Harald@heigl-online.at@194.112.138.126)
  by xserv02.internex.at with SMTP; 11 Apr 2011 08:09:49 -0000
In-Reply-To: <4DA2A762.1020203@drmicha.warpmail.net>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEXcd0yC7cUaWCOHMiUa2E+p/yQsAJXVLQSla6eR1A=
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171312>

Hi!
Thanks for your fast answer, you lead me to the right direction, proble=
m solved! see answers below.

> -----Urspr=C3=BCngliche Nachricht-----
> Von: Michael J Gruber [mailto:git@drmicha.warpmail.net]
> Gesendet: Montag, 11. April 2011 09:02
> An: HH-developing@heigl-online.at
> Cc: git@vger.kernel.org
> Betreff: Re: Weird behaviour when importing from a subversion reposit=
ory
> (empty dir/ambiguous argument)
>=20
> HH-developing@heigl-online.at venit, vidit, dixit 10.04.2011 12:28:
> > Hi everybody!
> > I=E2=80=99m a software developer in lower Austria and started intro=
ducing
> subversion in my company some time ago. It was mainly for myself to h=
ave a
> history. Now when I looked for myself I came to git.
> > When I=E2=80=99m more comfortable with it we=E2=80=99ll switch at c=
ompany too.
> >
> > So I=E2=80=99ve tried to clone our main project and I got an error.=
 I have to say I
> cloned some other even bigger subversion projects and it worked, so
> something must be special here.
> > I hope you read this long mail, I tried to separate it in sections =
and tried to
> shorten the output a little bit.
> >
> >
> > My command:
> > git svn clone "[subversionrepo]"  [gitclonedir] -T trunk -b branche=
s
> > -t tags --username [subversionuser]
> >
>=20
> "git svn --version" please :)

Sorry I forgot to say: 1.7.4 on windows (msysgit) and 1.7.4.3 on linux =
(ubuntu-server)
Had the same behaviour on both oft hem.

>=20
> >
> > The error:
> > fatal: ambiguous argument
> 'a41f9bd5959dde85035bd047bf730cc62eaee12a^..1cb281cf44644da76ed9476
> 4f7770bb9e11d7424': unknown revision or path not in the working tree.
> > Use '--' to separate paths from revisions rev-list
> >
> a41f9bd5959dde85035bd047bf730cc62eaee12a^..1cb281cf44644da76ed94764
> f77
> > 70bb9e11d7424: command returned error: 128 if I do the same with --=
no-
> follow-parent, it works, but I assume then I=E2=80=99m losing the bra=
nch/tag
> connection to the trunk. If I=E2=80=99m losing the branches I can liv=
e with it (I think I
> did more branching in the last days with git, then with subversion th=
e last
> year =E2=98=BA ), but I=E2=80=99m interested and if there is a possib=
ility I=E2=80=99ll prefer to import the
> subversion project completely.
> >
> >
> >
> > I did some further investigation:
> > =E2=80=9Egit log a41f9bd5959dde85035bd047bf730cc62eaee12a=E2=80=9C =
works giving me:
> >     git-svn-id: [subversionrepo]/branches/Pluginstruktur-HEH@158
> > ebb3a944-7b90-0446-bc25-369ed2d31b3f
> > git log a41f9bd5959dde85035bd047bf730cc62eaee12a^ (this should be t=
he
> > parent, right?) says =E2=80=9Eunknown revision or path not in the w=
orking
> > tree.=E2=80=9C
> >
> >
> >
> > I think it=E2=80=99s a failure I did in subversion some months ago:
> > Rev 158: Created an empty folder 'Pluginstruktur-HEH'.
> > Rev 159: Deleted folder =E2=80=9A Pluginstruktur-HEH=E2=80=98 (don=E2=
=80=99t ask why) Rev 160:
> > branched from trunk to branches/Pluginstruktur-HEH
> >
> > So in Rev 158 there was an empty folder in branches, in Rev 159 no =
folder
> and in Rev160 a non empty folder out oft he trunk.
> > Perhaps this ist the problem, because between Rev 158 and Rev159 th=
ere
> was a single empty folder an das I found out git doesn=E2=80=99t trac=
k empty folders.
> Perhaps that=E2=80=99s why Rev158 (git:
> a41f9bd5959dde85035bd047bf730cc62eaee12a) doesn=E2=80=99t have a pare=
nt here.
>=20
> The problem is that r158 has no parent - you started with an empty fo=
lder
> and created a new root commit (just like git checkout --orphan) which
> happens to be empty.
>=20
> In several places, "git svn" assumes that "A^ B" makes sense, particu=
lar that
> A has a parent. We fixed a couple of these in the past, which is why =
I asked
> for your version above.
>=20
> > Maybe you can shed some led in this and how I may solve this.  Can =
I just
> leave out revision 158 and 159 when doing git svn clone, because it w=
as
> nothing more than creating an empty folder and deleting an empty fold=
er?
> I=E2=80=99ve read somewhere on the net you can also use a svndump as =
base for a git
> import, perhaps I then may leave rev 158/159 out in the dumb, but I d=
on=E2=80=99t
> know how to use exactly an svndump as a git import and also if this w=
uld be a
> solution for me.
>=20
> You could first clone up to and including r157, and then fetch from r=
160 in
> your case. Still, "git svn" should be able to cope.

That lead me to the right direction: I was thinking of git cloning the =
whole history and not thinking about that you could do a partitial clon=
e of a subversion directory and then fetch from somewhere in between, s=
o I did:
 git svn clone "[subversionrepo]"  [gitclonedir] -T trunk -b branches -=
t tags --username [subversionuser] -r 0:157
 git svn fetch -r 160:HEAD

>=20
> Michael

So left out the two misleading revisions  and it worked! Thanks again, =
still learning on git :-)
Regards,
Harald
