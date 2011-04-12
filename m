From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 09:44:58 +0200
Message-ID: <BANLkTincUmH7SjypXfDMXDfg8BxW4MW+Jg@mail.gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
	<1302464048-21806-2-git-send-email-avarab@gmail.com>
	<7v39lorli9.fsf@alter.siamese.dyndns.org>
	<7vy63gq6s2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:45:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9YHb-0007aQ-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab1DLHpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:45:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069Ab1DLHpA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:45:00 -0400
Received: by fxm17 with SMTP id 17so4096628fxm.19
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6pCZWN67doks9oEZlY/6kApUaaV77ZMiDDcD8lXyg5k=;
        b=SuZ8OwKCFqAga5Q/AkD/oLVF7KQGN1nPqbN7dVnTJcaT0miftmcfMcpki5tMeaP7F9
         wRhJVeD7pPAYyJZmH15pkRMTHpSPqY3QzEzV4o7KCIUP4NKfc9cyctoDz5COQZL2+Pvx
         9BLU2CNBA92VRueiE0o63Hr/NcXreItnlK7Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B0Dal6BV3syx0ZDhNscnzbypz/rD2cQ4I2KSww3bGaILsQl6EbjavXziN4cuLOk+Z4
         Ygb5w0zHUNwe7zhOQXGA0iyHQBYy2Gv2OR5rMg1hh+3WOO/XsaLJEdGfvzN/+eRz2HT6
         I9qqiiffx9I9anbh2xNL/xf733faStCa1/mGQ=
Received: by 10.223.24.72 with SMTP id u8mr1544035fab.10.1302594298929; Tue,
 12 Apr 2011 00:44:58 -0700 (PDT)
Received: by 10.223.105.201 with HTTP; Tue, 12 Apr 2011 00:44:58 -0700 (PDT)
In-Reply-To: <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171380>

On Tue, Apr 12, 2011 at 09:15, Junio C Hamano <gitster@pobox.com> wrote=
:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> =C2=A0 =C2=A0 =C2=A0fp =3D fopen(git_link, "w");
>>> =C2=A0 =C2=A0 =C2=A0if (!fp)
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Could not create gi=
t link %s", git_link);
>>> - =C2=A0 =C2=A0fprintf(fp, "gitdir: %s\n", git_dir);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die(_("Could not create =
git link %s"), git_link);
>>> + =C2=A0 =C2=A0fprintf(fp, _("gitdir: %s\n"), git_dir);
>>> =C2=A0 =C2=A0 =C2=A0fclose(fp);
>>> ...
>> I don't think this is correct. =C2=A0The file "git_link" refers to .=
git that is
>> not a directory but is a regular file whose contents is "gitdir: $pa=
th"
>> and that should _never_ be localized, so the patch to die() message =
is Ok,
>> but the string given to fprintf(fp, ...) is _not_.
>
> See read_gitfile_gently() in setup.c; that is the reader of the
> information contained in this file.

Ah, thanks. Missed that. I'd have spotted it if I dug down instead of s=
ending.

I'll re-send one without the translation for this plumbing message.
