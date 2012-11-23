From: "W. Trevor King" <wking@tremily.us>
Subject: Re: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Fri, 23 Nov 2012 12:54:02 -0500
Message-ID: <20121123175402.GH2806@odin.tremily.us>
References: <20121123160301.GC14509@book.hvoigt.net>
 <20121123155521.GB14509@book.hvoigt.net>
 <20121123162329.GF2806@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=k+G3HLlWI7eRTl+h
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Nov 23 18:54:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbxSZ-0005GD-15
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 18:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab2KWRyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 12:54:24 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:55795 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab2KWRyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 12:54:23 -0500
Received: from odin.tremily.us ([unknown] [72.68.108.36])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDY00EP9CE3YO20@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 23 Nov 2012 11:54:04 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id EA48C6DB077; Fri,
 23 Nov 2012 12:54:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1353693242; bh=c8LUBCRpIeGHGQdDdJGwIpE1AkUKrYUfnEh+FEnVqNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BSQCn6NvkR4DbC5O3q+465cwSk4RSILin9J9tVvnPOldl5+M90oPpSATNZdYMpKQn
 /9qeGaW/ka7GKskN1cZ1HYICiXR4YQ1QMkooDCom3Q2OIz7P/qWSJXtepRRCp+2yEo
 qAmFTLBPa8KxAbpRDKQF05IgAYmFHHa2YjFc6ojc=
Content-disposition: inline
In-reply-to: <20121123162329.GF2806@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210269>


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 11:23:29AM -0500, W. Trevor King wrote:
> On Fri, Nov 23, 2012 at 04:55:21PM +0100, Heiko Voigt wrote:
> > On Tue, Nov 20, 2012 at 11:52:46AM -0800, Junio C Hamano wrote:
> > > "W. Trevor King" <wking@tremily.us> writes:
> > >=20
> > > > The superproject gitlink should only be updated after
> > > >
> > > >   $ git submodule update --pull
> > > >
> > > > A plain
> > > >
> > > >   $ git submodule update
> > > >
> > > > would still checkout the previously-recorded SHA, not the new upstr=
eam
> > > > tip.
> > >=20
> > > Hrm, doesn't it make the "float at the tip of a branch" mode
> > > useless, though?
> >=20
> > How about having a branch config option and reusing our
> > submodule.$name.update option for specifying whether the user wants to
> > always float to the tip of the branch?
>=20
> I'm adding "update --pull" as one of the update options in v4, which I
> am writing up as we speak ;).

On second thought, this does not seem to be a good idea.  The current
fancy update styles (--rebase, --merge) are both for cases where you
have local commits in the submodule and are trying to incorporate new
gitlinks from an updated superproject into the submodule's checked out
branch:

  superproject $ cd submod
  superproject $ git checkout next
  submod $ =E2=80=A6hack hack hack=E2=80=A6
  submod $ git commit =E2=80=A6
  submod $ cd ..
  =E2=80=A6upstream superproject changes=E2=80=A6
  superproject $ git pull
  =E2=80=A6updated SHA1 for submod gitlink=E2=80=A6
  superproject $ git submodule update --merge
  =E2=80=A6merge superproject's gitlink SHA1 into local submod branch=E2=80=
=A6

My submodule.<name>.branch option gives a local branch to
check out:

  =E2=80=A6upstream submod changes=E2=80=A6
  superproject $ git cd ssubmodule update --pull
  =E2=80=A6fetch upstream submod changes and ff-merge into local submodule.=
<name>.branch=E2=80=A6

This seems suitably distinct that bundling it with the other update
options will just add confusion.

So, let's rethink this approach.  I'm trying to pull the upstream
version of my local submod branch.  The difficulties with this are:

1. Checking out a local branch (from the default detached state)
   to do something on it requires an ungainly:

     $ git submodule foreach 'git checkout $(git config --file $toplevel/.g=
itmodules submodule.$name.branch) && =E2=80=A6'

2. The remote pulling behavior is configured in
   .git/modules/<name>/config, which is not tracked in the repository
   itself.

I'm ok with forcing local users to handle 2 manually (or implicitly),
but 1 is crazy.  Addin submodule.<name>.branch explicitly to
=2Egitmodules is a step towards fixing 1, but submod pull doesn't match
an existing submodules-implemented workflow.  Perhaps a better choice
would be to borrow the implicit-local-checkout behaviour used by
--rebase and --merge.  We could add

  $ git submodule update --branch

to checkout the gitlinked SHA1 as submodule.<name>.branch in each of
the submodules, leaving the submodules on the .gitmodules-configured
branch.  Effectively (for each submodule):

  $ git branch -f $branch $sha1
  $ git checkout $branch

Then I could use

  $ git submodule foreach 'git pull'

to update my submodule tracking branches (without further "git
submodule" restructuring).

This would help everyone that doesn't like the detached head state (me
and --rebase/--merge users).  I could avoid implementing "update
--pull", and all of the difficulty in configuring upstream merge
choices (2) would be punted to the user making local edits in
=2Egit/modules/<name>/config.

Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr7g5AAoJEEUbTsx0l5OMzq8P/ijeKwrF/Y/7+UyUGe+MG92G
4ub+VjJmrdcu7UCAF/aI1LjOdCYWf2k1wK1VoX9d4YgkW8+8XiL2A3Xc2z+Tccrm
sDi4lrLwSXpdAeKVIOuKFn+laqvkW7xHRkzC4tBn4KUuHHl++0VnV4U3W6M/gMfn
LKGOeiJ8ONAcqS/f/2GuprTaHdpwShIzW7D9X1g3J6/8l4R2qJ20anXWvgKdpCN2
+1lKgEVZLLIXNwE5yIrqnmr9ZPVOlXA5dxWpQ8BRHgsEIjgVHEpFquMu4mQwC0vt
2LYymYkbjYM+51UOVZd2mgx3xbFTokCti2YyMEVWl3nyrInTkAlzbkJr9dor4Wey
JoeqqPlI1OWKiVQ1J0yfiBuB6vUKl2A7S1dKZKhgpR65uCdzAjSxHyep9itzWt9l
ChJSIWusLu8VggIYe3rBliXIFk9kSSOn4S9/3fXL0ox6RI3XHg2vmwo7wgTG07Hx
wTF95lW3dqL0mB5nvynUHhl52prZDXy5wR8tzOMtwmVWUvEl6qH0qKIEkBJiQPe/
xO8Ls5Gi3RvJi7/cUsjrrhroSb4va64WvP+dKQD1qm6wl9w9lXwbaCE0+9OESyro
4VnFdq5azCCW/TaQ7bwGO+I2GY7QV5PjyRUDqBFQNf6Uj1JKL4zGl7oFkrQ1vu8O
w00XZDC+a5GPKjVUtWvO
=wsCh
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
