From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 23:16:32 +0000
Message-ID: <AANLkTimhR5UDCM_T+UeO=7pbAubR4L6dW4TmUV3B07Pn@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-4-git-send-email-avarab@gmail.com>
	<7veid1gqjd.fsf@alter.siamese.dyndns.org>
	<7v62ydgpvs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 01:16:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCpu-00087K-7X
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 01:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab0IJXQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 19:16:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64819 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0IJXQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 19:16:33 -0400
Received: by iwn5 with SMTP id 5so2646250iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MqeqJvgZi7JxwwSzeazekXxvWjelFCqiWcW+Ra7xFwI=;
        b=Wbk9rFuGQGjmQql7pD+3JHB017fr9TDlxzWOtvukyoBvguOTUZPLC6MmarqPxN1tmC
         iLPe0PeusdA55nsjpwQPcverqP55IsMA9kjKlg4QAX2j8IlhRdFSxhKmiiLtgbwRlQdj
         y5qks22EyUnsaAtSs4VfQOSsf6606R4TawiuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GTOsr1f4IJNfVZIy+CbJTP6iPeVb+XKcIDB+Civ1Z9nSR8LVPNxGvBSEFWBqFQlR4o
         ToM5I8u8bAxRpGqDDymB25JiLT92u6fRvv+TQ7CfSpHW0jJM0a7mIjGJh4/J+M0k6VlC
         zBri1rez2KE8YNRWGUSFpdrHBYmgu6/Lnyz6g=
Received: by 10.231.79.213 with SMTP id q21mr1767573ibk.137.1284160592396;
 Fri, 10 Sep 2010 16:16:32 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 16:16:32 -0700 (PDT)
In-Reply-To: <7v62ydgpvs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155985>

On Fri, Sep 10, 2010 at 23:06, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> writ=
es:
>> ...
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char *reset_type_names[] =
=3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0N_("mixed"), N_("soft"),=
 N_("hard"), N_("merge"), N_("keep"), NULL
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>>> +
>>> + =C2=A0 =C2=A0And then, later:
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("%s reset is not allowed in a ba=
re repository"),
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(reset_type_nam=
es[reset_type]));
>>
>> I do not think this is a very good example. =C2=A0Unless we are doin=
g l10n of
>> option names, a Portuguese won't be typing "git reset --misto", so t=
here
>> is no point in invoking _(reset_type_names[]) to begin with, and the=
re is
>> no need to mark mixed/soft/hard/... for translation.
>
> Ahh, I think I should take half of what I said back. =C2=A0The line o=
f thought
> here is that
>
> =C2=A0(1) the user types "git reset --mixed"; no l10n of option names=
;
>
> =C2=A0(2) however, various modes of operations in "reset" command hav=
e
> =C2=A0 =C2=A0 human-readable names, not necessarily cuttable-and-past=
able for
> =C2=A0 =C2=A0 machine consumption. =C2=A0E.g. "git reset --mixed" is =
called "mixed
> =C2=A0 =C2=A0 reset" in English and that is primarily meant to be exp=
lanation of
> =C2=A0 =C2=A0 concept in human language, i.e. should be translated.
>
> Under that assumption, localizing reset_type_names[] in the above may=
 make
> sense.

Yeah.

> I said "half of", because I think the example is still problematic if=
 you
> want to translate to a language where "reset" in the fixed part of th=
e
> die() message may need to be spelled differently depending on what
> adjective in reset_type_names[] it takes (or the word order between t=
he
> noun "reset" and the adjective may have to be different depending on =
what
> the adjective is), so an example may probaby need to be more like:
>
> =C2=A0 =C2=A0static const char *error_msgs[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0N_("mixed reset is not allowed..."),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0N_("soft reset is not allowed..."),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0};
>
> =C2=A0 =C2=A0die("%s", _(error_msgs[reset_type]));

That, or we could also solve issues like that to some extent by using
the gettext message context, which the limited gettext.h API doesn't
support yet, it's probably not useful in this case but in others you
could do:

    _("reset-verb", "mixed")

And elsewhere:

    _("reset-noun", "mixed")

And that would turn into:

    msgctxt "reset-verb"
    msgid "mixed"
    msgstr "blanda=C3=B0"

Or something like that.

Anyway, regarding the examples it's the only one of two N_() uses
right now, and the builtin/notes.c example is more subtle, and needs
more explanation.

So out of lazyness I'd prefer to keep it as-is for now.
