From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git working tree status
Date: Sun, 26 Oct 2008 23:23:35 +0100
Message-ID: <20081026222335.GJ2273@genesis.frugalware.org>
References: <73f525b90810261454wb902edfk3a696c06ef2148d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Cc: git@vger.kernel.org
To: Mike Clarke <clarkema@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 23:24:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuE2V-0001AF-Qi
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYJZWXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYJZWXj
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:23:39 -0400
Received: from virgo.iok.hu ([193.202.89.103]:42743 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYJZWXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:23:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 23B3E580AB;
	Sun, 26 Oct 2008 23:23:36 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 03F424465E;
	Sun, 26 Oct 2008 23:23:36 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E104511901A1; Sun, 26 Oct 2008 23:23:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <73f525b90810261454wb902edfk3a696c06ef2148d1@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99191>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2008 at 09:54:03PM +0000, Mike Clarke <clarkema@gmail.com> =
wrote:
> a) fully 'clean' -- i.e., all changes checked in, no stashes;

In case you want to ignore ignores:

$ git ls-files -o

otherwise:

git ls-files -o --exclude-standard

by 'stashes', I guess you mean those extra files, but using that term is
confusing, given that stashes can be listed with git stash list and they
are actually merge commits (so something totally different).


> b) all changes checked in, but there are some stashes; or

git update-index -q --refresh
test -z "$(git diff-index --name-only HEAD --)" && echo "everything committ=
ed"

> c) 'dirty' in some way -- new files, uncommitted changes, etc.

git update-index -q --refresh
test -z "$(git diff-index --name-only HEAD --)" && echo "dirty"

see GIT-VERSION-GEN in git.git

> 1) Is there already some way of doing this that I've overlooked?
> 2) Would the preferred approach be an option (git status --is-clean)
> or a sub-command (git is-clean)?  A sub-command would probably result
> in cleaner internal code, but would also clutter the interface.

I guess you overlooked the fact that plumbing is supposed to be used
=66rom scripts and porcelain by the users. git status is porcelain, so
in general just don't use it from scripts.

> 3) Is a patch for such a feature likely to be accepted?

I don't think so, see above.

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkE7ecACgkQe81tAgORUJYytgCfXCtPdLypiRPRiIk2US9P+iHZ
U94An190j4JHj5aHPvizs0tFDs3DSIwb
=ppjR
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
