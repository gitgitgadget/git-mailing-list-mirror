From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: jn/svn-fe
Date: Fri, 13 Aug 2010 03:18:23 -0700 (PDT)
Message-ID: <m3lj8a3jfo.fsf@localhost.localdomain>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<4C63BD9B.6000608@viscovery.net> <20100813000848.GA8076@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 12:18:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjrLL-0006qc-W1
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 12:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761430Ab0HMKS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 06:18:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40636 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab0HMKSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 06:18:25 -0400
Received: by fxm13 with SMTP id 13so1512974fxm.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=N1Ipb7S1r0qQhB4mqoMl8J3tE5Ha3qeLcqhx30RHlhc=;
        b=Bc2hZ9SgweJ9pwFbV7nsRf/Yu2bUlIRx8INgGGOQ2VlzIZHolRCXrsrEDl49K+6NWh
         tahk8YMCxgNYe7Wlh3yV9ruDHcbDyrJ+wRz+NT2PgU+9z9SdoflJA1cxIAs4ab8MJro0
         6M99YqER6TuwQ0rT/ozhCprNmvFhEW4wppeEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=GDNlrPJBC5zv70b8dRVkokZjJ1EFKaqEyAdRVxuER9wqxuxoVqTTo9RiSEZlSIVSg+
         ijA4remUcavM6KuWjNks7W2XLDmzO4B5rbJcqwSsVQ21+Br3twZ1wk2VdpLIqlR1w6p2
         lWARUSxY0efRjQoZLaW6+qix8jTxOnVq+QTQY=
Received: by 10.223.119.198 with SMTP id a6mr1707154far.66.1281694704489;
        Fri, 13 Aug 2010 03:18:24 -0700 (PDT)
Received: from localhost.localdomain (abwf88.neoplus.adsl.tpnet.pl [83.8.229.88])
        by mx.google.com with ESMTPS id 16sm160051fad.2.2010.08.13.03.18.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 03:18:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7DAITR8015438;
	Fri, 13 Aug 2010 12:18:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7DAI5ok015428;
	Fri, 13 Aug 2010 12:18:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100813000848.GA8076@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153469>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about something like this instead?
>=20
> -- 8< --
> Subject: vcs-svn: Port to Windows
>=20
> MSys #define-s dirent away.  Avoid trouble by avoiding that
> identifier.
>=20
> Windows does not have strtok_r (and while does have an identical
> strtok_s, but it is not obvious how to use it).  Grab an
> implementation from glibc.
>=20
> The svn-fe test fails in the =E2=80=9Csvn export=E2=80=9D step becaus=
e of the
> lack of symlink support.  With a less ambitious dump, it passes.
>=20
> Cc: Johannes Sixt <j6t@kdbg.org>
> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Makefile              |    8 ++
>  compat/strtok_r.c     |   61 ++++++++++++++++
>  git-compat-util.h     |    5 ++
>  t/t9010-svn-fe.sh     |    4 +-
>  vcs-svn/fast_export.c |    4 +-
>  vcs-svn/repo_tree.c   |  188 ++++++++++++++++++++++++---------------=
---------
>  6 files changed, 172 insertions(+), 98 deletions(-)
>  create mode 100644 compat/strtok_r.c
>=20
> diff --git a/Makefile b/Makefile
> index c441414..444a0fe 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -68,6 +68,8 @@ all::
>  #
>  # Define NO_MKSTEMPS if you don't have mkstemps in the C library.
>  #
> +# Define NO_STRTOK_R if you don't have strtok_r in the C library.
> +#
>  # Define NO_LIBGEN_H if you don't have libgen.h.
>  #
>  # Define NEEDS_LIBGEN if your libgen needs -lgen when linking

You are missing autodetection by autoconf, i.e. changes to
config.mak.in and to configure.ac

  #
  # Define NO_STRTOK_R if you don't have strtok_r in the C library.
  GIT_CHECK_FUNC(strtok_r,
  [NO_STRTOK_R=3D],
  [NO_STRTOK_R=3DYesPlease])
  AC_SUBST(NO_STRTOK_R)

--=20
Jakub Narebski
Poland
ShadeHawk on #git
