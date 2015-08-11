From: Johannes Schauer <josch@debian.org>
Subject: bug: git-archive does not use the zip64 extension for archives with more
 than 16k entries
Date: Tue, 11 Aug 2015 12:40:56 +0200
Message-ID: <20150811104056.16465.58131@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha256"; boundary="===============0590333875916235476=="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 12:50:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP78w-0008HG-CL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 12:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934032AbbHKKut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 06:50:49 -0400
Received: from fulda116.server4you.de ([62.75.219.19]:36242 "EHLO
	fulda116.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755246AbbHKKus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 06:50:48 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2015 06:50:48 EDT
Received: from localhost (win7217.informatik.uni-wuerzburg.de [132.187.9.217])
	by mister-muffin.de (Postfix) with ESMTPSA id EA40280289
	for <git@vger.kernel.org>; Tue, 11 Aug 2015 12:40:56 +0200 (CEST)
Content-Disposition: inline
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275682>

--===============0590333875916235476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

for repositories with more than 16k files and folders, git-archive will cre=
ate
zip files which store the wrong number of entries. That is, it stores the
number of entries modulo 16k. This will break unpackers that do not include
code to support this brokenness.

Instead, git-archive should use the zip64 extension to handle more than 16k
files and folders correctly.

Thanks!

cheers, josch

--===============0590333875916235476==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVydE4AAoJEPLLpcePvYPhlV8QAJ5mAaqOTmJNvpb1hnlms9n8
1gRDKDi6zT0CYz3eJfPcuL31FNQ3u7fIsiyix2O+TEz6tzkPKSI7yCOA/B0gFDjs
Oy7srAFlpSHoTpTPfB40ANWDzCbN60YrfCjti1egnSz8qOa/VnZrHPpLQTNXE9eM
nmdZLWTylDeUjQvmfHgd8SuL4pfi2adSfo6duEgWhV5kMuQVN1SU8jVTm8vl+kbx
8KzY2bG5H+IXGC3wKXi/v6/e/1odRULS5j/4JDzfycD2+FHi4T4g0HZ9JKLsW7Jq
3y2qYA3WZddcR5rwEgiv81WP8utP1b/Hw/nRfrLUfqPKwZoIHtqwTxyMgytIprLi
HJZ7kvGjTRLMHJfXZ2N3EpE3aQBzJy5v1Pg4nSVh3GLgTvQf43vLAgoT64bpE/iz
oqoMC5fOAPJsPir4oZStXWa8tUmlKWHWP7otMsV3yv16FSW7F/9PZSPfBf2gNWMk
K+zInaDbaxSgPkU52JSc8MRhxjT5rL+p9cDv7kkMITquNkCMtjZ8F9x5yfW7uz4H
UE1qPRV5tLbizbgzkXH6HLyNCYSVPM7iSow10dZ4ZYVdgr8abnORZumCTZtus+rl
zqFvrSEal5m2UFYV/7Jw6ZA2D1MMcMjlSt57Hw8uXVhKDpEeR0QkQCVMPnRi5RBo
/o9kMU+joF8YjNYo4u9m
=ncn0
-----END PGP SIGNATURE-----

--===============0590333875916235476==--
