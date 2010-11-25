From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Thu, 25 Nov 2010 15:54:19 +0100
Message-ID: <AANLkTind1tQ2bE3O-_dz+LOa4gW1X3J28uvRg1mP7aU=@mail.gmail.com>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <AANLkTi=U=Km28W-xUM0vmRhhYCuhjSxxk5Fk_yhvjz8K@mail.gmail.com>
 <AANLkTinWtG8dp_CvoH+EWYz4d=D-N0QUiBSrCNwamROo@mail.gmail.com>
 <AANLkTim0hYKcPPaZjxjbpekhR4Ho_cOVaE=41HyJOrMZ@mail.gmail.com> <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 25 15:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdDj-0004Ow-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 15:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0KYOyl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 09:54:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63240 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0KYOyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 09:54:41 -0500
Received: by fxm13 with SMTP id 13so834448fxm.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=l9O5rneG7qQRwN53NsA50aCL8m+acqjHTDlG42RIPtA=;
        b=udCDHL8wb6ZAboV2ofk55csAYcK6lrVqJ2uUxEjjSHtj0nkSglH5jv05yEDuX/pVNu
         qpO2GQWXrQi1aNjICXYZsnDJ4NKbLCGOPvy0iRFJ+bzlZx+3qQHfsJcADmZGkc6MQQ+k
         QgXu8hvt+PB5yHCZala19oxF/N/M75cAu19YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=l6C4/jzAAY/u6D6W+u8IFRTUfZEXD6QgdxsJ4twSlBjFanQ9eabzenw39J0KsooOHH
         G4pZPbfxI++av6SVCnGrkY3C8bEB66zaehNBpfBSYUeqXKk1leS6OL6xhkv9uFNz5NZL
         R0OakaiTeMbFCn+iKAfoKYJ94IqGgZ0I6fufY=
Received: by 10.223.100.15 with SMTP id w15mr830943fan.121.1290696879535; Thu,
 25 Nov 2010 06:54:39 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 25 Nov 2010 06:54:19 -0800 (PST)
In-Reply-To: <AANLkTi=N=-e+BYM+Bjp665pN=GxK5fWSKbJ34T8Qfh77@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162133>

On Thu, Nov 25, 2010 at 1:34 PM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> On Thu, Nov 25, 2010 at 1:00 PM, =C6var Arnfj=F6r=F0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Thu, Nov 25, 2010 at 11:35, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>>> On Thu, Nov 25, 2010 at 10:45 AM, =C6var Arnfj=F6r=F0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>
>>>> Is there anything else than that (the builtin.h includes) that you
>>>> think needs work?
>>>
>>> There was an issue where setting NO_GETTEXT wasn't enough to disabl=
e
>>> internationalization. Has this been fixed?
>>
>> Do you mean the issue with eval_gettext in git-sh-i18n.sh? I fixed
>> that issue, but even under NO_GETTEXT=3DYesPlease we'll still pass
>> things through git-sh-i18n--envsubst. Since I can't just #define
>> things out under NO_GETTEXT=3DYes like I can in the C code.
>>
>> Maybe you mean something different that I'm forgetting. But IIRC tha=
t
>> was the only issue.
>>
>
> I'm talking about this:
>
> $ git diff
> diff --git a/Makefile b/Makefile
> index 8357106..0a49c2c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1124,6 +1124,7 @@ ifeq ($(uname_S),Windows)
> =A0 =A0 =A0 =A0NO_STRTOK_R =3D YesPlease
> =A0 =A0 =A0 =A0NO_FNMATCH =3D YesPlease
> =A0 =A0 =A0 =A0NO_MEMMEM =3D YesPlease
> + =A0 =A0 =A0 NO_GETTEXT =3D YesPlease
> =A0 =A0 =A0 =A0# NEEDS_LIBICONV =3D YesPlease
> =A0 =A0 =A0 =A0NO_ICONV =3D YesPlease
> =A0 =A0 =A0 =A0NO_C99_FORMAT =3D YesPlease
>

Uhm, my bad. This was in the MINGW-section. Seems this issue has been
fixed now, thanks.
