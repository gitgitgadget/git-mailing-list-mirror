From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes
 in detail
Date: Thu, 16 Jan 2014 12:55:21 -0800
Message-ID: <20140116205521.GY2647@odin.tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
 <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
 <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y48FV0AvvvAm5Iyr"
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 21:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3tyL-0004u5-QC
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 21:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbaAPUz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 15:55:26 -0500
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:41225
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750750AbaAPUzY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 15:55:24 -0500
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id EhnC1n00427AodY5FkvP9c; Thu, 16 Jan 2014 20:55:23 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id EkvN1n00J152l3L3fkvNgN; Thu, 16 Jan 2014 20:55:23 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id A6CD9EFF2A8; Thu, 16 Jan 2014 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389905721; bh=Lmq41R7yF+zid4LCLiWNx8D3bYHMs1mmnbP1d7vyzQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GQrDauBnfnS2VD2bJjl9txX12JcsHyxGm/90tLlN9DIPrncMCp5CLC2xRacfcRpY5
	 4CeZUVUIIBJvqwf4KEIwuAT32psYBIE8L0JzUKePwYNeOZFQNA6fa3723H9bxVJ8ZD
	 +0008fQpbLrAuRdltpvqHJJH98AQ+RCZ2bRvnJ9g=
Content-Disposition: inline
In-Reply-To: <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.22 (2013-10-16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389905723;
	bh=7UIvHlacwI0N+3zWXmKqp6JMW9WLRWQpti9O1VLmVZE=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=Hz2xYeRTlIiue7mPcbTPm+202jDSdKdf1VEinfCrHStDH1zvmC/L1pHgS2Jjj543j
	 Qvs/K5n8dBb7Mz1ygxJNh+bpPLICSpYEr1dW0Q77n7VZklwhEwrIIX5U/0aa4Iwsb4
	 pGZancb3ltselzaqSwH7hGZ57jc3AZh9zlicWUw31qOmUS6HRWP71blfnnDV43je7+
	 uN2srLidi2tybSBluj2DSTg/HWrw/JEc2KZlddfGt5oe7qyClcSKkw49icT8sOvWBu
	 QMZjOcyLnWuu4/7Uf1/x2hHNDHBVAkaXNtEtLi5H85k5nv1AOxVK4PCQMUM1Qq+OpF
	 EnGm5BkG7o6iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240531>


--Y48FV0AvvvAm5Iyr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2014 at 12:21:04PM -0800, Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:
> > @@ -155,13 +155,31 @@ it contains local modifications.
> > =20
> >  update::
> >  	Update the registered submodules, i.e. clone missing submodules and
> > -	checkout the commit specified in the index of the containing reposito=
ry.
> > -	This will make the submodules HEAD be detached unless `--rebase` or
> > -	`--merge` is specified or the key `submodule.$name.update` is set to
> > -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> > -	`--checkout`. Setting the key `submodule.$name.update` to `!command`
> > -	will cause `command` to be run. `command` can be any arbitrary shell
> > -	command that takes a single argument, namely the sha1 to update to.
> > +	checkout the commit specified in the index of the containing
> > +	repository.  The update mode defaults to 'checkout', but be
> > +	configured with the 'submodule.<name>.update' setting or the
> > +	'--rebase', '--merge', or 'checkout' options.
>=20
> Not '--checkout'?

Oops, will fix in v5.

> > ++
> > +For updates that clone missing submodules, checkout-mode updates will
> > +create submodules with detached HEADs; all other modes will create
> > +submodules with a local branch named after 'submodule.<path>.branch'.
> > ++
> > +For updates that do not clone missing submodules, the submodule's HEAD
>=20
> That is, updates that update submodules that are already checked out?

It's submodules for which $sm_path/.git does not exist.

> > +is only touched when the remote reference does not match the
> > +submodule's HEAD (for none-mode updates, the submodule is never
> > +touched).  The remote reference is usually the gitlinked commit from
> > +the superproject's tree, but with '--remote' it is the upstream
> > +subproject's 'submodule.<name>.branch'.  This remote reference is
> > +integrated with the submodule's HEAD using the specified update mode.
>=20
> I think copying some motivation from the log message of 06b1abb5
> (submodule update: add --remote for submodule's upstream changes,
> 2012-12-19) would help the readers here.

I think a brief reference to --remote is best here, mentioning that it
has something to do with the upstream subproject.  More detail on when
you should use --remote should probably go under the docs for --remote
;).

> A na=C3=AFve expectation from a casual reader of the above would be "The
> superproject's tree ought to point at the same commit as the tip of
> the branch used in the submodule (modulo mirroring delays and
> somesuch),

What is the branch used in the submodule?  The remote subproject's
current submodule.<name>.branch?  The local submodule's
submodule.<name>.branch (or localBranch) branch?  The submodule's
current HEAD?

> if the repository of the superproject and submodules are maintained
> properly", which would lead to "when would any sane person need to
> use --remote in the first place???".

--remote is not for sane people (who will probably be pulling from
withing the submodule itself).  --remote is for folks who track too
many submodules to care about them as individuals, who just want to
blindly update to whatever the upstream subproject maintainer has in
submodule.<name>.branch.  For example, if you are a distribution with
a hundred submodules tracking all the projects you package, and want
to bump them all to a their current trunk tip in one fell swoop.

> If I am reading 06b1abb5 correctly, the primary motivation behind
> "--remote" seems to be that it is exactly to help the person who
> wants to update superproject to satisify the "... are maintained
> properly" part by fetching the latest in each of the submodules in
> his superproject in preparation to 'git add .' them.  I still do not
> think "--remote" was a better way than the "foreach", but that is a
> separate topic.

I agree now ;), the problems with:

  $ git submodule foreach 'git pull'

are:

1. You may not be on the =E2=80=9Cright=E2=80=9D local branch to begin with=
, and
2. You may not have out-of-tree submodule configs setting up the
   =E2=80=9Cright=E2=80=9D upstream for that branch.

06b1abb did not address the former, and added a new .gitmodules-level
submodule.<name>.branch to help with the latter.  I now think all of
this would be easier if we had automatic submodule local-branch
checkouts (fixing problem 1) and synchronized out-of-tree submodule
configs (fixing problem 2).  Fixing problem 1 is all you need if you
aren't interested in sharing your out-of-tree configs.

I think 06b1abb was inspired by =E2=80=9Cwe already have a way to integrate
changes in the gitlinked commit, we should reuse those to integrate
other changes=E2=80=9D.  In hindsight, changes in the gitlinked commit are
really a checkout-time issue, while changes in other places (like the
remote subproject) are pull-time issues.  Mixing them together was
more confusing than it was worth.

Cheers,
Trevor

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--Y48FV0AvvvAm5Iyr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2Ec2AAoJEKKfehoaNkbtk2YQAJ+fj731hlZ2V6nJ9SfuZcfd
rBrkEcaoZTczFmJtejpCYigSfc5NgJ8/4alLT4szGJr0ukSHBV3nfBf3Os6FS9MR
H2ycygz41IxC/V38xcDeHNJw7FU4ax+cQi9s/9DGwBo6VxNFbwWIKXuXTETeQxet
6FVmg/5A+nTEEDe4YNocOls5NuA8ZXO9GiBhNW3rq1ysFcpyQ4ccFAlKkodqBJaJ
fVRkKNJ0WJ4wXdvq/wvYEJnpnicpefshRE7yYbp7A1HFByycmEA8UeSezSmyVtIp
MNMNSS0gCUvnOEzJbD6vqaEZvaVWVRSTig5V37gHiZN5J84RoX7UBO4mb9V1gb8c
HRzfxPhcsoqpoFwh8FvXvLUYDOmvg/YwZ1hBLFANowtBEWLR1hCE7btHYG0Elpi9
L1BkZRiqWrENhbqerJ0Kygs577tYHKYbIiBa5AywbxMt2vW7HUwGGWgo950gzLAq
ft2C1aPnTvlQ2jBJoeW+WUFZa57fNJQSDhMKKffpSoPThT/hXtC3wtQmhkX0h1u+
Pf3dryMJpPSyrsKyuYE3AOt2Gra7cw8OdNHATUixzd4eGrwM8v5zrbHFj+S7Ys7Q
PgiwUE1Zct+ZkrtJ60fFaGd0ksWD0Xh+HZl3ipKMtMEDB9af5X7TXQAbETAp2OuW
3G3D5ZjuGsx0sx3yT4/L
=SZve
-----END PGP SIGNATURE-----

--Y48FV0AvvvAm5Iyr--
