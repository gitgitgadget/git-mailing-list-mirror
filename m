From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sun, 20 Mar 2011 16:42:20 +0800
Message-ID: <AANLkTim+sijuHidJNWyqC75yTFVo0YX67J3AXnPJVsoc@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
 <7vsjujq8kf.fsf@alter.siamese.dyndns.org> <AANLkTinPCeg3NU2bRvk8rwWSWnu4b0PHwya9+PWAc3DB@mail.gmail.com>
 <AANLkTinFFnm7-TKcbTdbzJHx4i4L8rdi4xogr3R7=7s1@mail.gmail.com> <vpqlj0ajkqa.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:42:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1EDo-0006ew-8h
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 09:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab1CTImn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 04:42:43 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42688 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab1CTImm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 04:42:42 -0400
Received: by yxs7 with SMTP id 7so2063643yxs.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=N3uoSKzX6+z5XRToqsHVkF9taETIhgW6BfZmIENDo1c=;
        b=YAMTbN2sIYmcOjqOiRiDYeQX1OvEtwLHpavST5BLrBQfWD7oOU06UsXrxgDr8XRozw
         RGvnMd5k8t1YOgkeZAMYfNzVJ+0FoWRRjMALUWqV/F/WwNE2cL9NqBaasxXxhhlAXJBw
         +1PnprP5XSr8M0CVoZ4GVNTcPD7KZ5COKeQ+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XZbx4OFytPl3DTOZUqnyFQZedS8WuwSXx7yy1CAOifgTfL/xhteqGlUIJM3b4+cnlz
         FAekdpKMEqywIl+ALyDmESumGFonrAd+XuWeTpx9wl8wWfrBmDAAal5SACIbYJCBcYaL
         fjeFM0psbAEfIEL4KSpcAgVMPfkxWhRx961d4=
Received: by 10.100.193.12 with SMTP id q12mr2153545anf.7.1300610560214; Sun,
 20 Mar 2011 01:42:40 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sun, 20 Mar 2011 01:42:20 -0700 (PDT)
In-Reply-To: <vpqlj0ajkqa.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169491>

Hey Matthieu,

Yes, I mean it.

The purpose of this test script is to testify that "*MINGW*|*CYGWIN*"
will match MinGW and/or Cygwin, so that it won't fall down to the next
2 cases.


On Sun, Mar 20, 2011 at 15:48, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> ryenus =E2=97=87 <ryenus@gmail.com> writes:
>
>> oops, corrected the script with the test strings in upper cases
>>
>> #!/bin/sh
>> echo $(uname -s)
>> case $(uname -s) in
>> *MINGW*|*CYGWIN*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^
> This "|" means "or" in a case statement...
>
>> =C2=A0 echo "detected MinGW/Cygwin"
>> =C2=A0 ;;
>> *MINGW*)
>
> ...so I can see no way to reach this point: if the string matches
> *MINGW*, it also matches *MINGW*|*CYGWIN*.
>
>> =C2=A0 echo "detected MinGW"
>> =C2=A0 ;;
>> *CYGWIN*)
>> =C2=A0 echo "detected Cygwin"
>> =C2=A0 ;;
>> esac
>
> But you've just showed that $(uname -s) of Cygwin did contain upper-c=
ase
> CYGWIN, which I think was the point to verify :-).
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>
