From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 3/6] submodule: Explicit local branch creation in
 module_clone
Date: Thu, 16 Jan 2014 11:29:58 -0800
Message-ID: <20140116192958.GU2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
 <xmqqr487zqfr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xPLL5cPndR2UZ7Mw"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 20:30:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3sdj-0004L4-4I
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 20:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbaAPTaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 14:30:03 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:56434
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750946AbaAPTaB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 14:30:01 -0500
Received: from omta12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id EheB1n0010xGWP857jW04R; Thu, 16 Jan 2014 19:30:00 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta12.westchester.pa.mail.comcast.net with comcast
	id EjVy1n00z152l3L3YjVzoZ; Thu, 16 Jan 2014 19:30:00 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 71C7FEFF098; Thu, 16 Jan 2014 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389900598; bh=ROQCA4UlJ7DML6pn9qkJ6moD4AZPYgxLxLzZ4OEc7Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DGCNC4Mf6rtV83pMtzKWBsBBL0VrSbMQjbadalC0cKctXGKqqEokFIyZ5pd5UFirn
	 enCm9Bgmq1G3LudPxJ+NdYgIH8Y+UGnJ6XxfSl9y90imIyJmrr8Bc815uKgtewYZKE
	 LiaKYGb+jWvkCXCR+JlsZnc89rafVXEG2fK0K4uM=
Content-Disposition: inline
In-Reply-To: <xmqqr487zqfr.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389900600;
	bh=tLWni16JhvRP7eIj5lsl0TudsPPMiuYLaRh+UN6yeuU=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=jdp7NPJrvNAB0X17MaM6GcOmuX7rzHRum1tZRWTK+73K1dW9yMcLK8xpq47kKT2HJ
	 H7NLEHMSNpDkKJGA3HmlSyriReAdKmotbM27+qMK57l8NyHuidCEkLJEz46hq+AhDc
	 ba9NmginFIhzcTMsr5AWJ/pMSpNJC7HgZ9PNzSoxbgB0zKzwnOPTQWa1PURC+B8HlA
	 Gyn2agBToY6EUBrWSzI/CLI5ub6QmbfZ8iPXibZrsFF7tIsUuPp+TXTG1956+znWvU
	 Q9rvLXgtzkhlBSv1ZIrMikqVbI4GzdULO0DJabyo1ZitgIakmDG/oruD3q6l5Vw0HT
	 r847E5LMDAGIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240524>


--xPLL5cPndR2UZ7Mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 11:18:00AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > @@ -312,7 +317,16 @@ module_clone()
> >  	echo "gitdir: $rel/$a" >"$sm_path/.git"
> > =20
> >  	rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
> > -	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config c=
ore.worktree "$rel/$b")
> > +	(
> > +		clear_local_git_env
> > +		cd "$sm_path" &&
> > +		GIT_WORK_TREE=3D. git config core.worktree "$rel/$b" &&
> > +		# ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
>=20
> Interesting...

That's copied out of the old cmd_add code ;).  I don't have ash
intalled to actually confirm the comment.

> > +		case "$local_branch" in
> > +		'') git checkout -f -q ${start_point:+"$start_point"} ;;
> > +		?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_poi=
nt"} ;;
> > +		esac
>=20
> I am wondering if it makes more sense if you did this instead:
>=20
> 	git checkout -f -q ${start_point:+"$start_point"} &&
> 	if test -n "$local_branch"
>         then
>         	git checkout -B "$local_branch" HEAD
> 	fi
>=20
> The optional "re-attaching to the local_branch" done with the second
> "checkout" would be a non-destructive no-op to the working tree and
> to the index, but it does distinguish between creating the branch
> anew and resetting the existing branch in its output (note that
> there is no "-q" to squelch it).  By doing it this way, when we
> later teach "git branch -f" and "git checkout -B" to report more
> about what commits have been lost by such a resetting, you will get
> the safety for free if you made the switching with "-B" run without
> "-q" here.

This is immediately post-non-checkout-clone.  There are no local
branches to clobber yet.

> > @@ -475,16 +489,14 @@ Use -f if you really want to add it." >&2
> >  				echo "$(eval_gettext "Reactivating local git directory for submodu=
le '\$sm_name'.")"
> >  			fi
> >  		fi
> > -		module_clone "$sm_path" "$sm_name" "$realrepo" "$reference" "$depth"=
 || exit
> > -		(
> > -			clear_local_git_env
> > -			cd "$sm_path" &&
> > -			# ash fails to wordsplit ${branch:+-b "$branch"...}
> > -			case "$branch" in
> > -			'') git checkout -f -q ;;
> > -			?*) git checkout -f -q -B "$branch" "origin/$branch" ;;
> > -			esac
> > -		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
> > +		if test -n "$branch"
> > +		then
> > +			start_point=3D"origin/$branch"
> > +			local_branch=3D"$branch"
> > +		else
> > +			start_point=3D""
> > +		fi
>=20
> I'd feel safer if the "else" clause explicitly cleared $local_branch
> by assigning an empty string to it; it would make it a lot clearer
> that "when $branch is an empty string here, we do not want to
> trigger the new codepath to run checkout with "-B $local_branch" in
> module_clone" is what you mean.

Ok.  Will add in v5.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--xPLL5cPndR2UZ7Mw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2DM1AAoJEKKfehoaNkbtht4QAIruwwyVNJoNDw9KpstruLpp
i6J/Z3vRSVdHDM96lhYCmLDZxRw6u2l+JJ1BDwLwZ5kRZT5iXtXFbR/nW5bonzZZ
+9GOeEPBLguMntQ8tG+xHZmkiBkJjrc2GHpaWeDVmmtXDvJvc5pGvUN+CzJDZ54P
vP9+8Nch8G13Dt+ivau7c3P0f7PF+6ycjYJTUaG9mkkm1hpXKqf1+GPs8f7YUcCx
whr7iY6faho66ymTFraAsnOj4SAsX0HfaAVFcWvXQSYmJIZxmnAxDJU/FardDORG
dnVudO0+adhVqShxF13fBfQOh0EGZrYQhDsnjWkWnwqeRLDj42wMrH20yhty9Gjg
SBBUtQpoqrIjkwrYtpZ7imD48z08nMKUNkBvARRVH6PKxPVgezTPbnHc+71LmsLv
rSeTdtZor7LfON9yN7/AnkHC0m0cuPxSXwNhNRHR3vnFD+bBmRCfNqbapfMGqCOK
BX/+0tEOk8cbmZDeq+oI1RYymlYa4XB/ErqWeZYaW1Jz5aLnTbpzGAHy2887Eyr6
RSijSf7/4V82tKb8Feb/dn7ms8Ps6sf496X6pQHnu45+cwMvu0HWEeXUPdbfhrCo
rzzt0Lc+mZEsjdV/0VgXXBiD4eZBSuZe+OArY1EGfxhOcKr+5035VXQbvKn5afjS
GuScR6t2N87BU/bTjkja
=8g5W
-----END PGP SIGNATURE-----

--xPLL5cPndR2UZ7Mw--
