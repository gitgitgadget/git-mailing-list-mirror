From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: git-add says 'pathspec did not match any files' for git repository
	in /
Date: Fri, 25 Mar 2011 11:02:54 +0100
Message-ID: <20110325100254.GH30350@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vhOf6eAHdfH9MSjZ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 11:45:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q34WT-0004SI-7P
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 11:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934358Ab1CYKpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 06:45:33 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:60697 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195Ab1CYKpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 06:45:32 -0400
X-Greylist: delayed 2556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Mar 2011 06:45:32 EDT
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1Q33r4-0006fW-TV
	for git@vger.kernel.org; Fri, 25 Mar 2011 11:02:55 +0100
Received: (nullmailer pid 25635 invoked by uid 1000);
	Fri, 25 Mar 2011 10:02:54 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169979>


--vhOf6eAHdfH9MSjZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey folks,

I've been using git for keeping config files using a repository in /.
In 1.7.4.1, this seems to be broken again. Committing, diffing and
status work this time, but git add gives a pathspec did not match any
files error when adding a file while the current working directory is
not /.

This is best illustrated by an example:

root@ldap:/# git init
Initialized empty Git repository in /.git/
root@ldap:/# cd etc/
root@ldap:/etc# gt add fstab=20
bash: gt: command not found
root@ldap:/etc# git add fstab
fatal: pathspec 'fstab' did not match any files
root@ldap:/etc# ls -l fstab=20
-rw-r--r-- 1 root root 37 Mar 24 16:58 fstab
root@ldap:/etc# cd /
root@ldap:/# git add /etc/fstab
root@ldap:/etc# git --version=20
git version 1.7.4.1


All of this worked properly in 1.7.1. There was a different problem in
1.7.2, but that was fixed then (and with that fix, the above problem
didn't occur). I haven't tested 1.7.3.

I don't have time to fix this right now, so I'll be sticking to 1.7.1
for now. Perhaps someone else want to look into this.

Gr.

Matthijs

--vhOf6eAHdfH9MSjZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2MaE4ACgkQz0nQ5oovr7xCXgCfZTS7plffQ1xfcN2M9wWQpKsl
VQwAoNnfaQzMdheWwtIFFymAha3cM2DM
=TqMk
-----END PGP SIGNATURE-----

--vhOf6eAHdfH9MSjZ--
