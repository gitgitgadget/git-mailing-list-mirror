From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Fri, 5 Nov 2010 14:46:32 -0700
Message-ID: <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 22:46:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEU7Q-0005lo-85
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 22:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab0KEVqj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 17:46:39 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52438 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0KEVqi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 17:46:38 -0400
Received: by pxi15 with SMTP id 15so548405pxi.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 14:46:37 -0700 (PDT)
Received: by 10.142.178.10 with SMTP id a10mr1997145wff.391.1288993597694;
        Fri, 05 Nov 2010 14:46:37 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e36sm2387015wfj.2.2010.11.05.14.46.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 14:46:36 -0700 (PDT)
In-Reply-To: <7vvd4bu2pl.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160824>

On Nov 5, 2010, at 9:58 AM, Junio C Hamano wrote:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>=20
>> Full pattern must be quoted. So 'pat"t"ern attr' will give exactly
>> 'pat"t"ern', not 'pattern'. Also clarify that leading whitespaces ar=
e
>> not part of the pattern and document comment syntax.
>>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> Obvious regression: patterns that begin with double quote will
>> now work differently.
>=20
> I'm really hesitant to pursue this route and break people's existing
> setups, especially if the only benefit this patch tries to achieve is=
 to
> allow somebody to say:
>=20
>    "Program Files/*.txt" ...some attr...
>=20
> It is not worth the effort, risk and headache, especially because peo=
ple
> with such paths are probably already using
>=20
>    Program?Files/*.txt	...some attr..
>=20
> to match them.

Would this actually break any existing setups? The only ones that are a=
ffected
are ones beginning with ", which I imagine would be rather rare. I pers=
onally
am in favor of having an unambiguous way to encode whitespace into the =
pattern.
Having to use ? has always struck me as being, well, not very good, esp=
ecially
if you have 2 files that only differ at that character (e.g. file.1 and=
 "file 1").

-Kevin Ballard