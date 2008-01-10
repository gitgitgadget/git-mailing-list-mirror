From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Thu, 10 Jan 2008 12:04:54 +0100
Message-ID: <200801101204.58300.devurandom@gmx.net>
References: <200801081738.56624.devurandom@gmx.net> <200801081830.25722.devurandom@gmx.net> <20080110083846.GA15047@soma>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1741587.75l3zJGjpz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCvEj-0006NU-BT
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 12:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151AbYAJLFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 06:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbYAJLFo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 06:05:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:38533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752918AbYAJLFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 06:05:43 -0500
Received: (qmail invoked by alias); 10 Jan 2008 11:05:41 -0000
Received: from hnvr-4dbbd1d5.pool.einsundeins.de (EHLO ernie.local) [77.187.209.213]
  by mail.gmx.net (mp039) with SMTP; 10 Jan 2008 12:05:41 +0100
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX19EVEJ7aANELKJ1PqdpsLjvz0VEFtKVMLZZD+hnHj
	4A6C9CYfxmHbf3
User-Agent: KMail/1.9.7
In-Reply-To: <20080110083846.GA15047@soma>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70057>

--nextPart1741587.75l3zJGjpz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 10. Januar 2008 09:38:46 schrieb Eric Wong:
> Dennis Schridde <devurandom@gmx.net> wrote:
> > Am Dienstag, 8. Januar 2008 18:21:55 schrieb Junio C Hamano:
> > > Dennis Schridde <devurandom@gmx.net> writes:
> > > > Hello!
> > > >
> > > > I am getting "Odd number of elements in anonymous hash at
> > > > /usr/bin/git-svn line 1760." (normal output, no warning/error) duri=
ng
> > > > git-svn-clone. I am using git version 1.5.4.rc2.
> > > >
> > > > Line 1760 is this (with context, marked with '!!'):
> > > >     # see if we have it in our config, first:
> > > >     eval {
> > > >         my $section =3D "svn-remote.$self->{repo_id}";
> > > > !!        $svnsync =3D {
> > > >           url =3D> tmp_config('--get', "$section.svnsync-url"),
> > > >           uuid =3D> tmp_config('--get', "$section.svnsync-uuid"),
> > > >         }
> > > >     };
> > > >
> > > > The commandline was "git svn
> > > > clone --authors-file=3D/var/git/org.gna.warzone.git/authors
> > > > --use-svnsync-props --stdlayout file:///var/svn/warzone2100/
> > > > org.gna.warzone.git/"
> > > >
> > > > I assume this is some kind of bug?
> > >
> > > More than one svn-remote.$your_repo.svnsync-{url,uuid}?
> >
> > PS: It doesn't happen for every revision and the folders (and thus
> > config) were empty before. The config doesn't list any "svnsync-*" duri=
ng
> > the import process.
>
> Can you look in .git/svn/.metadata for the svnsync-* values?  Thanks.
>
> I downloaded your repository and couldn't reproduce it locally.
This is the file left after the segfault from the other mail:
=2D--
[svn-remote "svn"]
    reposRoot =3D file:///var/svn/warzone2100
    uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
    branches-maxRev =3D 14
    tags-maxRev =3D 14
    svnsync-uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084\n
    svnsync-url =3D http://svn.gna.org/svn/warzone
[svn-remote "tags/1.10a.12"]
    reposRoot =3D file:///var/svn/warzone2100
    uuid =3D 4a71c877-e1ca-e34f-864e-861f7616d084
=2D--

I will post the whole file asap. (I think recompiling git,svn,perl with=20
CFLAGS=3D-g and not striping the binary magically solves the problem, at le=
ast=20
it seemed to when I tried to create a backtrace.)

=2D-Dennis

--nextPart1741587.75l3zJGjpz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAkeF+9oACgkQjqfyF1DtJW7z6wCdGPbqJh7vVYVKNUp5FbLyIfDq
OG8AnjKDT5QTNQwqBfTslNUhvFsvYpcy
=tnzm
-----END PGP SIGNATURE-----

--nextPart1741587.75l3zJGjpz--
