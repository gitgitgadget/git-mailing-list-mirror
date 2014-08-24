From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 21:49:54 +0200
Message-ID: <53FA41E2.9060907@web.de>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com> <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk> <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com> <53FA1050.2060309@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	tsuna <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 21:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLdox-0000ix-Fh
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 21:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368AbaHXTvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 15:51:17 -0400
Received: from mout.web.de ([212.227.15.4]:57064 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281AbaHXTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 15:50:00 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LqGCu-1WiCJg2FE0-00dlWP; Sun, 24 Aug 2014 21:49:56
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53FA1050.2060309@ramsay1.demon.co.uk>
X-Provags-ID: V03:K0:kOUT43b2parQk4Nb1IAZZi+L+fvnQsFpwz3fpybB6lOFhBHGG4V
 BjAhURYjiHXYKg31JORQTm4AtCXAXMae0dQ8+8YT5evKwGvJPt5g1HTvgtKRrSFmuan3oP3
 dh6JSMVTm9m8juc+k74rtqN6COuzGpQlPiCOInfp3VbMrBqIaqjrQ8a7i0NVe05SmCwbFX8
 McOSvg/0dtfEKmREXZFCw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255813>

On 2014-08-24 18.18, Ramsay Jones wrote:
> On 24/08/14 12:13, tsuna wrote:
>> On Sun, Aug 24, 2014 at 4:10 AM, Ramsay Jones
>> <ramsay@ramsay1.demon.co.uk> wrote:
>>> Hmm, which version of OS X are we talking about?
>>
>> OS X 10.9.4:
>>
>> $ uname -a
>> Darwin damogran.local 13.3.0 Darwin Kernel Version 13.3.0: Tue Jun  =
3
>> 21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64
>=20
> Hmm, does 'uname -r' return 13.3.0 or 13.4.0? (or something else!)
>=20
>>> config.mak.uname contains this:
>>>
>>>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>>>                 NO_STRLCPY =3D YesPlease
>>>
>>> What does ./configure put in config.mak.autogen for NO_STRLCPY?
>>
>> NO_STRLCPY=3D
>=20
> OK, so I've got to my limit here! ;-) The conditional shown above
> (from config.mak.uname) should not have set NO_STRLCPY (assuming
> that 'uname -r' is returning 13.3.0 or 13.4.0). So, unless NO_STRLCPY
> is being set somewhere else (command-line, environment), this should
> just work. puzzled. :(
>=20
>>
>> I guess I saw all the warnings because I did just a =E2=80=9Cgit pul=
l =E2=80=94rebase
>> && make -j8=E2=80=9D without running =E2=80=9Cmake configure && ./co=
nfigure=E2=80=9D.
>>
>=20
> Yes, but use of configure is supposed to be optional ...
>=20
> Hopefully, someone who actually knows OS X can solve the mystery.
>=20
> ATB,
> Ramsay Jones

I need to admit that I can not reproduce the warning here,
uname -r gives "13.3.0"

Could it be that something is special on your machine ?
Something in the environment  ?
Does a fresh clone help ?
