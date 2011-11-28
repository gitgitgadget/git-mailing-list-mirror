From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: 404 links on some blob pages
Date: Mon, 28 Nov 2011 18:24:53 +0100
Message-ID: <201111281824.53338.jnareb@gmail.com>
References: <CAKD0UuxBO_Uj4dHr9g3zryO=03_ds0omFFnGY89_MPJGfxLZMA@mail.gmail.com> <m3y5v1kwwm.fsf@localhost.localdomain> <CAKD0Uuyom0chUGfsh+oBRw8NoH4XutbmkVVKoQon6YO2V5oWkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Mon Nov 28 18:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV4wx-0000fb-6c
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 18:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab1K1RY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 12:24:58 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41409 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab1K1RY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 12:24:57 -0500
Received: by bke11 with SMTP id 11so8799710bke.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 09:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=bxjiT3y6dMfWvBX/QAmhP0Ceyi14yyn6iCpfy5UQa38=;
        b=nXt84pj66XP9ru/CtLRF6S+B1qJL2FK01y2mhT/W2D73TSM/gEWwNctH+gHOliKEx1
         gyQZHrj3R9QtcTEoACNzTZ3Rxm9jUGvQJeKgmH1wy6HzP2V51Eg+g/0gsXaS+/a2J8FI
         r0CRQ1hh3QinV6y3m15mTpvo3dv5eoBVMl/O4=
Received: by 10.204.157.151 with SMTP id b23mr46757410bkx.30.1322501096553;
        Mon, 28 Nov 2011 09:24:56 -0800 (PST)
Received: from [192.168.1.13] (abwn156.neoplus.adsl.tpnet.pl. [83.8.237.156])
        by mx.google.com with ESMTPS id hw14sm18008878bkc.16.2011.11.28.09.24.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Nov 2011 09:24:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAKD0Uuyom0chUGfsh+oBRw8NoH4XutbmkVVKoQon6YO2V5oWkA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186022>

J=C3=BCrgen Kreileder wrote:
> 2011/11/27 Jakub Narebski <jnareb@gmail.com>:
> > J=C3=BCrgen Kreileder <jk@blackdown.de> writes:
> >
> > > some blob pages have broken links:
> > >
> > > For example, on
> > > https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob;f=3DClass=
es/WindowController.m;h=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690a;hb=3D=
b84d1882cb6c3a2d2058cbdd56b2280b48f1690a
> > > the blob_plain link for WindowController.m leads to '404 - Cannot=
 find file':
> > > https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob_plain;f=3D=
Classes/WindowController.m;hb=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690=
a
> >
> > That is strange. =C2=A0The check is the same for 'blob' and 'blob_p=
lain'
> > action...
>=20
> The problem is the missing hash (h) parameter for the latter URL.
> Adding it to the blob_plain link makes it work.  Just as removing it
> from the blob link breaks that one as well.

Strange.  From the look of the page it looks like the 'hb' ("hash_base"=
)
parameter that should lead to the commit from which we get the file is
bogus.

But the "raw" link uses=20

  href(action=3D>"blob_plain", -replay=3D>1)

which means that if 'blob' has "h" set correctly, then 'blob_plain'
should too.

> Adding h=3D... to the tree link doesn't fix that case, though.

Of course it doesn't if you just copy _blob_ hash as _tree_ hash... :-P
(i.e. if you just copy "h" parameter from 'blob' URL).

--=20
Jakub Narebski
Poland
