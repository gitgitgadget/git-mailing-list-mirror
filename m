From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 21:02:13 +0200
Message-ID: <20090405190213.GA12929@vidovic>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:05:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXda-0002DL-5o
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbZDETCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbZDETCW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:02:22 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:33809 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964AbZDETCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:02:21 -0400
Received: by ey-out-2122.google.com with SMTP id 4so445417eyf.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GDjK91Fh9B0XlFsZ3V5R/LTyMERsYH9XiXV8yjvXL5s=;
        b=flwSFB0ayaROth0A3rIv5VZTggRF42hhLDQkGarHwFCtVakXWvZRE51tbIaQ7NOpWb
         rUvqJ6R/vmvRZY2DVdLey+1O8FfCy4Be5i7RyeHdVPG2Ze4UtNAz/VEu17GF6sakx/Un
         JQICvz9IOpH0cmkKtmF56VnU+nU689RYk2vu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=W3dspxhvfhDtbor2y+BK0e0unpv58/j9qq+fEwNd/iZW9wwUIjHlcoF3e7OYmWkLrC
         aaU2FNQe06oCIAx7QHUCLrHARMwes4Ck9351trjUqE14i+aZikm3ei6iUQKOOnGwcZNw
         VAUA46NNcFh78kDb8NcdZkV2gDbMUDq23jtLY=
Received: by 10.210.42.20 with SMTP id p20mr738861ebp.18.1238958137238;
        Sun, 05 Apr 2009 12:02:17 -0700 (PDT)
Received: from @ (83-154-175-191.rev.libertysurf.net [83.154.175.191])
        by mx.google.com with ESMTPS id 10sm5763635eyd.43.2009.04.05.12.02.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 12:02:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090405070412.GB869@curie-int>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115679>

On Sun, Apr 05, 2009 at 12:04:12AM -0700, Robin H. Johnson wrote:

> Before I answer the rest of your post, I'd like to note that the matt=
er
> of which choice between single-repo, repo-per-package, repo-per-categ=
ory
> has been flogged to death within Gentoo.
>=20
> I did not come to the Git mailing list to rehash those choices. I cam=
e
> here to find a solution to the performance problem.

I understand. I know two ways to resolve this:
- by resolving the performance problem itself,
- by changing the workflow to something more accurate and more suitable
  against the facts.

My point is that going from a centralized to a decentralized SCM
involves breacking strongly how developers and maintainers work. What
you're currently suggesting is a way to work with Git in a centralized
way. This sucks. To get the things right with Git I would avoid shared
and global repositories. Gnome is doing it this way:
http://gitorious.org/projects/gnome-svn-hooks/repos/mainline/trees/mast=
er

>          The GSoC 2009 ideas contain a potential project for caching =
the
> generated packs, which, while having value in itself, could be partia=
lly
> avoided by sending suitable pre-built packs (if they exist) without a=
ny
> repacking.

Right. It could be an option to wait and see if the GSoC gives
something.

> Also, I should note that working on the tree isn't the only reason to
> have the tree checked out. While the great majority of Gentoo users h=
ave
> their trees purely from rsync, there is nothing stopping you from usi=
ng
> a tree from CVS (anonCVS for the users, master CVS server for the
> developers).
>=20
> A quick bit of stats run show that while some developers only touch a
> few packages, there are at least 200 developers that have done a majo=
r
> change to 100 or more packages.

That's a point that has to be reconsidered. Not the fact that at least
200 developers work on over 100 packages (this is really not an issue)=B9
but the fact that they do that directly on the main repo/server. The
good way to achieve this is to send his work to the maintainer=B2. The =
main
issue is a better code reviewing.

1. Some or all repo-per-category can be tracked with a simple script.
2. Maintainers could be - or not be - the same developers as today.
Adding a layer of maintainers in charge of EAPI review (for example) up
to the packages-maintainers could help in fixing a lot of portage issue=
s
and would avoid "simple developers" to do crap on the main repo(s) that
users download.

> And per-package numbers, because we DID do an experimental conversion=
,
> last year, although the packs might not have been optimal:
> - ~410MiB of content (w/ 4kb inodes)
> - 4.7GiB of Git total overhead, with a breakdown:
>   - 1.9GiB in inode waste
>   - 2.8GiB in packs

Ok.

> > One repo per category could be a good compromise assuming one seper=
ate
> > branch per package, then.
> Other downsides to repo-per-category and repo-per-package:

Let's forget a repo-per-package.

> - Raises difficulty in adding a new package/category.=20
>   You cannot just do 'mkdir && vi ... && git add && git commit' anymo=
re.

Right, but categories are not evolving that much.

> - The name of the directory for both of the category AND the package =
are not
>   specified in the ebuild, as such, unless they are checked out to th=
e right
>   location, you will get breakage (definitely in the package name, an=
d
>   about 10% of the time with categories).

Of course. Quite franckly, it's recoverable without pain.

A repo-per-category local workflow would be:
$ git branch
  master
* next
  package_one
  package_two
  [...]
$ tree -a
|-- .git
|   |-- [...]
|   [...]
|-- package_one
|   |-- ChangeLog
|   |-- Manifest
|   |-- metadata.xml
|   |-- package_one-0.4.ebuild
|   `-- package_one-0.5.ebuild
|-- package_two
|   |-- ChangeLog
|   |-- Manifest
|   |-- files
|   |   |-- package_two.confd
|   |   `-- package_two.rc
|   |-- metadata.xml
|   `-- package_two-0.7-r3.ebuild
[...]

$ git checkout package_one
$ tree -a
|-- .git
|   |-- [...]
|   [...]
`-- package_one
    |-- ChangeLog
    |-- Manifest
    |-- metadata.xml
    |-- package_one-0.4.ebuild
    `-- package_one-0.5.ebuild
$ <hack, hack, hack>
$ git checkout next
$ git merge package_one=20

> - Does NOT present a good base for anybody wanting to branch the enti=
re
>   tree themselves.

Scriptable.

> We're already on track to drop the CVS $Header$, and thereafter, some=
 of the
> ebuilds are already on track to be smaller. Here's our prototype dev-=
perl/Sub-Name-0.04.
> =3D=3D=3D=3D
> # Copyright 1999-2009 Gentoo Foundation
> # Distributed under the terms of the GNU General Public License v2
> MODULE_AUTHOR=3DXMATH
> inherit perl-module
> DESCRIPTION=3D"(re)name a sub"
> LICENSE=3D"|| ( Artistic GPL-2 )"
> SLOT=3D"0"
> KEYWORDS=3D"~amd64 ~x86"
> IUSE=3D""
> SRC_TEST=3Ddo
> =3D=3D=3D=3D
>=20
> We can have all the CPAN packages from CPAN author XMATH, with changi=
ng
> only the DESCRIPTION string. KEYWORDS then just changes over the pack=
age
> lifespan.

Sounds good.

--=20
Nicolas Sebrecht
