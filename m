From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: testsuite problems
Date: Tue, 18 Sep 2007 17:52:14 +0200
Message-ID: <20070918155214.GQ19019@genesis.frugalware.org>
References: <20070917211742.GF19019@genesis.frugalware.org> <46EEF6A8.1030308@lsrfire.ath.cx> <20070917220408.GG19019@genesis.frugalware.org> <46EFE75D.7000805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zbynv6TNPa9FrOf6"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:53:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXfNH-000548-RV
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:52:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759392AbXIRPw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757865AbXIRPw0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:52:26 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50368 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759383AbXIRPwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:52:25 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXfN5-0003Gs-FZ
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 17:52:23 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 936411678012; Tue, 18 Sep 2007 17:52:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46EFE75D.7000805@lsrfire.ath.cx>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0057]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58623>


--Zbynv6TNPa9FrOf6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 04:57:33PM +0200, Ren=E9 Scharfe <rene.scharfe@lsrf=
ire.ath.cx> wrote:
> Info-ZIP zip and unzip are two different programs, each with their
> own version numbers.

ah, my bad.

> >> Also, what is the difference between t/trash/a and t/trash/d/a after
> >> running the test script (that's what test 21 is comparing)?
> >=20
> > $ diff -Naur t/trash/a t/trash/d/a
> > diff -Naur t/trash/a/l1 t/trash/d/a/l1
> > --- t/trash/a/l1        2007-09-17 23:10:03.000000000 +0200
> > +++ t/trash/d/a/l1      2007-09-17 23:10:03.000000000 +0200
> > @@ -1 +1 @@
> > -simple textfile
> > +a
> > \ No newline at end of file
>=20
> Ah!  l1 is a symlink to a.  The target of a symlink is stored as file
> content in a ZIP archive and marked with a special flag.  An unzipper
> that doesn't understand this flag would create a file containing the
> link target's name instead of a symlink pointing to the target.
>=20
> The unzip on my system says:
>=20
>   $ unzip -v
>   UnZip 5.52 of 28 February 2005, by Ubuntu. Original by Info-ZIP.
>=20
>   Latest sources and executables are at  ftp://ftp.info-zip.org/pub/infoz=
ip/ ;
>   see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.
>=20
>   Compiled with gcc 4.1.2 (Ubuntu 4.1.2-0ubuntu4) for Unix (Linux ELF) on=
 Mar 31 2007.
>=20
>   UnZip special compilation options:
>           ACORN_FTYPE_NFS
>           COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
>           SET_DIR_ATTRIB
>           TIMESTAMP
>           USE_EF_UT_TIME
>           USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
>           USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
>           VMS_TEXT_CONV
>           WILD_STOP_AT_DIR
>           [decryption, version 2.9 of 05 May 2000]
>=20
> I suspect you need SET_DIR_ATTRIB in order to extract symlinks.

$ unzip -v
UnZip 5.52 of 28 February 2005, by Info-ZIP.  Maintained by C. Spieler.
Send
bug reports using http://www.info-zip.org/zip-bug.html; see README for
details.

Latest sources and executables are at
ftp://ftp.info-zip.org/pub/infozip/ ;
see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.

Compiled with gcc 4.1.2 for Unix (Linux ELF) on May  9 2007.

UnZip special compilation options:
        ASM_CRC
        COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
        SET_DIR_ATTRIB
        TIMESTAMP
        USE_EF_UT_TIME
        USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
        USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
        VMS_TEXT_CONV
        [decryption, version 2.9 of 05 May 2000]

if i'm not wrong then these options should be ok. :S

thanks,
- VMiklos

--Zbynv6TNPa9FrOf6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7/Que81tAgORUJYRAs0WAJsGiuH7uWqXsPOJnmoWWsSwqrdZ2gCfYe15
3xmoGk8LjUycP7nGnTGOcE8=
=WnF1
-----END PGP SIGNATURE-----

--Zbynv6TNPa9FrOf6--
