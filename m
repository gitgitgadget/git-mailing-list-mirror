From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Merge two repos with history included? (was Re: How do I..?)
Date: Tue, 23 Dec 2008 01:44:07 +0100
Message-ID: <20081223004407.GZ21154@genesis.frugalware.org>
References: <e1a4c7f60812221404k57a5e150kac74f53c784b6b4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vsi50HYs5tPfr+1I"
Cc: git@vger.kernel.org
To: Dylan Martin <dmartin@sccd.ctc.edu>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEvQE-0001Yu-77
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbYLWAoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbYLWAoN
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:44:13 -0500
Received: from virgo.iok.hu ([212.40.97.103]:57131 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbYLWAoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:44:12 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B43D658096;
	Tue, 23 Dec 2008 01:44:08 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 79F574465E;
	Tue, 23 Dec 2008 01:44:08 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 02A9111B8630; Tue, 23 Dec 2008 01:44:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e1a4c7f60812221404k57a5e150kac74f53c784b6b4a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103796>


--Vsi50HYs5tPfr+1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2008 at 02:04:06PM -0800, Dylan Martin <dmartin@sccd.ctc.ed=
u> wrote:
> I tried converting an existing SVN repo to git and then adding it to
> my main git repo using the subtree merge technique described at
> http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree=
=2Ehtml.
>  I now have the various files in my repo, but they have no history.

They have, but you are right about that - due to the nature of subtree
merge - git log <path> will show only the merge commits. (However git
blame works fine, for example.)

> I checked, and my initial SVN to git conversion does contain history.
>=20
> I'm trying to add an exising repo as a subdir of my main repo with
> history included.  Can anyone tell me how to do that?

I would try the following: Let's say you have super.git and foo.git, and
you want to merge foo.git to the subdirectory 'foo' of super.git. Then
you can do in foo.git:

mkdir foo
mv * foo
git add foo
git commit -a

Then in super.git:

git pull path/to/foo.git master

And then git log --follow should work just fine on any merged files as
well.

--Vsi50HYs5tPfr+1I
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklQNFcACgkQe81tAgORUJZGnACfVya2SWXiqgN0vIGT5hrAvbsH
XRoAoJX5g/esG+3itJGtnfpZcqvzbcg8
=ZXv2
-----END PGP SIGNATURE-----

--Vsi50HYs5tPfr+1I--
