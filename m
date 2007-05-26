From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] Add git-submodule command
Date: Sat, 26 May 2007 16:37:56 +0200
Message-ID: <200705261638.00302.simon@lst.de>
References: <7v1wh4ped4.fsf@assigned-by-dhcp.cox.net> <11801878003599-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4882629.roqfmROgeE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 16:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrxOk-0007oJ-RD
	for gcvg-git@gmane.org; Sat, 26 May 2007 16:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbXEZOh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 10:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754192AbXEZOh3
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 10:37:29 -0400
Received: from verein.lst.de ([213.95.11.210]:35391 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594AbXEZOh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 10:37:28 -0400
Received: from luria.local (157.80-203-65.nextgentel.com [80.203.65.157])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l4QEbP6a002905
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Sat, 26 May 2007 16:37:25 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <11801878003599-git-send-email-hjemli@gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48473>

--nextPart4882629.roqfmROgeE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 26 May 2007 15:56:40 Lars Hjemli wrote:
[...]
> +modules_init()
> +{
> +	git ls-files --stage -- "$@" | grep -e '^160000 ' |
> +	while read mode sha1 stage path
> +	do
> +		# Skip submodule paths that already contain a .git directory.
> +		# This will also trigger if $path is a symlink to a git
> +		# repository
> +		test -d "$path"/.git && continue
> +
> +		# If there already is a directory at the submodule path,
> +		# expect it to be empty (since that is the default checkout
> +		# action) and try to remove it.
> +		# Note: if $path is a symlink to a directory the test will
> +		# succeed but the rmdir will fail. We might want to fix this.
> +		if test -d "$path"
> +		then
> +			rmdir "$path" 2>/dev/null ||
> +			die "Directory '$path' exist, but is neither empty "
> +			    "nor a git repository"
> +		fi
> +
> +		test -e "$path"
> +		die "A file already exist at path '$path'"

Isn't there a && missing at the end of the test line? :)


Simon

--nextPart4882629.roqfmROgeE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGWEZIWXvMThJCpvIRAvwKAKCrdAPbBcty1Tf+nL37e9goW4sYGgCgzNJO
WbKyi0iC/AFaCSKP0ARbOE4=
=8tXB
-----END PGP SIGNATURE-----

--nextPart4882629.roqfmROgeE--
