From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] autoconf: Add test for sys/select.h header file
Date: Fri, 25 Jan 2008 13:53:04 +0100
Message-ID: <20080125125304.GO30676@schiele.dyndns.org>
References: <20080124183446.GJ30676@schiele.dyndns.org> <1201259981-7115-1-git-send-email-jnareb@gmail.com> <alpine.LSU.1.00.0801251229250.5731@racer.site>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UdiMmEj9EzJj2jSc"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 13:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIO3y-0008Rk-Os
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 13:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbYAYMxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 07:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbYAYMxM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 07:53:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:49507 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbYAYMxK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 07:53:10 -0500
Received: by ug-out-1314.google.com with SMTP id z38so502734ugc.16
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 04:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=Ms84qnJkNAwH/Cfq3mp4SFb9r/lJMfFEAEOTUhIWLIE=;
        b=c5lBdEyFtkrb2LdqWIDleQ+Y58ZtOhVqbHse5J8hTfgB3LrVaH/HDp1WiP25byI5Tu/Iae/ootOlPJtKvazz6bg6RXdKuImMxGtCIYkrVLVquvuZoCVzVdfLkOsnArFc2tJNG5rukR3K6sNn/+/2yEAoVOkgALJXisI/sSGowXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=b4x6aeIVROkq6DnYA+6VH0LvXPmGNvhqSgMWoZLF82EOqkzvwDBFS3HksCIfsTr0iTp+orVU8WKdLop9cnHMTasIR98MTCGmw65WnMXE4w0vTJaiEycbhhou3qMTV8S3hzXEHHRvmDQmxY5siOZQx8Ef5BKn1mDi/hn8snsBFxE=
Received: by 10.67.101.17 with SMTP id d17mr3509752ugm.53.1201265587028;
        Fri, 25 Jan 2008 04:53:07 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.108.130])
        by mx.google.com with ESMTPS id l12sm2081995fgb.8.2008.01.25.04.53.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 04:53:06 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 0C22B4BFE5; Fri, 25 Jan 2008 13:53:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801251229250.5731@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71705>


--UdiMmEj9EzJj2jSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2008 at 12:30:27PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 25 Jan 2008, Jakub Narebski wrote:
>=20
> > diff --git a/configure.ac b/configure.ac
> > index af177fd..85d7ef5 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -235,6 +235,12 @@ test -n "$NEEDS_SOCKET" && LIBS=3D"$LIBS -lsocket"
> >  ## Checks for header files.
> >  AC_MSG_NOTICE([CHECKS for header files])
> >  #
> > +# Define NO_SYS_SELECT_H if you don't have sys/select.h.
> > +AC_CHECK_HEADER([sys/select.h],
> > +[NO_SYS_SELECT_H=3D],
> > +[NO_SYS_SELECT_H=3DUnfortunatelyYes])
> > +AC_SUBST(NO_SYS_SELECT_H)
> > +#
>=20
> Just because I am curious: would that not define "NO_SYS_SELECT_H" in bot=
h=20
> cases?  IOW would the "ifdef NO_SYS_SELECT_H" not be triggered all the=20
> time?

No, in make the empty string is equal to not being defined.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--UdiMmEj9EzJj2jSc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHmduwxcDFxyGNGNcRAjO0AKCy1a7GCZirWma4l/Uq+KrexKDOTQCfbcW6
7c/2gS2/Hj+IB3/Xu7iOTDI=
=7men
-----END PGP SIGNATURE-----

--UdiMmEj9EzJj2jSc--
