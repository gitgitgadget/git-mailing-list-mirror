From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 08/13] credential: make relevance of http path configurable
Date: Sat, 10 Dec 2011 03:50:11 -0800 (PST)
Message-ID: <m3mxb0hcjs.fsf@localhost.localdomain>
References: <20111210102827.GA16460@sigill.intra.peff.net>
	<20111210103133.GH16529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 12:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZLRc-0001sM-0r
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 12:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab1LJLuP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 06:50:15 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43151 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1LJLuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2011 06:50:14 -0500
Received: by eaak14 with SMTP id k14so2117309eaa.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 03:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=X4BQ+ozYgHQu2Z/3dYrrG5BI6TpH/KRRTKKzDjcogmY=;
        b=ep1p3p3/9YLPI4LkjV2KkT2QxExyB3oBC0tzVZGR4ty4HnSz+wljwF7/uDk2K+ving
         f1qRsaLbm26nF7/orK/cTI7zLBKU9rzfq+97s3+i6Krru5yBOfEa2UaoIyvNF3PMKQCf
         CHBJ6U6I/E37TukuqjVqzgW26GLejDRGkaqsk=
Received: by 10.213.14.204 with SMTP id h12mr711444eba.21.1323517811739;
        Sat, 10 Dec 2011 03:50:11 -0800 (PST)
Received: from localhost.localdomain (abwc156.neoplus.adsl.tpnet.pl. [83.8.226.156])
        by mx.google.com with ESMTPS id f47sm11508624eea.1.2011.12.10.03.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 03:50:11 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBABnXvd001505;
	Sat, 10 Dec 2011 12:49:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBABnBQZ001501;
	Sat, 10 Dec 2011 12:49:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20111210103133.GH16529@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186762>

Jeff King <peff@peff.net> writes:

[...]
> This is nothing you couldn't do with a clever credential
> helper at the start of your stack, like:
>=20
>   [credential "http://"]
> 	helper =3D "!f() { grep -v ^path=3D ; }; f"
> 	helper =3D your_real_helper
>=20
> But doing this:
>=20
>   [credential]
> 	useHttpPath =3D false

Shouldn't this be 'usePath' or 'usePathComponent' or 'useRepositoryPath=
',
etc.?  Because if^W when remote helper for Subversion is complete, you
could have svn://svnserve.example.com/path/to/repo as an URL... which
would be not HTTP(S).=20

--=20
Jakub Nar=EAbski
