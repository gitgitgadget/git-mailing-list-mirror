From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 3/6] submodule: Explicit local branch creation in
 module_clone
Date: Thu, 16 Jan 2014 13:12:34 -0800
Message-ID: <20140116211234.GZ2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <96f9749de94f7e89f4d113f8cde69f2a960bcb88.1389837412.git.wking@tremily.us>
 <xmqqiotjzp8v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DVXvgjZtTc9TWCEb"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 22:12:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3uFB-0006yn-G7
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbaAPVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 16:12:38 -0500
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:56491
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaAPVMh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 16:12:37 -0500
Received: from omta07.westchester.pa.mail.comcast.net ([76.96.62.59])
	by qmta03.westchester.pa.mail.comcast.net with comcast
	id EhwF1n0061GhbT853lCcT6; Thu, 16 Jan 2014 21:12:36 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta07.westchester.pa.mail.comcast.net with comcast
	id ElCa1n00n152l3L3TlCbjm; Thu, 16 Jan 2014 21:12:36 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 6DBA6EFF330; Thu, 16 Jan 2014 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389906754; bh=b1xG9ESnQSHFPLsyXoPZ+X9ge2jg65zWdK6kBtfTdYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=py8num7Y9vX0AmN5md2m70TKI4psyzVoJXrptx7oqH7j6NKLo4xGkYfJ++CWBcYMc
	 BLfH+LUHKZxqYrBqWvzi9Fc72Z6bvNGr7of7GSxMUW1u5qYFmf+j1WNdfKdscthPh0
	 /dCgeKBYkpVRwLbyCfHtMhLZ1pVq4rdkYqDdaFpo=
Content-Disposition: inline
In-Reply-To: <xmqqiotjzp8v.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389906756;
	bh=El11oYEAuq+pC8hvgDxV54WG5t6n5FLApMzopF3901I=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=rqt1BvIdk4cvvvQqe5JeUT3Y7zPm7uwpUW8jfmM6sGI4dLTQLyXh1wFYegngTj9ZM
	 mdx2rfrlgKOOpbPlEN9yqndkaJ/wxGJkMYV+OB5CRgxzuW7aiFwE8oJpW1uU3Fmznl
	 Fd3KyCSfmOE411Vi/GH/91Ao1+RVcH/rpa1ZLf+pHTFHmmINrK0SYKTiTJqlPc82i+
	 anNwW3qAFSBcXknK5CL8K7opa5O/Sij45Go9ch0WdHkPFjJgeDjLd3K46x6y7Y3Kv9
	 q0bxrXEay3QqTdNT3bHw+CXiV+EKnBupp3a8MHNG8OE6RHwEANBTUma3Ypays2V8PS
	 cBFJfDD0flBzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240534>


--DVXvgjZtTc9TWCEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 11:43:44AM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
>=20
> > @@ -817,11 +831,15 @@ cmd_update()
> > =20
> >  		displaypath=3D$(relative_path "$prefix$sm_path")
> > =20
> > -		if test "$update_module" =3D "none"
> > -		then
> > +		case "$update_module" in
> > +		none)
> >  			echo "Skipping submodule '$displaypath'"
> >  			continue
> > -		fi
> > +			;;
> > +		checkout)
> > +			local_branch=3D""
> > +			;;
> > +		esac
>=20
> I wonder if there is a way to avoid detaching (and you may need to
> update the coddpath that resets the submodule to the commit
> specified by the superproject tree) when it is safe to do so.
>
> =E2=80=A6
>=20
> Perhaps that kind of "'git submodule update' is parallel to 'git
> pull' in the project without submodules" is better done with other
> update modes like --rebase or --merge.  If so, how should we explain
> what 'submodule update --checkout' is to the end users?  Is it
> supposed to be like "git fetch && git checkout origin/master"?

It sounds like you're looking for:

  submodule.<name>.update =3D !git merge --ff-only

That's fine for folks who want that sort of advancement, but I think
there will also be blind updaters who just want the gitlinked commit,
and don't care if that blows away local work, because they never work
locally in the submodule.  They'll still prefer the current
checkout-mode with it's clobbering.

I think the best way to explain this to users is to have 'git
checkout' (with an optional '--recurse-submdules' trial period)
checkout the gitlinked commit automatically.  Then there is never
local submodule work that is not committed or stashed in the
superproject (or stashed on some out-of-the-way branch in the
submodule).  Currently we have:

  1. Checkout a superproject branch and currently gitlinked submodule.
  2. Do local work on the submodule.
  3. Alter the superproject and its gitlinks.
  4. 'git submodule update' to integrate your work from 2 with the
     changes from 3 and checkout the appropriate submodule commit.

I think it would make more sense to:

  1. Checkout a superproject branch and currently gitlinked submodule.
  2. Do local work on the submodule.
  3. Commit your new gitlink to the superproject (or stash it, or put
     it on a temporary submodule branch and reset the submodule HEAD
     to the old value).
  4. Alter the superproject and its gitlinks, using the existing logic
     to integrate conflicts.  Automatically checkout the appropriate
     submodule commit (as the appropriate submodule branch).

That shifts =E2=80=9Cdealing with local submodule changes=E2=80=9D from an
integration-time issue (I just called submodule update, what changes
are local?) to a pre-checkout-time issue (I've got a dirty submodule
(it's HEAD is not the gitlinked commit, all of these changes are
local).  I think that's a lot easier to wrap your head around.

This series is a stop-gap to avoid detached HEADs after cloning,
non-checkout updates, while we hash out the real solution ;).

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--DVXvgjZtTc9TWCEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2Es9AAoJEKKfehoaNkbtg9sP/jGGo9NohY0h6J58D+g8Gty5
9jZwnxMdDgcmo31KqweIacbVOE5LlN33PMMc6TEYl8Vjkb1zcKSOKbo3oIHl+gs9
+KzJd9EgbGqiyV9eKLMiZXxLjT2Gd4qGZ35qZw3FcmDLPJXmz0cUmPw6SBkBN33y
DOfgTTgHKbevikljJ8h7fizGFPY4gtml5SbWEQTHz9elO1kh9MyBZzMmb2DQe2Wg
qi+Cyoo+VszA9iOz1Dr74guSE9XVHBoETuotmSY7yG4w+QuHZAooK86JHriE/w9r
wzExhkd7doCiBD2rOyuyscOFWq6geG7bMcvjuAZ9ym2kbfCIO1fvRywPGU2/31A1
MmPxNuVWTifs0XxuGbHKMOtG93RCFqr6Mfl/VE6GhUfPcz95rPeUSUHiN0/LQAbt
0+zfJ5SOsZvZoUlDYYE2Pw39iup2t7yUPfA1X0MakXcjR28t6ezAG1tisgxy7m87
JX7DlfOHr3uPrcGv4lEBvae4U1Nzw5GSugGqPoATfU6vXGQXo6a2y0/Hp1ANtf8c
qLXO8AmU6tHgxhVJwQ+1Xdafmp3R8o6RM/REDrcoN6UWAkNVUiyq3DaPifJ8wQMR
FaB5anE0mz2vUtOoLabXwlozQkgJn4v+ZxLICjlHdeaqKQaQe0+JYvHy6anAJ21o
Fbh/HpQMRLqw2ib1+jjq
=/8KU
-----END PGP SIGNATURE-----

--DVXvgjZtTc9TWCEb--
