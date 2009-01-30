From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 04:25:43 -0800 (PST)
Message-ID: <m33af1x9od.fsf@localhost.localdomain>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
	<adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: =?iso-8859-15?q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 13:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSsTT-0006w0-Ma
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 13:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZA3MZs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 07:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751680AbZA3MZr
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 07:25:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:15618 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZA3MZr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 07:25:47 -0500
Received: by ey-out-2122.google.com with SMTP id 25so118140eya.37
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 04:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=iELGY7pYKelfsVKrsf/okeCCbogtpYe3Lht8GygmLcA=;
        b=i5AH+f7+WHN3XaeNZ1mEZvtCpXGfSTkJslm9vHzY++H9UvMkNvHBxtTQeM4xKPLAeZ
         B6LQ5SESonPbtHB8p0RzIC7E6MpR5T01nXRpBWc9xMvSMp+9y5kfofWxPbB3vBHQhDi5
         jF3+3igg8Mnzr0607TyBsaxHLfXOEWt53mrok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=bNaunE4WrsFjqV2ucPLxHH888D9WYK7ezjaO0pK0+TJFs25D0D9pA1ZPrNrA2m46Ii
         rQB6bQqOmi8IiEAZXRyiRhMLKDk23nklIWSsKpYHiAJiuP2WbsfSNcQ0sWmwcVqQzE9h
         z8Nek+WFB9+Vb58eWg3UdnAj6oV6mNzdDtBIQ=
Received: by 10.103.243.9 with SMTP id v9mr545708mur.91.1233318344937;
        Fri, 30 Jan 2009 04:25:44 -0800 (PST)
Received: from localhost.localdomain (abwh184.neoplus.adsl.tpnet.pl [83.8.231.184])
        by mx.google.com with ESMTPS id e9sm1006847muf.21.2009.01.30.04.25.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 04:25:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0UCPf18022529;
	Fri, 30 Jan 2009 13:25:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0UCPdSB022526;
	Fri, 30 Jan 2009 13:25:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107802>

Santi B=E9jar <santi@agolina.net> writes:
> 2009/1/30 Frank Li <lznuaa@gmail.com>:

> > mkdir tt3
> > cd tt3
> > git init-db
>=20
> "git init"
>=20
> > touch a.c
> > git add a.c
> > git commit -a -m "test1"
> >
> > git mv a.c b.c
> > git commit -a -m "rename"
> >
> > modify b.c
> > git commit -a -m "test2"
> >
> > git log -C -M -- b.c
> [...]
> > I can't get history before rename.
>=20
> You asked to restrict the search to the b.c path.
>=20
> You want:
>=20
> git log --follow -- b.c
>=20
> Man git-log:
>        --follow
>            Continue listing the history of a file beyond renames.

Or use

  $ git log -C -- b.c a.c

(you don't need '-M' option, as '-C' is superset of it).

Note that '--follow' works for simple histories, but (as it is quite
new invention) doesn't work yet for all cases, like for example
subtree merge or equivalent.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
