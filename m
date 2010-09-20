From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: use base64 instead of quoted-printable in format-patch headers
 (was Re: Make format-patch produce UTF-8 `From:' header)
Date: Mon, 20 Sep 2010 10:29:23 -0500
Message-ID: <ml4g8cZKMzCEccW79LHWosmZo3sz8RXCtZnyPWJ59xPTtblrKv8xLQ@cipher.nrlssc.navy.mil>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>	<87y6axshmt.fsf_-_@gmail.com>	<87mxrda6e3.fsf@windlord.stanford.edu>	<87k4mgsj1j.fsf_-_@gmail.com> <AANLkTim-vfrxGbdfXeef81uP29NSSzutHbs-yhhQtiA8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Russ Allbery <rra@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	=?UTF-8?B?THVrYXMgU2FuZHN0csO2?= =?UTF-8?B?bQ==?= 
	<luksan@gmail.com>, Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 17:29:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxiJS-0002gB-4S
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 17:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab0ITP3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 11:29:40 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36508 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab0ITP3k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 11:29:40 -0400
Received: by mail.nrlssc.navy.mil id o8KFTOEZ031118; Mon, 20 Sep 2010 10:29:24 -0500
In-Reply-To: <AANLkTim-vfrxGbdfXeef81uP29NSSzutHbs-yhhQtiA8@mail.gmail.com>
X-OriginalArrivalTime: 20 Sep 2010 15:29:23.0851 (UTC) FILETIME=[9A80E5B0:01CB58D8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156630>

On 09/20/2010 08:46 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 20, 2010 at 12:20, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <step=
nem@gmail.com> wrote:
>> Russ Allbery <rra@debian.org> writes:
>>
>>> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
>>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>
>>>>> Maybe format-patch could provide another mode to produce patches =
that
>>>>> do not include unnecessary headers (in particular, leaving out th=
e
>>>>> difficult "From " line and using UTF-8 instead of quoted-printabl=
e for
>>>>> the "From: " line).
>>>
>>>> FWIW, the quoted-printable `From:' encoding has always annoyed me =
-- I
>>>> replace it manually with my name & address in UTF-8 every time I s=
end
>>>> out a patch. What is the reason format-patch does that (and if the=
re is
>>>> a reason not to change the default, could an option to disable it =
be
>>>> provided)?
>>>
>>> Well, it's required if you're going to actually send the result dir=
ectly
>>> as a mail message, since the RFC 5322 format requires headers be en=
coded
>>> using RFC 2047 encoding.
>>
>> Right... thanks for pointing that out. So the problem I'm seeing is
>> actually different -- some software (including Mutt and the mailing
>> list/archive software used by this list) appears to have problems wi=
th
>> quoted-printable, but not with base64.
>>
>> To take my name as example: when I send mail from Mutt, it is encode=
d as
>> "=3D?utf-8?B?xaB0xJtww6FuIE7Em21lYw=3D=3D?=3D", i.e. base64, and bot=
h Mutt and
>> the vger archive seem to decode it properly, whereas the
>> quoted-printable version produced by fromat-patch, i.e.
>> "=3D?utf-8?q?=3DC5=3DA0t=3DC4=3D9Bp=3DC3=3DA1n=3D20N=3DC4=3D9Bmec?=3D=
" in this case, is left
>> undecoded by Mutt and mis-decoded in the ML archive as far as I have
>> seen. I'm not sure about other software (Gnus seems to be able to de=
al
>> with both correctly), but perhaps it would make sense to switch to
>> base64 in format-patch?
>=20
> The advantage of quoted-printable is the printable part. It's at leas=
t
> somewhat human readable, e.g.:
>=20
>     =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjar=
mason?=3D
>=20
> I have some chance of spotting a typo or something in there if I look
> at the raw E-Mail (which I often do), but not with base64.
>=20
> Are we sure we're correctly encoding quoted-printable? E.g. maybe
> ?UTF-8? instead of ?utf-8? would work? It seems odd that a widely use=
d
> client like Mutt would screw up such a widely used encoding.

I don't think we should be producing lower-case utf-8 anymore, since
1.6.4 I think.

I have encountered platforms, like older Solaris or IRIX, that indeed
did not understand utf-8, but did understand UTF-8.  So, it is somethin=
g
to check out.  Perhaps Mutt or the mailing list archive were running
on such a system?

-Brandon
