From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 01/17] Makefile: A variable for options used by
 xgettext(1) calls
Date: Tue, 31 Aug 2010 16:36:16 +0000
Message-ID: <AANLkTim6fjMKcULn08G0NqWRhoRRv_J63KtARq6G5ZbG@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-2-git-send-email-avarab@gmail.com>
	<20100831145158.GD2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTot-00020T-Av
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856Ab0HaQgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 12:36:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60195 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab0HaQgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 12:36:17 -0400
Received: by pxi10 with SMTP id 10so2516228pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U/t/zBDl/03eobuFyEMTGmVzEwG3ZodkBZWR5yq33po=;
        b=rPxfpC976VoqkB9XWjhcOp0GCLr/ArOOMolHf0muzA/vcFTn7gNMESo5RiJSOkYRmH
         Rrw3W/YeHonjExkmlsZaMTY/OPvnxHprrnmqNviFQPa9g3m+fRkrGRbQqUa8xCBr6dMy
         w9BKL2W+uH65Ob3OlBh8JoSwvoZ/rnoDWsY00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DTeVDKs9GflokO1Ga8EU7cLHm5CiGUm1FVnM0Yy6Z6cNO0yLP8JG2tBVkQ0U6YS3c+
         cLOnFb6D7tfYSnFY7WFlkrZH4xxVYv17nLTr/9r9sDrYPSvHb67+a+u9RDCB+O8HR6ST
         HBjS2Lf5geE/z698pZrSQxNSkZSA8kjKDVX2Y=
Received: by 10.142.217.17 with SMTP id p17mr787879wfg.301.1283272576652; Tue,
 31 Aug 2010 09:36:16 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 09:36:16 -0700 (PDT)
In-Reply-To: <20100831145158.GD2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154935>

On Tue, Aug 31, 2010 at 14:51, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> +++ b/Makefile
>> @@ -2008,10 +2008,11 @@ cscope:
>> =C2=A0 =C2=A0 =C2=A0 $(RM) cscope*
>> =C2=A0 =C2=A0 =C2=A0 $(FIND) . -name '*.[hcS]' -print | xargs cscope=
 -b
>>
>> +XGETTEXT_OPTIONS =3D --add-comments
>> =C2=A0pot:
>> - =C2=A0 =C2=A0 $(XGETTEXT) --add-comments --keyword=3D_ --keyword=3D=
N_ --output=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
>> - =C2=A0 =C2=A0 $(XGETTEXT) --add-comments --join-existing --output=3D=
po/git.pot --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
>> - =C2=A0 =C2=A0 $(XGETTEXT) --add-comments --join-existing --keyword=
=3D__ --output=3Dpo/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/te=
st.perl
>> + =C2=A0 =C2=A0 $(XGETTEXT) $(XGETTEXT_OPTIONS) --keyword=3D_ --keyw=
ord=3DN_ --output=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/te=
st.c
>> + =C2=A0 =C2=A0 $(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --ou=
tput=3Dpo/git.pot --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
>> + =C2=A0 =C2=A0 $(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --ke=
yword=3D__ --output=3Dpo/git.pot --language=3DPerl $(SCRIPT_PERL) t/t02=
00/test.perl
>
> The long lines are a bit scary. :)
>
> Maybe more of it could be pulled out into variables. =C2=A0As a
> side-effect, users could override some settings from the command line=
=2E
> Maybe something like this?
>
> =C2=A0LOCALIZED_C =3D $(C_OBJ:o=3Dc) t/t0200/test.c
> =C2=A0LOCALIZED_SH =3D $(SCRIPT_SH) t/t0200/test.sh
> =C2=A0LOCALIZED_PERL =3D $(SCRIPT_PERL) t/t0200/test.perl
>
> =C2=A0XGETTEXT_OPTIONS =3D --add-comments
> =C2=A0XGETTEXT_OPTIONS_C =3D $(XGETTEXT_OPTIONS) -k_ -kN_ -LC
> =C2=A0XGETTEXT_OPTIONS_SH =3D $(XGETTEXT_OPTIONS) -LShell
> =C2=A0XGETTEXT_OPTIONS_PERL =3D $(XGETTEXT_OPTIONS) -k__ -LPerl
>
> =C2=A0po/git.pot:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f $@+
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(XGETTEXT) -o$@+ $(XGETTEXT_OPTIONS_C) $(=
LOCALIZED_C)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(XGETTEXT) -j -o$@+ $(XGETTEXT_OPTIONS_SH=
) $(LOCALIZED_SH)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(XGETTEXT) -j -o$@+ $(XGETTEXT_OPTIONS_PE=
RL) $(LOCALIZED_PERL)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mv $@+ $@

Thanks. I worked that into v2.
