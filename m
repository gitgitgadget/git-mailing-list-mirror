From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 17:52:28 +0100
Message-ID: <200712051752.28667.jnareb@gmail.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com> <ADB12552-AD67-4781-B194-AD15CA4A7B44@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 17:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzxUh-0002MF-Vm
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 17:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbXLEQwn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 11:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbXLEQwm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 11:52:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:6088 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbXLEQwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 11:52:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so488641ugc
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=C/uAdY2aIqrIRScRhsL1i9yY5GJWQ7eafeAB/Fo1x6E=;
        b=LkER3xk0SoIYADw/BBFmY+KYPmYh2WGQdmNJSTXiaumRHOiqFNqMrO4s+H8Csr6vAafIAkqY0BqIi3OUZyGJzJTrDOXejIjE5AyPJhvO3u1oobGk0duSfkGtvEDJBOfNMzM5Yg4dlJ8CogHJrt0o3O9FoZ09KYBdKZAKZ8CebVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I2AuRcV+++0UfdlpNwEHOKo2RW5sPH6QopPl01uzS4mAEXUAwCfFfh9mS1Lv0DyRxlnVplRY8mBQF7I0aiuLLof93EyjhoX/3O8JbcZd/PsHn+sUE2j6djn51FyU3O4HVNDz0Dm9B2y0jKPBUwq8xZPwvGJ6w6UF57rCkGnDfaE=
Received: by 10.67.88.10 with SMTP id q10mr159287ugl.1196873555505;
        Wed, 05 Dec 2007 08:52:35 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.161])
        by mx.google.com with ESMTPS id o1sm693828uge.2007.12.05.08.52.29
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 08:52:34 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <ADB12552-AD67-4781-B194-AD15CA4A7B44@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67167>

On Wed, 5 December 2007, Wincent Colaiuta wrote:
> El 5/12/2007, a las 16:45, Jakub Narebski escribi=F3:
>=20
> > Update configure.ac (and config.mak.in) to keep up with git
> > development by adding [compile] test whether your library has
> > an old iconv(), where the second (input buffer pointer) parameter
> > is declared with type (const char **) (OLD_ICONV).
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > This patch needs checking if it correctly sets OLD_ICONV
> > when needed.  I have checked only that it is not set when
> > with new iconv() declaration.  Could people using Cygwin
> > (and other with OLD_ICONV: Darwin) test it?
>=20
> Before applying your patch:
>=20
>      CC utf8.o
> utf8.c: In function =91reencode_string=92:
> utf8.c:328: warning: passing argument 2 of =91iconv=92 from incompati=
ble =20
> pointer type
>      CC convert.o
>=20
> After applying your patch:
>=20
>      CC utf8.o
>      CC convert.o

Do I understand correctly that above is excerpt from the output of the=20
following sequence of commands before and after this patch applied?

  $ make configure
  $ ./configure [options]
  $ make

Do you have something like below in ./configure output?

  configure: CHECKS for header files
  checking for old iconv()... yes

> This on Darwin Kernel Version 9.1.0 (Mac OS X 10.5.1).

Strange... in Makefile there is

  ifeq ($(uname_S),Darwin)
	NEEDS_SSL_WITH_CRYPTO =3D YesPlease
	NEEDS_LIBICONV =3D YesPlease
	OLD_ICONV =3D UnfortunatelyYes
	NO_STRLCPY =3D YesPlease
	NO_MEMMEM =3D YesPlease
  endif

so the uname based guessing should set OLD_ICONV on Darwin...
--=20
Jakub Narebski
Poland
