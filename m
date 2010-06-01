From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RCF] autoconf: Check if <libintl.h> exists and set NO_GETTEXT
Date: Tue, 1 Jun 2010 23:22:23 +0200
Message-ID: <201006012322.24899.jnareb@gmail.com>
References: <m3eigqr8hf.fsf@localhost.localdomain> <1275415908-24838-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>,
	"David M. Syzdek" <david.syzdek@acsalaska.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 23:20:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJYsr-0007lA-9y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 23:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0FAVUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 17:20:20 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63845 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab0FAVUS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 17:20:18 -0400
Received: by fxm8 with SMTP id 8so1389383fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CXgtvFDLLW48MqQ8OOUPODFrkNMPnO7h/p682cUSbbY=;
        b=BcSCGWiSSew1x6uCGOvstX2gWkpQsmh2RZpdz7IGlqOYB1GzB06L5+9tOBLk4Lj87O
         6lcUsvZlavphx+ziy/L1lDPXU5kLgqqAGdyitJVORJ6/6Do3zrog7X7mHwOIGOt7ZjSk
         vADxnKCih9zWI8CpHqfjfMNzhj6hmrZ1rVGdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TCA9b+/1EfQKp5B8YdyHH1Ex3UoK3ebGGAo0JWAaySIRCVGZDCCIbm//T1sz/v8IRw
         1iWuH4dy/6OA6EFM6ZEH0RQ3lCpjoxlvGV3NITYKKsoR6IRhwEb9sdbc0mBTrXii1LtH
         n3MZX78H1E1hJOb91I7R5m2kdsrHEhZqIRiJs=
Received: by 10.223.10.11 with SMTP id n11mr7763123fan.3.1275427215272;
        Tue, 01 Jun 2010 14:20:15 -0700 (PDT)
Received: from [192.168.1.15] (abvg224.neoplus.adsl.tpnet.pl [83.8.204.224])
        by mx.google.com with ESMTPS id y12sm48875245faj.17.2010.06.01.14.20.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 14:20:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275415908-24838-1-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148159>

On Tue, Jun 1, 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 1, 2010 at 17:01, Jakub Narebski <jnareb@gmail.com> wrote=
:
> > [...]
> > Could you also provide change to configure.ac, so that ./configure
> > would detect if we have gettext installed or not?  Thanks in advanc=
e.
>=20
> Here's a check that just checks if we have libintl.h similar to the
> existing checks for libgen.h and other headers.
>=20
> Do you think this be adequate?

I'm not sure.  If NO_GETTEXT is used only to protect '#include <libintl=
=2Eh>'
it might be enough.

>=20
>  config.mak.in |    1 +
>  configure.ac  |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/config.mak.in b/config.mak.in
> index 0d4b64d..a15f3c1 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
>  NO_EXPAT=3D@NO_EXPAT@
>  NO_LIBGEN_H=3D@NO_LIBGEN_H@
>  HAVE_PATHS_H=3D@HAVE_PATHS_H@
> +NO_GETTEXT=3D@NO_GETTEXT@
>  NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
>  NEEDS_SOCKET=3D@NEEDS_SOCKET@
>  NEEDS_RESOLV=3D@NEEDS_RESOLV@

O.K.

> diff --git a/configure.ac b/configure.ac
> index 71038fc..7bebfd8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
>  [HAVE_PATHS_H=3D])
>  AC_SUBST(HAVE_PATHS_H)
>  #
> +# Define NO_GETTEXT if you don't have libintl.h
> +AC_CHECK_HEADER([libintl.h],
> +[NO_GETTEXT=3D],
> +[NO_GETTEXT=3DYesPlease])
> +AC_SUBST(NO_GETTEXT)
> +#
>  # Define NO_STRCASESTR if you don't have strcasestr.
>  GIT_CHECK_FUNC(strcasestr,
>  [NO_STRCASESTR=3D],

The getext documentation says that `gettext.m4' defines AM_GNU_GETTEXT
macro that tests for the presence of GNU gettext function family.

The complication is that `gettext.m4' might not exist, and then
AM_GNU_GETTEXT would be not defined.  So if we are to use
AM_GNU_GETTEXT, we should I guess protect it with m4_ifdef():

  m4_ifdef([AM_GNU_GETTEXT], [AM_GNU_GETTEXT([external])])

or something like that.  And of course we need to work around the fact
that AM_GNU_GETTEXT sets USE_NLS to either 'yes' or 'no' instead of
setting setting NO_GETTEXT to either non-empty or empty value.

Or we can do something similar to what we do for NEEDS_LIBICINV /
NO_ICONV, namely make ./configure compile simple test program using
gettext.

Cc-ed Ben Walton and David M. Syzdek: perhaps they can help with this
issue.
--=20
Jakub Narebski
Poland
