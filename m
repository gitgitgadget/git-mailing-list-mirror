From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Sat, 12 Feb 2011 13:12:15 +0100
Message-ID: <4D56791F.2090004@drmicha.warpmail.net>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 13:11:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoEJz-0006BO-Ai
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 13:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab1BLMLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 07:11:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52914 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab1BLMLP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 07:11:15 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 73AC220FBB;
	Sat, 12 Feb 2011 07:11:14 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 12 Feb 2011 07:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tUi+iydCgxpycpHaL3prZFDkdUs=; b=IhAhnRsCThsoIoeYC9gGKPZSAiI+DqNCGHvmrF7/ZZnsZoEV60NBphCqowS74+/dnmGxvoeKne5QDl97VKUe9BKHMT/wrxHD6Z2ZSkp7NE9hJAN8jJ9DxwHjG2pNZpPo7bvpHebusUlA+fgdHhMZyKa1YZjys9iDYnZmRXbicF0=
X-Sasl-enc: uq79lNAKg2RrgKymggl1L8Jgks6pHpIO3DtqHwd3B42p 1297512673
Received: from localhost.localdomain (p54859B52.dip0.t-ipconnect.de [84.133.155.82])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1D6AF401E70;
	Sat, 12 Feb 2011 07:11:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166609>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 12.02.2011 1=
2:19:
> On Fri, Feb 11, 2011 at 21:22, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>> On Fri, Feb 11, 2011 at 21:01, kev <kev@riseup.net> wrote:
>>> i understand the ab/i18n has been gettextized and translated to at
>>> least a couple of languages.
>>>
>>> ive found references in the list archives to this, but nothing in t=
he
>>> source code. i do see translations of git-gui, however. but im look=
ing
>>> for some clue as to how to translate git itself.
>>
>> Currently the ab/i18n branch has not been merged to master, so it's
>> not available to the general public. =C3=86var has been working on i=
t but
>> we haven't heard from him recently on this topic.
>=20
> Hi both. I've been on a hiatus from Git development, so I haven't
> picked up ab/i18n again, but I still plan to and to get it included i=
n
> Git.
>=20
> Meanwhile Kev, if you want to translate Git you can:
>=20
>     git clone git://github.com/avar/git.git &&
>     cd git &&
>     git checkout -t origin/ab/i18n
>=20
> And follow the instructions in po/README. This branch is relatively
> out of date and hasn't been rebased on the upstream master in a while=
,
> but most of the strings you'll be translating will still be there onc=
e
> I do that, so your work won't go to waste.
>=20
> For everyone else, I plan to re-submit ab/i18n, but re-do it so that
> it isn't all one huge patch series but can be applied in smaller
> steps. Here's the outline of my current plan:
>=20
>     ** TODO Re-do the i18n series so it can be applied in piecemeal s=
teps
>=20
>        I.e. these:
>=20
>     *** TODO Introduce a skeleton no-op gettext, just the
> infrastructure minus the interesting stuff
>=20
>         I.e. just add:
>=20
>             #define N_(s) (s)
>             #define _(s) (s)
>=20
>     *** TODO Add no-op C gettextize patches
>=20
>         This will change "foo" to _("foo") everywhere, but will be a =
no-op
>         due to it being macroed out.
>=20
>     *** TODO Add no-op Shell/Perl gettextize patches
>=20
>         Due to the nature of these languages these can't be macroed o=
ut,
>         but it's still easy to have a no-op wrapper function.
>=20
>     *** TODO Add po/README etc.
>=20
>         The documentation about how to add translations etc.
>=20
>     *** TODO Add translations
>=20
>         Add the po/*.po files. Since we have no-op translations every=
where
>         we can translate git with xgettext + po editing, even though =
the
>         translations aren't being used yet.
>=20
>     *** TODO Introduce the real gettext in a later patch + tests
>=20
>         Once the rest is all in this will be a much smaller change.
>=20
> I think doing it this way will be much easier for everyone, what do
> you think Junio?

Disclaimer: I'm not Junio :)

Sounds like a good plan, though I'm wondering whether reversing the
order of the last two would make sense review-wise (with having 1
translation for the tests), i.e. for reviewing the translations. In cas=
e
those last two should be orthogonal so that it doesn't matter.

What does matter (at least to me) is my old pet-peave suggestion for
having consistent, systematic translations: translate a/the glossary
first, then translate git messages.

_("Cheers,")
Michael
