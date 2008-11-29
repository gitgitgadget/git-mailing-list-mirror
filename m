From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: A better approach to diffing and merging
Date: Sat, 29 Nov 2008 17:40:02 -0600
Message-ID: <200811291740.06865.bss03@volumehost.net>
References: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1461929.Y5WhPr8Od2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ian Clarke" <ian.clarke@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 00:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6ZhT-0001St-Na
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 00:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbYK2X4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 18:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753120AbYK2X4z
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 18:56:55 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37688 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYK2X4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 18:56:54 -0500
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Nov 2008 18:56:53 EST
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20081129234007.QOUH3946.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sat, 29 Nov 2008 18:40:07 -0500
Received: from dellbuntu.local ([72.204.50.125])
	by fed1rmimpo03.cox.net with bizsmtp
	id lBg51a00K2i4SyG04Bg62E; Sat, 29 Nov 2008 18:40:06 -0500
X-Authority-Analysis: v=1.0 c=1 a=zDTlNH28ivwA:10 a=yHMh0okCwtwA:10
 a=nEQGfrJnAAAA:8 a=S10ij2_GU8Yb2ZnJVBIA:9 a=ZTIFSLUcoh4XFOr6n9j2NYBlg5AA:4
 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=LcbPIGvGkqqfmqMH90cA:9
 a=t_iXkGVDmtQOQTHnMXFV5NzRDksA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
User-Agent: KMail/1.9.5
In-Reply-To: <823242bd0811291012g15c4d442qa5d7afc9cc762b20@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101935>

--nextPart1461929.Y5WhPr8Od2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 2008 November 29 12:12, Ian Clarke wrote:
> While I'm no merging expert, it seems that most merging algorithms do
> it on a line-by-line basis, treating source code as nothing but a list
> of lines of text.  It got me thinking, what if the merging algorithm
> understood the structure of the source code it is trying to merge?

Unfortunately, this is hard to do in general.  Not impossible, but very har=
d. =20
Heck, some languages don't really have a formal grammar, or have one that i=
s=20
undecidable without doing deeper analysis.  Perl 6 is supposed to have some=
=20
support for language constructs that change the grammar.

Also, this generally takes a lot of time.  Automatic merges are only useful=
 if=20
they take less (or only a little more) time than doing the merge manually. =
=20
If your mergetool has to think about something for 30 minutes that you coul=
d=20
have resolved in 5, it's not normally a "win".

Also, it slightly changes the format of a "patch" file.  Currently, patch=20
files are a line-by-line diff.  If you instead made changes based on mappin=
g=20
parse trees to parse trees, you'd (probably) want to=20
store/transfer/communicate your patches using a different format, to preser=
ve=20
the proper amount of "context" and make the patch easy to apply.  (I.e., do=
=20
the hard work once.)

> Any takers? I've set up a Google Group for further discussion, please
> join if interested.

You might look deeper into Darcs development.  This level of=20
pluggable "understanding" of the file(s) being modified fits in well with a=
=20
Grand Unified Theory of Patching.  Also "understanding" patches better allo=
ws=20
Darcs to reorder patches (and calculate "reverse patches") better -- reduci=
ng=20
the time to do existing automatic merging (or reject the merge as=20
non-automatable) and make merges automatic that are currently not handled=20
automatically.

I'm not going to come out and discourage you or other from adding the=20
functionality to git, but I think there are more useful and practical ways =
to=20
improve git.  (Line-by-line merging is generally "good enough", the worst=20
enemy of "good" software.)
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart1461929.Y5WhPr8Od2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJMdLWdNbfk+86fC0RAlPUAKCEQ3ePTrzAvTtVzRJnJhPvtOjFqACbB0Y3
zHHV+ZjHhbm2M/zAWehZNeY=
=yNJl
-----END PGP SIGNATURE-----

--nextPart1461929.Y5WhPr8Od2--
