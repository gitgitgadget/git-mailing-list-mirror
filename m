From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Sun, 30 Oct 2005 17:28:03 -0500
Message-ID: <436548F3.1030507@michonline.com>
References: <43652934.8000308@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig02B39492F55AB99ED4A8F371"
Cc: Git Mailing List <git@vger.kernel.org>, rpm-list@redhat.com
X-From: git-owner@vger.kernel.org Sun Oct 30 23:29:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWLf2-0002QE-N1
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 23:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVJ3W2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 17:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJ3W2K
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 17:28:10 -0500
Received: from mail.autoweb.net ([198.172.237.26]:62954 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932367AbVJ3W2I (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2005 17:28:08 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EWLep-0000ob-Rt; Sun, 30 Oct 2005 17:28:07 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EWLep-0003pS-00; Sun, 30 Oct 2005 17:28:07 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EWLeo-0007mx-Tu; Sun, 30 Oct 2005 17:28:06 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43652934.8000308@zytor.com>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10836>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig02B39492F55AB99ED4A8F371
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> The Subversion importer Perl script breaks RPM generation.  First of
> all, it introduces new module dependencies which don't exist in for
> example RHEL4.  The easiest way to deal with that is probably to fork
> off the subversion exporter into a separate package, but the really bad
> one is:
> 
> git-svnimport.perl:require v5.8.0; # for shell-safe open("-|",LIST)
> 
> ... which RPM thinks means that you need a Perl module called v5.8.0
> which doesn't, of course, exist.  This is arguably an rpmbuild bug, but
> it nevertheless breaks at the moment.

If you change that to the traditional statement of "require 5.008;",
does it fix things up?

--------------enig02B39492F55AB99ED4A8F371
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDZUj2fhVDhkBuUKURAiy7AKC2qCFPhGQD8YnwxU4oA9SFQlpi/ACg+hko
ea4/EsLI2MnxGfumbaZm9MM=
=dWzA
-----END PGP SIGNATURE-----

--------------enig02B39492F55AB99ED4A8F371--
