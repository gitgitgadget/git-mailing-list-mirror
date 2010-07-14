From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 14 Jul 2010 11:24:58 +0200
Message-ID: <201007141125.01863.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <201007140024.58446.jnareb@gmail.com> <AANLkTikyxqPHkNnVaN6kLNdbjxl69e_8Yuf1-n7CwnEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 11:25:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYyDW-0007Xn-6v
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 11:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0GNJZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 05:25:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40240 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab0GNJZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 05:25:16 -0400
Received: by bwz1 with SMTP id 1so776736bwz.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4OVyJg3NXHYRPcXo1+5vOSuGTssqVz5rOSqQnXk9ls0=;
        b=vz+pm7s1YhOGGRrHqFcCMpG2BLhThKKBzIgpi90pytm7Qs0K2MP0Dr9hoWphwKeaWg
         ltqhB71kOkMEOI5CzlnvUZUvYCa4W8AyUNegsGx+c2FYFDbg7S/qS1RU/QyndLZ3tLii
         Tm7IMRxjdYaObBcKKZTBAW3+MeIgcxSe4A3Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jMbh9mMKQc4k2Fk913Lowecw43RUFz6NjVu9yQO5Poy+YbMEUCst+SGdtUliIAHFcz
         5tYLQwiNfgPN2rwEKHA3zw6mJnQAchqUdtOSWNkXKAH2CfZTzKMp6niOxVN/PtbYopeQ
         K4fHeNkg1f5KTQlY82SSwnlKOhPsd58sRsscg=
Received: by 10.204.47.214 with SMTP id o22mr8598084bkf.17.1279099514788;
        Wed, 14 Jul 2010 02:25:14 -0700 (PDT)
Received: from [192.168.1.13] (abvb104.neoplus.adsl.tpnet.pl [83.8.199.104])
        by mx.google.com with ESMTPS id y2sm31198666bkx.8.2010.07.14.02.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Jul 2010 02:25:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikyxqPHkNnVaN6kLNdbjxl69e_8Yuf1-n7CwnEg@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150975>

On Wed, 14 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jul 13, 2010 at 22:24, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>=20
> > I wrote simple script that tests result of __DIR__ and $FindBin::Bi=
n.
> > For cgi-bin / mod_cgi it was:
> >
> > =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/cgi-bin/gitweb (sym=
link to /home/local/gitweb)
> > =C2=A0$FindBin::Bin =3D /home/local/gitweb
> >
> > For mod_perl (ModPerl::Registry handler) it was
> >
> > =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/perl/gitweb (symlin=
k to /home/local/gitweb)
> > =C2=A0$FindBin::Bin =3D /
> >
> > As you can see it's useless. =C2=A0I have't checked the FastCGI cas=
e...
>=20
> Thanks for spending time researching what was an offhand ignorant "he=
y
> wasn't .." comment. Also, sorry :)

Nothing to it.  I wanted to check if there really is a problem with=20
=46indBin on mod_perl, as I was not sure with description in "Known Iss=
ues"
section in FindBin manpage.

Note that using 'FindBin->again();' after 'use FindBin;' fixes this
issue.  So perhaps it would be beter to use FindBin than borrow code
for __DIR__ from Dir::Self.

> But that's very informative. Good to know that FindBin is broken like
> that under mod_perl.

It might be only under ModPerl::Registry, but it might be not.

--=20
Jakub Narebski
Poland
