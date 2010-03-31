From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 19:43:11 +0200
Message-ID: <201003311943.13031.jnareb@gmail.com>
References: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net> <m3eij0iy5m.fsf@localhost.localdomain> <20100331151648.dbd8bd45.jan@stepien.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jan =?utf-8?q?St=C4=99pie=C5=84?=" <jan@stepien.cc>
X-From: git-owner@vger.kernel.org Wed Mar 31 19:43:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx1wx-0000kO-09
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 19:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757023Ab0CaRnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 13:43:25 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:52381 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab0CaRnY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 13:43:24 -0400
Received: by fxm27 with SMTP id 27so298026fxm.28
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=65NBD1XC4su/iFH+KDH6d0IeDUREkLmm4j2XDA8deRI=;
        b=D21rUYGD5Wn3Ook0Kaw4iBnMmTmqhoyEjLESx1r+n7/ukCsNqmkI0PmWCSlEf8as26
         k4zGjRABXcSzWAB7f2p/vo2OEuiH7vSB/65953X2sJXGwxQEA6yg+3/pxpQT+cOj3929
         eXyY7xV6ZIq32KKLWYA04YEnerqUvtt/p2Tvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wjZYWM4LwoKCZNAakE3atrc/FnqP+9/VjZ1MO9XRNNr5k8ylgWN8CEmXAsG5OK+TMh
         4gcAfaEFzKO7J5zjc10E/mWzI/FK4bUyyDHUntnkLTh5wEYwGb5OJsnwNBYE5L7cglsA
         1of4fAjNh493MXjpMfzuZmdmic8dmKO2BvoIE=
Received: by 10.223.6.27 with SMTP id 27mr2091101fax.31.1270057401425;
        Wed, 31 Mar 2010 10:43:21 -0700 (PDT)
Received: from [192.168.1.13] (abuz2.neoplus.adsl.tpnet.pl [83.8.197.2])
        by mx.google.com with ESMTPS id 13sm4975463fxm.2.2010.03.31.10.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 31 Mar 2010 10:43:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100331151648.dbd8bd45.jan@stepien.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143686>

On Wed, 31 Mar 2010, Jan St=C4=99pie=C5=84 wrote:
> On Wed, 31 Mar 2010 03:28:24 -0700 (PDT)
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:
> >=20
> > > This commit adds $show_owner_column configuration variable which =
allows
> > > to hide the project list "Owner" column if desired.
> > >
> >=20
> > This commit message is a bit lacking, in that it does not describe
> > *why* one would want to hide "Owner" column in projects list page.
> > It is not described either why "Owner" column is unique among all
> > other columns, in that it is the only column that can be hidden.
> >=20
> > Besides for completeness you might want to hide "Owner" row in proj=
ect
> > summary page.
>=20
> The reason why I think gitweb should allow hiding the "Owner" row are
> situations when its used for displaying a single person's repositorie=
s.
> In such situation repeating the owner's name in each row may be
> unnecessary in one's point of view and an option for hiding the whole
> column could be a solution.

Such description should be put in the commit message.

By the way it follows from the above descriptions that one might want
to hide (not show) "Owner" column in projects list page, because it is
repetitous and doesn't give much information, but retain "Owner" field
(row) in the projects summary page.
=20
> > > Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.=
net>
> > > ---
> > >  gitweb/gitweb.perl |    9 ++++++---
> > >  1 files changed, 6 insertions(+), 3 deletions(-)
> >=20
> > While "Gitweb config file variables" section in gitweb/README does =
not
> > need to include _all_ gitweb configuration variables, you should th=
ing
> > about it whether to include description of '$show_owner_column' (or
> > just '$show_owner') in gitweb/README, and whether to include note
> > about this variable in "Projects list file format" in this file.
>=20
> I agree with you on adding it to the "Gitweb config file variables"
> section. On the other hand, I think that mentioning it in "Projects
> list file format" isn't necessary unless '$show_owner' would affect t=
he
> way the projects list file would be parsed.

By the way, you might want to add description on *whe* one might want
to use $hide_owner / $omit_owner / $show_owner in gitweb/README, and
not only in commit message.
=20
[...]
> > BTW. if it would hide owner everywhere, you might want to skip
> > generating / reading projects owners.
> >=20
>=20
> Broadening the scope of this variable and hiding owner information al=
so
> on the project info page is more than I initially thought of, but it
> seems like a good idea. In this case I'll add skipping owner generati=
on
> to the next version of the patch.

Well, you can always leave it for later commit... but I think that
generating data one would not use is a bit wasteful.

--=20
Jakub Nar=C4=99bski
Poland
