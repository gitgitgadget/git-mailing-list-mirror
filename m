From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Automatically autoload bashcompinit for ZSH, when needed
Date: Wed, 27 Apr 2011 04:22:21 +0300
Message-ID: <BANLkTi=qzBGmp80088hVrc+yicH2ofDGEg@mail.gmail.com>
References: <7vtydkddto.fsf@alter.siamese.dyndns.org>
	<1303849690-20894-1-git-send-email-mstormo@gmail.com>
	<BANLkTindtTVcLetYs1wJ0K9BcQO7YNYpvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 03:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEtSV-0007Ei-NM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 03:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976Ab1D0BWX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 21:22:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47213 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1D0BWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 21:22:22 -0400
Received: by fxm17 with SMTP id 17so822487fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 18:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iLgJOZ9puR5zV6tqR56DkpruD2JZ13HVevH+g6Ek4+U=;
        b=KGy2OzOnAZAdK7ruh5qwS/LE/+jY/L0zMCEXSznhdxj5Z88TPsDuftVNaKLOPQpCeC
         N+rVawSs1tJ8YWz0FTEjxrRsCK70Fxa+prQihxLg5XeQjyHCcHY6+ahWRsx3bzDIueKP
         00NDPhSVuBct3bmTemLz1n9Kxcx4CqWvuC3+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VBBVF8rSqGwhK/CshXFPnjMI2chOuDoP+0optqQcZV1tJb06Lk2VPoaz0qT/wESmz3
         NpESDRVYC0s6fzrwt0XZsIcoh+gbnN+KLxz1iMZ06GPod5zny3vFZ8sgLPWiK3kXtJN5
         Um8AIGcD48M6nbyJppo9JY8DemBWs9gzhVoXc=
Received: by 10.223.87.16 with SMTP id u16mr1611078fal.13.1303867341096; Tue,
 26 Apr 2011 18:22:21 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 26 Apr 2011 18:22:21 -0700 (PDT)
In-Reply-To: <BANLkTindtTVcLetYs1wJ0K9BcQO7YNYpvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172141>

On Wed, Apr 27, 2011 at 4:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 26, 2011 at 11:28 PM, Marius Storm-Olsen
> <marius@storm-olsen.com> wrote:
>> If bashcompinit has not already been autoloaded, do so
>> automatically, as it is required to properly parse the
>> git-completion file with ZSH.
>>
>> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
>> ---
>
>> +if [[ -n ${ZSH_VERSION-} ]]; then
>> + =C2=A0 =C2=A0 =C2=A0 if ! bashcompinit >/dev/null 2>&1; then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 autoload -U bashc=
ompinit
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bashcompinit
>> + =C2=A0 =C2=A0 =C2=A0 fi
>
> How about this instead?
> autoload -UX bashcompinit && bashcompinit

Er, autoload -U +X.

--=20
=46elipe Contreras
