From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Fri, 13 May 2011 11:48:25 +0200
Message-ID: <BANLkTi=QvxfUfmdYv8tmYpfHXWpaKOcFnQ@mail.gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
	<1304857280-14773-21-git-send-email-avarab@gmail.com>
	<4DCB9592.2090503@viscovery.net>
	<BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com>
	<4DCBECB5.5050502@viscovery.net>
	<BANLkTikM-FaArEA8QTy_MB9cODzwV_ER_g@mail.gmail.com>
	<BANLkTim0VZ6-xbgZC0K=HXfVMaWehJ0pBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri May 13 11:48:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKoz4-0003vH-9q
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119Ab1EMJs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 05:48:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58774 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759146Ab1EMJs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 05:48:26 -0400
Received: by fxm17 with SMTP id 17so1645174fxm.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c/RwwZjadc+7gb4SkVP7DFGZjV9DA5Kl1kFlB54rzvQ=;
        b=eYMb0w5ny3OeMCJuBzCO5L7yLNLaQ+/P7xCyTQUeRJDnSwqA+6MJjgmc1qbSu/Y4nX
         0avZkvOdXPIdqJQCnX08nLcg6D1tiCgzTr/BG7m87ipviDcZP3Yzls3fn4RMiEdcqTex
         SH7Y3f//Wbnu37ZbY+dfWSZZNhSWqrjNRXMW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aiSjtvR8mH2iVUWl0/Nv1EgP+6FEB3jUCnnM5B5WMxhbHloboGv4YyF4iS32fYlZlk
         4BHoSHgXZX6wceV5ptJdrqG6kyKE5CosqDKnNrXXAgL350PDu8m6iecX3vQMxFZqKppW
         hbJo4mxFzmoR1i6L1QxNu9TYYH4Vag/CK3qmY=
Received: by 10.223.85.196 with SMTP id p4mr1430826fal.105.1305280105456; Fri,
 13 May 2011 02:48:25 -0700 (PDT)
Received: by 10.223.105.9 with HTTP; Fri, 13 May 2011 02:48:25 -0700 (PDT)
In-Reply-To: <BANLkTim0VZ6-xbgZC0K=HXfVMaWehJ0pBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173519>

On Fri, May 13, 2011 at 11:04, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Fri, May 13, 2011 at 10:21 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
>> That's interesting. I thought that the problem would only be with
>> PATH, since we'd clobber the other environment variables when we do
>> the export in git-sh-i18n.
>>
>> But evidently not, but I don't quite grok why.
>>
>> Anyway, this behavior seems un-POSIX compliant, and I'd been assumin=
g
>> that our shell scripts were POSIX shellscripts when I wrote this.
>
> May I remind you of the first rule in Documentation/CodingGuidelines?
>
> =C2=A0- Most importantly, we never say "It's in POSIX; we'll happily
> =C2=A0 ignore your needs should your system not conform to it."
> =C2=A0 We live in the real world.

I'm not saying we shouldn't work around it, I'll submit another series
which adds some unique prefix to all the environment variables.

I was just saying that I'd assumed that at least POSIX behavior for
environment variables could be relied upon.
