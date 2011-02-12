From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How you can translate things now, and a plan for the i18n series
 going forward
Date: Sat, 12 Feb 2011 12:12:01 -0800
Message-ID: <7vipwpxbam.fsf@alter.siamese.dyndns.org>
References: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, kev <kev@riseup.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 21:12:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoLpU-0002jp-GY
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 21:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1BLUMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 15:12:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1BLUMP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 15:12:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D32D3CDF;
	Sat, 12 Feb 2011 15:13:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mClPTpjpxLPI
	tS3duA7U6CXxkDY=; b=JyI7gfnThkmOI+7cCpDyD2QY0l9ElpykxNxrT7NphdQM
	Sg6ISxA2iBVsKblM6rPQHzXVFfLvTjY2qH6mEpEr0nQyz48CoipXf3uZTf/VoeJm
	ss0xplOasvP5r5bf91+MP058immiN4dHWjrvMZlAWktyuvyLsy8Za//blPiD4aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IkSf4+
	xdgEeuRgWxZK+qo6jWrFsEfm8OdqMVTTzCgNtRryFfdvtT5MvjbVYhKW/76sRfsI
	k9F8RGQ+etuDkEG2VASZnVKEUnCR/1uom3ofRlfjxVdtncAcAy/jJ7DyLo3eX/tK
	8HAOl6+bPkVwEWT4LYl8HquM2H3zM/ujudFNI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B6B63CDE;
	Sat, 12 Feb 2011 15:13:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB2DC3CDD; Sat, 12 Feb 2011
 15:13:06 -0500 (EST)
In-Reply-To: <AANLkTim+_zRisVRfnv_Xe69xof3e8rL_BAXxmAsCwins@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat\, 12 Feb
 2011 12\:19\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84500768-36E4-11E0-A8E6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166620>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Hi both. I've been on a hiatus from Git development, so I haven't
> picked up ab/i18n again, but I still plan to and to get it included i=
n
> Git.

Thanks.

>     *** TODO Introduce a skeleton no-op gettext, just the
> infrastructure minus the interesting stuff
>
>         I.e. just add:
>
>             #define N_(s) (s)
>             #define _(s) (s)
>
>     *** TODO Add no-op C gettextize patches
>
>         This will change "foo" to _("foo") everywhere, but will be a =
no-op
>         due to it being macroed out.

It would be best to get this as early as possible while not many topics
are in 'next'; it is preferrable if we can rebase other topics in 'pu' =
on
top of the result of this step.

>     *** TODO Add no-op Shell/Perl gettextize patches
>
>         Due to the nature of these languages these can't be macroed o=
ut,
>         but it's still easy to have a no-op wrapper function.

Yes.  After the above two steps are done, we can pretty much independen=
tly
advance and tweak i18n topic from other changes.

>     *** TODO Add po/README etc.
>
>         The documentation about how to add translations etc.
>
>     *** TODO Add translations
>
>         Add the po/*.po files. Since we have no-op translations every=
where
>         we can translate git with xgettext + po editing, even though =
the
>         translations aren't being used yet.
>
>     *** TODO Introduce the real gettext in a later patch + tests
>
>         Once the rest is all in this will be a much smaller change.

The last two could probably be swapped, but I think we are on the same
page as to the overall steps and direction.
