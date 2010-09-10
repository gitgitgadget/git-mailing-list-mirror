From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 23:03:04 +0000
Message-ID: <AANLkTimNvSuJ8g_Z3OuN2d-EGO99NNohe_HN+yzBaBMy@mail.gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
	<1284147353-18000-4-git-send-email-avarab@gmail.com>
	<7veid1gqjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 01:03:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCcj-0000YW-0C
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 01:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab0IJXDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 19:03:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41622 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0IJXDF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 19:03:05 -0400
Received: by iwn5 with SMTP id 5so2635115iwn.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 16:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JC5QcrCaDpLiFlBybD7M1ZUxV8PeOhQuLhIPTjVeblg=;
        b=nyDjS62k/v5fBrnuscOqzPSjhzNcDGlBSzU4S5ydNKGbsOPM7dqUaIHT5YWxj8/ROX
         u8goge63dLWUUoiQ2vSezYDxYgNgn12Df93e6C+O9/Fey8La9ctvP++jyYvHB9JA4Vfx
         LSpjcqt0+AKMdphj1Qp6flo4fmFW0LWTYpm7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oeFx4MlhSh6gmFjsQDrfT4EDuMRGX/0G+p2DIy2uSgtxhuwxi3jvLrvjIVlJ2qeO8I
         9Gl+bvFCC6Lyy9vLCyuTIqC9i0zESzx10ImbGixkh6edKfXbTELoiksKAx9PPYlpgEpn
         GQfZBb7DQNUl1Z+Nq1ZVb4tKQIUyN3XRitPiY=
Received: by 10.231.174.196 with SMTP id u4mr1780010ibz.19.1284159784781; Fri,
 10 Sep 2010 16:03:04 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 10 Sep 2010 16:03:04 -0700 (PDT)
In-Reply-To: <7veid1gqjd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155981>

On Fri, Sep 10, 2010 at 22:52, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> + =C2=A0 - _()
>> +
>> + =C2=A0 =C2=A0Mark and translate a string. E.g.:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(_("HEAD is now at %s"), hex);
>> +
>> + =C2=A0 - N_()
>> +
>> + =C2=A0 =C2=A0A no-op pass-through macro for marking strings inside=
 static
>> + =C2=A0 =C2=A0initializations, e.g.:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0static const char *reset_type_names[] =3D=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0N_("mixed"), N_("soft"), =
N_("hard"), N_("merge"), N_("keep"), NULL
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0};
>> +
>> + =C2=A0 =C2=A0And then, later:
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("%s reset is not allowed in a bar=
e repository"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _(reset_type_name=
s[reset_type]));
>
> I do not think this is a very good example. =C2=A0Unless we are doing=
 l10n of
> option names, a Portuguese won't be typing "git reset --misto", so th=
ere
> is no point in invoking _(reset_type_names[]) to begin with, and ther=
e is
> no need to mark mixed/soft/hard/... for translation.

Actually all the code that uses reset_type_names isn't referring to
the option directly, but to the action currently being undertaken:

    die(_("Cannot do a %s reset in the middle of a merge."),
        _(reset_type_names[reset_type]));

    die(_("Cannot do %s reset with paths."),
        _(reset_type_names[reset_type]));

    die(_("%s reset is not allowed in a bare repository"),
        _(reset_type_names[reset_type]));

In that context translators probably want to translate them, e.g. I'd
translate the first one into Icelandic as:

    "Get ekki framkv=C3=A6mt %s endurstillingu =C3=AD mi=C3=B0ri samein=
ingu" with %s
=3D=3D "blanda=C3=B0a" ("mixed")

> And we won't be doing l10n of option names or subcommand names, I hop=
e ;-).

We could do that, I don't have plans for it though, and in any case I
don't think this is such a case.
