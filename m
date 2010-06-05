From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v8 0/2] Gettext support for Git
Date: Sat, 5 Jun 2010 21:35:29 +0000
Message-ID: <AANLkTikvP6z4-AdbSJQYV5yo9UXKVh3lleFZ49_hmSZ5@mail.gmail.com>
References: <1275772373-26718-1-git-send-email-avarab@gmail.com>
	<m3vd9xp3oz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 23:35:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL11m-0003J4-AB
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114Ab0FEVfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 17:35:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63950 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933039Ab0FEVfa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 17:35:30 -0400
Received: by iwn37 with SMTP id 37so2186519iwn.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=18fzPb/7iijx0FfDf0jyjj5Ci8Nnk1KA1wTYK+/HaIQ=;
        b=L9nTWB/j9VaSwzwu8qTODslPI2FiP/KOcyuGgpdmnGzt+cob8AiI5eBCOoRoggUH07
         J8B+HRC8ZNa+RynT2Lkd2V7zAYUF9LVvgr+VAHSbmTc7/zu912BcuX+Z5M7Gru+U0JTj
         GW9NN5rycO1HzcTJvKrh3X344n7qTMSf82Oj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BjYJfZpmdQF2kMmp1nFGrIvEQIRw6YopoHThjS4ThndwtW6Kl3+WG0gY/NWBc1G7kq
         u/jeEgYvMqFdQCb5LiqfhKdwcXPfVFJSUCS1EqBCDLqshwDLHUG4UmYcIBFAqwUXgK8i
         8R/nqSDnCMvwO9O6UJQuido04dxETEylXYHzk=
Received: by 10.231.130.137 with SMTP id t9mr2589655ibs.142.1275773729072; 
	Sat, 05 Jun 2010 14:35:29 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 5 Jun 2010 14:35:29 -0700 (PDT)
In-Reply-To: <m3vd9xp3oz.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148501>

On Sat, Jun 5, 2010 at 21:29, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> This is version 8 of the series to make Git optionally translatable
>> with GNU gettext.
>>
>> Changes since version 7:
> [...]
>
>> =C2=A0 =C2=A0* Add back support (and a new test) for the no-op N_() =
macro. This
>> =C2=A0 =C2=A0 =C2=A0is used for marking translations for later use, =
e.g.:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char help[] =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 N_("See 'git help C=
OMMAND' for more information on a specific command.");
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int main(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(_(help));
>
> Shouldn't you add also corresponding N__ subroutine to Git::I18N
> module?
>
> =C2=A0# Dummy functions for string marking.
> =C2=A0sub N__($) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return shift;
> =C2=A0}

I don't really see the need. It's very useful in C because you can't
call functions outside function bodies (like in the example
above). Perl has no such restriction, so I don't see the use case.

Can you think of one? Perhaps I'm just being unimaginative.
