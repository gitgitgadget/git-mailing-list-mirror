From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb/gitweb.perl: remove use of qw(...) as parentheses
Date: Sun, 20 Feb 2011 15:42:46 +0100
Message-ID: <201102201542.47590.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <201102191654.41601.jnareb@gmail.com> <AANLkTi==3c4ZLckUPE6NUt-sqWBsywQh3Gu+4B5vOBpj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 15:43:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrAVB-0007xi-G2
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 15:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab1BTOnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 09:43:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47213 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910Ab1BTOnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 09:43:02 -0500
Received: by fxm17 with SMTP id 17so717679fxm.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=CoOgAJv806B9chUrnye548mmJ4jhHXhq2Ypmnke0WM0=;
        b=DAB88am+OFOTBHPdB6bwmdZLxFjcs9DO/Opi3/ASvlL6zKZlxAalRQxjXDiDSAHQ6H
         BWPzrBiekBPWYOZINnCkuSqyAZjOxVw2mX3TngoiAdq+BEOpmJNum/VF9nXDN0YCLfk/
         uk9RpAy6uZqK1ptxq22gJIq2l+g058ZrmNnBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WxQOF/D5os+5aT2EiZOHGCuC0ru78KzsCaabDHQinNGc+Z1UUa7RsEWuPm4BzsEjPZ
         DTSDmW1L2lo1zX/ZgIYe+LlY5Yi9MzZzZ3mnK2QBtjljZIi7HvdfE9eIIORGGrpCTWOe
         CvcbG6BFq8RB+1yYt3jk43tuvk5kt1/zT3uRo=
Received: by 10.223.72.207 with SMTP id n15mr539314faj.49.1298212980666;
        Sun, 20 Feb 2011 06:43:00 -0800 (PST)
Received: from [192.168.1.13] (abvz77.neoplus.adsl.tpnet.pl [83.8.223.77])
        by mx.google.com with ESMTPS id 17sm1974414far.43.2011.02.20.06.42.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 06:42:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi==3c4ZLckUPE6NUt-sqWBsywQh3Gu+4B5vOBpj@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167425>

Dnia sobota 19. lutego 2011 17:06, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on napisa=C5=82:
> On Sat, Feb 19, 2011 at 16:54, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>> On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>>> Using the qw(...) construct as implicit parentheses was deprecated =
in
>>> perl 5.13.5. Change the relevant code in gitweb to not use the
>>> deprecated construct. The offending code was introduced in 3562198b=
 by
>>> Jakub Narebski.
>>
>> It is strange that Perl introduces such backwards incompatibile chan=
ge
>> (well, actually will introduce, as 5.13.x is development branch lead=
ing
>> to future Perl version 5.14).
>>
>> qw{} is described in perlop(1) as "word list" operator, so one would
>> suppose that it generates a list.
>=20
> It does, but it wasn't supposed to generate parens for you.

[...]
>> Hmmm... does it affect only foreach loop, or dows it affect also oth=
er
>> places, like
>>
>> =C2=A0 =C2=A0 =C2=A0use POSIX qw( setlocale localeconv )
>> =C2=A0 =C2=A0 =C2=A0@EXPORT =3D qw( foo bar baz );

[...]
> No. This is being deprecated because qw(foo bar) is supposed to mean
> "foo, "bar", not ("foo", "bar"). I.e. this doesn't compile:
>=20
>     for my $i "a", "b", "c" { }
>=20
> So neither should this:
>=20
>     for my $i qw(a b c) {}
>=20
> But these both work:
>=20
>     for my $i ("a", "b", "c") { }
>     for my $i (qw(a b c)) {}
>=20
> All of your other examples could have used a list without implicit
> parens. So this is the only change that's needed in gitweb.

Thanks for the explanation.  It makes sense.  So:

Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

--=20
Jakub Narebski
Poland
