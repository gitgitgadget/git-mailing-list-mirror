From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 11:26:16 +0100
Message-ID: <200902061126.18418.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902061012.42943.jnareb@gmail.com> <b77c1dce0902060149j25e76250q76c2368bd3ca5857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVNw9-0006jO-JS
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbZBFK00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 05:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZBFK00
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:26:26 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:46246 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbZBFK0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:26:25 -0500
Received: by fxm13 with SMTP id 13so1014376fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 02:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sCcv7F2U56zZzfTa3HAzQHbUeCQV4Jqr2eNX9IbY0E0=;
        b=HyAR2i3P3CgW8dmAEXnZbAQCg94WxFjYtXEWoKY9j5DdubBruYdCg9sXdez9YbPmiw
         VdmXtcqh19CFlu5wITX8wq6+I1VXCnTHsSsPQg5lGwc0by22Dh3c6PWBLlH5WW0I+0Dh
         F4pqq4vEX+L03j0UUnNgoJfllVGRvWGCIOb3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=phOFpAq8qjmAfbLN5FgzuQVm+ePt589hQgYkiJGW+YY28r76OpjMHT7kXs+qh98u2z
         N8TVDSRulgljAljF4vGKoMl6B8ar0uuJT60lUgnvvKYkUs5sEOhyPFGO0e4GX6BAbhhy
         3U+iTJPaI21nwFmaXZ1+t7YxIYhDjoHY0Us1o=
Received: by 10.103.238.4 with SMTP id p4mr655245mur.68.1233915983484;
        Fri, 06 Feb 2009 02:26:23 -0800 (PST)
Received: from ?192.168.1.13? (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id n10sm2099728mue.9.2009.02.06.02.26.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 02:26:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0902060149j25e76250q76c2368bd3ca5857@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108672>

Dnia pi=B1tek 6. lutego 2009 10:49, Rafael Garcia-Suarez napisa=B3:
> 2009/2/6 Jakub Narebski <jnareb@gmail.com>:

> > Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag)
> > to match word boundary at the beginning and the end.  This way we
> > reduce number of false matches, for example we now don't match
> > 0x74a5cd01 which is hex decimal (for example memory address),
> > but is not SHA-1.
>=20
> Further suggestion: you could also turn the final \b into (\b|\@),

You meant \b -> \b(?!\@), didn't you?  Word boundary _not_ followed
by '@', and not word boundary _OR_ '@' as you wrote...

> so it skips stuff that might look like a message-id.
> Here's an example :
> http://perl5.git.perl.org/perl.git/commit/f57255841c18e91c7a719a24006=
45e39398f3947

=46or those who do not want to open browser, it is:

Message-ID: <46A0F33545E63740BC7563DE59CA9C6D0939A0@exchsvr2.npl.ad.loc=
al>

> (We get loads of this in the Perl repository)

> > -       if ($line =3D~ m/([0-9a-fA-F]{8,40})/) {
> > +       if ($line =3D~ m/\b([0-9a-fA-F]{8,40})\b/) {

--=20
Jakub Narebski
Poland
