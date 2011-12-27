From: chirin <takonatto@gmail.com>
Subject: Re: Git beginner - Need help understanding
Date: Mon, 26 Dec 2011 23:02:52 -0800 (PST)
Message-ID: <1324969372444-7129429.post@n2.nabble.com>
References: <1324955537875-7129186.post@n2.nabble.com> <CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 08:02:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfR3q-0008JD-3q
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 08:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab1L0HCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 02:02:54 -0500
Received: from sam.nabble.com ([216.139.236.26]:47151 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1L0HCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2011 02:02:53 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <takonatto@gmail.com>)
	id 1RfR3k-0000FE-EY
	for git@vger.kernel.org; Mon, 26 Dec 2011 23:02:52 -0800
In-Reply-To: <CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187710>

=46rom what I understand, your scenario is exactly what I expect. Which=
 is why
when I asked around my colleagues, no one was able to explain why I'm h=
aving
this issue.

As per your scenario:

    # A changes hello.txt

    # Going into B (who has not done anything to hello.txt)
    git pull --> merge conflict on hello.txt

    git commit
    git pull --> OK

Would going through Gerrit have anything to do with it? I've compared g=
it
config -l with the others but they are the same (aside from
remote.origin.url which has our own gerrit userid).



Dov Grobgeld wrote
>=20
> The best way of understanding and also of asking questions, is if you
> can reproduce the steps of exactly what you want and don't understand
> by a sequence of commands like so:
>=20
>  =C2=A0=C2=A0=C2=A0 # First create a bare repository
>  =C2=A0=C2=A0=C2=A0 mkdir R
>  =C2=A0=C2=A0=C2=A0 cd R
>  =C2=A0=C2=A0=C2=A0 git init --bare .
>=20
>  =C2=A0=C2=A0=C2=A0 # Clone it into A
>  =C2=A0=C2=A0=C2=A0 git clone R A
>=20
>  =C2=A0=C2=A0=C2=A0 # Clone it into B
>  =C2=A0=C2=A0=C2=A0 git clone R B
>=20
>  =C2=A0=C2=A0=C2=A0 # Now start doing changes for A and B, pulling an=
d pushing into R
>  =C2=A0=C2=A0=C2=A0 cd A
>  =C2=A0=C2=A0=C2=A0 echo "Change #1" > hello.txt
>  =C2=A0=C2=A0=C2=A0 git add hello.txt
>  =C2=A0=C2=A0=C2=A0 git commit -m 'Commit #1'
>  =C2=A0=C2=A0=C2=A0 git push origin master
>=20
>  =C2=A0=C2=A0=C2=A0 # Get into B
>  =C2=A0=C2=A0=C2=A0 cd ../B
>  =C2=A0=C2=A0=C2=A0 git pull
>  =C2=A0=C2=A0=C2=A0 echo "Change #2" >> hello.txt
>  =C2=A0=C2=A0=C2=A0 git commit -a -m 'Commit #2'
>  =C2=A0=C2=A0=C2=A0 git push
>=20
>  =C2=A0=C2=A0=C2=A0 # Get into A and pull the changes done by B
>  =C2=A0=C2=A0=C2=A0 cd ../A
>  =C2=A0=C2=A0=C2=A0 git pull
>=20
> In this sequence, which fulfills the scenario that you described,
> there are no conflicts. So I suggest that you try to change the
> command sequence to illustrate what you don't understand and ask
> again.
>=20
>  Regards,
>  Dov
>=20

--
View this message in context: http://git.661346.n2.nabble.com/Git-begin=
ner-Need-help-understanding-tp7129186p7129429.html
Sent from the git mailing list archive at Nabble.com.
