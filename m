From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Sun, 11 Jul 2010 08:55:05 +0200
Message-ID: <20100711065505.GA19606@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <20091229223123.GA12965@vidovic>
 <20091230121238.6117@nanako3.lavabit.com>
 <20100710065549.GA24296@localhost>
 <20100710214050.GA3680@burratino>
 <m3lj9jknlr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 08:56:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXqT5-0002wR-WA
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab0GKG4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:56:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36356 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab0GKG4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:56:37 -0400
Received: by eya25 with SMTP id 25so414461eya.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=dXHkyLQ0Mg6TFGGPRPMDqGdCy8rrXPsFfWLk+dQIExE=;
        b=h1b+v0A1i1V4u9fbkvt49W96TRcr+3a18c19KPEnzJ3RixDXTpYL75inRF4maf0erh
         1H3LYRP5OGJ0U8pitux+4krELuqrNJgtv5ECh16c+PlDciYqqgiWYl/3He7d6ZVf5jrf
         mx/X+F48GNUQRAUXrq5iCXtF/1m04mvU50f5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=BMAD8NHysCVRN2BUVAV/OqzHn6YbSGLvWssy2vdFl1Wet67etfpKWj+DolXS+Ka1ax
         2PqQNBirl3Y/oqQ/0us+xSLI1dkKX8TudUuEJACzBU8FNtOaJlmfZpk6XW3dMht0eG84
         P/VeD0ht8x6xzOhfU62c6bcr2sPGvUIM9Xsec=
Received: by 10.213.7.65 with SMTP id c1mr7081013ebc.76.1278831396031;
        Sat, 10 Jul 2010 23:56:36 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id x54sm24531059eeh.23.2010.07.10.23.56.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:56:34 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OXqRN-00058C-Cb; Sun, 11 Jul 2010 08:55:05 +0200
Content-Disposition: inline
In-Reply-To: <m3lj9jknlr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150762>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2010 at 02:57:35PM -0700, Jakub Narebski wrote:
>=20
> It's unfortunately not so easy.  The problem you have to solve is D/F
> conflict: if you have 'foo/bar' branch, you can't create 'foo' branch,
> but after deleting 'foo/bar' you want to be able to create 'foo'
> branch and reflog for 'foo' branch.

I'm going to read up on Jonathan's pointers. But I do not really
see the problem above. If the reflog already exists, the new branch
simpliy continues using it. So if the branch is re-created, it's as
if the branch had never been deleted.

Or possibly we add a special reflog entry which points the branch
to a zero sha to signify that the branch had been deleted.

Clemens

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMOWrFAAoJELKdZexG8uqMzsIIAIjkAF2Th/cECMxz3cjqZxMJ
jr6G9q8jRrnzaydbUjNniXMHmHUzHnw3SNPRLLvkTrkOxTKX1TeyGx5TjHTF8OJh
nFzUF56KFf4MOgleiiHIe6LncmuKl5ed+8NkVMv/1emzJ1FNK20UFiEh4/xnLDfw
p7q+w2cnCcjwyfA3ZUsFXaHruVdHt5jTvknXSZlSQLGka2oPvSBCozBzPD73LJTl
o7aHjPH5tCCvPuA1PnG9sq/BYCII/ShsIXTVDV24f2zw9oJoWMh3zSoNA586/NcT
8GN//hMAugLACJ9qjtv0KMDQ6PDajwVXiXX6l0rFzfLSqmXC79jNrONpt/6jCLw=
=Rie7
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
