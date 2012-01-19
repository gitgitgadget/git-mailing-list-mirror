From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT
 defined
Date: Wed, 18 Jan 2012 16:17:36 -0800
Message-ID: <7vfwfclf4v.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 01:17:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnfhI-00069C-Sx
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 01:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab2ASARl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 19:17:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64730 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753744Ab2ASARk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 19:17:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EF837BAF;
	Wed, 18 Jan 2012 19:17:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bJrrEB+9G8Wl
	dg9nX0MfIW9KNkU=; b=Lozrwdii2ss++FM9d5XlCVaFBsA8aJ4slVB2aiVU6vzc
	vAjmL9CJ/beGEJFZVqODDffwqT/Mmpf/9ZQ6xgkbMG83e66QgjY97WrJqoZisiuL
	5DoIR1wHZps+6/Az537psn+HXHPViOK4qShgwrx+y+iIMC4IsSyS+Zc41+ZWzwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uUDEsc
	afpRubIJ2TVCGWufNtel/DUBImSH5Fv1I7iW2DubrzWszMG+UBIHbt2p4H55/+3r
	YiLlybjy8XhnaBUXaajdX89Jm4sH+/+vnvkswEqLhu6czMjJenoNed7TdxrcaNGF
	+JfWNcGHX5H0JVODxuLOfDKan3OEPIWFnANSI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4572B7BAD;
	Wed, 18 Jan 2012 19:17:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F75F7BAB; Wed, 18 Jan 2012
 19:17:38 -0500 (EST)
In-Reply-To: <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 19 Jan
 2012 00:18:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEB112AE-4232-11E1-BBC3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188781>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jan 18, 2012 at 19:57, Alex Riesen <raa.lkml@gmail.com> wrote=
:
> ...
>> Well, if I say NO_GETTEXT, I kind of want none of local gettext,
>> whether it works, or not.
>
> That's not what NO_GETTEXT means, and not what it *should* mean. It
> means that your output won't be translated, but we might still make
> use of a locally installed library to provide the gettext() and
> eval_gettext() functions.

You are right.

In the current approach we take for shell scripts, we cannot have "No i=
18n
whatsoever and messages are emit with printf and echo". We always have =
to
go through gettext/eval_gettext even though they may be an implementati=
on
that does not do i18n at all.

> Now I haven't done exhaustive tests but this is the sort of slowdown
> we might be looking at on Linux for output,...

I think we judged that it is OK not to worry about the performance of
message generation, back when we decided to take the current approach.

> Anyway speed is the least of the issues here, it's not like we're ver=
y
> constrained by spewing out gettext output.
>
> I just think we should consider portability more carefully than "it
> doesn't work on one obscure setup, let's change it everywhere", when
> actually it's working just fine in most places.
> ...
> But in summary: We shouldn't be *always* using fallback functions
> whether they're the C stuff in compat/* or the gettext fallbacks in
> git-sh-i18n.sh just because there's some version out there of the
> system-supplied functions that's broken.
>=20
> It makes sense to prefer the system functions by default in both
> cases, but when the OS one can be broken or lacking we can just add
> probes or Makefile options like we do for fnmatch() with the
> NO_FNMATCH_CASEFOLD switch.

So we need "MY_GETTEXT_IS_BROKEN" to decline the use of system gettext
in addition to "NO_GETTEXT" to ask Git not to translate the messages. I=
s
that correct?

If that is the case, should we do something like

	LANG=3DC LC_ALL=3DC
        export LANG LC_ALL

in our shell scripts, when building for NO_GETTEXT target?
