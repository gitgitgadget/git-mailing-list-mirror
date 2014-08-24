From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 17:18:24 +0100
Message-ID: <53FA1050.2060309@ramsay1.demon.co.uk>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com> <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk> <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tsuna <tsunanet@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 18:18:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLaV1-0006um-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 18:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbaHXQSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 12:18:31 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:60207 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753087AbaHXQS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 12:18:27 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id D186F18CF56;
	Sun, 24 Aug 2014 17:18:24 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 8C60A18CF4E;
	Sun, 24 Aug 2014 17:18:24 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sun, 24 Aug 2014 17:18:24 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255802>

On 24/08/14 12:13, tsuna wrote:
> On Sun, Aug 24, 2014 at 4:10 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> Hmm, which version of OS X are we talking about?
>=20
> OS X 10.9.4:
>=20
> $ uname -a
> Darwin damogran.local 13.3.0 Darwin Kernel Version 13.3.0: Tue Jun  3
> 21:27:35 PDT 2014; root:xnu-2422.110.17~1/RELEASE_X86_64 x86_64

Hmm, does 'uname -r' return 13.3.0 or 13.4.0? (or something else!)

>> config.mak.uname contains this:
>>
>>         ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>>                 NO_STRLCPY =3D YesPlease
>>
>> What does ./configure put in config.mak.autogen for NO_STRLCPY?
>=20
> NO_STRLCPY=3D

OK, so I've got to my limit here! ;-) The conditional shown above
(from config.mak.uname) should not have set NO_STRLCPY (assuming
that 'uname -r' is returning 13.3.0 or 13.4.0). So, unless NO_STRLCPY
is being set somewhere else (command-line, environment), this should
just work. puzzled. :(

>=20
> I guess I saw all the warnings because I did just a =E2=80=9Cgit pull=
 =E2=80=94rebase
> && make -j8=E2=80=9D without running =E2=80=9Cmake configure && ./con=
figure=E2=80=9D.
>=20

Yes, but use of configure is supposed to be optional ...

Hopefully, someone who actually knows OS X can solve the mystery.

ATB,
Ramsay Jones
