From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: [PATCH 1/3] gitweb: add extensions to highlight feature
Date: Thu, 16 Dec 2010 23:33:24 +0100
Message-ID: <1292538804.2511.4.camel@kheops>
References: <1292535801-7421-1-git-send-email-sylvain@abstraction.fr>
	 <1292535801-7421-2-git-send-email-sylvain@abstraction.fr>
	 <m3y68slxj9.fsf@localhost.localdomain>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EBxeWphdl7k9A8YXSZQa"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:33:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTMOD-0003DC-IP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256Ab0LPWd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:33:28 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58095 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0LPWd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:33:27 -0500
Received: by wwa36 with SMTP id 36so60266wwa.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 14:33:26 -0800 (PST)
Received: by 10.216.164.141 with SMTP id c13mr201955wel.113.1292538806740;
        Thu, 16 Dec 2010 14:33:26 -0800 (PST)
Received: from [192.168.0.7] (85-168-197-251.rev.numericable.fr [85.168.197.251])
        by mx.google.com with ESMTPS id f52sm326706wes.11.2010.12.16.14.33.25
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 14:33:25 -0800 (PST)
In-Reply-To: <m3y68slxj9.fsf@localhost.localdomain>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163826>


--=-EBxeWphdl7k9A8YXSZQa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-12-16 at 14:22 -0800, Jakub Narebski wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
>=20
> > added: sql, php5, phps, bash, zsh, mk
> >=20
>=20
> There is one issue with this patch (see below), but otherwise I like
> it.
>=20
> > Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
> > ---
> >  gitweb/gitweb.perl |    7 ++++---
> >  1 files changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index d521c93..db18d06 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -250,13 +250,14 @@ our %highlight_ext =3D (
> >  	# main extensions, defining name of syntax;
> >  	# see files in /usr/share/highlight/langDefs/ directory
> >  	map { $_ =3D> $_ }
> > -		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tc=
l),
> > +		qw(py c cpp rb java css php pl js tex bib xml awk bat ini spec tcl s=
ql),
>=20
> Why did you remove 'sh' =3D> 'sh' mapping?  Shouldn't it be
>=20
>   -		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tc=
l),
>   +		qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tc=
l sql),
>=20

I removed it on purpose but should have not, I was thinking
the mapping made below would be enough but no, you're right.

> >  	# alternate extensions, see /etc/highlight/filetypes.conf
> >  	'h' =3D> 'c',
> > +	map { $_ =3D> 'sh'  } qw(bash zsh),
>=20
> Good idea.

Does ksh, csh can be highlighted as sh too ?

>=20
> >  	map { $_ =3D> 'cpp' } qw(cxx c++ cc),
> > -	map { $_ =3D> 'php' } qw(php3 php4),
> > +	map { $_ =3D> 'php' } qw(php3 php4 php5 phps),
>=20
> Good idea.
>=20
> >  	map { $_ =3D> 'pl'  } qw(perl pm), # perhaps also 'cgi'
> > -	'mak' =3D> 'make',
> > +	map { $_ =3D> 'make'} qw(mak mk),
>=20
> Good idea.
>=20
> Sidenote: git itself uses *.mak extension.  Is *.mk popular?

Don't know but mk is mapped to Makefiles in the gtksourceview lib so I
added it here.

>=20
> >  	map { $_ =3D> 'xml' } qw(xhtml html htm),
> >  );
> > =20
> > --=20
> > 1.7.3.2
> >=20
>=20


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-EBxeWphdl7k9A8YXSZQa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJNCpOuAAoJECLlHVUnhaoWWCoIAJOjW01sovEiwrU0pq6HYeet
fuJqhRmOMinnaH9wG/3xF5jFnfrDeUjsJE/x8uy2BmTs/svVVtNV9W5+/KZjuVyz
2nqmunUqrGVsHIu4dNthp3Uhyf+y8tL3VzQZ8kQU+iQSiSAuJDr28c4quguubsj1
GLwFGScddjzKpTk/6eUldQfN4SmjWMLtWy078YQQ/e1dgvbF53KTZEp3Dpa9/PUL
vbHm76T7ud6x2jCtoMCVcRHmxJL48SEhzNhGVUUB7MGxfPimSCEvCoISQ3NlTrqW
sEvTRmHsoA7soKmJtsu5wxBWaegA2piia8urvPyx3kANb2iFCftW7xQjXJ18Q6s=
=j5k/
-----END PGP SIGNATURE-----

--=-EBxeWphdl7k9A8YXSZQa--
