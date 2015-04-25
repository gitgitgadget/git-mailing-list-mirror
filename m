From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Cleaning projects with submodules
Date: Sat, 25 Apr 2015 23:36:25 +0200
Message-ID: <553C08D9.9000907@hogyros.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EhJfX3UqPbV7N2b5WEmSqiSUL5BxoROxo"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 23:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym7tA-0007v9-8t
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 23:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbbDYVpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 17:45:23 -0400
Received: from psionic.psi5.com ([212.83.56.200]:33217 "EHLO psionic.psi5.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbDYVpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 17:45:22 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Apr 2015 17:45:22 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by psionic.psi5.com (Postfix) with ESMTP id 876A7AC0F73
	for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:36:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at psi5.com
Received: from psionic.psi5.com ([127.0.0.1])
	by localhost (psionic.psi5.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HSyW5idDx49w for <git@vger.kernel.org>;
	Sat, 25 Apr 2015 23:36:34 +0200 (CEST)
Received: from [192.168.0.132] (mango.hogyros.de [83.236.216.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client CN "Simon Richter", Issuer "CA Cert Signing Authority" (not verified))
	by psionic.psi5.com (Postfix) with ESMTPS id 759E9AC011E
	for <git@vger.kernel.org>; Sat, 25 Apr 2015 23:36:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267803>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EhJfX3UqPbV7N2b5WEmSqiSUL5BxoROxo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to set up a continuous integration build for Boost, which
uses massive amounts of submodules, and keep running into problems when
running "git clean" in the toplevel project.

When I switch to a version where a submodule has been removed (e.g. an
earlier version), "git clean -dx" will not remove the submodule's
directory, because it has its own .git directory. Using a single -f
flag, the process fails (because directories containing .git directories
are no longer skipped), and using -ff removes all submodules (which is
overkill).

Is there a good way to clean a project, leaving valid submodules in
place (these are then switched to the new tip and cleaned in separate
commands) while removing submodules that are no longer referenced?

   Simon


--EhJfX3UqPbV7N2b5WEmSqiSUL5BxoROxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJVPAjaAAoJEH69OHuwmQgRuKUH/1b6cvvXQdXnqNYyuHAyNZwy
MhBqvBDnlIoTCYkSpLB2NgO9V5P4zHYwgH0xYynJoX6IwLW2hJNQUlbAbD+RH1sl
R8gl74Q4oWr/1E+Sq4w7pxqotCZ8rL8EjGMf3c0dPlZzX/7j9R1askYqPG0lbEVs
mOy+kKdYDw4uSVnBOo/pHWqxNMVB+3shakxbZmQk0eKl21nsPR8R4Eivp6olQkPx
hs++XUKEBYZj4NeUMC6tCht/XSYBO7vmLZ6VE0gC2otvYq6pupoRmTYU0qobJxiu
zH58bPoQodgp1AZuoJwxfA7iwZJXuMrvoz4v0Yn7/a0OZObc3ffb8Siqx1ZAkMM=
=eaZf
-----END PGP SIGNATURE-----

--EhJfX3UqPbV7N2b5WEmSqiSUL5BxoROxo--
