From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb not friendly to firefox revived
Date: Sat, 14 Aug 2010 14:33:33 +0200
Message-ID: <201008141433.35451.jnareb@gmail.com>
References: <20100801195138.GA1980@pengutronix.de> <4C6670EE.3060806@gmail.com> <AANLkTimR9Wkz+YOchyjvO8fgAwk5YsGtcpMOpyZY4Fjv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	"Uwe =?utf-8?q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@pengutronix.de>,
	git@vger.kernel.org, kernel@pengutronix.de
To: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 14:33:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkFv4-0001TU-Eq
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 14:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab0HNMc5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 08:32:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35725 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab0HNMc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 08:32:57 -0400
Received: by bwz3 with SMTP id 3so1660787bwz.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=okIOxi9kOcWWVneerv5DJs511M6Q39UAoPtKtyVQZcE=;
        b=PhH1rDBWbD8JTSfztS7yZRepM4njm9KtNobCXwVLS+zCQ/+oEZVb3F+Gv4wKJbh4Qg
         RfOFGJBEwDz6xmm7lIIMLZzL5/zHXojOVl+scYXSuuVNV2T+cd6uyTNWwO1fY8qceNjI
         BO1j8p5DSVjrp5ZTIiV8LwsnPKP9GDET7ZLHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hr718eiXWnHxOu3C0DrW/zrluGO6aM3t269i4/UzlAw/Vzw7n22joGXmP3mdPm3+WW
         Po6t8JGgnNAMQ7bEWXBOBLYqJ9leu+M/63qDfbK7ncZ9VNsjZCrPk+UdDked5cDUMl6x
         B/j2o1QivwpRrE7+hV0Ok4A+OQh4m5eBJEV0E=
Received: by 10.204.47.193 with SMTP id o1mr1626224bkf.134.1281789175772;
        Sat, 14 Aug 2010 05:32:55 -0700 (PDT)
Received: from [192.168.1.13] (abvh53.neoplus.adsl.tpnet.pl [83.8.205.53])
        by mx.google.com with ESMTPS id d27sm483167bku.10.2010.08.14.05.32.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 05:32:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimR9Wkz+YOchyjvO8fgAwk5YsGtcpMOpyZY4Fjv@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153556>

On Sat, 14 Aug 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2010/8/14 Stephen Boyd <bebarino@gmail.com>:
>> =C2=A0On 08/03/2010 02:50 PM, Jakub Narebski wrote:
>>>
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 my $title =3D to_utf8("Search for commits $p=
erformed by $author");
>>> + =C2=A0 =C2=A0 =C2=A0 $title =3D~ s/[[:cntrl:]]/?/g;
>>> +
>>>
>>
>> Isn't it possible that other data coming from git could have escape
>> characters in them such as the commit subject line? In which case th=
is same
>> bug would occur?
>>
>> Therefore isn't it better to strip out control characters (that's wh=
at this
>> patch is doing right?) in esc_html?
>=20
> I don't think stripping them out is the right thing either, hiding
> from you that something is Really Wrong (binary garbage in patches)
> isn't good.
>=20
> Something like this would be better:
>=20
>     s/([[:cntrl:]])/sprintf("\\%03x", ord $1)/ge

Or=20
      s|([[:cntrl:]])|quot_cec($1)|eg;

But is it worth it?  This is about _title_ attribute, shown only on=20
mouseover (mouse hover).


But perhaps it would be worth it to add 'prep_attr' and 'esc_attr'
functions, though esc_html can be used in those places where esc_attr
would be needed...

--=20
Jakub Narebski
Poland
