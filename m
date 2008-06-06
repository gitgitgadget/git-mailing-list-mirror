From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Multiple user questions
Date: Sat, 7 Jun 2008 00:15:29 +0200
Message-ID: <200806070015.29709.devurandom@gmx.net>
References: <200806062247.42074.devurandom@gmx.net> <fa67IkKd22OcyCOfHZx_EORkS5DPZLP5IEWlE3dg-pOOdKgeIL0hpA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1486972.8Rq8S393BG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kim-0001MW-Ur
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268AbYFFWqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 18:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755966AbYFFWqX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:46:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:33866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754305AbYFFWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 18:46:21 -0400
Received: (qmail invoked by alias); 06 Jun 2008 22:46:19 -0000
Received: from hnvr-4dbbcf4f.pool.einsundeins.de (EHLO ernie.local) [77.187.207.79]
  by mail.gmx.net (mp063) with SMTP; 07 Jun 2008 00:46:19 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX1+pgec/lvupTS9aLECoz/wdtH0Fs01kuvDgkYPLBj
	JuURqQ8PpNqtTx
User-Agent: KMail/1.9.9
In-Reply-To: <fa67IkKd22OcyCOfHZx_EORkS5DPZLP5IEWlE3dg-pOOdKgeIL0hpA@cipher.nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84128>

--nextPart1486972.8Rq8S393BG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 6. Juni 2008 23:19:49 schrieben Sie:
> Dennis Schridde wrote:
> > I just ran into a lost stash again and thus would like to get an answer
> > to this question, which was forgotten last time:
> > (lost-found is really growing in a pace it will take me very long to fi=
nd
> > my lost stash.)
>
> How did you lose it?
>
> If you did 'git stash drop' and then realized that you dropped the wrong
> stash, you can apply that stash and then recreate it since 'stash drop'
> also prints out the sha1 and 'stash apply' can use that.
>
> For example:
>
>    # edit edit edit
>    $ git stash
>    # hmm I don't need that old stash anymore
>    $ git stash drop
>    Dropped refs/stash@{0} (5dcea62df980fa157e7755f82125dfc3bbd52ff5)
>    # whoops I didn't mean to drop _that_ stash
>    $ git stash apply 5dcea62df980fa157e7755f82125dfc3bbd52ff5
>    $ git stash
>
> Of course, that only works if you realize pretty quickly that you dropped
> the wrong stash. Also realize my example was rather simplified and the
> working directory may need to be prepped before reapplying the dropped
> stash.
It was indeed too late. (I assumed to have rerecorded the stash, but later=
=20
realised that the new stash contained only parts of the changes.)

I am now using this script:
for commit in $(git fsck --full --lost-found | grep commit | awk '{print=20
$3}') ; do
        git show ${commit} | head -n7 | \
                grep "On ${branch}:" | grep "${message}" > /dev/null \
                && git show ${commit} | head -n7
done

Though that list grows pretty long, so I would like to cut down the output =
of=20
fsck-lost-found after I am sure nothing worthy is "lost" anymore.

=2D-Dennis

--nextPart1486972.8Rq8S393BG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhJtwEACgkQjqfyF1DtJW7h9wCgoQ7d2147T+fLjUzSgdnpCFZf
cY8Anj+HU8zVGtVo4iuc2EcVWlm9rEVR
=M3Ny
-----END PGP SIGNATURE-----

--nextPart1486972.8Rq8S393BG--
