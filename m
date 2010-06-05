From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v7 1/2] Add infrastructure for translating Git with 
	gettext
Date: Sat, 5 Jun 2010 03:28:04 +0000
Message-ID: <AANLkTil541q0RtZsEmnLOtUNxfltvcFCGxpxR-myhyDl@mail.gmail.com>
References: <1275704035-6552-1-git-send-email-avarab@gmail.com>
	<1275704035-6552-2-git-send-email-avarab@gmail.com>
	<20100605025702.GA2019@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 05:29:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKk4J-0006vL-Ks
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 05:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab0FED2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jun 2010 23:28:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51641 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab0FED2F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jun 2010 23:28:05 -0400
Received: by iwn37 with SMTP id 37so1708024iwn.19
        for <git@vger.kernel.org>; Fri, 04 Jun 2010 20:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WqXUW75VCYf4zF4F5A7ItKlvf5OjcJe8rsZKYRfjkWI=;
        b=dB99//JJo9X1ob2TbKd3u7shGWXMz9YVIV0EjbsnJv9EIsZ+Cc241OF2RUPrnIhzuX
         lWM337DmSTbSfHwwLDxiMfOyZ76W2QwYNIOCsxwwm2wji6P0DNSpXXnIKcTrbLP1Sks4
         mFElTq1IpNoPzO0IOrhCcNE6k5TxmNCwp/jnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rYcItrbCfp5DCYZdW+1Pu2NP/3Qce7Ebia4JBtIq8wTbTZymVYON3PkAGKGMGoNaJ8
         OK9xec6ki9cMtWK3H/iQscRLgLlEjg+M+V692d8nHpOtCyXv9nK8oe24XTYMHoSyFBJU
         PL/00C+6fkFyHNh2k9QqWMdqdN+d3J3YA/wrM=
Received: by 10.231.124.40 with SMTP id s40mr1733296ibr.172.1275708484209; 
	Fri, 04 Jun 2010 20:28:04 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 4 Jun 2010 20:28:04 -0700 (PDT)
In-Reply-To: <20100605025702.GA2019@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148453>

On Sat, Jun 5, 2010 at 02:57, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> =C2=A0const char git_usage_string[] =3D
>> =C2=A0 =C2=A0 =C2=A0 "git [--version] [--exec-path[=3DGIT_EXEC_PATH]=
] [--html-path]\n"
>> @@ -490,6 +491,8 @@ int main(int argc, const char **argv)
>> =C2=A0 =C2=A0 =C2=A0 if (!cmd)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D "git-help";
>>
>> + =C2=A0 =C2=A0 git_setup_gettext();
>> +
>
> This handles builtins. =C2=A0=E2=80=98grep PROGRAM_OBJS Makefile=E2=80=
=99 reveals nine
> other source files with their own main() functions.

Thanks. I spotted those, but I thought they could be skipped for now.

They're mostly guts, but I guess imap-send should be translated.

I can add git_setup_gettext() to them as well if that's wanted. Or I
could just do so during some future commit when they actually get
translated.
