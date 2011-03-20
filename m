From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 08:35:51 +0800
Message-ID: <AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
 <7vsjujq8kf.fsf@alter.siamese.dyndns.org> <AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16cy-00014q-Qd
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab1CTAgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 20:36:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50473 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1CTAgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 20:36:11 -0400
Received: by ywj3 with SMTP id 3so2008435ywj.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=eGEihyjVIgBqFhpZpm0lZ+aNQE4Qm3+Iq+CU/3c26Jo=;
        b=e5OIU8sZie1zoxGeE/0iHBF9xcQE18pF9tPGIDxhwwMlWolK+v6fnH06hP3xan765Y
         S7278yFY4eBm8bqqRAUI7YRY8bFlm9emSWbjyEXaJs5bPwhGG6Iuog/vMdtWiK4ZCGV4
         KT0E8801TsOLxJDpI1yIU0SCD2vIZXsPEDmlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sw1IqBKCigidpvu9QswAuK8Ufc4tQTxzTvqfHvD2OBjz1tpRVK0vAdWnUgtnAt7eHr
         mDnD6s29ahgAT6R1f7SNj3t+V0GnUNJsF2cFm9J62tO8rOxDhoR2j8NpnC+FF4nq9mKW
         pYcxQVzzomYtC/r//1uXAYhD+cxpPsiSXxzfo=
Received: by 10.101.42.1 with SMTP id u1mr422729anj.51.1300581371181; Sat, 19
 Mar 2011 17:36:11 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sat, 19 Mar 2011 17:35:51 -0700 (PDT)
In-Reply-To: <AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169481>

oops, corrected the script with the test strings in upper cases

#!/bin/sh
echo $(uname -s)
case $(uname -s) in
*MINGW*|*CYGWIN*)
  echo "detected MinGW/Cygwin"
  ;;
*MINGW*)
  echo "detected MinGW"
  ;;
*CYGWIN*)
  echo "detected Cygwin"
  ;;
esac


On Sun, Mar 20, 2011 at 08:31, ryenus =E2=97=87 <ryenus@gmail.com> wrot=
e:
> I'm not sure if there's a set of tests for Cygwin/MinGW among all the
> test cases in GIT, here is a simple one:
>
> #!/bin/sh
> echo $(uname -s)
> case $(uname -s) in
> *MINGW*|*CYGWIN*)
> =C2=A0echo "detected MinGW/Cygwin"
> =C2=A0;;
> *MinGW*)
> =C2=A0echo "detected MinGW"
> =C2=A0;;
> *Cygwin*)
> =C2=A0echo "detected Cygwin"
> =C2=A0;;
> esac
>
> Run with dash, the output is
>
> CYGWIN_NT-6.1
> detected MinGW/Cygwin
>
> While I don't have MinGW, so someone has it please give it a shot.
>
> Thanks
>
> 2011/3/20 Junio C Hamano <gitster@pobox.com>:
>> ryenus =E2=97=87 <ryenus@gmail.com> writes:
>>
>>> Thank you, Duy, you're almost right, I just checked git-sh-setup.sh=
,
>>> in the bottom, sort and find are defined as functions like what you
>>> pointed out, but only for MinGW, therefore a better fix is to check
>>> for cygwin as well:
>>>
>>> ---
>>> =C2=A0git-sh-setup.sh | =C2=A0 =C2=A02 +-
>>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>>> index aa16b83..5c52ae4 100644
>>> --- a/git-sh-setup.sh
>>> +++ b/git-sh-setup.sh
>>> @@ -227,7 +227,7 @@ fi
>>>
>>> =C2=A0# Fix some commands on Windows
>>> =C2=A0case $(uname -s) in
>>> -*MINGW*)
>>> +*MINGW*|*CYGWIN*)
>>
>> This looks like a more sensible alternative than forbidding the use =
of
>> "find", privided if the new pattern is an appropriate one to catch c=
ygwin.
>>
>> I don't have any Windows boxes, so I cannot verify, but the patch sm=
ells
>> correct.
>>
>>
>>
>
