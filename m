From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sun, 29 Aug 2010 18:12:05 +0000
Message-ID: <AANLkTimn+-5Vys+jg=ryDfwdJ=WZfGwgZ+065M_=TF8r@mail.gmail.com>
References: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
	<AANLkTikHbxrmj3R1LDghVvMA1KNEdfeiXj44cq1KRN7M@mail.gmail.com>
	<20100828214641.GA5515@burratino>
	<20100828215956.GB5515@burratino>
	<alpine.BSF.2.00.1008282213420.67930@x.fncre.vasb>
	<20100828221655.GB5777@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 20:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpmPm-0007rE-Ga
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 20:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab0H2SPM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 14:15:12 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33151 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab0H2SPL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 14:15:11 -0400
Received: by iwn5 with SMTP id 5so4257666iwn.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F2t+Fs6rvv3OMR5r7AqsUVGibRpVwyx47Er2ctVhR2I=;
        b=P5N4i2MV3+aYOA5YiiZlDNYiaHdm8OVJp+ipVtfHoji5F1AvD3XF3ZfjyD9hSD0Gvo
         vByKsTlr8AtQaNF7Dvm/hno6+sB/nxca3FifuerMPntEiThrK/zVDEy+bNeYvks8TeIg
         /vNMSLifsJydXAPRPSnJz7Ain1ZG5TjVdxFsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iZCWL6AF7jE47/UkvYjxlrZwAYjHf/Vht7Tn1obOz92GJx0fIp95htZ7erlF+4r5Q3
         GA4enFtYfhI+zw3+QI/VkUWnl87qK+ASY58A1AnfA7wuKqliR7m2mbPkSaHJVm/1TqYX
         Y+vWW5oiHBv1O7/RI0m/R9eHLV8IpZTkELOTs=
Received: by 10.231.153.5 with SMTP id i5mr4189854ibw.105.1283105526006; Sun,
 29 Aug 2010 11:12:06 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 11:12:05 -0700 (PDT)
In-Reply-To: <20100828221655.GB5777@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154699>

On Sat, Aug 28, 2010 at 22:16, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> $ /lib/libc.so.6 =C2=A0|head -1
> GNU C Library (Debian EGLIBC 2.11.2-2) stable release version 2.11.2,=
 by Roland McGrath et al.
> $ cat test.c
> #include <stdio.h>
> #include <locale.h>
>
> int main(void)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int n;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0setlocale(LC_CTYPE, "");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D printf("%.11s\n", "Author: \277");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0perror("printf");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, "return value: %d\n", n);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> }
> $ make test
> cc =C2=A0 =C2=A0 test.c =C2=A0 -o test
> $ ./test
> printf: Invalid or incomplete multibyte or wide character
> return value: -1

So, my plan of attack is:

 * Add compat/printf from Free, Open or NetBSD. Maybe make
   compat/snprintf.c use that while I'm at it.
 * Use that instead of the GNU libc printf on systems that have glibc.
 * Add a configure check for that.
 * Revert 107880a
 * Get gettext goodness with LC_CTYPE

Does anyone see a problem with that? The potential issue is that
LC_CTYPE is for:

    "regular expression matching, character classification,
    conversion, case-sensitive comparison, and wide character
    functions."

So it might have unintended side-effects. But the only other
workaround I can see is to decree that all consumers of the localized
messages must have a UTF-8 locale.
