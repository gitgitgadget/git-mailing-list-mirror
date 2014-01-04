From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH] submodule: Respect reqested branch on all clones
Date: Sat, 4 Jan 2014 14:54:01 -0800
Message-ID: <20140104225401.GA3156@odin.tremily.us>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
 <dad947caba9e1c49d691ffccc868cfdce7d04e82.1388772192.git.wking@tremily.us>
 <20140104220915.GA5697@book-mint>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Git <git@vger.kernel.org>, Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jan 04 23:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vza6e-0005eC-N4
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 23:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087AbaADWyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 17:54:08 -0500
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:55703
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754545AbaADWyG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jan 2014 17:54:06 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id 9ygQ1n0040xGWP859yu5jg; Sat, 04 Jan 2014 22:54:05 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id 9yu31n00N152l3L3Yyu4qD; Sat, 04 Jan 2014 22:54:05 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 8E1F0E78004; Sat,  4 Jan 2014 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1388876041; bh=B74LBqS4eTPZBcmCDw1WF4pw+dRc3Z47o7uxHcCbjqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g014y3LvLy3FEIyhNODTNKCvroXu04UUVXH5ymdhbBF2YzQn5bCONdpVEeN+1qXeP
	 46zVC/e+peQBXDZq9+OUbS+WGJ0v3ln5iFHnnBnzttL75fMleVX0F8tWTQGwzoxwHc
	 TOQM/Ugu1Q2xGVh+aRlhlRdWJbcfk4y/rUU2ElTc=
Content-Disposition: inline
In-Reply-To: <20140104220915.GA5697@book-mint>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1388876045;
	bh=vpwXwMToaWwnWutE8s/DOnBYj1c4nun2vfJ/wGck3pI=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=AtiGeR/HPBSNqabdqgqNGT5wiG0geQX5Zpe8WmyEt0ltsX0wGN8O+0RR23GT1IhtB
	 Lfr67e390x/dvqGO/W5madBldz6hu3qb54clNNlMbmWyk4ff3R0hD4xaoQJte8ckMN
	 MKwaP+La4itgxJ6HQ45uSJxSiMs5DrnTKdhFEdxW8y57ANhXn0GIZMW0H9mSO0W5hJ
	 3/TdTYokG3wMnK5wRjpz96F/Yl5jzLAB3n+jlWALenN6qD/eXkttaZ4Q/pSO9UzFMM
	 YLsTChRSUxsuNVys1oe4MAUI4v79j4o6RTor3TbxAIOq0Mywy7gd37Rgan+gU/oNdQ
	 bDtgA7fF+YM3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239950>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2014 at 11:09:15PM +0100, Heiko Voigt wrote:
> On Fri, Jan 03, 2014 at 10:06:11AM -0800, W. Trevor King wrote:
> > @@ -306,7 +307,14 @@ module_clone()
> >  	echo "gitdir: $rel/$a" >"$sm_path/.git"
> > =20
> >  	rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
> > -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config c=
ore.worktree "$rel/$b")
>=20
> Why should this line be removed? Is it not needed for correct
> worktree <-> repo linking of submodules?
>=20
> > +	(
> > +		clear_local_git_env
> > +		cd "$sm_path" &&
> > +		GIT_WORK_TREE=3D. git config core.worktree "$rel/$b" &&
> > +		if test -n "$branch"; then
> > +			git checkout -f -q -B "$branch" "origin/$branch" && echo "checked o=
ut $branch"
> > +		fi
> > +	) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path=
'")"
> >  }

It's not removed, just merged with the branch manipulation that also
happens in a clean local environment in $sm_path.  Spawning two
sequential subshells with the same setup seemed like overkill.

> > @@ -861,7 +860,12 @@ Maybe you want to use 'update --init'?")"
> >  			case ";$cloned_modules;" in
> >  			*";$name;"*)
> >  				# then there is no local change to integrate
> > -				update_module=3D ;;
> > +				if test -n "$branch"; then
> > +					update_module=3D"!git reset --hard -q"
>=20
> Does that not put the user in danger of loosing changes?

No, because this is only happens for just-cloned modules.  The user
hasn't had time to make local changes yet.

> If submodule.<name>.branch is configured:
>=20
> 	git submodule update
>=20
> will checkout the configured branch instead of the sha1?

The use case described by Francesco, a submodule maintainer Alice sets
up the submodule, which downstream developer Bob want to checkout to a
branch.  I think that matching the exact commit specified by Alice in
Bob's checkout is important, even if the upstream developer Charlie
has advanced the referenced branch in the meantime.  Shifting the
referenced submodule commit should be an explicit decision made by
Alice, not a clone-time accident for Bob.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyJEHAAoJEKKfehoaNkbtxUUP/1GM1X6CCKvtsckq+1LHfqdh
x+ecPTawbUc4wF8vGxKG6GYsYxjy0VrFfZq+FiCoxV5CHTZHi+c/SReqwspbav9g
0S6hVqm9TZYpr46Z6WKHI17+ofyjOiCqUajCRyLzledSJpWQFLwqsy7xQdDkuBQc
Yc8a9PZXXDUl2rtYHvgEJqnEStayhXBWe/tqe/x2W2jKZGjZ+6mcCDFYnuTSPjhK
hv/D9IdxgP8LeAqC10hdYdC1GYtKBv/LEbibM9QpT6QTpM/bD6QSSB5rbJZ6KBRr
syv9YL1gI6D9F47hDWXqh+eecuuYxku72DuW+GudYtuv8Wcc4xyA/xyBDlRW93aq
vvojeTqWtbW83MnDXTKStbS8V5vRKDfqLooQMZgJvcy3nGcJaDPNqRHxrq2pftya
UnOmjawnZoeHC2MOYMZ8IEthaZflel2V0rwpPlp4KI5cK2gjFnazUopF01CB7lCg
oOvW8jNz/P5lHuENsMSc1rNZ8zSH9isCGApCCqkVwvm1QOSPnR9JK99PX1wwQjFU
hL9Dru9K2LCs3BL/hoEvUCav3MtFneDraKf32E1m2Fl11b9s/XOXBBcojehrgbs5
MFFQ++n3NedJGVL5Qzo1sznjlAFGyRDVoMMVmlIoHxo3c4OBozbtJBC4VL2pxnEm
CuN8L4eg0eZ80ESYivS1
=KYhA
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
