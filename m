From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Re: Pull is Evil
Date: Thu, 1 May 2014 23:45:22 +0000
Message-ID: <20140501234522.GD75770@vauxhall.crustytoothpaste.net>
References: <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
 <20140501175623.GY6227@odin.tremily.us>
 <53628CB1.8010302@xiplink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 01:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0fT-00058r-76
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaEAXp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:45:27 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47456 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353AbaEAXp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2014 19:45:27 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b5e1:3ff0:63e4:293d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 50E3C28087;
	Thu,  1 May 2014 23:45:26 +0000 (UTC)
Mail-Followup-To: Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <53628CB1.8010302@xiplink.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247897>


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 02:04:33PM -0400, Marc Branchaud wrote:
> On 14-05-01 01:56 PM, W. Trevor King wrote:
> > On Thu, May 01, 2014 at 11:20:44AM -0400, Marc Branchaud wrote:
> >> On 14-05-01 05:46 AM, brian m. carlson wrote:
> >>>   git checkout maintenance-branch
> >>>   # Update our maintenance branch to the latest from the main repo.
> >>>   git pull --ff-only
> >>>   git pull --no-ff developer-remote topic-branch
> >>>   git push main-repo HEAD
> >>
> >> =E2=80=A6
> >> What's more, it seems to me that the only real advantage "git pull" pr=
ovides
> >> here is a less typing compared to the non-pull equivalent:
> >>
> >>   git fetch main-repo
> >>   git checkout main-repo/maintenance-branch
> >>   git fetch developer-remote
> >>   git merge --no-ff developer-remote/topic-branch
> >>   git push main-repo HEAD
> >=20
> > You're missing Brian's fast-forward merge here.  It should be:
> >=20
> >   git checkout maintenance-branch
> >   git fetch main-repo
> >   git merge --ff-only main-repo/maintenance-branch
> >   git fetch developer-remote
> >   =E2=80=A6
>=20
> I think you're mistaken -- I checked out "main-repo/maintenance-branch"
> directly, so there's no need to fast-forward a local branch.

I actually need my local copy to be up-to-date.  Part of my workflow,
which I omitted for the sake of brevity, is running scripts that rely on
my local branch's name, format, and contents.

My use case is that I'm one of several code reviewers, and I update my
branch, merge in another developer's changes, review them, and then push
them if they're good.  I need to pull from the main repo immediately
before merging, to minimize the chances that someone else will have
pushed before me, which would result in me having to redo the merge
(because the push has to be fast-forward).

I just used this to illustrate the fact that there isn't actually one
completely correct case with pull.  I have aliases for pull (and merge)
--ff-only and --no-ff, and I never actually use plain git pull unless I
really don't care whether or not it's a fast-forward.  So I'm okay with
the status quo because I have distinct choices for merge, no merge, and
don't care.  I don't really have a strong opinion, though, as long as
those three options remain.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTYtySAAoJEL9TXYEfUvaLmZcQALh1vCkN6WjS63p835ie8rPR
J5zecErKVNZanXb+hsLFoX9wvq4SsbILLwAy8mouE9ff/iPZl9eXZEYfGmKTm2N4
K7GQsB4PEGzu2VBeNCUzrbqcYtJNu0zusoHXufZmVsmkf3+KGU7UHl6Anep4V8ru
VaGLMDhtzvckr2A6FX61HcoS54rS3i+fCITE+kEoPuDdIiWISCrEuIgZGcqQ7d0y
iAIAsrP5eP2lFqaJG15Fvk5hEt+6ikShOLTCRrXQbNM5HK+Y6uCMnPtGPZRm4S45
zG65aWahttdKlz7hMPlKNNMUhoCRczc2sk4twT3+T5qo0fqCuOETPdd4LvWYADsX
PX0v+UfSrzuEiB0iA3QaLbJsZaLpfEqHNo2MZVFIHm6nRn0bte4mJeLprXl7fyof
zN0Uo7LchKYRKFkBLlo2V+8cgOkZe+gXKesfyhlq0qjXcrJiy4492VpcJxADcO9J
HbPTPk3Qag03Cpp+lxXFU7C/Wjq+Bhw/hd8Jl9ZC+0RvThr4iX0K5FIXWdY0l153
hQbV4zZPe3ribzeNfYKefeqFPtcn5FlfWaOOgu59Xgy9zsLkpsQJ/6W553FUQz91
6azYApBLJbUztc6TBtDjbNxeqag6dr/G6aFOn2nwkWCEZKlwzFkNCmMGIw12UtYe
raAjjFxmIAB88+uZ36qv
=NxLU
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
