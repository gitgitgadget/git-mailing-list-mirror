From: Eric Blake <eblake@redhat.com>
Subject: git format-patch should honor notes
Date: Tue, 07 Dec 2010 14:53:09 -0700
Organization: Red Hat
Message-ID: <4CFEACC5.70005@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigF8C23594C8E68A0DA3DAB057"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 07 22:53:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ5TJ-0005pf-0P
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 22:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab0LGVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 16:53:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15349 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab0LGVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 16:53:10 -0500
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oB7LrA0p003560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Tue, 7 Dec 2010 16:53:10 -0500
Received: from [10.3.113.117] (ovpn-113-117.phx2.redhat.com [10.3.113.117])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oB7Lr9Ie007530;
	Tue, 7 Dec 2010 16:53:09 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101103 Fedora/1.0-0.33.b2pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163141>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8C23594C8E68A0DA3DAB057
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'm just starting to experiment with 'git notes', because it seems to
fit well with my workflow on several projects, except for one drawback.

My workflow is that I post patch series for upstream review via 'git
send-email'.  Often, that results in feedback that requires me to
amend/rebase my series, and post a v2 or v3 of the series.  By adding
'git config notes.rewriteRef refs/notes/commits', I can add notes that
will carry across my rebase, and remind me what I changed in v2 (for
example, git notes add -m 'v2: fix foo, per mail xyz@example.com').
This is handy for me, and I think it is also handy for reviewers -
someone who took the time to read through v1 should know what I changed
in response to their comments, and only have to focus in on commits with
changes, rather than on the entire resent series.

However, I think such review helps are informational only - that is, in
'git send-email' parlance, they belong between the '-- ' and diffstat
lines of the email, and not in the upstream commit.  After all, once my
series is finally accepted upstream, it will no longer be rebased, and
'git bisect' sees only the final version.  I see no reason for the
commit message to carry the cruft of extra information that was only
helpful during reviewing the amended series, nor any reason why upstream
should carry around my notes.

So, what I'm missing is the ability for 'git send-email' (or more
fundamentally, 'git format-patch') to be able to include contents of a
particular (set of) notes reference in each patch file it generates,
where the note falls in the informative portion of the email, and is
intentionally omitted from the upstream commit when someone else runs
'git am' on my email.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigF8C23594C8E68A0DA3DAB057
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM/qzFAAoJEKeha0olJ0NqCzIIAJvR9726i/K9vZX4z9NeR3RC
yQpjBsUoL4/FgN9b3nwgkDIw0EGdkbVm61724m7dAlqYcnidO9VnvP3LmUFbZltn
TWkehciQjFhN56Lpb+JfXY11dSOeuKAWSLTovQ/E16BwrlsfYH3XpzCRXV+h0eIr
+C6GgbUSsA7PaXQi2xdEwIFDA8OQqPdXFrMr860h0Jj3Kz43epJhPoiWgsWd7NGi
TAL08glut5XLrIb/sDmBAGzX0agIk9bxCB8p3UyLqERJiNN//t5+tCwYS9fz8SuI
sGpKTuhvCyt6hq4O74yRJYv04kRvFFnq+N2XTkJfiHAPDV0PnTWrSfXr1qJqMyI=
=nUUo
-----END PGP SIGNATURE-----

--------------enigF8C23594C8E68A0DA3DAB057--
