From: "Joshua J. Kugler" <joshua@eeinternet.com>
Subject: Re: Problem signing a tag
Date: Tue, 03 Nov 2009 10:11:46 -0800
Organization: EE Internet
Message-ID: <200911030911.47030.joshua@eeinternet.com>
References: <200911021558.17550.joshua@eeinternet.com>
 <81b0412b0911022331q2976b6e6u575a9700b212623d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:12:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5NrV-0006VN-0x
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 19:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239AbZKCSLs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 13:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754074AbZKCSLs
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 13:11:48 -0500
Received: from msgmmp-1.gci.net ([209.165.130.11]:39111 "EHLO msgmmp-1.gci.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024AbZKCSLr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 13:11:47 -0500
Received: from hyperion.eeinternet.com ([206.174.62.163])
 by msgmmp-1.gci.net (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0KSJ00NG0P7O3NJ0@msgmmp-1.gci.net> for
 git@vger.kernel.org; Tue, 03 Nov 2009 09:11:49 -0900 (AKST)
Received: from hosanna.eeinternet.com (unknown [192.168.100.194])
	by hyperion.eeinternet.com (Postfix) with ESMTP id BD7A83F262; Tue,
 03 Nov 2009 09:11:48 -0900 (AKST)
X-Face: %RQZkR-ZZZ/},^dzp$qPotQ8:EI[dl6TX^9<K):};#rjcB`apZ95_e*NbqV8Db$,=?utf-8?q?r=7C7x=5FK=0A=09TOpQkS5A?=>=R9nGN)Qva<p+^;@rEbe*bA5XUd<=?utf-8?q?csl=3BT0d=5FP=3AdH21=2EuJAZ=24iao=26H!K=3A9u=7E=7B9=0A=09WV4=5BX4?=
 =?utf-8?q?*=7B=60=5Evlz=5FIVZ?=)R^X5{:l6#=%fLpM^!}~B"CN.R%wwU-Ni-L2TgD](24jBa=_G@
 =?utf-8?q?Zga=0A=09KNcSq4/Lv=3AJm!z=5D=2Ee5=25IgMb=5Cl-xGs=2EN5M4=5D=3A?=
 =?utf-8?q?vz2?="XrHM]j$h/aNM2J_1}}i@"
 =?utf-8?q?l=26Phy5=3FU1=0A=09mfdxMpo=7D?=)/ixNj03,scN>w*od72RYo9i+XAj
In-reply-to: <81b0412b0911022331q2976b6e6u575a9700b212623d@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131984>

On Monday 02 November 2009, Alex Riesen said something like:
> On Tue, Nov 3, 2009 at 01:58, Joshua J. Kugler <joshua@eeinternet.com=
>=20
wrote:
> > Nobody on the git IRC channel responded to this question, even
> > after asking it a few times, so I thought I'd try here.
> >
> > I'm having trouble signing a tag. =C2=A0I'm using this command:
> >
> > git tag -u EAFD344D14EA086E -F .git/TAG_EDITMSG tag_name
> >
> > I type in my passphrase, and am then told:
> >
> > error: gpg failed to sign the tag
> > error: unable to sign the tag
> >
> > However, if I use this command:
> >
> > gpg -s -u EAFD344D14EA086E
> >
> > and use the same passphrase, it works fine. Is there any way to
> > find out why a key-signing is failing?
>
> What does "echo $?" after it prints? IOW, maybe plain gpg fails too,
> without printing anything special, and you don't pay attention to the
> exit code. Git does. And it runs "gpg -bsau <key-id>".

$ git tag -s -F .git/TAG_EDITMSG tag_name

You need a passphrase to unlock the secret key for
user: "Joshua J. Kugler <joshua@azariah.com>"
1024-bit DSA key, ID 14EA086E, created 2009-08-09

gpg: problem with the agent - disabling agent use
error: gpg failed to sign the tag
error: unable to sign the tag
$ echo $?
128

And when I sign at the prompt:

$ gpg -sa

You need a passphrase to unlock the secret key for
user: "Joshua J. Kugler <joshua@azariah.com>"
1024-bit DSA key, ID 14EA086E, created 2009-08-09

gpg: problem with the agent - disabling agent use
Blah blah blah blah
-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.9 (GNU/Linux)

owGbwMvMwCT46q+Jr8grjjzG01JJDF4fChqdchIzFJJQCK4ONxYGQSYGNlYmkAoG
Lk4BmLZpyxgW7Jol8mB6kt+Hr1xb9gvUnTs9f/XdVIYFW3VNlx3cmvy4sf/R0/m7
nr9fFpzyFQA=3D
=3DPlql
-----END PGP MESSAGE-----
$ echo $?
2

So, it appear that it works (prints the signature) but then exits with=20
an error code of 2.

Using --status-log, I get:

[GNUPG:] USERID_HINT EAFD344D14EA086E Joshua J. Kugler=20
<joshua@azariah.com>
[GNUPG:] NEED_PASSPHRASE EAFD344D14EA086E EAFD344D14EA086E 17 0
[GNUPG:] GOOD_PASSPHRASE
[GNUPG:] BEGIN_SIGNING
[GNUPG:] SIG_CREATED S 17 2 00 1257271594=20
4FE551A1A4AE4DEF7EDD58E1EAFD344D14EA086E

No indication of an error.  The only thing I see that might be an error=
=20
is "gpg: problem with the agent - disabling agent use." But that should=
=20
be a warning, not an error, correct?  I talked with somebody on the=20
gnupg IRC channel and they were able to create a signed tag, even=20
though they were not using an agent.

Here it is with -bsau:

$ gpg -bsau EAFD344D14EA086E

You need a passphrase to unlock the secret key for
user: "Joshua J. Kugler <joshua@azariah.com>"
1024-bit DSA key, ID 14EA086E, created 2009-08-09

gpg: problem with the agent - disabling agent use
Blah blah blah blah
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkrwciEACgkQ6v00TRTqCG7TZwCfSrvb6p0L+ZZqPB8XrVuMpJPj
jicAoJKnfIeTsWylXpklB9Gw/ArdxvxU
=3DCM2I
-----END PGP SIGNATURE-----
$ echo $?
2


I'm lost. Thanks for the tips.

j

--=20
Joshua Kugler
Part-Time System Admin/Programmer
http://www.eeinternet.com
PGP Key: http://pgp.mit.edu/ =C2=A0ID 0x14EA086E
