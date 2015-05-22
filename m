From: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: fix inconsistent spelling of "packfile"
Date: Fri, 22 May 2015 08:10:15 +0200
Message-ID: <20150522061015.GA386@pks-pc.localdomain>
References: <xmqqr3qaledb.fsf@gitster.dls.corp.google.com>
 <1432193225-3502-1-git-send-email-ps@pks.im>
 <xmqqegm9lwed.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 08:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvgAl-0005qy-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 08:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbbEVGLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 02:11:03 -0400
Received: from sender1.zohomail.com ([74.201.84.153]:25950 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbbEVGLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 02:11:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; 
  b=Nuc8hWc3FsHYX8R/gXkGM8tPg+qPTrqY2nMrKvqf8NIGFm6MxixKC9uO8x1JoiIwQ6T9EYftgw/4
    VYdhQ5Y09vNmb6B1pjSHM6v99X7sTkVIxItVhTvSi6MaaLJTw8CGEUP/3rUtFhMg2PrNm0lz/dXE
    Z8R2K+qTPA5UJ2qEum0=  
Received: from localhost (x55b3ace6.dyn.telefonica.de [85.179.172.230]) by mx.zohomail.com
	with SMTPS id 14322750517711015.8429403918209; Thu, 21 May 2015 23:10:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqegm9lwed.fsf@gitster.dls.corp.google.com>
X-Zoho-Virus-Status: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269690>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 09:37:14AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Fix remaining instances where "pack-file" is used instead of
> > "packfile".
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > This patch now also fixes instances where we refer to EBNF-style
> > command line parameters, as discussed by Junio and Peff.
>=20
> Thanks.
>=20
> > diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index=
-pack.txt
> > index 7a4e055..49621da 100644
> > --- a/Documentation/git-index-pack.txt
> > +++ b/Documentation/git-index-pack.txt
> > @@ -9,9 +9,9 @@ git-index-pack - Build pack index file for an existing =
packed archive
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git index-pack' [-v] [-o <index-file>] <pack-file>
> > +'git index-pack' [-v] [-o <index-file>] <packfile>
> >  'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
> > -                 [<pack-file>]
> > +		  [<packfile>]
>=20
> Hmm.  The former is taking a concrete *.pack file on disk, and the
> latter is optionally writing the pack stream out to a *.pack file on
> disk.  If we follow "'packfile' for the concept, 'pack-file' to
> refer to a file with .pack ending" guideline, I'd think both should
> be 'pack-file'.
>=20
> 	Side note: because these invocations, especially the latter
> 	form, can take any filename, you could do:
>=20
>         	git index-pack foo.tmp && mv foo.tmp $realfilename.pack
>=20
> 	in which case the arguments may not be files whose names end
> 	with ".pack"; it is just a file that holds pack data stream,
> 	so it could be argued that "packfile" is not incorrect.  But
> 	the reason why you are doing the above is to ultimately
> 	create a *.pack file, and I'd say "pack-file" would be more
> 	correct.
>=20
> > @@ -37,11 +37,11 @@ OPTIONS
> > =20
> >  --stdin::
> >  	When this flag is provided, the pack is read from stdin
> > -	instead and a copy is then written to <pack-file>. If
>=20
> Likewise; we are writing to a *.pack file, "written to" is not
> talking about what (i.e. "packfile", the pack data stream) is
> written but what accepts and holds that data stream in the end.
>=20
> > -	<pack-file> is not specified, the pack is written to
> > +	instead and a copy is then written to <packfile>. If
> > +	<packfile> is not specified, the pack is written to
> >  	objects/pack/ directory of the current Git repository with
> >  	a default name determined from the pack content.  If
> > -	<pack-file> is not specified consider using --keep to
> > +	<packfile> is not specified consider using --keep to
> >  	prevent a race condition between this process and
> >  	'git repack'.
>=20
> All of the above talk about that same entity on the filesystem that
> receives the pack data stream.
>=20
> > diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-u=
npack-objects.txt
> > index 894d20b..07d4329 100644
> > --- a/Documentation/git-unpack-objects.txt
> > +++ b/Documentation/git-unpack-objects.txt
> > @@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archi=
ve
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git unpack-objects' [-n] [-q] [-r] [--strict] < <pack-file>
> > +'git unpack-objects' [-n] [-q] [-r] [--strict] < <packfile>
>=20
> This feeds the pack data stream to the command from its standard
> input, so would be a good change.
>=20
> 	Side note: if you have an on-disk file to feed this command
> 	from its standard input, it is more than likely that the
> 	file is a *.pack file, i.e. a "pack-file".  But in practice,
> 	the command is more often than not fed an output of another
> 	command via pipe, and it only cares about it being a pack
> 	data stream.  So in that sense, both are correct but the
> 	updated one is more correct.
>=20
> > diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
> > index 812d857..fc09c63 100644
> > --- a/Documentation/technical/pack-protocol.txt
> > +++ b/Documentation/technical/pack-protocol.txt
> > @@ -465,7 +465,7 @@ contain all the objects that the server will need t=
o complete the new
> >  references.
>=20
> All changes to this file are good.
>=20
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
> > index 68978f5..7147519 100644
> > --- a/Documentation/user-manual.txt
> > +++ b/Documentation/user-manual.txt
> > @@ -3164,7 +3164,7 @@ objects.  (Note that linkgit:git-tag[1] can also =
be used to create
> >  "lightweight tags", which are not tag objects at all, but just simple
> >  references whose names begin with `refs/tags/`).
> > =20
> > -[[pack-files]]
> > +[[packfiles]]
>=20
> Isn't this a xref target?  Can you change it without changing all
> the referrers?

I did not find any referrers pointing to this, so I just changed
it. I do not know if there are any referrers from outside, so I
guess I'll just revert that back to [[pack-files]] as it is not
seen by users anyway.

> In any case, after doing the above two side notes, I am not sure if
> readers would appreciate our careful choice of words between
> "packfile" and "pack-file" when they read the documentation.

Exactly my thought by now. While it sure is nice to have the
technically most-correct terms in use I guess the user will not
realize that we are talking about different things when referring
to "pack-files" as opposed to "packfiles". I doubt it will hurt
though as the user will certainly just skim over it without
realizing that we sometimes use one or the other, as long as they
are not used together in a single paragraph.

Patrick

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVXshFAAoJEBF8Z7aeq/EsaI0P/1NimBbaitzJ17GbEOQcqg9i
UE76H6s92tEtJELGi9IfcULcYkVeyX71cuA18+jMUoEzQRSC557LVdgExzHlExL8
PuSpizNIqzxCHwd53k5Dwl7bdVAM9qfaQjjqT3eGPRYcSRpCI4Zsi/+EV1/VvEwe
1wZUu93KlQaPQnKuMs5hmunjgK2rmmX8whogrpVNS/RwOrS1ELg89ZhVuJButFBt
J20KHmX9VJynhooyXLDxulLQXA4mc+btBAz4Ff6G6eKhdkVMtMviNVenV2DWTaeH
fem7LSKW6VnYWWC3Cr/QGNy9AXREI2Vlntnp3N469qNLDUamg7qIfz9OuU2euCkW
482ZMzG7E5GoQ0vREobA9Y80LGOxqYVNAsjBpyEHJ32SXOxWeN3lK9tG3gFJDD6/
6uujgmQ1AiJWuEW535V+Wh7t6l7W9VX+Yxtp23l03sG1rNN/UOwjdDlSNs5xBp0J
Ynbs5TLuwmmXj4j97XKgzctXjtUmTxITjmQADU7GBsPqPantmDIns2cVP//TrrOv
NfVymOsWG1mxKyUieErOg5VvwKrPcvxo4QZGz8a1A3qi7YEFNxb6htGN00b1WP/O
g7v0UaukxLe1DIRcuweVb/cdZxz0rC2XvtwLzZm0qb9JiI1pNFx2O794PPS3FpCz
DfLGDXtW1anRlYrZlvo3
=f72e
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
