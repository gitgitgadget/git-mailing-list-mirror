From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Mon, 30 Aug 2010 19:57:29 +0000
Message-ID: <AANLkTi=CeeBkHZgCOtACxCtWoab6Q+3Jwtx327KDFjqh@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
	<4C7BC344.9020500@workspacewhiz.com>
	<201008302040.10399.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 30 21:57:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqAU8-0007s7-Sk
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 21:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0H3T5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 15:57:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58486 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab0H3T5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 15:57:30 -0400
Received: by fxm13 with SMTP id 13so3537892fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+Z6taH3YqtGRCvLufpYeiAyeXWMfBto6vU/S2BvNoyY=;
        b=nl2ZKHH043S32Xf+kZ1yJs8tTk2QAom+19+5ZIjo6ICxU7SY54+Q7Qfy9SqBpRwb0u
         d9xa+EfQB7WD3prQdig8/vHG/mP8+LVdRUTnstv2MonM+eCqq2Et1/ejhlekhjNxzWua
         YiGHjsIGswpHjjuVDs4Hk9s1WY8uO9yrqn5tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sxOcObSUVL49kWyDw/GyOYOzOPI5aiZ9urGhNaCn4HAQInu6jsT4tKs/x8MEvvZCfQ
         11hewcsnkJ9joHvwKMlTkwFRBO956HYA7+8lUEujK/hw+w1fbdQdWAUtj8V7YxKL2zr0
         wZx3+2sndSLsYbsGZOwHGKc/xVFwUUZCbq0sM=
Received: by 10.223.115.13 with SMTP id g13mr2625376faq.41.1283198249542; Mon,
 30 Aug 2010 12:57:29 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Mon, 30 Aug 2010 12:57:29 -0700 (PDT)
In-Reply-To: <201008302040.10399.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154841>

On Mon, Aug 30, 2010 at 18:40, Johannes Sixt <j6t@kdbg.org> wrote:
> On Montag, 30. August 2010, Joshua Jensen wrote:
>> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > =C2=A0 =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 COMPAT_OBJS =3D compat/=
fnmatch/fnmatch.o
>> > =C2=A0 =C2=A0 =C2=A0+ =C2=A0 =C2=A0 =C2=A0 COMPAT_CFLAGS =3D -Icom=
pat -Icompat/fnmatch
> ...
>> You added COMPAT_OBJS
>> above, but I think there is no linker guarantee it will pick up
>> compat/fnmatch/fnmatch.o over the C runtime version?
>
> The way linkers work ensures that git code picks up the compat versio=
n when
> defined this way.

So why does e.g. compat/snprintf.c need to "#undef snprintf" before
defining it again?
