From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 18:23:05 +0200
Message-ID: <523881E9.9040204@gmx.de>
References: <5236FBEA.80909@gmx.de> <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:23:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLy3e-0006wH-8j
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab3IQQXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 12:23:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:57484 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab3IQQXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:23:17 -0400
Received: from [80.171.227.76] ([80.171.227.76]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0Ld1CS-1VmGJg12VU-00iFOX for <git@vger.kernel.org>;
 Tue, 17 Sep 2013 18:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130807 Thunderbird/17.0.8
In-Reply-To: <CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:0NXN2pPAwA+cL4EQDgsB7LQIeo4S49f+YjDiS/nJuZQpA8sMuOq
 igCSH6GJ6y+2W7YHIKp+u+aBTrF4iQPTJz9kWeJAq5TenaYqEvHCupyDxZFY5EBpYw9x7hM
 ayaL9PdQu7KqvNQd9qNzSeYohCTq9eWOxGcFZFDhMnr9dcxSS+YkLDlKH6GTWtCEeUAjQm4
 uFtEl1SJ50fssK7nSTQvQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234883>

On 09/17/2013 09:26 AM, Christian Couder wrote:
> Hi,
>=20
> On Mon, Sep 16, 2013 at 2:39 PM, Toralf F=C3=B6rster <toralf.foerster=
@gmx.de> wrote:
>> I'm bisecting a linux kernel issue and want to ignore all commits ju=
st
>> touching something in ./drives/staging.
>>
>> Currently the only way would be to specify all dir/subdir combinatio=
n
>> under ./linux except that particular directory, right ?
>=20
> Yeah, you are right, currently the only way would be to specify all
> dir/subdir combination
> under ./linux except the particular directory you want to exclude.
>=20
> It might indeed be useful to have a way to exclude some directories o=
r files.

Great to hear

> In practice though, as git bisect is a kind of binary search, if what
> you want to exclude is exclusively touched by half the commits, it
> will only add one more bisection step if you don't exclude it.

Unfortunately not. Linus pulls from Greg's staging tree usually once in
a merge window. It is not uncommon to have hundreds of commits in that
merge. If now (by accident) the merge point is marked as "BAD" and the
base is "GOOD", then git bisect falls into that trap and wastes about
ld(few hundreds) steps - and this happened here for me and each bisect
step took hours ...


> Best regards,
> Christian.
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
